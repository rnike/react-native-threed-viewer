//
//  ThreedViewer.h
//  Pods
//
//  Created by Mike on 2021/12/27.
//
#import <SceneKit/SceneKit.h>

@interface RCTThreedViewer : SCNView

@property (nonatomic, strong, nullable) NSDictionary *src;
@property (nonatomic, strong, nullable) NSMutableArray<NSDictionary*> *rotation;
@property (nonatomic, strong, nullable) NSDictionary *scale;

@end
