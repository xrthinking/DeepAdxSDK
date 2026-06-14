//
//  DeepAdxNetworkMessageCode.h
//  NetWorkDemo
//
//  Created by cc on 2022/4/22.
//

#import <Foundation/Foundation.h>

// Make sure these codes do not overlap with any contained in the FIRAMessageCode enum.
typedef NS_ENUM(NSInteger, DeepAdxNetworkMessageCode) {
  // GULNetwork.m
  kDeepAdxNetworkMessageCodeNetwork000 = 900000,  // I-NET900000
  kDeepAdxNetworkMessageCodeNetwork001 = 900001,  // I-NET900001
  kDeepAdxNetworkMessageCodeNetwork002 = 900002,  // I-NET900002
  kDeepAdxNetworkMessageCodeNetwork003 = 900003,  // I-NET900003
  // GULNetworkURLSession.m
  kDeepAdxNetworkMessageCodeURLSession000 = 901000,  // I-NET901000
  kDeepAdxNetworkMessageCodeURLSession001 = 901001,  // I-NET901001
  kDeepAdxNetworkMessageCodeURLSession002 = 901002,  // I-NET901002
  kDeepAdxNetworkMessageCodeURLSession003 = 901003,  // I-NET901003
  kDeepAdxNetworkMessageCodeURLSession004 = 901004,  // I-NET901004
  kDeepAdxNetworkMessageCodeURLSession005 = 901005,  // I-NET901005
  kDeepAdxNetworkMessageCodeURLSession006 = 901006,  // I-NET901006
  kDeepAdxNetworkMessageCodeURLSession007 = 901007,  // I-NET901007
  kDeepAdxNetworkMessageCodeURLSession008 = 901008,  // I-NET901008
  kDeepAdxNetworkMessageCodeURLSession009 = 901009,  // I-NET901009
  kDeepAdxNetworkMessageCodeURLSession010 = 901010,  // I-NET901010
  kDeepAdxNetworkMessageCodeURLSession011 = 901011,  // I-NET901011
  kDeepAdxNetworkMessageCodeURLSession012 = 901012,  // I-NET901012
  kDeepAdxNetworkMessageCodeURLSession013 = 901013,  // I-NET901013
  kDeepAdxNetworkMessageCodeURLSession014 = 901014,  // I-NET901014
  kDeepAdxNetworkMessageCodeURLSession015 = 901015,  // I-NET901015
  kDeepAdxNetworkMessageCodeURLSession016 = 901016,  // I-NET901016
  kDeepAdxNetworkMessageCodeURLSession017 = 901017,  // I-NET901017
  kDeepAdxNetworkMessageCodeURLSession018 = 901018,  // I-NET901018
  kDeepAdxNetworkMessageCodeURLSession019 = 901019,  // I-NET901019
};
