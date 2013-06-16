//
//  ViewController.m
//  KerningTest
//
//  Created by Oliver Drobnik on 6/16/13.
//  Copyright (c) 2013 Oliver Drobnik. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	
	NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:30]};
	
	NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"Kerning Examples:\n\nTw\nAV\nWA\nWa\n\nThe second character should always be visible under some part of the first." attributes:attributes];
	
	self.textView.attributedText = attributedString;
}

@end
