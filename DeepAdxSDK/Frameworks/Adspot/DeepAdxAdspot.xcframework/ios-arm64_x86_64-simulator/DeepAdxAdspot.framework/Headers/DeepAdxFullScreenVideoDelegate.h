//
//  DeepAdxFullScreenVideoDelegate.h
//

#ifndef DeepAdxFullScreenVideoDelegate_h
#define DeepAdxFullScreenVideoDelegate_h

#import <DeepAdxAdspot/DeepAdxBaseDelegate.h>

@protocol DeepAdxFullScreenVideoDelegate <DeepAdxBaseDelegate>
@optional
/// 视频播放完成
- (void)ad_FullScreenVideoOnAdPlayFinish;

@end

#endif
