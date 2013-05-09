//
//  ErrorSwitchHeaderView.m
//  relationbug
//
//  Created by Oliver Drobnik on 6/25/12.
//  Copyright (c) 2012 Cocoanetics. All rights reserved.
//

#import "ErrorSwitchHeaderView.h"

@implementation ErrorSwitchHeaderView
{
	UISwitch *_errorSwitch;
	UILabel *_label;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		
		_errorSwitch = [[UISwitch alloc] init];
		[self addSubview:_errorSwitch];
		
		_label = [[UILabel alloc] init];
		_label.numberOfLines = 0;
		[self addSubview:_label];
		
		self.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    }
    return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	
	CGRect frame = _errorSwitch.frame;
	
	frame.origin.x = CGRectGetMaxX(self.bounds) - frame.size.width - 10;
	frame = CGRectInset(frame, 0, 10);
	_errorSwitch.frame = frame;
	
	_label.frame = CGRectMake(10,10, frame.origin.x - 20, self.bounds.size.height-20);
	_label.text = @"This switch addes an extra save of the temporary context and the adding of the relation by itself before a save does not trigger the update notification.";
	_label.font = [UIFont systemFontOfSize:13];
	_label.textColor = [UIColor redColor];
	_label.shadowColor = [UIColor whiteColor];
	_label.shadowOffset = CGSizeMake(0, 1);
	_label.backgroundColor = self.backgroundColor;
}

@synthesize errorSwitch = _errorSwitch;


@end
