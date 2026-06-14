//
//  DeepAdxConfigModel.h
//  DeepAdxCore
//
//  Created by cc on 2022/10/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeepAdxConfigModel : NSObject

/// appID
@property(nonatomic, copy) NSString *appID;
/// 是否为调试模式
@property(nonatomic, assign) BOOL debugMode;
/// 是否为中国大陆地区
@property(nonatomic, assign) BOOL isCN;
/// 谷歌测试设备ID，仅限测试传入，线上不传
@property(nonatomic, strong) NSArray *testDeviceIdentifiersGG;
/// 是否启用 Google UMP 同意流程。默认仅当设备区域为欧盟/EEA/GB（按 NSLocale 国家码）时为 YES；可在服务端或业务侧显式覆盖。
@property(nonatomic, assign) BOOL enableGoogleUMPConsent;

@end

NS_ASSUME_NONNULL_END
