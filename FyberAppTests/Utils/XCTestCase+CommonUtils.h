//
//  XCTestCase+CommonUtils.h
//  FyberApp
//
//  Created by Andrey Martynenko on 8/3/15.
//  Copyright (c) 2015 GlobalLogic. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "XCTestCase+AsyncTesting.h"

@interface XCTestCase (CommonUtils)

- (void)notifySuccess;
- (void)waitForSuccess;

@end
