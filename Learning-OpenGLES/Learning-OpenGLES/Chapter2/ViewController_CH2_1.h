//
//  ViewController_CH2_1.h
//  Learning-OpenGLES
//
//  Created by 贾辰 on 2020/6/20.
//  Copyright © 2020 JJC. All rights reserved.
//

#import <GLKit/GLKit.h>

NS_ASSUME_NONNULL_BEGIN

// GLKViewController 继承自 UIViewController，同时里面的self.view属性也变为了GLKView
// GLKViewController 会自动重新设置OpenGLES和应用的GLKView实例以响应设备方向的变化并可视化过渡效果，例如淡出和淡入
@interface ViewController_CH2_1 : GLKViewController
{
   GLuint vertexBufferID; // 保存顶点数据缓存的标识符
}
// ⚠️GLKBaseEffect：是一个内建类，可隐藏OpenGLES版本间的差异
// 通过使用 GLKBaseEffect 可以减少编写的代码
@property (strong, nonatomic) GLKBaseEffect *baseEffect;  // 实例指针
@end

NS_ASSUME_NONNULL_END
