//
//  SceneModel.h
//  Learning-OpenGLES
//
//  Created by 贾辰 on 2020/6/30.
//  Copyright © 2020 JJC. All rights reserved.
//

#import <GLKit/GLKit.h>

@class AGLKVertexAttribArrayBuffer;
@class SceneMesh;

NS_ASSUME_NONNULL_BEGIN

@interface SceneModel : NSObject
- (instancetype)initWithName:(NSString *)aName mesh:(SceneMesh *)aMesh numberOfVertices:(GLsizei)aCount;
   
- (void)draw;

- (void)updateAlignedBoundingBoxForVertices:(float *)verts count:(unsigned int)aCount;
@end

NS_ASSUME_NONNULL_END
