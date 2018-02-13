//
//  Message.h
//  WCDBDemo
//
//  Created by 周建顺 on 2018/2/7.
//  Copyright © 2018年 mxrcorp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject<NSCopying>

@property int localID;
@property(retain) NSString *content;
@property(retain) NSDate *createTime;
@property(retain) NSDate *modifiedTime;
@property(assign) int unused; //You can only define the properties you need

@end
