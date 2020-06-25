//
//  AGLKContext.m
//  Learning-OpenGLES
//
//  Created by 贾辰 on 2020/6/24.
//  Copyright © 2020 JJC. All rights reserved.
//

#import "AGLKContext.h"

@implementation AGLKContext

@synthesize clearColor = _clearColor; // 这里因为要重写set和get方法，因此需要主动@synthesize，创建同名成员变量(这样就不用创城_clearColor这样的成员变量了)

#pragma mark - Over Write
- (void)setClearColor:(GLKVector4)clearColor {
    _clearColor = clearColor;

    // NSAssert:如果参数1不成立，则抛出一个异常，异常内容为参数2
    NSAssert(self == [[self class] currentContext], @"Receiving context required to be current context");

    glClearColor(clearColor.r, clearColor.g, clearColor.b, clearColor.a);
}

- (GLKVector4)clearColor {
    return _clearColor;
}
#pragma mark - Public
- (void)clear:(GLbitfield)mask {
    // NSAssert:如果参数1不成立，则抛出一个异常，异常内容为参数2
    NSAssert(self == [[self class] currentContext], @"Receiving context required to be current context");

    glClear(mask);
}

@end
