//
//  TiledContentView.m
//  CATiledLayerMemory
//
//  Created by Oliver Drobnik on 9/8/13.
//  Copyright (c) 2013 Oliver Drobnik. All rights reserved.
//

#import "TiledContentView.h"

@implementation TiledContentView

- (void)awakeFromNib
{
	// set tile size if applicable
	CATiledLayer *layer = (id)self.layer;
	
	// this way tiles cover entire screen regardless of orientation or scale
	CGSize tileSize = CGSizeMake(360, 360);
	layer.tileSize = tileSize;
}

+ (Class)layerClass
{
	return [CATiledLayer class];
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
	CGRect rect = CGContextGetClipBoundingBox(ctx);
	
	// random color
	CGFloat red = (arc4random()%256)/256.0;
	CGFloat green = (arc4random()%256)/256.0;
	CGFloat blue = (arc4random()%256)/256.0;
	
	CGContextSetRGBFillColor(ctx, red, green, blue, 1);
	CGContextFillRect(ctx, rect);
	
	CGContextSetGrayStrokeColor(ctx, 0, 1);
	CGContextStrokeRect(ctx, rect);
}

@end
