//
//  TakeElevatorTableViewController.h
//  Elevator2
//
//  Created by lisiqi on 12-10-24.
//  Copyright (c) 2012年 lisiqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ElevatorViewController.h"
#import "Elevator.h"
#import "FromMasterToDetail.h"


@interface TakeElevatorTableViewController : UITableViewController<UISplitViewControllerDelegate>

@property (nonatomic, weak) IBOutlet id <FromMasterToDetail> dataSource;

@end
