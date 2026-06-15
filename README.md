# DeepAdxSDK iOS 接入文档

DeepAdxSDK 是面向 iOS 的广告聚合 SDK，支持 Banner、插屏、激励视频、开屏、信息流等常见广告位，可按需接入国内/海外渠道适配器。

本文提供从 0 到 1 的接入说明：环境准备、SDK 初始化、各广告位调用、回调处理、示例工程与常见问题排查。

---

## 1. 环境要求

- iOS：`12.0+`
- Xcode：建议 `14+`（越新越好）
- CocoaPods：`1.10.0+`
- 接入语言：Objective-C / Swift（Swift 项目可通过桥接头文件使用）

---

## 2. 仓库结构

```text
deepadx-ios-sdk/
├── DeepAdxSDK.podspec          # CocoaPods 描述文件
├── DeepAdxSDK/
│   ├── Frameworks/
│   │   ├── Core/DeepAdxCore.xcframework
│   │   ├── Adspot/DeepAdxAdspot.xcframework
│   │   └── Adapter/DeepAdxAdapter_*.xcframework
│   └── Resources/GGResource.bundle
└── Example/
    ├── podfile
    ├── DeepAdxAdsDebug.xcworkspace
    ├── DeepAdxAdsDebug/        # Objective-C 示例
    └── DeepAdxSwift/        # Swift 示例
```

---

## 3. 集成方式

### 3.1 CocoaPods（推荐）

在业务工程 `Podfile` 中添加：

```ruby
platform :ios, '12.0'

# 核心模块（必选）
pod 'DeepAdxSDK', '1.0.11'

# 国内渠道（按需）
pod 'DeepAdxSDK/CSJ'   # 穿山甲
pod 'DeepAdxSDK/GDT'   # 广点通
pod 'DeepAdxSDK/KS'    # 快手
pod 'DeepAdxSDK/BD'    # 百度

# 海外渠道（按需）
pod 'DeepAdxSDK/GG'    # Google AdMob
pod 'DeepAdxSDK/PAG'   # Pangle（海外穿山甲）
```

也可以一次性引入多个 subspec：

```ruby
pod 'DeepAdxSDK', '1.0.11', :subspecs => ['Core', 'CSJ', 'GDT', 'KS', 'BD', 'GG', 'PAG']
```

执行安装：

```bash
pod install
```

#### 本地联调（使用仓库源码）

若需要直接调试本仓库中的 `podspec` 与 `xcframework`，可在 `Example/podfile` 中开启本地模式：

```ruby
USE_LOCAL_DEEPADX_SDK = true

pod 'DeepAdxSDK', :path => '../', :subspecs => ['Core', 'CSJ', 'GDT', 'KS', 'BD', 'GG', 'PAG']
```

然后在 Example 目录执行：

```bash
cd Example
pod install
open DeepAdxAdsDebug.xcworkspace
```

### 3.2 手动集成

将以下产物拖入业务工程，并在 Target 的 `General -> Frameworks, Libraries, and Embedded Content` 中配置：

- `DeepAdxCore.xcframework`
- `DeepAdxAdspot.xcframework`
- 对应渠道 `DeepAdxAdapter_*.xcframework`（按需）
- `GGResource.bundle`（若接入 GG 相关广告）

> 建议优先使用 `xcframework`，兼容真机与模拟器架构。

---

## 4. 头文件导入

```objc
#import <DeepAdxCore/DeepAdxCore.h>
#import <DeepAdxAdspot/DeepAdxAdspot.h>
```

按需导入具体广告位头文件，例如：

```objc
#import <DeepAdxAdspot/DeepAdxBanner.h>
#import <DeepAdxAdspot/DeepAdxInterstitial.h>
#import <DeepAdxAdspot/DeepAdxRewardVideo.h>
#import <DeepAdxAdspot/DeepAdxSplash.h>
#import <DeepAdxAdspot/DeepAdxNativeExpress.h>
```

---

## 5. SDK 初始化（必须）

建议在 `AppDelegate` 的 `application:didFinishLaunchingWithOptions:` 里初始化：

```objc
- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupDeepAdx];
    return YES;
}

- (void)setupDeepAdx {
    // 1) 日志级别（调试期开 Debug，线上建议降级）
    [DeepAdxSdkConfig shareInstance].level = DeepAdxLogLevel_Debug;

    // 2) 配置模型
    DeepAdxConfigModel *model = [[DeepAdxConfigModel alloc] init];
    model.debugMode = YES; // 线上请改为 NO

    // 3) 注册 AppID（从平台后台获取）
    [[DeepAdxSdkConfig shareInstance] registerAppID:@"YOUR_APP_ID" withConfig:model];
}
```

---

## 6. 广告位接入示例（OC）

> 回调协议里的方法较多，下面给出最常用链路。  
> 完整 Demo 可参考 `Example/DeepAdxAdsDebug` 工程。

### 6.1 Banner

```objc
@interface DemoVC () <DeepAdxBannerDelegate>
@property (nonatomic, strong) DeepAdxBanner *adBanner;
@end

- (void)loadBanner {
    self.adBanner = [[DeepAdxBanner alloc] initWithAdViewController:self];
    self.adBanner.delegate = self;

    // 可选：指定容器
    // self.adBanner.adContainer = self.bannerContainerView;

    [self.adBanner loadAndShowAd];
}

#pragma mark - DeepAdxBannerDelegate
- (void)ad_loadSuccessWithAdsType:(adsType)adsType {}
- (void)ad_loadFailure:(NSError *)error withAdsType:(adsType)adsType {}
- (void)ad_exposuredWithAdsType:(adsType)adsType {}
- (void)ad_clickedWithAdsType:(adsType)adsType {}
- (void)ad_didCloseWithAdsType:(adsType)adsType { self.adBanner = nil; }
```

### 6.2 插屏（Interstitial）

```objc
@interface DemoVC () <DeepAdxInterstitialDelegate>
@property (nonatomic, strong) DeepAdxInterstitial *adInterstitial;
@end

- (void)loadInterstitial {
    self.adInterstitial = [[DeepAdxInterstitial alloc] initWithViewController:self];
    self.adInterstitial.delegate = self;
    [self.adInterstitial loadAd];
}

- (void)showInterstitial {
    [self.adInterstitial showAd];
}

#pragma mark - DeepAdxInterstitialDelegate
- (void)ad_loadSuccessWithAdsType:(adsType)adsType {}
- (void)ad_loadFailure:(NSError *)error withAdsType:(adsType)adsType {}
- (void)ad_exposuredWithAdsType:(adsType)adsType {}
- (void)ad_didCloseWithAdsType:(adsType)adsType { self.adInterstitial = nil; }
```

### 6.3 激励视频（Reward Video）

```objc
@interface DemoVC () <DeepAdxRewardVideoDelegate>
@property (nonatomic, strong) DeepAdxRewardVideo *adReward;
@end

- (void)loadReward {
    self.adReward = [[DeepAdxRewardVideo alloc] initWithViewController:self];
    self.adReward.delegate = self;
    [self.adReward loadAd];
}

- (void)showReward {
    [self.adReward showAd];
}

#pragma mark - DeepAdxRewardVideoDelegate
- (void)ad_loadSuccessWithAdsType:(adsType)adsType {}
- (void)ad_rewardVideoOnAdVideoCached {}               // 建议在此后展示
- (void)ad_rewardVideoAdDidRewardEffective {}          // 发奖时机
- (void)ad_rewardVideoAdDidPlayFinish {}
- (void)ad_didCloseWithAdsType:(adsType)adsType { self.adReward = nil; }
```

### 6.4 开屏（Splash）

```objc
@interface DemoVC () <DeepAdxSplashDelegate>
@property (nonatomic, strong) DeepAdxSplash *adSplash;
@end

- (void)loadAndShowSplash {
    self.adSplash = [[DeepAdxSplash alloc] initWithViewController:self];
    self.adSplash.delegate = self;
    self.adSplash.timeout = 5;
    self.adSplash.showLogoRequire = YES;
    [self.adSplash loadAndShowAd];
}

#pragma mark - DeepAdxSplashDelegate
- (void)ad_loadSuccessWithAdsType:(adsType)adsType {}
- (void)ad_splashOnAdSkipClicked { self.adSplash = nil; }
- (void)ad_didCloseWithAdsType:(adsType)adsType { self.adSplash = nil; }
```

### 6.5 信息流（Native Express）

```objc
@interface DemoVC () <DeepAdxNativeExpressDelegate>
@property (nonatomic, strong) DeepAdxNativeExpress *adNative;
@property (nonatomic, strong) NSMutableArray<DeepAdxNativeExpressView *> *nativeViews;
@end

- (void)loadNative {
    self.adNative = [[DeepAdxNativeExpress alloc] initWithViewController:self
                                                                   adSize:CGSizeMake(self.view.bounds.size.width, 0)];
    self.adNative.delegate = self;
    [self.adNative loadAd];
}

#pragma mark - DeepAdxNativeExpressDelegate
- (void)ad_NativeExpressOnAdLoadSuccess:(NSArray<DeepAdxNativeExpressView *> *)views {
    self.nativeViews = [views mutableCopy];
    DeepAdxNativeExpressView *first = self.nativeViews.firstObject;
    [first render];
    [self.view addSubview:first.expressView];
}

- (void)ad_NativeExpressOnAdRenderSuccess:(DeepAdxNativeExpressView *)adView {}
- (void)ad_NativeExpressOnAdShow:(DeepAdxNativeExpressView *)adView {}
- (void)ad_NativeExpressOnAdClicked:(DeepAdxNativeExpressView *)adView {}
- (void)ad_NativeExpressOnAdClosed:(DeepAdxNativeExpressView *)adView {}
- (void)ad_NativeExpressOnAdDislike:(DeepAdxNativeExpressView *)adView {} // 部分渠道仅走 dislike
```

---

## 7. 回调语义说明（重要）

为避免瀑布流中断，建议这样理解回调：

- `ad_loadSuccess...`：当前广告位拿到可用广告。
- `ad_loadFailure...`：可能是当前链路失败，也可能是策略/频控拦截。
- `ad_failedWithError:description:`：通常用于最终失败汇总（看你们具体策略接线）。
- `ad_exposured...`：真正曝光。
- `ad_clicked...`：点击。
- `ad_didClose...`：关闭。

> 实战建议：不要在“中途失败”回调里立即释放全局广告上下文，避免影响后续渠道继续加载。

---

## 8. 接入检查清单

上线前建议逐项核对：

- [ ] 已调用 `registerAppID:withConfig:`
- [ ] `viewController` 传值有效（展示时页面未释放）
- [ ] Banner/信息流容器有可见尺寸，不是 0 高度
- [ ] GG 测试设备 ID 在调试阶段已配置
- [ ] `GGResource.bundle` 已进包（若接入 GG）
- [ ] 关闭/跳过回调中有实例清理逻辑

---

## 9. 常见问题与排查

### 9.1 广告加载成功但不展示

优先检查：

- 容器视图是否为空或未在可见层级
- 约束高度是否被压成 0/1（尤其信息流）
- `viewController` 是否有效

### 9.2 信息流“看得到点不了”/无法关闭

常见原因：

- 根视图高度或命中区域异常（被错误约束）
- SDK 需要的控制器绑定缺失

建议：

- 给信息流一个合理占位高度，渲染成功后更新真实高度
- 确认广告视图在最上层可交互区域

### 9.3 `pod install` 报工程解析错误

一般是 `project.pbxproj` 结构被破坏（手工改坏）。  
建议优先通过 Xcode UI 删除 target/group，不直接粗改 `pbxproj`。

若修改了 Example 工程名称或 Podfile target，请重新执行：

```bash
cd Example
pod install
```

---

## 10. 示例工程

| 工程 | 说明 |
|------|------|
| `Example/DeepAdxAdsDebug` | Objective-C 调试示例 |
| `Example/DeepAdxSwift` | Swift 调试示例 |
| `Example/DeepAdxAdsDebug.xcworkspace` | 统一 Workspace，包含 OC/Swift 两个 Demo |

打开方式：

```bash
cd Example
pod install
open DeepAdxAdsDebug.xcworkspace
```
