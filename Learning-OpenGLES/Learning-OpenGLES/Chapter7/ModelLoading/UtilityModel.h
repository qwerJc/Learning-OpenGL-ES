//
//  UtilityModel.h
//  Learning-OpenGLES
//
//  Created by 贾辰 on 2020/7/6.
//  Copyright © 2020 JJC. All rights reserved.
//

#import <GLKit/GLKit.h>
@class UtilityMesh;

typedef struct
{
   GLKVector3 min;
   GLKVector3 max;
}AGLKAxisAllignedBoundingBox;

NS_ASSUME_NONNULL_BEGIN

@interface UtilityModel : NSObject
@property (copy, nonatomic) NSString *name;

- (instancetype)initWithName:(NSString *)name
                        mesh:(UtilityMesh *)mesh
         indexOfFirstCommand:(NSUInteger)indexFirst
            numberOfCommands:(NSUInteger)count
     axisAlignedBoundeingBox:(AGLKAxisAllignedBoundingBox)boundingBox;

- (instancetype)initWithPlistRepresentation:(NSDictionary *)dictionary
                                       mesh:(UtilityMesh *)mesh;
@end

NS_ASSUME_NONNULL_END
