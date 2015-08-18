//
//  CoreTextUtils.h
//  coreText
//
//  Created by xiaerfei on 15/8/18.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CoreTextData;
@class CoreTextLinkData;

@interface CoreTextUtils : NSObject

+ (CoreTextLinkData *)touchLinkInView:(UIView *)view atPoint:(CGPoint)point data:(CoreTextData *)data;
+ (CFIndex)touchContentOffsetInView:(UIView *)view atPoint:(CGPoint)point data:(CoreTextData *)data;


@end
