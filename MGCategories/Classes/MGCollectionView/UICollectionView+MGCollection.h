//
//  UICollectionView+MGCollection.h
//  MGCategories
//
//  Created by Mingle on 2018/4/16.
//

#import <UIKit/UIKit.h>

@protocol MGDragCollectionDelegate <NSObject>

@optional

/**
 能否拖动某一个cell
 */
- (BOOL)mg_collectionView:(UICollectionView *)collectionView canDragItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 能否拖动某一个cell到指定位置
 */
- (BOOL)mg_collectionView:(UICollectionView *)collectionView canDragItemFromIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath;

/**
 将要开始拖动某一个cell
 */
- (void)mg_collectionView:(UICollectionView *)collectionView willBeginDragItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 拖动结束
 */
- (void)mg_collectionView:(UICollectionView *)collection didEndDragItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 将要拖动cell从一个位置到另一个位置，在这个方法里面修改数据源
 */
- (void)mg_collectionView:(UICollectionView *)collectionView willDragItemFromIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath;

@end

@interface UICollectionView (MGCollection)

/**允许拖动，默认是NO*/
@property (nonatomic, assign) BOOL dragEnable;
/**拖动时缩放比例，默认1.2*/
@property (nonatomic, assign) float scaleOnDrag;
/**是否正在拖动*/
@property (nonatomic, assign, readonly) BOOL isDrag;
/**代理*/
@property (nonatomic, weak, nullable) id<MGDragCollectionDelegate> mgDelegate;

@end
