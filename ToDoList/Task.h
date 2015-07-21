//
//  Task.h
//  ToDoList
//
//  Created by Manjula Jonnalagadda on 7/19/15.
//  Copyright (c) 2015 Manjula Jonnalagadda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject

@property(nonatomic,copy)NSString *taskName;
@property(nonatomic,copy)NSString *taskDescription;
@property(nonatomic,strong)NSDate *deadLine;

-(id)initWithTaskName:(NSString *)taskName;

-(id)initWithTaskName:(NSString *)taskName andDeadLine:(NSDate *)deadline;

+(Task *)taskWithTaskName:(NSString *)taskName andDeadLine:(NSDate *)deadline;

@end
