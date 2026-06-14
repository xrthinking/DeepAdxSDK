//
//  DeepAdxAdapter_GG.h
//  DeepAdxAdapter_GG
//
//  Created by cc on 2022/5/24.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark - GG
#import "DeepAdxGGBannerAdapter.h"
#import "DeepAdxGGInterstitialAdapter.h"
#import "DeepAdxGGNativeExpressAdapter.h"
#import "DeepAdxGGRewardVideoAdapter.h"
#import "DeepAdxGGSplashAdapter.h"

#pragma mark - DeepAdxCore
#if __has_include(<DeepAdxCore/DeepAdxCore.h>)
#import <DeepAdxCore/DeepAdxCore.h>
#import <DeepAdxAdspot/DeepAdxAdspot.h>
#else
#import "DeepAdxCore/DeepAdxCore.h"
#import "DeepAdxAdspot/DeepAdxAdspot.h"
#endif


//! Project version number for DeepAdxAdapter_GG.
FOUNDATION_EXPORT double DeepAdxAdapter_GGVersionNumber;

//! Project version string for DeepAdxAdapter_GG.
FOUNDATION_EXPORT const unsigned char DeepAdxAdapter_GGVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <DeepAdxAdapter_GG/PublicHeader.h>


