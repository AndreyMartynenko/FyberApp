//
//  JSONOfferService.m
//  FyberApp
//
//  Created by Andrey Martynenko on 8/1/15.
//  Copyright (c) 2015 GlobalLogic. All rights reserved.
//

#import "JSONOfferService.h"
#import "OfferResponse.h"
#import <AdSupport/ASIdentifierManager.h>
#import "NSString+NSHash.h"
#import "Constants.h"

#define APPID @"appid"
#define APPLE_IDFA @"apple_idfa"
#define APPLE_IDFA_TRACKING_ENABLED @"apple_idfa_tracking_enabled"
#define DEVICE_ID @"device_id"
#define FORMAT @"format"
#define IP @"ip"
#define LOCALE @"locale"
#define OFFER_TYPES @"offer_types"
#define TIMESTAMP @"timestamp"
#define UID @"uid"
#define HASH_KEY @"hashkey"

@implementation JSONOfferService

- (void)retrieveOffersSuccess:(SuccessObjectBlock)successBlock failure:(FailureBlock)failureBlock {
    [self request:PATH parameters:[self requestParametersWithHashKey] success:^(id responseObject) {
        OfferResponse *response = [[OfferResponse alloc] initWithDictionary:responseObject];
        successBlock(response);
        
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

- (NSDictionary *)requestParametersInfo {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"parameters" ofType:@"plist"];
    return [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
}

- (MutableOrderedDictionary *)requestParameters {
    NSDictionary *info = [self requestParametersInfo];
    
    MutableOrderedDictionary *parameters = [MutableOrderedDictionary dictionary];
    [parameters setObject:[info objectForKey:APPID] forKey:APPID];
    [parameters setObject:[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString] forKey:APPLE_IDFA];
    [parameters setObject:[NSNumber numberWithBool:[[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]] forKey:APPLE_IDFA_TRACKING_ENABLED];
    [parameters setObject:UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? @"tablet" : @"phone" forKey:DEVICE_ID];
    [parameters setObject:[info objectForKey:FORMAT] forKey:FORMAT];
    [parameters setObject:[info objectForKey:IP] forKey:IP];
    [parameters setObject:[info objectForKey:LOCALE] forKey:LOCALE];
    [parameters setObject:[info objectForKey:OFFER_TYPES] forKey:OFFER_TYPES];
    [parameters setObject:[NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]] forKey:TIMESTAMP];
    [parameters setObject:[info objectForKey:UID] forKey:UID];
    
    return parameters;
}

- (MutableOrderedDictionary *)requestParametersWithHashKey {
    MutableOrderedDictionary *parameters = [self requestParameters];
    
    NSMutableString *parametersToHash = [NSMutableString string];
    [parameters enumerateKeysAndObjectsWithIndexUsingBlock:^(id key, id obj, NSUInteger idx, BOOL *stop) {
        [parametersToHash appendString:[NSString stringWithFormat:@"%@=%@&", key, obj]];
    }];
    [parametersToHash appendString:API_KEY];
    
    NSString *hashKey = [parametersToHash SHA1];
    [parameters setObject:hashKey forKey:HASH_KEY];
    
    return parameters;
}

@end
