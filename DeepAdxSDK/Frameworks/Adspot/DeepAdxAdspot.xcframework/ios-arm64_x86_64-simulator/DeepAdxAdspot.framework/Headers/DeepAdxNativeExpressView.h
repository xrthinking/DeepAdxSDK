//
//  DeepAdxNativeExpressView.h
//  DeepAdxAdspot
//
//  Created by cc on 2022/8/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeepAdxNativeExpressView : NSObject

- (instancetype)initWithViewController:(UIViewController *)controller;
/// 信息流view
@property (nonatomic, strong) UIView *expressView;

- (void)render;

@end

NS_ASSUME_NONNULL_END
