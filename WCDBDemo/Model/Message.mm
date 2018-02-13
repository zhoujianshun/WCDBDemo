//
//  Message.m
//  WCDBDemo
//
//  Created by 周建顺 on 2018/2/7.
//  Copyright © 2018年 mxrcorp. All rights reserved.
//

#import "Message.h"

#import "Message+WCTTableCoding.h"
#import <WCDB/WCDB.h>

@implementation Message

-(id)copyWithZone:(NSZone *)zone{
    Message *message = [[self class] allocWithZone:zone];
    message.modifiedTime = self.modifiedTime;
    message.createTime = self.createTime;
    message.content = self.content;
    message.localID = self.localID;
    message.unused = self.unused;
    return message;
}

WCDB_IMPLEMENTATION(Message)
WCDB_SYNTHESIZE(Message, localID)
WCDB_SYNTHESIZE(Message, content)
WCDB_SYNTHESIZE(Message, createTime)
WCDB_SYNTHESIZE(Message, modifiedTime)

WCDB_PRIMARY(Message, localID)

WCDB_INDEX(Message, "_index", createTime)

@end
