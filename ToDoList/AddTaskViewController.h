//
//  AddTaskViewController.h
//  ToDoList
//
//  Created by Manjula Jonnalagadda on 7/19/15.
//  Copyright (c) 2015 Manjula Jonnalagadda. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Task;

@protocol AddTaskViewControllerDelegate <NSObject>

-(void)addTask:(Task *)task;

@end

@interface AddTaskViewController : UIViewController

@property(nonatomic,weak)id<AddTaskViewControllerDelegate> delegate;


@end
