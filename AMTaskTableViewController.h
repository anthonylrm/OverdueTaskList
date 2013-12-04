//
//  AMTaskTableViewController.h
//  OverdueTaskList
//
//  Created by Anthony Matteo on 11/22/13.
//  Copyright (c) 2013 Anthony Matteo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMAddTaskViewController.h"

@interface AMTaskTableViewController : UITableViewController <AMAddTaskViewControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) NSMutableArray *tasks;

- (IBAction)addTaskBarButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)reorderBarButtonpressed:(UIBarButtonItem *)sender;
@end
