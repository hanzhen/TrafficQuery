//
//  CarInfo.m
//  TrafficQuery
//
//  Created by hz on 13-4-2.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import "CarInfo.h"

@implementation CarInfo
@synthesize whenLabel, whereLabel, whyLabel, fakuanLabel, koufenLabel;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
