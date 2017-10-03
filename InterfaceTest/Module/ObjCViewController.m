//
//  ObjCViewController.m
//  Module
//
//  Created by Oliver Drobnik on 03.10.17.
//  Copyright © 2017 Cocoanetics. All rights reserved.
//

#import "ObjCViewController.h"
#import <Module/Module-Swift.h>

@implementation ObjCViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	// Here you should see quick help on the class and the property, but don't.
	CustomView *cv = [[CustomView alloc] initWithFrame:CGRectZero];
	cv.publicProperty = YES;
}

@end
