//
//  ThreedViewer.h
//  Pods
//
//  Created by Jake on 2021/12/27.
//
#import <React/RCTViewManager.h>
#import <SceneKit/SceneKit.h>

@interface ThreedViewer : SCNView

@property (nonatomic, strong) NSDictionary *src;

@end
