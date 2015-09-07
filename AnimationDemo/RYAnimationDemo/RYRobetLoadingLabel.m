//
//  RYRobetLoadingLabel.m
//  RYAnimationDemo
//
//  Created by rongyu100 on 6/11/15.
//  Copyright (c) 2015 RY100. All rights reserved.
//

#import "RYRobetLoadingLabel.h"

@implementation RYRobetLoadingLabel

#pragma mark - Init
- (instancetype)initWithTag:(NSInteger)tag{
    self = [super init];
    
    if (self) {
        self.tag = tag;
        [self setup];
    }
    
    return self;
}

-(void)setup{
    [self setupFrame];
    [self setupUI];
}

-(void)setupUI{
    self.textColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor clearColor];
}

/*        0   1   2
 *         \  |  /
 *          \ | /
 *           \|/
 *     7 -----|------ 3
 *           /|\
 *          / | \
 *         /  |  \
 *        6   5   4
 */
-(void)setupFrame{
    NSInteger labelWidth = 160, labelHeight = 30;
    NSInteger screenWidth = [UIScreen mainScreen].bounds.size.width;
    NSInteger screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    if (self.tag == 0) {
        self.frame = CGRectMake(-labelWidth, -labelHeight, labelWidth, labelHeight);
    } else if(self.tag == 1){
        self.frame = CGRectMake(screenWidth / 2, -labelHeight, labelWidth, labelHeight);
    } else if(self.tag == 2){
        self.frame = CGRectMake(screenWidth + labelWidth, -labelHeight, labelWidth, labelHeight);
    } else if(self.tag == 3){
        self.frame = CGRectMake(screenWidth + labelWidth, screenHeight / 2, labelWidth, labelHeight);
    } else if(self.tag == 4){
        self.frame = CGRectMake(screenWidth + labelWidth, labelHeight + screenHeight, labelWidth, labelHeight);
    } else if(self.tag == 5){
        self.frame = CGRectMake(screenWidth / 2, labelHeight + screenHeight, labelWidth, labelHeight);
    } else if(self.tag == 6){
        self.frame = CGRectMake(-labelWidth, -labelHeight, labelWidth, labelHeight);
    } else if(self.tag == 7){
        self.frame = CGRectMake(-labelWidth, screenHeight / 2, labelWidth, labelHeight);
    }
}

#pragma mark - Help
-(void)reloadText{
    self.text = [self.text isEqualToString:self.textArray[0]] ? self.textArray[1]:self.textArray[0];
}

@end
