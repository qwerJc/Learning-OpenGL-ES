////
////  AGLKTextureLoader.h
////  Learning-OpenGLES
////
////  Created by 贾辰 on 2020/6/26.
////  Copyright © 2020 JJC. All rights reserved.
////
//
//#import <Foundation/Foundation.h>
//#import <GLKit/GLKit.h>
//
//NS_ASSUME_NONNULL_BEGIN
//
//#pragma mark - AGLKTextureInfo
//// 封装了纹理缓存的信息
//@interface AGLKTextureInfo : NSObject
//@property (assign, nonatomic, readonly) GLuint name;
//@property (assign, nonatomic, readonly) GLenum target;
//@property (assign, nonatomic, readonly) GLuint width;
//@property (assign, nonatomic, readonly) GLuint height;
//- (instancetype)initWithName:(GLuint)aName
//                      target:(GLenum)aTarget
//                       width:(size_t)aWidth
//                      height:(size_t)aHeight;
//@end
//
//#pragma mark - AGLKTextureLoader
//@interface AGLKTextureLoader : NSObject
//+(AGLKTextureInfo *)textureWithCGImage:(CGImageRef)cgImage
//                               options:(nullable NSDictionary<NSString *,NSNumber *> *)options
//                                 error:(NSError * _Nullable __autoreleasing * _Nullable)outError;
//@end
//
//NS_ASSUME_NONNULL_END

//
//  AGLKTextureLoader.h
//  OpenGLES_Ch3_2
//

#import <GLKit/GLKit.h>

#pragma mark -AGLKTextureInfo

@interface AGLKTextureInfo : NSObject
{
@private
   GLuint name;
   GLenum target;
   GLuint width;
   GLuint height;
}

@property (readonly) GLuint name;
@property (readonly) GLenum target;
@property (readonly) GLuint width;
@property (readonly) GLuint height;

@end


#pragma mark -AGLKTextureLoader

@interface AGLKTextureLoader : NSObject

+ (AGLKTextureInfo *)textureWithCGImage:(CGImageRef)cgImage                                                         options:(NSDictionary *)options
   error:(NSError **)outError;
   
@end
