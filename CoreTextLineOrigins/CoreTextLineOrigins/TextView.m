//
//  TextView.m
//  CoreTextLineOrigins
//
//  Created by Oliver Drobnik on 05.02.12.
//  Copyright (c) 2012 Drobnik KG. All rights reserved.
//

#import "TextView.h"
#import <QuartzCore/QuartzCore.h>

@implementation TextView
{
	NSAttributedString *attributedString;
	CATextLayer *textLayer;
}


- (void)setupAttributedString
{
	
	// if you use the system font instead then the spacing is correct
//	CTFontRef font = CTFontCreateUIFontForLanguage(kCTFontSystemFontType,																		 54.0, NULL);
	
	CTFontRef font = CTFontCreateWithName(CFSTR("ArialMT"), 54, NULL);
	
	NSString *string = @"XgXg XgXg XgXg XgXg XgXg\nXgXg XgXg XgXg XgXg XgXg XgXg\nXgXg XgXg XgXg XgXg XgXg\nTheEnd";
	
	NSNumber *underline = [NSNumber numberWithInt:kCTUnderlineStyleSingle];
	
	NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
										 (__bridge_transfer id)font, (id)kCTFontAttributeName,
										 underline, (id)kCTUnderlineStyleAttributeName, nil];
	
	attributedString = [[NSAttributedString alloc] initWithString:string
																		attributes:attributes];
}

- (void)layoutSubviews
{
	if (!attributedString)
	{
		[self setupAttributedString];
	}
	
	if (!textLayer)
	{
		textLayer = [CATextLayer layer];
		[self.layer addSublayer:textLayer];
		textLayer.string = attributedString;
		textLayer.frame = CGRectInset(self.bounds, 10, 10);
		textLayer.wrapped = YES;
		textLayer.opacity = 0.5;
	}
}


- (void)drawRect:(CGRect)rect
{
	if (!attributedString)
	{
		[self setupAttributedString];
	}
	
	CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attributedString);
	CGPathRef path = CGPathCreateWithRect(CGRectInset(rect, 10, 10), NULL);
	
	CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetBlendMode(context, kCGBlendModePlusDarker);
	
	CGContextSetTextMatrix(context, CGAffineTransformIdentity);
	CGContextTranslateCTM(context, 0, self.bounds.size.height);
	CGContextScaleCTM(context, 1.0, -1.0);
	
	CTFrameDraw(frame, context);
	
	
	// log the base-line distances
	NSArray *lines = (__bridge_transfer NSArray *)CTFrameGetLines(frame);
	CGPoint *origins = calloc([lines count], sizeof(CGPoint));
	
	CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), origins);
	
	for (NSInteger i=1; i<[lines count]; i++)
	{
		CGFloat distance = origins[i].y - origins[i-1].y;
		NSLog(@"Line %d: %f", i, distance);
	}
}


@end
