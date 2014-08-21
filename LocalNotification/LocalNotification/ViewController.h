//
//  ViewController.h
//  LocalNotification
//
//  Created by Oliver Drobnik on 21.08.14.
//  Copyright (c) 2014 Cocoanetics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *checkLabel;

- (IBAction)sendNote:(id)sender;

@end

