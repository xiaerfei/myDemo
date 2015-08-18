//
//  ViewController.m
//  coreText
//
//  Created by xiaerfei on 15/8/12.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#import "ViewController.h"
#import <CoreText/CoreText.h>
#import "DisplayView.h"
#import "CTFrameParserConfig.h"
#import "CoreTextData.h"
#import "CTFrameParser.h"
#import "CTDisplayView.h"
#import "UIViewExt.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSMutableAttributedString *mabstring = [[NSMutableAttributedString alloc]initWithString:@"This is a test of characterAttribute. 中文字符"];
//    CTFontRef font = CTFontCreateWithName(CFSTR("Georgia"), 40, NULL);
//    [mabstring addAttribute:(id)kCTFontAttributeName value:(__bridge id)font range:NSMakeRange(0, 4)];
//    self.attributeLabel.attributedText = mabstring;
    
    CTDisplayView *displayView = [[CTDisplayView alloc] initWithFrame:CGRectMake(10,20, [UIScreen mainScreen].bounds.size.width -20, 0)];
    [self.view addSubview:displayView];

    
    
    CTFrameParserConfig *config = [[CTFrameParserConfig alloc] init];
    config.width = displayView.width;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"content" ofType:@"json"];
    CoreTextData *data = [CTFrameParser parseTemplateFile:path config:config];
    displayView.data = data;
    displayView.height = data.height;
    displayView.backgroundColor = [UIColor whiteColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
