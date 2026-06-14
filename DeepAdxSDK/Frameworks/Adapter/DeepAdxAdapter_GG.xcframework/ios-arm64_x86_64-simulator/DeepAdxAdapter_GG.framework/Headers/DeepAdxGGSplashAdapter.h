//
//  DeepAdxGGSplashAdapter.h
//

#if __has_include(<DeepAdxAdspot/DeepAdxSplashDelegate.h>)
#import <DeepAdxAdspot/DeepAdxSplashDelegate.h>
#import <DeepAdxCore/DeepAdxBaseAdPosition.h>
#else
#import "DeepAdxSplashDelegate.h"
#import "DeepAdxBaseAdPosition.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface DeepAdxGGSplashAdapter : DeepAdxBaseAdPosition

@property (nonatomic, weak) id<DeepAdxSplashDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
