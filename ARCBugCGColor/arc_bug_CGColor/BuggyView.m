//
//  BuggyView.m
//  arc_bug_CGColor
//
//  Created by Oliver Drobnik on 6/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BuggyView.h"

@implementation BuggyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect 
{
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	
	CGColorRef topColor = [UIColor colorWithRed:147.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0].CGColor;
	CGColorRef bottomColor = [UIColor colorWithRed:254.0/255.0 green:204.0/255.0 blue:209.0/255.0 alpha:1.0].CGColor;
	
	
	// Fill the background with a gradient
	CGFloat gradientLocations[2] = { 1.0, 0.0 };
	CGColorRef fillColors[2] = {bottomColor, topColor};
	CFArrayRef fillColorsArray = CFArrayCreate(NULL, (void *)fillColors, 2, &kCFTypeArrayCallBacks);
	CGGradientRef gradient = CGGradientCreateWithColors(NULL, fillColorsArray, gradientLocations);
	CGContextDrawLinearGradient(ctx, gradient, CGPointZero,CGPointMake(0, self.bounds.size.height), 0);
	
	CGGradientRelease(gradient);
	CFRelease(fillColorsArray);
	
	// draw bottom line
	
	CGContextMoveToPoint(ctx, 0, rect.size.height);
	CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height);
	
	CGContextSetRGBStrokeColor(ctx, 163.0/255.0, 167.0/255.0, 176.0/255.0, 1.0);
	CGContextSetLineWidth(ctx, 1.5);
	CGContextStrokePath(ctx);
}

@end
