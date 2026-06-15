//
//  DeepAdxDatabaseManager.h
//  DeepAdxSDK
//

#import <Foundation/Foundation.h>
#import <DeepAdxCore/DeepAdxSdkConfig.h>
#import <DeepAdxCore/DeepAdxDataConversionUtils.h>
#import <DeepAdxCore/DeepAdxConfigModel.h>

NS_ASSUME_NONNULL_BEGIN

#define kIsShieldAds @"isShieldAds"
#define kDeepAdxAPPID @"DeepAdxAPPID"
#define kDeepAdx_ISDEBUG @"DeepAdx_ISDEBUG"


@interface DeepAdxDatabaseManager : NSObject

+ (nonnull DeepAdxDatabaseManager *)sharedInstance;
/// 是否需要上报日志
@property(nonatomic, assign) BOOL isUpdateState;
/// 是否屏蔽广告展示
@property(nonatomic, assign) BOOL isShieldAds;
/// DeepAdxConfigModel
@property(nonatomic, strong) DeepAdxConfigModel *configModel;
/// appID
@property(nonatomic, strong) NSString *appID;

/// 本地缓存/频控键：有 placementId 用广告位 ID，否则用 adsType 字符串
- (NSString *)configCacheKeyForAdsType:(adsType)type placementId:(nullable NSString *)placementId;

- (NSDictionary *)readLocalDataWithPath:(NSString *)path;

#pragma mark - 本地存取
- (void)saveDataToUserDefaults:(id)value key:(NSString *)key;
- (id)getDataForKey:(NSString *)key;

#pragma mark - 广告数据读取
- (BOOL)writeDataToLocal:(NSDictionary *)data
                    type:(adsType)type
                  isShow:(BOOL)isShow;
- (BOOL)writeDataToLocal:(NSDictionary *)data
                    type:(adsType)type
              placementId:(nullable NSString *)placementId
                  isShow:(BOOL)isShow;

- (id)readLocalDataWithAdsType:(adsType)adsType isShow:(BOOL)isShow;
- (id)readLocalDataWithAdsType:(adsType)adsType
                    placementId:(nullable NSString *)placementId
                         isShow:(BOOL)isShow;

#pragma mark - 接口数据读取
- (void)saveLastRequestTimeWithAdsType:(adsType)adsType;
- (void)saveLastRequestTimeWithAdsType:(adsType)adsType placementId:(nullable NSString *)placementId;
- (id)getLastRequestTimeWithAdsType:(adsType)adsType;
- (id)getLastRequestTimeWithAdsType:(adsType)adsType placementId:(nullable NSString *)placementId;

#pragma mark - 接口判断
- (BOOL)isRequestAllowedWithAdsType:(adsType)adsType;
- (BOOL)isRequestAllowedWithAdsType:(adsType)adsType placementId:(nullable NSString *)placementId;

#pragma mark - 展现限制
- (NSDictionary *)isShowAdWithAdsType:(adsType)adsType withTag:(NSString *)tag;
- (NSDictionary *)isShowAdWithAdsType:(adsType)adsType
                           placementId:(nullable NSString *)placementId
                               withTag:(NSString *)tag;
- (void)recordAdWithAdsType:(adsType)adsType withTag:(NSString *)tag;
- (void)recordAdWithAdsType:(adsType)adsType
                placementId:(nullable NSString *)placementId
                    withTag:(NSString *)tag;

- (NSString *)completeRoutePathWithType:(adsType)type isShow:(BOOL)isShow;
- (NSString *)completeRoutePathWithType:(adsType)type
                             placementId:(nullable NSString *)placementId
                                   isShow:(BOOL)isShow;

- (NSString *)getFilePath;
- (NSString *)getFileNameWithType:(adsType)type isShow:(BOOL)isShow;
- (NSString *)getFileNameWithType:(adsType)type
                      placementId:(nullable NSString *)placementId
                           isShow:(BOOL)isShow;

@end

NS_ASSUME_NONNULL_END
