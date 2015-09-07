//
//  RYAnimationAdaptor.h
//  RYAnimationDemo
//
//  Created by rongyu100 on 6/11/15.
//  Copyright (c) 2015 RY100. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface RYAnimationAdaptor : NSObject

@property (nonatomic, weak) UIView *targetView;
@property (nonatomic, copy) NSString *key;

// animation could be play one by one
@property (nonatomic, strong) RYAnimationAdaptor *nextAnimation;

// factor used to control animation speed, default 1.0
@property (nonatomic, assign) CGFloat animationFactor;

@property (nonatomic, assign) CGFloat speed;
@property (nonatomic, assign) CGFloat delayInSeconds;

- (void)play;
- (void)commit;

- (CGFloat)animationDuration:(CGFloat)duration;
- (CGFloat)animationBeginTime;

- (void)setup;
/*
 * implemented by subclass
 */

- (CAAnimation *)animation;
- (void)drawAnimation:(CGContextRef)context;

- (void)beforeAnimation;
- (void)afterAnimation;
- (void)didAnimation;

@end
