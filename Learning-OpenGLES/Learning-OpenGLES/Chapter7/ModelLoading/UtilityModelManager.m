//
//  UtilityModelManager.m
//  Learning-OpenGLES
//
//  Created by 贾辰 on 2020/7/6.
//  Copyright © 2020 JJC. All rights reserved.
//

#import "UtilityModelManager.h"

#import "GLKTextureInfo+utilityAdditions.h"
#import "UtilityModel.h"
#import "UtilityMesh.h"

@interface UtilityModelManager()
@property (strong, nonatomic) GLKTextureInfo *textureInfo;
@property (strong, nonatomic) UtilityMesh *consolidatedMesh;
@property (strong, nonatomic) NSDictionary *modelsDictionary;
@end

@implementation UtilityModelManager
- (instancetype)initWithModelPath:(NSString *)path {
    self = [super init];
    if (self) {
        NSError *error = nil;
        NSData *data = [NSData dataWithContentsOfFile:path
                                              options:0
                                                error:&error];
        
        if (data) {
            [self readFromData:data
                        ofType:[path pathExtension]
                         error:&error];
        }
    }
    return self;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError {
    NSDictionary *document = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    _textureInfo = [GLKTextureInfo textureInfoFromUtilityPlistRepresentation:[document objectForKey:@"textureImageInfo"]];
    
    _consolidatedMesh = [[UtilityMesh alloc] initWithPlistRepresentation:[document objectForKey:@"mesh"]];
    
    _modelsDictionary = [self modelsFromPlistRepresentation:[document objectForKey:@"models"] mesh:_consolidatedMesh];
    
    return YES;
}

- (NSDictionary *)modelsFromPlistRepresentation:(NSDictionary *)plist mesh:(UtilityMesh *)mesh {
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    for (NSDictionary *dic in plist.allValues) {
        UtilityModel *model = [[UtilityModel alloc] initWithPlistRepresentation:dic mesh:mesh];
        [result setObject:model forKey:model.name];
    }
    
    return result;
}
#pragma mark - draw
- (void)prepareToDraw {
//    [self.consolidatedMesh prepareToDraw];
}
#pragma mark - Getter
- (UtilityModel *)modelWithName:(NSString *)name {
    return [self.modelsDictionary objectForKey:name];
}
@end
