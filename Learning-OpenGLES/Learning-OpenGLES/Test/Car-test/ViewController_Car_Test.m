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

#import "SceneRinkModel.h"

#import "Car_Test_Rink.h"


@interface ViewController_Car_Test ()
@property (strong, nonatomic) GLKBaseEffect *baseEffect;  // 实例指针
@property (strong, nonatomic) AGLKVertexAttribArrayBuffer *vertexBuffer;

@property (strong, nonatomic) Car_Test_Rink *rink;
@property (strong, nonatomic) SceneRinkModel *rinkModel;
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
    
//    self.rink = [[Car_Test_Rink alloc] init];
    self.rinkModel = [[SceneRinkModel alloc] init];
    
    [(AGLKContext *)view.context enable:GL_DEPTH_TEST];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    [self.baseEffect prepareToDraw];
    
    [(AGLKContext *)view.context clear:GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT];
    
//    [self.rink prepareToDraw];
    
    [self.rinkModel draw];
}

@end
