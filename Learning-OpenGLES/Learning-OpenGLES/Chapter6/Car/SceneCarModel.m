//
//  SceneCarModel.m
//  Learning-OpenGLES
//
//  Created by 贾辰 on 2020/7/1.
//  Copyright © 2020 JJC. All rights reserved.
//

#import "SceneCarModel.h"
#import "SceneMesh.h"
#import "AGLKVertexAttribArrayBuffer.h"
#import "bumperCar.h"

@implementation SceneCarModel
- (instancetype)init {
    SceneMesh *carMesh = [[SceneMesh alloc] initWithPositionCoords:bumperCarVerts
                                                      normalCoords:bumperCarNormals
                                                        texCoords0:NULL
                                                 numberOfPositions:bumperCarNumVerts
                                                          indeices:NULL
                                                   numberOfIndices:0];
    
    self = [super initWithName:@"bumberCar"
                          mesh:carMesh
              numberOfVertices:bumperCarNumVerts];
    
    if (self) {
        [self updateAlignedBoundingBoxForVertices:bumperCarVerts
                                            count:bumperCarNumVerts];
    }
    return self;
}
@end
