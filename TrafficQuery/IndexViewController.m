//
//  IndexViewController.m
//  TrafficQuery
//
//  Created by hz on 13-4-11.
//  Copyright (c) 2013年 hz. All rights reserved.
//
/*
 在- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 加cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"XXX.png"]];
 */
#import "IndexViewController.h"
#import "IndexCarCell.h"
#import "AddButtonCell.h"
#import "HomeIntroduce.h"
#import "CarInfoListViewController.h"
#import "carCommon.h"
#import "LoginViewController.h"
#import "AboutUSViewController.h"
#import "CarManager.h"
#import "UserViewController.h"



#define CARLISTFILEPATH [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/CarList.plist"]

@interface IndexViewController ()

@end

@implementation IndexViewController
@synthesize carDictionary;
@synthesize mainTableView;
@synthesize addCarViewController;
@synthesize carInfoListViewController;

@synthesize carMutableArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.mainTableView.scrollEnabled = NO;
    //景
    btn_shade = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [btn_shade addTarget:self action:@selector(setting_pressed:) forControlEvents:UIControlEventTouchDown];
    [btn_shade setBackgroundColor:[UIColor blackColor]];
    btn_shade.alpha = 0.5;
    [self.view addSubview:btn_shade];
    btn_shade.hidden = YES;
    show = YES;
    newView = [[view alloc] initWithFrame:CGRectMake(0, 0, 320,480)];
    newView.backgroundColor = [UIColor clearColor];
    
    //右边的目录
    rightView=[[UIView alloc]initWithFrame:CGRectMake(320, 0, 120, 460)];
    [rightView setBackgroundColor:[UIColor clearColor]];
    UIImage *image=[UIImage imageNamed:@"choose.png"];
    UIImageView *imageview=[[UIImageView alloc]initWithImage:image];
    imageview.frame=CGRectMake(0, 0, 120, 460);
    
    UIButton *carManagerButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 120, 70)];
    [carManagerButton setTitle:@"车辆管理" forState:UIControlStateNormal];
    [carManagerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [carManagerButton setBackgroundImage:[UIImage imageNamed:@"set_top_n.png"] forState:UIControlStateNormal];
    [carManagerButton setBackgroundImage:[UIImage imageNamed:@"set_top_p.png"] forState:UIControlStateSelected];
    [carManagerButton addTarget:self action:@selector(managerCars:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *remindButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 69, 120, 70)];
    [remindButton setTitle:@"提醒设置" forState:UIControlStateNormal];
    [remindButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [remindButton setBackgroundImage:[UIImage imageNamed:@"set_middle_n.png"] forState:UIControlStateNormal];
    [remindButton setBackgroundImage:[UIImage imageNamed:@"set_middle_p.png"] forState:UIControlStateSelected];
    
    UIButton *userInfButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 138, 120, 70)];
    [userInfButton setTitle:@"个人信息" forState:UIControlStateNormal];
    [userInfButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [userInfButton setBackgroundImage:[UIImage imageNamed:@"set_middle_n.png"] forState:UIControlStateNormal];
    [userInfButton setBackgroundImage:[UIImage imageNamed:@"set_middle_p.png"] forState:UIControlStateSelected];
    [userInfButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *shareButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 460-139, 120, 70)];
    [shareButton setTitle:@"分享给朋友" forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shareButton setBackgroundImage:[UIImage imageNamed:@"set_middle_n.png"] forState:UIControlStateNormal];
    [shareButton setBackgroundImage:[UIImage imageNamed:@"set_middle_p.png"] forState:UIControlStateSelected];
    
    UIButton *aboutUSButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 460-70, 120, 70)];
    [aboutUSButton setTitle:@"关于我们" forState:UIControlStateNormal];
    [aboutUSButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [aboutUSButton setBackgroundImage:[UIImage imageNamed:@"set_bottom_n.png"] forState:UIControlStateNormal];
    [aboutUSButton setBackgroundImage:[UIImage imageNamed:@"set_buttom_p.png"] forState:UIControlStateSelected];
    [aboutUSButton addTarget:self action:@selector(aboutUS:) forControlEvents:UIControlEventTouchUpInside];
    
    [rightView addSubview:imageview];
    [rightView addSubview:carManagerButton];
    [rightView addSubview:remindButton];
    [rightView addSubview:userInfButton];
    [rightView addSubview:shareButton];
    [rightView addSubview:aboutUSButton];
    
    [carManagerButton release];
    [remindButton release];
    [userInfButton release];
    [shareButton release];
    [aboutUSButton release];
    [imageview release];
    [self.view addSubview:rightView];
    
    
    [self initMainTableView];
}
-(void)initMainTableView{
    NSFileManager* fileManage = [NSFileManager defaultManager];
    if(![fileManage fileExistsAtPath:CARLISTFILEPATH]){
        [fileManage createFileAtPath:CARLISTFILEPATH contents:nil attributes:nil];
    }
    
    self.carMutableArray = [NSMutableArray arrayWithContentsOfFile:CARLISTFILEPATH];
    NSLog(@"self.carMutableArray = %@", self.carMutableArray);
}
//TableViewController
-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 1)
    {
        return 1;
        
    }
    if([[NSMutableArray arrayWithContentsOfFile:CARLISTFILEPATH] count] > 3)
    {
        self.mainTableView.scrollEnabled = YES;
    }
    
    return [[NSMutableArray arrayWithContentsOfFile:CARLISTFILEPATH] count];

}
-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell;
    if(indexPath.section == 0)
    {
        cell = (IndexCarCell*)[tableView dequeueReusableCellWithIdentifier:@"IndexCell"];
    
    if(!cell)
     {
         cell = [[[NSBundle mainBundle] loadNibNamed:@"IndexCarCell" owner:self options:nil] lastObject];
     }
        NSString* tempImageStr;
        NSString* tempCarNumStr;
        
        NSString* tempCarJiaStr;
       
        self.carDictionary = [self.carMutableArray objectAtIndex:indexPath.row];
        tempCarNumStr = [[self.carDictionary objectForKey:@"carNum"] uppercaseString];
        tempCarJiaStr = [self.carDictionary objectForKey:@"carJiaNum"];
        NSLog(@"tempCarJiaStr号 = %@",tempCarJiaStr);
        ((IndexCarCell*)cell).carJiaHiddenLabel.text = tempCarJiaStr;
        ((IndexCarCell*)cell).carJiaHiddenLabel.hidden = YES;
        NSLog(@"carJiaNum号:%@",((IndexCarCell*)cell).carJiaHiddenLabel.text);
        
        //转成大写 并加上 豫字
        NSLog(@"tempCarNumStr = %@",tempCarNumStr);
        NSMutableString* yu = [NSMutableString stringWithFormat:@"豫"];
        [yu appendString:tempCarNumStr];
        ((IndexCarCell*)cell).carNumberLabel.text = yu;
        

        tempImageStr = [self.carDictionary objectForKey:@"carImageNum"];
        ((IndexCarCell*)cell).carImageView.image = [UIImage imageNamed:tempImageStr];
        ((IndexCarCell*)cell).delegate = self;
        
        cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ic_more_item_middle.png"]];
        
        
    }else{//添加车辆
        cell = (AddButtonCell*)[tableView dequeueReusableCellWithIdentifier:@"AddButtonCell"];
        if(!cell){
            cell = [[[NSBundle mainBundle] loadNibNamed:@"AddButtonCell" owner:self options:nil] lastObject];
        }
        ((AddButtonCell*)cell).indexVC = self;
    }
    return cell;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView{
    return 2;
//    return 1;
}

-(void)managerCars:(id)sender{
    managerCars = [[carCommon alloc] initWithNibName:@"carCommon" bundle:nil];
    [self.navigationController pushViewController:managerCars animated:YES];
    
}

-(void)login:(id)sender{

    if([[NSUserDefaults standardUserDefaults] boolForKey:@"hasLogin"])
    {
        userViewController = [[UserViewController alloc] initWithNibName:@"UserViewController" bundle:nil];
        [self.navigationController pushViewController:userViewController animated:YES];
    }else
    {
    loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [self.navigationController pushViewController:loginViewController animated:YES];
    }
    [self setting_pressed:self];
}
-(void)aboutUS:(id)sender{
    aboutUSViewController = [[AboutUSViewController alloc] initWithNibName:@"AboutUSViewController" bundle:nil];
    [self.navigationController pushViewController:aboutUSViewController animated:YES];
    [self setting_pressed:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    [mainTableView release];
    [carDictionary release];
    [addCarViewController release];
    [carMutableArray release];
    [super dealloc];
}
//返回添加新车页面
-(void)showHomeIntroduce{
    addCarViewController = [[HomeIntroduce alloc] initWithNibName:@"HomeIntroduce" bundle:nil];
    [self.navigationController pushViewController:addCarViewController animated:YES];
}
-(void)showCarInfoViewController:(NSString *)numberStr carJaNumber:(NSString *)carJaStr{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.dimBackground = YES;
    HUD.labelText = @"正在努力为您加载";
    [HUD showAnimated:YES whileExecutingBlock:^{
        sleep(5);
    }completionBlock:^{
        carInfoListViewController = [[CarInfoListViewController alloc] initWithNibName:@"CarInfoListViewController" bundle:nil];
//        carInfoListViewController.data = [carInfoListViewController carDataNumber:numberStr carJaNumber:carJaStr];
        [carInfoListViewController carDataNumber:numberStr carJaNumber:carJaStr];
        carInfoListViewController.carName = numberStr;
        [self.navigationController pushViewController:carInfoListViewController animated:YES];
        
        [HUD removeFromSuperview];
        [HUD release];
        HUD = nil;
        
    }];
    
}
-(IBAction)setting_pressed:(id)sender{
    [UIView beginAnimations:@"movement" context:nil];
    [UIView setAnimationDuration:0.5f];
    // show = YES;
    if(show){
        rightView.frame = CGRectMake(320-120, 0, 120, 480);
        show = NO;
        btn_shade.hidden = NO;
    }else{
        rightView.frame = CGRectMake(320, 0, 120, 480);
        show = YES;
        btn_shade.hidden = YES;
    }
    [UIView commitAnimations];
}


@end
