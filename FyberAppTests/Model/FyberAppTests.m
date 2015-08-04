//
//  FyberAppTests.m
//  FyberAppTests
//
//  Created by Andrey Martynenko on 8/3/15.
//  Copyright (c) 2015 GlobalLogic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "XCTestCase+AsyncTesting.h"

#import "JSONOfferService.h"
#import "OfferResponse.h"
#import "Information.h"

#define ASYNC_TEST_TIMEOUT 10 // in seconds

@interface FyberAppTests : XCTestCase

@end

@implementation FyberAppTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testServerConnectionSuccessful {
    JSONService *service = [JSONService new];
    JSONOfferService *offerService = [JSONOfferService new];
    
    [service request:PATH parameters:offerService.requestParametersWithHashKey success:^(id responseObject) {
        OfferResponse *response = [[OfferResponse alloc] initWithDictionary:responseObject];
        
        XCTAssertEqualObjects(response.code, @"OK");
        XCTAssertEqualObjects([NSNumber numberWithInteger:response.information.appIdentifier], @(2070));
        
        [self notify:XCTAsyncTestCaseStatusSucceeded];
        
    } failure:^(NSError *error) {
        
    }];
    
    [self waitForStatus:XCTAsyncTestCaseStatusSucceeded timeout:ASYNC_TEST_TIMEOUT];
}

- (void)testServerConnectionErrorInHashKey {
    JSONService *service = [JSONService new];
    JSONOfferService *offerService = [JSONOfferService new];
    
    [service request:PATH parameters:offerService.requestParameters success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        XCTAssertEqualObjects(error.localizedDescription, @"Request failed: unauthorized (401)");
        [self notify:XCTAsyncTestCaseStatusFailed];
    }];
    
    [self waitForStatus:XCTAsyncTestCaseStatusFailed timeout:ASYNC_TEST_TIMEOUT];
}

@end
