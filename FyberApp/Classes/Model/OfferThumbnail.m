//
//  OfferThumbnail.m
//  FyberApp
//
//  Created by Andrey Martynenko on 8/3/15.
//  Copyright (c) 2015 GlobalLogic. All rights reserved.
//

#import "OfferThumbnail.h"

@implementation OfferThumbnail

- (void)updateFromDictionary:(NSDictionary *)dictionary {
    [super updateFromDictionary:dictionary];
    
    if (dictionary[@"hires"])
        [self setHiRes:dictionary[@"hires"]];
    if (dictionary[@"lowres"])
        [self setLowRes:dictionary[@"lowres"]];
}

@end
