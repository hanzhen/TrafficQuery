//
//  LoginViewController.m
//  TrafficQuery
//
//  Created by han zhen on 13-4-17.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import "LoginViewController.h"
#import "IndexViewController.h"
#import "RegisterViewController.h"
#import "ASIFormDataRequest.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize telphoneTextField;
@synthesize passwordTextField;


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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)login:(id)sender{
    NSString* urlString = [NSString stringWithFormat:@"http://www.chexingle.com:8080/car/signIn/"];
    ASIFormDataRequest* requestForm = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    [requestForm setPostValue:@"13949068621" forKey:@"mobile"];
    [requestForm setPostValue:@"12345609" forKey:@"pwd"];
    [requestForm startSynchronous];
   // NSLog(@"response\n%@",[requestForm responseData]);
    NSLog(@"response\n%@",[[NSString alloc] initWithData:[requestForm responseData] encoding:NSUTF8StringEncoding]);
}
-(IBAction)register:(id)sender{
    registerViewController = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
    [self.navigationController pushViewController:registerViewController animated:YES];
}
-(IBAction)goBack:(id)sender{
    indexViewController = [[IndexViewController alloc] initWithNibName:@"IndexViewController" bundle:nil];
    [self.navigationController pushViewController:indexViewController animated:YES];
}

@end
