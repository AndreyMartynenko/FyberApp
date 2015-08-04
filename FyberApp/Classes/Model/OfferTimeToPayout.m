//
//  OfferTimeToPayout.m
//  FyberApp
//
//  Created by Andrey Martynenko on 8/3/15.
//  Copyright (c) 2015 GlobalLogic. All rights reserved.
//

#import "OfferTimeToPayout.h"

@implementation OfferTimeToPayout

- (void)updateFromDictionary:(NSDictionary *)dictionary {
    [super updateFromDictionary:dictionary];
    
    if (dictionary[@"amount"])
        [self setAmount:[dictionary[@"amount"] integerValue]];
    if (dictionary[@"readable"])
        [self setReadable:dictionary[@"readable"]];
}

@end
