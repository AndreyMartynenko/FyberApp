//
//  OfferResponse.h
//  FyberApp
//
//  Created by Andrey Martynenko on 8/3/15.
//  Copyright (c) 2015 GlobalLogic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseObject.h"

@class Information;

@interface OfferResponse : BaseObject

@property (nonatomic, strong) NSString *code;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) Information *information;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSArray *offers;
@property (nonatomic, assign) NSInteger pages;

@end
