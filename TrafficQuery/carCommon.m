//
//  carCommon.m
//  TrafficQuery
//
//  Created by hz on 13-4-17.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import "carCommon.h"
//#import "IndexCarCell.h"
#import "IndexViewController.h"
#import "ModifyCell.h"
#import "ModifyViewController.h"
#define CARLISTFILEPATH [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/CarList.plist"]
@interface carCommon ()

@end

@implementation carCommon
@synthesize carDictionary;
@synthesize mainTableView;
@synthesize carMutableArray;
@synthesize deleteButton;


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
-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell;
   
//        cell = (IndexCarCell*)[tableView dequeueReusableCellWithIdentifier:@"IndexCell"];
        cell = (ModifyCell*)[tableView dequeueReusableCellWithIdentifier:@"ModifyCell"];
    
        if(!cell)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ModifyCell" owner:self options:nil] lastObject];
        }
        NSString* tempImageStr;
        NSString* tempCarNumStr;
        NSString* tempCarJiaStr;
        self.carDictionary = [self.carMutableArray objectAtIndex:indexPath.row];

        // tempCarNumStr = [[self.carDictionary allKeys] objectAtIndex:indexPath.row];
        tempCarNumStr = [self.carDictionary objectForKey:@"carNum"];
        NSLog(@"tempCarNumStr = %@",tempCarNumStr);
        ((ModifyCell*)cell).carPaiLabel.text = tempCarNumStr;
    
        tempCarJiaStr = [self.carDictionary objectForKey:@"carJiaNum"];
        ((ModifyCell*)cell).carJiaLabelHidden.text = tempCarJiaStr;
    
        ((ModifyCell*)cell).carJiaLabelHidden.hidden = YES;
    
    
       // ((IndexCarCell*)cell).carNumberLabel.text = tempCarNumStr;
       // ((IndexCarCell*)cell).carJiaHiddenLabel.hidden = YES;
    
        tempImageStr = [self.carDictionary objectForKey:@"carImageNum"];
        ((ModifyCell*)cell).carBiaoImageView.image = [UIImage imageNamed:tempImageStr];
        ((ModifyCell*)cell).commonDelegate = self;
    
    
     
//        ((IndexCarCell*)cell).carImageView.image = [UIImage imageNamed:tempImageStr];
//        ((IndexCarCell*)cell).commonDelegate = self;
    
        
    
    return cell;
    
}
-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section{

    return [[NSMutableArray arrayWithContentsOfFile:CARLISTFILEPATH] count];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)deleteCar:(UIButton*)sender{
    if(sender.tag == 18){
        [self.mainTableView setEditing:YES animated:YES];
        deleteButton.tag = 05;
        NSLog(@"进行了单击");
    }else{
        [self.mainTableView setEditing:NO animated:YES];
        deleteButton.tag = 18;
    }
    
}

-(void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
   // IndexCarCell* cell = (IndexCarCell*)[tableView cellForRowAtIndexPath:indexPath];
    // ModifyCell* cell = (ModifyCell*)[tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"indexPath = %d",indexPath.row);
  //  NSLog(@"cell = %@", cell.carNumberLabel.text);
    [self.carMutableArray removeObjectAtIndex:indexPath.row];
    [self.carMutableArray writeToFile:CARLISTFILEPATH atomically:NO];
    [mainTableView reloadData];
}

-(IBAction)goBack:(UIButton *)sender{
    indexViewController = [[IndexViewController alloc] initWithNibName:@"IndexViewController" bundle:nil];
    [self.navigationController pushViewController:indexViewController animated:YES];
}
//有改动
-(void)dealloc{
    [carMutableArray release];
    [carDictionary release];
    [indexViewController release];
    [ModifyViewController release];
    [super dealloc];
}
-(void)showModifyVC:(NSString*)carPaiStr carJia:(NSString*)carJiaStr{
    
    modifyViewController = [[ModifyViewController alloc] initWithNibName:@"ModifyViewController" bundle:nil];
    modifyViewController.carPaiStr = carPaiStr;
    
    NSLog(@"carPaiTextField.text = %@",carPaiStr);
    modifyViewController.carJiaStr = carJiaStr;
    int num = [self.carMutableArray count];
    for(int i = 0; i < num; i++)
    {
        NSString* tempCarJia = [[self.carMutableArray objectAtIndex:i] objectForKey:@"carJiaNum"];
        if([carJiaStr isEqualToString:tempCarJia])
        {
            
            modifyViewController.carImageStr = [[self.carMutableArray objectAtIndex:i] objectForKey:@"carImageNum"];
            modifyViewController.carNameStr = [[self.carMutableArray objectAtIndex:i] objectForKey:@"carImage"];
            
//            modifyViewController.carPaiImageView.image = [UIImage imageNamed:[[self.carMutableArray objectAtIndex:i] objectForKey:@"carImageNum"]];
//            modifyViewController.carNameLabel.text = [[self.carMutableArray objectAtIndex:i] objectForKey:@"carImage"];
            //return;
        }
    }
    
//    NSLog(@"carNameLabel ===%@",modifyViewController.carNameLabel.text);
    [self.navigationController pushViewController:modifyViewController animated:YES];
    
    
}




@end
