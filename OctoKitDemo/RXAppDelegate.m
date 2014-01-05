//
//  RXAppDelegate.m
//  OctoKitDemo
//
//  Created by Naoki Tsutsui on 2014/01/04.
//  Copyright (c) 2014年 nkapp. All rights reserved.
//

#import "RXAppDelegate.h"


@implementation RXAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}

//=============================================================================
#pragma mark - OctoKit
//=============================================================================

- (void)simpleRequest
{
    NSString *username = @"naokits";
    OCTUser *user = [OCTUser userWithLogin:username server:OCTServer.dotComServer];
    OCTClient *client = [OCTClient unauthenticatedClientWithUser:user];
    
    // Prepares a request that will load all of the user's repositories, represented
    // by `OCTRepository` objects.
    //
    // Note that the request is not actually _sent_ until you use one of the
    // -subscribe… methods below.
    RACSignal *request = [client fetchUserRepositories];
    
    // This method actually kicks off the request, handling any results using the
    // blocks below.
    [request subscribeNext:^(OCTRepository *repository) {
        // This block is invoked for _each_ result received, so you can deal with
        // them one-by-one as they arrive.
        NSLog(@"リポジトリ:%@", repository);
    } error:^(NSError *error) {
        // Invoked when an error occurs.
        //
        // Your `next` and `completed` blocks won't be invoked after this point.
        NSLog(@"エラー:%@", error);
    } completed:^{
        // Invoked when the request completes and we've received/processed all the
        // results.
        //
        // Your `next` and `error` blocks won't be invoked after this point.
        NSLog(@"完了");
    }];
}

- (void)oAuthAccess
{
    [OCTClient setClientID:@"85f97b090c7641e96c90"
              clientSecret:@"ef4763c780c6248eb1d81abaa289ab252e89cc0a"];

    
//    [OCTUser userWithName:@"naokits" email:@"naokitsutsui@me.com"];
//    [OCTClient authenticatedClientWithUser:@"hoge" token:@"hoge"];
    
    
    //    [OCTClient authenticatedClientWithUser:<#(OCTUser *)#> password:<#(NSString *)#>
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
