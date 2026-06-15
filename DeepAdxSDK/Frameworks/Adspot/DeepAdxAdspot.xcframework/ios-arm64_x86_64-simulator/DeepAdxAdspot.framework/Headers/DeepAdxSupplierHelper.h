//
//  DeepAdxSupplierHelper.h
//  DeepAdxAdspot
//

#import <Foundation/Foundation.h>
#import <DeepAdxAdspot/DeepAdxBaseDelegate.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeepAdxSupplierHelper : NSObject

/// 是否可以执行（加载/展示）广告
+ (BOOL)isAdAvailableWithAdsType:(adsType)adsType
                             tag:(NSString *)tag
                    withDelegate:(id<DeepAdxBaseDelegate>)delegate;

/// 指定 DeepAdx 广告位 ID 时的频控与屏蔽判断
+ (BOOL)isAdAvailableWithAdsType:(adsType)adsType
                             tag:(NSString *)tag
                      placementId:(nullable NSString *)placementId
                    withDelegate:(id<DeepAdxBaseDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
