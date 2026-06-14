//
//  DeepAdxSplashProtocol.h
//

#ifndef DeepAdxSplashProtocol_h
#define DeepAdxSplashProtocol_h

#import <DeepAdxAdspot/DeepAdxBaseDelegate.h>

@protocol DeepAdxSplashDelegate <DeepAdxBaseDelegate>

@optional
/// 广告点击跳过
- (void)ad_splashOnAdSkipClicked;
/// 广告倒计时结束回调
- (void)ad_splashOnAdCountdownToZero;

@end

#endif 
