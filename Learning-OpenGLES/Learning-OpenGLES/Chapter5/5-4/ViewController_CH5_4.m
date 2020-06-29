//
//  ViewController_CH5_4.m
//  Learning-OpenGLES
//
//  Created by 贾辰 on 2020/6/29.
//  Copyright © 2020 JJC. All rights reserved.
//

#import "ViewController_CH5_4.h"
#import "GLKViewController+BtnBack.h"
#import "AGLKContext.h"
#import "AGLKVertexAttribArrayBuffer.h"

#import "lowPolyAxesAndModels2.h"

@interface ViewController_CH5_4 ()
{
    CGFloat translateX;
    CGFloat translateY;
    CGFloat translateZ;
    
    CGFloat rotateX;
    CGFloat rotateY;
    CGFloat rotateZ;
    
    CGFloat scaleX;
    CGFloat scaleY;
    CGFloat scaleZ;
}
@property (strong, nonatomic) GLKBaseEffect *baseEffect;
@property (strong, nonatomic) AGLKVertexAttribArrayBuffer *vertexPositionBuffer;
@property (strong, nonatomic) AGLKVertexAttribArrayBuffer *vertexNormalBuffer;
@end

@implementation ViewController_CH5_4

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBtnBackOnView:self.view];
    // Do any additional setup after loading the view.
    [self createUI];
    
    GLKView *view = (GLKView *)self.view;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat16;
    view.context = [[AGLKContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [AGLKContext setCurrentContext:view.context];
    
    self.baseEffect = [[GLKBaseEffect alloc] init];
    self.baseEffect.light0.enabled = GL_TRUE;
    self.baseEffect.light0.diffuseColor = GLKVector4Make(0.7f, 0.7f, 0.7f, 1.f);
    self.baseEffect.light0.position = GLKVector4Make(1.f, 0.f, -0.8f, 0.f);
    
    // BG color
    ((AGLKContext *)view.context).clearColor = GLKVector4Make(.7f, .7f, .5f, 1.f);
    
    /*************** 场景旋转 **************/
    {  // Comment out this block to render the scene top down
       GLKMatrix4 modelViewMatrix = GLKMatrix4MakeRotation(
          GLKMathDegreesToRadians(-60.0f), 1.0f, 0.0f, 0.0f);
       modelViewMatrix = GLKMatrix4Rotate(
          modelViewMatrix,
          GLKMathDegreesToRadians(-30.0f), 0.0f, 0.0f, 1.0f);
       modelViewMatrix = GLKMatrix4Translate(
          modelViewMatrix,
          0.0f, 0.0f, 0.25f);

       self.baseEffect.transform.modelviewMatrix = modelViewMatrix;
    }
    
    self.vertexPositionBuffer = [[AGLKVertexAttribArrayBuffer alloc] initWithAttribStride:3*sizeof(GLfloat)
                                                                         numberOfVertices:sizeof(lowPolyAxesAndModels2Verts)/(3*sizeof(GLfloat))
                                                                                    bytes:lowPolyAxesAndModels2Verts
                                                                                    usage:GL_STATIC_DRAW];
    
    self.vertexNormalBuffer = [[AGLKVertexAttribArrayBuffer alloc] initWithAttribStride:3*sizeof(GLfloat)
                                                                       numberOfVertices:sizeof(lowPolyAxesAndModels2Normals)/(3*sizeof(GLfloat))
                                                                                  bytes:lowPolyAxesAndModels2Normals
                                                                                  usage:GL_STATIC_DRAW];
    
    // 开启片元深度测试
    [(AGLKContext *)view.context enable:GL_DEPTH_TEST];
    
    translateX = 0.f;
    translateY = 0.f;
    translateZ = 0.f;
    
    rotateX = 0.f;
    rotateY = 0.f;
    rotateZ = 0.f;
    
    scaleX = 1.f;
    scaleY = 1.f;
    scaleZ = 0.f;
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    [self.baseEffect prepareToDraw];
    
    /** 定义一个正向投影 */
    const GLfloat  aspectRatio = (GLfloat)view.drawableWidth / (GLfloat)view.drawableHeight;
    self.baseEffect.transform.projectionMatrix = GLKMatrix4MakeOrtho( -0.5 * aspectRatio, 0.5 * aspectRatio, -0.5, 0.5, -5.0, 5.0);
    
    [(AGLKContext *)view.context clear:GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT];
    
    [self.vertexPositionBuffer prepareToDrawWithAttrib:GLKVertexAttribPosition
                                   numberOfCoordinates:3
                                                  data:0
                                          shouldEnable:YES];
    
    [self.vertexNormalBuffer prepareToDrawWithAttrib:GLKVertexAttribNormal
                                 numberOfCoordinates:3
                                                data:0
                                        shouldEnable:YES];
    
    GLKMatrix4 matrix = GLKMatrix4MakeTranslation(translateX, translateY, translateZ);

    if (rotateX > 0) {
        matrix = GLKMatrix4Rotate(matrix, rotateX, 1, 0, 0);
//        matrix = GLKMatrix4MakeRotation(rotateX, 1, 0, 0);  // 没有 matrix 的情况
    }
    if (rotateY>0) {
        matrix = GLKMatrix4Rotate(matrix, rotateY, 0, 1, 0);
    }
    if (rotateZ>0) {
        matrix = GLKMatrix4Rotate(matrix, rotateZ, 0, 0, 1);
    }

    matrix = GLKMatrix4Scale(matrix, scaleX, scaleY, scaleZ);
    
    /**
     这里 transform 包含3个矩阵：projectionMatrix & modelviewMatrix & normalMatrix
     projectionMatrix:定义了一个用于整个场景的坐标系
     modelviewMatrix:定义了一个用于控制对象（场景内模型）显示位置的坐标系
     GLKBaseEffect会 级联projectionMatrix和modelviewMatrix 来产生一个modelviewProjectionMatrix矩阵，以将对象顶点变换到OpenGLES默认坐标系中
     默认坐标系直接映射到像素颜色渲染缓存中的片元位置
     */
    self.baseEffect.transform.projectionMatrix = matrix;
    
    self.baseEffect.light0.diffuseColor = GLKVector4Make(
       1.0f, // Red
       1.0f, // Green
       0.0f, // Blue
       0.3f);// Alpha

    [self.baseEffect prepareToDraw];
    
    [AGLKVertexAttribArrayBuffer drawPreparedArraysWithMode:GL_TRIANGLES
                                           startVertexIndex:0
                                           numberOfVertices:lowPolyAxesAndModels2NumVerts];
}

#pragma mark - UI
- (void)createUI {
    UILabel *lbl1 = [[UILabel alloc] init];
    lbl1.text = @"平移x";
    lbl1.textColor = [UIColor whiteColor];
    [lbl1 sizeToFit];
    [self.view addSubview:lbl1];
    lbl1.center = CGPointMake(60, 440);
    
    UISlider *slider1 = [[UISlider alloc] initWithFrame:CGRectMake(CGRectGetMidX(lbl1.frame)-50, CGRectGetMaxY(lbl1.frame)+5.f, 100, 50)];
    [slider1 setValue:0.5f];
    [slider1 addTarget:self action:@selector(translateX:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider1];
    
    UILabel *lbl2 = [[UILabel alloc] init];
    lbl2.text = @"平移y";
    lbl2.textColor = [UIColor whiteColor];
    [lbl2 sizeToFit];
    [self.view addSubview:lbl2];
    lbl2.center = CGPointMake(170, 440);
    
    UISlider *slider2 = [[UISlider alloc] initWithFrame:CGRectMake(CGRectGetMidX(lbl2.frame)-50, CGRectGetMaxY(lbl2.frame)+5.f, 100, 50)];
    [slider2 setValue:0.5f];
    [slider2 addTarget:self action:@selector(translateY:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider2];
    
    UILabel *lbl3 = [[UILabel alloc] init];
    lbl3.text = @"平移z";
    lbl3.textColor = [UIColor whiteColor];
    [lbl3 sizeToFit];
    [self.view addSubview:lbl3];
    lbl3.center = CGPointMake(280, 440);
    
    UISlider *slider3 = [[UISlider alloc] initWithFrame:CGRectMake(CGRectGetMidX(lbl3.frame)-50, CGRectGetMaxY(lbl3.frame)+5.f, 100, 50)];
    [slider3 setValue:0.5f];
    [slider3 addTarget:self action:@selector(translateZ:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider3];
    
    UILabel *lbl11 = [[UILabel alloc] init];
    lbl11.text = @"旋转x";
    lbl11.textColor = [UIColor whiteColor];
    [lbl11 sizeToFit];
    [self.view addSubview:lbl11];
    lbl11.center = CGPointMake(60, 520);
    
    UISlider *slider11 = [[UISlider alloc] initWithFrame:CGRectMake(CGRectGetMidX(lbl11.frame)-50, CGRectGetMaxY(lbl11.frame)+5.f, 100, 50)];
    [slider11 addTarget:self action:@selector(rotateX:) forControlEvents:UIControlEventValueChanged];
    [slider11 setValue:0.f];
    [self.view addSubview:slider11];
    
    UILabel *lbl22 = [[UILabel alloc] init];
    lbl22.text = @"旋转y";
    lbl22.textColor = [UIColor whiteColor];
    [lbl22 sizeToFit];
    [self.view addSubview:lbl22];
    lbl22.center = CGPointMake(170, 520);
    
    UISlider *slider22 = [[UISlider alloc] initWithFrame:CGRectMake(CGRectGetMidX(lbl22.frame)-50, CGRectGetMaxY(lbl22.frame)+5.f, 100, 50)];
    [slider22 addTarget:self action:@selector(rotateY:) forControlEvents:UIControlEventValueChanged];
    [slider22 setValue:0.f];
    [self.view addSubview:slider22];
    
    UILabel *lbl33 = [[UILabel alloc] init];
    lbl33.text = @"旋转z";
    lbl33.textColor = [UIColor whiteColor];
    [lbl33 sizeToFit];
    [self.view addSubview:lbl33];
    lbl33.center = CGPointMake(280, 520);
    
    UISlider *slider33 = [[UISlider alloc] initWithFrame:CGRectMake(CGRectGetMidX(lbl33.frame)-50, CGRectGetMaxY(lbl33.frame)+5.f, 100, 50)];
    [slider33 addTarget:self action:@selector(scaleZ:) forControlEvents:UIControlEventValueChanged];
    [slider33 setValue:0.f];
    [self.view addSubview:slider33];
    
    UILabel *lbl111 = [[UILabel alloc] init];
    lbl111.text = @"缩放x";
    lbl111.textColor = [UIColor whiteColor];
    [lbl111 sizeToFit];
    [self.view addSubview:lbl111];
    lbl111.center = CGPointMake(60, 600);
    
    UISlider *slider111 = [[UISlider alloc] initWithFrame:CGRectMake(CGRectGetMidX(lbl111.frame)-50, CGRectGetMaxY(lbl111.frame)+5.f, 100, 50)];
    [slider111 addTarget:self action:@selector(scaleX:) forControlEvents:UIControlEventValueChanged];
    [slider111 setValue:1.f];
    [self.view addSubview:slider111];
    
    UILabel *lbl222 = [[UILabel alloc] init];
    lbl222.text = @"缩y";
    lbl222.textColor = [UIColor whiteColor];
    [lbl222 sizeToFit];
    [self.view addSubview:lbl222];
    lbl222.center = CGPointMake(170, 600);
    
    UISlider *slider222 = [[UISlider alloc] initWithFrame:CGRectMake(CGRectGetMidX(lbl222.frame)-50, CGRectGetMaxY(lbl222.frame)+5.f, 100, 50)];
    [slider222 addTarget:self action:@selector(scaleY:) forControlEvents:UIControlEventValueChanged];
    [slider222 setValue:1.f];
    [self.view addSubview:slider222];
    
    UILabel *lbl333 = [[UILabel alloc] init];
    lbl333.text = @"缩z";
    lbl333.textColor = [UIColor whiteColor];
    [lbl333 sizeToFit];
    [self.view addSubview:lbl333];
    lbl333.center = CGPointMake(280, 600);
    
    UISlider *slider333 = [[UISlider alloc] initWithFrame:CGRectMake(CGRectGetMidX(lbl333.frame)-50, CGRectGetMaxY(lbl333.frame)+5.f, 100, 50)];
    [slider333 addTarget:self action:@selector(scaleZ:) forControlEvents:UIControlEventValueChanged];
    [slider333 setValue:0.5f];
    [self.view addSubview:slider333];
}

- (void)translateX:(UISlider *)slider {
    NSLog(@"%f",slider.value);
    translateX = slider.value*2-1;
}
- (void)translateY:(UISlider *)slider {
    NSLog(@"%f",slider.value);
    translateY = slider.value*2-1;
}
- (void)translateZ:(UISlider *)slider {
    NSLog(@"%f",slider.value);
    translateZ = slider.value*2-1;
}

- (void)rotateX:(UISlider *)slider {
    NSLog(@"%f",slider.value);
    rotateX = slider.value*M_PI;
}
- (void)rotateY:(UISlider *)slider {
    NSLog(@"%f",slider.value);
    rotateY = slider.value*M_PI;
}
- (void)rotateZ:(UISlider *)slider {
    NSLog(@"%f",slider.value);
    rotateZ = slider.value*M_PI;
}

- (void)scaleX:(UISlider *)slider {
    NSLog(@"%f",slider.value);
    scaleX = slider.value*2-1;
}
- (void)scaleY:(UISlider *)slider {
    NSLog(@"%f",slider.value);
    scaleY = slider.value*2-1;
}
- (void)scaleZ:(UISlider *)slider {
    NSLog(@"%f",slider.value);
    scaleZ = slider.value*2-1;
}
@end
