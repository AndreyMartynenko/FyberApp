//
//  XCTestCase+CommonUtils.m
//  FyberApp
//
//  Created by Andrey Martynenko on 8/3/15.
//  Copyright (c) 2015 GlobalLogic. All rights reserved.
//

#import "XCTestCase+CommonUtils.h"

#define ASYNC_TEST_TIMEOUT 10 // in seconds

@implementation XCTestCase (CommonUtils)

- (void)notifySuccess {
    [self notify:XCTAsyncTestCaseStatusSucceeded];
}

- (void)waitForSuccess {
    [self waitForStatus:XCTAsyncTestCaseStatusSucceeded timeout:ASYNC_TEST_TIMEOUT];
}

@end
