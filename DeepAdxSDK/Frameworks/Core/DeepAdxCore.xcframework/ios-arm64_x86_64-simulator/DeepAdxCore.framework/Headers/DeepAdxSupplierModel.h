//
//  DeepAdxSupplierModel.h
//

#import <Foundation/Foundation.h>

@class DeepAdxSupplierModel;
@class DeepAdxSetting;
@class DeepAdxSupplier;
typedef NS_ENUM(NSUInteger, DeepAdxSdkSupplierRepoType) {
   
    /// 广告下载成功
    DeepAdxSdkSupplierRepoTypeLoadSuccess,
    /// 广告下载失败
    DeepAdxSdkSupplierRepoTypeLoadFail,
    /// 广告展示成功
    DeepAdxSdkSupplierRepoTypeShowSuccess,
    /// 广告展示失败
    DeepAdxSdkSupplierRepoTypeShowFail,
    /// 广告点击
    DeepAdxSdkSupplierRepoTypeClick,
};

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces

@interface DeepAdxSupplierModel : NSObject
@property (nonatomic, strong) NSMutableArray<DeepAdxSetting *> *rules;
@property (nonatomic, strong) NSMutableArray<DeepAdxSupplier *> *suppliers;
@property (nonatomic, copy)   NSString *sortTag;

@end

@interface DeepAdxSetting : NSObject
@property (nonatomic, strong) NSMutableArray<NSNumber *> *sort;
@property (nonatomic, assign) NSInteger percent;
@property (nonatomic, copy)   NSString *tag;

@end

@interface DeepAdxSupplier : NSObject
@property (nonatomic, copy)   NSString *appId;
@property (nonatomic, copy)   NSString *adspotId;
@property (nonatomic, copy)   NSString *tag;
@property (nonatomic, strong)   NSNumber *index;

@end

NS_ASSUME_NONNULL_END
