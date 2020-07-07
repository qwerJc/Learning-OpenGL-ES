//
//  GLKTextureInfo+utilityAdditions.h
//  Learning-OpenGLES
//
//  Created by 贾辰 on 2020/7/6.
//  Copyright © 2020 JJC. All rights reserved.
//

#import <GLKit/GLKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GLKTextureInfo (utilityAdditions)
+ (GLKTextureInfo*)textureInfoFromUtilityPlistRepresentation:(NSDictionary *)dictionary;
@end

NS_ASSUME_NONNULL_END
