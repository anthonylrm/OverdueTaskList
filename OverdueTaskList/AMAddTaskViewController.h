//
//  AMAddTaskViewController.h
//  OverdueTaskList
//
//  Created by Anthony Matteo on 11/22/13.
//  Copyright (c) 2013 Anthony Matteo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMTask.h"

@protocol AMAddTaskViewControllerDelegate <NSObject>

@required

-(void)didCancel;
-(void)didAddTask:(AMTask*)task;

@end

@interface AMAddTaskViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) id <AMAddTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *taskNameTextField;
@property (strong, nonatomic) IBOutlet UITextView *taskDescriptionTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *taskDueDatePicker;


- (IBAction)addTaskBarButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)cancelBarButtonPressed:(UIBarButtonItem *)sender;

@end
