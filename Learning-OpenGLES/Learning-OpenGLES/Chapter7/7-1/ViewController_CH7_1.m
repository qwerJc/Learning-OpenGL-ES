//
//  ViewController_CH7_1.m
//  Learning-OpenGLES
//
//  Created by 贾辰 on 2020/7/6.
//  Copyright © 2020 JJC. All rights reserved.
//

#import "ViewController_CH7_1.h"
#import "GLKViewController+BtnBack.h"

#import "AGLKContext.h"
#import "AGLKVertexAttribArrayBuffer.h"

#import "UtilityModelManager.h"

@interface ViewController_CH7_1 ()
@property (strong, nonatomic) GLKBaseEffect *baseEffect;  // 实例指针
@property (strong, nonatomic) AGLKVertexAttribArrayBuffer *vertexBuffer;

@property (strong, nonatomic) UtilityModelManager *managerModel;
@end

@implementation ViewController_CH7_1

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBtnBackOnView:self.view];
    // Do any additional setup after loading the view.
    
    GLKView *view = (GLKView *)self.view;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24; // 这里使用 high resolution depth buffer
    view.context = [[AGLKContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [AGLKContext setCurrentContext:view.context];
    [(AGLKContext *)view.context enable:GL_DEPTH_TEST];
    
    self.baseEffect = [[GLKBaseEffect alloc] init];
    self.baseEffect.light0.enabled = GL_TRUE;
    self.baseEffect.light0.ambientColor = GLKVector4Make(.7f, .7f, .7f, 1.f);
    self.baseEffect.light0.diffuseColor = GLKVector4Make(1.f, 1.f, 1.f, 1.f);
    self.baseEffect.light0.position = GLKVector4Make(1.f, .8f, .4f, 1.f);
    
    ((AGLKContext *)view.context).clearColor = GLKVector4Make(0.f, 0.f, 0.f, 1.f);
    
    NSString *modelsPath = [[NSBundle mainBundle] pathForResource:@"bumper" ofType:@"modelplist"];
    self.managerModel = [[UtilityModelManager alloc] initWithModelPath:modelsPath];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
