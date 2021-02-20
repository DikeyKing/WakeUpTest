//
//  NSTimer+ARTimer.h
//  InsightSDK
//
//  Created by Carmine on 2018/9/5.
//  Copyright © 2018 DikeyKing. All rights reserved.
//

/**
    https://www.jianshu.com/p/7fec49cc2a03
 */

#import <Foundation/Foundation.h>

@interface NSTimer (ARTimer)

+ (instancetype)ar_timerWithTimeInterval:(NSTimeInterval)timeInterval
                                   block:(void(^)(void))timeBlock
                                 repeats:(BOOL)repeats;

@end
