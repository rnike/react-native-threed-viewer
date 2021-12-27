//
//  ThreedViewer.m
//  react-native-threed-viewer
//
//  Created by Jake on 2021/12/27.
//

#import "ThreedViewer.h"

@import SceneKit.ModelIO;

@interface ThreedViewer()

@property (nonatomic, strong) SCNNode* modelNode;

@end

@implementation ThreedViewer

- (id) init {
    self = [super init];
    
    return self;
}

- (void)setSrc:(NSDictionary *)src{
    _modelNode = [self createModel:src[@"model"]
                        textureUrl:src[@"texture"]];;
    [self reloadModel];
}

-(void) reloadModel{
    for (SCNNode *child in self.scene.rootNode.childNodes) {
        [child removeFromParentNode];
    }
    
    self.scene = [[SCNScene alloc] init];
    
    if(!_modelNode){
        return;
    }

    [self.scene.rootNode addChildNode: _modelNode];
}

-(SCNNode *)createModel:(nullable NSString*)modelUrl textureUrl:(nullable NSString*)textureUrl  {
    NSString *fileType = [modelUrl pathExtension];
    
    if([fileType isEqual: @"obj"]) {
        return [self createObj:modelUrl textureUrl:textureUrl];
    }
    
    return nil;
}

-(SCNNode *)createObj:(NSString *)modelUrl textureUrl:(NSString *)textureUrl {
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

@end
