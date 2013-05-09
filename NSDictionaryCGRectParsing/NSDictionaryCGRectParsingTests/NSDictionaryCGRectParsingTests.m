//
//  NSDictionaryCGRectParsingTests.m
//  NSDictionaryCGRectParsingTests
//
//  Created by Stefan Gugarel on 9/24/12.
//  Copyright (c) 2012 Cocoanetics. All rights reserved.
//

#import "NSDictionaryCGRectParsingTests.h"

@implementation NSDictionaryCGRectParsingTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testOriginalPlist {

    NSBundle *testBundle = [NSBundle bundleForClass:[self class]];
    NSString *finalPath = [testBundle pathForResource:@"rect" ofType:@"plist"];
    NSDictionary *plistData = [NSDictionary dictionaryWithContentsOfFile:finalPath];
    
    CGRect rect = CGRectZero;
    
    BOOL success = CGRectMakeWithDictionaryRepresentation((__bridge CFDictionaryRef)[plistData objectForKey:@"Frame"], &rect);
    
    STAssertTrue(success, @"dicitionary parsing did finish with failure");
    
    NSLog(@"rect: %@", NSStringFromCGRect(rect));
    
    
}

- (void)testMofiedPlistByXCode {

    NSBundle *testBundle = [NSBundle bundleForClass:[self class]];
    NSString *finalPath = [testBundle pathForResource:@"rect_modified_by_xcode45" ofType:@"plist"];
    NSDictionary *plistData = [NSDictionary dictionaryWithContentsOfFile:finalPath];
    
    CGRect rect = CGRectZero;
    
    BOOL success = CGRectMakeWithDictionaryRepresentation((__bridge CFDictionaryRef)[plistData objectForKey:@"Frame"], &rect);
    
    STAssertTrue(success, @"Dictionary parsing did finish with failure, result %@", NSStringFromCGRect(rect));
}

- (void)testParseRealString
{
    NSString *string = @"123.2112731933594";
    
    float f = [string floatValue];
    double d = [string doubleValue];
    
    STAssertTrue(f>0, @"Float could not be parsed");
    
    STAssertTrue(d>0, @"Double could not be parsed");
}


- (void)testRectMake
{
    CGRect rect = CGRectMake(123.2112731933594, 123.2112731933594, 123.2112731933594, 123.2112731933594);
    
    STAssertTrue(rect.origin.x>0, @"Origin.x is 0");
    STAssertTrue(rect.origin.y>0, @"Origin.y is 0");
    STAssertTrue(rect.size.width>0, @"Size.width is 0");
    STAssertTrue(rect.size.height>0, @"Size.height is 0");
    
    NSDictionary *dict = (__bridge_transfer NSDictionary *)CGRectCreateDictionaryRepresentation(rect);
    
    NSData *data = [NSPropertyListSerialization dataFromPropertyList:dict format:NSPropertyListXMLFormat_v1_0 errorDescription:NULL];
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    // fake the 594 at the end instead of the 5938
    NSString *hackedString = [string stringByReplacingOccurrencesOfString:@"<" withString:@"594<"];
    
    NSData *hackedData = [hackedString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *hackedDict = [NSPropertyListSerialization propertyListFromData:hackedData mutabilityOption:NSPropertyListImmutable format:NULL errorDescription:NULL];
    
    // try to parse that
    CGRect hackedRect = CGRectZero;
    BOOL success = CGRectMakeWithDictionaryRepresentation((__bridge CFDictionaryRef)hackedDict, &hackedRect);
    
    STAssertTrue(success, @"Dictionary parsing did finish with failure, result %@", NSStringFromCGRect(hackedRect));
}

@end
