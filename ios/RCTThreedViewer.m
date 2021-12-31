//
//  ThreedViewer.m
//  react-native-threed-viewer
//
//  Created by Mike on 2021/12/27.
//

#import "RCTThreedViewer.h"
#import "RCTThreedViewerUtils.h"

@import SceneKit.ModelIO;

@interface RCTThreedViewer()

@property (nonatomic, strong, nullable) NSMutableArray<NSDictionary*>* rotationData;
@property (nonatomic, strong, nullable) NSDictionary* scaleData;
@property (nonatomic, strong, nullable) SCNNode* modelNode;

@end

@implementation RCTThreedViewer

- (id) init {
    self = [super init];
    
    return self;
}

- (void)setSrc:(NSDictionary *)src{
    _modelNode = [RCTThreedViewerUtils.shared createModel:src[@"model"]
                                               textureUrl:src[@"texture"]];;
    [self reloadModel];
}

- (void)setRotation:(nullable NSMutableArray<NSDictionary*> *)value{
    _rotationData = value;
    
    [self reloadModel];
}

- (void)setScale:(nullable NSDictionary *)value{
    _scaleData = value;
    
    [self reloadModel];
}

- (void) reloadModel{
    for (SCNNode *child in self.scene.rootNode.childNodes) {
        [child removeFromParentNode];
    }
    
    self.scene = [[SCNScene alloc] init];
    
    if(!_modelNode){
        return;
    }
    
    SCNMatrix4 transform = [RCTThreedViewerUtils.shared createTransform:_scaleData rotationData:_rotationData];
    
    [_modelNode setTransform:transform];
    
    [self.scene.rootNode addChildNode: _modelNode];
}

@end
