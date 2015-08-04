//
//  ServicesBlocks.h
//  FyberApp
//
//  Created by Andrey Martynenko on 8/1/15.
//  Copyright (c) 2015 GlobalLogic. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^RequestSuccessBlock)(id responseObject);
typedef void (^SuccessArrayBlock)(NSArray *results);
typedef void (^SuccessObjectBlock)(id object);
typedef void (^SuccessBlock)();
typedef void (^FailureBlock)(NSError* error);

