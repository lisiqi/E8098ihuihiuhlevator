//
//  TakeElevatorTableViewController.m
//  Elevator2
//
//  Created by lisiqi on 12-10-24.
//  Copyright (c) 2012年 lisiqi. All rights reserved.
//

#import "TakeElevatorTableViewController.h"

@interface TakeElevatorTableViewController ()
{
    int publicTask[2][20] ;//公有任务列表
}

//显示颜色变化的时候，可能用到
@property (nonatomic,retain) IBOutletCollection(UIButton) NSArray *upButtonCollection;
@property (nonatomic,retain) IBOutletCollection(UIButton) NSArray *downButtonCollection;

@end

@implementation TakeElevatorTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    for(int i=0;i<2;i++)
        for(int j=0;j<20;j++){
            publicTask[i][j]=0;
        }

    self.dataSource = [self.splitViewController.viewControllers lastObject];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.splitViewController.delegate = self;
    //self. = UIInterfaceOrientationLandscapeLeft;
}

-(BOOL)splitViewController:(UISplitViewController *)svc
  shouldHideViewController:(UIViewController *)vc
             inOrientation:(UIInterfaceOrientation)orientation
{
    
    return  NO;
}

-(void)splitViewController:(UISplitViewController *)svc
    willHideViewController:(UIViewController *)aViewController
         withBarButtonItem:(UIBarButtonItem *)barButtonItem
      forPopoverController:(UIPopoverController *)pc
{
    
    // [self splitViewBarButtonItemPresenter].splitViewBarButtonItem = barButtonItem;
}

-(void)splitViewController:(UISplitViewController *)svc
    willShowViewController:(UIViewController *)aViewController
 invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    
    // [self splitViewBarButtonItemPresenter].splitViewBarButtonItem = nil;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return ((toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown)&&(toInterfaceOrientation != UIInterfaceOrientationPortrait));
}

-(void)setPublicTask:(int)uod aim:(int)floor
{
    if(uod == 1) {
        publicTask[0][floor] = 1;
    }
    if(uod == -1) {
        publicTask[1][floor] = 1;
    }
}

//把公有任务分配给电梯，完成电梯调度。一旦分配过，任务置0.
//只有一个电梯时，全部拷贝
//多电梯 需要改进！！！！！！！！！！！！！！！！！！！！！！！！！！！！
-(void)elevatorScheduling
{
    for(int j=0;j<20;j++)
        if(publicTask[0][j]==1)
        {
            [self.dataSource receivedState:1 receivedFloor:j];
            publicTask[0][j]=0;
        }
    for(int j=0;j<20;j++)
        if(publicTask[1][j]==1)
        {
            [self.dataSource receivedState:-1 receivedFloor:j];
            publicTask[1][j]=0;
        }  
}

//处理按键
//添加到公有任务列表，一旦添加进行任务分配
-(IBAction)addPublicTask:(UIButton *)sender
{
    UITableViewCell *cell = (UITableViewCell*)[[sender superview]superview];    //静态Cell也是两个superView！！！
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSInteger row = [indexPath row];
    if([[sender currentTitle] isEqualToString:@"up"]){     //....
        [self setPublicTask:1 aim:(20-row-1)];
    }
    if([[sender currentTitle] isEqualToString:@"down"]){
        [self setPublicTask:-1 aim:(20-row-1)];
    }
    //调用elevatorScheduling
    [self elevatorScheduling];
}


#pragma mark - Table view data source

//适用于动态Cell。静态Cell全删即可

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 20;
//}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"floor1";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if(cell == nil){
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//    // Configure the cell...
//    //将来处理cell中button 的变色。
//    return cell;
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}

@end