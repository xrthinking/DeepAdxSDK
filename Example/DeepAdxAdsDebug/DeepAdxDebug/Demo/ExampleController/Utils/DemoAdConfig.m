//
//  DemoAdConfig.m
//  DeepAdxDebug
//

#import "DemoAdConfig.h"
#import <DeepAdxCore/DeepAdxCore.h>

/// 国内 iOS 测试应用 ID（与国内广告位 ID 绑定）
static NSString * const kDemoAppIdCN = @"a06460e31fce62fa";
/// 海外 iOS 测试应用 ID（与海外广告位 ID 绑定）
static NSString * const kDemoAppIdOverseas = @"e3aa00b33d0927ec";

@implementation DemoAdConfig

#pragma mark - 国内广告位 ID

+ (NSString *)cnSplashPlacementId { return @"bc67792762bdb759"; }
+ (NSString *)cnBannerPlacementId { return @"b72384448094b28d"; }
+ (NSString *)cnInterstitialPlacementId { return @"b2c3a85530d3d95a"; }
+ (NSString *)cnRewardPlacementId { return @"bf7b40ba83e0098f"; }
+ (NSString *)cnNativePlacementId { return @"bb39f16cdddbc911"; }

#pragma mark - 海外广告位 ID

+ (NSString *)overseasSplashPlacementId { return @"bfe3fa8b9e8f37f5"; }
+ (NSString *)overseasBannerPlacementId { return @"b0b77fe7d422351c"; }
+ (NSString *)overseasInterstitialPlacementId { return @"bdc62dad46437fab"; }
+ (NSString *)overseasRewardPlacementId { return @"b38bfb0d5b06fd68"; }
+ (NSString *)overseasNativePlacementId { return @"b557af1ac49ba08b"; }

#pragma mark - Public

+ (NSString *)appId {
    return [self isMainlandChina] ? kDemoAppIdCN : kDemoAppIdOverseas;
}

+ (BOOL)isMainlandChina {
    // 非中国大陆一律视为海外（含港澳台及其他地区）
    NSString *countryCode = [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
    if (countryCode.length <= 0) {
        countryCode = [[NSLocale autoupdatingCurrentLocale] objectForKey:NSLocaleCountryCode];
    }
    return [countryCode.uppercaseString isEqualToString:@"CN"];
}

+ (NSString *)regionDescription {
    return [self isMainlandChina] ? @"国内" : @"海外";
}

+ (NSString *)placementIdForKind:(DemoAdPlacementKind)kind {
    BOOL isCN = [self isMainlandChina];
    switch (kind) {
        case DemoAdPlacementKindSplash:
            return isCN ? [self cnSplashPlacementId] : [self overseasSplashPlacementId];
        case DemoAdPlacementKindBanner:
            return isCN ? [self cnBannerPlacementId] : [self overseasBannerPlacementId];
        case DemoAdPlacementKindInterstitial:
            return isCN ? [self cnInterstitialPlacementId] : [self overseasInterstitialPlacementId];
        case DemoAdPlacementKindRewardVideo:
            return isCN ? [self cnRewardPlacementId] : [self overseasRewardPlacementId];
        case DemoAdPlacementKindNative:
            return isCN ? [self cnNativePlacementId] : [self overseasNativePlacementId];
    }
    return @"";
}

+ (adsType)adsTypeForKind:(DemoAdPlacementKind)kind {
    switch (kind) {
        case DemoAdPlacementKindSplash: return adsTypeSplash;
        case DemoAdPlacementKindBanner: return adsTypeBanner;
        case DemoAdPlacementKindInterstitial: return adsTypeInterstitial;
        case DemoAdPlacementKindRewardVideo: return adsTypeRewardVideo;
        case DemoAdPlacementKindNative: return adsTypeNative;
    }
    return adsTypeBanner;
}

+ (void)prefetchCurrentRegionConfigs {
    NSString *appId = [self appId];
    NSArray<NSNumber *> *kinds = @[
        @(DemoAdPlacementKindSplash),
        @(DemoAdPlacementKindBanner),
        @(DemoAdPlacementKindInterstitial),
        @(DemoAdPlacementKindRewardVideo),
        @(DemoAdPlacementKindNative),
    ];
    for (NSNumber *num in kinds) {
        DemoAdPlacementKind kind = (DemoAdPlacementKind)num.integerValue;
        NSString *placementId = [self placementIdForKind:kind];
        adsType type = [self adsTypeForKind:kind];
        [[DeepAdxSdkConfig shareInstance] fetchFilterConfigForPlacementId:placementId
                                                                  adsType:type
                                                                    appID:appId];
    }
    NSLog(@"[DemoAdConfig] 已预拉 %@ 地区广告位策略, appId=%@", [self regionDescription], [self appId]);
}

@end
