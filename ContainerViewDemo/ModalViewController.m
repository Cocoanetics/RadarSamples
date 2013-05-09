//
//  ModalViewController.m
//  containerviewdemo
//
//  Created by Oliver Drobnik on 17.06.12.
//  Copyright (c) 2012 Oliver Drobnik. All rights reserved.
//

#import "ModalViewController.h"

@interface ModalViewController ()

@end

@implementation ModalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		 self.wantsFullScreenLayout = YES;
    }
    return self;
}

- (void)viewDidLoad
{
	// we want full screen layout to be visible, so let's add a view to show where this is
	self.view.backgroundColor = [UIColor blueColor];
	
	UIButton *statusBarToggle = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[statusBarToggle setTitle:@"Toggle Status Bar" forState:UIControlStateNormal];
	
	statusBarToggle.bounds = CGRectMake(0,0,150,50);
	statusBarToggle.center = CGPointMake(self.view.bounds.size.width/2.0, self.view.bounds.size.height/2.0);
	[statusBarToggle addTarget:self action:@selector(toggleStatusBar:) forControlEvents:UIControlEventTouchUpInside];
	
	[self.view addSubview:statusBarToggle];
	
	
	UIButton *modalButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[modalButton setTitle:@"Dismiss This" forState:UIControlStateNormal];
	
	modalButton.bounds = CGRectMake(0,0,150,50);
	modalButton.center = CGPointMake(self.view.bounds.size.width/2.0, self.view.bounds.size.height/2.0+100);
	[modalButton addTarget:self action:@selector(dismissThis:) forControlEvents:UIControlEventTouchUpInside];
	
	[self.view addSubview:modalButton];
	

	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 130)];
	label.text = @"This text should be riding below the status bar and if the bar is hidden the blue background of this VC's view should show.";
	label.backgroundColor = [UIColor grayColor];
	label.textAlignment = NSTextAlignmentCenter;
	label.numberOfLines = 0;
	[self.view addSubview:label];
	
	UILabel *wantsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-50, self.view.bounds.size.width, 30)];
	wantsLabel.text = @"wantsFullScreenLayout == YES";
	wantsLabel.textAlignment = NSTextAlignmentCenter;
	wantsLabel.backgroundColor = [UIColor greenColor];
	wantsLabel.numberOfLines = 0;
	[self.view addSubview:wantsLabel];
	
    [super viewDidLoad];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark Actions

- (void)toggleStatusBar:(id)sender
{
	BOOL statusBarHidden = [[UIApplication sharedApplication] isStatusBarHidden];
	
	[[UIApplication sharedApplication] setStatusBarHidden:!statusBarHidden withAnimation:UIStatusBarAnimationFade];
}

- (void)dismissThis:(id)sender
{
	if (self.dismissingBlock)
	{
		self.dismissingBlock();
	}
}


@end
