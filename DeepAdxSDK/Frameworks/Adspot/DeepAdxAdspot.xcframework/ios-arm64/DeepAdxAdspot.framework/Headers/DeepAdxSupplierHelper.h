//
//  DeepAdxSupplierHelper.h
//  DeepAdxAdspot
//
//  Created by cc on 2022/8/31.
//

#import <Foundation/Foundation.h>
#import <DeepAdxAdspot/DeepAdxBaseDelegate.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeepAdxSupplierHelper : NSObject

/// 是否可以执行（加载/展示）广告
/// adsType 广告类型
/// tag 广告商标识
/// delegate 回调代理
+ (BOOL)isAdAvailableWithAdsType:(adsType)adsType
                             tag:(NSString *)tag
                    withDelegate:(id<DeepAdxBaseDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
