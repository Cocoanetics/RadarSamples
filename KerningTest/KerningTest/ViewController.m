//
//  ViewController.m
//  KerningTest
//
//  Created by Oliver Drobnik on 6/16/13.
//  Copyright (c) 2013 Oliver Drobnik. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	// explanatory text is smaller
	NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:20]};
	NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"Kerning Examples:\nTw\nAV\nWA\nWa\n\nThe second character should always be visible under some part of the first." attributes:attributes];
	
	
	// make sample strings bigger and centered
	NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
	paragraphStyle.alignment = NSTextAlignmentCenter;
	NSDictionary *sampleAttribs = @{NSFontAttributeName:[UIFont systemFontOfSize:50], NSParagraphStyleAttributeName: paragraphStyle};
	[attributedString setAttributes:sampleAttribs range:NSMakeRange(18, 12)];
	
	self.textView.attributedText = attributedString;
}

@end
