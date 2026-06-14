//
//  DeepAdxGGNativeExpressAdapter.h
//

#import <DeepAdxCore/DeepAdxBaseAdPosition.h>
#import <DeepAdxAdspot/DeepAdxNativeExpressDelegate.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeepAdxGGNativeExpressAdapter : DeepAdxBaseAdPosition

@property (nonatomic, weak) id<DeepAdxNativeExpressDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
