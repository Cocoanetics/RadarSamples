//
//  UIImage+Test.m
//  RoundedRectArtifact
//
//  Created by Oliver Drobnik on 10.09.13.
//  Copyright (c) 2013 Cocoanetics. All rights reserved.
//

#import "UIImage+Test.h"

@implementation UIImage (Test)

+ (UIImage *)imageMaskedAndTintedWithColorAndBorder:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius
{
	UIGraphicsBeginImageContextWithOptions(size, NO, 1);
	
	CGRect bounds = (CGRect){CGPointZero, size};
	
	// create path for drawing inner border
	CGRect innerBorder =  CGRectInset(bounds, 0.5f, 0.5f);
	//CGRect innerBorder =  CGRectInset(bounds, 1.0f, 1.0f);
	UIBezierPath *borderWithCornerRadius = [UIBezierPath bezierPathWithRoundedRect:innerBorder cornerRadius:cornerRadius];
	
	// draw inner border
	[color setStroke];
	[borderWithCornerRadius stroke];
	
	// get back new image
	UIImage *retImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return retImage;
}

@end
