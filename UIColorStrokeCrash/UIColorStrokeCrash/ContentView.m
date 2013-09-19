//
//  ContentView.m
//  ForegroundColorBug
//
//  Created by Oliver Drobnik on 8/15/13.
//  Copyright (c) 2013 Oliver Drobnik. All rights reserved.
//

#import "ContentView.h"

@implementation ContentView
{
	BOOL _showCrash;
}

- (void)drawRect:(CGRect)rect
{
	NSDictionary *attributes;
	

	if (_showCrash)
	{
		// set with iOS 6/7 attributes

		UIFont *font = [UIFont fontWithName:@"Helvetica" size:12];
		attributes = @{NSForegroundColorAttributeName: [UIColor blueColor],
					   NSFontAttributeName: font};

	}
	else
	{
		// set with Core Text attributes

		CTFontRef font = CTFontCreateWithName(CFSTR("Helvetica"), 12, NULL);
		attributes = @{(id)kCTForegroundColorAttributeName: (id)[UIColor blueColor].CGColor,
					   (id)kCTFontAttributeName: (id)CFBridgingRelease(font)};
	}
	
	NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"line1" attributes:attributes];
	
	CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)(attributedString));
	
	CFRange range = CFRangeMake(0, [attributedString length]);
	
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathAddRect(path, NULL, CGRectMake(0, 0, 1000, 100));
	
	CTFrameRef frame =  CTFramesetterCreateFrame(framesetter, range, path, NULL);
	
	NSArray *lines = (NSArray *)CTFrameGetLines(frame);
	CTLineRef firstLine = (__bridge CTLineRef)(lines[0]);
	NSArray *runs = (NSArray *)CTLineGetGlyphRuns(firstLine);
	CTRunRef firstRun = (__bridge CTRunRef)runs[0];
	
	NSDictionary *runAttributes = (NSDictionary *)CTRunGetAttributes(firstRun);

	// the CTForegroundColor attribute is not visible in the runAttributes
	NSLog(@"%@", runAttributes);
	
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	
	CGColorRef cgColor = (__bridge CGColorRef)runAttributes[(id)kCTForegroundColorAttributeName];
	
	if (cgColor) // should be nil for "modern style"
	{
		CGContextSetStrokeColorWithColor(ctx, cgColor);
	}
	else
	{
		// .. so that the stroke color would come from here
		UIColor *color = runAttributes[NSForegroundColorAttributeName];
		[color setStroke];
	}
	
	// this line crashes
	CGContextStrokeRect(ctx, self.bounds);
}

- (void)enableCrash
{
	_showCrash = YES;
	
	[self setNeedsDisplay];
}

@end
