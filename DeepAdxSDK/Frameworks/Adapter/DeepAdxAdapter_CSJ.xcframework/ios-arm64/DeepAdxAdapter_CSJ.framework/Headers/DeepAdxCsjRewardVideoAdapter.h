//
//  DeepAdxCsjRewardVideoAdapter.h
//

#import <DeepAdxAdspot/DeepAdxRewardVideoDelegate.h>
#import <DeepAdxCore/DeepAdxBaseAdPosition.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeepAdxCsjRewardVideoAdapter : DeepAdxBaseAdPosition
@property (nonatomic, weak) id<DeepAdxRewardVideoDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
