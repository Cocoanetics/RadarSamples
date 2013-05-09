//
//  TimelineViewController.m
//  relationbug
//
//  Created by Oliver Drobnik on 6/25/12.
//  Copyright (c) 2012 Cocoanetics. All rights reserved.
//

#import "TimelineViewController.h"
#import "MessageViewController.h"

#import "Timeline.h"

@implementation TimelineViewController
{
	NSManagedObjectContext *_moc;
	NSFetchedResultsController *_fetchedResultsController;
}

- (id)initWithMOC:(NSManagedObjectContext *)moc;
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) 
	{
		_moc = moc;
		
		self.navigationItem.title = @"Timelines";
		
		UIBarButtonItem *addTimeline = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTimeline:)];
		self.navigationItem.rightBarButtonItem = addTimeline;
		
		// set up fetched results controller
		NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Timeline"];
        
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
    }
    return self;
}

#pragma mark - Table view data source

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
    Timeline *timeline = (Timeline *)[_fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = timeline.name;
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	formatter.timeStyle = NSDateFormatterMediumStyle;
	cell.detailTextLabel.text = [formatter stringFromDate:timeline.creationDate];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	Timeline *timeline = (Timeline *)[_fetchedResultsController objectAtIndexPath:indexPath];
 
	MessageViewController *messages = [[MessageViewController alloc] initWithTimeline:timeline];
	[self.navigationController pushViewController:messages animated:YES];
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
- (void)addTimeline:(UIBarButtonItem *)sender
{
	Timeline *newTimeline = (Timeline *)[NSEntityDescription insertNewObjectForEntityForName:@"Timeline" 
																			inManagedObjectContext:_moc];
	newTimeline.creationDate = [NSDate date];
	newTimeline.name = @"A new timeline";
	
	[_moc save:nil];
}

@end
