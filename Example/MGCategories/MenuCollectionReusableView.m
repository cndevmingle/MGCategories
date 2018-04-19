//
//  MenuCollectionReusableView.m
//  MGCollectionViewDemo
//
//  Created by Mingle on 2018/4/16.
//  Copyright © 2018年 Mingle. All rights reserved.
//

#import "MenuCollectionReusableView.h"

@implementation MenuCollectionReusableView

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width - 20, self.frame.size.height)];
        _contentLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_contentLabel];
    }
    return _contentLabel;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    _contentLabel.frame = CGRectMake(10, 0, self.frame.size.width - 20, self.frame.size.height);
}

@end
