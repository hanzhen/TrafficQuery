//
//  ModifyViewController.m
//  TrafficQuery
//
//  Created by hz on 13-4-18.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import "ModifyViewController.h"
#define CARLISTFILEPATH [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/CarList.plist"]

@interface ModifyViewController ()

@end

@implementation ModifyViewController
@synthesize carPaiImageView, carJiaTextField, carNameLabel, carPaiTextField;
@synthesize carNameStr, carImageStr, carJiaStr, carPaiStr;

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
    carNameLabel.text = carNameStr;
    carPaiImageView.image = [UIImage imageNamed:carImageStr];
    carJiaTextField.text = carJiaStr;
    carPaiTextField.text = carPaiStr;
    
    UITapGestureRecognizer* tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
}
//添加手势,让键盘消失
-(void)viewTapped:(UITapGestureRecognizer*)tapGr{
    
    [carPaiTextField resignFirstResponder];
    
    [carJiaTextField resignFirstResponder];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)goBack:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
//保存数据
-(IBAction)saveChange:(UIButton *)sender{
    
}
-(void)dealloc{
    [carNameStr release];
    [carImageStr release];
    [carJiaStr release];
    [carPaiStr release];
    [carPaiImageView release];
    
    [carNameLabel release];
    [super dealloc];
}

@end
