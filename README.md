# MKWaterLayout
##如何使用

* 将MKWaterFlowLayout.h和MKWaterFlowLayout.m拖入到您的项目

* 在您的项目中导入主头文件  `#import "MKWaterFlowLayout.h"`* 
* 切换UICollectionView的布局 

’‘’objc
     MKWaterFlowLayout * layout = [[MKWaterFlowLayout alloc] init];
  
  self.collectionView.collectionViewLayout = layout;
'''

* 遵守协议设置代理

```objc

 layout.delegate = self;

```

* 必须实现的代理方法(返回真是图片的宽高比)

```objc
- (CGFloat)waterFlowLayout:(MKWaterFlowLayout *)waterFlowLayout widthHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{}

```
