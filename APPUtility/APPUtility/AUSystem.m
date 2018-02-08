//
//  AUSystem.m
//  APPUtility
//
//  Created by quentin on 2018/2/8.
//  Copyright © 2018年 Quentin. All rights reserved.
//

#import "AUSystem.h"
#import <BmobSDK/Bmob.h>

#define kAPPUtilityCollapseClassName     @"APPUtilityCollapse"
#define kAPPUtilityAppID            @"appID"
#define kAPPUtilityClose            @"close"


@implementation AUSystem

+ (AUSystem *)sharedSystem
{
    static AUSystem *_sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[AUSystem alloc] init];
    });
    
    return _sharedInstance;
}

// 初始化BMOB
- (void)registBmobAppKey:(NSString *)appKey appID:(NSString *)appID
{
    [Bmob registerWithAppKey:appKey];
    
    if (appID) {
        BmobObject *object = [BmobObject objectWithClassName:kAPPUtilityCollapseClassName];
        [object setObject:appID forKey:kAPPUtilityAppID];
        [object setObject:@(NO) forKey:kAPPUtilityClose];
        [object saveInBackground];
    }
}

- (void)collapseWithAppID:(NSString *)appID
{
    BmobQuery *query = [BmobQuery queryWithClassName:kAPPUtilityCollapseClassName];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        if ([array count] > 0) {
            BmobObject *object = array[0];
            
            BOOL close = [[object objectForKey:kAPPUtilityClose] boolValue];
            if (close) {
                exit(0);
            }
        }
        
    }];
}

- (void)activateSDK
{
    [Bmob activateSDK];
}

@end
