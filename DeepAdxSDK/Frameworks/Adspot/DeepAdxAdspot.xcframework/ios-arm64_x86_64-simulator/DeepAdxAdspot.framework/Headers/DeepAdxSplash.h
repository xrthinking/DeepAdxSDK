//
//  DeepAdxSplash.h
//

#import <Foundation/Foundation.h>
#if __has_include(<DeepAdxCore/DeepAdxBaseAdapter.h>)
#import <DeepAdxAdspot/DeepAdxSplashDelegate.h>
#import <DeepAdxCore/DeepAdxBaseAdapter.h>
#else
#import "DeepAdxSplashDelegate.h"
#import "DeepAdxBaseAdapter.h"

#endif
NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    /// 垂直显示Logo
    AdLogoTypeVertical,
    /// 水平显示Logo
    AdLogoTypeHorizontal,
} AdLogoType;


@interface DeepAdxSplash : DeepAdxBaseAdapter

/// 广告方法回调代理
@property (nonatomic, weak) id<DeepAdxSplashDelegate> delegate;
/// 是否必须展示Logo 默认: NO 注意: 强制展示Logo可能会影响收益 !!!
@property (nonatomic, assign) BOOL showLogoRequire;
/// 自定义Logo容器
@property(nonatomic, strong) UIView *logoContentView;
///广告Logo样式：水平、垂直
@property(nonatomic, assign) AdLogoType adLogoType;
/// 广告Logo
@property(nonatomic, strong) UIImage *logoImage;
/// 标题
@property(nonatomic, copy) NSString *title;
/// 子标题 adLogoType为AdLogoTypeHorizontal时有效
@property(nonatomic, copy) NSString *subTitle;
/// 广告未加载出来时的占位图
@property(nonatomic, strong) UIImage *backgroundImage;
/// 总超时时间
@property (nonatomic, assign) NSInteger timeout;

/// 获取自定义Logo容器大小
- (CGSize)getLogoConentViewSize;

/// 构造方法
- (instancetype)initWithViewController:(UIViewController *)viewController;
#ifdef DEBUG
/// 构造方法
/// 仅适用于Debug模式 Release下调用无效
- (instancetype)initWithJsonDic:(NSDictionary *)jsonDic viewController:(UIViewController *)viewController;
#endif

@end

NS_ASSUME_NONNULL_END
