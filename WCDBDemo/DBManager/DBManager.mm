//
//  DBManager.m
//  WCDBDemo
//
//  Created by 周建顺 on 2018/2/7.
//  Copyright © 2018年 mxrcorp. All rights reserved.
//

#import "DBManager.h"


#import "Message.h"


@implementation DBManager

+(instancetype)sharedInstance{
    
    static dispatch_once_t onceToken;
    static DBManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [DBManager new];
        [instance InitDBWith:@"WCSample.db"];
    });
    return instance;
}

+(WCTDatabase *)sharedDB{
    return [DBManager sharedInstance].database;
}


-(void)InitDBWith:(NSString*)dbName{
    
        NSString *doucumentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, NO) firstObject];
        NSString *path = [doucumentPath stringByAppendingPathComponent:dbName];
        
        WCTDatabase *database = [[WCTDatabase alloc] initWithPath:path];
        _database = database;
        /*
         CREATE TABLE messsage (localID INTEGER PRIMARY KEY,
         content TEXT,
         createTime BLOB,
         modifiedTime BLOB)
         */
        BOOL result = [database createTableAndIndexesOfName:MessageDBName
                                                  withClass:Message.class];
        NSLog(@"创建数据库：%@", result?@"成功":@"失败");
   
}



@end
