//
//  ViewController.m
//  qltest
//
//  Created by Oliver Drobnik on 6/11/13.
//  Copyright (c) 2013 Oliver Drobnik. All rights reserved.
//

#import <QuickLook/QuickLook.h>
#import "ViewController.h"

@interface MyPreviewItem : NSObject <QLPreviewItem>

@end

@implementation MyPreviewItem

- (NSURL *)previewItemURL
{
	return nil;
}

@end

@interface ViewController () <QLPreviewControllerDataSource>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonTouched:(id)sender {
	QLPreviewController *controller = [[QLPreviewController alloc] init];
	controller.dataSource = self;
	
	[self presentViewController:controller animated:YES completion:^{
		
	}];
	
	
}

- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller
{
	return 1;
}

- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index
{
	return [[MyPreviewItem alloc] init];
}

@end
