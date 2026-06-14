//
//  DeepAdxNativeExpressProtocol.h
//

#ifndef DeepAdxNativeExpressProtocol_h
#define DeepAdxNativeExpressProtocol_h

#import <DeepAdxAdspot/DeepAdxCommonDelegate.h>

@class DeepAdxNativeExpressView;

@protocol DeepAdxNativeExpressDelegate <DeepAdxBaseDelegate>

@optional

/// 广告数据拉取成功
- (void)ad_NativeExpressOnAdLoadSuccess:(nullable NSArray<DeepAdxNativeExpressView *> *)views;
/// 广告数据拉取失败
- (void)ad_NativeExpressOnAdLoadFailWithError:(NSError *_Nullable)error;
/// 广告渲染成功
- (void)ad_NativeExpressOnAdRenderSuccess:(nullable DeepAdxNativeExpressView *)adView;
/// 广告渲染失败
- (void)ad_NativeExpressOnAdRenderFail:(nullable DeepAdxNativeExpressView *)adView withError:(NSError *_Nullable)error;
/// 广告视图为空
- (void)ad_NativeExpressOnAdGetViewIsEmpty;
/// 广告曝光
- (void)ad_NativeExpressOnAdShow:(nullable DeepAdxNativeExpressView *)adView;
/// 广告点击
- (void)ad_NativeExpressOnAdClicked:(nullable DeepAdxNativeExpressView *)adView;
/// 广告被关闭 (注: 百度广告(百青藤), 不支持该回调, 若使用百青藤,则该回到功能请自行实现)
- (void)ad_NativeExpressOnAdClosed:(nullable DeepAdxNativeExpressView *)adView;
/// 广告点击不喜欢原因后发送
- (void)ad_NativeExpressOnAdDislike:(nullable DeepAdxNativeExpressView *)adView;

@end

#endif
