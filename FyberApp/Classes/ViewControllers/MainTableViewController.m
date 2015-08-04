//
//  MainTableViewController.m
//  FyberApp
//
//  Created by Andrey Martynenko on 8/3/15.
//  Copyright (c) 2015 GlobalLogic. All rights reserved.
//

#import "MainTableViewController.h"
#import "ServicesHub.h"
#import "OfferResponse.h"
#import "Offer.h"
#import "OfferCell.h"

static NSString * const OfferCellIdentifier = @"OfferCell";
static NSString * const NoOffersCellIdentifier = @"NoOffersCell";

@interface MainTableViewController ()

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
    
    // Add refresh control
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    refreshControl.backgroundColor = [UIColor lightGrayColor];
    refreshControl.tintColor = [UIColor whiteColor];
    [refreshControl addTarget:self action:@selector(updateData) forControlEvents:UIControlEventValueChanged];
    
    self.refreshControl = refreshControl;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // Set title to refresh control
    NSString *title = @"Fetching coupons...";
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                forKey:NSForegroundColorAttributeName];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
    
    // Update table view's content
    [self.refreshControl beginRefreshing];
    [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentOffset.y - self.refreshControl.frame.size.height) animated:YES];
    
    [self updateData];
}

- (void)updateData {
    [[ServicesHub sharedInstance].offerService retrieveOffersSuccess:^(id object) {
        NSLog(@"__success");
        
        OfferResponse *response = (OfferResponse *)object;
        self.dataSource = response.offers;
        [self.tableView reloadData];
        [self updateRefreshControlWithTimestamp];
        
    } failure:^(NSError *error) {
        NSLog(@"__failure");
        
        self.dataSource = [NSArray arrayWithObject:[NSObject new]];
        [self.tableView reloadData];
        [self updateRefreshControlWithTimestamp];
    }];
}

#pragma mark - UIRefreshControl

- (void)updateRefreshControlWithTitle:(NSString *)title {
    if (self.refreshControl) {
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                    forKey:NSForegroundColorAttributeName];
        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        
        [self.refreshControl endRefreshing];
    }
}

- (void)updateRefreshControlWithTimestamp {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"MMM d, h:mm a"];
    [self updateRefreshControlWithTitle:[NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]]];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell new];
    
    if ([[[self.dataSource objectAtIndex:0] class] isSubclassOfClass:[Offer class]]) {
        cell = [tableView dequeueReusableCellWithIdentifier:OfferCellIdentifier forIndexPath:indexPath];
        [(OfferCell *)cell setContent:[self.dataSource objectAtIndex:indexPath.row]];
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:NoOffersCellIdentifier forIndexPath:indexPath];
    }
    
    return cell;
}

@end
