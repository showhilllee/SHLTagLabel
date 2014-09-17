//
//  SHLTagLabel.m
//  SHLTagLabelDemo
//
//  Created by 开发机 on 14-7-23.
//  Copyright (c) 2014年 showhilllee. All rights reserved.
//

#import "SHLTagLabel.h"
#import <QuartzCore/QuartzCore.h>

#define CORNER_RADIUS 15.0f//圆角
#define LABEL_MARGIN 15.0f//Label之间的横向间距
#define BOTTOM_MARGIN 25.0f//Label之间的纵向间距
#define FONT_SIZE 25.0f//字体大小
#define HORIZONTAL_PADDING 13.0f//Label的宽
#define VERTICAL_PADDING 3.0f//Label的高
#define BACKGROUND_COLOR [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00]//Label的背景色
#define TEXT_COLOR [UIColor grayColor]//字体颜色
#define TEXT_SHADOW_COLOR [UIColor whiteColor]//阴影颜色
#define TEXT_SHADOW_OFFSET CGSizeMake(0.0f, 1.0f)//阴影大小
#define BORDER_COLOR [UIColor lightGrayColor].CGColor//圆圈的颜色
#define BORDER_WIDTH 0.8f//圆圈线条的粗细

@interface SHLTagLabel () {
    UIView *view;
    NSArray *textArray;
    CGSize sizeFit;
    UILabel* shlTabLabel;
}

@end

@implementation SHLTagLabel

@synthesize totalHeight, view, textArray;
@synthesize delegate;
@synthesize textColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:view];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame WithTextColor:(UIColor*)color
{
    self = [super initWithFrame:frame];
    if (self) {
        textColor = color;
        [self addSubview:view];
    }
    return self;
}

- (void)setTags:(NSArray *)array
{
    textArray = [[NSArray alloc] initWithArray:array];
    sizeFit = CGSizeZero;
    [self display];
}

- (void)setLabelBackgroundColor:(UIColor *)color
{
    self.backbroundColor = color;
    [self display];
}

- (void)display
{
    for (UILabel *subview in [self subviews]) {
        [subview removeFromSuperview];
    }
    totalHeight = 0;
    CGRect previousFrame = CGRectZero;
    BOOL gotPreviousFrame = NO;
    
    for (NSInteger txtNum = 0; txtNum < textArray.count; txtNum++) {
        
        NSString* text = [[NSString alloc] init];
        text = textArray[txtNum];
        
        CGSize textSize = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:CGSizeMake(self.frame.size.width, 1500) lineBreakMode:NSLineBreakByCharWrapping];
        textSize.width += HORIZONTAL_PADDING*2;
        textSize.height += VERTICAL_PADDING*2;
        
        UILabel *label = nil;
        
        if (!gotPreviousFrame) {
            label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, textSize.width, textSize.height)];
            totalHeight = textSize.height;
        } else {
            CGRect newRect = CGRectZero;
            if (previousFrame.origin.x + previousFrame.size.width + textSize.width + LABEL_MARGIN > self.frame.size.width) {
                newRect.origin = CGPointMake(0, previousFrame.origin.y + textSize.height + BOTTOM_MARGIN);
                totalHeight += textSize.height + BOTTOM_MARGIN;
            } else {
                newRect.origin = CGPointMake(previousFrame.origin.x + previousFrame.size.width + LABEL_MARGIN, previousFrame.origin.y);
            }
            newRect.size = textSize;
            label = [[UILabel alloc] initWithFrame:newRect];
        }
        previousFrame = label.frame;
        gotPreviousFrame = YES;
        [label setFont:[UIFont systemFontOfSize:FONT_SIZE]];
        
        [label setBackgroundColor:self.backbroundColor ? self.backbroundColor : BACKGROUND_COLOR];
        [label setTextColor:textColor ? textColor : TEXT_COLOR];
        
        [label setText:text];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setShadowColor:TEXT_SHADOW_COLOR];
        [label setShadowOffset:TEXT_SHADOW_OFFSET];
        [label.layer setMasksToBounds:YES];
        [label.layer setCornerRadius:CORNER_RADIUS];
        [label.layer setBorderColor:BORDER_COLOR];
        [label.layer setBorderWidth: BORDER_WIDTH];
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByCharWrapping;
        [self addSubview:label];
        
        label.tag = txtNum;
        label.userInteractionEnabled = YES;
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap:)];
        [label addGestureRecognizer:tap];
        
        shlTabLabel = label;
    }
    sizeFit = CGSizeMake(self.frame.size.width, totalHeight + 1.0f);
    
    CGRect selfFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, totalHeight);
    self.frame = selfFrame;
}

- (CGSize)fittedSize
{
    return sizeFit;
}

- (void) labelTap:(UITapGestureRecognizer*)tap {
    UIView* labView = tap.view;
    NSInteger tapTag = labView.tag;
    
    if (delegate && [delegate respondsToSelector:@selector(tapedOnLabelTag:labelText:)]) {
        [delegate tapedOnLabelTag:tapTag labelText:textArray[tapTag]];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
