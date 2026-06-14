//
//  DeepAdxGdtBannerAdapter.h
//

#if __has_include(<DeepAdxAdspot/DeepAdxBannerDelegate.h>)
#import <DeepAdxAdspot/DeepAdxBannerDelegate.h>
#import <DeepAdxCore/DeepAdxBaseAdPosition.h>
#else
#import "DeepAdxBannerDelegate.h"
#import "DeepAdxBaseAdPosition.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface DeepAdxGdtBannerAdapter : DeepAdxBaseAdPosition

@property (nonatomic, weak) id<DeepAdxBannerDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
