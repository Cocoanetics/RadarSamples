//
//  StatusBarBugAppDelegate.h
//  StatusBarBug
//
//  Created by Oliver Drobnik on 8/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StatusBarBugViewController;

@interface StatusBarBugAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    StatusBarBugViewController *viewController;
	UINavigationController *navController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet StatusBarBugViewController *viewController;
@property (nonatomic, retain) IBOutlet UINavigationController *navController;
@end

