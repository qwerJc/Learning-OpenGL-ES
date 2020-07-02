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

typedef struct {
   GLKVector3 min;
   GLKVector3 max;
}SceneAxisAllignedBoundingBox;

NS_ASSUME_NONNULL_BEGIN

@interface SceneModel : NSObject
@property (copy, nonatomic, readonly) NSString *name;
@property (assign, nonatomic, readonly) SceneAxisAllignedBoundingBox axisAlignedBoundingBox;

- (instancetype)initWithName:(NSString *)aName mesh:(SceneMesh *)aMesh numberOfVertices:(GLsizei)aCount;
   
- (void)draw;

- (void)updateAlignedBoundingBoxForVertices:(float *)verts count:(unsigned int)aCount;
@end

NS_ASSUME_NONNULL_END
