//
//  UICollectionView+MGCollection.m
//  MGCategories
//
//  Created by Mingle on 2018/4/16.
//

#import "UICollectionView+MGCollection.h"
#import <objc/runtime.h>

@interface UICollectionView ()

/**长按编辑手势*/
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGesture;
/**是否正在编辑*/
@property (nonatomic, assign, readwrite) BOOL isDrag;
/**拖动中的view*/
@property (nonatomic, strong, nullable) UIView *dragView;
/**dragView的手势起始点*/
@property (nonatomic, assign) CGPoint dragFirstPoint;
/**当前的位置*/
@property (nonatomic, strong, nullable) NSIndexPath *currentIndexPath;

@end

@implementation UICollectionView (MGCollection)

#pragma mark - 运行时赋值、取值
- (BOOL)dragEnable {
    return [objc_getAssociatedObject(self, @selector(dragEnable)) boolValue];
}

- (void)setDragEnable:(BOOL)dragEnable {
    objc_setAssociatedObject(self, @selector(dragEnable), @(dragEnable), OBJC_ASSOCIATION_COPY);
    if (dragEnable && !self.longPressGesture) {
        self.longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressHandle:)];
        self.longPressGesture.enabled = self.dragEnable;
        self.scaleOnDrag = 1.2;
        [self addGestureRecognizer:self.longPressGesture];
    }
    self.longPressGesture.enabled = dragEnable;
}

- (float)scaleOnDrag {
    return [objc_getAssociatedObject(self, @selector(scaleOnDrag)) floatValue];
}

- (void)setScaleOnDrag:(float)scaleOnDrag {
    objc_setAssociatedObject(self, @selector(scaleOnDrag), @(scaleOnDrag), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)isDrag {
    return [objc_getAssociatedObject(self, @selector(isDrag)) boolValue];
}

- (void)setIsDrag:(BOOL)isDrag {
    objc_setAssociatedObject(self, @selector(isDrag), @(isDrag), OBJC_ASSOCIATION_COPY);
}

- (id<MGDragCollectionDelegate>)mgDelegate {
    return objc_getAssociatedObject(self, @selector(mgDelegate));
}

- (void)setMgDelegate:(id<MGDragCollectionDelegate>)mgDelegate {
    objc_setAssociatedObject(self, @selector(mgDelegate), mgDelegate, OBJC_ASSOCIATION_ASSIGN);
}

- (UIView *)dragView {
    return objc_getAssociatedObject(self, @selector(dragView));
}

- (void)setDragView:(UIView *)dragView {
    objc_setAssociatedObject(self, @selector(dragView), dragView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGPoint)dragFirstPoint {
    return [objc_getAssociatedObject(self, @selector(dragFirstPoint)) CGPointValue];
}

- (void)setDragFirstPoint:(CGPoint)dragFirstPoint {
    objc_setAssociatedObject(self, @selector(dragFirstPoint), [NSValue valueWithCGPoint:dragFirstPoint], OBJC_ASSOCIATION_COPY);
}

- (NSIndexPath *)currentIndexPath {
    return objc_getAssociatedObject(self, @selector(currentIndexPath));
}

- (void)setCurrentIndexPath:(NSIndexPath *)currentIndexPath {
    objc_setAssociatedObject(self, @selector(currentIndexPath), currentIndexPath, OBJC_ASSOCIATION_COPY);
}

- (void)longPressHandle:(UIGestureRecognizer *)sender {
    CGPoint touchPoint = [sender locationInView:self];
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            [self dragBegin:touchPoint];
            break;
        case UIGestureRecognizerStateChanged:
            [self dragMoving:touchPoint];
            break;
        case UIGestureRecognizerStateEnded:
            [self dragEnd:touchPoint];
            break;
        default:
            break;
    }
}

#pragma mark - 开始拖动
- (void)dragBegin:(CGPoint)touchPoint {
    self.isDrag = YES;
    self.currentIndexPath = [self getDragingIndexPathWithPoint:touchPoint];
    if ([self.mgDelegate respondsToSelector:@selector(mg_collectionView:canDragItemAtIndexPath:)]) {
        if ([self.mgDelegate mg_collectionView:self canDragItemAtIndexPath:self.currentIndexPath]) {
            [self setupDragView:touchPoint];
        }
    }
}

- (void)setupDragView:(CGPoint)touchPoint {
    UICollectionViewCell *targetCell = [self cellForItemAtIndexPath:self.currentIndexPath];
    if (targetCell) {
        self.dragFirstPoint = [self convertPoint:touchPoint toView:targetCell];
        if ([self.mgDelegate respondsToSelector:@selector(mg_collectionView:willBeginDragItemAtIndexPath:)]) {
            [self.mgDelegate mg_collectionView:self willBeginDragItemAtIndexPath:self.currentIndexPath];
        }
        self.dragView = [targetCell snapshotViewAfterScreenUpdates:NO];
        self.dragView.frame = targetCell.frame;
        [self addSubview:self.dragView];
        [UIView animateWithDuration:0.25f animations:^{
            self.dragView.transform = CGAffineTransformMakeScale(self.scaleOnDrag, self.scaleOnDrag);
        } completion:^(BOOL finished) {
            if (finished) {
                targetCell.hidden = YES;
            }
        }];
    }
}

#pragma mark - 拖动中
- (void)dragMoving:(CGPoint)touchPoint {
    if (self.dragView) {
        NSIndexPath *targetIndexPath = [self getDragingIndexPathWithPoint:touchPoint];
        
        CGRect rect = self.dragView.frame;
        rect.origin.x = touchPoint.x - self.dragFirstPoint.x;
        rect.origin.y = touchPoint.y - self.dragFirstPoint.y;
        self.dragView.frame = rect;
        
        if ([self.mgDelegate respondsToSelector:@selector(mg_collectionView:canDragItemFromIndexPath:toIndexPath:)]) {
            if (![self.mgDelegate mg_collectionView:self canDragItemFromIndexPath:self.currentIndexPath toIndexPath:targetIndexPath]) {
                return;
            }
        }
        
        if (!(self.currentIndexPath.section == targetIndexPath.section && self.currentIndexPath.row == targetIndexPath.row) && targetIndexPath) {
            // 当前位置和目标位置不同，需要移动cell
            if ([self.mgDelegate respondsToSelector:@selector(mg_collectionView:willDragItemFromIndexPath:toIndexPath:)]) {
                [self.mgDelegate mg_collectionView:self willDragItemFromIndexPath:self.currentIndexPath toIndexPath:targetIndexPath];
            }
            [self moveItemAtIndexPath:self.currentIndexPath toIndexPath:targetIndexPath];
            self.currentIndexPath = targetIndexPath;
        }
    }
}

#pragma mark - 拖动结束
- (void)dragEnd:(CGPoint)touchPoint {
    if (self.dragView) {
        [UIView animateWithDuration:0.25f animations:^{
            self.dragView.transform = CGAffineTransformMakeScale(1, 1);
            self.dragView.frame = [self cellForItemAtIndexPath:self.currentIndexPath].frame;
        } completion:^(BOOL finished) {
            if (finished) {
                self.isDrag = NO;
                [self cellForItemAtIndexPath:self.currentIndexPath].hidden = NO;
                [self.dragView removeFromSuperview];
                if ([self.mgDelegate respondsToSelector:@selector(mg_collectionView:didEndDragItemAtIndexPath:)]) {
                    [self.mgDelegate mg_collectionView:self didEndDragItemAtIndexPath:self.currentIndexPath];
                }
                self.dragView = nil;
                self.currentIndexPath = nil;
            }
        }];
    }
}

#pragma mark - 获取被拖动IndexPath的方法
- (NSIndexPath *)getDragingIndexPathWithPoint:(CGPoint)point {
    NSIndexPath *dragingIndexPath = nil;
    //遍历所有屏幕上的cell
    for (NSIndexPath *indexPath in [self indexPathsForVisibleItems]) {
        //判断cell是否包含这个点
        if (CGRectContainsPoint([self cellForItemAtIndexPath:indexPath].frame, point)) {
            dragingIndexPath = indexPath;
            break;
        }
    }
    return dragingIndexPath;
}

@end
