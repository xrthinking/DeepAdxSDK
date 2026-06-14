//
//  DeepAdxAdapter_PAG.h
//  DeepAdxAdapter_PAG
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark - Pangle
#import "DeepAdxPagSplashAdapter.h"
#import "DeepAdxPagRewardVideoAdapter.h"
#import "DeepAdxPagInterstitialAdapter.h"
#import "DeepAdxPagBannerAdapter.h"
#import "DeepAdxPagNativeExpressAdapter.h"

#pragma mark - DeepAdxCore
#if __has_include(<DeepAdxCore/DeepAdxCore.h>)
#import <DeepAdxCore/DeepAdxCore.h>
#import <DeepAdxAdspot/DeepAdxAdspot.h>
#else
#import "DeepAdxCore/DeepAdxCore.h"
#import "DeepAdxAdspot/DeepAdxAdspot.h"
#endif

//! Project version number for DeepAdxAdapter_PAG.
FOUNDATION_EXPORT double DeepAdxAdapter_PAGVersionNumber;

//! Project version string for DeepAdxAdapter_PAG.
FOUNDATION_EXPORT const unsigned char DeepAdxAdapter_PAGVersionString[];
