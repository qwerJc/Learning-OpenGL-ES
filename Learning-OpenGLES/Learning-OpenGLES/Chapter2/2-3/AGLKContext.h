//
//  AGLKContext.h
//  Learning-OpenGLES
//
//  Created by 贾辰 on 2020/6/24.
//  Copyright © 2020 JJC. All rights reserved.
//
// 主要负责设置 上下文 及 清除颜色

#import <GLKit/GLKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AGLKContext : EAGLContext

@property (nonatomic, assign) GLKVector4 clearColor;

// 设置在上下文的帧缓存中每个像素颜色为clearColor
// 内部通过调用 glClear()来实现
- (void)clear:(GLbitfield)mask;
@end

NS_ASSUME_NONNULL_END
