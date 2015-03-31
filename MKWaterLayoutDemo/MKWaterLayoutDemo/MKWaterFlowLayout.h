//
//  MKWaterFlowLayout.h
//  01-瀑布流界面搭建
//
//  Created by wangqinggong on 15/3/31.
//  Copyright (c) 2015年 Michael King. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MKWaterFlowLayout;

@protocol MKWaterFlowLayoutDelegate <NSObject>

    @required
        // 要求返回的是宽高比
        - (CGFloat)waterFlowLayout:(MKWaterFlowLayout *)waterFlowLayout widthHeightForRowAtIndexPath:(NSIndexPath *)indexPath;

    @optional
        - (NSUInteger)columnCountInWaterFlowLayout:(MKWaterFlowLayout *)waterFlowLayout;
        - (CGFloat)columnMarginInWaterFlowLayout:(MKWaterFlowLayout *)waterFlowLayout;
        - (CGFloat)rowMarginInWaterFlowLayout:(MKWaterFlowLayout *)waterFlowLayout;
        - (UIEdgeInsets)edgeInsetsInWaterFlowLayout:(MKWaterFlowLayout *)waterFlowLayout;

@end

@interface MKWaterFlowLayout : UICollectionViewLayout

@property (nonatomic,weak) id<MKWaterFlowLayoutDelegate> delegate;
@end
