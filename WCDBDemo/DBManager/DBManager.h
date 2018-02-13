//
//  DBManager.h
//  WCDBDemo
//
//  Created by 周建顺 on 2018/2/7.
//  Copyright © 2018年 mxrcorp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WCDB/WCDB.h>

#define MessageDBName @"message"

@class WCTDatabase;

@interface DBManager : NSObject
+(instancetype)sharedInstance;
+(WCTDatabase *)sharedDB;
@property (nonatomic, strong, readonly) WCTDatabase *database;
@end
