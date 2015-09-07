//
//  RYAnimationView.h
//  RYAnimationDemo
//
//  Created by rongyu100 on 6/11/15.
//  Copyright (c) 2015 RY100. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RYAnimationAdaptor;

@interface RYAnimationView : UIView

-(void)addSubview:(UIView *)view animationAdaptor:(RYAnimationAdaptor*)adaptor;

@end
