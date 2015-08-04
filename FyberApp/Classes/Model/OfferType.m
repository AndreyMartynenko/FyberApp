//
//  OfferType.m
//  FyberApp
//
//  Created by Andrey Martynenko on 8/3/15.
//  Copyright (c) 2015 GlobalLogic. All rights reserved.
//

#import "OfferType.h"

@implementation OfferType

- (void)updateFromDictionary:(NSDictionary *)dictionary {
    [super updateFromDictionary:dictionary];
    
    if (dictionary[@"offer_type_id"])
        [self setIdentifier:[dictionary[@"offer_type_id"] integerValue]];
    if (dictionary[@"readable"])
        [self setReadable:dictionary[@"readable"]];
}

@end
