//
//  DeepAdxLog.h
//

#import <Foundation/Foundation.h>

#if __has_include(<DeepAdxCore/DeepAdxSdkConfig.h>)
#import <DeepAdxCore/DeepAdxSdkConfig.h>
#else
#import "DeepAdxSdkConfig.h"
#endif

#define DEEPADX_LEVEL_FATAL_LOG(format,...)  [DeepAdxLog customLogWithFormatString:[NSString stringWithFormat:format, ##__VA_ARGS__] level:DeepAdxLogLevel_Fatal]
#define DEEPADX_LEVEL_ERROR_LOG(format,...)  [DeepAdxLog customLogWithFormatString:[NSString stringWithFormat:format, ##__VA_ARGS__] level:DeepAdxLogLevel_Error]
#define DEEPADX_LEVEL_WARING_LOG(format,...)  [DeepAdxLog customLogWithFormatString:[NSString stringWithFormat:format, ##__VA_ARGS__] level:DeepAdxLogLevel_Warning]
#define DEEPADX_LEVEL_INFO_LOG(format,...)  [DeepAdxLog customLogWithFormatString:[NSString stringWithFormat:format, ##__VA_ARGS__] level:DeepAdxLogLevel_Info]
#define DEEPADX_LEVEL_DEBUG_LOG(format,...)  [DeepAdxLog customLogWithFormatString:[NSString stringWithFormat:format, ##__VA_ARGS__] level:DeepAdxLogLevel_Debug]

#define DeepAdxLog(format,...)  [DeepAdxLog customLogWithFormatString:[NSString stringWithFormat:format, ##__VA_ARGS__]]
#define DeepAdxLogJSONData(data)  [DeepAdxLog logJsonData:data]

NS_ASSUME_NONNULL_BEGIN


@interface DeepAdxLog : NSObject

/// 日志输出方法
/// @param formatString 内容
/// @param level  日志等级
+ (void)customLogWithFormatString:(NSString *)formatString
                            level:(DeepAdxLogLevel)level;

/// 日志输出方法
/// @param formatString 内容
+ (void)customLogWithFormatString:(NSString *)formatString;

/// 记录data类型数据
/// @param data 数据
+ (void)logJsonData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
