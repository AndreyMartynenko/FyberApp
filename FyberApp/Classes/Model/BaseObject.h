//
//  BaseObject.h
//  FyberApp
//
//  Created by Andrey Martynenko on 8/1/15.
//  Copyright (c) 2015 GlobalLogic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseObject : NSObject

@property (nonatomic, assign) NSInteger identifier;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (void)updateFromDictionary:(NSDictionary *)dictionary;

@end
