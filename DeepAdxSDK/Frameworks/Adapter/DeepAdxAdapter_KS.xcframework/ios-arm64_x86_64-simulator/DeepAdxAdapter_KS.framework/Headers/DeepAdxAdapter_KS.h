//
//  DeepAdxAdapter_KS.h
//  DeepAdxAdapter_KS
//
//  Created by 李秀然 on 2026/3/24.
//

#import <Foundation/Foundation.h>
#pragma mark - 快手
#import "DeepAdxKsBannerAdapter.h"
#import "DeepAdxKsInterstitialAdapter.h"
#import "DeepAdxKsRewardVideoAdapter.h"
#import "DeepAdxKsNativeExpressAdapter.h"
#import "DeepAdxKsSplashAdapter.h"

#pragma mark - DeepAdxCore

#if __has_include(<DeepAdxCore/DeepAdxCore.h>)
#import <DeepAdxCore/DeepAdxCore.h>
#import <DeepAdxAdspot/DeepAdxAdspot.h>
#else
#import "DeepAdxCore/DeepAdxCore.h"
#import "DeepAdxAdspot/DeepAdxAdspot.h"
#endif

//! Project version number for DeepAdxAdapter_KS.
FOUNDATION_EXPORT double DeepAdxAdapter_KSVersionNumber;

//! Project version string for DeepAdxAdapter_KS.
FOUNDATION_EXPORT const unsigned char DeepAdxAdapter_KSVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <DeepAdxAdapter_KS/PublicHeader.h>
