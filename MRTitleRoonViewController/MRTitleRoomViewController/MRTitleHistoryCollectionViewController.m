//
//  MRTitleHistoryCollectionViewController.m
//  MRTitleRoonViewController
//
//  Created by Yaw on 18/4/17.
//  Copyright © 2017 Yaw. All rights reserved.
//

#import "MRTitleHistoryCollectionViewController.h"
#import "MRTitleHistoryCollectionViewCell.h"
#import "MRTitleHistoryCollectionReusableView.h"

@interface MRTitleHistoryCollectionViewController ()

@property (nonatomic,assign) CGFloat cellPadding;
@property (nonatomic,assign) CGFloat sRate;
@property (nonatomic,assign) CGFloat cellWidth;
@property (nonatomic,assign) CGFloat cellHight;

@end

@implementation MRTitleHistoryCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
     self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MRTitleHistoryCollectionViewCell class]) bundle:nil]
          forCellWithReuseIdentifier:NSStringFromClass([MRTitleHistoryCollectionViewCell class])];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MRTitleHistoryCollectionReusableView class]) bundle:nil]
          forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                 withReuseIdentifier:NSStringFromClass([MRTitleHistoryCollectionReusableView class])];
    CGFloat screen = [UIScreen mainScreen].bounds.size.width;
    self.cellWidth = screen / 2;
    self.cellHight = 81;
    self.cellPadding = (screen - self.cellWidth * 2 - 3)/3.0;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
        CGFloat screen = [UIScreen mainScreen].bounds.size.width;
        self.cellWidth = screen / 2;
        self.cellHight = 81;
        self.cellPadding = (screen - self.cellWidth * 2 - 3)/3.0;
        [self.collectionView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <MRSegmentControllerDelegate>

-(NSString *)segmentTitle {
    
    return NSLocalizedString(@"Title History", @"Title History");
}

-(UIScrollView *)streachScrollView {
    
    return self.collectionView;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MRTitleHistoryCollectionViewCell class]) forIndexPath:indexPath];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        
        MRTitleHistoryCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([MRTitleHistoryCollectionReusableView class]) forIndexPath:indexPath];
        reusableView = headerView;
    }
    return  reusableView;
}

#pragma mark <UICollectionViewDelegate>

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
    
    CGSize bsize = CGSizeMake(self.cellWidth, self.cellHight);
    return bsize;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0.0f;
}

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGSize bsize = CGSizeMake(screenWidth, 0);
    return bsize;
}


@end
