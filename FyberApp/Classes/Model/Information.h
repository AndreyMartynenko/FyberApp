//
//  Information.h
//  FyberApp
//
//  Created by Andrey Martynenko on 8/3/15.
//  Copyright (c) 2015 GlobalLogic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseObject.h"

@interface Information : BaseObject

@property (nonatomic, strong) NSString *appName;
@property (nonatomic, assign) NSInteger appIdentifier;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *language;
@property (nonatomic, strong) NSString *supportUrl;
@property (nonatomic, strong) NSString *virtualCurrency;

@end
