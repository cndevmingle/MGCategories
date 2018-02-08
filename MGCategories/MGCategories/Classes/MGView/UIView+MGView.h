//
//  UIView+MGView.h
//  MGCategories
//
//  Created by Mingle on 2018/2/2.
//

#import <UIKit/UIKit.h>

@interface UIView (MGView)

/**大小*/
@property (nonatomic, assign) CGSize mg_size;
/**原点*/
@property (nonatomic, assign) CGPoint mg_origin;
/**中间点*/
@property (nonatomic, assign) CGPoint mg_center;
/**中间点x*/
@property (nonatomic, assign) CGFloat mg_centerX;
/**中间点y*/
@property (nonatomic, assign) CGFloat mg_centerY;
/**x*/
@property (nonatomic, assign) CGFloat mg_x;
@property (nonatomic, assign) CGFloat mg_left;
/**右边的x*/
@property (nonatomic, assign) CGFloat mg_right;
/**y*/
@property (nonatomic, assign) CGFloat mg_y;
@property (nonatomic, assign) CGFloat mg_top;
/**底部的y*/
@property (nonatomic, assign) CGFloat mg_bottom;
/**width*/
@property (nonatomic, assign) CGFloat mg_width;
/**height*/
@property (nonatomic, assign) CGFloat mg_height;
/**圆角弧度*/
@property (nonatomic, assign) CGFloat mg_cornerRadius;
/**边框宽度*/
@property (nonatomic, assign) CGFloat mg_borderWidth;
/**边框颜色*/
@property (nonatomic, strong) UIColor *mg_borderColor;

/**
 设置任意角的弧度

 @param topleft 是否需要左上圆角
 @param topRight 是否需要右上圆角
 @param bottomLeft 是否需要左下圆角
 @param bottomRight 是否需要右下圆角
 @param size 圆角大小
 */
- (void)mg_setCornerRadiusWithTopLeft:(BOOL)topleft topRight:(BOOL)topRight bottomLeft:(BOOL)bottomLeft bottomRight:(BOOL)bottomRight size:(CGSize)size;

/**
 点击一次的手势响应

 @param block 回调
 */
- (void)mg_whenTapOnceWithBlock:(void(^)(UIView *view))block;

/**
 点击两次的手势响应

 @param block 回调
 */
- (void)mg_whenTapDoubleWithBlock:(void(^)(UIView *view))block;

/**
 长按时菜单功能

 @param block 回调
 */
- (void)mg_whenLongPressWithBlock:(void(^)(UIView *view))block;

@end
