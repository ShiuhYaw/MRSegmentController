//
//  MRTitleHistorySegmentViewController.m
//  MRTitleRoonViewController
//
//  Created by Yaw on 17/4/17.
//  Copyright © 2017 Yaw. All rights reserved.
//

#import "MRTitleHistorySegmentViewController.h"
#import "MRTitleTableViewController.h"
#import "MRAwardTableViewController.h"
#import "constants.h"

@interface MRTitleHistorySegmentViewController ()

@end

@implementation MRTitleHistorySegmentViewController

- (instancetype)init {
    
    MRTitleTableViewController *titleTableViewController = [[MRTitleTableViewController alloc] initWithNibName:NSStringFromClass([MRTitleTableViewController class]) bundle:nil];
    MRAwardTableViewController *awardTableViewController = [[MRAwardTableViewController alloc] initWithNibName:NSStringFromClass([MRAwardTableViewController class]) bundle:nil];

    self = [super initWithControllers:titleTableViewController, awardTableViewController, nil];
    if (self) {
        self.segmentMiniTopInset = kNavigationHeight;
        self.headerHeight = kNavigationHeight;
        self.freezenHeaderWhenReachMaxHeaderheight = YES;
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Title History", @"Title History");
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
