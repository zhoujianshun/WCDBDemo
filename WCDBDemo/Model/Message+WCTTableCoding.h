//
//  Message+WCTTableCoding.h
//  WCDBDemo
//
//  Created by 周建顺 on 2018/2/7.
//  Copyright © 2018年 mxrcorp. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Message.h"
#import <WCDB/WCDB.h>


@interface Message(WCTTableCoding)<WCTTableCoding>

WCDB_PROPERTY(localID)
WCDB_PROPERTY(content)
WCDB_PROPERTY(createTime)
WCDB_PROPERTY(modifiedTime)

@end
