//
//  OfferService.h
//  FyberApp
//
//  Created by Andrey Martynenko on 8/1/15.
//  Copyright (c) 2015 GlobalLogic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServicesBlocks.h"

@protocol OfferService <NSObject>

- (void)retrieveOffersSuccess:(SuccessObjectBlock)successBlock failure:(FailureBlock)failureBlock;

@end
