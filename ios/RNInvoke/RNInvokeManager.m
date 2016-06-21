//
//  RNInvoke.m
//  RNInvoke
//
//  Created by Tal Kol on 6/20/16.
//  Copyright © 2016 Wix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNInvokeManager.h"
#import "MethodInvocation.h"


@implementation RNInvokeManager

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE();

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

RCT_EXPORT_METHOD(execute:(NSDictionary *)invocation
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    __block BOOL rejected = NO;
    id result = [MethodInvocation invoke:invocation withBridge:self.bridge onError:^(NSString *details)
    {
        if (rejected) return;
        rejected = YES;
        reject(@"invoke_error", details, nil);
    }];
    result = [MethodInvocation serializeValue:result withType:[invocation objectForKey:@"returns"] onError:^(NSString *details)
    {
        if (rejected) return;
        rejected = YES;
        reject(@"invoke_error", details, nil);
    }];
    if (rejected) return;
    resolve(result);
}

@end
