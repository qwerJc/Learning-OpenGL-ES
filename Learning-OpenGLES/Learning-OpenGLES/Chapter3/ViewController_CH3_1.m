//
//  ViewController_CH3_1.m
//  Learning-OpenGLES
//
//  Created by 贾辰 on 2020/6/22.
//  Copyright © 2020 JJC. All rights reserved.
//

#import "ViewController_CH3_1.h"
#import "GLKViewController+BtnBack.h"
#import "AGLKVertexAttribArrayBuffer.h"

// 定义名为 SceneVertex 的结构体，用来保存 GLKVector3 类型的成员
// GLKVector3保存了 XYZ 这3个坐标，即代表起始于坐标系远点的矢量
typedef struct {
    GLKVector3  positionCoords;
    GLKVector2  textureCoords;  // 新增了纹理数据
}
SceneVertex;

/////////////////////////////////////////////////////////////////
// 用顶点数据初始化的C数组，用来定义一个三角形
static const SceneVertex vertices[] =
{
    {{-0.5f, -0.5f, 0.0},{0.f,0.f}}, // lower left corner
    {{ 0.5f, -0.5f, 0.0},{1.f,0.f}}, // lower right corner
    {{-0.5f,  0.5f, 0.0},{0.f,1.f}}  // upper left corner
};

@interface ViewController_CH3_1 ()

@end

@implementation ViewController_CH3_1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    self.baseEffect.useConstantColor = GL_TRUE;
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
    
    /**⚠️新增：初始化 纹理*/
    CGImageRef imageRef = [[UIImage imageNamed:@"img1-1.png"] CGImage];
    
    GLKTextureInfo *textureInfo = [GLKTextureLoader textureWithCGImage:imageRef
                                                               options:nil
                                                                 error:NULL];
    
    self.baseEffect.texture2d0.name = textureInfo.name;
    self.baseEffect.texture2d0.target = textureInfo.target;
}

// 当GLKView实例需要被重绘时，都会让保存在视图的上下文属性中的OpenGLES上下文成为当前上下文
// 使用 顶点属性数组缓存 的前3步已经在 viewDidLoad 中被执行，这里会执行剩下的3步：
// 4、启动
// 5、设置指针
// 6、绘图
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
//    [self.baseEffect prepareToDraw];
//    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_CLAMP_TO_EDGE);
//    // Clear back frame buffer (erase previous drawing)
//    [view.context clear:GL_COLOR_BUFFER_BIT];
//    
//    [self.vertexBuffer prepareToDrawWithAttrib:GLKVertexAttribPosition
//                           numberOfCoordinates:3
//                                  attribOffset:offsetof(SceneVertex, positionCoords)
//                                  shouldEnable:YES];
//    [self.vertexBuffer prepareToDrawWithAttrib:GLKVertexAttribTexCoord0
//                           numberOfCoordinates:2
//                                  attribOffset:offsetof(SceneVertex, textureCoords)
//                                  shouldEnable:YES];
//    
//    // Draw triangles using the first three vertices in the
//    // currently bound vertex buffer
//    [self.vertexBuffer drawArrayWithMode:GL_TRIANGLES
//                        startVertexIndex:0
//                        numberOfVertices:3];
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
