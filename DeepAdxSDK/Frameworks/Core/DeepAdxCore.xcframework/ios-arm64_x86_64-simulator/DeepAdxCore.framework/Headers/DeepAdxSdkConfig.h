//
//  DeepAdxSdkConfig.h
//  

#import <Foundation/Foundation.h>
#import <DeepAdxCore/DeepAdxConfigModel.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,DeepAdxLogLevel) {
    DeepAdxLogLevel_None  = 0, // 不打印
    DeepAdxLogLevel_Fatal,
    DeepAdxLogLevel_Error,
    DeepAdxLogLevel_Warning,
    DeepAdxLogLevel_Info,
    DeepAdxLogLevel_Debug,
};

// 广告类型
typedef NS_ENUM(NSInteger, adsType){
    adsTypeSplash = 1,                // 开屏广告
    adsTypeBanner ,                   // 横幅广告
    adsTypeInterstitial ,             // 插页式广告
    adsTypeRewardedInterstitialVideo, // 插页式激励视频广告
    adsTypeNative ,                   // 原生广告
    adsTypeRewardVideo ,              // 激励视频广告
    adsTypeInformationFlow,           // 信息流
    adsTypeNativeBanner,              // 原生横幅广告
};

#pragma mark - SDK
extern NSString *const DeepAdxSdkVersion;

extern NSString *const SDK_TAG_GDT;
extern NSString *const SDK_TAG_CSJ;
extern NSString *const SDK_TAG_KS;
extern NSString *const SDK_TAG_BAIDU;
extern NSString *const SDK_TAG_GG;
extern NSString *const SDK_TAG_IS;
extern NSString *const SDK_TAG_FB;
extern NSString *const SDK_TAG_PAG;


extern NSString *const DeepAdxSdkTypeAdName;
extern NSString *const DeepAdxSdkTypeAdNameSplash;
extern NSString *const DeepAdxSdkTypeAdNameBanner;
extern NSString *const DeepAdxSdkTypeAdNameInterstitial;
extern NSString *const DeepAdxSdkTypeAdNameFullScreenVideo;
extern NSString *const DeepAdxSdkTypeAdNameNativeExpress;
extern NSString *const DeepAdxSdkTypeAdNameRewardVideo;

/// 屏幕宽高
#define kScreenWith      [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight    [[UIScreen mainScreen] bounds].size.height
#define WeakSelf(weakSelf)  __weak __typeof(self) weakSelf = self;
// Tabbar safe bottom margin.
#define  K_TabbarSafeBottomMarginDeepAdx       (kIsSafeArea ? 34.f : 0.f)
#define k_Height_TabBar (kIsSafeArea ? 83.0 : 49.0)
#define k_Height_NavBar (kIsSafeArea ? 88.0 : 64.0)

// 带有安全区域
#define kIsSafeArea (\
{\
BOOL isPhoneX = NO;\
isPhoneX = [UIApplication sharedApplication].getCurrentWindow.safeAreaInsets.bottom > 0.0;\
(isPhoneX);}\
)
@interface DeepAdxSdkConfig : NSObject

+ (instancetype)shareInstance;

/// 初始化SDK add 20221021
/// appID: 应用ID
/// @parame config 配置model
- (void)registerAppID:(NSString *)appID
           withConfig:(DeepAdxConfigModel * __nullable)config;

/// 获取SDK版本
+ (NSString *)sdkVersion;

/*
 判断是否是简体中文
 */
+ (BOOL)isSimplifiedChinese;

/// 控制台log级别
/// 0 不打印
/// 1 打印fatal
/// 2 fatal + error
/// 3 fatal + error + warning
/// 4 fatal + error + warning + info
/// 5 全部打印
@property (nonatomic, assign) DeepAdxLogLevel level;

/// 按 DeepAdx 广告位 ID 拉取过滤配置（同一类型多广告位时使用）
- (void)fetchFilterConfigForPlacementId:(NSString *)placementId
                                adsType:(adsType)adsType
                                  appID:(NSString *)appID;

/// 按广告类型拉取过滤配置（本地缓存缺失时主动补拉）
- (void)fetchFilterConfigForAdsType:(adsType)adsType
                              appID:(NSString *)appID;

@end

@protocol DeepAdxConsentProvider <NSObject>

@required
/// provider 唯一标识，建议使用渠道 tag（如 gg/csj）。
- (NSString *)providerIdentifier;
/// 当前 provider 是否需要发起隐私弹窗流程。
- (BOOL)shouldRequestConsentWithConfig:(DeepAdxConfigModel *)configModel;
/// 发起隐私弹窗流程。
- (void)requestConsentWithConfig:(DeepAdxConfigModel *)configModel
                      completion:(void (^ __nullable)(NSError * __nullable error))completion;

@end

@interface DeepAdxSdkConfig (Consent)

/// 注册隐私弹窗 provider，重复 identifier 会覆盖旧值。
+ (void)registerConsentProvider:(id<DeepAdxConsentProvider>)provider;
/// 按 identifier 取消注册 provider。
+ (void)unregisterConsentProviderForIdentifier:(NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
