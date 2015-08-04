//
//  OfferResponse.m
//  FyberApp
//
//  Created by Andrey Martynenko on 8/3/15.
//  Copyright (c) 2015 GlobalLogic. All rights reserved.
//

#import "OfferResponse.h"
#import "Information.h"
#import "Offer.h"

@implementation OfferResponse

- (void)updateFromDictionary:(NSDictionary *)dictionary {
    [super updateFromDictionary:dictionary];
    
    if (dictionary[@"code"])
        [self setCode:dictionary[@"code"]];
    if (dictionary[@"count"])
        [self setCount:[dictionary[@"count"] integerValue]];
    if (dictionary[@"information"])
        [self setInformation:[[Information alloc] initWithDictionary:dictionary[@"information"]]];
    if (dictionary[@"message"])
        [self setMessage:dictionary[@"message"]];
    
    if (dictionary[@"offers"]) {
        [self setOffers:dictionary[@"offers"]];
        
        NSMutableArray *offers = [NSMutableArray array];
        for (NSDictionary *dictionary in self.offers)
            [offers addObject:[[Offer alloc] initWithDictionary:dictionary]];
        [self setOffers:[NSArray arrayWithArray:offers]];
    }
    
    if (dictionary[@"pages"])
        [self setPages:[dictionary[@"pages"] integerValue]];
}

@end
