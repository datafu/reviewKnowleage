//
//  FSPElectricView.m
//  reviewKnowleage
//
//  Created by fushp on 2018/12/1.
//  Copyright © 2018年 fushp. All rights reserved.
//

#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))//弧度转角度

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)//角度转弧度

#import "FSPElectricView.h"

@interface FSPElectricView()

@property (nonatomic, strong) CAShapeLayer *radarLayer;//内圈圆环渐变色
@property (nonatomic, strong) CAShapeLayer *circleLayer;//圈内渐变色
@property (nonatomic, strong) CAShapeLayer *borderLayer; //外环实线圈

@end

@implementation FSPElectricView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


-(void)layoutSubviews
{
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.position = self.center;
    
    borderLayer.bounds = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    borderLayer.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    borderLayer.path = [UIBezierPath bezierPathWithRoundedRect:borderLayer.bounds cornerRadius:CGRectGetWidth(borderLayer.bounds)/2].CGPath;
    borderLayer.lineWidth = 3.0;
    borderLayer.fillColor = nil;
    //实线边框
    borderLayer.lineDashPattern = nil;
    borderLayer.strokeColor = [[UIColor qmui_colorWithHexString:@"8d8d8d"] colorWithAlphaComponent:0.4].CGColor;
    [self.layer addSublayer:borderLayer];
    self.borderLayer  = borderLayer;
}

- (void)setElectric:(CGFloat)electric {
    _electric = electric;
    CGFloat  angle   =  electric*360-90;
    QMUILog(@"setElectric",@"-----------%f",DEGREES_TO_RADIANS(angle));
    [self startAnimationWithAngle:angle];
}

- (void)startAnimationWithAngle:(CGFloat)endAngle {
    
    //开始动画之前 先移除之前的动画
    CAShapeLayer *pathLayerEctype;
    CAShapeLayer *pathLayerEctype2;
    
    if ([self.layer.sublayers containsObject:self.borderLayer]) {
        [self.borderLayer removeFromSuperlayer];
    }
    if ([self.layer.sublayers containsObject:pathLayerEctype]) {
        [pathLayerEctype removeFromSuperlayer];
    }
    if ([self.layer.sublayers containsObject:self.radarLayer]) {
        [self.radarLayer removeFromSuperlayer];
    }
    if ([self.layer.sublayers containsObject:self.circleLayer]) {
        [self.circleLayer removeFromSuperlayer];
    }
    if ([self.layer.sublayers containsObject:pathLayerEctype2]) {
        [pathLayerEctype2 removeFromSuperlayer];
    }
    
    
    
    
    //圆环渐变
    // 动画绘制曲线表示剩余电量的曲线
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:self.borderLayer.position
                    radius:CGRectGetWidth(self.borderLayer.bounds)/2 - 1
                startAngle:M_PI/2*3
                  endAngle:DEGREES_TO_RADIANS(endAngle)
                 clockwise:YES];
    //图形设置
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.frame = self.bounds;
    pathLayer.path = path.CGPath;
    
    
    pathLayer.strokeColor = [[UIColor blackColor] CGColor];
    pathLayer.fillColor = nil;
    pathLayer.lineWidth = 6.0f;
    pathLayer.lineDashPattern = nil;
    pathLayer.lineJoin = kCALineJoinBevel;
    pathLayer.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    pathLayerEctype = pathLayer;
    
    self.radarLayer = [CAShapeLayer layer];
    self.radarLayer.frame = self.bounds;
    self.radarLayer.lineCap = kCALineCapRound; // 设置线为圆角
    
    [self.layer addSublayer:self.radarLayer];
    
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    
    gradientLayer.frame = CGRectMake(-5, -5, self.bounds.size.width+10, self.bounds.size.height+10);//减5 加10 都是为了坐标合适 没有实际意义
    
    [gradientLayer setColors:[NSArray arrayWithObjects:(id)[[UIColor qmui_colorWithHexString:@"baa077"] CGColor],(id)[[UIColor qmui_colorWithHexString:@"f4e0c2"]CGColor], nil]];
    
    [gradientLayer setLocations:@[@0,@1.5]];
    
    [self.radarLayer addSublayer:gradientLayer];
    
    self.radarLayer.mask = pathLayer;
    
    //圆圈的动画
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];//strokeend
    pathAnimation.duration = 1.0;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    [pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
    
    //圈内动画
    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 addArcWithCenter:self.borderLayer.position
                     radius:CGRectGetWidth(self.borderLayer.bounds)/4 - 1
                 startAngle:M_PI/2*3
                   endAngle:DEGREES_TO_RADIANS(endAngle)
                  clockwise:YES];
    CAShapeLayer *pathLayer2 = [CAShapeLayer layer];
    pathLayer2.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    pathLayer2.path = path2.CGPath;
    pathLayer2.strokeColor = [[UIColor qmui_colorWithHexString:@"08c827"] CGColor];
    pathLayer2.fillColor = [UIColor clearColor].CGColor;
    pathLayer2.lineDashPattern = nil;
    pathLayer2.lineJoin = kCALineJoinBevel;
    pathLayer2.lineCap = kCALineCapButt;
    pathLayer2.lineWidth = self.frame.size.width/2;
    pathLayer2.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));


    self.circleLayer = [CAShapeLayer layer];
    self.circleLayer.frame = self.bounds;
    [self.layer addSublayer:self.circleLayer];
    CAGradientLayer *gradientLayer1 =  [CAGradientLayer layer];

    gradientLayer1.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);

    [gradientLayer1 setColors:[NSArray arrayWithObjects:(id)[[UIColor qmui_colorWithHexString:@"403e39"] CGColor],(id)[[UIColor qmui_colorWithHexString:@"8c8271"]CGColor], nil]];

    [gradientLayer1 setLocations:@[@0.1,@0.9]];


    [self.circleLayer addSublayer:gradientLayer1];


    [self.circleLayer setMask:pathLayer2];

    //圆圈的动画
    CABasicAnimation *pathAnimation2 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation2 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];//strokeend
    pathAnimation2.duration = 1.0;
    pathAnimation2.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation2.toValue = [NSNumber numberWithFloat:1.0f];
    [pathLayer2 addAnimation:pathAnimation2 forKey:@"strokeEnd"];
}


@end
