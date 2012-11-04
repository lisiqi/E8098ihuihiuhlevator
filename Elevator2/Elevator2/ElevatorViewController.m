//
//  ElevatorViewController.m
//  Elevator2
//
//  Created by lisiqi on 12-10-24.
//  Copyright (c) 2012年 lisiqi. All rights reserved.
//

#import "ElevatorViewController.h"

@interface ElevatorViewController ()
{
    NSArray *labelCollection1;//为什么需要写这个
}
@property (nonatomic,strong) Elevator *elevator1;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

@property (nonatomic,retain) IBOutletCollection(UILabel) NSArray *labelCollection1;



@end

@implementation ElevatorViewController

@synthesize scrollview;
@synthesize elevator1 = _elevator1;
@synthesize labelCollection1 = _labelCollection1;

-(NSArray *)labelCollection1
{
    if(_labelCollection1 == nil)
        _labelCollection1 = [[NSArray alloc]init];
    return _labelCollection1;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scrollview.contentSize = CGSizeMake(5000, 800);
    
    
    self.elevator1 = [[Elevator alloc]init];
    [self.elevator1 initElevator];


    [self multiThreads];
   // __block UIViewController<FromMasterToDetail> *elecontroller = self;
    //???????????????????????????????????????????????
//    dispatch_async(dispatch_get_global_queue(0, 0), ^
//    {
//        while(1)
//        {
//            dispatch_sync(dispatch_get_main_queue(), ^{
//            });
//            
//            [self.elevator1 doPrivateTasks];//????
//        }
//
//            
//                    
//    });
//    dispatch_async(dispatch_get_global_queue(0, 0), ^
//    {
//        while (1)
//        {
//           // [self.elevator1 doPrivateTasks];//????
//            dispatch_sync(dispatch_get_main_queue(), ^{
//            
//                [self runAndChangeColor];
//               // [NSThread sleepForTimeInterval:1.0f];
//         
//            
//            }
//                          );
//            
//        }
//    });

   // self.labelCollection1
     
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setScrollview:nil];

    [super viewDidUnload];
 
    // Release any retained subviews of the main view.
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
   return  YES;
}


// 实现协议
-(void)receivedState:(int) state
       receivedFloor:(int) floor
{
    [self.elevator1 setTask:state aim:floor];
    
    //[self multiThreads];
}

//处理电梯内的按键,添加到私有任务列表
//判断电梯内按键与电梯实际位置的相对关系
-(IBAction)addTaskFromInside:(UIButton *)sender
{
    int toFloor = [[sender currentTitle] intValue];
    
    if(self.elevator1.atFloor < toFloor)
        [self.elevator1 setTask:1 aim:toFloor-1];
    if(self.elevator1.atFloor > toFloor)
        [self.elevator1 setTask:-1 aim:toFloor-1];
    
   // [self multiThreads];
}

// 实时检索atfloor的值，处理label的变色//独立出来
//线程！！！！！！！！！！！！！！！！！！！！！！！！

-(void)runAndChangeColor
{
    UILabel *lable = [[UILabel alloc]init] ;
    for (UILabel* floorLable in self.labelCollection1) {
       // NSLog(@"%d",[floorLable.text intValue]);
        if(self.elevator1.atFloor == [floorLable.text intValue]
           )
        {
            lable = floorLable;
            //NSLog(@"%d",[floorLable.text intValue]);
            //floorLable.backgroundColor = [UIColor redColor];
            floorLable.backgroundColor = [UIColor redColor];
        }else{
            floorLable.backgroundColor = [UIColor blueColor];
        }
    }
    
    //lable.backgroundColor = [UIColor redColor];
}

-(void)multiThreads
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^
                   {
                       while(1)
                       {
                           dispatch_sync(dispatch_get_main_queue(), ^{
                           });
                           
                           [self.elevator1 doPrivateTasks];//????
                       }
                       
                       
                       
                   });
    dispatch_async(dispatch_get_global_queue(0, 0), ^
                   {
                       while (1)
                       {
                           // [self.elevator1 doPrivateTasks];//????
                           dispatch_sync(dispatch_get_main_queue(), ^{
                               
                               [self runAndChangeColor];
                               // [NSThread sleepForTimeInterval:1.0f];
                               
                               
                           }
                                         );
                           
                       }
                   });

}










@end
