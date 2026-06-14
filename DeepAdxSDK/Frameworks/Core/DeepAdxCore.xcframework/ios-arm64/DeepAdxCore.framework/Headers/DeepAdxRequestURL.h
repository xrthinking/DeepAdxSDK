//
//  DeepAdxRequestURL.h
//  Pods
//
//  Created by cc on 2022/5/4.
//

#ifndef DeepAdxRequestURL_h
#define DeepAdxRequestURL_h

#ifdef DEBUG

#define BaseURL         @"https://sdk.deepadx.com"        // 广告配置接口API
#define BaseURLOSS      @"https://oss.deepadx.com"        // 广告配置兜底OSS

#else

#define BaseURL         @"https://sdk.deepadx.com"        // 广告配置接口API
#define BaseURLOSS      @"https://oss.deepadx.com"        // 广告配置兜底OSS

#endif

/// 状态上报
#define  URL_ADS_REPORTSTATE     @"/ads/reportState"
/// 加密广告信息接口
#define  URL_ADS_RULE            @"/ads/ruleInfo"


#endif /* DeepAdxRequestURL_h */
