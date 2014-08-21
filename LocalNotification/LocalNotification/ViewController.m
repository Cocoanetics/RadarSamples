//
//  ViewController.m
//  LocalNotification
//
//  Created by Oliver Drobnik on 21.08.14.
//  Copyright (c) 2014 Cocoanetics. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

#pragma mark - View Lifecycle

- (void)viewWillAppear:(BOOL)animated
{
   [super viewWillAppear:animated];
   
   [self _authorizeLocalNotifications];
}


#pragma mark - Helpers

- (void)_authorizeLocalNotifications {
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
   UIApplication *app = [UIApplication sharedApplication];
   if ([app respondsToSelector:
        @selector(registerUserNotificationSettings:)])
   {
      UIUserNotificationSettings *settings =
      [UIUserNotificationSettings settingsForTypes:
       UIUserNotificationTypeAlert|UIUserNotificationTypeSound
                                        categories:nil];
      [app registerUserNotificationSettings:settings];
   }
#endif
}

// sends a local notification for a Yard Sale Place
- (void)_sendLocalNotificationAfterDelay:(NSTimeInterval)duration {
   UIApplication *app = [UIApplication sharedApplication];
   
   BOOL shouldAddMsg = YES;
   BOOL shouldAddSound = YES;
   
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
   if ([app respondsToSelector:
        @selector(currentUserNotificationSettings)]) {
      UIUserNotificationSettings *settings =
      [app currentUserNotificationSettings];
      
      if (!settings.types) {
         // we'll come back here in the callback to registering
         return;
      }
      
      if (!(settings.types & UIUserNotificationTypeAlert)) {
         shouldAddMsg = NO;
      }
      
      if (!(settings.types & UIUserNotificationTypeSound)) {
         shouldAddSound = NO;
      }
   }
#endif
   
   NSString *msg = @"Check if you see the checkmark appear.";
   
   UILocalNotification *note = [[UILocalNotification alloc] init];
   note.alertAction = @"Open Demo";
   
   if (shouldAddMsg) {
      note.alertBody = msg;
   }
   
   if (shouldAddSound) {
      note.soundName = UILocalNotificationDefaultSoundName;
   }
   
   note.fireDate = [[NSDate date] dateByAddingTimeInterval:duration];
   
   [app scheduleLocalNotification:note];
}


#pragma mark - Actions

- (IBAction)sendNote:(id)sender {
   self.checkLabel.text = @"?";
   self.checkLabel.textColor = [UIColor grayColor];

   [self _sendLocalNotificationAfterDelay:5];
}

@end
