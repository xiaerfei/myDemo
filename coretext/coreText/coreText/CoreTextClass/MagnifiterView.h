//
//  MagnifiterView.h
//  coreText
//
//  Created by xiaerfei on 15/8/18.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MagnifiterView : UIView

@property (weak, nonatomic) UIView *viewToMagnify;
@property (nonatomic) CGPoint touchPoint;

@end
