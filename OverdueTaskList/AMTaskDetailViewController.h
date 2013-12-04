//
//  AMTaskDetailViewController.h
//  OverdueTaskList
//
//  Created by Anthony Matteo on 11/22/13.
//  Copyright (c) 2013 Anthony Matteo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMEditTaskViewController.h"
#import "AMTask.h"

@interface AMTaskDetailViewController : UIViewController <AMEditTaskViewController>

@property (strong, nonatomic) AMTask *task;

@property (strong, nonatomic) IBOutlet UILabel *taskNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *taskDueDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *taskDescription;
@property (strong, nonatomic) IBOutlet UILabel *taskStatusLabel;


- (IBAction)editTaskBarButtonPressed:(UIBarButtonItem *)sender;
@end
