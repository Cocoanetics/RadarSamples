//
//  Message.h
//  relationbug
//
//  Created by Oliver Drobnik on 6/25/12.
//  Copyright (c) 2012 Cocoanetics. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Timeline;

@interface Message : NSManagedObject

@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSSet *timelines;
@property (nonatomic, retain) NSDate * creationDate;
@end

@interface Message (CoreDataGeneratedAccessors)

- (void)addTimelinesObject:(Timeline *)value;
- (void)removeTimelinesObject:(Timeline *)value;
- (void)addTimelines:(NSSet *)values;
- (void)removeTimelines:(NSSet *)values;

@end
