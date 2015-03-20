//
//  ViewController.m
//  StoreKitVCBug
//
//  Created by Oliver Drobnik on 20/03/15.
//  Copyright (c) 2015 Cocoanetics. All rights reserved.
//

#import "ViewController.h"
@import StoreKit;

@interface ViewController () <SKStoreProductViewControllerDelegate>

@end

@implementation ViewController


- (IBAction)showStoreButton:(id)sender
{
	NSNumber *iTunesID = @(951069440);
 
	if (iTunesID)
	{
		SKStoreProductViewController *storeProductViewController = [[SKStoreProductViewController alloc]
																						init];
		
		// Configure View Controller
		[storeProductViewController setDelegate:self];
		[storeProductViewController loadProductWithParameters:
		 @{SKStoreProductParameterITunesItemIdentifier : iTunesID}
														  completionBlock:^(BOOL result, NSError *error) {
															  // log error
															  dispatch_async(dispatch_get_main_queue(), ^{
																  NSString *text = [NSString stringWithFormat:@"NSError received: %@", [error localizedDescription]];
																  self.errorTextLabel.text = text;
															  });
														  }
   ];
		
		// present right away to avoid pause
		[self presentViewController:storeProductViewController animated:YES completion:nil];
	}
}

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
	[viewController dismissViewControllerAnimated:YES completion:NULL];
}

@end
