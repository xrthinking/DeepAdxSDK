//
//  DemoAdConfig.h
//  DeepAdxDebug
//
//  Demo 国内/海外测试配置（按设备地区 countryCode 自动切换 appId + placementId）
//
//  国内 iOS 测试 appId: a06460e31fce62fa
//    开屏 bc67792762bdb759  横幅 b72384448094b28d  插屏 b2c3a85530d3d95a
//    激励 bf7b40ba83e0098f  原生 bb39f16cdddbc911
//
//  海外 iOS 测试 appId: e3aa00b33d0927ec
//    开屏 bfe3fa8b9e8f37f5  横幅 b0b77fe7d422351c  插屏 bdc62dad46437fab
//    激励 b38bfb0d5b06fd68  原生 b557af1ac49ba08b
//

#import <Foundation/Foundation.h>
#import <DeepAdxCore/DeepAdxSdkConfig.h>

NS_ASSUME_NONNULL_BEGIN

/// Demo 广告位类型（与 DeepAdx 各广告模板一一对应）
typedef NS_ENUM(NSInteger, DemoAdPlacementKind) {
    DemoAdPlacementKindSplash = 0,       ///< 开屏
    DemoAdPlacementKindBanner,           ///< 横幅
    DemoAdPlacementKindInterstitial,     ///< 插屏
    DemoAdPlacementKindRewardVideo,      ///< 激励视频
    DemoAdPlacementKindNative,           ///< 原生
};

@interface DemoAdConfig : NSObject

/// 当前地区对应的 iOS 测试应用 ID（国内/海外各一套，须与后台广告位绑定一致）
+ (NSString *)appId;

/// 当前设备是否判定为中国大陆（countryCode == CN）
+ (BOOL)isMainlandChina;

/// 当前使用的地区描述，用于界面展示：「国内」或「海外」
+ (NSString *)regionDescription;

/// 按广告类型返回当前地区对应的 DeepAdx 广告位 ID
+ (NSString *)placementIdForKind:(DemoAdPlacementKind)kind;

/// 将 Demo 广告位类型映射为 SDK adsType
+ (adsType)adsTypeForKind:(DemoAdPlacementKind)kind;

/// 启动时预拉当前地区全部广告位策略（placementId 方式）
+ (void)prefetchCurrentRegionConfigs;

@end

NS_ASSUME_NONNULL_END
