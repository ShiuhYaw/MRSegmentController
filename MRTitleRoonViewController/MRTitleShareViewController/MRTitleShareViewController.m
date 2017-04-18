//
//  MRTitleShareViewController.m
//  MRTitleRoonViewController
//
//  Created by Yaw on 18/4/17.
//  Copyright © 2017 Yaw. All rights reserved.
//

#import "MRTitleShareViewController.h"

@interface MRTitleShareViewController ()

@property (weak, nonatomic) IBOutlet UIView *shareView;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *aheadLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userIDLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;

@end

@implementation MRTitleShareViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.shareView.layer.cornerRadius = 11.0f;
    self.profileImageView.hidden = true;
    self.shareView.hidden = true;
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self popShareView];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    self.profileImageView.hidden = false;
    self.profileImageView.layer.cornerRadius = self.profileImageView.bounds.size.width / 2;
    [self.activityIndicatorView stopAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissButtonDidTapped:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:NO completion:nil];
}


- (void)popShareView {
    
    self.shareView.hidden = false;
    self.shareView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.shareView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished){
    }];
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
