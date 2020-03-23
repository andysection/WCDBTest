//
//  GDDBManager.m
//  GoDap
//
//  Created by Damion on 2018/4/12.
//  Copyright © 2018年 dingtone. All rights reserved.
//

#import "GDDBManager.h"

#import <WCDB/WCDB.h>

#define DATABASE_FILE_NAME @"godap.db"

//线程队列名称
static const char *queueName = "DBManagerQueue";

@interface GDDBManager () {
    //读写队列
    dispatch_queue_t _queue;
    //数据库路径
    NSString *dbFilePath;
    //
    WCTDatabase *database;
}

@end

@implementation GDDBManager

- (instancetype)init {
    if (self = [super init]) {
        NSString *documentFolderPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
        dbFilePath = [documentFolderPath stringByAppendingPathComponent:DATABASE_FILE_NAME];
        _queue = dispatch_queue_create(queueName, DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

+ (GDDBManager *)defaultDBManager {
    static GDDBManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[GDDBManager alloc] init];
    });
    
    return _sharedClient;
}

- (void)createDatabase {
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isExist = [fm fileExistsAtPath:dbFilePath];
    if (!isExist)
    {
        //拷贝数据库
        //获取工程里，数据库的路径,因为我们已在工程中添加了数据库文件，所以我们要从工程里获取路径
        NSString *backupDbPath = [[NSBundle mainBundle]
                                  pathForResource:@"godap"
                                  ofType:@"db"];
        //这一步实现数据库的添加，
        // 通过NSFileManager 对象的复制属性，把工程中数据库的路径拼接到应用程序的路径上
//        BOOL cp = [fm copyItemAtPath:backupDbPath toPath:dbFilePath error:nil];
//        GDLogInfo(@"cp = %d",cp);
//        GDLogInfo(@"backupDbPath =%@",backupDbPath);
    }
    database = [[WCTDatabase alloc] initWithPath:dbFilePath];
    
    [WCTStatistics SetGlobalSQLTrace:^(NSString *sql) {
        NSLog(@"SQL: %@", sql);
    }];
    
    [WCTStatistics SetGlobalPerformanceTrace:^(WCTTag tag, NSDictionary<NSString *,NSNumber *> *sqls, NSInteger cost) {
        NSLog(@"Tag: %d", tag);
        [sqls enumerateKeysAndObjectsUsingBlock:^(NSString *sql, NSNumber *count, BOOL *) {
            NSLog(@"SQL: %@ Count: %d", sql, count.intValue);
        }];
        NSLog(@"Total cost %ld nanoseconds", (long) cost);
    }];
    
    [WCTStatistics SetGlobalErrorReport:^(WCTError *error) {
        NSLog(@"SQL ERROR: %@", error);
    }];
    
    if ([database canOpen]) {
        if ([database isOpened]) {
            
        }
    }
    
}

- (id)currentDatabase {
    return database;
}

- (void)deleteDBCache{
    if ([database isOpened]){
        [database close];
    }
    NSFileManager *fileManage = [NSFileManager defaultManager];
    if ([fileManage fileExistsAtPath:dbFilePath]) {
        NSLog(@"文件存在");
        // 删除
        BOOL isSuccess = [fileManage removeItemAtPath:dbFilePath error:nil];
        NSLog(@"%@",isSuccess ? @"删除成功" : @"删除失败");
        [[GDDBManager defaultDBManager] createDatabase];
    }else{
        NSLog(@"文件不存在");
    }
}

@end
