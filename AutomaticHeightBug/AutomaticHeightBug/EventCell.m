//
//  EventCell.m
//  EmmiView
//
//  Created by Oliver Drobnik on 08/05/15.
//  Copyright (c) 2015 Cocoanetics. All rights reserved.
//

#import "EventCell.h"

@implementation EventCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)prepareForReuse
{
    self.descriptionLabel.text = nil;
    self.locationLabel.text = nil;
}

@end
