//
//  SendRedPaperCell.h
//  RongYu100
//
//  Created by xiaerfei on 15/8/21.
//  Copyright (c) 2015年 ___RongYu100___. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const kSendRedPaperCellPaymentMethod;
extern NSString *const kSendRedPaperCellRedPaperType;
extern NSString *const kSendRedPaperCellRedPaperMoney;
extern NSString *const kSendRedPaperCellRedPaperNum;
extern NSString *const kSendRedPaperCellRemark;


@protocol SendRedPaperCellDelegate <NSObject>

- (void)currentBeginClickTextFild:(id)textField reuseIdentifier:(NSString *)reuseIdentifier;
- (void)currentEndClickTextFild:(id)textField reuseIdentifier:(NSString *)reuseIdentifier;
@end

@interface SendRedPaperCell : UITableViewCell<UITextFieldDelegate,UITextViewDelegate>

@property (nonatomic, strong) UILabel *leftValue;
@property (nonatomic, strong) UITextField *leftValueWrite;
@property (nonatomic, strong) UITextView *remarkText;

@property (nonatomic, weak) id<SendRedPaperCellDelegate> delegate;


- (void)configWithData:(NSString *)data reuseIdentifier:(NSString *)reuseIdentifier;

@end
