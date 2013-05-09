//
//  MessageViewController.h
//  relationbug
//
//  Created by Oliver Drobnik on 6/25/12.
//  Copyright (c) 2012 Cocoanetics. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Timeline;

@interface MessageViewController : UITableViewController <NSFetchedResultsControllerDelegate>

- (id)initWithTimeline:(Timeline *)timeline;

@end
