//
//  SendRedPaperCell.m
//  RongYu100
//
//  Created by xiaerfei on 15/8/21.
//  Copyright (c) 2015年 ___RongYu100___. All rights reserved.
//

#import "SendRedPaperCell.h"
#import "UIViewExt.h"

NSString *const kSendRedPaperCellPaymentMethod = @"SendRedPaperCellPaymentMethod";
NSString *const kSendRedPaperCellRedPaperType  = @"SendRedPaperCellRedPaperType";
NSString *const kSendRedPaperCellRedPaperMoney = @"SendRedPaperCellRedPaperMoney";
NSString *const kSendRedPaperCellRedPaperNum   = @"SendRedPaperCellRedPaperNum";
NSString *const kSendRedPaperCellRemark        = @"SendRedPaperCellRemark";

#define SCREEN_BOUND_WIDTH [UIScreen mainScreen].bounds.size.width

@implementation SendRedPaperCell
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
    if ([reuseIdentifier isEqualToString:kSendRedPaperCellPaymentMethod]) {
        self.leftValue.right = SCREEN_BOUND_WIDTH - 30;
        self.leftValue.text = @"钱包余额";
        [self.contentView addSubview:self.leftValue];
    } else if ([reuseIdentifier isEqualToString:kSendRedPaperCellRedPaperType]){
        self.leftValue.right = SCREEN_BOUND_WIDTH - 30;
        self.leftValue.textColor = [UIColor redColor];
        self.leftValue.text = @"固定金额";
        [self.contentView addSubview:self.leftValue];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if ([reuseIdentifier isEqualToString:kSendRedPaperCellRedPaperMoney]) {
        self.leftValue.width  = 15;
        self.leftValue.right = SCREEN_BOUND_WIDTH - 30;
        
        self.leftValue.text = @"元";
        [self.contentView addSubview:self.leftValue];
        
        self.leftValueWrite.right = self.leftValue.left-1;
        self.leftValueWrite.placeholder = @"请填写红包金额";
        [self.contentView addSubview:self.leftValueWrite];
        
        
    } else if ([reuseIdentifier isEqualToString:kSendRedPaperCellRedPaperNum]) {
        self.leftValue.width  = 15;
        self.leftValue.right = SCREEN_BOUND_WIDTH - 30;
        
        self.leftValue.text = @"个";
        [self.contentView addSubview:self.leftValue];
        
        self.leftValueWrite.right = self.leftValue.left-1;
        self.leftValueWrite.placeholder = @"请填写红包个数";
        [self.contentView addSubview:self.leftValueWrite];
    } else if ([reuseIdentifier isEqualToString:kSendRedPaperCellRemark]) {
        [self.contentView addSubview:self.remarkText];
    }
}

- (void)configWithData:(NSString *)data reuseIdentifier:(NSString *)reuseIdentifier
{
    self.textLabel.text = data;
    NSLog(@"%@",self.superview);
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
    // 正则判断
    if (textField.text.length == 0) {
        return;
    }
    BOOL ret = [self isNumberOfStr:textField.text];
    if (ret == NO) {
        NSLog(@"只能为数字");
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"只能填写数字" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alertView show];
        textField.text = @"";
    }
    
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

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([self.delegate respondsToSelector:@selector(currentBeginClickTextFild:reuseIdentifier:)]) {
        [self.delegate currentBeginClickTextFild:textView reuseIdentifier:_sendRedPaperFlag];
    }

    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(currentEndClickTextFild:reuseIdentifier:)]) {
        [self.delegate currentEndClickTextFild:textView reuseIdentifier:_sendRedPaperFlag];
    }
        if (textView.text.length == 0) {
            textView.text = @"恭喜发财，万事如意！";
        }
    return YES;
}

#pragma mark - private methods
- (BOOL)isNumberOfStr:(NSString *)str
{
    NSString *regex = @"^[0-9|.]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isValid = [predicate evaluateWithObject:str];
    return isValid;
}


#pragma mark - getters
- (UILabel *)leftValue
{
    if (_leftValue == nil) {
        _leftValue = [[UILabel alloc] initWithFrame:CGRectMake(0, 11, 90, 20)];
        _leftValue.font = [UIFont systemFontOfSize:13];
//        _leftValue.backgroundColor = [UIColor grayColor];
        _leftValue.textAlignment = NSTextAlignmentRight;
    }
    return _leftValue;
}

- (UITextField *)leftValueWrite
{
    if (_leftValueWrite == nil) {
        _leftValueWrite = [[UITextField alloc] initWithFrame:CGRectMake(0, 11, 90, 20)];
//        _leftValueWrite.backgroundColor = [UIColor grayColor];
        _leftValueWrite.delegate = self;
        _leftValueWrite.textAlignment = NSTextAlignmentRight;
        _leftValueWrite.font = [UIFont systemFontOfSize:12];
        _leftValueWrite.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        _leftValueWrite.returnKeyType = UIReturnKeyDone;
    }
    return _leftValueWrite;
}

- (UITextView *)remarkText
{
    if (_remarkText == nil) {
        _remarkText = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_BOUND_WIDTH, 80)];
        _remarkText.delegate = self;
        _remarkText.text = @"恭喜发财，万事如意！";
        _remarkText.textColor = [UIColor colorWithRed:187.0f/255.0f green:187.0f/255.0f blue:187.0f/255.0f alpha:1];
    }
    return _remarkText;
}

@end
