//
//  PhotoScrollView.h
//  ProductLayyer
//
//  Created by Oliver Drobnik on 17.07.14.
//  Copyright (c) 2014 Cocoanetics. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 A Photo Viewer supporting both pinch-to-zoom and Motion Tilt.
 */


@interface PhotoScrollView : UIScrollView

/**
 The image to show in the scroll view
 */
@property (nonatomic, strong) UIImage *image;

@end
