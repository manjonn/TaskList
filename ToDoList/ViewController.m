//
//  ViewController.m
//  ToDoList
//
//  Created by Manjula Jonnalagadda on 7/19/15.
//  Copyright (c) 2015 Manjula Jonnalagadda. All rights reserved.
//

#import "ViewController.h"
#import "AddTaskViewController.h"
#import "TaskTableViewCell.h"
#import "Task.h"

@interface ViewController ()<UITableViewDataSource,UITextFieldDelegate,UITableViewDelegate,AddTaskViewControllerDelegate>{
    
    NSDateFormatter *_dateFormatter;
    
}


///NSArray is static array NSMutableArray Objects can be added and removed.
@property(nonatomic,strong)NSMutableArray *tasks;
@property (weak, nonatomic) IBOutlet UITableView *taskTableView;
@property(nonatomic,assign)NSInteger editingIndex;
@property (weak, nonatomic) IBOutlet UITextField *taskTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tasks=[NSMutableArray array];
    _dateFormatter=[NSDateFormatter new];
    [_dateFormatter setDateStyle:NSDateFormatterLongStyle];
    self.editingIndex=-1;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.destinationViewController isKindOfClass:[AddTaskViewController class]]) {
        AddTaskViewController *addTaskViewController=segue.destinationViewController;
        addTaskViewController.delegate=self;
    }
    
}

-(CGFloat)estimatedHeightForRow:(NSInteger)row{
    
    CGFloat ht=50;
    Task *task=self.tasks[row];
    if (task.taskDescription.length>0) {
        CGRect rect=[task.taskDescription boundingRectWithSize:CGSizeMake(self.view.frame.size.width-30, INFINITY) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0]} context:nil];
        ht+=rect.size.height+10;
    }
    return ht;
}


#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tasks.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TaskTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"taskCell" forIndexPath:indexPath];
    Task *task=self.tasks[indexPath.row];
    cell.taskNameLabel.text=task.taskName;
    cell.taskDescriptionLabel.text=task.taskDescription;
    cell.deadLineLabel.text=[_dateFormatter stringFromDate:task.deadLine];
    return cell;
}

#pragma mark - UITableViewDelegate
/*
 //Use for pre-iOS 8 versions

 -(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
 */

/*
 
 
 
*/

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    /*
     //Use for pre-iOS 8 versions

     if (UITableViewCellEditingStyleDelete) {
        [self.tasks removeObjectAtIndex:indexPath.row];
        [self.taskTableView reloadData];
    }
     */
}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    __weak typeof(self) weakself=self;
    
    UITableViewRowAction *deleteAction=[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"Delete" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
        [weakself.tasks removeObjectAtIndex:indexPath.row];
        [weakself.taskTableView reloadData];
        
    }];
    
    UITableViewRowAction *editAction=[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Edit" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
        AddTaskViewController *taskViewController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"AddTaskViewController"];
        taskViewController.delegate=self;
        [self.navigationController pushViewController:taskViewController animated:YES];
        taskViewController.task=self.tasks[indexPath.row];
        [weakself.taskTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];

        
    }];
    
    return @[deleteAction,editAction];
    
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self estimatedHeightForRow:indexPath.row];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self estimatedHeightForRow:indexPath.row];
    
}



#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.text.length==0) {
        return NO;
    }
    if (self.editingIndex<0) {
        [self.tasks addObject:textField.text];
    }else{
        [self.tasks replaceObjectAtIndex:self.editingIndex withObject:textField.text];
    }
    [self.taskTableView reloadData];
    textField.text=@"";
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - AddTaskViewControllerDelegate

-(void)addTask:(Task *)task{
    
    [self.tasks addObject:task];
    [self.taskTableView reloadData];
    
}

-(void)replaceTask:(Task *)task withTask:(Task *)anotherTask{
    NSInteger index=[self.tasks indexOfObject:task];
    
    [self.tasks replaceObjectAtIndex:index withObject:anotherTask];
    [self.taskTableView reloadData];
}

@end
