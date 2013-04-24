//
//  CarInfoListViewController.m
//  TrafficQuery
//
//  Created by hz on 13-4-10.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import "CarInfoListViewController.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
#import "CarInfo.h"
#import "HomeIntroduce.h"
#import "IndexViewController.h"
#import "RemindViewController.h"

@interface CarInfoListViewController ()

@end

@implementation CarInfoListViewController
@synthesize mainTabView, data, weifaArr;
@synthesize delegate;
@synthesize whichCarLabel, homeManyLabel, countMoneyLabel;
@synthesize carName;

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
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
	leftButton.frame = CGRectMake(5,8, 50, 30);
	[leftButton setTitle:@"返回" forState:UIControlStateNormal];
	leftButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    leftButton.titleLabel.textColor = [UIColor whiteColor];
    leftButton.titleLabel.shadowOffset = CGSizeMake(-1.0f, 2.0f);
    leftButton.titleLabel.shadowColor = [UIColor blackColor];
	[leftButton setTitleEdgeInsets:UIEdgeInsetsMake(5, 10, 5, 5)];
	[leftButton setBackgroundImage:[UIImage imageNamed:@"btn_setting.png"] forState:UIControlStateNormal];
	[leftButton addTarget:self action:@selector(backTopage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];
    ////////////////////////////////////////////////////////////////////
//    self.whichCarLabel.text = self.data
    
    
    
    //HomeIntroduce* delegate;
    self.whichCarLabel.text = delegate.carNumberField.text ;
    NSLog(@"是否为空 ＝%@",delegate.carNumberField.text);
    
    
    
    //违法次数
    self.homeManyLabel.text = [NSString stringWithFormat:@"%d",[self.data count]];
    
    
    NSLog(@"data数据 = %@",self.data);
    int count = [self.data count];
    
    countDic = [[NSMutableDictionary alloc] init];
    int allMoney = 0;
    for(int i = 0; i < count; i++){
        countDic = [self.data objectAtIndex:i];
        NSNumber* tempNum = [countDic objectForKey:@"fkje"];
        allMoney += [tempNum intValue];
    }
    self.countMoneyLabel.text = [NSString stringWithFormat:@"%d",allMoney];
    self.whichCarLabel.text = self.carName;
   
    
    
    //单元格的行高
    self.mainTabView.rowHeight = 150;
    
    //违法行为
    self.weifaArr = [[NSArray alloc] initWithArray:[self weifaData]];
//    self.countMoneyLabel.text = [NSString stringWithFormat:@"%d", money];
//    NSLog(@"共计罚款:%d", money);

    [self.mainTabView reloadData];
  
}
- (void)backTopage{
    IndexViewController* indexViewController=[[IndexViewController alloc] initWithNibName:@"IndexViewController" bundle:nil];
    [self.navigationController pushViewController:indexViewController animated:YES];
  //-  [self.navigationController dismissModalViewControllerAnimated:YES];
    
    //    [self.navigationController popViewControllerAnimated:YES];
   // delegate = []
   // CarViewController* carVC = [[CarViewController alloc] initWithNibName:@"CarViewController" bundle:nil];
  //-  [self.navigationController popToRootViewControllerAnimated:YES];
//    [self.navigationController pushViewController:delegate animated:YES];
//    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
-(NSArray*)weifaData{
    NSString* file = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"wfxw"] ofType:@"txt"];
    NSString* fileData = [[NSString alloc] initWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
    //  NSLog(@"fileData = %@", fileData);
    NSArray* records = [fileData componentsSeparatedByString:@"\n"];
    NSMutableDictionary* tmpdic = [NSMutableDictionary dictionaryWithCapacity:[records count]];
    
    NSMutableDictionary* tmpdic1 = [NSMutableDictionary dictionaryWithCapacity:[records count]];
    
    //    NSMutableArray* tmpArr = [NSMutableArray arrayWithObjects: nil];
    
    //得到第一个数据
    NSMutableArray* firstArr = [NSMutableArray arrayWithObjects: nil];
    
    for(NSString* record in records)
    {
        NSArray* arr = [record componentsSeparatedByString:@";"];
        
        [firstArr addObject:[arr objectAtIndex:0]];
        
        [tmpdic setValue:[[arr objectAtIndex:1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:[arr objectAtIndex:0]];
        [tmpdic1 setValue:[[arr objectAtIndex:2] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:[arr objectAtIndex:0]];
        
        [[arr objectAtIndex:2] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
    }
    
    NSArray* returnArr = [NSMutableArray arrayWithObjects:firstArr, tmpdic, tmpdic1, nil];
    return returnArr;
    
}
-(NSArray*)carDataNumber:(NSString*)numberStr carJaNumber:(NSString*)carJaStr{
    
    //测试用的
    NSString* urlString = [NSString stringWithFormat:@"http://116.255.238.8:3000/querytraffic"];
    ASIFormDataRequest* requestForm = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    //[requestForm setRequestMethod:@"POST"];
    //设置需要POST的数据,这里提交两个数据
    NSString* strA = @"豫";
    strA = [strA stringByAppendingString:numberStr];
    [requestForm setPostValue:strA forKey:@"hphm"];
    [requestForm setPostValue:carJaStr forKey:@"clsbdh"];
    
    
       // [requestForm setPostValue:@"豫AGM979" forKey:@"hphm"];
    //    //[requestForm setPostValue:[@"豫AGM979" ] forKey:<#(NSString *)#>]
     //   [requestForm setPostValue:@"428163" forKey:@"clsbdh"];
    [requestForm setPostValue:@"02" forKey:@"hpzl"];
    [requestForm setPostValue:@"VS" forKey:@"queryid"];
    
//    [requestForm setDelegate:self];
//    [requestForm setDidFinishSelector:@selector(requestDone:)];
//    [requestForm setDidFailSelector:@selector(requestWentWrong:)];
//    [requestForm startAsynchronous];
    
    [requestForm startSynchronous];
    
    
    
    
    
    NSLog(@"response\n%@",[[NSString alloc] initWithData:[requestForm responseData] encoding:NSUTF8StringEncoding]);
    NSString* requestStr = [[NSString alloc] initWithData:[requestForm responseData] encoding:NSUTF8StringEncoding];
    NSDictionary* request = [requestStr objectFromJSONString];
    NSLog(@"%@",[request class]);//JKDictionary
    
    //JKArray下面是
    // NSLog(@"%@",[[[[request objectForKey:@"root"] objectForKey:@"VehSurveilInfo" ] objectForKey:@"surveil"] class] );
    // NSLog(@"%@",[[[[request objectForKey:@"root"] objectForKey:@"VehSurveilInfo" ] objectForKey:@"surveil"] class] );
    
    NSArray* carArrays = [[[request objectForKey:@"root"] objectForKey:@"VehSurveilInfo" ] objectForKey:@"surveil"];
   // NSLog(@"carArrays = %@",carArrays);
    NSNumber* countArr = [[[request objectForKey:@"root"] objectForKey:@"VehSurveilInfo"] objectForKey:@"count"];
    NSLog(@"countArr = %@", countArr);
    NSLog(@"countArr = %@", [countArr class]);
    NSString* homeManyStr = [NSString stringWithFormat:@"%@", countArr];
    self.homeManyLabel.text = homeManyStr;
  //  self.homeManyLabel.text = [NSString stringWithFormat:@"%@", countArr];
    
//    NSNumber* count = [countArr objectAtIndex:0];
//    NSLog(@"count = %@",count);
    
//    self.homeManyLabel.text = [NSString stringWithFormat:@"%@",[countArr objectAtIndex:0]];
    NSLog(@"self.homeManyLabel.text = %@",self.homeManyLabel.text);
    return carArrays;
}
/*
-(void)requestDone:(ASIHTTPRequest*)request{
    NSLog(@"response\n%@",[[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding]);
    NSString* requestStr = [[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding];
    NSDictionary* requests = [requestStr objectFromJSONString];
    NSLog(@"%@",[request class]);//JKDictionary
    
    //JKArray下面是
    // NSLog(@"%@",[[[[request objectForKey:@"root"] objectForKey:@"VehSurveilInfo" ] objectForKey:@"surveil"] class] );
    // NSLog(@"%@",[[[[request objectForKey:@"root"] objectForKey:@"VehSurveilInfo" ] objectForKey:@"surveil"] class] );
    
    NSArray* carArrays = [[[requests objectForKey:@"root"] objectForKey:@"VehSurveilInfo" ] objectForKey:@"surveil"];
    // NSLog(@"carArrays = %@",carArrays);
    NSNumber* countArr = [[[requests objectForKey:@"root"] objectForKey:@"VehSurveilInfo"] objectForKey:@"count"];
    NSLog(@"countArr = %@", countArr);
    NSLog(@"countArr = %@", [countArr class]);
    NSString* homeManyStr = [NSString stringWithFormat:@"%@", countArr];
    self.homeManyLabel.text = homeManyStr;
    //  self.homeManyLabel.text = [NSString stringWithFormat:@"%@", countArr];
    
    //    NSNumber* count = [countArr objectAtIndex:0];
    //    NSLog(@"count = %@",count);
    
    //    self.homeManyLabel.text = [NSString stringWithFormat:@"%@",[countArr objectAtIndex:0]];
    NSLog(@"self.homeManyLabel.text = %@",self.homeManyLabel.text);
    return carArrays;
}
*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.data count];
    //return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell* cell;
//    cell = (CarInfo*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    carInfo = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(!carInfo){
        carInfo = [[[NSBundle mainBundle] loadNibNamed:@"CarInfo" owner:self options:nil] lastObject];
    }
    

    NSDictionary* dic1;
    if([self.data count] == 1)
    {
        // NSLog(@"self.data 转化======%@",[self.data class]);
    }else{
        NSLog(@"self.data 转化======%@",[self.data class]);
        NSLog(@"[self.data count]==%d",[self.data count]);
        
        dic1 = [self.data objectAtIndex:indexPath.row];
    }
      
    NSNumber* FirstNumber = [dic1 objectForKey:@"wfxw"];
    NSString* FirstNumberStr = [NSString stringWithFormat:@"%@",FirstNumber];
    //NSLog(@"FirstNumber = %@", FirstNumber);
    //NSLog(@"FirstNumber = %@", [FirstNumber class]);
    
    NSArray* SecondText = [self.weifaArr objectAtIndex:0];
    // NSLog(@"SecondText = %@", SecondText);
    //NSLog(@"SecondText = %@", [SecondText class]);
    
    //NSCFString里面是
    id SecondNumber = [SecondText objectAtIndex:0];
    NSLog(@"%@",[SecondNumber class]);
    NSLog(@"SecondNumber = %@", SecondNumber);
    
    int index =[SecondText indexOfObject:FirstNumberStr];
    NSLog(@"index = %d",index);
    
    NSString* whyStr = [[self.weifaArr objectAtIndex:1] objectForKey:[[self.weifaArr objectAtIndex:0] objectAtIndex:index]];
    NSLog(@"whyStr = %@", whyStr);
    

    
    carInfo.whyLabel.text = whyStr;
    
    
    
    
    id koufenNumber = [[self.weifaArr objectAtIndex:2] objectForKey:[[self.weifaArr objectAtIndex:0] objectAtIndex:index]];
  //  NSLog(@"koufenNumber = %@", [self.weifaArr objectAtIndex:2]);
   // NSLog(@"koufenNumber = %@",[koufenNumber class]);
    
    carInfo.koufenLabel.text = koufenNumber;
    
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
    // NSString* weifayuanxin = [[weifaArr objectAtIndex:1] objectAtIndex:indexPath.row];
    
    //      NSString* weifayuanxin = [[weifaArr objectAtIndex:0] objectAtIndex:indexPath.row];
    // NSLog(@"weifayuanxin = %@",weifayuanxin);
    
    
    NSString* wfsj = [dic1 objectForKey:@"wfsj"];
    carInfo.whenLabel.text = wfsj;
    // NSLog(@"wfsj === %@",wfsj);
    
    NSString* wfdz = [dic1 objectForKey:@"wfdz"];
    carInfo.whereLabel.text = wfdz;
    //  NSLog(@"wfdz === %@",wfdz);
    
    // NSString* cljgmc = [dic1 objectForKey:@"cljgmc"];
    // cell.koufenLabel.text = cljgmc;
    // NSLog(@"cljgmc === %@",cljgmc);
    
    // NSString* fkje = [[dic1 objectForKey:@"fkje"] floatValue];
    NSNumber* fkje = [dic1 objectForKey:@"fkje"];
    
    /*
    money +=[fkje intValue];
    NSLog(@"money = %d",money);
    self.countMoneyLabel.text = [NSString stringWithFormat:@"%d",money];
    */
    carInfo.fakuanLabel.text = [NSString stringWithFormat:@"%@", fkje];
    
    // cell.fakuanLabel.text = fkje;
    //  NSLog(@"fkje === %@",fkje);
    
    //    }
    return carInfo;
}
//在此进行逻辑判断
-(IBAction)remindBtn:(id)sender{
    remindViewController = [[RemindViewController alloc] initWithNibName:@"RemindViewController" bundle:nil];
    [self.navigationController pushViewController:remindViewController animated:YES];
}


-(void)dealloc{
    [countDic release];
    [super dealloc];
}

@end
