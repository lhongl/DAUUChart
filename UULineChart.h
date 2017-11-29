//
//  UULineChart.h
//  UUChartDemo
//
//  Created by shake on 14-7-24.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "UUChartConst.h"

@interface UULineChart : UIView

@property (strong, nonatomic) NSArray * xLabels;
@property (strong, nonatomic) NSArray * yLabels;
@property (strong, nonatomic) NSArray * yValues;
@property (strong, nonatomic) NSArray * colors;
@property (strong, nonatomic) NSArray *lineArray;
@property (strong, nonatomic) NSArray *lineColorArray;
@property (strong, nonatomic) NSMutableArray *showHorizonLine;
@property (strong, nonatomic) NSMutableArray *showVerticalLine;
@property (strong, nonatomic) NSMutableArray *showMaxMinArray;

@property (nonatomic) CGFloat xLabelWidth;
@property (nonatomic) CGFloat yValueMin;
@property (nonatomic) CGFloat yValueMax;
@property (nonatomic, strong)UIView *lineImage;
@property (nonatomic, assign)NSInteger labelCount;
@property (nonatomic, assign) CGRange markRange;

@property (nonatomic, assign) CGRange chooseRange;

-(void)strokeChart;

- (NSArray *)chartLabelsForX;

@end
