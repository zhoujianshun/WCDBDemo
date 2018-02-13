//
//  CRUDViewController.m
//  WCDBDemo
//
//  Created by 周建顺 on 2018/2/9.
//  Copyright © 2018年 mxrcorp. All rights reserved.
//

#import "CRUDViewController.h"
#import "Message.h"
#import "MessageDBManager.h"
#import "MessageDetailViewController.h"



static NSString *messageCellIdentifier = @"messageCellIdentifier";

@interface CRUDViewController ()<UITableViewDelegate, UITableViewDataSource, MessageDetailViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UITextField *localIDTextField;
@property (strong, nonatomic) IBOutlet UITextField *contentTextField;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *messages;

@end

@implementation CRUDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self reloadData];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     
     if ([segue.destinationViewController isKindOfClass:[MessageDetailViewController class]]) {
         UITableViewCell *cell = sender;
         NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
         Message *message = [self.messages objectAtIndex:indexPath.row];
         
         MessageDetailViewController *vc = segue.destinationViewController;
         vc.delegate = self;
         vc.message = message;
     }
 }


-(void)insertTestMessage{
    Message *testMessage = [Message new];
    testMessage.localID = 0;
    testMessage.content = @"First test content";
    testMessage.createTime = [NSDate date];
    testMessage.modifiedTime = [NSDate date];
    BOOL result = [[MessageDBManager sharedManager] insertMessage:testMessage];
    NSLog(@"插入测试数据：%@",result?@"成功":@"失败");
    if (result) {
        [self.messages addObject:testMessage];
        [[self tableView] reloadData];
    }
}
-(void)reloadData{
    
    NSArray *datas = [[MessageDBManager sharedManager] getAllMessages];
    self.messages = [NSMutableArray arrayWithArray:datas];
    [self.tableView reloadData];
}



#pragma mark -



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.messages.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Message *message = [self.messages objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:messageCellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",@(message.localID)];
    cell.detailTextLabel.text = message.content;
    return cell;
    
}


#pragma mark - messageDetail delegate

-(void)messageDetailViewController:(MessageDetailViewController *)controller updateMessageSuccess:(Message *)message{
    NSInteger index = [self.messages indexOfObject:message];
    if (0<=index&&index<self.messages.count) {
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
    
}


#pragma mark -

- (IBAction)insertAction:(id)sender {
    
    NSInteger localID = [self.localIDTextField.text integerValue];
    NSString *content =self.contentTextField.text;
    
    Message *testMessage = [Message new];
    testMessage.localID = localID;
    testMessage.content = content;
    testMessage.createTime = [NSDate date];
    testMessage.modifiedTime = [NSDate date];
    BOOL result = [[MessageDBManager sharedManager] insertMessage:testMessage];
    if (result) {
        [self.messages addObject:testMessage];
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:(self.messages.count - 1) inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    }else{
        [self showMessage:@"插入数据失败"];
    }
}

- (IBAction)updateAction:(id)sender {
    
    NSInteger localID = [self.localIDTextField.text integerValue];
    NSString *content =self.contentTextField.text;
    
    Message *testMessage = [Message new];
    testMessage.localID = localID;
    testMessage.content = content;
    testMessage.createTime = [NSDate date];
    testMessage.modifiedTime = [NSDate date];
    BOOL result = [[MessageDBManager sharedManager] updateMessage:testMessage];
    if (result) {
        [self.messages addObject:testMessage];
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:(self.messages.count - 1) inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    }else{
        [self showMessage:@"插入数据失败"];
    }
}
- (IBAction)refreshAction:(id)sender {
    [self reloadData];
}

@end
