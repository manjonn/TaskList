//
//  AddTaskViewController.m
//  ToDoList
//
//  Created by Manjula Jonnalagadda on 7/19/15.
//  Copyright (c) 2015 Manjula Jonnalagadda. All rights reserved.
//

#import "AddTaskViewController.h"
#import "Task.h"

@interface AddTaskViewController (){
    
    NSDateFormatter *_dateFormatter;
    
}
@property (weak, nonatomic) IBOutlet UITextField *taskNameTextField;
@property (weak, nonatomic) IBOutlet UITextView *taskDescriptionTextField;
@property (weak, nonatomic) IBOutlet UIButton *dateButton;
@property (weak, nonatomic) IBOutlet UIToolbar *dateToolBar;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation AddTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dateFormatter=[NSDateFormatter new];
    [_dateFormatter setDateStyle:NSDateFormatterLongStyle];
    if (self.task) {
        self.taskNameTextField.text=self.task.taskName;
        self.taskDescriptionTextField.text=self.task.taskDescription;
        self.datePicker.date=self.task.deadLine;
        [self.dateButton setTitle:[_dateFormatter stringFromDate:self.task.deadLine] forState:UIControlStateNormal];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setTask:(Task *)task{
    _task=task;
    self.taskNameTextField.text=task.taskName;
    self.taskDescriptionTextField.text=task.taskDescription;
    self.datePicker.date=task.deadLine;
}

- (IBAction)dateButtonTapped:(UIButton *)sender {
    
    if ([self.taskDescriptionTextField isFirstResponder]) {
        if (self.taskDescriptionTextField.text.length==0) {
            return;
        }
        [self.taskDescriptionTextField resignFirstResponder];
    }
    if ([self.taskDescriptionTextField isFirstResponder]) {
        [self.taskDescriptionTextField resignFirstResponder];
    }
    self.datePicker.hidden=NO;
    self.dateToolBar.hidden=NO;

}
- (IBAction)save:(UIButton *)sender {
    
    if ([self.taskDescriptionTextField isFirstResponder]) {
        if (self.taskDescriptionTextField.text.length==0) {
            return;
        }
        [self.taskDescriptionTextField resignFirstResponder];
    }
    if ([self.taskDescriptionTextField isFirstResponder]) {
        [self.taskDescriptionTextField resignFirstResponder];
    }
    
    Task *task=[Task new];
    task.taskName=self.taskNameTextField.text;
    task.taskDescription=self.taskDescriptionTextField.text;
    task.deadLine=self.datePicker.date;
    
    if (!self.task) {
        if ([self.delegate respondsToSelector:@selector(addTask:)]) {
            [self.delegate addTask:task];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(replaceTask:withTask:)]) {
            [self.delegate replaceTask:self.task withTask:task];
        }

    }
    
    [self.navigationController popViewControllerAnimated:YES];

}
- (IBAction)cancelDate:(UIBarButtonItem *)sender {
    
    self.datePicker.hidden=YES;
    self.dateToolBar.hidden=YES;
}
- (IBAction)pickDate:(UIBarButtonItem *)sender {
    
    self.datePicker.hidden=YES;
    self.dateToolBar.hidden=YES;
    NSString *dateSelected=[_dateFormatter stringFromDate:self.datePicker.date];
    [self.dateButton setTitle:dateSelected forState:UIControlStateNormal];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
