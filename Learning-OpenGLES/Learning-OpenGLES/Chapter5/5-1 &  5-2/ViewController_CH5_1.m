//
//  ViewController_CH5_1.m
//  Learning-OpenGLES
//
//  Created by 贾辰 on 2020/6/29.
//  Copyright © 2020 JJC. All rights reserved.
//

#import "ViewController_CH5_1.h"
#import "GLKViewController+BtnBack.h"
#import "AGLKContext.h"
#import "AGLKVertexAttribArrayBuffer.h"

#import "sphere.h"

@interface ViewController_CH5_1 ()
@property (strong, nonatomic) GLKBaseEffect *baseEffect;  // 实例指针
@property (strong, nonatomic) AGLKVertexAttribArrayBuffer *vertexPositionBuffer;
@property (strong, nonatomic) AGLKVertexAttribArrayBuffer *vertexNormalBuffer;
@property (strong, nonatomic) AGLKVertexAttribArrayBuffer *vertexTextureCoordBuffer;
@end

@implementation ViewController_CH5_1

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBtnBackOnView:self.view];
    // Do any additional setup after loading the view.
    
    GLKView *view = (GLKView *)self.view;
    
    // 开启深度渲染缓存并使用16位来保存深度值
    view.drawableDepthFormat = GLKViewDrawableDepthFormat16;
    
    view.context = [[AGLKContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [AGLKContext setCurrentContext:view.context];
    
    self.baseEffect = [[GLKBaseEffect alloc] init];
    self.baseEffect.light0.enabled = GL_TRUE;
    self.baseEffect.light0.diffuseColor = GLKVector4Make(0.7f, 0.7f, 0.7f, 1.f);
    self.baseEffect.light0.ambientColor = GLKVector4Make(0.2f, 0.2f, 0.2f, 1.f);
    self.baseEffect.light0.position = GLKVector4Make(1.f, 0.f, -0.8f, 0.f);
    
    CGImageRef imageRef = [[UIImage imageNamed:@"Earth512x256.jpg"] CGImage];
    id option = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],GLKTextureLoaderOriginBottomLeft, nil];
    GLKTextureInfo *textureInfo = [GLKTextureLoader textureWithCGImage:imageRef
                                                               options:option
                                                                 error:NULL];
    self.baseEffect.texture2d0.name = textureInfo.name;
    self.baseEffect.texture2d0.target = textureInfo.target;
    
    [(AGLKContext *)view.context setClearColor:GLKVector4Make(0.f, 0.f, 0.f, 1.f)];
    
    self.vertexPositionBuffer = [[AGLKVertexAttribArrayBuffer alloc] initWithAttribStride:(3*sizeof(GLfloat))
                                                                         numberOfVertices:sizeof(sphereVerts)/(3*sizeof(GLfloat))
                                                                                    bytes:sphereVerts
                                                                                    usage:GL_STATIC_DRAW];
    
    self.vertexNormalBuffer = [[AGLKVertexAttribArrayBuffer alloc] initWithAttribStride:(3*sizeof(GLfloat))
                                                                       numberOfVertices:sizeof(sphereVerts)/(3*sizeof(GLfloat))
                                                                                  bytes:sphereNormals
                                                                                  usage:GL_STATIC_DRAW];
    
    self.vertexTextureCoordBuffer = [[AGLKVertexAttribArrayBuffer alloc] initWithAttribStride:(2*sizeof(GLfloat))
                                                                             numberOfVertices:sizeof(sphereTexCoords)/(2*sizeof(GLfloat))
                                                                                        bytes:sphereTexCoords
                                                                                        usage:GL_STATIC_DRAW];
    
    // 开启片元深度测试
    [(AGLKContext *)view.context enable:GL_DEPTH_TEST];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    
    [self.baseEffect prepareToDraw];
    
    // 这样设置clear方法来：同一时间清除深度缓存 和 像素颜色渲染缓存
    [(AGLKContext *)view.context clear:GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT];
    
    [self.vertexPositionBuffer prepareToDrawWithAttrib:GLKVertexAttribPosition
                                   numberOfCoordinates:3
                                                  data:0
                                          shouldEnable:YES];
    
    [self.vertexNormalBuffer prepareToDrawWithAttrib:GLKVertexAttribNormal
                                 numberOfCoordinates:3
                                                data:0
                                        shouldEnable:YES];
    
    [self.vertexTextureCoordBuffer prepareToDrawWithAttrib:GLKVertexAttribTexCoord0
                                       numberOfCoordinates:2
                                                      data:0
                                              shouldEnable:YES];
    
    // 这里计算屏幕的横纵比
    const GLfloat aspectRatio = (GLfloat)view.drawableWidth/(GLfloat)view.drawableHeight;
    // 这里通过 GLKMatrix4MakeScale 创建了一个基础的变换矩阵（transformation matrix）
    // 三个参数分别改变坐标系三个轴的相对单位长度，设置为1.f意味没有变化。Y轴设置为横纵比用于缩放Y轴以抵消拉伸效果
    self.baseEffect.transform.projectionMatrix = GLKMatrix4MakeScale(1.f, aspectRatio, 1.f);
    
    [AGLKVertexAttribArrayBuffer drawPreparedArraysWithMode:GL_TRIANGLES
                                           startVertexIndex:0
                                           numberOfVertices:sphereNumVerts];
    
}
@end
