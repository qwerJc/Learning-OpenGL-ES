//
//  GLKVertexAttribArrayBuffer.m
//  Learning-OpenGLES
//
//  Created by 贾辰 on 2020/6/24.
//  Copyright © 2020 JJC. All rights reserved.
//

#import "AGLKVertexAttribArrayBuffer.h"


@interface AGLKVertexAttribArrayBuffer()
@property (nonatomic, readonly) GLuint glName; // 生成一个标识符，并保存在vertexBufferID指针指向的位置
@property (nonatomic, readonly) GLsizeiptr bufferSizeBytes; // 所有需要复制的顶点总字节长
@property (nonatomic, readonly) GLsizeiptr stride;          // 一个顶点数据的字节长
@end

@implementation AGLKVertexAttribArrayBuffer

- (id)initWithAttribStride:(GLsizeiptr)stride
          numberOfVertices:(GLsizei)cout
              attribOffset:(const GLvoid *)dataPtr
                     usage:(GLenum)usage {
    // 断言，不满足时则抛出异常
    NSParameterAssert(0 < stride);
    NSParameterAssert(0 < cout);
    NSParameterAssert(NULL != dataPtr);
    
    self = [super init];
    if (self) {
        _stride = stride;
        _bufferSizeBytes = stride*cout;
        
        // step 1
        glGenBuffers(1, &_glName);
        
        // step 2
        glBindBuffer(GL_ARRAY_BUFFER, _glName);
        
        // step 3
        glBufferData(GL_ARRAY_BUFFER, _bufferSizeBytes, dataPtr, usage);
        
        NSAssert(_glName!=0, @"Failed to grenerate glName");
    }
    return self;
}

- (void)prepareToDrawWithAttrib:(GLKVertexAttrib)type
            numberOfCoordinates:(GLint)count
                           data:(GLsizeiptr)offset
                   shouldEnable:(BOOL)shouldEnable {
//    NSParameterAssert((0<count) && (count<4));
    NSParameterAssert(offset < self.stride); // 防止越界
    NSAssert(self.glName!=0, @"Invalid glName");
    
    // step2
    // Q:这里为什么要重新绑定？
    glBindBuffer(GL_ARRAY_BUFFER, _glName);
    
    // step4
    // 用缓冲区中 从index开始的数据 来绘制三角形
    if (shouldEnable) {
        glEnableVertexAttribArray(type);
    }
    
    // step5
    glVertexAttribPointer(type, count, GL_FLOAT, GL_FALSE, (GLsizei)self.stride, offset+NULL);
}

- (void)drawArrayWithMode:(GLenum)mode
         startVertexIndex:(GLint)first
         numberOfVertices:(GLsizei)count {
    NSAssert((self.bufferSizeBytes >= (first+count)*self.stride), @"Attempt to draw more vertex data than available");
    
    // step 6
    glDrawArrays(mode, first, count);
}

- (void)dealloc {
    if (_glName != 0) {
        glDeleteBuffers(1, &_glName);
        _glName = 0;
    }
}
@end
