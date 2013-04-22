//
//  AboutUSViewController.m
//  TrafficQuery
//
//  Created by hz on 13-4-19.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import "AboutUSViewController.h"
#import "HomeIntroduce.h"

@interface AboutUSViewController ()

@end

@implementation AboutUSViewController

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
}
-(IBAction)goBack:(id)sender{
   // homeIntroduce = [[HomeIntroduce alloc] initWithNibName:@"HomeIntroduce" bundle:nil];
    //[self.navigationController popViewControllerAnimated:YES];
    
   // [self.navigationController pushViewController:homeIntroduce animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
