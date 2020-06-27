//
//  ViewController_CH3_2.m
//  Learning-OpenGLES
//
//  Created by 贾辰 on 2020/6/26.
//  Copyright © 2020 JJC. All rights reserved.
//

#import "ViewController_CH3_2.h"
#import "GLKViewController+BtnBack.h"
#import "AGLKContext.h"
#import "AGLKVertexAttribArrayBuffer.h"
#import "AGLKTextureLoader.h"

@interface ViewController_CH3_2 ()
@property (strong, nonatomic) GLKBaseEffect *baseEffect;  // 实例指针
@property (strong, nonatomic) AGLKVertexAttribArrayBuffer *vertexBuffer;
@end

typedef struct {
    GLKVector3  positionCoords;
    GLKVector2  textureCoords;  // 新增了纹理数据
}
SceneVertex;

/////////////////////////////////////////////////////////////////
// 用顶点数据初始化的C数组，用来定义一个三角形
static const SceneVertex vertices[] =
{
    {{-0.5f, -0.5f, 0.0},{0.f,1.f}}, // lower left corner
    {{ 0.5f, -0.5f, 0.0},{1.f,1.f}}, // lower right corner
    {{-0.5f,  0.5f, 0.0},{0.f,0.f}}  // upper left corner
};


@implementation ViewController_CH3_2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBtnBackOnView:self.view];
    
    GLKView *view = (GLKView *)self.view;
    
    view.context = [[AGLKContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    [AGLKContext setCurrentContext:view.context];
    
    self.baseEffect = [[GLKBaseEffect alloc] init];
    self.baseEffect.useConstantColor = GL_TRUE;
    self.baseEffect.constantColor = GLKVector4Make(1.f, 1.f, 1.f, 1.f);
    
    ((AGLKContext *)view.context).clearColor = GLKVector4Make(1.f, 0.f, .5f, 1.f);
    
    self.vertexBuffer = [[AGLKVertexAttribArrayBuffer alloc] initWithAttribStride:sizeof(SceneVertex)
                                                                 numberOfVertices:sizeof(vertices)/sizeof(SceneVertex)
                                                                     attribOffset:vertices
                                                                            usage:GL_STATIC_DRAW];
    CGImageRef imageRef = [[UIImage imageNamed:@"img1-1.png"] CGImage];
    
    AGLKTextureInfo *textureInfo = [AGLKTextureLoader textureWithCGImage:imageRef
                                                                 options:nil
                                                                   error:NULL];
    
    self.baseEffect.texture2d0.name = textureInfo.name;
    self.baseEffect.texture2d0.target = textureInfo.target;
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    [self.baseEffect prepareToDraw];
    
    // 设置纹理的拉伸
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_CLAMP_TO_EDGE);
    
    // Clear back frame buffer (erase previous drawing)
    [(AGLKContext *)view.context clear:GL_COLOR_BUFFER_BIT];
    
    [self.vertexBuffer prepareToDrawWithAttrib:GLKVertexAttribPosition
                           numberOfCoordinates:3
                                          data:offsetof(SceneVertex, positionCoords)
                                  shouldEnable:YES];
    
    // 新增纹理绘制准备
    [self.vertexBuffer prepareToDrawWithAttrib:GLKVertexAttribTexCoord0
                           numberOfCoordinates:2
                                          data:offsetof(SceneVertex, textureCoords)
                                  shouldEnable:YES];
    
    // Draw triangles using the first three vertices in the
    // currently bound vertex buffer
    [self.vertexBuffer drawArrayWithMode:GL_TRIANGLES
                        startVertexIndex:0
                        numberOfVertices:3];
}
@end
