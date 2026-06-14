//
//  DeepAdxCsjSplashAdapter.h
//

#import <DeepAdxAdspot/DeepAdxSplashDelegate.h>
#import <DeepAdxCore/DeepAdxBaseAdPosition.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeepAdxCsjSplashAdapter : DeepAdxBaseAdPosition
@property (nonatomic, weak) id<DeepAdxSplashDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
