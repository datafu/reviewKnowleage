//
//  FSPProgressRingView.m
//  reviewKnowleage
//
//  Created by fushp on 2018/12/1.
//  Copyright © 2018年 fushp. All rights reserved.
//  虚线画圆

#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))//弧度转角度

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)//角度转弧度


#import "FSPProgressRingView.h"

@interface FSPProgressRingView()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) CAShapeLayer *pathLayer;

@end

@implementation FSPProgressRingView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.bounds = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    borderLayer.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
//    borderLayer.position = self.center;
    borderLayer.path = [UIBezierPath bezierPathWithRoundedRect:borderLayer.bounds cornerRadius:CGRectGetWidth(borderLayer.bounds)/2].CGPath;
    borderLayer.lineWidth = 1. / [[UIScreen mainScreen] scale];
    //虚线边框
    borderLayer.lineDashPattern = @[@4, @4];

    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.strokeColor = [UIColor qmui_colorWithHexString:@"c6c6c6"].CGColor;
    [self.layer addSublayer:borderLayer];
    self.shapeLayer = borderLayer;
}

- (void)setMileage:(CGFloat)mileage {
    
    _mileage = mileage;
    CGFloat  angle   = _mileage/300 *160 +90;
    [self drawcCurveWithEndAngle:angle];
    
}

-(void)drawcCurveWithEndAngle:(CGFloat)endAngle{
    if ([self.layer.sublayers containsObject:_pathLayer]) {
        [_pathLayer removeFromSuperlayer];
    }
    [self.layer respondsToSelector:@selector(removeAllObjects)];
    // 动画绘制表示里程的曲线
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:self.shapeLayer.position
                    radius:CGRectGetWidth(self.shapeLayer.bounds)/2
                startAngle:M_PI/2
                  endAngle:DEGREES_TO_RADIANS(endAngle)
                 clockwise:YES];
    //图形设置
    _pathLayer = [CAShapeLayer layer];
    _pathLayer.frame = self.bounds;
    _pathLayer.path = path.CGPath;
    
    _pathLayer.strokeColor = [[UIColor qmui_colorWithHexString:@"b4a38b"] CGColor];
    _pathLayer.fillColor = nil;
    _pathLayer.lineWidth = 4.0f;
    _pathLayer.lineJoin = kCALineJoinBevel;
    [self.layer addSublayer:_pathLayer];
    //动画
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];//strokeend
    pathAnimation.duration = 1.0;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    [_pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
}
@end
