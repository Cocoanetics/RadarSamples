//
//  RootViewController.m
//  containerviewdemo
//
//  Created by Oliver Drobnik on 17.06.12.
//  Copyright (c) 2012 Oliver Drobnik. All rights reserved.
//

#import "RootViewController.h"
#import "ModalViewcontroller.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		 
		 self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
		 
		 UIButton *modalButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		 [modalButton setTitle:@"Deprecated Presenting" forState:UIControlStateNormal];
		 modalButton.bounds = CGRectMake(0,0,250,50);
		 modalButton.center = CGPointMake(self.view.bounds.size.width/2.0, self.view.bounds.size.height/2.0);
		 [modalButton addTarget:self action:@selector(presentModally:) forControlEvents:UIControlEventTouchUpInside];
		 [self.view addSubview:modalButton];

		 UIButton *presentButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		 [presentButton setTitle:@"Custom Animated Presenting" forState:UIControlStateNormal];
		 presentButton.bounds = CGRectMake(0,0,250,50);
		 presentButton.center = CGPointMake(self.view.bounds.size.width/2.0, self.view.bounds.size.height/2.0+100);
		 [presentButton addTarget:self action:@selector(presentCustom:) forControlEvents:UIControlEventTouchUpInside];
		 [self.view addSubview:presentButton];
		 
		 UILabel *wantsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-50, self.view.bounds.size.width, 30)];
		 wantsLabel.text = @"wantsFullScreenLayout == NO";
		 wantsLabel.textAlignment = NSTextAlignmentCenter;
		 wantsLabel.backgroundColor = [UIColor redColor];
		 wantsLabel.numberOfLines = 0;
		 [self.view addSubview:wantsLabel];
    }
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark Custom Presenting

- (void)customizedPresentViewController:(UIViewController *)viewController
{
	// add as child VC
	[self addChildViewController:viewController];
	
	// adjust the frame to go under the status bar
	CGRect newBounds = self.view.bounds;
	newBounds.origin.y = -20;
	newBounds.size.height += 20;
	viewController.view.frame = newBounds;
	
	[self.view addSubview:viewController.view];
	
	// fancy presentation
		viewController.view.transform = CGAffineTransformMakeRotation(M_PI_2);
	viewController.view.alpha = 0;
		
		[UIView animateWithDuration:1 animations:^{
			viewController.view.transform = CGAffineTransformIdentity;
			viewController.view.alpha = 1;
		} completion:^(BOOL finished) {
			[viewController didMoveToParentViewController:self];
		}];
}

- (void)customizedDismissViewController:(UIViewController *)viewController
{
	[viewController willMoveToParentViewController:nil];
	
	
	[UIView animateWithDuration:1 animations:^{
		viewController.view.transform = CGAffineTransformMakeRotation(-M_PI_2);
		viewController.view.alpha = 0;
	} completion:^(BOOL finished) {
		[viewController removeFromParentViewController];
		
		[viewController.view removeFromSuperview];
	}];
}

#pragma mark Actions

- (void)presentModally:(id)sender
{
	// this is the deprecated method of presenting it
	ModalViewController *modalVC = [[ModalViewController alloc] init];
	
	
	__weak RootViewController *weakSelf = self;

	modalVC.dismissingBlock = ^{
		[weakSelf dismissModalViewControllerAnimated:YES];
	};
	
	[self presentModalViewController:modalVC animated:YES];
}

- (void)presentCustom:(id)sender
{
	// this is our custom method of presenting it with special fancy animation
	// Note: self is NOT wantsFullScreenLayout, presented VC does wantsFullScreenLayout
	
	ModalViewController *modalVC = [[ModalViewController alloc] init];
	
	__weak ModalViewController *weakVC = modalVC;
	__weak RootViewController *weakSelf = self;
	
	modalVC.dismissingBlock = ^{
		[weakSelf customizedDismissViewController:weakVC];
	};
	
	[self customizedPresentViewController:modalVC];
}

@end
