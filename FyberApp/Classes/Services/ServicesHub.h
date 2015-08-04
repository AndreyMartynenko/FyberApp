//
//  ServicesHub.h
//  FyberApp
//
//  Created by Andrey Martynenko on 8/1/15.
//  Copyright (c) 2015 GlobalLogic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OfferService.h"

@interface ServicesHub : NSObject

+ (ServicesHub *)sharedInstance;

- (NSObject <OfferService> *)offerService;

@end
