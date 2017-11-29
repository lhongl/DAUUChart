//
//  UULineChart.m
//  UUChartDemo
//
//  Created by shake on 14-7-24.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import "UULineChart.h"
#import "UUChartConst.h"
#import "UUChartLabel.h"
#define YkCount 10.0
@implementation UULineChart {
    NSHashTable *_chartLabelsForX;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        [self SET_line];
    }
    return self;
}

- (void)SET_line{
    self.lineImage = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width-7, 10, 10, self.frame.size.height - 30)];
    self.lineImage.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1];
    [self addSubview:self.lineImage];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(4, 0, 2, self.lineImage.frame.size.height-3)];
    label.backgroundColor = [UIColor redColor];
    [self.lineImage addSubview:label];
    
    UILabel *hengLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,self.lineImage.frame.size.height-3, 10, 3)];
    hengLabel.backgroundColor = [UIColor redColor];
    [self.lineImage addSubview:hengLabel];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(hanlePan:)];
    [self.lineImage addGestureRecognizer:panGesture ];
    
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:tapGest];
    
}

- (void)handleTap:(UITapGestureRecognizer *)sender{
    CGPoint currentPoint = [sender locationInView:sender.view];
    [self SETValue_X:currentPoint.x];
}

- (void)hanlePan:(UIPanGestureRecognizer *)panGesture{
    [panGesture.view superview].userInteractionEnabled = NO;
    CGPoint point = [panGesture translationInView:panGesture.view];
    if (panGesture.view.frame.origin.x < 30) {
         panGesture.view.transform = CGAffineTransformTranslate(panGesture.view.transform, 0, 0);
    }else{
         panGesture.view.transform = CGAffineTransformTranslate(panGesture.view.transform, point.x, 0);
    }
    [panGesture setTranslation:CGPointZero inView:panGesture.view];
    
    if (panGesture.state == UIGestureRecognizerStateEnded) {
        [self SETValue_X:panGesture.view.frame.origin.x];
        [panGesture.view superview].userInteractionEnabled = YES;
    }
    
}

- (void)SETValue_X:(CGFloat)curr_index{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSInteger index ;
    _xLabelWidth = (self.frame.size.width - UUYLabelwidth)/self.labelCount;
    CGFloat m = (CGFloat)_xLabelWidth;
    CGFloat n = (CGFloat)(curr_index-30);
    CGFloat a = n/m;
    NSInteger k = a;
    CGFloat brfor = n - k*m;
    CGFloat after = (k+1)*m-n;
    if (brfor <= after) {
        index = a ;
        if (curr_index < 30+m/2) {
            self.lineImage.frame = CGRectMake(self.frame.origin.x+30+k*m-3, 10, 10, self.frame.size.height-30);
        }else{
           self.lineImage.frame = CGRectMake(self.frame.origin.x+30+k*m-5, 10, 10, self.frame.size.height-30);
        }
    }else{
        index = a+1;
        if (curr_index < 30+m/2) {
            self.lineImage.frame = CGRectMake(self.frame.origin.x+30+(k+1)*m -3, 10,10, self.frame.size.height-30);;
        }else{
            self.lineImage.frame = CGRectMake(self.frame.origin.x+30+(k+1)*m -5, 10,10, self.frame.size.height-30);
        }
    }
    [dict setValue:[NSString stringWithFormat:@"%ld",index] forKey:@"key"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LineChange" object:nil userInfo:dict];

}

-(void)setYValues:(NSArray *)yValues
{
    _yValues = yValues;
    [self setYLabels:yValues];
}

-(void)setYLabels:(NSArray *)yLabels
{
    NSInteger max = 0;
    NSInteger min = 1000000000;

    for (NSArray * ary in yLabels) {
        for (NSString *valueString in ary) {
            NSInteger value = [valueString integerValue];
            if (value > max) {
                max = value;
            }
            if (value < min) {
                min = value;
            }
        }
    }
    max = max < YkCount ? YkCount:max;
    _yValueMin = 0;
    _yValueMax = (int)max;
    
    if (_chooseRange.max != _chooseRange.min) {
        _yValueMax = _chooseRange.max;
        _yValueMin = _chooseRange.min;
    }

    float level = (_yValueMax-_yValueMin) /(YkCount - 1);
    CGFloat chartCavanHeight = self.frame.size.height - UULabelHeight*3;
    CGFloat levelHeight = chartCavanHeight /(YkCount - 1);

    for (int i=0; i < YkCount; i++) {
        UUChartLabel * label = [[UUChartLabel alloc] initWithFrame:CGRectMake(0.0,chartCavanHeight-i*levelHeight+YkCount, UUYLabelwidth, UULabelHeight)];
		label.text = [NSString stringWithFormat:@"%.1f",(float)(level * i+_yValueMin)];
		[self addSubview:label];
    }
    if ([super respondsToSelector:@selector(setMarkRange:)]) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(UUYLabelwidth, (1-(_markRange.max-_yValueMin)/(_yValueMax-_yValueMin))*chartCavanHeight+UULabelHeight, self.frame.size.width-UUYLabelwidth, (_markRange.max-_markRange.min)/(_yValueMax-_yValueMin)*chartCavanHeight)];
           view.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
          [self addSubview:view];

    }
    if ([super respondsToSelector:@selector(setLineArray:)]) {
        for (NSInteger i = 0; i < _lineArray.count; i++) {
            NSString *data = _lineArray[i];
            CGFloat x = [data floatValue];
            CGFloat height = (1-(x-_yValueMin)/(_yValueMax-_yValueMin))*chartCavanHeight+UULabelHeight- 2;
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(UUYLabelwidth, height, self.frame.size.width-UUYLabelwidth, 2)];
            if (_lineColorArray) {
                if (i < _lineColorArray.count) {
                    [self drawDashLine:lineView lineLength:10 lineSpacing:5 lineColor:[_lineColorArray objectAtIndex:i]];
                }else{
                    [self drawDashLine:lineView lineLength:10 lineSpacing:5 lineColor:[UIColor greenColor]];
                }
            }else{
               [self drawDashLine:lineView lineLength:10 lineSpacing:5 lineColor:[UIColor greenColor]];
            }
            [self addSubview:lineView];
        }
    }

    //画横线
    for (int i=0; i< YkCount; i++) {
        if ([_showHorizonLine[i] integerValue]>0) {
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(UUYLabelwidth,UULabelHeight+i*levelHeight)];
            [path addLineToPoint:CGPointMake(self.frame.size.width,UULabelHeight+i*levelHeight)];
            [path closePath];
            shapeLayer.path = path.CGPath;
            if (i == YkCount - 1) {
               shapeLayer.strokeColor = [[[UIColor blackColor] colorWithAlphaComponent:0.4] CGColor];
            }else{
               shapeLayer.strokeColor = [[[UIColor blackColor] colorWithAlphaComponent:0.1] CGColor];
            }
            shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
            shapeLayer.lineWidth = 1;
            [self.layer addSublayer:shapeLayer];
        }
    }
}



-(void)setXLabels:(NSArray *)xLabels
{
    if( !_chartLabelsForX ){
        _chartLabelsForX = [NSHashTable weakObjectsHashTable];
    }
    
    _xLabels = xLabels;
    CGFloat num = 0;
    if (xLabels.count>=20) {
        num=20.0;
    }else if (xLabels.count<=1){
        num=1.0;
    }else{
        num = xLabels.count;
    }
    _xLabelWidth = (self.frame.size.width - UUYLabelwidth)/(num -1);
    self.labelCount = (num-1);
    for (int i=0; i<xLabels.count; i++) {
        NSString *labelText = xLabels[i];
        UUChartLabel * label = [[UUChartLabel alloc] initWithFrame:CGRectMake(i * _xLabelWidth+5, self.frame.size.height - UULabelHeight, _xLabelWidth-5, UULabelHeight)];
        label.textAlignment = NSTextAlignmentRight;
        label.text = labelText;
        [self addSubview:label];
        [_chartLabelsForX addObject:label];
    }
    
    //画竖线
    for (int i=0; i<xLabels.count+1; i++) {
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(UUYLabelwidth+i*_xLabelWidth,UULabelHeight)];
            [path addLineToPoint:CGPointMake(UUYLabelwidth+i*_xLabelWidth,self.frame.size.height-2*UULabelHeight)];
            [path closePath];
            shapeLayer.path = path.CGPath;
            if (i == 0) {
                shapeLayer.strokeColor = [[[UIColor blackColor] colorWithAlphaComponent:0.4] CGColor];
            }else{
                shapeLayer.strokeColor = [[[UIColor blackColor] colorWithAlphaComponent:0.1] CGColor];
            }
            shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
            shapeLayer.lineWidth = 1;
            [self.layer addSublayer:shapeLayer];
        }
}

-(void)setColors:(NSArray *)colors
{
	_colors = colors;
}

-(void)setLineColorArray:(NSArray *)lineColorArray
{
    _lineColorArray = lineColorArray;
}


- (void)setMarkRange:(CGRange)markRange
{
    _markRange = markRange;
}

- (void)setLineArray:(NSArray *)lineArray{
    _lineArray = lineArray;
}

- (void)setChooseRange:(CGRange)chooseRange
{
    _chooseRange = chooseRange;
}

- (void)setshowHorizonLine:(NSMutableArray *)showHorizonLine
{
    _showHorizonLine = showHorizonLine;
}

- (void)setshowVerticalLine:(NSMutableArray *)showVerticalLine
{
    _showVerticalLine = showVerticalLine;
}


-(void)strokeChart
{
    for (int i=0; i<_yValues.count; i++) {
        NSArray *childAry = _yValues[i];
        if (childAry.count==0) {
            return;
        }
        //获取最大最小位置
        CGFloat max = [childAry[0] floatValue];
        CGFloat min = [childAry[0] floatValue];
        NSInteger max_i = 0;
        NSInteger min_i = 0;
        
        for (int j=0; j<childAry.count; j++){
            CGFloat num = [childAry[j] floatValue];
            if (max<=num){
                max = num;
                max_i = j;
            }
            if (min>=num){
                min = num;
                min_i = j;
            }
        }
        
        //划线
        CAShapeLayer *_chartLine = [CAShapeLayer layer];
        _chartLine.lineCap = kCALineCapRound;
        _chartLine.lineJoin = kCALineJoinBevel;
        _chartLine.fillColor   = [[UIColor whiteColor] CGColor];
        _chartLine.lineWidth   = 2.0;
        _chartLine.strokeEnd   = 0.0;
        [self.layer addSublayer:_chartLine];
        
        UIBezierPath *progressline = [UIBezierPath bezierPath];
        CGFloat firstValue = [[childAry objectAtIndex:0] floatValue];
        CGFloat xPosition = UUYLabelwidth;
        //(UUYLabelwidth + _xLabelWidth/2.0);修改坐标点在什么位置显示
        CGFloat chartCavanHeight = self.frame.size.height - UULabelHeight*3;
        
        float grade = ((float)firstValue-_yValueMin) / ((float)_yValueMax-_yValueMin);
        //第一个点
        BOOL isShowMaxAndMinPoint = YES;
        if (self.showMaxMinArray) {
            if ([self.showMaxMinArray[i] intValue]>0) {
                isShowMaxAndMinPoint = (max_i==0 || min_i==0)?NO:YES;
            }else{
                isShowMaxAndMinPoint = YES;
            }
        }
        BOOL isfistValue = false;
        if (firstValue != 0) {
            [self addPoint:CGPointMake(xPosition, chartCavanHeight - grade * chartCavanHeight+UULabelHeight)
                     index:i
                    isShow:isShowMaxAndMinPoint
                     value:firstValue];
              [progressline moveToPoint:CGPointMake(xPosition, chartCavanHeight - grade * chartCavanHeight+UULabelHeight)];
            isfistValue = YES;
        }
      
        [progressline setLineWidth:2.0];
        [progressline setLineCapStyle:kCGLineCapRound];
        [progressline setLineJoinStyle:kCGLineJoinRound];
        NSInteger index = 0;
        
        for (NSString * valueString in childAry) {
            float grade =([valueString floatValue]-_yValueMin) / ((float)_yValueMax-_yValueMin);
            if (index != 0) {
                CGPoint point = CGPointMake(xPosition+index*_xLabelWidth, chartCavanHeight - grade * chartCavanHeight+UULabelHeight);
                if (valueString.floatValue != 0) {
                    [progressline addLineToPoint:point];
                    [progressline moveToPoint:point];
                    [self addPoint:point index:i isShow:YES value:[valueString floatValue]];
                }
            }
            index += 1;
        }
        
        _chartLine.path = progressline.CGPath;
        if ([[_colors objectAtIndex:i] CGColor]) {
            _chartLine.strokeColor = [[_colors objectAtIndex:i] CGColor];
        }else{
            _chartLine.strokeColor = [UUColor green].CGColor;
        }
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = childAry.count*0.2;//动画划线
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
        pathAnimation.autoreverses = NO;
        [_chartLine addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
        
        _chartLine.strokeEnd = 1.0;
    }
}

//绘制坐标点
- (void)addPoint:(CGPoint)point index:(NSInteger)index isShow:(BOOL)isHollow value:(CGFloat)value
{
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 5, 6, 6)];
        view.center = point;
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 3;
        view.layer.backgroundColor = [[_colors objectAtIndex:index] CGColor]?[[_colors objectAtIndex:index] CGColor]:[UUColor green].CGColor;
        if (isHollow) {
            view.layer.backgroundColor = [[_colors objectAtIndex:index] CGColor]?[[_colors objectAtIndex:index] CGColor]:[UUColor green].CGColor;
        }else{
            view.backgroundColor = [_colors objectAtIndex:index]?[_colors objectAtIndex:index]:[UUColor green];
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(point.x-UUTagLabelwidth/2.0, point.y-UULabelHeight*2, UUTagLabelwidth, UULabelHeight)];
            label.font = [UIFont systemFontOfSize:10];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = view.backgroundColor;
            label.text = [NSString stringWithFormat:@"%d",(int)value];
            [self addSubview:label];
        }
        
        [self addSubview:view];
}

- (NSArray *)chartLabelsForX
{
    return [_chartLabelsForX allObjects];
}


/**
 ** lineView:       需要绘制成虚线的view
 ** lineLength:     虚线的宽度
 ** lineSpacing:    虚线的间距
 ** lineColor:      虚线的颜色
 **/
- (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    
    //  设置虚线颜色为
    [shapeLayer setStrokeColor:lineColor.CGColor];
    
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(lineView.frame), 0);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}


@end
