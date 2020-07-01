//
//  SceneModel.m
//  Learning-OpenGLES
//
//  Created by 贾辰 on 2020/6/30.
//  Copyright © 2020 JJC. All rights reserved.
//

#import "SceneModel.h"
#import "SceneMesh.h"
#import "AGLKVertexAttribArrayBuffer.h"

typedef struct {
   GLKVector3 min;
   GLKVector3 max;
}SceneAxisAllignedBoundingBox;

@interface SceneModel()
@property (strong, nonatomic) SceneMesh *mesh;
@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) GLsizei numberOfVertics;
@property (assign, nonatomic) SceneAxisAllignedBoundingBox axisAlignedBoundingBox;
@end

@implementation SceneModel
- (instancetype)initWithName:(NSString *)aName
                        mesh:(SceneMesh *)aMesh
            numberOfVertices:(GLsizei)aCount {
    self = [super init];
    if (self) {
        _name = aName;
        _mesh = aMesh;
        _numberOfVertics = aCount;
    }
    return self;
}

- (void)draw {
    [self.mesh prepareToDraw];
    [self.mesh drawUnidexedWithMode:GL_TRIANGLES
                   startVertexIndex:0
                   numberOfVertices:self.numberOfVertics];
}

- (void)updateAlignedBoundingBoxForVertices:(float *)verts count:(unsigned int)aCount {
    SceneAxisAllignedBoundingBox result = {{0,0,0},{0,0,0}};
    
    const GLKVector3 *positions = (const GLKVector3 *)verts;
    
    if (aCount>0) {
        result.min.x = result.max.x = positions[0].x;
        result.min.y = result.max.y = positions[0].y;
        result.min.z = result.max.z = positions[0].z;
    }
    
    for (int i = 1; i<aCount; i++) {
        result.min.x = MIN(result.min.x, positions[i].x);
        result.min.y = MIN(result.min.y, positions[i].y);
        result.min.z = MIN(result.min.z, positions[i].z);
        
        result.max.x = MAX(result.max.x, positions[i].x);
        result.max.y = MAX(result.max.y, positions[i].y);
        result.max.z = MAX(result.max.z, positions[i].z);
    }
    
    self.axisAlignedBoundingBox = result;
}
@end
