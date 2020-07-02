//
//  Car_Test_Rink.m
//  Learning-OpenGLES
//
//  Created by 贾辰 on 2020/7/2.
//  Copyright © 2020 JJC. All rights reserved.
//

#import "Car_Test_Rink.h"
#import "AGLKVertexAttribArrayBuffer.h"
#import "bumperRink.h"

@interface Car_Test_Rink()
@property (strong, nonatomic) AGLKVertexAttribArrayBuffer *vertexPositionBuffer;
@property (strong, nonatomic) AGLKVertexAttribArrayBuffer *vertexNormalBuffer;
@end

@implementation Car_Test_Rink
- (instancetype)init {
    self = [super init];
    if (self) {
        [self createRinkVertexData];
    }
    return self;
}

- (void)createRinkVertexData {
    self.vertexPositionBuffer = [[AGLKVertexAttribArrayBuffer alloc] initWithAttribStride:(3*sizeof(GLfloat))
                                                                         numberOfVertices:sizeof(bumperRinkVerts)/(3*sizeof(GLfloat))
                                                                                    bytes:bumperRinkVerts
                                                                                    usage:GL_STATIC_DRAW];

    self.vertexNormalBuffer = [[AGLKVertexAttribArrayBuffer alloc] initWithAttribStride:(3*sizeof(GLfloat))
                                                                       numberOfVertices:sizeof(bumperRinkNormals)/(3*sizeof(GLfloat))
                                                                                  bytes:bumperRinkNormals
                                                                                  usage:GL_STATIC_DRAW];
}

- (void)prepareToDraw {
    
    [self.vertexPositionBuffer prepareToDrawWithAttrib:GLKVertexAttribPosition
                                 numberOfCoordinates:3
                                                data:0
                                          shouldEnable:YES];
    
    [self.vertexNormalBuffer prepareToDrawWithAttrib:GLKVertexAttribNormal
                                 numberOfCoordinates:3
                                                data:0
                                        shouldEnable:YES];
    
    [AGLKVertexAttribArrayBuffer drawPreparedArraysWithMode:GL_TRIANGLES
                                           startVertexIndex:0
                                           numberOfVertices:bumperRinkNumVerts];
}
@end
