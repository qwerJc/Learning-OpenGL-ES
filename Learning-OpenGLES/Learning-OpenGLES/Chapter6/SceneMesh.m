//
//  SceneMesh.m
//  Learning-OpenGLES
//
//  Created by 贾辰 on 2020/6/30.
//  Copyright © 2020 JJC. All rights reserved.
//

#import "SceneMesh.h"
#import "AGLKVertexAttribArrayBuffer.h"

@interface SceneMesh()
@property (assign, nonatomic) GLKVector3 position;
@property (assign, nonatomic) GLKVector2 minTextureCoords;
@property (assign, nonatomic) GLKVector2 maxTextureCoords;
@property (assign, nonatomic) GLKVector2 size;
@property (assign, nonatomic) GLfloat    distanceSquared;

@property (strong, nonatomic) AGLKVertexAttribArrayBuffer *vertexAttributeBuffer;
@property (assign, nonatomic) GLuint indexBufferID;
@property (strong, nonatomic) NSData *vertexData;
@property (strong, nonatomic) NSData *indexData;
@end

@implementation SceneMesh
#pragma mark - Init
- (instancetype)initWithVertexAttributeData:(NSData *)vertexAttributes
                                  indexData:(NSData *)indices {
    self = [super init];
    if (self) {
        _vertexData = vertexAttributes;
        _indexData = indices;
    }
    return self;
}

- (instancetype)initWithPositionCoords:(GLfloat *)somePositions
                          normalCoords:(GLfloat *)someNormals
                            texCoords0:(GLfloat *)someTextCoords0
                     numberOfPositions:(size_t)coutPositions
                              indeices:(GLushort *)someIndices
                       numberOfIndices:(size_t)countIndices {
    NSMutableData *vertexAttributesData = [[NSMutableData alloc] init];
    NSMutableData *indicesData = [[NSMutableData alloc] init];
    
    [indicesData appendBytes:someIndices
                      length:countIndices*sizeof(GLushort)];
    
    for (size_t i=0; i<coutPositions; i++) {
        SceneMeshVertex currentVertex;
        
        currentVertex.position.x = someIndices[i*3 + 0];
        currentVertex.position.y = someIndices[i*3 + 1];
        currentVertex.position.z = someIndices[i*3 + 2];
        
        currentVertex.normal.x = someNormals[i*3 + 0];
        currentVertex.normal.y = someNormals[i*3 + 1];
        currentVertex.normal.z = someNormals[i*3 + 2];
        
        if (someTextCoords0 != NULL) {
            currentVertex.texCoords0.s = someTextCoords0[i*2 + 0];
            currentVertex.texCoords0.t = someTextCoords0[i*2 + 1];
        } else {
            currentVertex.texCoords0.s = 0.f;
            currentVertex.texCoords0.t = 0.f;
        }
        
        [vertexAttributesData appendBytes:&currentVertex length:sizeof(currentVertex)];
    }
    
    return [self initWithVertexAttributeData:vertexAttributesData
                                   indexData:indicesData];
}

#pragma mark - Draw
- (void)prepareToDraw {
    if (!self.vertexAttributeBuffer && [self.vertexData length]>0) {
        self.vertexAttributeBuffer = [[AGLKVertexAttribArrayBuffer alloc] initWithAttribStride:sizeof(SceneMeshVertex)
                                                                              numberOfVertices:[self.vertexData length]/sizeof(SceneMeshVertex)
                                                                                         bytes:[self.vertexData bytes]
                                                                                         usage:GL_STATIC_DRAW];
        
        // 不在需要本地存储了
        self.vertexData = nil;
    }
    
    if ((_indexBufferID==0) && ([self.indexData length]>0)) {
        glGenBuffers(1, &_indexBufferID);
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, self.indexBufferID);
        glBufferData(GL_ELEMENT_ARRAY_BUFFER, [self.indexData length], [self.indexData bytes], GL_STATIC_DRAW);
        
        self.indexData = nil;
    }
    
    [self.vertexAttributeBuffer prepareToDrawWithAttrib:GLKVertexAttribPosition
                                    numberOfCoordinates:3
                                                   data:offsetof(SceneMeshVertex, position)
                                           shouldEnable:YES];
    
    [self.vertexAttributeBuffer prepareToDrawWithAttrib:GLKVertexAttribNormal
                                    numberOfCoordinates:3
                                                   data:offsetof(SceneMeshVertex, normal)
                                           shouldEnable:YES];
    
    [self.vertexAttributeBuffer prepareToDrawWithAttrib:GLKVertexAttribTexCoord0
                                    numberOfCoordinates:2
                                                   data:offsetof(SceneMeshVertex, normal)
                                           shouldEnable:YES];
    
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBufferID);
}

- (void)drawUnidexedWithMode:(GLenum)mode
            startVertexIndex:(GLint)first
            numberOfVertices:(GLsizei)count {
    
    [self.vertexAttributeBuffer drawArrayWithMode:mode
                                 startVertexIndex:first
                                 numberOfVertices:count];
}

- (void)makeDynamicAndUpdateWithVertices:(SceneMeshVertex *)someVerts numberOfVertices:(size_t)count {
    if (self.vertexAttributeBuffer) {
        [self.vertexAttributeBuffer reinitWithAttribStride:sizeof(SceneMeshVertex)
                                          numberOfVertices:count
                                                     bytes:someVerts];
    } else {
        
        self.vertexAttributeBuffer = [[AGLKVertexAttribArrayBuffer alloc] initWithAttribStride:sizeof(SceneMeshVertex)
                                                                              numberOfVertices:count
                                                                                         bytes:someVerts
                                                                                         usage:GL_DYNAMIC_DRAW];
    }
}
@end
