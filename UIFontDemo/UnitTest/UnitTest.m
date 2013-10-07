//
//  UnitTest.m
//  UnitTest
//
//  Created by Oliver Drobnik on 10/5/13.
//  Copyright (c) 2013 Oliver Drobnik. All rights reserved.
//

#import "UnitTest.h"

@implementation UnitTest

- (void)testExample
{
	UIFont *font = [UIFont fontWithName:@"Helvetica" size:20];
	STAssertNotNil(font, @"font should not be nil");
}

@end
