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
}
SceneVertex;

static const SceneVertex vertices[] =
{
    {{-0.5f, -0.5f, 0.0}}, // lower left corner
    {{ 0.5f, -0.5f, 0.0}}, // lower right corner
    {{-0.5f,  0.5f, 0.0}},  // upper left corner
    {{0.5f,  0.5f, 0.0}}  // upper left corner
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
    // step 1
    glGenBuffers(1, &_glName);
    
    // step 2
    glBindBuffer(GL_ARRAY_BUFFER, _glName);
    
    // step 3
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    [self.baseEffect prepareToDraw];
    
    [((AGLKContext *)view.context) clear:GL_COLOR_BUFFER_BIT];
    
    // step4
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    
    // step5
    glVertexAttribPointer(GLKVertexAttribPosition, 4, GL_FLOAT, GL_FALSE, (GLsizei)sizeof(SceneVertex), NULL);
    
    // step 6
    glDrawArrays(GL_LINES, 0, 4);
}

@end
