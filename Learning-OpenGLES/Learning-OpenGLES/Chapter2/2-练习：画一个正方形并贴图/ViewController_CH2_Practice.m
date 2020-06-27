//
//  ViewController_CH2_Practice.m
//  Learning-OpenGLES
//
//  Created by 贾辰 on 2020/6/26.
//  Copyright © 2020 JJC. All rights reserved.
//

#import "ViewController_CH2_Practice.h"
#import "GLKViewController+BtnBack.h"
#import "AGLKContext.h"
#import "AGLKVertexAttribArrayBuffer.h"

typedef struct {
    GLKVector3  positionCoords;
    GLKVector2  textureCoords;
}
SceneVertex;

static const SceneVertex vertices[] =
{
    {{-0.5f, -0.5f, 0.0},{0.f,0.f}}, // 左下
    {{ 0.5f, -0.5f, 0.0},{1.f,0.f}}, // 右下
    {{-0.5f,  0.5f, 0.0},{0.f,1.f}},  // 左上
    
    {{0.5f,  0.5f, 0.0},{1.f,1.f}},  // 右上
    {{ 0.5f, -0.5f, 0.0},{1.f,0.f}}, // 右下
    {{-0.5f,  0.5f, 0.0},{0.f,1.f}},  // 左上
    
    // 左右翻转
//    {{-0.5f, -0.5f, 0.0},{1.f,0.f}}, // 左下
//    {{ 0.5f, -0.5f, 0.0},{0.f,0.f}}, // 右下
//    {{-0.5f,  0.5f, 0.0},{1.f,1.f}},  // 左上
//
//    {{0.5f,  0.5f, 0.0},{0.f,1.f}},  // 右上
//    {{ 0.5f, -0.5f, 0.0},{0.f,0.f}}, // 右下
//    {{-0.5f,  0.5f, 0.0},{1.f,1.f}},  // 左上
};

@interface ViewController_CH2_Practice ()
@property (strong, nonatomic) GLKBaseEffect *baseEffect; // 设置绘图的基础类

@property (nonatomic, readonly) GLuint glName; // 生成一个标识符，并保存在vertexBufferID指针指向的位置

@end

@implementation ViewController_CH2_Practice

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBtnBackOnView:self.view];
    
    GLKView *view = (GLKView *)self.view;
    NSAssert([view isKindOfClass:[GLKView class]], @"View Controller's view is not a GLKView");
    
    view.context = [[AGLKContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    // 设置当前上下文
    [AGLKContext setCurrentContext:view.context];
    
    self.baseEffect = [[GLKBaseEffect alloc] init];
    self.baseEffect.useConstantColor = GL_TRUE;
    self.baseEffect.constantColor = GLKVector4Make(1.f, 1.f, 1.f, 1.f);
    
    // bg color
    ((AGLKContext *)view.context).clearColor = GLKVector4Make(.3f, .5f, 0.2f, 1.f);
    
    // 创建顶点数据准备绘制
    // step 1 申请一个标识符
    glGenBuffers(1, &_glName);
    
    // step 2 把标识符绑定到GL_ARRAY_BUFFER上
    glBindBuffer(GL_ARRAY_BUFFER, _glName);
    
    // step 3 把顶点数据从cpu内存复制到gpu内存
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
    
    // 纹理
    CGImageRef imageRef = [[UIImage imageNamed:@"img1-1.png"] CGImage];
    // 创建一个包含 imageRef 像素数据的纹理缓存
    GLKTextureInfo *textureInfo = [GLKTextureLoader textureWithCGImage:imageRef
                                                               options:nil
                                                                 error:NULL];
    
    // 将创建的纹理缓存赋给 baseEffect
    self.baseEffect.texture2d0.name = textureInfo.name;
    self.baseEffect.texture2d0.target = textureInfo.target;
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    [self.baseEffect prepareToDraw];
    
    [((AGLKContext *)view.context) clear:GL_COLOR_BUFFER_BIT];
    
    // step4 是开启对应的顶点属性
    glEnableVertexAttribArray(GLKVertexAttribPosition);
        // 纹理
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    
    // step5 设置合适的格式从buffer里面读取数据
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, (GLsizei)sizeof(SceneVertex), NULL);
        // 设置 从buffer中读取纹理数据
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, (GLsizei)sizeof(SceneVertex), offsetof(SceneVertex, textureCoords)+NULL);
    
    // step 6 绘制图形
    glDrawArrays(GL_TRIANGLES, 0, 6);

}

@end
