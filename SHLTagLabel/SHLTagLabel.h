//
//  SHLTagLabel.h
//  SHLTagLabelDemo
//
//  Created by 开发机 on 14-7-23.
//  Copyright (c) 2014年 showhilllee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SHLTagLabelDelegate <NSObject>

- (void) tapedOnLabelTag:(NSInteger)labTag labelText:(NSString*)text;

@end

@interface SHLTagLabel : UIView 

@property (nonatomic) float totalHeight;//总的高度
@property (nonatomic, strong) UIView* view;
@property (nonatomic, strong) NSArray* textArray;
@property (nonatomic, strong) UIColor* textColor;
@property (nonatomic, setter=setLabelBackgroundColor:) UIColor* backbroundColor;
@property (nonatomic, unsafe_unretained) id <SHLTagLabelDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame WithTextColor:(UIColor*)color;
- (void)setTags:(NSArray *)array;
- (void)display;
- (CGSize)fittedSize;

@end
