//
//  ModifyViewController.h
//  TrafficQuery
//
//  Created by hz on 13-4-18.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModifyViewController : UIViewController{
    UILabel* carNameLabel;
    UITextField* carPaiTextField;
    UITextField* carJiaTextField;
    UIImageView* carPaiImageView;
    NSString* carImageStr;
    NSString* carNameStr;
    NSString* carPaiStr;
    NSString* carJiaStr;
}
@property(nonatomic, assign)NSString* carPaiStr;
@property(nonatomic, assign)NSString* carJiaStr;
@property(nonatomic, assign)NSString* carImageStr;
@property(nonatomic, assign)NSString* carNameStr;
@property(nonatomic, retain)IBOutlet UILabel* carNameLabel;
@property(nonatomic, retain)IBOutlet UITextField* carPaiTextField;
@property(nonatomic, retain)IBOutlet UITextField* carJiaTextField;
@property(nonatomic, retain)IBOutlet UIImageView* carPaiImageView;
-(IBAction)goBack:(UIButton*)sender;

@end
