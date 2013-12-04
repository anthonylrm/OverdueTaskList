//
//  AMAddTaskViewController.m
//  OverdueTaskList
//
//  Created by Anthony Matteo on 11/22/13.
//  Copyright (c) 2013 Anthony Matteo. All rights reserved.
//

#import "AMAddTaskViewController.h"


@interface AMAddTaskViewController ()

@end

@implementation AMAddTaskViewController

#pragma mark - IBActions

- (IBAction)addTaskBarButtonPressed:(UIBarButtonItem *)sender
{
    if (![self.taskNameTextField.text isEqualToString:@""]) {
        
        [self.delegate didAddTask:[self createTaskFromUI]];

    } else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Required field" message:@"You must supply a task name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}


- (IBAction)cancelBarButtonPressed:(UIBarButtonItem *)sender
{
    [self.delegate didCancel];
}



#pragma mark - helper methods

-(AMTask*)createTaskFromUI
{
    NSDictionary *taskData = @{TASK_NAME: self.taskNameTextField.text, TASK_DESCRIPTION : self.taskDescriptionTextView.text, TASK_DUE_DATE : self.taskDueDatePicker.date, TASK_COMPLETE : [NSNumber numberWithBool:NO]};
    return [[AMTask alloc] initWithData:taskData];
}


#pragma mark - Xcode default methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
