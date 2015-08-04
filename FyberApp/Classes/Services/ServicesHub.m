//
//  ServicesHub.m
//  FyberApp
//
//  Created by Andrey Martynenko on 8/1/15.
//  Copyright (c) 2015 GlobalLogic. All rights reserved.
//

#import "ServicesHub.h"

#import "JSONOfferService.h"

@interface ServicesHub()

@property (nonatomic, strong) NSObject <OfferService> *offerService;

@end

@implementation ServicesHub

static ServicesHub *sharedInstance;

+ (void)initialize {
    if (sharedInstance == nil) {
        sharedInstance = [[ServicesHub alloc] init];
        
        sharedInstance.offerService = [JSONOfferService new];
    }
}

+ (ServicesHub *)sharedInstance {
    return sharedInstance;
}

@end
