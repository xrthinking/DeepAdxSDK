//
//  DeepAdxGdtRewardVideoAdapter.h
//

#if __has_include(<DeepAdxAdspot/DeepAdxRewardVideoDelegate.h>)
#import <DeepAdxAdspot/DeepAdxRewardVideoDelegate.h>
#import <DeepAdxCore/DeepAdxBaseAdPosition.h>
#else
#import "DeepAdxRewardVideoDelegate.h"
#import "DeepAdxBaseAdPosition.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface DeepAdxGdtRewardVideoAdapter : DeepAdxBaseAdPosition
@property (nonatomic, weak) id<DeepAdxRewardVideoDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
