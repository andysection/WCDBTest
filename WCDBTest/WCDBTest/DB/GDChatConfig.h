//
//  GDChatCongfig.h
//  GoDap
//
//  Created by Damion on 2018/8/14.
//  Copyright © 2018年 dingtone. All rights reserved.
//

#import "GDModel.h"

@interface GDChatConfig : GDModel

@property (nonatomic, assign) NSInteger localID;

/**
 聊天对象userId、channelId、固定聊天对象(PC端等)
 */
@property (nonatomic, copy) NSString *chatWith;

/**
 所属用户
 */
@property (nonatomic, copy) NSString *belongs;

/**
 是否置顶，默认为NO
 */
@property (nonatomic, assign) BOOL isTop;

/**
 消息是否通知,默认为YES(开启免打扰时为NO)
 */
@property (nonatomic, assign) BOOL isNotification;

/**
 聊天草稿
 */
@property (nonatomic, copy) NSString *drafts;

/**
 群聊是否被禁言
 */
@property (nonatomic, assign) BOOL isGroupChatDisabled;

@end
