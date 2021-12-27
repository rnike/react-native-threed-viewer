#import <React/RCTViewManager.h>
#import <SceneKit/SceneKit.h>
#import "ThreedViewer.h"

@import SceneKit.ModelIO;

@interface ThreedViewerViewManager : RCTViewManager
@end

@implementation ThreedViewerViewManager

RCT_EXPORT_MODULE(ThreedViewerView)

- (ThreedViewer *)view
{
    return [[ThreedViewer alloc] init];
}

RCT_EXPORT_VIEW_PROPERTY(allowsCameraControl, BOOL)

RCT_EXPORT_VIEW_PROPERTY(src, NSDictionary)

@end
