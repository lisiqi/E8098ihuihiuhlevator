//
//  FromMasterToDetail.h
//  Elevator2
//
//  Created by lisiqi on 12-10-31.
//  Copyright (c) 2012年 lisiqi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TakeElevatorTableViewController.h"


@protocol FromMasterToDetail

-(void)receivedState:(int) state
       receivedFloor:(int) floor;

@end