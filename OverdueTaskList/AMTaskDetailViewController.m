//
//  AMTaskDetailViewController.m
//  OverdueTaskList
//
//  Created by Anthony Matteo on 11/22/13.
//  Copyright (c) 2013 Anthony Matteo. All rights reserved.
//

#import "AMTaskDetailViewController.h"

@interface AMTaskDetailViewController ()

@end

@implementation AMTaskDetailViewController


#pragma mark - helper methods
-(void)synchronizeViewWithTask
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    self.taskNameLabel.text = self.task.name;
    self.taskDescription.text = self.task.description;
    self.taskDueDateLabel.text = [formatter stringFromDate: self.task.dueDate];
    if (self.task.isComplete) {
        self.taskStatusLabel.text = @"Complete";
    } else {
        self.taskStatusLabel.text = @"Pending";
    }

}

#pragma mark - EditTask delegate

-(void)didSaveEditing
{
    
    [self synchronizeViewWithTask];
    [self.navigationController popViewControllerAnimated:YES];

}





#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"toEditTaskVC"]) {
        
        AMEditTaskViewController *nextVC = segue.destinationViewController;
        nextVC.delegate = self;
        nextVC.task = self.task;
    }
    
    
}



#pragma mark - Xcode default methods


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.taskDescription.backgroundColor = [UIColor whiteColor];
    [self synchronizeViewWithTask];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark - IBActions

- (IBAction)editTaskBarButtonPressed:(UIBarButtonItem *)sender {

    [self performSegueWithIdentifier:@"toEditTaskVC" sender:sender];
}
@end
