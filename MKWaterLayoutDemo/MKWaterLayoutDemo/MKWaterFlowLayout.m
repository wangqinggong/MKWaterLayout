//
//  MKWaterFlowLayout.m
//  01-瀑布流界面搭建
//
//  Created by wangqinggong on 15/3/31.
//  Copyright (c) 2015年 Michael King. All rights reserved.
//

#import "MKWaterFlowLayout.h"

#define MKCollectionW self.collectionView.frame.size.width

// 默认行间距
static const CGFloat MKDefaultRowMargin = 10;
// 默认列间距
static const CGFloat MKDefaultcolumnMargin = 10;
// 默认边距
static const UIEdgeInsets MKDefaultEdgeInsets = {10,10,10,10};
// 默认列数
static const CGFloat MKDefaultColumnCount = 3;

@interface MKWaterFlowLayout ()
/**
 *  存放每列的最大Y值
 */
@property (nonatomic,strong) NSMutableArray * maxYs;
/**
 *  存放cell的布局属性
 */
@property (nonatomic,strong) NSMutableArray * attrsArray;

@end

@implementation MKWaterFlowLayout

/**
 * 数组的懒加载
 *
 *  @return 可变数组
 */
- (NSMutableArray *)maxYs
{
    if (_maxYs == nil) {
        _maxYs = [[NSMutableArray alloc] init];
    }
    return _maxYs;
}

- (NSMutableArray *)attrsArray{

    if (_attrsArray == nil) {
        _attrsArray = [[NSMutableArray alloc] init];
    }
    return _attrsArray;
}


#pragma mark - 内部方法
- (CGSize)collectionViewContentSize
{
    // 计算最大的那列的y值
    CGFloat destiY = [self.maxYs[0] doubleValue];
    for(NSInteger i = 1;i < [self columnCount];i++){
        if (destiY < [self.maxYs[i] doubleValue]) {
            destiY = [self.maxYs[i] doubleValue];
        }
    }
    return CGSizeMake(0,destiY + [self edgeInsets].bottom);
}

/**
 *  准备一些初始化参数，每当UICollectionView的frame发生改变就会调用一次
 */
- (void)prepareLayout
{
    [super prepareLayout];
    
    // 初始化数组
    [self.maxYs removeAllObjects];
    for (int  i = 0; i < [self columnCount]; i++) {
        [self.maxYs addObject:@([self edgeInsets].top)];
    }
    
    // 计算所有cell的布局属性
    NSUInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (NSInteger i = 0; i < count; i++) {
        NSIndexPath * path = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes * attrs= [self layoutAttributesForItemAtIndexPath:path];
        
        [self.attrsArray addObject:attrs];
    }
}

/**
 *  决定rect里面的元素怎么排
 *
 *  @param rect 矩形区域
 *
 *  @return 带有UICollectionViewLayoutAttributes的数组
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attrsArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewLayoutAttributes * attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    /***计算cell的布局属性****/
    
    // 计算每列cell的宽度
    CGFloat margin = [self edgeInsets].left + [self edgeInsets].right + ([self columnCount] - 1) * [self columnMargin];
    CGFloat w = (MKCollectionW - margin) / [self columnCount];
    
    CGFloat h = w / [self.delegate waterFlowLayout:self widthHeightForRowAtIndexPath:indexPath];
    // 遍历数组maxYs
    // 取出最大的Y和对应的列号
    CGFloat destiY = [self.maxYs[0] doubleValue];
    NSInteger destiIndex = 0;
    for(NSInteger i = 1;i < [self columnCount];i++){
        if (destiY > [self.maxYs[i] doubleValue]) {
            destiY = [self.maxYs[i] doubleValue];
            destiIndex = i;
        }
    }
    CGFloat x = [self edgeInsets].left + (w + [self columnMargin]) * destiIndex;
    
    CGFloat y = 0;
    y = destiY == 10 ? 30 : (destiY + [self rowMargin]);
    
    attrs.frame = CGRectMake(x, y, w, h);
    
    // 更新数组
    self.maxYs[destiIndex] =@( CGRectGetMaxY(attrs.frame));
    
    return attrs;
}
#pragma mark - 处理代理数据
- (CGFloat)columnCount
{
    if ([self.delegate respondsToSelector:@selector(columnCountInWaterFlowLayout:)]) {
        return [self.delegate columnCountInWaterFlowLayout:self];
    }
    return MKDefaultColumnCount;

}
- (CGFloat)columnMargin
{
    if ([self.delegate respondsToSelector:@selector(columnMarginInWaterFlowLayout:)]) {
        return [self.delegate columnMarginInWaterFlowLayout:self];
    }
    return MKDefaultcolumnMargin;
    
}

- (CGFloat)rowMargin
{
    if ([self.delegate respondsToSelector:@selector(rowMarginInWaterFlowLayout:)]) {
        return [self.delegate rowMarginInWaterFlowLayout:self];
    }
    return MKDefaultRowMargin;
    
}

- (UIEdgeInsets)edgeInsets
{
    if ([self.delegate respondsToSelector:@selector(edgeInsetsInWaterFlowLayout:)]) {
        return [self.delegate edgeInsetsInWaterFlowLayout:self];
    }
    return MKDefaultEdgeInsets;
    
}

@end
