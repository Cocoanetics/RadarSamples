//
//  ViewController.m
//  CATiledLayerMemory
//
//  Created by Oliver Drobnik on 9/8/13.
//  Copyright (c) 2013 Oliver Drobnik. All rights reserved.
//

#import "ViewController.h"
#import "TiledContentView.h"


@interface UIApplication()

- (void)_performMemoryWarning;

@end


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	_scrollView.scrollEnabled = YES;
	_scrollView.minimumZoomScale = 1.0;
	_scrollView.maximumZoomScale = 1.0;
	_scrollView.userInteractionEnabled = YES;
	_contentView.userInteractionEnabled = NO;
	
	CGSize contentSize = CGSizeMake(self.view.bounds.size.width, 100000);
	
	_contentView.frame = (CGRect){CGPointZero, contentSize};
	_scrollView.contentSize = contentSize;
}

@end
