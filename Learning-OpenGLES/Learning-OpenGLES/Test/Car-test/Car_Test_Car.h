//
//  Car_Test_Car.h
//  Learning-OpenGLES
//
//  Created by 贾辰 on 2020/7/2.
//  Copyright © 2020 JJC. All rights reserved.
//

//#import <GLKit/GLKit.h>
#import <GLKit/GLKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Car_Test_Car : NSObject
- (void)prepareToDraw;
- (void)drawWithBaseEffect:(GLKBaseEffect *)anEffect color:(GLKVector4)carColor;
- (void)move;
@end

NS_ASSUME_NONNULL_END
