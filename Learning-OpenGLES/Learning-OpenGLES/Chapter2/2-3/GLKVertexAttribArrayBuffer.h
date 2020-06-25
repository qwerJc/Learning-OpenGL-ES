//
//  GLKVertexAttribArrayBuffer.h
//  Learning-OpenGLES
//
//  Created by 贾辰 on 2020/6/24.
//  Copyright © 2020 JJC. All rights reserved.
//
// 封装对顶点数据缓存的操作,减少7步缓存管理的代码

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

//@class

NS_ASSUME_NONNULL_BEGIN

@interface GLKVertexAttribArrayBuffer : NSObject
@property (nonatomic, readonly) GLuint glName;
@property (nonatomic, readonly) GLsizeiptr bufferSizeBytes;
@property (nonatomic, readonly) GLsizeiptr stride;

// 初始化方法
- (id)initWithAttribStride:(GLsizeiptr)stride
          numberOfVertices:(GLsizei)cout
              attribOffset:(const GLvoid *)dataPtr
                     usage:(GLenum)usage;

- (void)prepareToDrawWithAttrib:(GLuint)index
            numberOfCoordinates:(GLint)count
                           data:(GLsizeiptr)offset
                   shouldEnable:(BOOL)shouldEnable;

- (void)drawArrayWithMode:(GLenum)mode
         startVertexIndex:(GLint)first
         numberOfVertices:(GLsizei)count;
@end

NS_ASSUME_NONNULL_END
