//
//  DeepAdxDataJsonManager.h
//  DeepAdxCore
//
//  Created by cc on 2022/10/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeepAdxDataJsonManager : NSObject

+ (instancetype)shared;
- (NSDictionary *)loadAdDataWithType:(adsType)type;

@end

NS_ASSUME_NONNULL_END
