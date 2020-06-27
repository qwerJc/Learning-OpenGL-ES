////
////  AGLKTextureLoader.m
////  Learning-OpenGLES
////
////  Created by 贾辰 on 2020/6/26.
////  Copyright © 2020 JJC. All rights reserved.
////
//
//#import "AGLKTextureLoader.h"
//#import <GLKit/GLKit.h>
//
//#pragma mark - AGLKTextureInfo
//@implementation AGLKTextureInfo
//- (instancetype)initWithName:(GLuint)aName
//            target:(GLenum)aTarget
//             width:(size_t)aWidth
//            height:(size_t)aHeight {
//    self = [super init];
//    if (self) {
//        _name = aName;
//        _target = aTarget;
//        _width = aWidth;
//        _height = aHeight;
//    }
//    return self;
//}
//@end
//
//#pragma mark - Static Method
//typedef enum
//{
//   AGLK1 = 1,
//   AGLK2 = 2,
//   AGLK4 = 4,
//   AGLK8 = 8,
//   AGLK16 = 16,
//   AGLK32 = 32,
//   AGLK64 = 64,
//   AGLK128 = 128,
//   AGLK256 = 256,
//   AGLK512 = 512,
//   AGLK1024 = 1024,
//}
//AGLKPowerOf2;
//
//static AGLKPowerOf2 AGLKCalculatePowerOf2ForDimension(
//   GLuint dimension)
//{
//   AGLKPowerOf2  result = AGLK1;
//
//   if(dimension > (GLuint)AGLK512)
//   {
//      result = AGLK1024;
//   }
//   else if(dimension > (GLuint)AGLK256)
//   {
//      result = AGLK512;
//   }
//   else if(dimension > (GLuint)AGLK128)
//   {
//      result = AGLK256;
//   }
//   else if(dimension > (GLuint)AGLK64)
//   {
//      result = AGLK128;
//   }
//   else if(dimension > (GLuint)AGLK32)
//   {
//      result = AGLK64;
//   }
//   else if(dimension > (GLuint)AGLK16)
//   {
//      result = AGLK32;
//   }
//   else if(dimension > (GLuint)AGLK8)
//   {
//      result = AGLK16;
//   }
//   else if(dimension > (GLuint)AGLK4)
//   {
//      result = AGLK8;
//   }
//   else if(dimension > (GLuint)AGLK2)
//   {
//      result = AGLK4;
//   }
//   else if(dimension > (GLuint)AGLK1)
//   {
//      result = AGLK2;
//   }
//
//   return result;
//}
//
///** 获取用于初始化纹理缓存所需要的 字节 */
//static NSData *AGLKDataWithResizedCGImageBytes(
//                                               CGImageRef cgImage,
//                                               size_t *widhtPtr,
//                                               size_t *heightPtr)
//{
//    NSCParameterAssert(cgImage!=NULL);
//    NSCParameterAssert(widhtPtr!=NULL);
//    NSCParameterAssert(heightPtr!=NULL);
//
//    size_t originalWidth = CGImageGetWidth(cgImage);
//    size_t originalHeight = CGImageGetWidth(cgImage);
//
//    NSCAssert(originalWidth>0, @"无效的图片宽度");
//    NSCAssert(originalHeight>0, @"无效的图片高度");
//
//    size_t width = AGLKCalculatePowerOf2ForDimension(originalWidth);
//    size_t height = AGLKCalculatePowerOf2ForDimension(originalHeight);
//
//    NSMutableData *imageData = [NSMutableData dataWithLength:height*width*4];
//
//    // 这里通过CoreGraphics将cgImage拖至imageData中
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGContextRef cgContext = CGBitmapContextCreate([imageData mutableBytes],
//                                                   width,
//                                                   height,
//                                                   0,
//                                                   4*width,
//                                                   colorSpace,
//                                                   kCGImageAlphaPremultipliedLast);
//    CGColorSpaceRelease(colorSpace);
//
//    /**这里实现翻转Y轴（因为OpenGLES的方向和iOS不同）*/
//    // 上移height
//    CGContextTranslateCTM(cgContext, 0, height);
////    // 上下翻转
//    CGContextScaleCTM(cgContext, 1.f, -1.f);
//
//    CGContextDrawImage(cgContext, CGRectMake(0, 0, width, height), cgImage);
//    CGContextRelease(cgContext);
//
//    *widhtPtr = width;
//    *heightPtr = height;
//    return imageData;
//}
//
//#pragma mark - AGLKTextureLoader
//@implementation AGLKTextureLoader
//
//+(AGLKTextureInfo *)textureWithCGImage:(CGImageRef)cgImage
//                               options:(nullable NSDictionary<NSString *,NSNumber *> *)options
//                                 error:(NSError * _Nullable __autoreleasing * _Nullable)outError {
//    size_t width;
//    size_t height;
//    NSData *imgData = AGLKDataWithResizedCGImageBytes(cgImage, &width, &height);
//
//    GLuint textureBufferID;
//
//    // step 1
//    // 类似于 glGenBuffers：设定需要绑定的缓存标识符数量
//    glGenTextures(1, &textureBufferID);
//
//    // step 2
//    // 绑定 用于指定标识符的缓存 到 当前缓存
//    glBindTexture(GL_TEXTURE_2D, textureBufferID);
//
//    // step 3
//    // 复制图片像素颜色数据至绑定的纹理缓存中
//    glTexImage2D(GL_TEXTURE_2D,     // 指定纹理类型
//                 0,                 // 指定MIP贴图的初始细节级别（如果没有使用MIP贴图，则必须为0）
//                 GL_RGBA,           // 指定在纹理缓存中每个纹素需要保存的信息（GL_RGB/GL_RGBA）
//                 width,             // 图像宽度
//                 height,            // 图像高度
//                 0,                 // 通常为0，用来确定围绕纹理的纹素的边界大小
//                 GL_RGBA,           // 指定初始化缓存中的每个像素要保存的信息（这个值应当同上方第三个参相同数）
//                 GL_UNSIGNED_BYTE,  // 指定缓存中纹素数据使用的编码类型
//                 [imgData bytes]);  // 要被复制到绑定的纹理缓存中的图片的像素颜色数据指针
//    // 关于编码类型
//        // GL_UNSIGNED_BYTE : 提供最佳的色彩质量，但是每个纹素的颜色值保存都需要1字节，这样RGBA为4字节（32位）
//        // GL_UNSIGNED_SHORT_5_6_5 : 5位用于红色，6位勇于绿色，5位勇于蓝色，没有透明度部分
//        // GL_UNSIGNED_SHORT_4_4_4_4 : 平均为每个纹素的颜色元素使用4位
//
//    AGLKTextureInfo *result = [[AGLKTextureInfo alloc] initWithName:textureBufferID
//                                                             target:GL_TEXTURE_2D
//                                                              width:width
//                                                             height:height];
//    return result;
//}
//@end

//
//  AGLKTextureLoader.m
//  OpenGLES_Ch3_2
//

#import "AGLKTextureLoader.h"

/////////////////////////////////////////////////////////////////
// This data type is used specify power of 2 values.  OpenGL ES
// best supports texture images that have power of 2 dimensions.
typedef enum
{
   AGLK1 = 1,
   AGLK2 = 2,
   AGLK4 = 4,
   AGLK8 = 8,
   AGLK16 = 16,
   AGLK32 = 32,
   AGLK64 = 64,
   AGLK128 = 128,
   AGLK256 = 256,
   AGLK512 = 512,
   AGLK1024 = 1024,
}
AGLKPowerOf2;


/////////////////////////////////////////////////////////////////
// Forward declaration of function
static AGLKPowerOf2 AGLKCalculatePowerOf2ForDimension(
   GLuint dimension);

/////////////////////////////////////////////////////////////////
// Forward declaration of function
static NSData *AGLKDataWithResizedCGImageBytes(
   CGImageRef cgImage,
   size_t *widthPtr,
   size_t *heightPtr);
                              
/////////////////////////////////////////////////////////////////
// Instances of AGLKTextureInfo are immutable once initialized
@interface AGLKTextureInfo (AGLKTextureLoader)

- (id)initWithName:(GLuint)aName
   target:(GLenum)aTarget
   width:(size_t)aWidth
   height:(size_t)aHeight;
   
@end


@implementation AGLKTextureInfo (AGLKTextureLoader)

/////////////////////////////////////////////////////////////////
// This method is the designated initializer.
- (id)initWithName:(GLuint)aName
   target:(GLenum)aTarget
   width:(size_t)aWidth
   height:(size_t)aHeight
{
    if (nil != (self = [super init]))
    {
        name = aName;
        target = aTarget;
        width = aWidth;
        height = aHeight;
    }
    
    return self;
}

@end


@implementation AGLKTextureInfo

@synthesize name;
@synthesize target;
@synthesize width;
@synthesize height;

@end


@implementation AGLKTextureLoader

/////////////////////////////////////////////////////////////////
// This method generates a new OpenGL ES texture buffer and
// initializes the buffer contents using pixel data from the
// specified Core Graphics image, cgImage. This method returns an
// immutable AGLKTextureInfo instance initialized with
// information about the newly generated texture buffer.
//    The generated texture buffer has power of 2 dimensions. The
// provided image data is scaled (re-sampled) by Core Graphics as
// necessary to fit within the generated texture buffer.
+ (AGLKTextureInfo *)textureWithCGImage:(CGImageRef)cgImage                           options:(NSDictionary *)options
   error:(NSError **)outError;
{
   // Get the bytes to be used when copying data into new texture
   // buffer
   size_t width;
   size_t height;
   NSData *imageData = AGLKDataWithResizedCGImageBytes(
      cgImage,
      &width,
      &height);
   
   // Generation, bind, and copy data into a new texture buffer
   GLuint      textureBufferID;
   
   glGenTextures(1, &textureBufferID);                  // Step 1
   glBindTexture(GL_TEXTURE_2D, textureBufferID);       // Step 2
   
   glTexImage2D(                                        // Step 3
      GL_TEXTURE_2D,
      0,
      GL_RGBA,
      width,
      height,
      0,
      GL_RGBA,
      GL_UNSIGNED_BYTE,
      [imageData bytes]);
   
   // Set parameters that control texture sampling for the bound
   // texture
  glTexParameteri(GL_TEXTURE_2D,
     GL_TEXTURE_MIN_FILTER,
     GL_LINEAR);
   
   // Allocate and initialize the AGLKTextureInfo instance to be
   // returned
   AGLKTextureInfo *result = [[AGLKTextureInfo alloc]
      initWithName:textureBufferID
      target:GL_TEXTURE_2D
      width:width
      height:height];
   
   return result;
}
                                 
@end


/////////////////////////////////////////////////////////////////
// This function returns an NSData object that contains bytes
// loaded from the specified Core Graphics image, cgImage. This
// function also returns (by reference) the power of 2 width and
// height to be used when initializing an OpenGL ES texture buffer
// with the bytes in the returned NSData instance. The widthPtr
// and heightPtr arguments must be valid pointers.
static NSData *AGLKDataWithResizedCGImageBytes(
   CGImageRef cgImage,
   size_t *widthPtr,
   size_t *heightPtr)
{
   NSCParameterAssert(NULL != cgImage);
   NSCParameterAssert(NULL != widthPtr);
   NSCParameterAssert(NULL != heightPtr);
   
   size_t originalWidth = CGImageGetWidth(cgImage);
   size_t originalHeight = CGImageGetWidth(cgImage);
   
   NSCAssert(0 < originalWidth, @"Invalid image width");
   NSCAssert(0 < originalHeight, @"Invalid image width");
   
   // Calculate the width and height of the new texture buffer
   // The new texture buffer will have power of 2 dimensions.
   size_t width = AGLKCalculatePowerOf2ForDimension(
      originalWidth);
   size_t height = AGLKCalculatePowerOf2ForDimension(
      originalHeight);
      
   // Allocate sufficient storage for RGBA pixel color data with
   // the power of 2 sizes specified
   NSMutableData    *imageData = [NSMutableData dataWithLength:
      height * width * 4];  // 4 bytes per RGBA pixel

   NSCAssert(nil != imageData,
      @"Unable to allocate image storage");
   
   // Create a Core Graphics context that draws into the
   // allocated bytes
   CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
   CGContextRef cgContext = CGBitmapContextCreate(
      [imageData mutableBytes], width, height, 8,
      4 * width, colorSpace,
      kCGImageAlphaPremultipliedLast);
   CGColorSpaceRelease(colorSpace);
   
   // Flip the Core Graphics Y-axis for future drawing
   CGContextTranslateCTM (cgContext, 0, height);
   CGContextScaleCTM (cgContext, 1.0, -1.0);
   
   // Draw the loaded image into the Core Graphics context
   // resizing as necessary
   CGContextDrawImage(cgContext, CGRectMake(0, 0, width, height),
      cgImage);
   
   CGContextRelease(cgContext);
   
   *widthPtr = width;
   *heightPtr = height;
   
   return imageData;
}


/////////////////////////////////////////////////////////////////
// This function calculates and returns the nearest power of 2
// that is greater than or equal to the dimension argument and
// less than or equal to 1024.
static AGLKPowerOf2 AGLKCalculatePowerOf2ForDimension(
   GLuint dimension)
{
   AGLKPowerOf2  result = AGLK1;
   
   if(dimension > (GLuint)AGLK512)
   {
      result = AGLK1024;
   }
   else if(dimension > (GLuint)AGLK256)
   {
      result = AGLK512;
   }
   else if(dimension > (GLuint)AGLK128)
   {
      result = AGLK256;
   }
   else if(dimension > (GLuint)AGLK64)
   {
      result = AGLK128;
   }
   else if(dimension > (GLuint)AGLK32)
   {
      result = AGLK64;
   }
   else if(dimension > (GLuint)AGLK16)
   {
      result = AGLK32;
   }
   else if(dimension > (GLuint)AGLK8)
   {
      result = AGLK16;
   }
   else if(dimension > (GLuint)AGLK4)
   {
      result = AGLK8;
   }
   else if(dimension > (GLuint)AGLK2)
   {
      result = AGLK4;
   }
   else if(dimension > (GLuint)AGLK1)
   {
      result = AGLK2;
   }
   
   return result;
}
