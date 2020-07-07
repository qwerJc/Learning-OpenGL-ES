//
//  ViewController_CH2_3.m
//  Learning-OpenGLES
//
//  Created by 贾辰 on 2020/6/25.
//  Copyright © 2020 JJC. All rights reserved.
//

#import "ViewController_CH2_3.h"
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
   {{-0.5f,  0.5f, 0.0}}  // upper left corner
};

@interface ViewController_CH2_3 ()

@end

@implementation ViewController_CH2_3

// 因为要重写set&get方法，因此需要@synthesize来创建同名的成员变量
@synthesize baseEffect;
@synthesize vertexBuffer;

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
    ((AGLKContext *)view.context).clearColor = GLKVector4Make(0.f, 0.f, 0.f, 1.f);
    
    // 创建顶点数据准备绘制
    self.vertexBuffer = [[AGLKVertexAttribArrayBuffer alloc] initWithAttribStride:sizeof(SceneVertex)
                                                                numberOfVertices:sizeof(vertices)/sizeof(SceneVertex)
                                                                    bytes:vertices
                                                                           usage:GL_STATIC_DRAW];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    // 这里注意 先设置颜色 再调用 prepareToDraw 再 drawArrayWithMode
    [self.baseEffect prepareToDraw];
    
    [((AGLKContext *)view.context) clear:GL_COLOR_BUFFER_BIT];
    
    [self.vertexBuffer prepareToDrawWithAttrib:GLKVertexAttribPosition
                           numberOfCoordinates:3
                                          data:offsetof(SceneVertex, positionCoords)
                                  shouldEnable:YES];
    
    [self.vertexBuffer drawArrayWithMode:GL_TRIANGLES
                        startVertexIndex:0
                        numberOfVertices:3];
}


@end
