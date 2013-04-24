//
//  CarManager.m
//  TrafficQuery
//
//  Created by hz on 13-4-15.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import "CarManager.h"
#import "Car.h"
#define CARLISTFILEPATH [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/CarList.plist"]
@implementation CarManager

@synthesize carsDic;
@synthesize carsArr;
@synthesize isLogin;


static CarManager* sharedCarsInstance = nil;

+(CarManager*)sharedInstance{
    @synchronized(self){
        static dispatch_once_t pred;
        dispatch_once(&pred,^{sharedCarsInstance = [[self alloc] init];});
    }
    return sharedCarsInstance;
}


+(id)allocWithZone:(NSZone *)zone{
    @synchronized(self){
        if(sharedCarsInstance == nil){
            sharedCarsInstance = [super allocWithZone:zone];
            return sharedCarsInstance;
        }
    }
    return nil;
}

-(id)copyWithZone:(NSZone*)zone{
    return self;
}

-(id)retain{
    return self;
}
-(void)release{
    //do nothing
}

-(id)autorelease{
    return self;
}
-(void)saveUserNameAndPwd:(NSString *)userName andPwd:(NSString *)pwd{
    NSUserDefaults* userFile = [NSUserDefaults standardUserDefaults];
    [userFile removeObjectForKey:@"UserName"];
    [userFile removeObjectForKey:@"Password"];
    [userFile setObject:userName forKey:@"UserName"];
    [userFile setObject:pwd forKey:@"Password"];
    [userFile synchronize];
    
}
-(NSString*)getUserName{
    NSUserDefaults* userFile = [NSUserDefaults standardUserDefaults];
    return [userFile objectForKey:@"UserName"];
}
-(NSString*)getPwd{
    NSUserDefaults* userFile = [NSUserDefaults standardUserDefaults];
    return [userFile objectForKey:@"Password"];
}


-init{
    if(self = [super init]){
        [self setupArray];
    }
    return self;
}
-(void)setupArray{
    
    carsArr = [[NSMutableArray alloc] init];
    isLogin = NO;
    //carsArr = [[NSMutableArray alloc] initWithContentsOfFile:CARLISTFILEPATH];
    
//    NSDictionary* eachCar;
//    NSFileManager* fileManager = [NSFileManager defaultManager];
//    if(![fileManager fileExistsAtPath:CARLISTFILEPATH]){
//        [fileManager createFileAtPath:CARLISTFILEPATH contents:nil attributes:nil];
//    }
    
////    self.carsArr = [[NSArray alloc] initWithContentsOfFile:CARLISTFILEPATH];
//    self.carsArr = [[NSMutableArray alloc] initWithContentsOfFile:CARLISTFILEPATH];
//    NSLog(@"调用了setupArray");
//    NSLog(@"carsDic = %@", carsDic);
//
//    //车牌号唯一
//    for(eachCar in carsArr){
//        Car* car = [[Car alloc] initWithDictionary:eachCar];
//        [carsDic setObject:car forKey:car.carPaiNum];
//        NSLog(@"carsDic = %@", carsDic);
//       // NSLog(@"调用了setupArray");
//        [car release];
//    }

    //[self.carsArr release];

}


@end
