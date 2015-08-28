//
//  SendReadyRedPaper.h
//  红包Demo
//
//  Created by xiaerfei on 15/8/21.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SendReadyRedPaper;
@protocol SendReadyRedPaperDelegate <NSObject>

- (void)clickSendReadyRedPaper:(SendReadyRedPaper *)sendReadyRedPaper isDismiss:(BOOL)dismiss;

@end

@interface SendReadyRedPaper : UIView

@property (nonatomic, weak) id<SendReadyRedPaperDelegate> delegate;

@end
