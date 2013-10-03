//
//  ViewController.m
//  TestDTCoreTextException
//
//  Created by Jesús on 21/09/13.
//  Copyright (c) 2013 Jesús. All rights reserved.
//

#import <DTCoreText/DTCoreText.h>
#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, copy) NSString *text1;
@property (nonatomic, copy) NSString *text2;
@property (weak, nonatomic) IBOutlet UISwitch *swCreateAllContent;

@property (weak, nonatomic) IBOutlet UIView *vTextContainer;
@end

@implementation ViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.text1 = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SampleText1" ofType:@"txt"] encoding:NSUTF8StringEncoding error:NULL];
        self.text2 = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SampleText2" ofType:@"txt"] encoding:NSUTF8StringEncoding error:NULL];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createContent:nil];
}

- (IBAction)createContent:(id)sender
{
    [self createContent1:nil];
}

- (IBAction)createContent1:(id)sender
{
    BOOL createAllContent = self.swCreateAllContent.isOn;
    
    static NSInteger iteration = 0;
    
    [self.vTextContainer.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [(UIView*)obj removeFromSuperview];
    }];
    
    CGRect workingRect = self.view.bounds, column1, column2, column3;
    CGRectDivide(workingRect, &column1, &workingRect, CGRectGetWidth(self.view.bounds) / 3.f, CGRectMinXEdge);
    CGRectDivide(workingRect, &column2, &workingRect, CGRectGetWidth(self.view.bounds) / 3.f, CGRectMinXEdge);
    CGRectDivide(workingRect, &column3, &workingRect, CGRectGetWidth(self.view.bounds) / 3.f, CGRectMinXEdge);
    
    column1 = CGRectIntegral(column1);
    column2 = CGRectIntegral(column2);
    column3 = CGRectIntegral(column3);
    
    NSString *text = (iteration++%2)?self.text1:self.text2;
    NSInteger textRangeInit;
    DTHTMLAttributedStringBuilder *stringBuilder;
    DTCoreTextLayoutFrame *layoutFrame;
    DTAttributedTextView *textView;
    DTCoreTextLayouter *layouter;
    
    stringBuilder = [[DTHTMLAttributedStringBuilder alloc] initWithHTML:[text dataUsingEncoding:NSUTF8StringEncoding] options:nil documentAttributes:NULL];
    layouter = [[DTCoreTextLayouter alloc] initWithAttributedString:[stringBuilder generatedAttributedString]];
    
    //Column1
    textRangeInit = 0;
    
    layoutFrame = [layouter layoutFrameWithRect:(CGRect){.origin = CGPointZero, .size = column1.size} range:NSMakeRange(textRangeInit, 0)];
    textView = [[DTAttributedTextView alloc] initWithFrame:column1];
    [textView setAttributedString:[stringBuilder generatedAttributedString]];
    [[textView attributedTextContentView] setLayoutFrame:layoutFrame];
    [self.vTextContainer addSubview:textView];
    
    //Column2
    
    textRangeInit = [layoutFrame visibleStringRange].location + [layoutFrame visibleStringRange].length;
    if (createAllContent) {
        stringBuilder = [[DTHTMLAttributedStringBuilder alloc] initWithHTML:[text dataUsingEncoding:NSUTF8StringEncoding] options:nil documentAttributes:NULL];
        layouter = [[DTCoreTextLayouter alloc] initWithAttributedString:[stringBuilder generatedAttributedString]];
    }
    layoutFrame = [layouter layoutFrameWithRect:(CGRect){.origin = CGPointZero, .size = column2.size} range:NSMakeRange(textRangeInit, 0)];
    textView = [[DTAttributedTextView alloc] initWithFrame:column2];
    [textView setAttributedString:[stringBuilder generatedAttributedString]];
    [[textView attributedTextContentView] setLayoutFrame:layoutFrame];
    [self.vTextContainer addSubview:textView];
    
    //Column3
    textRangeInit = [layoutFrame visibleStringRange].location + [layoutFrame visibleStringRange].length;
    if (createAllContent) {
        stringBuilder = [[DTHTMLAttributedStringBuilder alloc] initWithHTML:[text dataUsingEncoding:NSUTF8StringEncoding] options:nil documentAttributes:NULL];
        layouter = [[DTCoreTextLayouter alloc] initWithAttributedString:[stringBuilder generatedAttributedString]];
    }
    layoutFrame = [layouter layoutFrameWithRect:(CGRect){.origin = CGPointZero, .size = column3.size} range:NSMakeRange(textRangeInit, 0)];
    textView = [[DTAttributedTextView alloc] initWithFrame:column3];
    [textView setAttributedString:[stringBuilder generatedAttributedString]];
    [[textView attributedTextContentView] setLayoutFrame:layoutFrame];
    [self.vTextContainer addSubview:textView];
}

@end
