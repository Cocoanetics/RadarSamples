//
//  PhotoScrollView.m
//  ProductLayer
//
//  Created by Oliver Drobnik on 17.07.14.
//  Copyright (c) 2014 Cocoanetics. All rights reserved.
//

#import "PhotoScrollView.h"

@interface PhotoScrollView () <UIScrollViewDelegate>
@end


@interface PhotoScrollView ()
@end


@implementation PhotoScrollView
{
	UIImageView *_imageView;

	NSInteger _minimumXOffset;
	NSInteger _maximumXOffset;
	
	NSInteger _minimumYOffset;
	NSInteger _maximumYOffset;
   
	UITapGestureRecognizer *_tapGestureRecognizer;
	
	CGSize _lastLayoutSize;
}

- (void)_commonSetup
{
	_imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
	_imageView.contentMode = UIViewContentModeScaleToFill;
	_imageView.userInteractionEnabled = NO;
	[self addSubview:_imageView];
	self.delegate = self;
	self.decelerationRate = UIScrollViewDecelerationRateFast;
	
	// workaround for compositing bug on iPhone 6, to mask white lines
//	_imageView.layer.borderColor = [UIColor blackColor].CGColor;
//	_imageView.layer.borderWidth = 1;
}

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self)
	{
		[self _commonSetup];
	}
	return self;
}

- (void)awakeFromNib
{
	[super awakeFromNib];
	
	[self _commonSetup];
	
	// for sample we set an image
	UIImage *image = [UIImage imageNamed:@"sample.jpg"];
	self.image = image;
}


- (void)layoutSubviews
{
	[super layoutSubviews];
	
	CGSize size = self.frame.size;
	
	if (!_imageView.image || !CGSizeEqualToSize(_lastLayoutSize, size))
	{
		[self _zoomImageToFit];
		[self _centerContentView];
		
		_lastLayoutSize = size;
	}
}

#pragma mark - UIScrollView Delegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
	return _imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
	[self _centerContentView];
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
	[[NSNotificationCenter defaultCenter] postNotificationName:@"PhotoScrollViewWillBeginZooming" object:scrollView];
}


#pragma mark - UITapGestureRecognizer


#pragma mark - Helpers

- (void)_centerContentView
{
	UIView *subView = _imageView;
	
	CGFloat offsetX = MAX((self.bounds.size.width - self.contentSize.width) * 0.5, 0.0);
	CGFloat offsetY = MAX((self.bounds.size.height - self.contentSize.height) * 0.5, 0.0);
	
	subView.center = CGPointMake(self.contentSize.width * 0.5 + offsetX,
										  self.contentSize.height * 0.5 + offsetY);
}

- (void)_zoomAspectFill
{
	UIImage *image = _imageView.image;
	CGFloat zoomForFullHeight = self.bounds.size.height / image.size.height;
	CGFloat zoomForFullWidth = self.bounds.size.width / image.size.width;
	self.zoomScale = MAX(zoomForFullHeight, zoomForFullWidth);
}

- (void)_zoomAspectFit
{
	UIImage *image = _imageView.image;
	CGFloat zoomForFullHeight = self.bounds.size.height / image.size.height;
	CGFloat zoomForFullWidth = self.bounds.size.width / image.size.width;
	self.zoomScale = MIN(zoomForFullHeight, zoomForFullWidth);
}

- (void)_zoomImageToFit
{
	if (!_image)
	{
		return;
	}
	
	// predefined zoom scale values
	self.minimumZoomScale = 1.0;
	self.zoomScale = 1.0;
	self.maximumZoomScale = 1.0;
	
	UIImage *image = _image;
	
	// adjust size for actual pixel size versus display scale
	CGSize imageSize = _image.size;
	imageSize.width *= _image.scale;
	imageSize.height *= _image.scale;
	
	CGFloat scale = [[UIScreen mainScreen] scale];
	
	imageSize.width /= scale;
	imageSize.height /= scale;
	
	_imageView.frame = CGRectMake(0, 0, imageSize.width, imageSize.height);
	_imageView.image = image;
	self.contentSize = _imageView.frame.size;
	
	CGFloat zoomForFullHeight = self.bounds.size.height / imageSize.height;
	CGFloat zoomForFullWidth = self.bounds.size.width / imageSize.width;
	
	
	self.minimumZoomScale = MIN(zoomForFullHeight, zoomForFullWidth);
	
	if (self.minimumZoomScale < 1)
	{
		// for all other large images or images taken from iPhone camera
		self.zoomScale = self.minimumZoomScale;
		self.maximumZoomScale = MAX(2.0, scale) * MAX(zoomForFullHeight, zoomForFullWidth);
	}
	else
	{
		// for images smaller than screen
		if (self.minimumZoomScale > self.maximumZoomScale)
		{
			self.maximumZoomScale = self.minimumZoomScale * 4;
		}
		
		self.zoomScale = self.minimumZoomScale;
	}
}

#pragma mark - Properties

- (void)setImage:(UIImage *)image
{
	if (image)
	{
		_image = image;
		_imageView.image = nil;
		
		[self setNeedsLayout];
	}
	else
	{
		self.zoomScale = 1.0;
		self.maximumZoomScale = 1.0;
		self.minimumZoomScale = 1.0;
		_image = nil;
		_imageView.image = nil;
		self.contentOffset = CGPointZero;
	}
}

@end
