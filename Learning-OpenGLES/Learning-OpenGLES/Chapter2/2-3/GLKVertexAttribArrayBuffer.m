//
//  GLKVertexAttribArrayBuffer.m
//  Learning-OpenGLES
//
//  Created by 贾辰 on 2020/6/24.
//  Copyright © 2020 JJC. All rights reserved.
//

#import "GLKVertexAttribArrayBuffer.h"


@implementation GLKVertexAttribArrayBuffer

@synthesize glName;
@synthesize bufferSizeBytes;
@synthesize stride;

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
        glBindBuffer(GL_ARRAY_BUFFER, self.glName);
        
        // step 3
        glBufferData(GL_ARRAY_BUFFER, _bufferSizeBytes, dataPtr, usage);
        
        NSAssert(_glName!=0, @"Failed to grenerate glName");
    }
    return self;
}

- (void)prepareToDrawWithAttrib:(GLuint)index
            numberOfCoordinates:(GLint)count
                           data:(GLsizeiptr)offset
                   shouldEnable:(BOOL)shouldEnable {
    NSParameterAssert((0<count) && (count<4));
    NSParameterAssert(self.stride < offset);
    NSAssert(_glName!=0, @"Invalid glName");
    
    // step2
    glBindBuffer(GL_ARRAY_BUFFER, self.glName);
    
    // step4
    // 用index来绘制三角形
    if (shouldEnable) {
        glEnableVertexAttribArray(index);
    }
    
    // step5
    glVertexAttribPointer(index, count, GL_FLOAT, GL_FALSE, (GLsizei)self.stride, offset+NULL);
}

- (void)drawArrayWithMode:(GLenum)mode
         startVertexIndex:(GLint)first
         numberOfVertices:(GLsizei)count {
    NSAssert((self.bufferSizeBytes >= (first+count)*self.stride), @"Attempt to draw more vertex data than available");
    
    // step 6
    glDrawArrays(mode, first, count);
}

- (void)dealloc {
    if (glName != 0) {
        glDeleteBuffers(1, &glName);
        glName = 0;
    }
}
@end
