//
//  GetMoneyFromBankCell.h
//  红包Demo
//
//  Created by xiaerfei on 15/8/24.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const kGetMoneyFromBankOverage;
extern NSString *const kGetMoneyFromBankType;
extern NSString *const kGetMoneyFromBankUserName;
extern NSString *const kGetMoneyFromBankName;
extern NSString *const kGetMoneyFromBankNum;
extern NSString *const kGetMoneyFromBankMoney;
extern NSString *const kGetMoneyFromBankRemark;


@protocol GetMoneyFromBankCellDelegate <NSObject>

- (void)currentBeginClickTextFild:(UITextField *)textField reuseIdentifier:(NSString *)reuseIdentifier;
- (void)currentEndClickTextFild:(UITextField *)textField reuseIdentifier:(NSString *)reuseIdentifier;
@end

@interface GetMoneyFromBankCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *leftValue;
@property (nonatomic, strong) UITextField *leftTextField;

@property (nonatomic, weak) id<GetMoneyFromBankCellDelegate> delegate;

- (void)configWithData:(NSString *)data reuseIdentifier:(NSString *)reuseIdentifier;

@end
