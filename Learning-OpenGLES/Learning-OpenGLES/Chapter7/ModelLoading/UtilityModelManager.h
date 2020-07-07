//
//  UtilityModelManager.h
//  Learning-OpenGLES
//
//  Created by 贾辰 on 2020/7/6.
//  Copyright © 2020 JJC. All rights reserved.
//

#import <GLKit/GLKit.h>

@class UtilityModel;

NS_ASSUME_NONNULL_BEGIN

@interface UtilityModelManager : NSObject

- (instancetype)initWithModelPath:(NSString *)path;

- (BOOL)readFromData:(NSDate *)data ofType:(NSString *)typeName error:(NSError **)outError;

#pragma mark -
- (void)prepareToDraw;
- (void)prepareToPick;

#pragma mark - Getter
- (UtilityModel *)modelWithName:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
