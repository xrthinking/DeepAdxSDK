//
//  DeepAdxRewardVideo.h
//  

#if __has_include(<DeepAdxCore/DeepAdxBaseAdapter.h>)
#import <DeepAdxCore/DeepAdxBaseAdapter.h>
#import <DeepAdxCore/DeepAdxRewardServerParams.h>
#import <DeepAdxAdspot/DeepAdxRewardVideoDelegate.h>
#else
#import "DeepAdxBaseAdapter.h"
#import "DeepAdxRewardServerParams.h"
#import "DeepAdxRewardVideoDelegate.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface DeepAdxRewardVideo : DeepAdxBaseAdapter
/// 广告方法回调代理
@property (nonatomic, weak) id<DeepAdxRewardVideoDelegate> delegate;

/// 激励视频服务端参数；渠道适配器会读取并在广告返回后写回 rewardName / rewardAmount（若 SDK 提供）。
/// 首次读取时若为空会自动创建实例，可直接 `rewardServerParams.userId = ...`；置为 nil 可丢弃后再读会重新创建。
@property (nonatomic, strong, nullable) DeepAdxRewardServerParams *rewardServerParams;

- (instancetype)initWithViewController:(nonnull UIViewController *)viewController;
/// 指定 DeepAdx 广告位 ID（后台广告单元 ID）
- (instancetype)initWithViewController:(nonnull UIViewController *)viewController
                          placementId:(nonnull NSString *)placementId;
#ifdef DEBUG
/// 仅限于debug模式下使用
- (instancetype)initWithJsonDic:(NSDictionary *)jsonDic
                 viewController:(nonnull UIViewController *)viewController;
#endif
@end

NS_ASSUME_NONNULL_END
