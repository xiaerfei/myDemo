//
//  SendRedPaperViewController.h
//  RongYu100
//
//  Created by xiaerfei on 15/8/21.
//  Copyright (c) 2015年 ___RongYu100___. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SendRedPaperType){
    SendRedPaperTypeOfRegularMoney,//固定金额
    SendRedPaperTypeOfChangeMoney, //浮动金额
};


@interface SendRedPaperViewController : UIViewController

@property (nonatomic, assign) SendRedPaperType sendRedPaperType;

@end
