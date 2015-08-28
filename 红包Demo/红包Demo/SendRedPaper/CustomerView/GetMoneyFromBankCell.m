//
//  GetMoneyFromBankCell.m
//  红包Demo
//
//  Created by xiaerfei on 15/8/24.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#import "GetMoneyFromBankCell.h"



NSString *const kGetMoneyFromBankOverage  = @"GetMoneyFromBankOverage";
NSString *const kGetMoneyFromBankType     = @"GetMoneyFromBankType";
NSString *const kGetMoneyFromBankUserName = @"GetMoneyFromBankUserName";
NSString *const kGetMoneyFromBankName     = @"GetMoneyFromBankName";
NSString *const kGetMoneyFromBankNum      = @"GetMoneyFromBankNum";
NSString *const kGetMoneyFromBankMoney    = @"GetMoneyFromBankMoney";
NSString *const kGetMoneyFromBankRemark   = @"GetMoneyFromBankRemark";

@implementation GetMoneyFromBankCell
{
    NSString *_sendRedPaperFlag;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUIWithReuseIdentifier:reuseIdentifier];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configUIWithReuseIdentifier:(NSString *)reuseIdentifier
{
    _sendRedPaperFlag = reuseIdentifier;
    if ([reuseIdentifier isEqualToString:kGetMoneyFromBankOverage]) {
        self.textLabel.text = @"钱包余额";
        self.leftValue.text = @"500.00元";
        [self.contentView addSubview:self.leftValue];
    } else if ([reuseIdentifier isEqualToString:kGetMoneyFromBankType]){
        self.textLabel.text = @"提现方式";
        self.leftValue.text = @"银行卡";
        [self.contentView addSubview:self.leftValue];
    } else if ([reuseIdentifier isEqualToString:kGetMoneyFromBankUserName]) {
        self.textLabel.text = @"姓　　名";
        self.leftTextField.placeholder = @"请正确填写用户名";
        [self.contentView addSubview:self.leftTextField];
    } else if ([reuseIdentifier isEqualToString: kGetMoneyFromBankNum]) {
        self.textLabel.text = @"卡　　号";
        self.leftTextField.placeholder = @"请正确填写银行卡号";
        self.leftTextField.keyboardType = UIKeyboardTypePhonePad;
        [self.contentView addSubview:self.leftTextField];
    } else if ([reuseIdentifier isEqualToString:kGetMoneyFromBankName]) {
        self.textLabel.text = @"银　　行";
        self.leftTextField.placeholder = @"请填写开户银行全称";
        [self.contentView addSubview:self.leftTextField];
    } else if ([reuseIdentifier isEqualToString:kGetMoneyFromBankMoney]) {
        self.textLabel.text = @"金　　额";
        self.leftTextField.placeholder = @"请填写提现金额";
        [self.contentView addSubview:self.leftTextField];
    } else if ([reuseIdentifier isEqualToString:kGetMoneyFromBankRemark]) {
        self.textLabel.text = @"备　　注";
        self.leftTextField.placeholder = @"请填写提现备注";
        [self.contentView addSubview:self.leftTextField];
    }
}

#pragma mark - update data
- (void)configWithData:(NSString *)data reuseIdentifier:(NSString *)reuseIdentifier
{
    
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(currentBeginClickTextFild:reuseIdentifier:)]) {
        [self.delegate currentBeginClickTextFild:textField reuseIdentifier:_sendRedPaperFlag];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self isMatchesOfTextField:textField reuseIdentifier:_sendRedPaperFlag];
    if ([self.delegate respondsToSelector:@selector(currentEndClickTextFild:reuseIdentifier:)]) {
        [self.delegate currentEndClickTextFild:textField reuseIdentifier:_sendRedPaperFlag];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(currentEndClickTextFild:reuseIdentifier:)]) {
        [self.delegate currentEndClickTextFild:textField reuseIdentifier:_sendRedPaperFlag];
    }
    return YES;
}

#pragma mark - private methods
- (void)isMatchesOfTextField:(UITextField *)textField reuseIdentifier:(NSString *)reuseIdentifier
{
    if (textField.text.length == 0) {
        return;
    }
    if ([reuseIdentifier isEqualToString:kGetMoneyFromBankNum]) {
        NSString *regex = @"^(\\d{7,25})$";
        BOOL isValid = [self matchesOfStr:textField.text regex:regex];
        if (isValid == NO) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"银行卡位数不对" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alertView show];
            textField.text = @"";
        }
    } else if ([reuseIdentifier isEqualToString:kGetMoneyFromBankMoney]) {
        NSString *regex = @"^[0-9|.]+$";
        BOOL isValid = [self matchesOfStr:textField.text regex:regex];
        if (isValid == NO) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"只能填写数字" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alertView show];
            textField.text = @"";
        }
    }
}

- (BOOL)matchesOfStr:(NSString *)str regex:(NSString *)regex
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isValid = [predicate evaluateWithObject:str];
    return isValid;
    
}
#pragma mark - getters

- (UILabel *)leftValue
{
    if (_leftValue == nil) {
        _leftValue = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-150-15, 15, 150, 20)];
        _leftValue.font = [UIFont systemFontOfSize:15];
        _leftValue.textAlignment = NSTextAlignmentRight;
//        _leftValue.backgroundColor = [UIColor grayColor];
    }
    return _leftValue;
}

- (UITextField *)leftTextField
{
    if (_leftTextField == nil) {
        _leftTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 15, 200, 20)];
        _leftTextField.font = [UIFont systemFontOfSize:13];
//        _leftTextField.backgroundColor = [UIColor grayColor];
        _leftTextField.delegate = self;
    }
    return _leftTextField;
}

@end
