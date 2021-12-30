//
//  RCTThreedViewerUtils.h
//  Pods
//
//  Created by Mike on 2021/12/31.
//

#import <SceneKit/SceneKit.h>

@import SceneKit.ModelIO;

@interface RCTThreedViewerUtils : NSObject

+ (instancetype)shared;

- (SCNMatrix4)parseRotation:(nullable NSDictionary*)value;

- (SCNMatrix4)parseScale:(nullable NSDictionary*)value;

- (SCNNode *)createModel:(nullable NSString*)modelUrl textureUrl:(nullable NSString*)textureUrl;

- (SCNNode *)createObj:(NSString *)modelUrl textureUrl:(NSString *)textureUrl;

- (SCNMatrix4)createTransform:(nullable NSDictionary*)scaleData rotationData:(nullable NSDictionary*)rotationData;

@end
