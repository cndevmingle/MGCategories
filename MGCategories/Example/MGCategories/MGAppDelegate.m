//
//  MGAppDelegate.m
//  MGCategories
//
//  Created by Mingle on 01/31/2018.
//  Copyright (c) 2018 Mingle. All rights reserved.
//

#import "MGAppDelegate.h"
#import "NSDate+MGDate.h"
#import "NSString+MGString.h"

@implementation MGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
//    NSLog(@"%@", [[NSDate date] mg_stringWithFormat:@"yyyy-MM-dd HH:mm:ss w"]);
    NSString *str = [NSNull null];
    NSLog(@"%@", [NSString isBlank:str]?@"空":@"非空");
    str = @"ggydm@vip.qq.com";
    NSLog(@"%@邮箱", [str isEmailAddress]?@"是":@"不是");
    str = @"18608170501";
    NSLog(@"%@手机", [str isMobileNumber]?@"是":@"不是");
    str = @"08178212694";
    NSLog(@"%@座机", [str isMobileNumberClassification]?@"是":@"不是");
    str = @"51132219951110101x";
    NSLog(@"%@身份证号", [NSString accurateVerifyIDCardNumber:str]?@"是":@"不是");
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
