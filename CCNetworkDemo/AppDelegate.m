//
//  AppDelegate.m
//  CCNetworkDemo
//
//  Created by admin on 2018/1/11.
//  Copyright © 2018年 cuixinkuan. All rights reserved.
//

#import "AppDelegate.h"
#import "CCUrlArgumentsFilter.h"
#import "CCNetworkConfig.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    CCNetworkConfig * config = [CCNetworkConfig sharedConfig];
    config.baseUrl = @"http://www.yvanwang.me";//@"https://news-at.zhihu.com";//@"http://zsc.ceair.com:80";
//    config.cdnUrl = @"http://****";
//    [self setupRequestFilters];
    return YES;
}

- (void)setupRequestFilters { // 添加请求过滤
    NSString * appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    CCNetworkConfig * config = [CCNetworkConfig sharedConfig];
    CCUrlArgumentsFilter * urlFilter = [CCUrlArgumentsFilter filterWithArguments:@{@"version":appVersion}];
    [config addUrlFilter:urlFilter];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
