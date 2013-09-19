//
//  DTCoreScannerView.m
//  TagScan
//
//  Created by Oliver Drobnik on 7/12/13.
//  Copyright (c) 2013 Oliver Drobnik. All rights reserved.
//

#import "DTCodeScannerView.h"

@implementation DTCodeScannerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
	 {
		 self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
  	UIColor *darkenColor = [UIColor colorWithWhite:0 alpha:0.1];
	[darkenColor setFill];
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextFillRect(context, self.bounds);
	
	if (!CGRectEqualToRect(_scanRegion, CGRectZero))
	{
		CGContextClearRect(context, _scanRegion);
	}
	
	// draw center line
	
	[[UIColor redColor] setStroke];
	CGContextMoveToPoint(context, CGRectGetMinX(rect), rect.size.height/2.0);
	CGContextAddLineToPoint(context, CGRectGetMaxX(rect), rect.size.height/2.0);
	
	CGContextStrokePath(context);
	
	CGContextMoveToPoint(context, rect.size.width/2.0, CGRectGetMinY(rect));
	CGContextAddLineToPoint(context, rect.size.width/2.0, CGRectGetMaxY(rect));
	
	CGContextStrokePath(context);

	
}

- (void)setScanRegion:(CGRect)scanRegion
{
	_scanRegion = scanRegion;
	[self setNeedsDisplay];
}

@end
