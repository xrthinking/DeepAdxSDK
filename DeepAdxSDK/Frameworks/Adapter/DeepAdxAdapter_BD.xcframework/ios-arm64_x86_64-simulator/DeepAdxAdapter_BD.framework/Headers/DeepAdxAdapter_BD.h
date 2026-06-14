//
//  DeepAdxAdapter_BD.h
//  DeepAdxAdapter_BD
//
//  Created by 李秀然 on 2026/3/25.
//

#import <Foundation/Foundation.h>
#pragma mark - 百度
#import "DeepAdxBdSplashAdapter.h"
#import "DeepAdxBdInterstitialAdapter.h"
#import "DeepAdxBdRewardVideoAdapter.h"
#import "DeepAdxBdNativeExpressAdapter.h"

#pragma mark - DeepAdxCore

#if __has_include(<DeepAdxCore/DeepAdxCore.h>)
#import <DeepAdxCore/DeepAdxCore.h>
#import <DeepAdxAdspot/DeepAdxAdspot.h>
#else
#import "DeepAdxCore/DeepAdxCore.h"
#import "DeepAdxAdspot/DeepAdxAdspot.h"
#endif

//! Project version number for DeepAdxAdapter_BD.
FOUNDATION_EXPORT double DeepAdxAdapter_BDVersionNumber;

//! Project version string for DeepAdxAdapter_BD.
FOUNDATION_EXPORT const unsigned char DeepAdxAdapter_BDVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <DeepAdxAdapter_BD/PublicHeader.h>
