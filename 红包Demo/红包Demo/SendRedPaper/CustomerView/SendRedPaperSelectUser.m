//
//  SendRedPaperSelectUser.m
//  红包Demo
//
//  Created by xiaerfei on 15/8/21.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#import "SendRedPaperSelectUser.h"
#import "SendRedSelectUserCell.h"
#import "GetMoneyFromBankVC.h"
#import "AddUserModel.h"

@interface SendRedPaperSelectUser ()<UITableViewDataSource,UITableViewDelegate,SendRedSelectUserCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapGesture;
- (IBAction)tapGestureAction:(id)sender;

@end

@implementation SendRedPaperSelectUser
{
    NSMutableArray *_sendRedUserArray;
    UITextField *_textField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configData];
    [self configUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configData
{
    _sendRedUserArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 5; i++) {
        AddUserModel *userModel = [[AddUserModel alloc] init];
        userModel.userName = [NSString stringWithFormat:@"test %d",i];
        if (i == 0) {
            userModel.addUserModelType = AddUserModelTypeAllUser;
        } else {
            userModel.addUserModelType = AddUserModelTypeSingleUser;
        }
        [_sendRedUserArray addObject:userModel];
    }
    
}

- (void)configUI
{
    self.title = @"选择用户";
    //,NSFontAttributeName:[UIFont systemFontOfSize:19]
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]}];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:224.0f/255.0f green:53.0f/255.0f blue:62.0f/255.0f alpha:1];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIButton *titleLabel = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    titleLabel.backgroundColor = [UIColor grayColor];
    titleLabel.frame = CGRectMake(0, 0, 50, 44);
    [titleLabel setTitle:@"发红包" forState:UIControlStateNormal];
    titleLabel.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    titleLabel.titleLabel.textColor = [UIColor whiteColor];
    [titleLabel addTarget: self action:@selector(sendRedPaperAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:titleLabel];
    //sendRedPaperAction
    self.navigationItem.rightBarButtonItem = item;
    self.tapGesture.enabled = NO;
    
}
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return _sendRedUserArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SendRedSelectUserCell *cell = nil;
    if (indexPath.section == 0) {
        cell = [self tableView:tableView reuseIdentifier:kInputPhoneNumber];
        cell.delegate = self;
    } else {
        cell = [self tableView:tableView reuseIdentifier:kSelectUserFriend];
        
        [cell configWithData:_sendRedUserArray[indexPath.row]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (section == 1) {
        return 20;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 44;
    } else {
        return 60;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *view = [[UIView alloc] init];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, [UIScreen mainScreen].bounds.size.width-10, 20)];
        label.text = @"您还可以添加 5位 用户";
        label.font = [UIFont systemFontOfSize:12];
        label.attributedText = [self textLabelColor:label.text leftPosition:7 rightPosition:label.text.length - 7-3 color:[UIColor colorWithRed:240.0f/255.0f green:200.0f/255.0f blue:56.0f/255.0f alpha:1] font:[UIFont systemFontOfSize:12]];
        [view addSubview:label];
        return view;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddUserModel *model = _sendRedUserArray[indexPath.row];
    if (model.addUserModelType == AddUserModelTypeAllUser) {
        BOOL isSelect = NO;
        for (AddUserModel *model in _sendRedUserArray) {
            if (model.addUserModelType == AddUserModelTypeSingleUser && model.isSelected) {
                isSelect = YES;
                break;
            }
        }
        if (isSelect == NO) {
            model.isSelected = !model.isSelected;
        }
    } else {
        AddUserModel *firstModel = [_sendRedUserArray firstObject];
        if (firstModel.isSelected == NO) {
            model.isSelected = !model.isSelected;
        }
    }
    
    SendRedSelectUserCell *cell = (SendRedSelectUserCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.isSelect = model.isSelected;
//    [self.tableView reloadData];
}

#pragma mark - SendRedSelectUserDelegate
- (void)addUserPhoneNumber:(NSString *)phoneNumber
{
    // 添加联系人
    [_sendRedUserArray addObject:phoneNumber];
    [self.tableView reloadData];
}

- (void)currentBeginClickTextFild:(UITextField *)textField
{
    self.tapGesture.enabled = YES;
    _textField = textField;
}

- (void)currentEndClickTextFild:(UITextField *)textField
{

}
#pragma mark - event responses
/**
 *   @author xiaerfei, 15-08-24 09:08:26
 *
 *   发红包
 */
- (void)sendRedPaperAction
{
    //TODO: 做判断
    /*
        1.抱歉，您还没有添加接收红包的联系人
        2.您确定发送给：\nXXX先生
        3.您确定发送给：全局用户
     */
    
}

- (IBAction)tapGestureAction:(id)sender {
    [_textField resignFirstResponder];
    self.tapGesture.enabled = NO;
}
#pragma mark - private methods

- (SendRedSelectUserCell *)tableView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier
{
    SendRedSelectUserCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[SendRedSelectUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (NSMutableAttributedString*)textLabelColor:(NSString*)str leftPosition:(NSInteger)leftPos rightPosition:(NSInteger)rightPos color:(UIColor*)color font:(UIFont*)font
{
    
    NSMutableAttributedString *labelStr= [[NSMutableAttributedString alloc] initWithString:str];
    [labelStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(leftPos,rightPos)];
    [labelStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(leftPos, rightPos)];
    return labelStr;
}
@end
