//
//  ViewController.m
//  StoreKitSheetTest
//
//  Created by Oliver Drobnik on 13.03.15.
//  Copyright (c) 2015 ProductLayer. All rights reserved.
//

#import "ViewController.h"
#import <StoreKit/StoreKit.h>


@implementation ViewController


- (IBAction)tapStore:(id)sender
{
	NSNumber *iTunesID = @(951069441);
	
	SKStoreProductViewController *storeProductViewController = [[SKStoreProductViewController alloc] init];
	
	// Configure View Controller
	[storeProductViewController loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier : iTunesID}
													  completionBlock:^(BOOL result, NSError *error) {
														  if (error)
														  {
															  NSLog(@"%@", error);
														  }
													  }];
	
	// present right away to avoid pause
	[self presentViewController:storeProductViewController animated:YES completion:nil];
}

@end
