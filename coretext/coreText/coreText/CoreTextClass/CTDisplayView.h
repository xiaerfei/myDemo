//
//  CTDisplayView.h
//  coreText
//
//  Created by xiaerfei on 15/8/17.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreTextData.h"

@interface CTDisplayView : UIView <UIGestureRecognizerDelegate>

@property (strong, nonatomic) CoreTextData * data;

@end
