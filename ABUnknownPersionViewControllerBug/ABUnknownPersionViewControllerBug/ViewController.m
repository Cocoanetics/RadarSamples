//
//  ViewController.m
//  ABUnknownPersionViewControllerBug
//
//  Created by Oliver Drobnik on 18/06/15.
//  Copyright © 2015 Cocoanetics. All rights reserved.
//

@import AddressBookUI;

#import "ViewController.h"

// create an ABRecord for testing
ABRecordRef testPerson()
{
	ABRecordRef person = ABPersonCreate();
	
	ABMutableMultiValueRef phoneNumbers = ABMultiValueCreateMutable(kABMultiStringPropertyType);
	
			ABMultiValueAddValueAndLabel(phoneNumbers, (__bridge CFStringRef)@"+4369910010110", kABPersonPhoneMainLabel, NULL);
	ABRecordSetValue(person, kABPersonPhoneProperty, phoneNumbers, nil);
	
	ABRecordSetValue(person, kABPersonFirstNameProperty,(__bridge CFTypeRef)@"Oliver", NULL);
	ABRecordSetValue(person, kABPersonLastNameProperty, (__bridge CFTypeRef)@"Drobnik", NULL);
	ABRecordSetValue(person, kABPersonOrganizationProperty, (__bridge CFTypeRef)@"Cocoanetics.com", NULL);
	CFRelease(phoneNumbers);
	
	return person;
}

@implementation ViewController

- (IBAction)showPerson:(id)sender
{
	ABRecordRef person = testPerson();
	
	ABUnknownPersonViewController *unk = [ABUnknownPersonViewController new];
	unk.allowsAddingToAddressBook = YES;
	unk.allowsActions = YES;
	unk.navigationItem.title = @"Who is that?";
	unk.displayedPerson = person;
	CFRelease(person);
	
	[self.navigationController pushViewController:unk animated:YES];
}

@end
