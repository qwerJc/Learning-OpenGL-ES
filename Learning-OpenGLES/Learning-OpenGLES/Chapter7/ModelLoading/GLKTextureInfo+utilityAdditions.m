//
//  GLKTextureInfo+utilityAdditions.m
//  Learning-OpenGLES
//
//  Created by 贾辰 on 2020/7/6.
//  Copyright © 2020 JJC. All rights reserved.
//

#import "GLKTextureInfo+utilityAdditions.h"

@implementation GLKTextureInfo (utilityAdditions)
+ (GLKTextureInfo *)textureInfoFromUtilityPlistRepresentation:(NSDictionary *)dictionary {
    GLKTextureInfo *result = nil;
    
    const size_t imageWidth = (size_t)[[dictionary objectForKey:@"width"] unsignedIntegerValue];
    const size_t imageHeight = (size_t)[[dictionary objectForKey:@"height"] unsignedIntegerValue];
    
    UIImage *image = [UIImage imageWithData:[dictionary objectForKey:@"imageData"]];
    
    if (image && imageWidth!=0 && imageHeight!=0 ) {
        NSError *error;
        result = [GLKTextureLoader textureWithCGImage:[image CGImage]
                                              options:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [NSNumber numberWithBool:YES],
                                                       GLKTextureLoaderGenerateMipmaps,
                                                       [NSNumber numberWithBool:NO],
                                                       GLKTextureLoaderOriginBottomLeft,
                                                       [NSNumber numberWithBool:NO],
                                                       GLKTextureLoaderApplyPremultiplication, nil]
                                                error:&error];
    }
    
    if (result) {
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST_MIPMAP_LINEAR);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
    }
    
    return result;
}
@end
