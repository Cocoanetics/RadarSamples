//
//  DTCodeScannerViewController.h
//  TagScan
//
//  Created by Oliver Drobnik on 7/12/13.
//  Copyright (c) 2013 Oliver Drobnik. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DTCodeScannerViewController;


@protocol DTCodeScannerViewControllerDelegate <NSObject>

- (void)codeScanner:(DTCodeScannerViewController *)codeScanner didScanCode:(NSString *)code;

@end


@interface DTCodeScannerViewController : UIViewController

@property (nonatomic, weak) IBOutlet id <DTCodeScannerViewControllerDelegate> scanDelegate;

@end
