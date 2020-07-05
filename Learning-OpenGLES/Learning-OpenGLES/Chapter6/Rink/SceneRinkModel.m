//
//  SceneRinkModel.m
//  Learning-OpenGLES
//
//  Created by 贾辰 on 2020/7/2.
//  Copyright © 2020 JJC. All rights reserved.
//

#import "SceneRinkModel.h"
#import "SceneMesh.h"
#import "bumperRink.h"

@implementation SceneRinkModel
- (instancetype)init {
    SceneMesh *rinkMesh = [[SceneMesh alloc] initWithPositionCoords:bumperRinkVerts
                                                       normalCoords:bumperRinkNormals
                                                         texCoords0:NULL
                                                  numberOfPositions:bumperRinkNumVerts
                                                            indices:NULL
                                                    numberOfIndices:0];

    self = [super initWithName:@"BumberRink"
                          mesh:rinkMesh
              numberOfVertices:bumperRinkNumVerts];
    if (self) {
        [self updateAlignedBoundingBoxForVertices:bumperRinkVerts
                                            count:bumperRinkNumVerts];
    }
    return self;
}
@end
