//
//  Car_Test_Car.m
//  Learning-OpenGLES
//
//  Created by 贾辰 on 2020/7/2.
//  Copyright © 2020 JJC. All rights reserved.
//

#import "Car_Test_Car.h"
#import "AGLKVertexAttribArrayBuffer.h"
#import "bumperCar.h"

@interface Car_Test_Car()
@property (strong, nonatomic) AGLKVertexAttribArrayBuffer *vertexPositonBuffer;
@property (strong, nonatomic) AGLKVertexAttribArrayBuffer *vertexNormalBuffer;
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
                                                                        numberOfVertices:sizeof(bumperCarVerts)/(3*sizeof(GLfloat))
                                                                                   bytes:bumperCarVerts
                                                                                   usage:GL_STATIC_DRAW];
    
    self.vertexNormalBuffer = [[AGLKVertexAttribArrayBuffer alloc] initWithAttribStride:(3*sizeof(GLfloat))
                                                                       numberOfVertices:sizeof(bumperCarNormals)/(3*sizeof(GLfloat))
                                                                                  bytes:bumperCarNormals
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
                                           numberOfVertices:bumperCarNumVerts];
}
@end
