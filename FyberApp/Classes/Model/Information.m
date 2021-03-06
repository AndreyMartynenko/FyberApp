//
//  Information.m
//  FyberApp
//
//  Created by Andrey Martynenko on 8/3/15.
//  Copyright (c) 2015 GlobalLogic. All rights reserved.
//

#import "Information.h"

@implementation Information

- (void)updateFromDictionary:(NSDictionary *)dictionary {
    [super updateFromDictionary:dictionary];
    
    if (dictionary[@"app_name"])
        [self setAppName:dictionary[@"app_name"]];
    if (dictionary[@"appid"])
        [self setAppIdentifier:[dictionary[@"appid"] integerValue]];
    if (dictionary[@"country"])
        [self setCountry:dictionary[@"country"]];
    if (dictionary[@"language"])
        [self setLanguage:dictionary[@"language"]];
    if (dictionary[@"support_url"])
        [self setSupportUrl:dictionary[@"support_url"]];
    if (dictionary[@"virtual_currency"])
        [self setVirtualCurrency:dictionary[@"virtual_currency"]];
}

@end
