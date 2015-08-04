//
//  OfferCell.m
//  FyberApp
//
//  Created by Andrey Martynenko on 8/3/15.
//  Copyright (c) 2015 GlobalLogic. All rights reserved.
//

#import "OfferCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "OfferThumbnail.h"

@interface OfferCell ()

@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *teaserLabel;
@property (weak, nonatomic) IBOutlet UILabel *payoutLabel;

@end

@implementation OfferCell

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.thumbnailImageView.image = nil;
}

- (void)setContent:(Offer *)offer {
    [self.thumbnailImageView setImageWithURL:[[NSURL alloc] initWithString:offer.thumbnail.hiRes]];
    self.titleLabel.text = offer.title;
    self.teaserLabel.text = offer.teaser;
    self.payoutLabel.text = [NSString stringWithFormat:@"Payout: %ld", (long)offer.payout];
}

@end
