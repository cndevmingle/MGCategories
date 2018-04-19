//
//  DragCollectionViewCell.m
//  MGCollectionViewDemo
//
//  Created by Mingle on 2018/4/16.
//  Copyright © 2018年 Mingle. All rights reserved.
//

#import "DragCollectionViewCell.h"

@implementation DragCollectionViewCell

- (void)setEditStyle:(NSInteger)editStyle {
    _editStyle = editStyle;
    [_editButton setImage:[UIImage imageNamed:editStyle==0?@"add":@"delete"] forState:UIControlStateNormal];
}

- (IBAction)editAction:(id)sender {
    if (_editStyle == 0) {
        if (_addBlock) {
            _addBlock(self);
        }
    } else {
        if (_deleteBlock) {
            _deleteBlock(self);
        }
    }
}

@end
