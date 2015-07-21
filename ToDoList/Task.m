//
//  Task.m
//  ToDoList
//
//  Created by Manjula Jonnalagadda on 7/19/15.
//  Copyright (c) 2015 Manjula Jonnalagadda. All rights reserved.
//

#import "Task.h"

@interface Task()

@end

@implementation Task

-(id)init{
    self=[super init];
    return self;
}

-(id)initWithTaskName:(NSString *)taskName{
    self=[super init];
    if (self) {
        
        self.taskName=taskName;
        
    }
    return self;
}

-(id)initWithTaskName:(NSString *)taskName andDeadLine:(NSDate *)deadline{
    self=[super init];
    if (self) {
        
        self.taskName=taskName;
        self.deadLine=deadline;
    }
    return self;

}

+(Task *)taskWithTaskName:(NSString *)taskName andDeadLine:(NSDate *)deadline{
    Task *task;
    if (deadline) {
        task=[[Task alloc]initWithTaskName:taskName andDeadLine:deadline];
    }else{
        task=[[Task alloc]initWithTaskName:taskName];
    }
//    Task *task=[[Task alloc]initWithTaskName:taskName andDeadLine:deadline];
    return task;
}


@end
