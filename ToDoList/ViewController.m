//
//  ViewController.m
//  ToDoList
//
//  Created by Manjula Jonnalagadda on 7/19/15.
//  Copyright (c) 2015 Manjula Jonnalagadda. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITextFieldDelegate,UITableViewDelegate>

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
    self.editingIndex=-1;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tasks.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"taskCell" forIndexPath:indexPath];
    cell.textLabel.text=self.tasks[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDataSource
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
        
        weakself.editingIndex=indexPath.row;
        weakself.taskTextField.text=weakself.tasks[indexPath.row];
        [weakself.taskTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];

        
    }];
    
    return @[deleteAction,editAction];
    
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

@end
