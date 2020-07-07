//
//  UtilityModel.m
//  Learning-OpenGLES
//
//  Created by 贾辰 on 2020/7/6.
//  Copyright © 2020 JJC. All rights reserved.
//

#import "UtilityModel.h"
#import "UtilityMesh.h"

@interface UtilityModel()
@property (strong, nonatomic) UtilityMesh *mesh;

@property (assign, nonatomic) NSUInteger indexOfFirstCommand;
@property (assign, nonatomic) NSUInteger numberOfCommands;
@property (assign, nonatomic) AGLKAxisAllignedBoundingBox axisAlignedBoundingBox;
@end


@implementation UtilityModel
- (instancetype)initWithName:(NSString *)name
                        mesh:(UtilityMesh *)mesh
         indexOfFirstCommand:(NSUInteger)indexFirst
            numberOfCommands:(NSUInteger)count
     axisAlignedBoundeingBox:(AGLKAxisAllignedBoundingBox)boundingBox {
    
    self = [super init];
    if (self) {
        _mesh = mesh;
        _name = name;
        _indexOfFirstCommand = indexFirst;
        _numberOfCommands = count;
        _axisAlignedBoundingBox = boundingBox;
    }
    return self;
}

- (instancetype)initWithPlistRepresentation:(NSDictionary *)dictionary
                                       mesh:(UtilityMesh *)mesh {
    
    NSString *name = [dictionary objectForKey:@"name"];
    NSUInteger firstIndex = [[dictionary objectForKey:@"indexOfFirstCommand"] unsignedIntegerValue];
    NSUInteger number = [[dictionary objectForKey:@"numberOfCommands"] unsignedIntegerValue];
    AGLKAxisAllignedBoundingBox bounding = [self getAxisAllignedBoundingBoxFromString:[dictionary objectForKey:@"axisAlignedBoundingBox"]];
    
    return [self initWithName:name
                         mesh:mesh
          indexOfFirstCommand:firstIndex
             numberOfCommands:number
      axisAlignedBoundeingBox:bounding];
}

- (AGLKAxisAllignedBoundingBox)getAxisAllignedBoundingBoxFromString:(NSString *)string {
    string = [string stringByReplacingOccurrencesOfString:@"{" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"}" withString:@""];
    
    NSArray *coordsArray = [string componentsSeparatedByString:@","];
    
    AGLKAxisAllignedBoundingBox result;
    result.min.x = [coordsArray[0] floatValue];
    result.min.y = [coordsArray[1] floatValue];
    result.min.z = [coordsArray[2] floatValue];
    result.max.x = [coordsArray[3] floatValue];
    result.max.y = [coordsArray[4] floatValue];
    result.max.z = [coordsArray[5] floatValue];
    return result;
}
@end
