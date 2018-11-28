//
// Created by kazuma.ukyo on 12/27/12.
//
// To change the template use AppCode | Preferences | File Templates.
// 解决服务端如果返回null 造成闪退问题



#import <Foundation/Foundation.h>

// http://stackoverflow.com/questions/2060741/does-objective-c-use-short-circuit-evaluation

@interface NSNull (OVNatural)
- (void)forwardInvocation:(NSInvocation *)anInvocation;
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector;
@end
