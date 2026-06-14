//
//  DeepAdxRewardServerParams.h
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 激励视频服务端 / 透传参数（各渠道映射到各自 SDK 的奖励模型）。
@interface DeepAdxRewardServerParams : NSObject

@property (nonatomic, copy, nullable) NSString *userId;

/// optional. serialized string.
@property (nonatomic, copy, nullable) NSString *extra;

/// reward name. It will assigned value when the ads back.
@property (nonatomic, copy, nullable) NSString *rewardName;

/// number of rewards. It will assigned value when the ads back.
@property (nonatomic, assign) NSInteger rewardAmount;

@end

NS_ASSUME_NONNULL_END
