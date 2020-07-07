//
//  UtilityMesh.m
//  Learning-OpenGLES
//
//  Created by 贾辰 on 2020/7/6.
//  Copyright © 2020 JJC. All rights reserved.
//

#import "UtilityMesh.h"

@interface UtilityMesh()
@property (strong, nonatomic) NSMutableData *mutableVertexData;
@property (strong, nonatomic) NSMutableData *mutableIndexData;

@property (strong, nonatomic) NSArray       *arrCommands;

@property (assign, nonatomic) GLuint        indexBufferID;
@property (assign, nonatomic) GLuint        vertexBufferID;
@property (assign, nonatomic) GLuint        vertexArrayID;

@property (assign, nonatomic) BOOL shouldUseVAOExtension;
@end

@implementation UtilityMesh
- (instancetype)initWithPlistRepresentation:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _mutableVertexData = [[NSMutableData alloc] init];
        _mutableIndexData = [[NSMutableData alloc] init];
        _arrCommands = [NSArray array];
        _shouldUseVAOExtension = YES;
        
        [_mutableVertexData appendData:[dictionary objectForKey:@"vertexAttributeData"]];
        [_mutableIndexData appendData:[dictionary objectForKey:@"indexData"]];
        _arrCommands = [dictionary objectForKey:@"commands"];
    }
    return self;
}

@end
