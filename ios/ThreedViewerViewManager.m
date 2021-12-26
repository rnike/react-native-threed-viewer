#import <React/RCTViewManager.h>
#import <SceneKit/SceneKit.h>

@import SceneKit.ModelIO;

@interface ThreedViewerViewManager : RCTViewManager
@end

@implementation ThreedViewerViewManager

RCT_EXPORT_MODULE(ThreedViewerView)

- (SCNView *)view
{
    SCNView *view = [[SCNView alloc] init];
    
    view.scene = [[SCNScene alloc] init];
    
    return view;
}

RCT_CUSTOM_VIEW_PROPERTY(allowsCameraControl, NSBoolean, SCNView){
    view.allowsCameraControl = json;
}

RCT_CUSTOM_VIEW_PROPERTY(src, NSString, SCNView)
{
    for (SCNNode *child in view.scene.rootNode.childNodes) {
        [child removeFromParentNode];
    }
    
    [view.scene.rootNode addChildNode:  [self createModel:json[@"model"]
                                               textureUrl:json[@"texture"]]];
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
