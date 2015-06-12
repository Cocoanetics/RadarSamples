//
//  ModalViewController.m
//  TransitionTest
//
//  Created by Oliver Drobnik on 26/01/15.
//  Copyright (c) 2015 Product Layer. All rights reserved.
//

#import "ModalViewController.h"

#import "ModalTransitionManager.h"

@implementation ModalViewController
{
	ModalTransitionManager *_transitionManager;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
	return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden
{
	return NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	// need IVAR because transitioning delegate does not retain
	_transitionManager = [ModalTransitionManager new];
	self.transitioningDelegate = _transitionManager;
}

- (IBAction)close:(id)sender
{
	[self dismissViewControllerAnimated:YES completion:NULL];
}

@end
