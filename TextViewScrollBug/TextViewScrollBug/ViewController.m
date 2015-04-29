//
//  ViewController.m
//  textviewscrollbug
//
//  Created by Oliver Drobnik on 29/04/15.
//  Copyright (c) 2015 Cocoanetics. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - Notifications

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	// observe keyboard for inset
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
	[center addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	[center addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
	
	NSString *path = [[NSBundle mainBundle] pathForResource:@"defaultnote" ofType:@"txt"];
	NSString *string = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
	self.textView.text = string;
}

- (void)viewDidLayoutSubviews
{
	[super viewDidLayoutSubviews];
	
	// show scrolled to top
	self.textView.contentOffset = CGPointZero;
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)automaticallyAdjustsScrollViewInsets
{
	return NO;
}

- (void)keyboardWillShow:(NSNotification *)notification
{
	// keyboard frame is in window coordinates
	NSDictionary *userInfo = [notification userInfo];
	CGRect keyboardFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
 
	// convert own frame to window coordinates, frame is in superview's coordinates
	CGRect ownFrame = [self.view.window convertRect:self.view.frame fromView:self.view.superview];
 
	// calculate the area of own frame that is covered by keyboard
	CGRect coveredFrame = CGRectIntersection(ownFrame, keyboardFrame);
 
	// now this might be rotated, so convert it back
	coveredFrame = [self.view.window convertRect:coveredFrame toView:self.view.superview];
 
	// set inset to make up for covered height at bottom
	UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, coveredFrame.size.height, 0);
	
	NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
	NSUInteger options = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
	
	[UIView animateWithDuration:duration
								 delay:0
							  options:options | UIViewAnimationOptionBeginFromCurrentState
						  animations:^{
							  self.textView.contentInset = insets;
							  self.textView.scrollIndicatorInsets = insets;
						  } completion:NULL];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
	// set inset to make up for no longer covered array at bottom
	UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
	
	NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
	NSUInteger options = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
	
	[UIView animateWithDuration:duration
								 delay:0
							  options:options | UIViewAnimationOptionBeginFromCurrentState
						  animations:^{
							  self.textView.contentInset = insets;
							  self.textView.scrollIndicatorInsets = insets;
						  } completion:NULL];
}
- (IBAction)hideKeyboard:(id)sender {
	[self.textView resignFirstResponder];
}

@end
