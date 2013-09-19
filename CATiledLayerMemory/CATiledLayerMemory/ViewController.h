//
//  ViewController.h
//  CATiledLayerMemory
//
//  Created by Oliver Drobnik on 9/8/13.
//  Copyright (c) 2013 Oliver Drobnik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TiledContentView.h"

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet TiledContentView *contentView;
@end
