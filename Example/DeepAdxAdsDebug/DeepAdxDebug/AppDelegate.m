//
//  AppDelegate.m
//  DeepAdxDebug
//
//  Created by cc on 2022/5/24.
//

#import "AppDelegate.h"
#import <DeepAdxCore/DeepAdxCore.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/AdSupport.h>
#import "ViewController.h"
#import "DemoSplashViewController.h"

@interface AppDelegate ()
@property (nonatomic, assign) BOOL hasRequestedTracking;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    self.isDebug = YES;
    [self settingDeepAdx];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    UINavigationController * nc = [[UINavigationController alloc]initWithRootViewController:[ViewController new]];
    self.window.rootViewController = nc;
    return YES;
}

/// 配置sdk
- (void)settingDeepAdx {
    [DeepAdxSdkConfig shareInstance].level = DeepAdxLogLevel_Debug;
    DeepAdxConfigModel * model = [[DeepAdxConfigModel alloc]init];
//#ifdef DEBUG
//    model.debugMode = YES;
//#else
    model.debugMode = YES;
    model.testDeviceIdentifiersGG = @[ @"DB161DFE-9AAC-4AEC-9865-25D3CE848935" ];
//    model.enableGoogleUMPConsent = YES;
//#endif
    // 国内测试：a06460e31fce62fa
    // 国外测试：e3aa00b33d0927ec
    // 依然在线-iOS(国内)：1375ce71c7894b24
    // 依然在线-iOS(海外)：6b1c8048fdc01e0b
    [[DeepAdxSdkConfig shareInstance] registerAppID:@"a06460e31fce62fa" withConfig:model];
}

// 获取IDFA权限
- (void)requestTracking {
    if (@available(iOS 14, *)) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            if (status == ATTrackingManagerAuthorizationStatusAuthorized) {

            NSString *idfa = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
                NSLog(@"idfa = %@",idfa);
            }
        }];
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    if (self.hasRequestedTracking) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf || strongSelf.hasRequestedTracking) {
            return;
        }
        UIViewController *rootVC = strongSelf.window.rootViewController;
        if (rootVC.presentedViewController || rootVC.isBeingPresented || rootVC.isBeingDismissed) {
            return;
        }
        strongSelf.hasRequestedTracking = YES;
        [strongSelf requestTracking];
    });
}


@end


