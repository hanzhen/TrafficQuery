//
//  CarViewController.h
//  TrafficQuery
//
//  Created by han zhen on 13-3-29.
//  Copyright (c) 2013年 hz. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "CarBaseCell.h"

@class HomeIntroduce;
@interface CarViewController : UITableViewController{
    HomeIntroduce* delegate;
    
    CarBaseCell* tmpCell;
    NSArray* data;
    
    UINib* cellNib;
    
    NSArray* character;
    NSMutableArray* dictionary1[20];

}
@property(nonatomic, assign)HomeIntroduce* delegate;
@property(nonatomic, retain)IBOutlet CarBaseCell* tmpCell;
@property(nonatomic, retain)NSArray* data;
@property(nonatomic, retain)UINib* cellNib;


@end
