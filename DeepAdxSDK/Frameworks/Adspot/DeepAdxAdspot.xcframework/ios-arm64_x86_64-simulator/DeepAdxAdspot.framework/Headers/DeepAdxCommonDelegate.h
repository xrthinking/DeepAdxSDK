//
//  DeepAdxCommonDelegate.h
//

#ifndef DeepAdxCommonDelegate_h
#define DeepAdxCommonDelegate_h

// 策略相关的代理
@protocol DeepAdxCommonDelegate <NSObject>

@optional
/// 内部渠道开始加载时调用
- (void)ad_supplierWillLoad:(NSString *)supplierId;
/// 成功加载渠道
/// @param sortTag 队列的标识
- (void)ad_successSortTag:(NSString *)sortTag;
/// 失败
/// @param error 聚合SDK的错误
/// @param description 每个渠道的错误详情, 部分情况下为nil  key的命名规则: 渠道名-index
- (void)ad_failedWithError:(NSError *)error description:(NSDictionary *)description;

@end

#endif /* DeepAdxBaseDelegate_h */
