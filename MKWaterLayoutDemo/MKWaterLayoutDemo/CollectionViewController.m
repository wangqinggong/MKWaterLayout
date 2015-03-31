//
//  CollectionViewController.m
//  MKWaterLayoutDemo
//
//  Created by wangqinggong on 15/4/1.
//  Copyright (c) 2015年 Michael King. All rights reserved.
//

#import "CollectionViewController.h"
#import "MKWaterFlowLayout.h"

@interface CollectionViewController () <MKWaterFlowLayoutDelegate>

@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"waterCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置布局
    [self setupLayout];
}

- (void)setupLayout
{
    MKWaterFlowLayout * layout = [[MKWaterFlowLayout alloc] init];
    layout.delegate = self;
    self.collectionView.collectionViewLayout = layout;
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor orangeColor];
    
    return cell;
}

#pragma mark <MKWaterFlowLayoutDelegate>
// 返回图片的宽高比
- (CGFloat)waterFlowLayout:(MKWaterFlowLayout *)waterFlowLayout widthHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat imgW = 20;
    CGFloat imgH = arc4random_uniform(50);
    return imgW / imgH;
}
- (NSUInteger)columnCountInWaterFlowLayout:(MKWaterFlowLayout *)waterFlowLayout
{
    return 3;
}


@end
