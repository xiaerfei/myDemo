//
//  RYAnimationView.m
//  RYAnimationDemo
//
//  Created by rongyu100 on 6/11/15.
//  Copyright (c) 2015 RY100. All rights reserved.
//

#import "RYAnimationView.h"
#import "RYAnimationAdaptor.h"

@interface RYAnimationView ()
@property (nonatomic, strong) NSMutableArray *animations;
@end


@implementation RYAnimationView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setup];
    }
    return self;
}

- (void)setup
{
    [self setBackgroundColor:[UIColor clearColor]];
    self.animations = [NSMutableArray array];
}

-(void)addSubview:(UIView *)view animationAdaptor:(RYAnimationAdaptor*)adaptor{
    if (view) {
        [super addSubview:view];
    }
    
    if (adaptor) {
        adaptor.targetView = view;
        [adaptor play];
        
        [self.animations addObject:adaptor];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
