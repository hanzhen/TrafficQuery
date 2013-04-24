//
//  HomeIntroduce.h
//  TrafficQuery
//
//  Created by hz on 13-3-27.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "view.h"
#import "MBProgressHUD.h"


#define NavbgHight  46
#define PLACECARNUMBER @"请输入车牌号码"
#define PLACECARJA     @"请输入车驾号码"

@class CarViewController;
@class CarInfoListViewController;
@class AppDelegate;
@class carCommon;

@class LoginViewController;
@class AboutUSViewController;
@class UserViewController;

@interface HomeIntroduce : UIViewController<UIScrollViewDelegate, UINavigationBarDelegate, UITextFieldDelegate>
{
    MBProgressHUD* HUD;
    LoginViewController* loginViewController;
    AboutUSViewController* aboutUSViewController;
    
    UserViewController* userViewController;
    
    UIView* rightView;
    BOOL show;
    view* newView;
    UIButton* btn_shade;
    
    carCommon* managerCars;
    
    CarViewController* carViewController;
    CarInfoListViewController* carInfoListViewController;
    
    AppDelegate* myAppDelegate;
    
    UIPageControl* pageControl;
    UIPageControl* pageForFirstView;  //程序第一次启动页数控制器
   
    UINavigationBar* mainNavigationBar;
    
    
    UITextField* carNumberField;//车牌号
    UITextField* carJaField;//车驾号
  //  UIImageView* homeBg;
    UIView* homeBgView;
    
    UIImageView* iconImageView;//车型
    
    UILabel* titleLabel;
    
    SEL action;
    id target;
    NSString* leftBarTitle;
    BOOL isPush;
    NSString* iconNumStr;
    NSString* carNameStr;
    NSString* weifaCount;
    UILabel* selectIconLabel;
    NSMutableDictionary* carDataDict;
    NSMutableArray* carListArr;
    
//    UIButton* btn_set;
    
}
@property(nonatomic, retain)NSMutableArray* carListArr;
@property(nonatomic, retain)AppDelegate* myAppDelegate;
@property(nonatomic, copy)NSString* weifaCount;
@property(nonatomic, copy)NSString* carNameStr;
@property(nonatomic, copy)NSString* iconNumStr;
@property(nonatomic, retain)UIImageView* iconImageView;
@property(nonatomic)SEL action;
@property(nonatomic, assign)id target;
@property(nonatomic, copy)NSString* leftBarTitle;

@property(nonatomic, retain)IBOutlet UINavigationBar* mainNavigationBar;
@property(nonatomic, retain)IBOutlet UILabel* titleLabel;
//@property(nonatomic, retain)IBOutlet UIImageView* homeBg;
@property(nonatomic, retain)IBOutlet UIView* homeBgView;
@property(nonatomic, retain)UILabel* selectIconLabel;

@property(nonatomic, retain)UITextField* carNumberField;
@property(nonatomic, retain)UITextField* carJaField;


@property(nonatomic, retain)UINavigationController* aboutNav;
//@property(nonatomic, retain)IBOutlet UINavigationController* navigationController;
-(IBAction)aboutSet:(id)sender;
//程序第一次启动时添加介绍页面视图
-(void)theAppFirstStartView;
//取文本域内text
-(UITextField*)getTextFieldNormal:(NSString*)placeMsg;
@end
