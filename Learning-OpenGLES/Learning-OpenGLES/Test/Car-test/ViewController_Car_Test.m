//
//  ViewController_Car_Test.m
//  Learning-OpenGLES
//
//  Created by 贾辰 on 2020/7/2.
//  Copyright © 2020 JJC. All rights reserved.
//

#import "ViewController_Car_Test.h"
#import "GLKViewController+BtnBack.h"

#import "AGLKContext.h"
#import "AGLKVertexAttribArrayBuffer.h"

//#import "SceneRinkModel.h"

#import "Car_Test_Rink.h"
#import "Car_Test_Car.h"

@interface ViewController_Car_Test ()
@property (strong, nonatomic) GLKBaseEffect *baseEffect;  // 实例指针
@property (strong, nonatomic) AGLKVertexAttribArrayBuffer *vertexBuffer;

@property (strong, nonatomic) Car_Test_Rink *rink;
@property (strong, nonatomic) Car_Test_Car *car;

@property (nonatomic, assign) GLKVector3 eyePosition;
@property (nonatomic, assign) GLKVector3 lookAtPosition;
@end

@implementation ViewController_Car_Test

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBtnBackOnView:self.view];
    // Do any additional setup after loading the view.
    
    GLKView *view = (GLKView *)self.view;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat16;
    view.context = [[AGLKContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [AGLKContext setCurrentContext:view.context];
    
    self.baseEffect = [[GLKBaseEffect alloc] init];
    self.baseEffect.light0.enabled = GL_TRUE;
    self.baseEffect.light0.diffuseColor = GLKVector4Make(0.7f, 0.7f, 0.7f, 1.f);
    self.baseEffect.light0.ambientColor = GLKVector4Make(0.2f, 0.2f, 0.2f, 1.f);
    self.baseEffect.light0.position = GLKVector4Make(1.f, 0.f, -0.8f, 0.f);
    
    [(AGLKContext *)view.context setClearColor:GLKVector4Make(.7f, .7f, .5f, 1.f)];
    
    self.rink = [[Car_Test_Rink alloc] init];
    
    self.car = [[Car_Test_Car alloc] init];
    
    [(AGLKContext *)view.context enable:GL_DEPTH_TEST];
    
    self.eyePosition = GLKVector3Make(10.f, 10.0, 10.0);
    self.lookAtPosition = GLKVector3Make(.0f, 0.1f, 0.);
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    [self.baseEffect prepareToDraw];
    
    [(AGLKContext *)view.context clear:GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT];
    
    const GLfloat  aspectRatio =
       (GLfloat)view.drawableWidth / (GLfloat)view.drawableHeight;

    self.baseEffect.transform.projectionMatrix =
       GLKMatrix4MakePerspective(
          GLKMathDegreesToRadians(35.0f),// Standard field of view
          aspectRatio,
          0.1f,   // Don't make near plane too close
          105.0f); // Far is aritrarily far enough to contain scene

    // Set the modelview matrix to match current eye and look-at
    // positions
    self.baseEffect.transform.modelviewMatrix =
       GLKMatrix4MakeLookAt(
          self.eyePosition.x,
          self.eyePosition.y,
          self.eyePosition.z,
          self.lookAtPosition.x,
          self.lookAtPosition.y,
          self.lookAtPosition.z,
          0, 1, 0);
    
    [self.rink prepareToDraw];
    
    self.baseEffect.
    
    [self.car prepareToDraw];
}

@end
