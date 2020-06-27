//
//  ViewController_CH2_1.m
//  Learning-OpenGLES
//
//  Created by 贾辰 on 2020/6/20.
//  Copyright © 2020 JJC. All rights reserved.
//

#define GL_SILENCE_DEPRECATION

#import "ViewController_CH2_1.h"
#import "GLKViewController+BtnBack.h"

// 定义名为 SceneVertex 的结构体，用来保存 GLKVector3 类型的成员
// GLKVector3保存了 XYZ 这3个坐标，即代表起始于坐标系远点的矢量
typedef struct {
   GLKVector3  positionCoords;
}
SceneVertex;

/////////////////////////////////////////////////////////////////
// 用顶点数据初始化的C数组，用来定义一个三角形
static const SceneVertex vertices[] =
{
   {{-0.5f, -0.5f, 0.0}}, // lower left corner
   {{ 0.5f, -0.5f, 0.0}}, // lower right corner
   {{-0.5f,  0.5f, 0.0}}  // upper left corner
};


@interface ViewController_CH2_1 ()

@end

@implementation ViewController_CH2_1

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBtnBackOnView:self.view];
    // Do any additional setup after loading the view.
    
    GLKView *view = (GLKView *)self.view;
    NSAssert([view isKindOfClass:[GLKView class]],
       @"View controller's view is not a GLKView");
    
    // Create an OpenGL ES 2.0 context and provide it to the
    // 在下面的上下文属性赋值前分配一个新的EAGLContext实例，且初始化为 OpenGLES 2.0
    view.context = [[EAGLContext alloc]
       initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    // 在OpenGLES配置或渲染前，应用的GLKView实例的上下问属性都应设置为当前
    // 一个应用可以使用多个上下文
    // 这里为 接下来的OpenGLES运算 设置 将会用到的上下文
    [EAGLContext setCurrentContext:view.context];
    
    
    // 初始化 baseEffect 属性来提供标准的 OpenGL ES 2.0
    // GLKBaseEffect类提供了 不依赖当前OpenGLES版本 的 OpenGLES渲染方法
    self.baseEffect = [[GLKBaseEffect alloc] init];
    self.baseEffect.useConstantColor = GL_TRUE; // 使用恒定颜色
    // 这里使用恒定的白色来渲染三角形（三角形中每个像素都为白色）
    self.baseEffect.constantColor = GLKVector4Make(
       1.0f, // Red
       1.0f, // Green
       1.0f, // Blue
       1.0f);// Alpha
    
    // 设置当前OpenGLES上下文的 清除颜色 为 不透明黑色
    // 用于在上下文的帧缓存被清除时初始化每个像素的色值
    glClearColor(0.0f, 0.0f, 0.0f, 1.0f); // background color
    
    // Generate, bind, and initialize contents of a buffer to be
    // stored in GPU memory
    // 创建并使用一个 用于保存顶点数据 的 顶点属性数组缓存，前三步如下：
    // 1、为缓存生成一个独一无二的标识符
    // 2、为接下来的运算绑定缓存
    // 3、赋值数据到缓存中
    
    // 【STEP 1】 生成一个标识符，并保存在vertexBufferID指针指向的位置
    // glGenBuffers(指定要生成缓存标识符的数量，指向生成标识符的内存指针)
    glGenBuffers(1,&vertexBufferID);
    
    // 【STEP 2】 绑定 用于指定标识符的缓存 到 当前缓存
    // OpenGLES可以保存不同类型的缓存标识符到当前OpenGLES上下文的不同位置
        // 但是同一时刻一种类型只能绑定一个缓存
    // glBindBuffer(要绑定的缓存类型，要绑定的缓存标识符)
        // 关于 GL_ARRAY_BUFFER 类型：指定一个顶点属性数组
        //
    glBindBuffer(GL_ARRAY_BUFFER, vertexBufferID);
    
    // 【STEP 3】 复制应用的顶点数据到当前上下文所绑定的顶点缓存中
    //    glBufferData(
    //      GL_ARRAY_BUFFER,  // 指定 更新当前上下文时 所绑定的是哪一个缓存
    //      sizeof(vertices), // 要复制进缓存的字节数量
    //      vertices,         // 要复制的字节电子
    //      GL_STATIC_DRAW);  // 缓存在之后的运算中会如何使用，指定合适的类型可以优化内存
    glBufferData(GL_ARRAY_BUFFER,
                 sizeof(vertices),
                 vertices,
                 GL_STATIC_DRAW);
    // 注：
        // GL_STATIC_DRAW：缓存内容适合复制到GPU控制的内存中，因为很少对其修改
        // GL_DYNAMIC_DRAW：缓存中数据会频繁改变
}

// 当GLKView实例需要被重绘时，都会让保存在视图的上下文属性中的OpenGLES上下文成为当前上下文
// 使用 顶点属性数组缓存 的前3步已经在 viewDidLoad 中被执行，这里会执行剩下的3步：
// 4、启动
// 5、设置指针
// 6、绘图
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    // 告诉 baseEffect 准备好上下文，为 baseEffect生成的属性 和 Shading Language程序绘图做好准备
    [self.baseEffect prepareToDraw];
    
    // 设置当前绑定的帧缓存中的每个像素颜色为之前设置的值（清除渲染的内容）
    // 由于帧缓存可能有 除了像素颜色渲染缓存之外 的 其他附加缓存，这里就是统一为每个像素重设颜色，以达到清除的效果
    glClear(GL_COLOR_BUFFER_BIT);
    
    // Enable use of positions from bound vertex buffer
    // 【STEP 4】 用存储在 GL_ARRAY_BUFFER类型的缓存中的顶点数据 绘制三角形
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    
    // 【STEP 5】告诉OpenGL ES顶点数据在哪里 及 如何解释每个顶点保存的数据
    //    glVertexAttribPointer(GLKVertexAttribPosition, // 指示当前绑定缓存包含的每个顶点的 位置信息
    //                          3,                       // 表示每个 vertex 有3个部分
    //                          GL_FLOAT,                // 设置OpenGL ES 每个部分都保存为一个符点类型的值
    //                          GL_FALSE,                // 设置OpenGL ES 小数点固定数据是否可以被改变（此处没用小数点固定的数据，因此值为GL_FALSE）
    //                          sizeof(SceneVertex),     // 步幅，即每个顶点的保存需要多少字节
    //                                                   // 换句话说，步幅制定了GPU从一个顶点到下一顶点需要跳过多少字节
    //                          NULL
    //                          );                       // 设置为NULL表示：从当前顶点缓存的开始位置访问顶点数据
    //
    glVertexAttribPointer(GLKVertexAttribPosition,
                          3,
                          GL_FLOAT,
                          GL_FALSE,
                          sizeof(SceneVertex),
                          NULL);

    
    // 【STEP 6】执行绘图
    glDrawArrays(GL_TRIANGLES,
                 0,  // 缓存内需要渲染的第一个顶点的位置
                 3); // 需要渲染的顶点的数量
}

// 视图被卸载时调用（iOS6及之后已经被废弃，不再被调用，此处仅供参考）
// 删除不再需要的点点缓存和上下文
- (void)viewDidUnload
{
   [super viewDidUnload];
   
   // 更新当前的上下文
   GLKView *view = (GLKView *)self.view;
   [EAGLContext setCurrentContext:view.context];
    
   // Delete buffers that aren't needed when view is unloaded
   if (0 != vertexBufferID)
   {
       // 这里将 vertexBufferID 设置为0，以避免对应缓存被删除后还使用
      glDeleteBuffers (1,
                       &vertexBufferID);
      vertexBufferID = 0;
   }
   
   // 设置旧的上下文为nil，以便让cocoa Touch回收使用的内存及其他资源
   ((GLKView *)self.view).context = nil;
   [EAGLContext setCurrentContext:nil];
}

@end
