//
//  DTTableView.m
//  InputViewScrollViewBug
//
//  Created by Oliver Drobnik on 5/9/13.
//  Copyright (c) 2013 Oliver Drobnik. All rights reserved.
//

#import "DTTableView.h"

@implementation DTTableView


// set a breakpoint here to see the erroneous calling of setContentInset
- (void)setContentInset:(UIEdgeInsets)contentInset
{
	NSLog(@"DTTableView setContentInset %@:", NSStringFromUIEdgeInsets(contentInset));
	[super setContentInset:contentInset];
}

@end
