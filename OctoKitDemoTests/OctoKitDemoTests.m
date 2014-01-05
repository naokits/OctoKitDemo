//
//  OctoKitDemoTests.m
//  OctoKitDemoTests
//
//  Created by Naoki Tsutsui on 2014/01/04.
//  Copyright (c) 2014年 nkapp. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface OctoKitDemoTests : XCTestCase

@end

@implementation OctoKitDemoTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}


- (void)testSimpleRequest
{
    __block BOOL waitingForBlock = YES;

    NSString *username = @"github";
    OCTUser *user = [OCTUser userWithLogin:username server:OCTServer.dotComServer];
    OCTClient *client = [OCTClient unauthenticatedClientWithUser:user];
    
    RACSignal *request = [client fetchUserRepositories];
    
    [request subscribeNext:^(OCTRepository *repository) {
        // This block is invoked for _each_ result received, so you can deal with them one-by-one as they arrive.
        NSLog(@"Repository Info:%@", repository);
    } error:^(NSError *error) {
        // Invoked when an error occurs.
        //
        // Your `next` and `completed` blocks won't be invoked after this point.
        XCTFail(@"%s Error:%@", __PRETTY_FUNCTION__, error);
        waitingForBlock = NO;
    } completed:^{
        // Invoked when the request completes and we've received/processed all the results.
        //
        // Your `next` and `error` blocks won't be invoked after this point.
        XCTAssertTrue(YES, @"Should have been success!");
        waitingForBlock = NO;

    }];
    // Run the loop
    while(waitingForBlock) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
    }

}
@end
