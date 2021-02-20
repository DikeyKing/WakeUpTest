//
//  AppDelegate.m
//  WakeUpTest
//
//  Created by Dikey on 2021/2/2.
//

#import "AppDelegate.h"
#import "NSTimer+ARTimer.h"

#include <mach/task.h>
#include <mach/mach.h>

static NSInteger _interrupt_wakeup;
static NSInteger _timer_wakeup;

@interface AppDelegate (){
    NSTimer *_timer;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self addTimer];

    return YES;
}

- (void)addTimer
{
    _timer = [NSTimer ar_timerWithTimeInterval:1.0 block:^{
        NEGetSystemWakeup(&_interrupt_wakeup, &_timer_wakeup);
    } repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}



#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


BOOL NEGetSystemWakeup(NSInteger *interrupt_wakeup, NSInteger *timer_wakeup) {
    struct task_power_info info = {0};
    mach_msg_type_number_t count = TASK_POWER_INFO_COUNT;
    kern_return_t ret = task_info(current_task(), TASK_POWER_INFO, (task_info_t)&info, &count);
    if (ret == KERN_SUCCESS) {
        if (interrupt_wakeup) {
            *interrupt_wakeup = info.task_interrupt_wakeups;
            NSLog(@"wake _interrupt_wakeup = %@", @(_interrupt_wakeup));
        }
        if (timer_wakeup) {
            *timer_wakeup = info.task_timer_wakeups_bin_1 + info.task_timer_wakeups_bin_2;
            NSLog(@"wake _timer_wakeup = %@", @(_timer_wakeup));
        }
        return true;
    }
    else {
        if (interrupt_wakeup) {
            *interrupt_wakeup = 0;
        }
        if (timer_wakeup) {
            *timer_wakeup = 0;
        }
        return false;
    }
}

@end
