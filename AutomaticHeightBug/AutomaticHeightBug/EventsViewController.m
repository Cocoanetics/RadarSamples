//
//  EventsViewController.m
//  EmmiView
//
//  Created by Oliver Drobnik on 08/05/15.
//  Copyright (c) 2015 Cocoanetics. All rights reserved.
//

#import "EventsViewController.h"
#import "EventCell.h"

@interface EventsViewController () <UIPopoverPresentationControllerDelegate>

@end

@implementation EventsViewController
{
	EventCell *_sizingCell;
}

- (void)awakeFromNib
{
	[super awakeFromNib];
	
	self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}


- (void)configureCell:(EventCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSString *longText = @"A very long text that certainly should be wrapping around several lines and should never show an ellipsis";
    
	cell.descriptionLabel.text = longText;
	
	NSDateFormatter *formatter = [NSDateFormatter new];
	formatter.dateStyle = NSDateFormatterShortStyle;
	
	cell.dateLabel.text = [formatter stringFromDate:[NSDate date]];
	
	formatter.dateStyle = NSDateFormatterNoStyle;
	formatter.timeStyle = NSDateFormatterShortStyle;
	
	NSString *timeStr = [NSString stringWithFormat:@"%@\n%@", [formatter stringFromDate:[NSDate date]], [formatter stringFromDate:[NSDate date]]];
	cell.fromTimeLabel.text = timeStr;
	
	cell.locationLabel.text = longText;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"EventCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    [self configureCell:(id)cell atIndexPath:indexPath];
    
    return cell;
}

- (IBAction)doRefresh:(UIRefreshControl *)sender
{
    [self.tableView reloadData];
    [sender endRefreshing];
}

@end
