//
//  AMTask.h
//  OverdueTaskList
//
//  Created by Anthony Matteo on 11/23/13.
//  Copyright (c) 2013 Anthony Matteo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMTask : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSDate *dueDate;
@property (nonatomic) BOOL isComplete;


-(id)initWithData:(NSDictionary*)data;
@end
