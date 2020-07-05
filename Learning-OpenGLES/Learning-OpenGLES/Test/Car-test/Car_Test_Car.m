//
//  Car_Test_Car.m
//  Learning-OpenGLES
//
//  Created by 贾辰 on 2020/7/2.
//  Copyright © 2020 JJC. All rights reserved.
//

#import "Car_Test_Car.h"
#import "AGLKVertexAttribArrayBuffer.h"
#import "try-bumperCar.h"
#import "SceneModel.h"

@interface Car_Test_Car()
@property (strong, nonatomic) AGLKVertexAttribArrayBuffer *vertexPositonBuffer;
@property (strong, nonatomic) AGLKVertexAttribArrayBuffer *vertexNormalBuffer;

@property (strong, nonatomic, readwrite) SceneModel *model;
@end

@implementation Car_Test_Car
- (instancetype)init {
    self = [super init];
    if (self) {
        [self createCarVertexData];
    }
    return self;
}

- (void)createCarVertexData {
    self.vertexPositonBuffer = [[AGLKVertexAttribArrayBuffer alloc] initWithAttribStride:(3*sizeof(GLfloat))
                                                                        numberOfVertices:sizeof(bumperCarVerts1)/(3*sizeof(GLfloat))
                                                                                   bytes:bumperCarVerts1
                                                                                   usage:GL_STATIC_DRAW];
    
    self.vertexNormalBuffer = [[AGLKVertexAttribArrayBuffer alloc] initWithAttribStride:(3*sizeof(GLfloat))
                                                                       numberOfVertices:sizeof(bumperCarNormals1)/(3*sizeof(GLfloat))
                                                                                  bytes:bumperCarNormals1
                                                                                  usage:GL_STATIC_DRAW];
}

- (void)prepareToDraw {
    [self.vertexPositonBuffer prepareToDrawWithAttrib:GLKVertexAttribPosition
                                  numberOfCoordinates:3
                                                 data:0
                                         shouldEnable:YES];
    
    [self.vertexNormalBuffer prepareToDrawWithAttrib:GLKVertexAttribNormal
                                 numberOfCoordinates:3
                                                data:0
                                        shouldEnable:YES];
    
    [AGLKVertexAttribArrayBuffer drawPreparedArraysWithMode:GL_TRIANGLES
                                           startVertexIndex:0
                                           numberOfVertices:bumperCarNumVerts1];
}

- (void)drawWithBaseEffect:(GLKBaseEffect *)anEffect color:(GLKVector4)carColor {
    GLKMatrix4  savedModelviewMatrix = anEffect.transform.modelviewMatrix;
    GLKVector4  savedDiffuseColor = anEffect.material.diffuseColor;
    GLKVector4  savedAmbientColor = anEffect.material.ambientColor;
    
    // Translate to the model's position
//    anEffect.transform.modelviewMatrix = GLKMatrix4Translate(savedModelviewMatrix,position.x, position.y, position.z);
    
    // Rotate to match model's yaw angle (rotation about Y)
//    anEffect.transform.modelviewMatrix =  GLKMatrix4Rotate(anEffect.transform.modelviewMatrix,
//                     self.yawRadians,
//                     0.0, 1.0, 0.0);
    
    // 设置材质的颜色
    anEffect.material.diffuseColor = carColor; // 漫反射颜色
    anEffect.material.ambientColor = carColor; // 环境光颜色
    
    // Draw the model
    [self prepareToDraw];
    
    [anEffect prepareToDraw];
    
    // Restore saved attributes
    anEffect.transform.modelviewMatrix = savedModelviewMatrix;
    anEffect.material.diffuseColor = savedDiffuseColor;
    anEffect.material.ambientColor = savedAmbientColor;
}
@end
