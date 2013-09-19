//
//  DTCodeScannerViewController.m
//  TagScan
//
//  Created by Oliver Drobnik on 7/12/13.
//  Copyright (c) 2013 Oliver Drobnik. All rights reserved.
//

#import "DTCodeScannerViewController.h"
#import "DTCodeScannerView.h"

#import <AVFoundation/AVFoundation.h>

@interface DTCodeScannerViewController () <AVCaptureMetadataOutputObjectsDelegate>

@end

@implementation DTCodeScannerViewController
{
	AVCaptureDevice *_camera;
	AVCaptureSession *_captureSession;
	AVCaptureDeviceInput *_videoInput;
	AVCaptureMetadataOutput *_metaDataOutput;
	
	AVCaptureVideoPreviewLayer *_videoPreviewLayer;
	
	DTCodeScannerView *_scanOverlayView;
	
	UIButton *_focusButton;
	UIButton *_exposureButton;
	UIButton *_whiteBalanceButton;
	
	// captured codes
	
	NSMutableSet *_visibleCodes;
}


- (void)dealloc
{
	[_camera removeObserver:self forKeyPath:@"adjustingFocus"];
	[_camera removeObserver:self forKeyPath:@"adjustingExposure"];
	[_camera removeObserver:self forKeyPath:@"adjustingWhiteBalance"];
}

- (void)loadView
{
	CGRect frame = [UIScreen mainScreen].applicationFrame;
	
	UIView *view = [[UIView alloc] initWithFrame:frame];
	view.autoresizesSubviews = YES;
	view.backgroundColor = [UIColor blackColor];
	
	_scanOverlayView = [[DTCodeScannerView alloc] initWithFrame:view.bounds];
	_scanOverlayView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	[view addSubview:_scanOverlayView];
	
	_focusButton = [UIButton buttonWithType:UIButtonTypeSystem];
	[_focusButton setTitle:@"FOC" forState:UIControlStateNormal];
	_focusButton.frame = CGRectMake(20, 10, 40, 20);
	[view addSubview:_focusButton];

	_exposureButton = [UIButton buttonWithType:UIButtonTypeSystem];
	[_exposureButton setTitle:@"EXP" forState:UIControlStateNormal];
	_exposureButton.frame = CGRectMake(120, 10, 40, 20);
	[view addSubview:_exposureButton];

	_whiteBalanceButton = [UIButton buttonWithType:UIButtonTypeSystem];
	[_whiteBalanceButton setTitle:@"WHT" forState:UIControlStateNormal];
	_whiteBalanceButton.frame = CGRectMake(220, 10, 40, 20);
	[view addSubview:_whiteBalanceButton];
	
	self.view = view;
}


- (void)viewDidLoad
{
	[super viewDidLoad];
	
	_visibleCodes = [NSMutableSet set];
	
	// get the camera
	_camera = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
	
	NSError *error;
	if ([_camera lockForConfiguration:&error])
	{
		// Autofocus: Continuous
		if ([_camera isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus])
		{
			[_camera setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
		}

		// Autofocus: Restricted to Near
		if ([_camera isAutoFocusRangeRestrictionSupported])
		{
			_camera.autoFocusRangeRestriction = AVCaptureAutoFocusRangeRestrictionNear;
		}
		
		// Exposure: Continuous
		if ([_camera isExposureModeSupported:AVCaptureExposureModeContinuousAutoExposure])
		{
			_camera.exposureMode = AVCaptureExposureModeContinuousAutoExposure;
		}
		
		// White Balance: Continuous
		if ([_camera isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance])
		{
			_camera.whiteBalanceMode = AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance;
		}

		[_camera unlockForConfiguration];
	}
	else
	{
		NSLog(@"Cannot lock cam device, %@", [error localizedDescription]);
	}
	
	// observe indicators
	[_camera addObserver:self forKeyPath:@"adjustingFocus" options:NSKeyValueObservingOptionNew context:NULL];
	[_camera addObserver:self forKeyPath:@"adjustingExposure" options:NSKeyValueObservingOptionNew context:NULL];
	[_camera addObserver:self forKeyPath:@"adjustingWhiteBalance" options:NSKeyValueObservingOptionNew context:NULL];

	// connect camera to input
	_videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:_camera error:&error];
	
	// Create session (use default AVCaptureSessionPresetHigh)
	_captureSession = [[AVCaptureSession alloc] init];
	
	//_captureSession.sessionPreset = AVCaptureSessionPreset640x480;
	if ([_captureSession canAddInput:_videoInput])
	{
		[_captureSession addInput:_videoInput];
	}
	
	// create a preview layer
	_videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
	_videoPreviewLayer.frame = self.view.bounds;
	
	// fill the entire screen, without this we get empty areas at the long sides
	[_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
	
	if ([[_videoPreviewLayer connection] isVideoOrientationSupported])
	{
		[[_videoPreviewLayer connection] setVideoOrientation:AVCaptureVideoOrientationPortrait];
	}
	
	CALayer *viewLayer = self.view.layer;
//	[viewLayer setMasksToBounds:YES];
	[viewLayer insertSublayer:_videoPreviewLayer atIndex:0];
	
	_metaDataOutput = [[AVCaptureMetadataOutput alloc] init];
	
	if ([_captureSession canAddOutput:_metaDataOutput])
	{
		[_captureSession addOutput:_metaDataOutput];
	}
	
	dispatch_queue_t metadataQueue = dispatch_queue_create("com.cocoanetics.metadata", NULL);
	[_metaDataOutput setMetadataObjectsDelegate:self queue:metadataQueue];
	
	_metaDataOutput.metadataObjectTypes = @[ AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeUPCECode ];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	[_captureSession startRunning];
	
	[[UIApplication sharedApplication] setIdleTimerDisabled:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[_captureSession stopRunning];

	[[UIApplication sharedApplication] setIdleTimerDisabled:NO];
}

- (void)_updateIndicators
{
	UIColor *activeColor = self.view.window.tintColor;
	UIColor *inactiveColor = [UIColor grayColor];
	
	if ([_camera isAdjustingExposure])
	{
		[_exposureButton setTintColor:activeColor];
	}
	else
	{
		[_exposureButton setTintColor:inactiveColor];
	}
	
	if ([_camera isAdjustingFocus])
	{
		[_focusButton setTintColor:activeColor];
	}
	else
	{
		[_focusButton setTintColor:inactiveColor];
	}
	
	if ([_camera isAdjustingWhiteBalance])
	{
		[_whiteBalanceButton setTintColor:activeColor];
	}
	else
	{
		[_whiteBalanceButton setTintColor:inactiveColor];
	}
}


- (void)_updateRectOfInterest:(CGRect)rectOfInterest
{
	_scanOverlayView.scanRegion = rectOfInterest;
	
	// update meta data scan rect
	CGRect metadataRect = [_videoPreviewLayer metadataOutputRectOfInterestForRect:_scanOverlayView.scanRegion];
	_metaDataOutput.rectOfInterest = metadataRect;
	
	// update focus point
	CGPoint scanCenter = CGPointMake(CGRectGetMidX(_scanOverlayView.scanRegion), CGRectGetMidY(_scanOverlayView.scanRegion));
	CGPoint focusPoint = [_videoPreviewLayer captureDevicePointOfInterestForPoint:scanCenter];
	
	// set exposure and focus point
	NSError *error;
	
	if ([_camera lockForConfiguration:&error])
	{
		if ([_camera isFocusPointOfInterestSupported])
		{
			[_camera setFocusPointOfInterest:focusPoint];
		}
		
		if ([_camera isExposurePointOfInterestSupported])
		{
			[_camera setExposurePointOfInterest:focusPoint];
		}
		
		[_camera unlockForConfiguration];
	}
	else
	{
		NSLog(@"Cannot lock cam device, %@", [error localizedDescription]);
	}
}


- (void)viewWillLayoutSubviews
{
	_videoPreviewLayer.frame = self.view.bounds;
	
	[self _updateRectOfInterest:CGRectInset(self.view.bounds, 20, 20)];
}

- (BOOL)shouldAutorotate
{
	return NO;
}

#pragma mark - Notifications

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	[self _updateIndicators];
}

#pragma mark Barcodes

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
	NSMutableArray *reportedCodes = [NSMutableArray array];
	
	for (AVMetadataMachineReadableCodeObject *object in metadataObjects)
	{
		if ([object isKindOfClass:[AVMetadataMachineReadableCodeObject class]])
		{
			NSString *code = [object stringValue];
			
			[reportedCodes addObject:code];
		}
	}
	
	BOOL codeDidAppear = NO;
	
	for (NSString *oneCode in _visibleCodes)
	{
		if (![reportedCodes containsObject:oneCode])
		{
			NSLog(@"code disappeared: %@", oneCode);
			[_visibleCodes removeObject:oneCode];
		}
	}
	
	for (NSString *oneCode in reportedCodes)
	{
		if (![_visibleCodes containsObject:oneCode])
		{
			[_visibleCodes addObject:oneCode];
			NSLog(@"code appeared: %@", oneCode);
			
			if ([_scanDelegate respondsToSelector:@selector(codeScanner:didScanCode:)])
			{
				[_scanDelegate codeScanner:self didScanCode:oneCode];
			}
			
			codeDidAppear = YES;
		}
	}
	
	if (codeDidAppear)
	{
		AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
	}
}

@end
