//
//  Offer.m
//  FyberApp
//
//  Created by Andrey Martynenko on 8/1/15.
//  Copyright (c) 2015 GlobalLogic. All rights reserved.
//

#import "Offer.h"
#import "OfferType.h"
#import "OfferThumbnail.h"
#import "OfferTimeToPayout.h"

@implementation Offer

- (void)updateFromDictionary:(NSDictionary *)dictionary {
    [super updateFromDictionary:dictionary];
    
    if (dictionary[@"link"])
        [self setLink:dictionary[@"link"]];
    if (dictionary[@"offer_id"])
        [self setIdentifier:[dictionary[@"offer_id"] integerValue]];
    
    if (dictionary[@"offer_types"]) {
        [self setTypes:dictionary[@"offer_types"]];
        
        NSMutableArray *types = [NSMutableArray array];
        for (NSDictionary *dictionary in self.types)
            [types addObject:[[OfferType alloc] initWithDictionary:dictionary]];
        [self setTypes:[NSArray arrayWithArray:types]];
    }
    
    if (dictionary[@"payout"])
        [self setPayout:[dictionary[@"payout"] integerValue]];
    if (dictionary[@"required_actions"])
        [self setRequiredActions:dictionary[@"required_actions"]];
    if (dictionary[@"store_id"])
        [self setStoreIdentifier:dictionary[@"store_id"]];
    if (dictionary[@"teaser"])
        [self setTeaser:dictionary[@"teaser"]];
    if (dictionary[@"thumbnail"])
        [self setThumbnail:[[OfferThumbnail alloc] initWithDictionary:dictionary[@"thumbnail"]]];
    if (dictionary[@"time_to_payout"])
        [self setTimeToPayout:[[OfferTimeToPayout alloc] initWithDictionary:dictionary[@"time_to_payout"]]];
    if (dictionary[@"title"])
        [self setTitle:dictionary[@"title"]];
}

@end
