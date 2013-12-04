//
//  AMEditTaskViewController.m
//  OverdueTaskList
//
//  Created by Anthony Matteo on 11/22/13.
//  Copyright (c) 2013 Anthony Matteo. All rights reserved.
//

#import "AMEditTaskViewController.h"

@interface AMEditTaskViewController ()

@end

@implementation AMEditTaskViewController

#pragma mark - IBActions

- (IBAction)saveBarButtonPressed:(UIBarButtonItem *)sender {
    
    self.task.name = self.taskNameTextField.text;
    self.task.description = self.taskDescriptionTextView.text;
    self.task.dueDate = self.taskDueDatePicker.date;
    [self.delegate didSaveEditing];
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
    
    self.taskNameTextField.text = self.task.name;
    self.taskDescriptionTextView.text = self.task.description;
    self.taskDueDatePicker.date = self.task.dueDate;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
