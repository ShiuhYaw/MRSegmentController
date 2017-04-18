//
//  MRTitleRoomCollectionViewController.m
//  MRTitleRoonViewController
//
//  Created by Yaw on 17/4/17.
//  Copyright © 2017 Yaw. All rights reserved.
//
#import "MRTitleRoomCollectionViewController.h"
#import "MRTitleCollectionViewCell.h"
#import "MRTitleRoomCollectionViewCell.h"
#import "MRTitleBottomButtonCollectionViewCell.h"

@interface MRTitleRoomCollectionViewController ()

@property (nonatomic,assign) CGFloat cellPadding;
@property (nonatomic,assign) CGFloat sRate;
@property (nonatomic,assign) CGFloat cellWidth;
@property (nonatomic,assign) CGFloat cellHight;

@end

@implementation MRTitleRoomCollectionViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MRTitleCollectionViewCell class]) bundle:nil]
          forCellWithReuseIdentifier:NSStringFromClass([MRTitleCollectionViewCell class])];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MRTitleRoomCollectionViewCell class]) bundle:nil]
          forCellWithReuseIdentifier:NSStringFromClass([MRTitleRoomCollectionViewCell class])];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MRTitleBottomButtonCollectionViewCell class]) bundle:nil]
          forCellWithReuseIdentifier:NSStringFromClass([MRTitleBottomButtonCollectionViewCell class])];
    CGFloat screen = [UIScreen mainScreen].bounds.size.width;
    self.sRate = screen / 375.0 ;
    self.cellWidth = 150 * self.sRate;
    self.cellHight = 120 * self.sRate;
    self.cellPadding = (screen - self.cellWidth * 2 - 3)/3.0;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        

    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
        CGFloat screen = [UIScreen mainScreen].bounds.size.width;
        self.sRate = screen / 375.0 ;
        self.cellWidth = 150 * self.sRate;
        self.cellHight = 120 * self.sRate;
        self.cellPadding = (screen - self.cellWidth * 2 - 3)/3.0;
        [self.collectionView reloadData];
    }];
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

#pragma mark - <MRSegmentControllerDelegate>

-(NSString *)segmentTitle {
    
    return NSLocalizedString(@"ahyaw's Title Room", @"ahyaw's Title Room");
}

-(UIScrollView *)streachScrollView {
    
    return self.collectionView;
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 10;
            break;
        case 2:
            return 1;
            break;
        default:
            break;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MRTitleRoomCollectionViewCell class]) forIndexPath:indexPath];
    switch (indexPath.section) {
        case 0:
        {
            UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MRTitleRoomCollectionViewCell class]) forIndexPath:indexPath];
            cell.backgroundColor = [UIColor whiteColor];
            return cell;
        }
            break;
        case 1: {
            UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MRTitleCollectionViewCell class]) forIndexPath:indexPath];
            cell.backgroundColor = [UIColor whiteColor];
            cell.layer.borderColor = [UIColor colorWithRed:(226/255.0f) green:(226/255.0f) blue:(226/255.0f) alpha:1.0].CGColor;
            cell.layer.borderWidth = 0.5;
            cell.layer.cornerRadius = 5;
            return cell;
        }
            break;
        case 2: {
            UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MRTitleBottomButtonCollectionViewCell class]) forIndexPath:indexPath];
            cell.backgroundColor = [UIColor whiteColor];
            return cell;
        }
            break;
        default:
            break;
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.layer.borderColor = [UIColor colorWithRed:(226/255.0f) green:(226/255.0f) blue:(226/255.0f) alpha:1.0].CGColor;
    cell.layer.borderWidth = 0.5;
    cell.layer.cornerRadius = 5;
    return cell;
}

#pragma mark - <UICollectionViewDelegate>

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
 }
 */

#pragma mark - <UICollectionViewLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0: {
            CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
            CGSize bsize = CGSizeMake(screenWidth - (self.cellPadding * 2), 35);
            return bsize;
        }
            break;
        case 1: {
            CGSize bsize = CGSizeMake(self.cellWidth, self.cellHight);
            return bsize;
        }
            break;
        case 2: {
            CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
            CGSize bsize = CGSizeMake(screenWidth - (self.cellPadding * 2), 82);
            return bsize;
        }
            break;
        default:
            break;
    }
    return CGSizeZero;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    switch (section) {
        case 0:
            return UIEdgeInsetsMake(0, self.cellPadding, 0, self.cellPadding);
            break;
        case 1:
            return UIEdgeInsetsMake(self.cellPadding/2, self.cellPadding, self.cellPadding/2, self.cellPadding);
            break;
        case 2:
            return UIEdgeInsetsMake(0, self.cellPadding, 0, self.cellPadding);
            break;
        default:
            break;
    }
    return UIEdgeInsetsZero;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return self.cellPadding;
}

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGSize bsize = CGSizeMake(screenWidth, 0);
    return bsize;
}


@end
