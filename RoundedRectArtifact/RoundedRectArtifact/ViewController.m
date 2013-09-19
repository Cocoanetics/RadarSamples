//
//  ViewController.m
//  RoundedRectArtifact
//
//  Created by Oliver Drobnik on 10.09.13.
//  Copyright (c) 2013 Cocoanetics. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Test.h"


@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];

	self.imageView1.image =  [UIImage imageMaskedAndTintedWithColorAndBorder:[UIColor redColor] size:_imageView1.frame.size cornerRadius:2];
	self.imageView2.image =  [UIImage imageMaskedAndTintedWithColorAndBorder:[UIColor redColor] size:_imageView1.frame.size cornerRadius:3];

	self.imageView3.image =  [UIImage imageMaskedAndTintedWithColorAndBorder:[UIColor redColor] size:_imageView1.frame.size cornerRadius:4];
}

@end
