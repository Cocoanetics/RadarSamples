//
//  UIImage+Test.h
//  RoundedRectArtifact
//
//  Created by Oliver Drobnik on 10.09.13.
//  Copyright (c) 2013 Cocoanetics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Test)

+ (UIImage *)imageMaskedAndTintedWithColorAndBorder:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius;

@end
