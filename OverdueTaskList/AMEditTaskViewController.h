//
//  AMEditTaskViewController.h
//  OverdueTaskList
//
//  Created by Anthony Matteo on 11/22/13.
//  Copyright (c) 2013 Anthony Matteo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMTask.h"

@protocol AMEditTaskViewController <NSObject>

@required

//-(void)didCancelEditing;
-(void)didSaveEditing;

@end



@interface AMEditTaskViewController : UIViewController

@property (weak, nonatomic) id <AMEditTaskViewController> delegate;

@property (strong, nonatomic) AMTask *task;

@property (strong, nonatomic) IBOutlet UITextField *taskNameTextField;
@property (strong, nonatomic) IBOutlet UITextView *taskDescriptionTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *taskDueDatePicker;


- (IBAction)saveBarButtonPressed:(UIBarButtonItem *)sender;

@end
