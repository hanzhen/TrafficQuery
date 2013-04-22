//
//  ModifyViewController.m
//  TrafficQuery
//
//  Created by hz on 13-4-18.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import "ModifyViewController.h"

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)goBack:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
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
