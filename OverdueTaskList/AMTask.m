//
//  AMTask.m
//  OverdueTaskList
//
//  Created by Anthony Matteo on 11/23/13.
//  Copyright (c) 2013 Anthony Matteo. All rights reserved.
//

#import "AMTask.h"

@implementation AMTask


//Designated initializer
-(id)initWithData:(NSDictionary*)data
{
    self = [super init];
    if (self) {
        _name = data[TASK_NAME];
        _description = data[TASK_DESCRIPTION];
        _dueDate = data[TASK_DUE_DATE];
        _isComplete = [data[TASK_COMPLETE] boolValue];
    }
    
    return self;
}

-(id)init
{
    return [self initWithData:nil];
}
@end
