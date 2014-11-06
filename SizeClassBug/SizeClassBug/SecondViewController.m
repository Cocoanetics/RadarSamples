//
//  SecondViewController.m
//  SizeClassBug
//
//  Created by Oliver Drobnik on 06/11/14.
//  Copyright (c) 2014 Cocoanetics. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)_setupForTraitCollection:(UITraitCollection *)collection
{
	switch (collection.horizontalSizeClass)
	{
		case UIUserInterfaceSizeClassUnspecified:
			self.horizontalLabel.text = @"Unspecified";
			break;
			
		case UIUserInterfaceSizeClassCompact:
			self.horizontalLabel.text = @"Compact";
			
			// in compact we want the nav bar to be able to close
			[self.navigationController setNavigationBarHidden:NO];
			break;
			
		case UIUserInterfaceSizeClassRegular:
			self.horizontalLabel.text = @"Regular";
			
			// in regular we need no nav bar
			[self.navigationController setNavigationBarHidden:YES];

			break;
	}
	
	switch (collection.verticalSizeClass)
	{
		case UIUserInterfaceSizeClassUnspecified:
			self.verticalLabel.text = @"Unspecified";
			break;
			
		case UIUserInterfaceSizeClassCompact:
			self.verticalLabel.text = @"Compact";
			break;
			
		case UIUserInterfaceSizeClassRegular:
			self.verticalLabel.text = @"Regular";
			break;
	}

}


- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	[self _setupForTraitCollection:self.traitCollection];
}

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
	[self _setupForTraitCollection:newCollection];
}

@end
