//
//  LoginViewController.h
//  TrafficQuery
//
//  Created by han zhen on 13-4-17.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IndexViewController;
@class RegisterViewController;
@interface LoginViewController : UIViewController{
    UITextField* telphoneTextField;
    UITextField* passworldTextField;
    IndexViewController* indexViewController;
    RegisterViewController* registerViewController;
}

@property(nonatomic, retain)IBOutlet UITextField* telphoneTextField;
@property(nonatomic, retain)IBOutlet UITextField* passwordTextField;
-(IBAction)login:(id)sender;
-(IBAction)register:(id)sender;
-(IBAction)goBack:(id)sender;

@end
