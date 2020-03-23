//
//  GDDBManager.h
//  GoDap
//
//  Created by Damion on 2018/4/12.
//  Copyright © 2018年 dingtone. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TABLE_NAME_GDActivateUserModel    @"Active_user"
#define TABLE_NAME_GDUserAvatarModel      @"User_avatar"
#define TABLE_NAME_GDUserInfo             @"Userinfo"
#define TABLE_NAME_GDTransferQueue        @"GDTransferQueue"

#define TABLE_NAME_GDShareFile            @"GDShareFile"
#define TABLE_NAME_GDCloudFile            @"GDCloudFile"
#define TABLE_NAME_GDShareInfo            @"GDShareInfo"

#define TABLE_NAME_GDChannelIDInfo        @"GDChannelIDInfo"

#define TABLE_NAME_GDChannelMember        @"GDChannelMember" // channelMember表


///新建一张share/private share表来过渡透啊

@interface GDDBManager : NSObject

+ (instancetype)defaultDBManager;
//- (instancetype)init NS_UNAVAILABLE;

/**
 初始化数据库
 */
- (void)createDatabase;


/**
 获取当前数据库

 @return db
 */
- (id)currentDatabase;

- (void)deleteDBCache;

@end
