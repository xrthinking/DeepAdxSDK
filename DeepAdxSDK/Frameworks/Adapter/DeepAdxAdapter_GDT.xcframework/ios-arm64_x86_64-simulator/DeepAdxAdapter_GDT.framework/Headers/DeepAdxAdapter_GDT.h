//
//  DeepAdxAdapter_GDT.h
//  DeepAdxAdapter_GDT
//
//  Created by cc on 2022/5/24.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark - GDT
#import "DeepAdxGdtBannerAdapter.h"
#import "DeepAdxGdtInterstitialAdapter.h"
#import "DeepAdxGdtRewardVideoAdapter.h"
#import "DeepAdxGdtSplashAdapter.h"

#pragma mark - DeepAdxCore
#if __has_include(<DeepAdxCore/DeepAdxCore.h>)
#import <DeepAdxCore/DeepAdxCore.h>
#import <DeepAdxAdspot/DeepAdxAdspot.h>
#else
#import "DeepAdxCore/DeepAdxCore.h"
#import "DeepAdxAdspot/DeepAdxAdspot.h"
#endif

//! Project version number for DeepAdxAdapter_GDT.
FOUNDATION_EXPORT double DeepAdxAdapter_GDTVersionNumber;

//! Project version string for DeepAdxAdapter_GDT.
FOUNDATION_EXPORT const unsigned char DeepAdxAdapter_GDTVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <DeepAdxAdapter_GDT/PublicHeader.h>


