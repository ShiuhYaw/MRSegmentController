//
//  ViewController.m
//  MRTitleRoonViewController
//
//  Created by Yaw on 17/4/17.
//  Copyright © 2017 Yaw. All rights reserved.
//

#import "ViewController.h"
#import "MRTitleRoomViewController/MRTitleRoomHeaderViewController.h"
#import "MRTitleRoomViewController/MRTitleHistorySegmentViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)push:(UIButton *)sender {
    
    MRTitleRoomHeaderViewController *titleRoomHeaderViewController = [[MRTitleRoomHeaderViewController alloc]init];
    [self.navigationController pushViewController:titleRoomHeaderViewController animated:YES];
}

- (IBAction)pushToAwards:(UIButton *)sender {
    
    MRTitleHistorySegmentViewController *titleHistorySegmentViewController = [[MRTitleHistorySegmentViewController alloc]init];
    [self.navigationController pushViewController:titleHistorySegmentViewController animated:YES];
}

- (IBAction)pushToTitles:(UIButton *)sender {
    
    MRTitleHistorySegmentViewController *titleHistorySegmentViewController = [[MRTitleHistorySegmentViewController alloc]init];
    [self.navigationController pushViewController:titleHistorySegmentViewController animated:YES];
}

@end
