//
//  DemoBannerViewController.m
//  Example
//

#import "DemoBannerViewController.h"
#import <DeepAdxAdspot/DeepAdxBanner.h>
#import "DemoAdConfig.h"

@interface DemoBannerViewController () <DeepAdxBannerDelegate>
@property (nonatomic, strong) DeepAdxBanner *adBanner;
@property (nonatomic, strong) UIView *bannerContainer;
@end

@implementation DemoBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Banner";
    self.isOnlyLoad = NO;
    [self setupBannerContainer];
}

- (void)setupBannerContainer {
    CGFloat scale = 100.0 / 640.0;
    CGFloat h = self.view.bounds.size.width * scale;
    UIEdgeInsets insets = UIEdgeInsetsZero;
    if (@available(iOS 11.0, *)) {
        insets = self.view.safeAreaInsets;
    }
    CGFloat y = self.view.bounds.size.height - insets.bottom - h-100;
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, y, self.view.bounds.size.width, h)];
    container.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    container.backgroundColor = UIColor.clearColor;
    [self.view addSubview:container];
    self.bannerContainer = container;
}

- (void)loadAndShowAd{
    [super loadAndShowAd];
    if ([self showToastIfAdUnavailable:self.adBanner]) {
        return;
    }
    [self loadAdWithState:AdState_Normal];
    [self.adBanner loadAndShowAd];
    [self loadAdWithState:AdState_Loading];
}

- (void)deallocAd {
    if (_adBanner) {
        _adBanner.delegate = nil;
        _adBanner = nil;
    }
    [self loadAdWithState:AdState_Normal];
}

#pragma mark - DeepAdxBannerDelegate

/// 内部渠道开始加载时调用
- (void)ad_supplierWillLoad:(NSString *)supplierId {
    NSLog(@"内部渠道开始加载 %s  supplierId: %@", __func__, supplierId);
    [self showProcessWithText:[NSString stringWithFormat:@"%s\r\n 内部渠道开始加载时调用", __func__]];
}

/// 选中渠道
- (void)ad_successSortTag:(NSString *)sortTag {
    NSLog(@"选中了 rule '%@' %s", sortTag,__func__);
    [self showProcessWithText:[NSString stringWithFormat:@"%s\r\n 选中了 rule '%@' ", __func__, sortTag]];
}

/// 广告数据拉取成功回调
- (void)ad_loadSuccessWithAdsType:(adsType)adsType {
    NSLog(@"广告数据拉取成功 %s", __func__);
    [self showProcessWithText:[NSString stringWithFormat:@"%s\r\n 广告拉取成功", __func__]];
    [self loadAdWithState:AdState_LoadSucceed];
}

- (void)ad_loadFailure:(NSError *)error withAdsType:(adsType)adsType {
    NSLog(@"广告数据拉取失败%@",error);
    [self showProcessWithText:[NSString stringWithFormat:@"%s\r\n 广告加载失败", __func__]];
    [self loadAdWithState:AdState_LoadFailed];
}

/// 广告展示失败
- (void)ad_exposuredFailed:(NSError *)error withAdsType:(adsType)adsType {
    
}
- (void)ad_failedWithError:(NSError *)error description:(NSDictionary *)description {
    NSLog(@"广告展示失败 %s  error: %@ 详情:%@", __func__, error, description);
    [self showProcessWithText:[NSString stringWithFormat:@"%s\r\n 广告加载失败", __func__]];
    [self showErrorWithDescription:description];
    [self loadAdWithState:AdState_LoadFailed];
    [self deallocAd];
}

/// 广告曝光
- (void)ad_exposuredWithAdsType:(adsType)adsType {
    NSLog(@"广告曝光回调 %s", __func__);
    [self showProcessWithText:[NSString stringWithFormat:@"%s\r\n 广告曝光成功", __func__]];
}

/// 广告点击
- (void)ad_clickedWithAdsType:(adsType)adsType {
    NSLog(@"广告点击 %s", __func__);
    [self showProcessWithText:[NSString stringWithFormat:@"%s\r\n 广告点击", __func__]];
}

/// 广告关闭回调
- (void)ad_didCloseWithAdsType:(adsType)adsType {
    NSLog(@"广告关闭了 %s", __func__);
    [self showProcessWithText:[NSString stringWithFormat:@"%s\r\n 广告关闭了", __func__]];

}

#pragma mark - lazy
- (DeepAdxBanner *)adBanner{
    if(!_adBanner){
        NSString *placementId = [DemoAdConfig placementIdForKind:DemoAdPlacementKindBanner];
        _adBanner = [[DeepAdxBanner alloc] initWithAdViewController:self placementId:placementId];
        _adBanner.delegate = self;
        _adBanner.adContainer = self.bannerContainer;
    }
    return _adBanner;
}

@end
