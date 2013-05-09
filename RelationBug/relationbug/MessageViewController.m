//
//  MessageViewController.m
//  relationbug
//
//  Created by Oliver Drobnik on 6/25/12.
//  Copyright (c) 2012 Cocoanetics. All rights reserved.
//

#import "MessageViewController.h"
#import "Timeline.h"
#import "Message.h"
#import "ErrorSwitchHeaderView.h"


@interface MessageViewController ()


@end


@implementation MessageViewController
{
	Timeline *_timeline;
	
	NSManagedObjectContext *_moc;
	NSFetchedResultsController *_fetchedResultsController;
	
	dispatch_queue_t _addQueue;
	
	ErrorSwitchHeaderView *_errorSwitchHeader;
}

- (id)initWithTimeline:(Timeline *)timeline
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) 
	{
		_timeline = timeline;
		_moc = _timeline.managedObjectContext;
		
		self.navigationItem.title = @"Messages";
		
		UIBarButtonItem *addMessage = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addMessage:)];
		self.navigationItem.rightBarButtonItem = addMessage;
		
		
		// set up fetched results controller
		NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Message"];
		
		NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(%@ in timelines)", _timeline];
		request.predicate = predicate; 
        
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO];
        request.sortDescriptors = [NSArray arrayWithObject:sort];
		
        _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:_moc sectionNameKeyPath:nil cacheName:nil];
        _fetchedResultsController.delegate = self;
        
        // perform initial fetch
        NSError *error;
        
        if (![_fetchedResultsController performFetch:&error])
        {
            NSLog(@"Error: %@", [error localizedDescription]);
        }
		
		_addQueue = dispatch_queue_create("AddMessageQueue", 0);
    }
    return self;
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	_errorSwitchHeader = [[ErrorSwitchHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
	return _errorSwitchHeader;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[_fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[_fetchedResultsController sections] objectAtIndex:section];
    NSUInteger rows = [sectionInfo numberOfObjects];
    return rows;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Message *message = (Message *)[_fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = message.text;
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	formatter.timeStyle = NSDateFormatterMediumStyle;
	cell.detailTextLabel.text = [formatter stringFromDate:message.creationDate];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    UITableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"Timeline"];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Timeline"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    
	return cell;
}

#pragma mark NSFetchedResultsController Delegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath]
                    atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

#pragma mark Actions
- (void)addMessage:(UIBarButtonItem *)sender
{
	dispatch_async(_addQueue, ^{
		// create a tmp MOC for adding
		NSManagedObjectContext *tmpMOC = [[NSManagedObjectContext alloc] init];
		tmpMOC.persistentStoreCoordinator = _moc.persistentStoreCoordinator;
		
		
		Message *newMessage = (Message *)[NSEntityDescription insertNewObjectForEntityForName:@"Message" 
																	   inManagedObjectContext:tmpMOC];
		newMessage.creationDate = [NSDate date];
		newMessage.text = @"A new message";

		
		// error switch ON causes an extra save
		if (_errorSwitchHeader.errorSwitch.isOn)
		{
			[tmpMOC save:nil];
		}

		
		[newMessage addTimelinesObject:_timeline];
		
		
		// if the relation adding is by itself then this save does not trigger a notification
		// i.e. the fetched results controller does not get updated properly. 
		[tmpMOC save:nil];
	});
}
@end
