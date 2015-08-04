//
//  OfferTimeToPayout.h
//  FyberApp
//
//  Created by Andrey Martynenko on 8/3/15.
//  Copyright (c) 2015 GlobalLogic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseObject.h"

@interface OfferTimeToPayout : BaseObject

@property (nonatomic, assign) NSInteger amount;
@property (nonatomic, strong) NSString *readable;

@end
