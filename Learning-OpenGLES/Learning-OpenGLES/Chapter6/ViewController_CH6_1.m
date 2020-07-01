//
//  ViewController_CH6_1.m
//  Learning-OpenGLES
//
//  Created by 贾辰 on 2020/6/30.
//  Copyright © 2020 JJC. All rights reserved.
//

#import "ViewController_CH6_1.h"
#import "GLKViewController+BtnBack.h"
#import "AGLKContext.h"
#import "AGLKVertexAttribArrayBuffer.h"

#import "SceneCarModel.h"

@interface ViewController_CH6_1 ()
@property (strong, nonatomic) NSArray *cars;
@property (strong, nonatomic) SceneCarModel *carModel;

@property (strong, nonatomic) GLKBaseEffect *baseEffect;  // 实例指针

@end

@implementation ViewController_CH6_1

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBtnBackOnView:self.view];
    // Do any additional setup after loading the view.
    
    GLKView *view = (GLKView *)self.view;
    
    view.drawableDepthFormat = GLKViewDrawableDepthFormat16;
    
    view.context = [[AGLKContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [AGLKContext setCurrentContext:view.context];
    
    [(AGLKContext *)view.context setClearColor:GLKVector4Make(0.1f, 0.3f, 0.2f, 1.f)];
    
    self.baseEffect = [[GLKBaseEffect alloc] init];
    self.baseEffect.light0.enabled = GL_TRUE;
    self.baseEffect.light0.diffuseColor = GLKVector4Make(0.7f, .7f, .7f, 1.f);
    self.baseEffect.light0.position = GLKVector4Make(-1.f, -0.3f, 0.6f, 0.f);
    
    [(AGLKContext *)view.context enable:GL_DEPTH_TEST];
    
    self.carModel = [[SceneCarModel alloc] init];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    
    [self.baseEffect prepareToDraw];
    
    // 这样设置clear方法来：同一时间清除深度缓存 和 像素颜色渲染缓存
    [(AGLKContext *)view.context clear:GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT];
    
}

@end
