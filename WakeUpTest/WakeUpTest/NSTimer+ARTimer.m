//
//  NSTimer+ARTimer.m
//  InsightSDK
//
//  Created by Carmine on 2018/9/5.
//  Copyright © 2018 DikeyKing. All rights reserved.
//

#import "NSTimer+ARTimer.h"

@implementation NSTimer (ARTimer)

+ (instancetype)ar_timerWithTimeInterval:(NSTimeInterval)timeInterval
                                   block:(void(^)(void))timeBlock
                                 repeats:(BOOL)repeats {
    return [self timerWithTimeInterval:timeInterval
                                target:self
                              selector:@selector(ar_blockInvoke:)
                              userInfo:[timeBlock copy]
                               repeats:repeats
            ];
}

+ (void)ar_blockInvoke:(NSTimer *)timer{
    void(^block)(void) = timer.userInfo;
    if (block) {
        block();
    }
}

@end
