//
//  JSONService.h
//  FyberApp
//
//  Created by Andrey Martynenko on 8/1/15.
//  Copyright (c) 2015 GlobalLogic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import "ServicesBlocks.h"

@interface JSONService : NSObject

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

+ (NSURL *)baseServiceURL;
+ (AFHTTPRequestSerializer <AFURLRequestSerialization> *)requestSerializer;

- (void)request:(NSString *)path parameters:(NSDictionary *)parameters success:(RequestSuccessBlock)successBlock failure:(FailureBlock)failureBlock;

@end

// NSError userInfo key that will contain response data
static NSString * const JSONResponseSerializerWithDataKey = @"JSONError";

@interface JSONResponseSerializerWithData : AFJSONResponseSerializer

@end
