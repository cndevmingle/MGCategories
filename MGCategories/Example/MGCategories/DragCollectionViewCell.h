//
//  DragCollectionViewCell.h
//  MGCollectionViewDemo
//
//  Created by Mingle on 2018/4/16.
//  Copyright © 2018年 Mingle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DragCollectionViewCell : UICollectionViewCell

/**图片*/
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
/**标题*/
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
/**编辑按钮（添加/删除）*/
@property (nonatomic, assign) IBOutlet UIButton *editButton;
/**编辑样式0-添加，1-删除*/
@property (nonatomic, assign) NSInteger editStyle;

/**添加回调*/
@property (nonatomic, copy) void(^addBlock)(DragCollectionViewCell *aCell);
/**删除回调*/
@property (nonatomic, copy) void(^deleteBlock)(DragCollectionViewCell *aCell);

@end
