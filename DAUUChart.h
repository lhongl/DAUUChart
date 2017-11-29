//
//  PNBar.h
//  PNChartDemo
//
//  Created by hongliang li on 17-11-29.
//  Copyright (c) 2017年 hongliang li . All rights reserved.
//
//

#import <UIKit/UIKit.h>
#import "DAUUChart.h"
#import "DAUUChartConst.h"
#import "DAUULineChart.h"
#import "DAUUBarChart.h"

typedef NS_ENUM(NSInteger, UUChartStyle){
    UUChartStyleLine = 0,
    UUChartStyleBar
};

@class UUChart;
@protocol UUChartDataSource <NSObject>

@required
//横坐标标题数组
- (NSArray *)chartConfigAxisXLabel:(UUChart *)chart;

//数值多重数组
- (NSArray *)chartConfigAxisYValue:(UUChart *)chart;

@optional
//颜色数组
- (NSArray *)chartConfigColors:(UUChart *)chart;

//显示数值范围
- (CGRange)chartRange:(UUChart *)chart;

#pragma mark 折线图专享功能
//标记数值区域
- (CGRange)chartHighlightRangeInLine:(UUChart *)chart;


//需要标准线
- (NSArray *)chartHighlightInLine:(UUChart *)chart;

//需要标准线颜色
- (NSArray *)chartHighlightInLineColor:(UUChart *)chart;


//判断显示横线条
- (BOOL)chart:(UUChart *)chart showHorizonLineAtIndex:(NSInteger)index;

//判断显示横线条
- (BOOL)chart:(UUChart *)chart showVerticalLine:(NSInteger)index;

//判断显示最大最小值
- (BOOL)chart:(UUChart *)chart showMaxMinAtIndex:(NSInteger)index;
@end


@interface DAUUChart : UIView

@property (nonatomic) UUChartStyle chartStyle;


- (id)initWithFrame:(CGRect)rect dataSource:(id<UUChartDataSource>)dataSource style:(UUChartStyle)style;

//展示在什么地方
- (void)showInView:(UIView *)view;

- (void)strokeChart;

@end
