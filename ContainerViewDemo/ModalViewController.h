//
//  ModalViewController.h
//  containerviewdemo
//
//  Created by Oliver Drobnik on 17.06.12.
//  Copyright (c) 2012 Oliver Drobnik. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DismissingBlock)(void);

@interface ModalViewController : UIViewController

@property (nonatomic, copy) DismissingBlock dismissingBlock;

@end
