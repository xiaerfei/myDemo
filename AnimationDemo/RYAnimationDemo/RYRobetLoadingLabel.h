//
//  RYRobetLoadingLabel.h
//  RYAnimationDemo
//
//  Created by rongyu100 on 6/11/15.
//  Copyright (c) 2015 RY100. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RYRobetLoadingLabel : UILabel
- (instancetype)initWithTag:(NSInteger)tagp;
@property(strong,nonatomic) NSArray* textArray;

-(void)reloadText;
@end
