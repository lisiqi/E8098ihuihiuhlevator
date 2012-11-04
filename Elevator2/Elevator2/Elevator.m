//
//  Elevator.m
//  Elevator2
//
//  Created by lisiqi on 12-10-28.
//  Copyright (c) 2012年 lisiqi. All rights reserved.
//

#import "Elevator.h"

@interface Elevator()
{
    int privateTask[2][20] ;//私有任务列表
}
@end

@implementation Elevator

@synthesize atFloor = _atFloor;
@synthesize state = _state;

-(void)initElevator
{
    for(int i=0;i<2;i++)
        for(int j=0;j<20;j++){
            privateTask[i][j]=0;
        }
    self.state = 0;
    self.atFloor = 1;
}

// 修改私有任务列表的函数.uod=-1：加下，uod=1:加上
//电梯内外的按键都通过这个函数
-(void)setTask:(int)uod aim:(int)floor
{
    if(uod == 1) {
        privateTask[0][floor] = 1;
    }
    if(uod == -1) {
        privateTask[1][floor] = 1;
    }
}

-(bool)isExistTask
{
    for(int j=0;j<20;j++)
        if(privateTask[0][j] == 1)
            return YES;
    for(int j=0;j<20;j++)
        if(privateTask[1][j] == 1)
            return YES;
    return NO;
}

//从atfloor到top是否有上//考虑次序。atfloor不是对应数组顺序！！！！
-(bool)fromCurrentFloorToTopHaveUp
{
    for(int j=self.atFloor;j<20;j++)
        if(privateTask[0][j] == 1)
            return YES;
    return NO;
}
//从atfloor到top是否有下
-(bool)fromCurrentFloorToTopHaveDown
{
    for(int j=self.atFloor;j<20;j++)
        if(privateTask[1][j] == 1)
            return YES;
    return NO;
}
//从atfloor到bottom是否有上
-(bool)fromCurrentFloorToBottomHaveUp
{
    for(int j=self.atFloor-2;j>-1;j--)
        if(privateTask[0][j] == 1)
            return YES;
    return NO;
}
//从atfloor到bottom是否有下
-(bool)fromCurrentFloorToBottomHaveDown
{
    for(int j=self.atFloor-2;j>-1;j--)
        if(privateTask[1][j] == 1)
            return YES;
    return NO;
}

//完成时要开门
-(void)isFinishTaskThenSetOk:(int)parkFloor 
{
    if(self.state == 1 && privateTask[0][parkFloor-1] == 1)
    {
        privateTask[0][parkFloor-1] = 0;
        [NSThread sleepForTimeInterval:1.0f];
    }
    if(self.state == -1 && privateTask[1][parkFloor-1] == 1)
    {
        privateTask[1][parkFloor-1] = 0;
        [NSThread sleepForTimeInterval:1.0f];
    }
    
}

//电梯执行私有任务
-(void)doPrivateTasks
{
    if(self.state == 0)
    {
        if([self fromCurrentFloorToTopHaveUp]) self.state = 1;
        if([self fromCurrentFloorToTopHaveDown]) self.state = 1;
        if([self fromCurrentFloorToBottomHaveUp]) self.state = -1;
        if([self fromCurrentFloorToBottomHaveDown]) self.state = -1;
    }else if(self.state == 1)
    {
        if([self isExistTask] == NO) self.state = 0;
        while([self fromCurrentFloorToTopHaveUp])
        {
            self.atFloor++;
            [NSThread sleepForTimeInterval:0.5f];
            [self isFinishTaskThenSetOk:self.atFloor];
        }
        while ([self fromCurrentFloorToTopHaveDown]) {
            self.atFloor++;
            [NSThread sleepForTimeInterval:0.5f];
        }
        self.state = -1;
        [self isFinishTaskThenSetOk:self.atFloor];//到最高的下
    }else if(self.state == -1)
    {
        if([self isExistTask] == NO) self.state = 0;
        while([self fromCurrentFloorToBottomHaveDown])
        {
            self.atFloor--;
            [NSThread sleepForTimeInterval:0.5f];
            [self isFinishTaskThenSetOk:self.atFloor];
        }
        while ([self fromCurrentFloorToBottomHaveUp]) {
            self.atFloor--;
            [NSThread sleepForTimeInterval:0.5f];
        }
        self.state = 1;
        [self isFinishTaskThenSetOk:self.atFloor];//到最底的上
    }
    if([self isExistTask] == NO) self.state = 0;
}







@end
