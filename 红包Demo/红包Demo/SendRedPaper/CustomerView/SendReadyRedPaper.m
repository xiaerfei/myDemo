//
//  SendReadyRedPaper.m
//  红包Demo
//
//  Created by xiaerfei on 15/8/21.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#import "SendReadyRedPaper.h"
#import "UIViewExt.h"

@interface SendReadyRedPaper ()
@property (strong, nonatomic)  UIImageView *sendPaperBg;
@property (strong, nonatomic)  UIImageView *sendPaperImage;
@property (strong, nonatomic)  UILabel *sendPaperTip;
@property (strong, nonatomic)  UIButton *sendRedPaperAction;
@property (strong, nonatomic)  UITapGestureRecognizer *tapGesture;
@end

@implementation SendReadyRedPaper

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
        [self autoLayoutUI];
    }
    return self;
}

- (void)addSubviews
{
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7f];
    
    [self addGestureRecognizer:self.tapGesture];
    [self addSubview: self.sendPaperBg];

    [self.sendPaperBg addSubview:self.sendPaperImage];
    
    [self.sendPaperBg addSubview:self.sendPaperTip];
    
    [self.sendPaperBg addSubview:self.sendRedPaperAction];
    
}

- (void)autoLayoutUI
{
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    self.sendPaperBg.top = (height - 64 - self.sendPaperBg.height)/2.0f;
    
    self.sendPaperBg.left = (self.width - self.sendPaperBg.width)/2.0f;
    self.sendPaperImage.left = (self.sendPaperBg.width - self.sendPaperImage.width)/2.0f;
    
    self.sendPaperTip.top = self.sendPaperImage.bottom + 50;
    self.sendPaperTip.left = (self.sendPaperBg.width - self.sendPaperTip.width)/2.0f;
    
    self.sendRedPaperAction.bottom = self.sendPaperBg.height - self.sendRedPaperAction.height - 20;
    self.sendRedPaperAction.left = (self.sendPaperBg.width - self.sendRedPaperAction.width)/2.0f;
}

#pragma mark - event response

- (void)sendRedPaperActionBtn
{
    if ([self.delegate respondsToSelector:@selector(clickSendReadyRedPaper:isDismiss:)]) {
        [self.delegate clickSendReadyRedPaper:self isDismiss:NO];
    }
}

- (void)tapGestureAction
{
    if ([self.delegate respondsToSelector:@selector(clickSendReadyRedPaper:isDismiss:)]) {
        [self.delegate clickSendReadyRedPaper:self isDismiss:YES];
    }
}

#pragma mark - getters

- (UIImageView *)sendPaperBg
{
    if (_sendPaperBg == nil) {
        _sendPaperBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 291, 400)];
        _sendPaperBg.image = [UIImage imageNamed:@"starRedPaper"];
        _sendPaperBg.userInteractionEnabled = YES;
    }
    return _sendPaperBg;
}

- (UIImageView *)sendPaperImage
{
    if (_sendPaperImage == nil) {
        _sendPaperImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 75, 75)];
        _sendPaperImage.image = [UIImage imageNamed:@"knockButton"];
    }
    return _sendPaperImage;
}

- (UILabel *)sendPaperTip
{
    if (_sendPaperTip == nil) {
        _sendPaperTip = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 100, 20)];
        _sendPaperTip.font = [UIFont systemFontOfSize:20];
        _sendPaperTip.text = @"红包已备好";
        _sendPaperTip.textColor = [UIColor yellowColor];
//        _sendPaperTip.backgroundColor = [UIColor grayColor];
    }
    return _sendPaperTip;
}

- (UIButton *)sendRedPaperAction
{
    if (_sendRedPaperAction == nil) {
        _sendRedPaperAction = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_sendRedPaperAction setTitle:@"发红包" forState:UIControlStateNormal];
        [_sendRedPaperAction setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _sendRedPaperAction.backgroundColor = [UIColor colorWithRed:234.0f/255.0f green:200.0f/255.0f blue:56.0f/255.0f alpha:1];
        _sendRedPaperAction.frame = CGRectMake(30, 200, 200, 40);
        [_sendRedPaperAction addTarget:self action:@selector(sendRedPaperActionBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendRedPaperAction;
}

- (UITapGestureRecognizer *)tapGesture
{
    if (_tapGesture == nil) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction)];
    }
    return _tapGesture;
}

@end
