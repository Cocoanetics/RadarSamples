//
//  AppDelegate.m
//  relationbug
//
//  Created by Oliver Drobnik on 6/25/12.
//  Copyright (c) 2012 Cocoanetics. All rights reserved.
//

#import "AppDelegate.h"

#import "TimelineViewController.h"

@interface AppDelegate ()
	- (void)_setupCoreDataStack;
@end

@implementation AppDelegate
{
	NSManagedObjectContext *_managedObjectContext;
	NSManagedObjectModel *_managedObjectModel;
	NSPersistentStoreCoordinator *_persistentStoreCoordinator;
}

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

	[self _setupCoreDataStack];
	TimelineViewController *timelines = [[TimelineViewController alloc] initWithMOC:_managedObjectContext];
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:timelines];
	
	self.window.rootViewController = nav;

    [self.window makeKeyAndVisible];
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

#pragma mark CoreData Stack
- (void)_setupCoreDataStack
{
	// setup managed object model
	NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
	_managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
	
	// setup persistent store coordinator
	NSURL *storeURL = [NSURL fileURLWithPath:[[NSString cachesPath] stringByAppendingPathComponent:@"Database.db"]];
	
	NSError *error = nil;
	_persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_managedObjectModel];
	
	if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) 
	{
		// inconsistent model/store
		[[NSFileManager defaultManager] removeItemAtURL:storeURL error:NULL];
		
		// retry once
		if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) 
		{
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		}
	}
	
	// create MOC
	_managedObjectContext = [[NSManagedObjectContext alloc] init];
	[_managedObjectContext setPersistentStoreCoordinator:_persistentStoreCoordinator];
	
	// subscribe to change notifications
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_mocDidSaveNotification:) name:NSManagedObjectContextDidSaveNotification object:nil];
}

- (void)_mocDidSaveNotification:(NSNotification *)notification
{
	// ignore change notifications for the main MOC
	
	NSManagedObjectContext *savedContext = [notification object];
	
	if (_managedObjectContext == savedContext)
	{
		return;
	}
	
	if (_managedObjectContext.persistentStoreCoordinator != savedContext.persistentStoreCoordinator)
	{
		// that's another database
		return;
	}
	
	dispatch_sync(dispatch_get_main_queue(), ^{
		// merge in the changes
		[_managedObjectContext mergeChangesFromContextDidSaveNotification:notification];
	});
}

@end
