//
//  ViewController.m
//  SHLTagLabelDemo
//
//  Created by 开发机 on 14-7-23.
//  Copyright (c) 2014年 showhilllee. All rights reserved.
//

#import "ViewController.h"

#import "SHLTagLabel.h"

@interface ViewController () <SHLTagLabelDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SHLTagLabel* tagList = [[SHLTagLabel alloc] initWithFrame:CGRectMake(20.0f, 70.0f, 280.0f, 100.0f)];
    tagList.delegate = self;
    [self.view addSubview:tagList];
    
    NSArray *array = [[NSArray alloc] initWithObjects:@"0-9",@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"Other", @"All", @"Music", @"Something maybe need to show a long long title", nil];
    [tagList setTags:array];
}

- (void)tapedOnLabelTag:(NSInteger)labTag labelText:(NSString *)text {
    NSLog(@"tag:%d--->%@", labTag, text);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
