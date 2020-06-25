//
//  ViewController_CH2_3.h
//  Learning-OpenGLES
//
//  Created by 贾辰 on 2020/6/25.
//  Copyright © 2020 JJC. All rights reserved.
//

#import <GLKit/GLKit.h>

@class AGLKVertexAttribArrayBuffer;

NS_ASSUME_NONNULL_BEGIN

@interface ViewController_CH2_3 : GLKViewController
@property (strong, nonatomic) GLKBaseEffect *baseEffect; // 设置绘图的基础类
@property (strong, nonatomic) AGLKVertexAttribArrayBuffer *vertexBuffer; // 定义一个顶点数据的buffer
@end

NS_ASSUME_NONNULL_END
