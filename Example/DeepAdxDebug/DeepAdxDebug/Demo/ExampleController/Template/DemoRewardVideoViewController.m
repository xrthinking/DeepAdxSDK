//
//  DemoRewardVideoViewController.m
//  DeepAdxSDKDemo
//
//  Created by CherryKing on 2020/1/3.
//  Copyright © 2020 DEEPADX. All rights reserved.
//

#import "DemoRewardVideoViewController.h"

#import <DeepAdxAdspot/DeepAdxRewardVideo.h>
@interface DemoRewardVideoViewController () <DeepAdxRewardVideoDelegate>
@property (nonatomic, strong) DeepAdxRewardVideo *adRewardVideo;
@property (nonatomic) bool isAdLoaded;
@end

@implementation DemoRewardVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"激励视频广告";
}

- (void)loadAd {
    [super loadAd];
    [self deallocAd];
    [self loadAdWithState:AdState_Normal];
    [self.adRewardVideo loadAd];
    [self loadAdWithState:AdState_Loading];
}

- (void)showAd {
    if (!self.adRewardVideo) {
        [DemoUtils showToast:@"请先加载广告"];
        return;
    }
    [self.adRewardVideo showAd];
}

- (void)loadAndShowAd {
    [super loadAd];
    [self deallocAd];
    [self loadAdWithState:AdState_Normal];
    [self.adRewardVideo loadAndShowAd];
    [self loadAdWithState:AdState_Loading];
}

- (void)deallocAd {
    if (_adRewardVideo) {
        _adRewardVideo.delegate = nil;
        _adRewardVideo = nil;
    }
    self.isLoaded = NO;
    [self loadAdWithState:AdState_Normal];
}

#pragma mark - DeepAdxRewardVideoDelegate
/// 内部渠道开始加载时调用
- (void)ad_supplierWillLoad:(NSString *)supplierId {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    NSLog(@"[%@] 内部渠道开始加载 %s  supplierId: %@", [formatter stringFromDate:[NSDate date]], __func__, supplierId);
    [self showProcessWithText:[NSString stringWithFormat:@"%s\r\n 内部渠道开始加载", __func__]];
}

/// 选中渠道
- (void)ad_successSortTag:(NSString *)sortTag {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    NSLog(@"[%@] 选中了 rule '%@' %s", [formatter stringFromDate:[NSDate date]], sortTag,__func__);
    [self showProcessWithText:[NSString stringWithFormat:@"%s\r\n 选中了 rule '%@' ", __func__, sortTag]];
}

/// 广告数据加载成功
- (void)ad_loadSuccessWithAdsType:(adsType)adsType {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    NSLog(@"[%@] 广告数据拉取成功, 正在缓存... %s", [formatter stringFromDate:[NSDate date]], __func__);
    [DemoUtils showToast:@"广告加载成功"];
    [self showProcessWithText:[NSString stringWithFormat:@"%s\r\n 广告数据拉取成功", __func__]];
}

- (void)ad_loadFailure:(NSError *)error withAdsType:(adsType)adsType {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    NSLog(@"[%@] 广告数据拉取失败  %@", [formatter stringFromDate:[NSDate date]], error);
}

/// 视频缓存成功
- (void)ad_rewardVideoOnAdVideoCached {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    NSLog(@"[%@] 视频缓存成功 %s", [formatter stringFromDate:[NSDate date]], __func__);
    [DemoUtils showToast:@"视频缓存成功"];
    self.isLoaded = YES;
    [self showProcessWithText:[NSString stringWithFormat:@"%s\r\n 视频缓存成功", __func__]];
    [self loadAdWithState:AdState_LoadSucceed];
}

/// 到达激励时间
- (void)ad_rewardVideoAdDidRewardEffective {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    NSLog(@"[%@] 到达激励时间 %s", [formatter stringFromDate:[NSDate date]], __func__);
    [self showProcessWithText:[NSString stringWithFormat:@"%s\r\n 到达激励时间", __func__]];
}

/// 广告曝光
- (void)ad_exposuredWithAdsType:(adsType)adsType {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    NSLog(@"[%@] 广告曝光回调 %s", [formatter stringFromDate:[NSDate date]], __func__);
    [self showProcessWithText:[NSString stringWithFormat:@"%s\r\n 广告曝光回调", __func__]];
}

/// 广告点击
- (void)ad_clickedWithAdsType:(adsType)adsType {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    NSLog(@"[%@] 广告点击 %s", [formatter stringFromDate:[NSDate date]], __func__);
    [self showProcessWithText:[NSString stringWithFormat:@"%s\r\n 广告点击", __func__]];
}

/// 广告展示失败
- (void)ad_failedWithError:(NSError *)error description:(NSDictionary *)description {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    NSLog(@"[%@] 广告展示失败 %s  error: %@ 详情:%@", [formatter stringFromDate:[NSDate date]], __func__, error,description);
    [DemoUtils showToast:@"广告加载失败"];
    [self showProcessWithText:[NSString stringWithFormat:@"%s\r\n 广告加载失败", __func__]];
    [self showErrorWithDescription:description];
    [self loadAdWithState:AdState_LoadFailed];
    [self deallocAd];
}

/// 广告关闭
- (void)ad_didCloseWithAdsType:(adsType)adsType {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    NSLog(@"[%@] 广告关闭了 %s", [formatter stringFromDate:[NSDate date]], __func__);
    [self showProcessWithText:[NSString stringWithFormat:@"%s\r\n 广告关闭了", __func__]];
    [self deallocAd];
}

/// 播放完成
- (void)ad_rewardVideoAdDidPlayFinish {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    NSLog(@"[%@] 播放完成 %s", [formatter stringFromDate:[NSDate date]], __func__);
    [self showProcessWithText:[NSString stringWithFormat:@"%s\r\n 播放完成", __func__]];
}

#pragma mark - lazy
- (DeepAdxRewardVideo *)adRewardVideo{
    if(!_adRewardVideo){
        _adRewardVideo = [[DeepAdxRewardVideo alloc] initWithViewController:self];
        _adRewardVideo.delegate = self;
        _adRewardVideo.rewardServerParams.userId = @"100001";
        _adRewardVideo.rewardServerParams.extra = @"哈哈哈";
        _adRewardVideo.rewardServerParams.rewardName = @"元宝";
        _adRewardVideo.rewardServerParams.rewardAmount = 100;
    }
    return _adRewardVideo;
}
@end
