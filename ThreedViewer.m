//
//  ThreedViewer.m
//  react-native-threed-viewer
//
//  Created by Jake on 2021/12/27.
//

#import "ThreedViewer.h"

@import SceneKit.ModelIO;

@interface ThreedViewer()

@property (nonatomic, assign) SCNMatrix4 rotationMatrix;
@property (nonatomic, assign) SCNMatrix4 scaleMatrix;
@property (nonatomic, strong) SCNNode* modelNode;

@end

@implementation ThreedViewer

- (id) init {
    self = [super init];
    _rotationMatrix = SCNMatrix4Identity;
    _scaleMatrix = SCNMatrix4MakeScale(1,1,1);
    
    return self;
}

- (void)setSrc:(NSDictionary *)src{
    _modelNode = [self createModel:src[@"model"]
                        textureUrl:src[@"texture"]];;
    [self reloadModel];
}

- (void)setRotation:(nullable NSDictionary *)value{
    if(value){
        CGFloat x = [value[@"x"] floatValue] ?: 0;
        CGFloat y = [value[@"y"] floatValue] ?: -0;
        CGFloat z = [value[@"z"] floatValue] ?: 0;
        CGFloat a = [value[@"a"] floatValue] ?: 0;
        
        _rotationMatrix = SCNMatrix4MakeRotation(a, x, y, z);
    }else{
        _rotationMatrix = SCNMatrix4Identity;
    }
    
    [self reloadModel];
}

- (void)setScale:(nullable NSDictionary *)value{
    if(value){
        CGFloat x = [value[@"x"] floatValue] ?: 1;
        CGFloat y = [value[@"y"] floatValue] ?: 1;
        CGFloat z = [value[@"z"] floatValue] ?: 1;
        
        _scaleMatrix = SCNMatrix4MakeScale(x, y, z);
    }else{
        _scaleMatrix = SCNMatrix4MakeScale(1,1,1);
    }
    
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
    
    SCNMatrix4 applyRotation = SCNMatrix4Mult(SCNMatrix4Identity, _rotationMatrix);
    SCNMatrix4 applyScale = SCNMatrix4Mult(applyRotation, _scaleMatrix);
    
    [_modelNode setTransform:applyScale];
    
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
