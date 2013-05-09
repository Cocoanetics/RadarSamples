//
//  DTViewController.m
//  CoreTextLineOrigins
//
//  Created by Oliver Drobnik on 05.02.12.
//  Copyright (c) 2012 Drobnik KG. All rights reserved.
//

#import "DTViewController.h"


@implementation DTViewController


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
	

	
	/*
	CATextLayer *textLayer = [CATextLayer layer];
	[self.view.layer addSublayer:textLayer];
	textLayer.string = aString;
	textLayer.frame = CGRectInset(self.view.bounds, 5, 5);
	textLayer.backgroundColor = [UIColor yellowColor].CGColor;
	textLayer.wrapped = YES;
	 */
//	CATextLayer ignores paragraph styles
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
	    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
	} else {
	    return YES;
	}
}

@end
