//
//  AUSystem.h
//  APPUtility
//
//  Created by quentin on 2018/2/8.
//  Copyright © 2018年 Quentin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AUSystem : NSObject

+ (AUSystem *)sharedSystem;

// 初始化BMOB
- (void)registBmobAppKey:(NSString *)appKey appID:(NSString *)appID;
- (void)collapseWithAppID:(NSString *)appID;
- (void)activateSDK;

@end
