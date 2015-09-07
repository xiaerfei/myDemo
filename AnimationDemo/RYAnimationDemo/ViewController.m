//
//  ViewController.m
//  RYAnimationDemo
//
//  Created by rongyu100 on 6/11/15.
//  Copyright (c) 2015 RY100. All rights reserved.
//

#import "ViewController.h"
#import "RYAnimationView.h"
#import "RYAnimations.h"
#import "RYRobetLoadingLabel.h"

@interface ViewController ()
@property(strong,nonatomic) RYAnimationView *animationView;
@end

@implementation ViewController

-(RYAnimationView*)animationView{
    if (!_animationView) {
        _animationView = [[RYAnimationView alloc] initWithFrame:self.view.bounds];
        _animationView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"loading_bg.png"]];
        [self.view addSubview:_animationView];
    }
    
    return _animationView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // bg
    UIImage *centerLoadingBgImage = [UIImage imageNamed:@"loading_center_bg.png"];
    UIImageView *centerLoadingBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, centerLoadingBgImage.size.width, centerLoadingBgImage.size.height)];
    centerLoadingBgImageView.image = centerLoadingBgImage;
    centerLoadingBgImageView.center = self.view.center;
    [self.animationView addSubview:centerLoadingBgImageView];

    // loading center
    UIImage *centerLoadingImage = [UIImage imageNamed:@"loading_center.png"];
    UIImageView *centerLoadingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, centerLoadingImage.size.width, centerLoadingImage.size.height)];
    centerLoadingImageView.image = centerLoadingImage;
    centerLoadingImageView.center = self.view.center;
    
    RYPulseAnimationAdaptor *pulseAdaptor = [[RYPulseAnimationAdaptor alloc] init];
    pulseAdaptor.toValue = 0.8;
    pulseAdaptor.speed = 1.5;
    
    [self.animationView addSubview:centerLoadingImageView animationAdaptor:pulseAdaptor];
    
    // arc
    UIImage *centerRorateCircleArc = [UIImage imageNamed:@"loading_rotate_circle_arc.png"];
    UIImageView *centerRorateCircleArcImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, centerRorateCircleArc.size.width, centerRorateCircleArc.size.height)];
    centerRorateCircleArcImageView.image = centerRorateCircleArc;
    centerRorateCircleArcImageView.center = self.view.center;
    
    RYRotationAnimationAdaptor *rotationAdaptor = [[RYRotationAnimationAdaptor alloc] init];
    [self.animationView addSubview:centerRorateCircleArcImageView animationAdaptor:rotationAdaptor];
    
    
    // label
    NSArray *slogan = @[@"金融产品编号",
                        @"房产总估值",
                        @"允许申请的网络产品",
                        @"网络会员年限",
                        @"限制申请的户口地",
                        @"允许申请的申请人",
                        @"申请人月收入",
                        @"允许申请的房产要求",
                        @"申请人的年龄范围",
                        @"最长逾期天数",
                        @"允许申请的房产要求",
                        @"允许申请的征信情况",
                        @"允许申请的负债情况",
                        @"允许申请的经营流水",
                        @"允许申请的网络平台",
                        @"12个月逾期次数",
                        @"限制申请的行业",
                        @"允许申请的营业年限"];
    for (int i = 0; i < 8; i++) {
        RYRobetLoadingLabel *label = [[RYRobetLoadingLabel alloc] initWithTag:i];
        label.textArray = [slogan objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(i * 2, 2)]];
        label.text = slogan[i*2];
        
        RYFlyinAnimationAdaptor *flyinAdaptor = [[RYFlyinAnimationAdaptor alloc] init];
        flyinAdaptor.endPoint = CGPointMake([self getXWithDegree:135-i*45], [self getYWithDegree:135-i*45]);
        flyinAdaptor.delayInSeconds = 0.2 * i;
        [self.animationView addSubview:label animationAdaptor:flyinAdaptor];
    }
}
float degreeToRadian(float degree)
{
    return M_PI/180*degree;
}

- (float)getXWithDegree:(float)degree
{
    return self.view.center.x + 80*cos(degreeToRadian(degree));
}

- (float)getYWithDegree:(float)degree
{
    return self.view.center.y - 80*sin(degreeToRadian(degree));
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
