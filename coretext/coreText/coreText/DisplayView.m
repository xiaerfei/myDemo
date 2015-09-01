//
//  DisplayView.m
//  coreText
//
//  Created by xiaerfei on 15/8/13.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#import "DisplayView.h"
#import <CoreText/CoreText.h>

@implementation DisplayView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    //self.bounds.size.height
    CGContextTranslateCTM(context,0,self.bounds.size.height+ 100 );
    CGContextScaleCTM(context,1,-1);
    // 步骤 3
    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathAddRect(path, NULL, self.bounds);
    CGPathAddEllipseInRect(path, NULL, self.bounds);
    // 步骤 4
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:@"红包已备好"];
    CGFloat fonsize = 8;
    CFNumberRef number = CFNumberCreate(NULL, kCFNumberCGFloatType, &fonsize);
    [attString addAttribute:(id)kCTStrokeWidthAttributeName value:(__bridge id)(number) range:NSMakeRange(0, attString.length)];
    CTFontRef font = CTFontCreateWithName(CFSTR("Georgia"), 25, NULL);
    [attString addAttribute:(id)kCTFontAttributeName value:(__bridge id)font range:NSMakeRange(0, attString.length)];
    [attString addAttribute:(id)kCTForegroundColorAttributeName value:(id)[UIColor yellowColor].CGColor range:NSMakeRange(0, attString.length)];
    
    CTFramesetterRef framesetter =
    CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    CTFrameRef frame =
    CTFramesetterCreateFrame(framesetter,
                             CFRangeMake(0, [attString length]), path, NULL);
    CTFrameDraw(frame, context);
    CFRelease(frame);
    CFRelease(path);
    CFRelease(framesetter);
    
    
}










@end
