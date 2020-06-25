//
//  ViewController_CH3_1.h
//  Learning-OpenGLES
//
//  Created by 贾辰 on 2020/6/22.
//  Copyright © 2020 JJC. All rights reserved.
//

#import <GLKit/GLKit.h>
@class AGLKVertexAttribArrayBuffer;

NS_ASSUME_NONNULL_BEGIN

@interface ViewController_CH3_1 : GLKViewController
{
   GLuint vertexBufferID; // 保存顶点数据缓存的标识符
}
@property (strong, nonatomic) GLKBaseEffect *baseEffect;  // 实例指针
@property (strong, nonatomic) AGLKVertexAttribArrayBuffer *vertexBuffer;
@end

NS_ASSUME_NONNULL_END
