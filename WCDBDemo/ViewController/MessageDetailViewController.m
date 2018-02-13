//
//  MessageDetailViewController.m
//  WCDBDemo
//
//  Created by 周建顺 on 2018/2/9.
//  Copyright © 2018年 mxrcorp. All rights reserved.
//

#import "MessageDetailViewController.h"
#import "MessageDBManager.h"

@interface MessageDetailViewController ()
@property (strong, nonatomic) IBOutlet UILabel *localIDLabel;
@property (strong, nonatomic) IBOutlet UILabel *createTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *modifiedTimeLabel;
@property (strong, nonatomic) IBOutlet UITextField *contentTextField;

@end

@implementation MessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.localIDLabel.text = [NSString stringWithFormat:@"%@",@(self.message.localID)];
    self.createTimeLabel.text = [NSString stringWithFormat:@"%@",self.message.createTime];
    self.modifiedTimeLabel.text = [NSString stringWithFormat:@"%@",self.message.modifiedTime];
    self.contentTextField.text = self.message.content;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)setMessage:(Message *)message{
//
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)submitAction:(id)sender {
    Message *message = [self.message copy];
    message.content = self.contentTextField.text;
    message.modifiedTime = [NSDate date];
    BOOL result = [[MessageDBManager sharedManager] updateMessage:message];
    
    if (result) {
        self.message.content = message.content;
        self.message.modifiedTime = message.modifiedTime;
        if ([self.delegate respondsToSelector:@selector(messageDetailViewController:updateMessageSuccess:)]) {
            [self.delegate messageDetailViewController:self updateMessageSuccess:self.message];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self showMessage:@"更新错误"];
    }
}

@end
