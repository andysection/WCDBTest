//
//  GDChatConfig.mm
//  GoDap
//
//  Created by Damion on 2018/8/14.
//  Copyright © 2018年 dingtone. All rights reserved.
//

#import "GDChatConfig+WCTTableCoding.h"
#import "GDChatConfig.h"
#import <WCDB/WCDB.h>

@implementation GDChatConfig

- (instancetype)init {
    self = [super init];
    if (self) {
        _isNotification = YES;
    }
    return self;
}

WCDB_IMPLEMENTATION(GDChatConfig)
WCDB_SYNTHESIZE(GDChatConfig, chatWith)
WCDB_SYNTHESIZE(GDChatConfig, belongs)
WCDB_SYNTHESIZE(GDChatConfig, drafts)
WCDB_SYNTHESIZE(GDChatConfig, localID)
WCDB_SYNTHESIZE(GDChatConfig, isGroupChatDisabled)
WCDB_SYNTHESIZE_DEFAULT(GDChatConfig, isTop, 0) // Default to WCTDefaultTypeCurrentTime, WCTDefaultTypeCurrentDate, WCTDefaultTypeCurrentTimestamp or your custom literal value
WCDB_SYNTHESIZE_DEFAULT(GDChatConfig, isNotification, 1) // Default to WCTDefaultTypeCurrentTime, WCTDefaultTypeCurrentDate, WCTDefaultTypeCurrentTimestamp or your custom literal value

WCDB_PRIMARY_ASC_AUTO_INCREMENT(GDChatConfig, localID)

WCDB_UNIQUE_INDEX_ASC(GDChatConfig, "_chatWith_belongs", chatWith)
WCDB_UNIQUE_INDEX_ASC(GDChatConfig, "_chatWith_belongs", belongs)

WCDB_NOT_NULL(GDChatConfig, chatWith)
WCDB_NOT_NULL(GDChatConfig, belongs)
  
@end
