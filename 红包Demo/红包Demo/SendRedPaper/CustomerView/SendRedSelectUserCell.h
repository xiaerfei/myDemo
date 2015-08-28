//
//  SendRedSelectUser.h
//  红包Demo
//
//  Created by xiaerfei on 15/8/21.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const kInputPhoneNumber;
extern NSString *const kSelectUserFriend;


@protocol SendRedSelectUserCellDelegate <NSObject>

- (void)currentBeginClickTextFild:(UITextField *)textField;
- (void)currentEndClickTextFild:(UITextField *)textField;

- (void)addUserPhoneNumber:(NSString *)phoneNumber;

@end

@class AddUserModel;

@interface SendRedSelectUserCell : UITableViewCell<UITextFieldDelegate>



@property (nonatomic, weak) id<SendRedSelectUserCellDelegate> delegate;

@property (nonatomic,assign) BOOL isSelect;

- (void)configWithData:(AddUserModel *)model;


@end
