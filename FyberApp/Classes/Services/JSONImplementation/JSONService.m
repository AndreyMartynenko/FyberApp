//
//  JSONService.m
//  FyberApp
//
//  Created by Andrey Martynenko on 8/1/15.
//  Copyright (c) 2015 GlobalLogic. All rights reserved.
//

#import "JSONService.h"
#import "ServicesHub.h"
#import "NSString+NSHash.h"
#import "Constants.h"

#define DEV_SERVER_STAGING @"http://api.sponsorpay.com/"
#define SIGNATURE_HEADER @"X-Sponsorpay-Response-Signature"

@interface JSONService()

@end

@implementation JSONService

+ (NSURL *)baseServiceURL {
    return [[NSURL alloc] initWithString:DEV_SERVER_STAGING];
}

+ (AFHTTPRequestSerializer<AFURLRequestSerialization> *)requestSerializer {
    AFHTTPRequestSerializer<AFURLRequestSerialization> *requestSerializer = [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-type"];

    return requestSerializer;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupSessionManager];
    }
    
    return self;
}

- (void)sslPinning:(AFHTTPSessionManager *)sessionManager {
    self.sessionManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    self.sessionManager.securityPolicy.allowInvalidCertificates = YES;
}

- (void)setupSessionManager {
    self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[[self class] baseServiceURL]];
    [self.sessionManager setRequestSerializer:[[self class] requestSerializer]];
    [self.sessionManager setResponseSerializer:[[JSONResponseSerializerWithData alloc] init]];
    
    self.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", nil];
    self.sessionManager.session.configuration.timeoutIntervalForRequest = 10.0f;
    
    // https
//    [self sslPinning:self.sessionManager];
}

- (void)request:(NSString *)path parameters:(NSDictionary *)parameters success:(RequestSuccessBlock)successBlock failure:(FailureBlock)failureBlock {
    if (self.sessionManager.baseURL == nil)
        [self setupSessionManager];
    
    [self.sessionManager GET:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSString *signature = @"";
        if ([task.response isKindOfClass:[NSHTTPURLResponse class]]) {
            NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
            signature = [[response allHeaderFields] objectForKey:SIGNATURE_HEADER];
        }
        
        if ([self hasErrorWithInfo:responseObject signature:signature failure:failureBlock]) {
            NSError *error = [NSError errorWithDomain:@"ResponseDomain"
                                                 code:-101
                                             userInfo:@{NSLocalizedDescriptionKey:NSLocalizedString(@"Wrong signature.", nil)}];
            
            failureBlock(error);
        }
        else {
            successBlock(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failureBlock(error);
    }];
}

- (BOOL)hasErrorWithInfo:(id)info signature:(id)signature failure:(FailureBlock)failureBlock {
    /*
    Signed Response
    To ensure the integrity and validity of the response, we are adding a special security parameter to the HTTP response header. It is called X-Sponsorpay-Response-Signature and created by using rules very similar to those for the request signature. A l though the use of this parameter is optional, it is strongly recommended to evaluate it on your side to prevent anyone from tampering any responses sent to you.
        
        Rules
        Concatenate the full response body with your API key
        Hash the whole resulting string using SHA1
     */
    
    /*
     Please advice me here, because no matter how I'm concatenating response body with API key, I never get hash value equal to response signature.
     Should it be: firstKey=firstValue&..lastKey=lastValue&API_KEY, [RESPONSE]&API_KEY, etc. ?
     */
    
    /*
    NSString *responseToHash = [NSString stringWithFormat:@"%@&%@", info, API_KEY];
    if ([[responseToHash SHA1] isEqualToString:signature])
        return NO;
    else
        return YES;
     */
    
    return NO;
}

@end

@implementation JSONResponseSerializerWithData

- (id)responseObjectForResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError *__autoreleasing *)error {
    if (![self validateResponse:(NSHTTPURLResponse *)response data:data error:error]) {
        if (*error != nil) {
            NSMutableDictionary *userInfo = [(*error).userInfo mutableCopy];
            NSError *jsonError = nil;
            NSDictionary *errors = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
            if (jsonError) {
                userInfo[JSONResponseSerializerWithDataKey] = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSError *newError = [NSError errorWithDomain:(*error).domain code:(*error).code userInfo:userInfo];
                (*error) = newError;
            }
            else {
                userInfo[JSONResponseSerializerWithDataKey] = errors;
                NSError *newError = [NSError errorWithDomain:(*error).domain code:(*error).code userInfo:userInfo];
                (*error) = newError;
            }
        }
        
        return (nil);
    }
    
    return ([super responseObjectForResponse:response data:data error:error]);
}

@end
