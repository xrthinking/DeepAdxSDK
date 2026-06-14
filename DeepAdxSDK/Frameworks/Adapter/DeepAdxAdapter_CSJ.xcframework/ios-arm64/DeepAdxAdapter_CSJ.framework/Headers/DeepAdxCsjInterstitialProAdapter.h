//
//  DeepAdxCsjInterstitialProAdapter.h
//

#import <DeepAdxAdspot/DeepAdxInterstitialDelegate.h>
#import <DeepAdxCore/DeepAdxBaseAdPosition.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeepAdxCsjInterstitialProAdapter : DeepAdxBaseAdPosition
@property (nonatomic, weak) id<DeepAdxInterstitialDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
