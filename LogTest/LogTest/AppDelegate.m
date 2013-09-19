//
//  AppDelegate.m
//  LogTest
//
//  Created by Oliver Drobnik on 8/7/13.
//  Copyright (c) 2013 Oliver Drobnik. All rights reserved.
//

#import "AppDelegate.h"
#import <asl.h>


@implementation AppDelegate

- (void)log
{
	aslmsg q, m;
	int i;
	const char *key, *val;
	
	q = asl_new(ASL_TYPE_QUERY);
	asl_set_query(q, ASL_KEY_MSG, "TEST", ASL_QUERY_OP_PREFIX | ASL_QUERY_OP_EQUAL);
	
	aslresponse r = asl_search(NULL, q);
	while (NULL != (m = aslresponse_next(r)))
	{
		NSMutableDictionary *tmpDict = [NSMutableDictionary dictionary];
		
		for (i = 0; (NULL != (key = asl_key(m, i))); i++)
		{
			NSString *keyString = [NSString stringWithUTF8String:(char *)key];
			
			val = asl_get(m, key);
			
			NSString *string = val?[NSString stringWithUTF8String:val]:@"";
			[tmpDict setObject:string forKey:keyString];
		}
		
		NSLog(@"%@", tmpDict);
	}
	aslresponse_free(r);
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	NSLog(@"TEST1");
	
	aslclient client = asl_open(NULL, [[[NSBundle mainBundle] bundleIdentifier] UTF8String], 0);

	asl_set_filter(client, ASL_FILTER_MASK_UPTO(ASL_LEVEL_DEBUG));
	
	aslmsg msg = asl_new(ASL_TYPE_MSG);
	// asl_set(msg, ASL_KEY_READ_UID, "501");  // without this the message cannot be found by asl_search
	
	asl_log(client, msg, ASL_LEVEL_NOTICE, "TEST2");
	
	asl_close(client);
	
	
	[self log];
	
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
