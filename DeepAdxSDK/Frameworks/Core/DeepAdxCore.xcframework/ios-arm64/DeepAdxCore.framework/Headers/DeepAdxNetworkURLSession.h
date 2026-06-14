//
//  DeepAdxNetworkURLSession.h
//  NetWorkDemo
//
//  Created by cc on 2022/4/22.
//

#import <Foundation/Foundation.h>
#import "DeepAdxNetworkLoggerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^DeepAdxNetworkCompletionHandler)(NSHTTPURLResponse *_Nullable response,
                                            NSDictionary *_Nullable data,
                                            NSError *_Nullable error);
typedef void (^DeepAdxNetworkURLSessionCompletionHandler)(NSHTTPURLResponse *_Nullable response,
                                                      NSData *_Nullable data,
                                                      NSString *sessionID,
                                                      NSError *_Nullable error);
typedef void (^DeepAdxNetworkSystemCompletionHandler)(void);

@interface DeepAdxNetworkURLSession : NSObject

/// Indicates whether the background network is enabled. Default value is NO.
@property(nonatomic, getter=isBackgroundNetworkEnabled) BOOL backgroundNetworkEnabled;

/// The logger delegate to log message, errors or warnings that occur during the network operations.
@property(nonatomic, weak, nullable) id<DeepAdxNetworkLoggerProtocol> loggerDelegate;

/// Calls the system provided completion handler after the background session is finished.
+ (void)handleEventsForBackgroundURLSessionID:(NSString *)sessionID
                            completionHandler:(DeepAdxNetworkSystemCompletionHandler)completionHandler;

/// Initializes with logger delegate.
- (instancetype)initWithNetworkLoggerDelegate:
    (nullable id<DeepAdxNetworkLoggerProtocol>)networkLoggerDelegate NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

/// Sends an asynchronous POST request and calls the provided completion handler when the request
/// completes or when errors occur, and returns an ID of the session/connection.
- (nullable NSString *)sessionIDFromAsyncPOSTRequest:(NSURLRequest *)request
                                   completionHandler:(DeepAdxNetworkURLSessionCompletionHandler)handler;

/// Sends an asynchronous GET request and calls the provided completion handler when the request
/// completes or when errors occur, and returns an ID of the session.
- (nullable NSString *)sessionIDFromAsyncGETRequest:(NSURLRequest *)request
                                  completionHandler:(DeepAdxNetworkURLSessionCompletionHandler)handler;

@end

NS_ASSUME_NONNULL_END
