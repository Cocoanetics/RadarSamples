//
//  ViewController.h
//  StoreKitVCBug
//
//  Created by Oliver Drobnik on 20/03/15.
//  Copyright (c) 2015 Cocoanetics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *errorTextLabel;

- (IBAction)showStoreButton:(id)sender;

@end

