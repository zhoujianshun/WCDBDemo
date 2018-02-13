//
//  MessageDBManager.h
//  WCDBDemo
//
//  Created by 周建顺 on 2018/2/9.
//  Copyright © 2018年 mxrcorp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Message.h"

@interface MessageDBManager : NSObject

+(instancetype)sharedManager;

-(BOOL)insertMessage:(Message*)message replace:(BOOL)replace;
-(BOOL)insertMessage:(Message*)message;

-(BOOL)updateMessage:(Message*)message;

-(NSArray*)getAllMessages;

@end
