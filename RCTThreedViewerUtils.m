//
//  RCTThreedViewerUtils.m
//  react-native-threed-viewer
//
//  Created by Mike on 2021/12/31.
//

#import "RCTThreedViewerUtils.h"

@implementation RCTThreedViewerUtils

+ (instancetype)shared {
    static RCTThreedViewerUtils *instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });

    return instance;
}

- (instancetype)init {
    self = [super init];

    return self;
}

- (SCNNode *)createModel:(nullable NSString*)modelUrl textureUrl:(nullable NSString*)textureUrl {
    NSString *fileType = [modelUrl pathExtension];
    
    if([fileType isEqual: @"obj"]) {
        return [self createObj:modelUrl textureUrl:textureUrl];
    }
    
    return nil;
}

- (SCNNode *)createObj:(NSString *)modelUrl textureUrl:(NSString *)textureUrl {
    MDLAsset *asset = [[MDLAsset alloc] initWithURL:[NSURL URLWithString:modelUrl]];
    
    if (asset.count == 0) {
        return nil;
    }
    
    MDLMesh* object = (MDLMesh *)[asset objectAtIndex:0];
    SCNNode *node = [SCNNode nodeWithMDLObject:object];
    
    if (textureUrl) {
        NSData *textureData = [[NSFileManager defaultManager] contentsAtPath:textureUrl];
        SCNMaterial *material = [SCNMaterial new];
        
        [material setDoubleSided:NO];
        material.locksAmbientWithDiffuse = YES;
        material.diffuse.contents = [UIImage imageWithData:textureData];
        material.ambient.contents = [UIColor whiteColor];
        
        node.geometry.materials = [NSArray arrayWithObject:material];
    }
    
    return node;
}

- (SCNMatrix4)parseRotation:(nullable NSDictionary*)value {
    SCNMatrix4 result;
    
    if(value){
        CGFloat x = [value[@"x"] floatValue] ?: 0;
        CGFloat y = [value[@"y"] floatValue] ?: -0;
        CGFloat z = [value[@"z"] floatValue] ?: 0;
        CGFloat a = [value[@"a"] floatValue] ?: 0;
        
        result = SCNMatrix4MakeRotation(a, x, y, z);
    }else{
        result = SCNMatrix4Identity;
    }
    
    return result;
}

- (SCNMatrix4)parseScale:(nullable NSDictionary*)value {
    SCNMatrix4 result;
    
    if(value){
        CGFloat x = [value[@"x"] floatValue] ?: 1;
        CGFloat y = [value[@"y"] floatValue] ?: 1;
        CGFloat z = [value[@"z"] floatValue] ?: 1;
        
        result = SCNMatrix4MakeScale(x, y, z);
    }else{
        result = SCNMatrix4MakeScale(1,1,1);
    }
    
    return result;
}

- (SCNMatrix4)createTransform:(nullable NSDictionary*)scaleData
                 rotationData:(nullable NSMutableArray<NSDictionary*>*)rotationData {
    SCNMatrix4 result = SCNMatrix4Identity;
    
    result = SCNMatrix4Mult(result, [self parseScale:scaleData]);
    
    for (NSDictionary *data in rotationData) {
        result = SCNMatrix4Mult(result, [self parseRotation:data]);
    }
    
    return result;
}


@end
