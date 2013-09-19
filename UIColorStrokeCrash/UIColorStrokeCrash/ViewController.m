//
//  ViewController.m
//  UIColorStrokeCrash
//
//  Created by Oliver Drobnik on 10.09.13.
//  Copyright (c) 2013 Cocoanetics. All rights reserved.
//

#import "ViewController.h"
#import "ContentView.h"

@interface ViewController ()

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

- (IBAction)crashButton:(id)sender
{
	[(ContentView *)self.view enableCrash];
}


@end
