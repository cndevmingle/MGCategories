//
//  ViewController.m
//  MGCollectionViewDemo
//
//  Created by Mingle on 2018/4/16.
//  Copyright © 2018年 Mingle. All rights reserved.
//

#import "MGCollectionViewController.h"
#import "DragCollectionViewCell.h"
#import "MenuCollectionReusableView.h"
#import <MGCategories/UICollectionView+MGCollection.h>

#define SCREEN_SIZE  [UIScreen mainScreen].bounds.size

@interface MGCollectionViewController () <UICollectionViewDelegate, UICollectionViewDataSource, MGDragCollectionDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

/**顶部数据*/
@property (nonatomic, strong) NSMutableArray *topArr;
/**完整数据*/
@property (nonatomic, strong) NSMutableArray *originArr;
/**item大小*/
@property (nonatomic, assign) CGSize itemSize;
/**间距*/
@property (nonatomic, assign) CGFloat padding;
/**能否编辑*/
@property (nonatomic, assign) BOOL editable;

@end

@implementation MGCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _topArr = [NSMutableArray array];
    _originArr = [NSMutableArray array];
    _collectionView.dragEnable = YES;
    _collectionView.mgDelegate = self;
    
    for (int i = 0; i < 22; i++) {
        [_originArr addObject:[NSString stringWithFormat:@"第%@", @(i+1)]];
    }
    _padding = 10;

    CGFloat itemWidth = floor((SCREEN_SIZE.width - _padding * 5)/4);
    CGFloat itemHeight = 100;
    _itemSize = CGSizeMake(itemWidth, itemHeight);

}

- (IBAction)edit:(UIBarButtonItem *)sender {
    _editable = !_editable;
    for (DragCollectionViewCell *cell in [_collectionView visibleCells]) {
        cell.editButton.hidden = !_editable;
    }
    sender.title = _editable?@"完成":@"编辑";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return _topArr.count;
    }
    return _originArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DragCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    __weak typeof(self) weakSelf = self;
    if (indexPath.section == 0) {
        cell.titleLabel.text = _topArr[indexPath.row];
        cell.editStyle = 1;
        cell.deleteBlock = ^(DragCollectionViewCell *aCell) {
            NSIndexPath *delIndexPath = [weakSelf.collectionView indexPathForCell:aCell];
            [weakSelf.topArr removeObjectAtIndex:delIndexPath.row];
            [weakSelf.collectionView deleteItemsAtIndexPaths:@[delIndexPath]];
            NSInteger index = [weakSelf.originArr indexOfObject:aCell.titleLabel.text];
            DragCollectionViewCell *bCell = (DragCollectionViewCell *)[weakSelf.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:1]];
            bCell.editStyle = 0;
        };
    } else {
        cell.titleLabel.text = _originArr[indexPath.row];
        cell.editStyle = [_topArr containsObject:_originArr[indexPath.row]]?1:0;
        cell.addBlock = ^(DragCollectionViewCell *aCell) {
            NSIndexPath *addIndexPath = [weakSelf.collectionView indexPathForCell:aCell];
            [weakSelf.topArr addObject:weakSelf.originArr[addIndexPath.row]];
            [weakSelf.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:weakSelf.topArr.count-1 inSection:0]]];
            aCell.editStyle = 1;
        };
        cell.deleteBlock = ^(DragCollectionViewCell *aCell) {
            NSObject *delObj = [weakSelf.originArr objectAtIndex:[weakSelf.collectionView indexPathForCell:aCell].row];
            NSIndexPath *delIndexPath = [NSIndexPath indexPathForRow:[weakSelf.topArr indexOfObject:delObj] inSection:0];
            [weakSelf.topArr removeObject:delObj];
            [weakSelf.collectionView deleteItemsAtIndexPaths:@[delIndexPath]];
            aCell.editStyle = 0;
        };
    }
    cell.editButton.hidden = !_editable;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return _itemSize;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(_padding, _padding, _padding, _padding);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return _padding;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_SIZE.width, 40);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_SIZE.width, 40);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    MenuCollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kind forIndexPath:indexPath];
    if (indexPath.section == 0) {
        view.contentLabel.text = [kind isEqualToString:UICollectionElementKindSectionHeader] ? @"便捷访问（长按拖动可排序）" : @"便捷访问 footer";
    } else {
        view.contentLabel.text = @"所有功能";
    }
    return view;
}

- (void)mg_collectionView:(UICollectionView *)collectionView willBeginDragItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __FUNCTION__);
}

- (void)mg_collectionView:(UICollectionView *)collection didEndDragItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __FUNCTION__);
}

- (BOOL)mg_collectionView:(UICollectionView *)collectionView canDragItemAtIndexPath:(NSIndexPath *)indexPath {
    _editable = YES;
    for (DragCollectionViewCell *cell in collectionView.visibleCells) {
        cell.editButton.hidden = !_editable;
    }
    if (indexPath.section == 0) {
        return YES;
    }
    NSLog(@"不能拖动%@", indexPath);
    return NO;
}

- (BOOL)mg_collectionView:(UICollectionView *)collectionView canDragItemFromIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    if (fromIndexPath.section == 0 && toIndexPath.section == 0) {
        return YES;
    }
    NSLog(@"不能拖动从：%@ 到 %@", fromIndexPath, toIndexPath);
    return NO;
}

- (void)mg_collectionView:(UICollectionView *)collectionView willDragItemFromIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    if (toIndexPath.section == 1) {
        NSObject *dragObj = _topArr[fromIndexPath.row];
        [_topArr removeObject:dragObj];
        [_topArr insertObject:dragObj atIndex:toIndexPath.row];
    }
}

@end
