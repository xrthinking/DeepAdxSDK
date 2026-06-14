//
//  DeepAdxNetworkConstants.h
//  NetWorkDemo
//
//  Created by cc on 2022/4/22.
//

#import <Foundation/Foundation.h>

/// Error codes in Firebase Network error domain.
/// Note: these error codes should never change. It would make it harder to decode the errors if
/// we inadvertently altered any of these codes in a future SDK version.
typedef NS_ENUM(NSInteger, DeepAdxNetworkErrorCode) {
  /// Unknown error.
  DeepAdxNetworkErrorCodeUnknown = 0,
  /// Error occurs when the request URL is invalid.
  DeepAdxErrorCodeNetworkInvalidURL = 1,
  /// Error occurs when request cannot be constructed.
  DeepAdxErrorCodeNetworkRequestCreation = 2,
  /// Error occurs when payload cannot be compressed.
  DeepAdxErrorCodeNetworkPayloadCompression = 3,
  /// Error occurs when session task cannot be created.
  DeepAdxErrorCodeNetworkSessionTaskCreation = 4,
  /// Error occurs when there is no response.
  DeepAdxErrorCodeNetworkInvalidResponse = 5
};

#pragma mark - Network constants

/// The prefix of the ID of the background session.
extern NSString *const kDeepAdxNetworkBackgroundSessionConfigIDPrefix;

/// The sub directory to store the files of data that is being uploaded in the background.
extern NSString *const kDeepAdxNetworkApplicationSupportSubdirectory;

/// Name of the temporary directory that stores files for background uploading.
extern NSString *const kDeepAdxNetworkTempDirectoryName;

/// The period when the temporary uploading file can stay.
extern const NSTimeInterval kDeepAdxNetworkTempFolderExpireTime;

/// The default network request timeout interval.
extern const NSTimeInterval kDeepAdxNetworkTimeOutInterval;

/// The host to check the reachability of the network.
extern NSString *const kDeepAdxNetworkReachabilityHost;

/// The key to get the error context of the UserInfo.
extern NSString *const kDeepAdxNetworkErrorContext;

#pragma mark - Network Status Code

extern const int kDeepAdxNetworkHTTPStatusOK;
extern const int kDeepAdxNetworkHTTPStatusNoContent;
extern const int kDeepAdxNetworkHTTPStatusCodeMultipleChoices;
extern const int kDeepAdxNetworkHTTPStatusCodeMovedPermanently;
extern const int kDeepAdxNetworkHTTPStatusCodeFound;
extern const int kDeepAdxNetworkHTTPStatusCodeNotModified;
extern const int kDeepAdxNetworkHTTPStatusCodeMovedTemporarily;
extern const int kDeepAdxNetworkHTTPStatusCodeNotFound;
extern const int kDeepAdxNetworkHTTPStatusCodeCannotAcceptTraffic;
extern const int kDeepAdxNetworkHTTPStatusCodeUnavailable;
