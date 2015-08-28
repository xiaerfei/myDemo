//
//  SendRedSelectUser.m
//  红包Demo
//
//  Created by xiaerfei on 15/8/21.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#import "SendRedSelectUserCell.h"
#import "UIViewExt.h"
#import "AddUserModel.h"
NSString *const kInputPhoneNumber = @"InputPhoneNumber";
NSString *const kSelectUserFriend = @"SelectUserFriend";


@interface SendRedSelectUserCell ()

@property (nonatomic, strong) UITextField *phoneNumber;
@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) UIImageView *userIconImage;
@property (nonatomic, strong) UILabel *userName;
@property (nonatomic, strong) UIImageView *selectImage;


@end

@implementation SendRedSelectUserCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUIWithReuseIdentifier:reuseIdentifier];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configUIWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if ([reuseIdentifier isEqualToString:kInputPhoneNumber]) {
        [self.contentView addSubview:self.phoneNumber];
        [self.contentView addSubview:self.addBtn];
        
        self.phoneNumber.width = self.addBtn.left - 10-5;
        
    } else {
        [self.contentView addSubview:self.userIconImage];
        [self.contentView addSubview:self.userName];
        [self.contentView addSubview:self.selectImage];
    }
}
#pragma mark - update data
- (void)configWithData:(AddUserModel *)model
{
    self.userName.text = model.userName;
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(currentBeginClickTextFild:)]) {
        [self.delegate currentBeginClickTextFild:textField];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    BOOL ret = [self isNumberOfStr:textField.text];
    if (ret == NO) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"手机号码格式不对" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alertView show];
        textField.text = @"";
    }

    if ([self.delegate respondsToSelector:@selector(currentEndClickTextFild:)]) {
        [self.delegate currentEndClickTextFild:textField];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(currentEndClickTextFild:)]) {
        [self.delegate currentEndClickTextFild:textField];
    }
    return YES;
}

#pragma mark - event responses
- (void)addBtnAction
{
    [self.phoneNumber resignFirstResponder];
    if (self.phoneNumber.text.length == 0 || self.phoneNumber.text.length != 11) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(addUserPhoneNumber:)]) {
        [self.delegate addUserPhoneNumber:self.phoneNumber.text];
    }
    self.phoneNumber.text = @"";
}
#pragma mark - private methods
- (BOOL)isNumberOfStr:(NSString *)str
{
    NSString *regex = @"^(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isValid = [predicate evaluateWithObject:str];
    return isValid;
}
#pragma mark - getters
- (UITextField *)phoneNumber
{
    if (_phoneNumber == nil) {
        _phoneNumber = [[UITextField alloc] initWithFrame:CGRectMake(10, 12, 200, 20)];
        _phoneNumber.placeholder = @"请填写联系人电话";
        _phoneNumber.font = [UIFont systemFontOfSize:13];
        _phoneNumber.keyboardType = UIKeyboardTypePhonePad;
        _phoneNumber.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneNumber.delegate = self;
    }
    return _phoneNumber;
}

- (UIButton *)addBtn
{
    if (_addBtn == nil) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_addBtn setTitle:@"添加" forState:UIControlStateNormal];
        [_addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _addBtn.backgroundColor = [UIColor colorWithRed:224.0f/255.0f green:53.0f/255.0f blue:62.0f/255.0f alpha:1];
        _addBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-60, 10, 50, 24);
        [_addBtn addTarget:self action:@selector(addBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

- (UIImageView *)userIconImage
{
    if (_userIconImage == nil) {
        _userIconImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        _userIconImage.backgroundColor = [UIColor grayColor];
    }
    return _userIconImage;
}

- (UILabel *)userName
{
    if (_userName == nil) {
        _userName = [[UILabel alloc] initWithFrame:CGRectMake(55, 20, 150, 20)];
        _userName.font = [UIFont systemFontOfSize:15];
        _userName.text = @"周杰伦";
        _userName.backgroundColor = [UIColor grayColor];
    }
    return _userName;
}

- (UIImageView *)selectImage
{
    if (_selectImage == nil) {
        _selectImage = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 50, 20, 20, 20)];
        _selectImage.backgroundColor = [UIColor grayColor];
    }
    return _selectImage;

}

- (void)setIsSelect:(BOOL)isSelect
{
    _isSelect = isSelect;
    if (isSelect) {
        self.selectImage.backgroundColor = [UIColor redColor];
    } else {
        self.selectImage.backgroundColor = [UIColor grayColor];
    }
}

@end
