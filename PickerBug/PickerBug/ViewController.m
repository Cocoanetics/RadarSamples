//
//  ViewController.m
//  PickerBug
//
//  Created by Oliver Drobnik on 28/11/14.
//  Copyright (c) 2014 Cocoanetics. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	UIImage *sample = [UIImage imageNamed:@"Sample"];
	self.sampleImageView.image = sample;
}

//- (void)viewWillAppear:(BOOL)animated
//{
//	[super viewWillAppear:animated];
//	
//	[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
//	[self.navigationController setNavigationBarHidden:YES animated:NO];
//}

- (IBAction)saveSampleToPhotos:(id)sender
{
	UIImageWriteToSavedPhotosAlbum(self.sampleImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
	UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Photo saving" message:nil preferredStyle:UIAlertControllerStyleAlert];
	
	if (error)
	{
		alert.message = [error localizedDescription];
	}
	else
	{
		alert.message = @"Photo successfully saved to camera roll";
	}
	
	[alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:NULL]];
	
	[self presentViewController:alert animated:YES completion:NULL];
}
- (IBAction)pickImage:(id)sender
{
	UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
	imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	imgPicker.delegate = self;
	imgPicker.allowsEditing = YES;
	
	[self presentViewController:imgPicker animated:YES completion:NULL];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	UIImage *image = info[UIImagePickerControllerEditedImage];
	self.resultImageView.image = image;
	
	[picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[picker dismissViewControllerAnimated:YES completion:nil];
}


@end
