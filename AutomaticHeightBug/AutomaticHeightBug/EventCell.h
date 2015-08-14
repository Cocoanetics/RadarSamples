//
//  EventCell.h
//  EmmiView
//
//  Created by Oliver Drobnik on 08/05/15.
//  Copyright (c) 2015 Cocoanetics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *untilTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@end
