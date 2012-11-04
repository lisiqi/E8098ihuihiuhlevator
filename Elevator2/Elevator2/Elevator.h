//
//  Elevator.h
//  Elevator2
//
//  Created by lisiqi on 12-10-28.
//  Copyright (c) 2012年 lisiqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Elevator : NSObject

//@property (nonatomic)int atFloor;//电梯自身所在的楼层
//@property (nonatomic)int state;//电梯的状态。0:停。1:上。-1:下。

@property (atomic)int atFloor;//电梯自身所在的楼层
@property (atomic)int state;//电梯的状态。0:停。1:上。-1:下。
-(void)initElevator;

// 修改私有任务列表的函数.uod=-1：加下，uod=1:加上
//电梯内外的按键都通过这个函数
-(void)setTask:(int)uod aim:(int)floor;

//任务完成则置0
-(void)isFinishTaskThenSetOk:(int)parkFloor;

//是否有任务
-(bool)isExistTask;

//从atfloor到top是否有上
-(bool)fromCurrentFloorToTopHaveUp;
//从atfloor到top是否有下
-(bool)fromCurrentFloorToTopHaveDown;
//从atfloor到bottom是否有上
-(bool)fromCurrentFloorToBottomHaveUp;
//从atfloor到bottom是否有下
-(bool)fromCurrentFloorToBottomHaveDown;

//电梯执行私有任务
-(void)doPrivateTasks;


@end
