//
//  MRTitleTableViewController.m
//  MRTitleRoonViewController
//
//  Created by Yaw on 17/4/17.
//  Copyright © 2017 Yaw. All rights reserved.
//

#import "MRTitleTableViewController.h"
#import "MRTitleHistoryTableViewCell.h"

@interface MRTitleTableViewController ()

@end

@implementation MRTitleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MRTitleHistoryTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MRTitleHistoryTableViewCell class])];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <MRSegmentControllerDelegate>

-(NSString *)segmentTitle {
    
    return NSLocalizedString(@"Title", @"Title");
}

-(UIScrollView *)streachScrollView {
    
    return self.tableView;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MRTitleHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MRTitleHistoryTableViewCell class]) forIndexPath:indexPath];
    return cell;
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 92;
}

@end
