//
//  ViewController_CH3_3.m
//  Learning-OpenGLES
//
//  Created by 贾辰 on 2020/6/27.
//  Copyright © 2020 JJC. All rights reserved.
//

#import "ViewController_CH3_3.h"

typedef struct {
    GLKVector3  positionCoords;
    GLKVector2  textureCoords;  // 新增了纹理数据
} SceneVertex;

/////////////////////////////////////////////////////////////////
// 用顶点数据初始化的C数组，用来定义一个三角形
static const SceneVertex vertices[] =
{
    {{-0.5f, -0.5f, 0.0},{0.f,0.f}}, // lower left corner
    {{ 0.5f, -0.5f, 0.0},{1.f,0.f}}, // lower right corner
    {{-0.5f,  0.5f, 0.0},{0.f,1.f}}  // upper left corner
};

@interface ViewController_CH3_3 ()

@end

@implementation ViewController_CH3_3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
