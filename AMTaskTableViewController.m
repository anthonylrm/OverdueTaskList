//
//  AMTaskTableViewController.m
//  OverdueTaskList
//
//  Created by Anthony Matteo on 11/22/13.
//  Copyright (c) 2013 Anthony Matteo. All rights reserved.
//

#import "AMTaskTableViewController.h"
#import "AMTaskDetailViewController.h"

@interface AMTaskTableViewController ()

@end

@implementation AMTaskTableViewController


#pragma mark - Getters - lazy instantiation

-(NSMutableArray*)tasks;
{
    if (!_tasks) {
        
        _tasks = [[NSMutableArray alloc] init];
    }
    return _tasks;
}



#pragma mark - helper methods for Task conversion

-(NSDictionary*)taskObjectAsPropertyList:(AMTask*)task
{
    return @{TASK_NAME : task.name, TASK_DESCRIPTION : task.description, TASK_DUE_DATE : task.dueDate, TASK_COMPLETE : [NSNumber numberWithBool:task.isComplete]};
}

-(AMTask*)taskObjectFromPropertyListData:(NSDictionary*)data
{
    return [[AMTask alloc] initWithData:data];
}



#pragma mark - helper methods for managing storage

-(void)retrieveTasksFromStorage
{
    
    NSArray *storedTaskData = [[NSUserDefaults standardUserDefaults] arrayForKey:STORED_TASKS_ARRAY];
    
    for (NSDictionary* taskDictionary in storedTaskData) {
        
        [self.tasks addObject:[self taskObjectFromPropertyListData:taskDictionary]];
    }

}

-(void)saveAllTasks
{
    NSMutableArray *newTaskListForStorage = [[NSMutableArray alloc] init];
    
    for (AMTask *task in self.tasks) {
        
        [newTaskListForStorage addObject:[self taskObjectAsPropertyList:task]];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:newTaskListForStorage forKey:STORED_TASKS_ARRAY];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

-(void)toggleCompletionStatusOfStoredTaskAtIndex:(NSUInteger)index
{

    NSMutableArray *storedTasks = [[[NSUserDefaults standardUserDefaults] arrayForKey:STORED_TASKS_ARRAY]mutableCopy];
    [storedTasks replaceObjectAtIndex:index withObject:[self taskObjectAsPropertyList:self.tasks[index]]];
    [[NSUserDefaults standardUserDefaults] setObject:storedTasks forKey:STORED_TASKS_ARRAY];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

-(void)deleteStoredTaskAtIndex:(NSUInteger)index
{
    NSMutableArray *storedTasks = [[[NSUserDefaults standardUserDefaults] arrayForKey:STORED_TASKS_ARRAY] mutableCopy];
    [storedTasks removeObjectAtIndex:index];
    [[NSUserDefaults standardUserDefaults] setObject:storedTasks forKey:STORED_TASKS_ARRAY];
    [[NSUserDefaults standardUserDefaults]synchronize];

}


#pragma mark - AddTask delegate

-(void)didCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)didAddTask:(AMTask *)task
{
    //Add to property
    [self.tasks insertObject:task atIndex:0];
    
    //Persist
    NSMutableArray *storedTaskData = [[[NSUserDefaults standardUserDefaults] arrayForKey:STORED_TASKS_ARRAY] mutableCopy];
    if (!storedTaskData) storedTaskData = [[NSMutableArray alloc] init];
    [storedTaskData insertObject:[self taskObjectAsPropertyList:task] atIndex:0];
    [[NSUserDefaults standardUserDefaults] setObject:storedTaskData forKey:STORED_TASKS_ARRAY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tableView reloadData];
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.tasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    AMTask *task = self.tasks[indexPath.row];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    // Configure the cell...
    cell.textLabel.text = task.name;
    cell.detailTextLabel.text = [formatter stringFromDate: task.dueDate];
    //cell.tintColor = [UIColor redColor];
 
    if (task.isComplete) {
        
        cell.backgroundColor = [UIColor lightGrayColor];
        cell.textLabel.textColor = [UIColor grayColor];
        cell.detailTextLabel.textColor = [UIColor grayColor];
    }
    else {
        
        cell.textLabel.textColor = [UIColor blackColor];
        cell.detailTextLabel.textColor = [UIColor blackColor];
        
        if ([task.dueDate timeIntervalSinceNow] < 0) {
        
            cell.backgroundColor = [UIColor redColor];
    
        } else {
        
        cell.backgroundColor = [UIColor yellowColor];
        
        }
    }
    //[self thisDate:task.dueDate isAfterThatDate:[NSDate date]];
    return cell;
}



#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    AMTask *task = self.tasks[indexPath.row];
    task.isComplete = !task.isComplete;
    
    [self toggleCompletionStatusOfStoredTaskAtIndex:indexPath.row];

    [self.tableView reloadData];
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"toTaskDetailVC" sender: indexPath];
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.tasks removeObjectAtIndex:indexPath.row];
        
        [self deleteStoredTaskAtIndex:indexPath.row];

        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSUInteger oldIndex = fromIndexPath.row;
    NSUInteger newIndex = toIndexPath.row;
    
    //insert the object at a new location
    if (newIndex == [self.tasks count]-1) {
        
        [self.tasks addObject:[self.tasks objectAtIndex:oldIndex]];
        
    } else {
        
        [self.tasks insertObject:[self.tasks objectAtIndex:oldIndex] atIndex:newIndex];

    }
    
    if (newIndex < oldIndex) oldIndex ++;
    
    [self.tasks removeObjectAtIndex:oldIndex];
    
    //Persist new list order
    [self saveAllTasks];
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}



#pragma mark -  Navigation Controller Delegate

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //NSLog(@"%@", [navigationController.topViewController class]);
    
    if ([viewController isEqual:self]) {
        
        //if ([navigationController.topViewController isKindOfClass:[AMTaskDetailViewController class]]) {
            
            [self saveAllTasks];
        //}
        [self.tableView reloadData];
    }
}



#pragma mark - Xcode default methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self retrieveTasksFromStorage];
    
    self.navigationController.delegate = self;
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
//    self.tableView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}



#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"toAddTaskVC"] && [segue.destinationViewController isKindOfClass:[AMAddTaskViewController class]]) {
        
        AMAddTaskViewController *nextViewController = segue.destinationViewController;
        nextViewController.delegate = self;
        
    } else if ([segue.identifier isEqualToString:@"toTaskDetailVC"] && [segue.destinationViewController isKindOfClass:[AMTaskDetailViewController class]]) {
        
        AMTaskDetailViewController *nextViewController = segue.destinationViewController;
        NSIndexPath *indexPath = sender;
        nextViewController.task = self.tasks[indexPath.row];
        
    }
    
    
}


#pragma mark - IBActions

- (IBAction)addTaskBarButtonPressed:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"toAddTaskVC" sender:sender];
}

- (IBAction)reorderBarButtonpressed:(UIBarButtonItem *)sender {

    if (self.tableView.editing) {
        
        sender.title = @"Reorder";
        [self.tableView setEditing:NO animated:YES];
        
    } else {
     
        sender.title = @"Done";
        [self.tableView setEditing:YES animated:YES];
    }
}
@end
