//
//  ViewController.h
//  PickerBug
//
//  Created by Oliver Drobnik on 28/11/14.
//  Copyright (c) 2014 Cocoanetics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (IBAction)saveSampleToPhotos:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *sampleImageView;
@property (weak, nonatomic) IBOutlet UIImageView *resultImageView;

- (IBAction)pickImage:(id)sender;
@end

