//
//  DeepAdxRewardVideoProtocol.h
//

#ifndef DeepAdxRewardVideoProtocol_h
#define DeepAdxRewardVideoProtocol_h

#import <DeepAdxAdspot/DeepAdxBaseDelegate.h>

@protocol DeepAdxRewardVideoDelegate <DeepAdxBaseDelegate>
@optional

/// 广告视频缓存完成
- (void)ad_rewardVideoOnAdVideoCached;

/// 广告视频播放完成
- (void)ad_rewardVideoAdDidPlayFinish;

/// 广告到达激励时间
- (void)ad_rewardVideoAdDidRewardEffective;

@end

#endif
