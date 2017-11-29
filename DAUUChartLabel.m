//
//  PNBar.h
//  PNChartDemo
//
//  Created by hongliang li on 17-11-29.
//  Copyright (c) 2017年 hongliang li . All rights reserved.
//
//

#import "DAUUChartLabel.h"
#import "DAUUChartConst.h"

@implementation DAUUChartLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setLineBreakMode:NSLineBreakByWordWrapping];
        [self setMinimumScaleFactor:5.0f];
        [self setNumberOfLines:1];
        [self setFont:[UIFont boldSystemFontOfSize:9.0f]];
        [self setTextColor: [UUColor darkGrayColor]];
        [self setTextAlignment:NSTextAlignmentCenter];
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
    }
    return self;
}


@end
