//
//  MessageDetailViewController.h
//  WCDBDemo
//
//  Created by 周建顺 on 2018/2/9.
//  Copyright © 2018年 mxrcorp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"
#import "MyDefaultViewController.h"

@class MessageDetailViewController;

@protocol MessageDetailViewControllerDelegate<NSObject>

-(void)messageDetailViewController:(MessageDetailViewController*)controller updateMessageSuccess:(Message*)message;

@end

@interface MessageDetailViewController : MyDefaultViewController

@property (nonatomic, strong) Message *message;
@property (nonatomic, weak) id<MessageDetailViewControllerDelegate> delegate;

@end
