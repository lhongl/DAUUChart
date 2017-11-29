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

@interface DAUUBarChart : UIView

@property (strong, nonatomic) NSArray * xLabels;
@property (strong, nonatomic) NSArray * yLabels;
@property (strong, nonatomic) NSArray * yValues;
@property (strong, nonatomic) NSArray * colors;

@property (nonatomic) float xLabelWidth;
@property (nonatomic) float yValueMax;
@property (nonatomic) float yValueMin;
@property (nonatomic) CGRange chooseRange;


- (NSArray *)chartLabelsForX;

- (void)strokeChart;

@end
