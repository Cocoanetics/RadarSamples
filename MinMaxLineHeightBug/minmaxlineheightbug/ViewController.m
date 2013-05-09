//
//  ViewController.m
//  minmaxlineheightbug
//
//  Created by Oliver Drobnik on 16.12.12.
//  Copyright (c) 2012 Oliver Drobnik. All rights reserved.
//

#import "ViewController.h"
#import "NSHTMLWriter.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	[self _setupTextWithFont:NO];
}

- (void)_setupTextWithFont:(BOOL)withFont
{
	NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
	paragraphStyle.minimumLineHeight = 40.f;
	paragraphStyle.maximumLineHeight = 40.f;
	
	UIFont *font = [UIFont systemFontOfSize:14];

	NSMutableDictionary *attributes =  [@{NSParagraphStyleAttributeName : paragraphStyle} mutableCopy];
	
	if (withFont)
	{
		attributes[NSFontAttributeName] = font;
		
		// blank the previous setting
		self.textView.font = nil;
	}
	else
	{
		// set the font via font property
		self.textView.font = font;
	}
	
	NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:
											  @"Minimum and maximum line height are set to 40px on NSParagraphStyle\nBut if the font attribute is set the properties get ignored." attributes: attributes];
	
	self.textView.attributedText = attributedString;
	
	
	// this demonstrates the output of NSHTMLWriter
	NSHTMLWriter *writer = [[NSHTMLWriter alloc] initWithAttributedString:attributedString];
	NSData *data = [writer HTMLData];
	
	NSString *htmlString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	self.htmlView.text = htmlString;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)segmentedControlChanged:(UISegmentedControl *)sender
{
	[self _setupTextWithFont:(sender.selectedSegmentIndex==1)];
}
@end
