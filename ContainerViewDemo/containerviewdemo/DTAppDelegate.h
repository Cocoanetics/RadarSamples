//
//  DTAppDelegate.h
//  containerviewdemo
//
//  Created by Oliver Drobnik on 17.06.12.
//  Copyright (c) 2012 Oliver Drobnik. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface DTAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) RootViewController *viewController;

@end
