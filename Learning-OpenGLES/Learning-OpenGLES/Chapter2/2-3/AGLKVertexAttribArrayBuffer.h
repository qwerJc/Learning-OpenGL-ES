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

@interface AGLKVertexAttribArrayBuffer : NSObject

/**
 初始化方法
 stride:每个节点的字节长
 cout:需要复制到缓存中的顶点数量
 dataPtr:顶点数据
 usage:缓存的处理方式（GL_STATIC_DRAW：缓存内容不易改变，可复制到GPU控制的内存中｜GL_DYNAMIC_DRAW：缓存中数据会频繁改变）
 */
- (id)initWithAttribStride:(GLsizeiptr)stride
          numberOfVertices:(GLsizei)cout
                     bytes:(const GLvoid *)dataPtr
                     usage:(GLenum)usage;

/**
 准备绘制
 type: GLKVertexAttrib 的类型
            GLKVertexAttribPosition, // 给着色器提供顶点位置数据
            GLKVertexAttribNormal,   // 给该着色器提供的是顶点的法向量
            GLKVertexAttribColor,    // 给着色器提供顶点的颜色
            GLKVertexAttribTexCoord0,// 给着色器提供一系列纹理坐标
            GLKVertexAttribTexCoord1 // 给着色器提供第二套纹理坐标
 count: 缓冲区顶点数据包含元素个数
 offset:从顶点缓冲区的offset的位置开始访问数据
 */
- (void)prepareToDrawWithAttrib:(GLKVertexAttrib)type
            numberOfCoordinates:(GLint)count
                           data:(GLsizeiptr)offset
                   shouldEnable:(BOOL)shouldEnable;

/**
 执行绘图
 mode: 图元类型 GLenum
 first: 缓存内需要渲染的第一个顶点的位置
 count: 需要渲染的顶点的数量
 */
- (void)drawArrayWithMode:(GLenum)mode
         startVertexIndex:(GLint)first
         numberOfVertices:(GLsizei)count;
@end

NS_ASSUME_NONNULL_END
