/*
 * Copyright 2017 Google
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "DeepAdxReachabilityChecker.h"

#if !TARGET_OS_WATCH
typedef SCNetworkReachabilityRef (*DeepAdxReachabilityCreateWithNameFn)(CFAllocatorRef allocator,
                                                                    const char *host);

typedef Boolean (*DeepAdxReachabilitySetCallbackFn)(SCNetworkReachabilityRef target,
                                                SCNetworkReachabilityCallBack callback,
                                                SCNetworkReachabilityContext *context);
typedef Boolean (*DeepAdxReachabilityScheduleWithRunLoopFn)(SCNetworkReachabilityRef target,
                                                        CFRunLoopRef runLoop,
                                                        CFStringRef runLoopMode);
typedef Boolean (*DeepAdxReachabilityUnscheduleFromRunLoopFn)(SCNetworkReachabilityRef target,
                                                          CFRunLoopRef runLoop,
                                                          CFStringRef runLoopMode);

typedef void (*DeepAdxReachabilityReleaseFn)(CFTypeRef cf);

struct DeepAdxReachabilityApi {
  DeepAdxReachabilityCreateWithNameFn createWithNameFn;
  DeepAdxReachabilitySetCallbackFn setCallbackFn;
  DeepAdxReachabilityScheduleWithRunLoopFn scheduleWithRunLoopFn;
  DeepAdxReachabilityUnscheduleFromRunLoopFn unscheduleFromRunLoopFn;
  DeepAdxReachabilityReleaseFn releaseFn;
};
#endif
@interface DeepAdxReachabilityChecker (Internal)

- (const struct DeepAdxReachabilityApi *)reachabilityApi;
- (void)setReachabilityApi:(const struct DeepAdxReachabilityApi *)reachabilityApi;

@end
