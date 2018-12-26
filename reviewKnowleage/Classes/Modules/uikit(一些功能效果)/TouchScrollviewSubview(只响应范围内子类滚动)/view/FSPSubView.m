//
//  FSPSubView.m
//  reviewKnowleage
//
//  Created by fushp on 2018/12/26.
//  Copyright © 2018年 fushp. All rights reserved.
//

#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))//弧度转角度

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)//角度转弧度

#import "FSPSubView.h"

@interface FSPSubView()

@property (weak, nonatomic) IBOutlet UIImageView *transformImageview;

@end

@implementation FSPSubView

- (instancetype)init {
    if (self = [super init]) {
        self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil].firstObject;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 6;
        
    }
    return self;
}
#pragma mark --获取触屏事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [super touchesBegan:touches withEvent:event];
//    UITouch *touch = [touches anyObject];
    QMUILog(@"touchesBegan",@"");

    
}



#pragma mark --获取触屏进行事件
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint point =[touch locationInView:self];
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    int currentAngle = floor(AngleFromNorth(centerPoint, point, NO));
    self.transformImageview.transform = CGAffineTransformMakeRotation (DEGREES_TO_RADIANS(currentAngle));
    QMUILogWarn(@"touchesMoved",@"centerPoint:%f->%f-->centerPoint:%f->%f-->currentAngle:%f",point.x,point.y,centerPoint.x,centerPoint.y,DEGREES_TO_RADIANS(currentAngle));

}

#pragma mark --获取触屏结束事件
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
   
}

#pragma mark - private methods
static inline float AngleFromNorth(CGPoint p1, CGPoint p2, BOOL flipped) {
    CGPoint v = CGPointMake(p2.x-p1.x,p2.y-p1.y);
    float result = 0 ;
    double radians = atan2(v.y,v.x);
    result = RADIANS_TO_DEGREES(radians);
    // DNLog(@"result:%f",result);
    return (result >=0  ? result : result + 360.0);
    
}

@end
