//
//  ViewController.m
//  DataDetectorAddressBug
//
//  Created by Oliver Drobnik on 15/04/15.
//  Copyright (c) 2015 Cocoanetics. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
	[super viewDidLoad];

	[self.workingAddressTextView.layer setBorderWidth:1];
	[self.workingAddressTextView.layer setBorderColor:[UIColor greenColor].CGColor];
	
	[self.firstAddressTextView.layer setBorderWidth:1];
	[self.firstAddressTextView.layer setBorderColor:[UIColor redColor].CGColor];
	
	[self.secondAddressTextView.layer setBorderWidth:1];
	[self.secondAddressTextView.layer setBorderColor:[UIColor redColor].CGColor];
	
	
	
	// there should be 4 parts in the address: City, Country, Street and ZIP
	// there is only the incomplete Street
	NSDictionary *firstAddressParts = [self _addressPartsOfString:self.firstAddressTextView.text];
	NSLog(@"%@", firstAddressParts);
	
	NSDictionary *secondAddressParts = [self _addressPartsOfString:self.secondAddressTextView.text];
	NSLog(@"%@", secondAddressParts);
}

- (NSDictionary *)_addressPartsOfString:(NSString *)string
{
	NSError *error;
	NSDataDetector *addressDetector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeAddress error:&error];
	
	NSRange entireRange = NSMakeRange(0, [string length]);
	NSArray *matches = [addressDetector matchesInString:string options:0 range:entireRange];
	
	NSTextCheckingResult *result = [matches firstObject];
	return result.addressComponents;
}

@end
