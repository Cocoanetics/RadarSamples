//
//  EditableView.m
//  InputViewScrollViewBug
//
//  Created by Oliver Drobnik on 5/9/13.
//  Copyright (c) 2013 Oliver Drobnik. All rights reserved.
//

#import "EditableView.h"
#import "AlternateInputViewController.h"

@interface EditableView ()

@property (nonatomic, strong) AlternateInputViewController *alternateInputViewController; 

@end

@implementation EditableView

- (UIView *)inputView
{
	if (!self.alternateInputViewController)
	{
		self.alternateInputViewController = [[AlternateInputViewController alloc] initWithStyle:UITableViewStyleGrouped];
	}
	
	return (UIView *)self.alternateInputViewController.view;
}

@end
