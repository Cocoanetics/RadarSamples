//
//  TableViewController.m
//  ActionsBug
//
//  Created by Oliver Drobnik on 08/01/15.
//  Copyright (c) 2015 ProductLayer. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
	cell.textLabel.text = @"Not Editing";
	cell.backgroundColor = [UIColor greenColor];
	
    return cell;
}

#pragma mark - Edit Actions

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSMutableArray *actions = [NSMutableArray array];
	
	UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"One" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
		
//		[self.tableView setEditing:YES animated:YES];
		[self.tableView setEditing:NO animated:YES];
	}];
	
	[actions addObject:action1];

	UITableViewRowAction *action2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"Two" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
		
		//		[self.tableView setEditing:YES animated:YES];
		[self.tableView setEditing:NO animated:YES];
	}];
	
	[actions addObject:action2];

	
	if ([actions count])
	{
		return actions;
	}
	
	return nil;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	// No statement or algorithm is needed in here. Just the implementation
}

- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	cell.textLabel.text = @"Editing";
	cell.backgroundColor = [UIColor redColor];
	
	NSLog(@"%s %@", __PRETTY_FUNCTION__, indexPath);
}

- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	cell.textLabel.text = @"Not Editing";
	cell.backgroundColor = [UIColor greenColor];
	
	// this is not called right away after closing the edit actions if the swipe ends too soon
	NSLog(@"%s %@", __PRETTY_FUNCTION__, indexPath);
}

@end
