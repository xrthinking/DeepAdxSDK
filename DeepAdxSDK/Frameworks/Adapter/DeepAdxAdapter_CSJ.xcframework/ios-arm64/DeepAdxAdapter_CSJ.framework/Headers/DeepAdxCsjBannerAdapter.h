//
//  DeepAdxCsjBannerAdapter.h
//

#import <DeepAdxAdspot/DeepAdxBannerDelegate.h>
#import <DeepAdxCore/DeepAdxBaseAdPosition.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeepAdxCsjBannerAdapter : DeepAdxBaseAdPosition

@property (nonatomic, weak) id<DeepAdxBannerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
