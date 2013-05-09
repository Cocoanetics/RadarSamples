//
//  StatusBarBugViewController.m
//  StatusBarBug
//
//  Created by Oliver Drobnik on 8/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "StatusBarBugViewController.h"

@implementation StatusBarBugViewController


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	UITapGestureRecognizer *tapGesture = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)] autorelease];
	[self.view addGestureRecognizer:tapGesture];
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

#pragma mark Actions
- (void)tap:(UITapGestureRecognizer *)gesture
{
	UIApplication *app = [UIApplication sharedApplication];
	if ([app isStatusBarHidden])
	{
		[app setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
		//[self.navigationController setNavigationBarHidden:NO animated:YES];
	}
	else 
	{
		[app setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
		//[self.navigationController setNavigationBarHidden:YES animated:YES];
	}
}

@end
