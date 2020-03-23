//
//  GDChatConfig+WCTTableCoding.h
//  GoDap
//
//  Created by Damion on 2018/8/14.
//  Copyright © 2018年 dingtone. All rights reserved.
//

#import "GDChatConfig.h"
#import <WCDB/WCDB.h>

@interface GDChatConfig (WCTTableCoding) <WCTTableCoding>

WCDB_PROPERTY(chatWith)
WCDB_PROPERTY(isTop)
WCDB_PROPERTY(isNotification)
WCDB_PROPERTY(drafts)
WCDB_PROPERTY(isGroupChatDisabled)
WCDB_PROPERTY(belongs)
WCDB_PROPERTY(localID)

@end
