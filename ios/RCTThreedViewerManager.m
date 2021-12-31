#import <React/RCTViewManager.h>
#import <SceneKit/SceneKit.h>
#import "RCTThreedViewer.h"

@import SceneKit.ModelIO;

@interface RCTThreedViewerManager : RCTViewManager
@end

@implementation RCTThreedViewerManager

RCT_EXPORT_MODULE(ThreedViewerView)

- (RCTThreedViewer *)view
{
    return [[RCTThreedViewer alloc] init];
}

RCT_EXPORT_VIEW_PROPERTY(allowsCameraControl, BOOL)

RCT_EXPORT_VIEW_PROPERTY(src, NSDictionary)

RCT_EXPORT_VIEW_PROPERTY(rotation, NSDictionaryArray)

RCT_EXPORT_VIEW_PROPERTY(scale, NSDictionary)

@end
