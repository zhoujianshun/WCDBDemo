//
//  MessageDBManager.m
//  WCDBDemo
//
//  Created by 周建顺 on 2018/2/9.
//  Copyright © 2018年 mxrcorp. All rights reserved.
//

#import "MessageDBManager.h"
#import "DBManager.h"
#import "Message+WCTTableCoding.h"

@implementation MessageDBManager

+(instancetype)sharedManager{
    static dispatch_once_t onceToken;
    static MessageDBManager *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [MessageDBManager new];
    });
    return instance;
}

-(BOOL)insertMessage:(Message*)message{

   return [self insertMessage:message replace:NO];
}

-(BOOL)insertMessage:(Message*)message replace:(BOOL)replace{
    if (replace) {
        return [[DBManager sharedDB] insertOrReplaceObject:message into:MessageDBName];
    }
    
    return [[DBManager sharedDB] insertObject:message into:MessageDBName];
}

-(BOOL)updateMessage:(Message*)message{

    NSArray *row = [NSArray arrayWithObjects:message.modifiedTime,message.content,nil];
   return [[DBManager sharedDB] updateRowsInTable:MessageDBName
                      onProperties:{Message.modifiedTime, Message.content}
                           withRow:row where:Message.localID==message.localID];
    
    
    //return [[DBManager sharedDB] updateRowsInTable:MessageDBName onProperties:{Message.modifiedTime, Message.content} withObject:message where:Message.localID==message.localID];
}

-(NSArray*)getAllMessages{
    NSArray<Message*> *result = [[DBManager sharedDB] getAllObjectsOfClass:Message.class fromTable:MessageDBName];
    return result;
}


@end
