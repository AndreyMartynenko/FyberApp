//
//  Offer.h
//  FyberApp
//
//  Created by Andrey Martynenko on 8/1/15.
//  Copyright (c) 2015 GlobalLogic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseObject.h"

@class OfferType;
@class OfferThumbnail;
@class OfferTimeToPayout;

@interface Offer : BaseObject

@property (nonatomic, strong) NSString *link;
@property (nonatomic, strong) NSArray *types;
@property (nonatomic, assign) NSInteger payout;
@property (nonatomic, strong) NSString *requiredActions;
@property (nonatomic, strong) NSString *storeIdentifier;
@property (nonatomic, strong) NSString *teaser;
@property (nonatomic, strong) OfferThumbnail *thumbnail;
@property (nonatomic, strong) OfferTimeToPayout *timeToPayout;
@property (nonatomic, strong) NSString *title;

@end
