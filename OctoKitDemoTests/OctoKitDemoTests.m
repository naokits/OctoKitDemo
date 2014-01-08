//
//  OctoKitDemoTests.m
//  OctoKitDemoTests
//
//  Created by Naoki Tsutsui on 2014/01/04.
//  Copyright (c) 2014年 nkapp. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface OctoKitDemoTests : XCTestCase
@property (strong, nonatomic) RACDisposable *repositoriesDisposable;
@property (strong, nonatomic) OCTClient *client;
@property (strong, nonatomic) RACSignal *request;
@end

@implementation OctoKitDemoTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    NSString *username = @"github";
    OCTUser *user = [OCTUser userWithLogin:username server:OCTServer.dotComServer];
    _client = [OCTClient unauthenticatedClientWithUser:user];
    _request = [_client fetchUserRepositories];

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

- (void)testMakingRequests
{
    RACSignal *request;
    request = [self makingRequests];
    XCTAssertNotNil(request, @"should not nil");
}

- (RACSignal *)makingRequests
{
    /*
     In order to begin interacting with the API, you must instantiate an OCTClient. There are two ways to create a client without authenticating:
     
     -initWithServer: is the most basic way to initialize a client. It accepts an OCTServer, which determines whether to connect to GitHub.com or a GitHub Enterprise instance.
     
     +unauthenticatedClientWithUser: is similar, but lets you set an active user, which is required for certain requests.
     
     We'll focus on the second method, since we can do more with it. Let's create a client that connects to GitHub.com:
     
     */
    
    NSString *username = @"github";
    OCTUser *user = [OCTUser userWithLogin:username server:OCTServer.dotComServer];
    OCTClient *client = [OCTClient unauthenticatedClientWithUser:user];

    // Prepares a request that will load all of the user's repositories, represented
    // by `OCTRepository` objects.
    //
    // Note that the request is not actually _sent_ until you use one of the
    // -subscribe… methods below.
    RACSignal *request = [client fetchUserRepositories];
    
    // However, you don't need a deep understanding of RAC to use OctoKit. There are just a few basic operations to be aware of.
    
    return request;
}

- (void)testReceivingResultsOneByOne
{
    __block BOOL waitingForBlock = YES;

    RACSignal *request = [self makingRequests];
    
    // It often makes sense to handle each result object independently, so you can spread any processing out instead of doing it all at once:
    
    
    // // This method actually kicks off the request, handling any results using the
    // blocks below.
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

- (void)testReceivingAllResultsAtOnce
{
    __block BOOL waitingForBlock = YES;

    NSString *username = @"github";
    OCTUser *user = [OCTUser userWithLogin:username server:OCTServer.dotComServer];
    OCTClient *client = [OCTClient unauthenticatedClientWithUser:user];
    RACSignal *request = [client fetchUserRepositories];
    
    // If you can't do anything until you have all of the results, you can "collect" them into a single array:
    
    [[request collect] subscribeNext:^(NSArray *repositories) {
        // Thanks to -collect, this block is invoked after the request completes,
        // with _all_ the results that were received.
        waitingForBlock = NO;
    } error:^(NSError *error) {
        // Invoked when an error occurs. You won't receive any results if this
        // happens.
        XCTFail(@"%s Error:%@", __PRETTY_FUNCTION__, error);
        waitingForBlock = NO;
    }];
    // Run the loop
    while(waitingForBlock) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
    }
}

- (void)testReceivingResultsOnTheMainThread
{
    __block BOOL waitingForBlock = YES;

    NSString *username = @"github";
    OCTUser *user = [OCTUser userWithLogin:username server:OCTServer.dotComServer];
    OCTClient *client = [OCTClient unauthenticatedClientWithUser:user];
    RACSignal *request = [client fetchUserRepositories];

    // The blocks in the above examples will be invoked in the background, to avoid slowing down the main thread. However, if you want to run UI code, you shouldn't do it in the background, so you must "deliver" results to the main thread instead:
        
    [[request deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(OCTRepository *repository) {
        // ...
    } error:^(NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Whoops!"
                                                        message:@"Something went wrong."
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:nil];
        [alert show];
        XCTFail(@"%s Error:%@", __PRETTY_FUNCTION__, error);
        waitingForBlock = NO;
    } completed:^{
//        [self.tableView reloadData];
        waitingForBlock = NO;
    }];
    // Run the loop
    while(waitingForBlock) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
    }
}

- (void)testCancellingRequest
{
    __block BOOL waitingForBlock = YES;

    // All of the -subscribe… methods actually return a RACDisposable object. Most of the time, you don't need it, but you can hold onto it if you want to cancel requests:
    RACDisposable *disposable = [[[[self.client fetchUserRepositories] collect] deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(NSArray *repositories) {

        NSLog(@"成功");
//        NSLog(@"成功:%@", repositories);
        waitingForBlock = NO;

    } error:^(NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Whoops!"
                                                        message:@"Something went wrong."
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:nil];
        [alert show];
        XCTFail(@"%s Error:%@", __PRETTY_FUNCTION__, error);
        waitingForBlock = NO;
    }];
    
    // Save the disposable into a `strong` property, so we can access it later.
    self.repositoriesDisposable = disposable;
    
    [self performSelector:@selector(cancel:) withObject:nil afterDelay:0.5];

    // Run the loop
    while(waitingForBlock) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
    }
}

- (void)cancel:(RACDisposable *)disposable
{
    NSLog(@"%s キャンセル", __PRETTY_FUNCTION__);

    // Cancels the request for repositories if it's still in progress. If the
    // request already terminated, nothing happens.
    [self.repositoriesDisposable dispose];
}

- (void)hoge
{
    // All of the -subscribe… methods actually return a RACDisposable object. Most of the time, you don't need it, but you can hold onto it if you want to cancel requests:
    
    RACSignal *signal = [[[self.client fetchUserStarredRepositories] collect] deliverOn:RACScheduler.mainThreadScheduler];
    RACDisposable *disposable = [signal subscribeNext:^(NSArray *repositories) {

        NSLog(@"成功:%@", repositories);
        
    } error:^(NSError *error) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Whoops!"
                                                        message:@"Something went wrong."
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:nil];
        [alert show];
        XCTFail(@"%s Error:%@", __PRETTY_FUNCTION__, error);
    }];

    // Save the disposable into a `strong` property, so we can access it later.
    self.repositoriesDisposable = disposable;
}
@end
