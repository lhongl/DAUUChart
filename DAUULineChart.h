//
//  PNBar.h
//  PNChartDemo
//
//  Created by hongliang li on 17-11-29.
//  Copyright (c) 2017年 hongliang li . All rights reserved.
//
//


#import <UIKit/UIKit.h>
#import "DAUUChartConst.h"

@interface DAUULineChart : UIView

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
