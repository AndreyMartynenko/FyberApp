//
//  JSONOfferService.h
//  FyberApp
//
//  Created by Andrey Martynenko on 8/1/15.
//  Copyright (c) 2015 GlobalLogic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONService.h"
#import "OfferService.h"
#import "OrderedDictionary.h"

#define PATH @"feed/v1/offers.json"

@interface JSONOfferService : JSONService <OfferService>

// For tests
- (MutableOrderedDictionary *)requestParameters;
- (MutableOrderedDictionary *)requestParametersWithHashKey;

@end
