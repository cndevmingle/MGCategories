//
//  UIView+MGView.m
//  MGCategories
//
//  Created by Mingle on 2018/2/2.
//

#import "UIView+MGView.h"
#import <objc/runtime.h>

@interface UIView ()

/**单击手势*/
@property (nonatomic, strong) UITapGestureRecognizer *onceTapGesture;
/**双击手势*/
@property (nonatomic, strong) UITapGestureRecognizer *doubleTapGesture;
/**长按手势*/
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGesture;
/**单击手势回调*/
@property (nonatomic, copy) void(^tapBlock)(UIView *);
/**双击手势回调*/
@property (nonatomic, copy) void(^doubleBlock)(UIView *);
/**长按手势回调*/
@property (nonatomic, copy) void(^longPressBlock)(UIView *);

@end

@implementation UIView (MGView)

- (void)setMg_size:(CGSize)mg_size {
    CGRect frame = self.frame;
    frame.size = mg_size;
    self.frame = frame;
}

- (CGSize)mg_size {
    return self.frame.size;
}

- (void)setMg_origin:(CGPoint)mg_origin {
    CGRect frame = self.frame;
    frame.origin = mg_origin;
    self.frame = frame;
}

- (CGPoint)mg_origin {
    return self.frame.origin;
}

- (void)setMg_center:(CGPoint)mg_center {
    self.center = mg_center;
}

- (CGPoint)mg_center {
    return self.center;
}

- (void)setMg_centerX:(CGFloat)mg_centerX {
    CGPoint center = self.mg_center;
    center.x = mg_centerX;
    self.center = center;
}

- (CGFloat)mg_centerX {
    return self.mg_center.x;
}

- (void)setMg_centerY:(CGFloat)mg_centerY {
    CGPoint center = self.mg_center;
    center.y = mg_centerY;
    self.center = center;
}

- (CGFloat)mg_centerY {
    return self.mg_center.y;
}

- (void)setMg_x:(CGFloat)mg_x {
    CGRect frame = self.frame;
    frame.origin.x = mg_x;
    self.frame = frame;
}

- (CGFloat)mg_x {
    return self.frame.origin.x;
}

- (void)setMg_left:(CGFloat)mg_left {
    self.mg_x = mg_left;
}

- (CGFloat)mg_left {
    return self.mg_x;
}

- (void)setMg_y:(CGFloat)mg_y {
    CGRect frame = self.frame;
    frame.origin.y = mg_y;
    self.frame = frame;
}

- (CGFloat)mg_y {
    return self.frame.origin.y;
}

- (void)setMg_top:(CGFloat)mg_top {
    self.mg_y = mg_top;
}

- (CGFloat)mg_top {
    return self.mg_y;
}

- (void)setMg_right:(CGFloat)mg_right {
    CGRect frame = self.frame;
    frame.origin.x = mg_right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)mg_right {
    return self.mg_x + self.mg_width;
}

- (void)setMg_bottom:(CGFloat)mg_bottom {
    CGRect frame = self.frame;
    frame.origin.y = mg_bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)mg_bottom {
    return self.mg_y + self.mg_height;
}

- (void)setMg_width:(CGFloat)mg_width {
    CGRect frame = self.frame;
    frame.size.width = mg_width;
    self.frame = frame;
}

- (CGFloat)mg_width {
    return self.frame.size.width;
}

- (void)setMg_height:(CGFloat)mg_height {
    CGRect frame = self.frame;
    frame.size.height = mg_height;
    self.frame = frame;
}

- (CGFloat)mg_height {
    return self.frame.size.height;
}

- (void)setMg_cornerRadius:(CGFloat)mg_cornerRadius {
    self.clipsToBounds = YES;
    self.layer.cornerRadius = mg_cornerRadius;
}

- (CGFloat)mg_cornerRadius {
    return self.layer.cornerRadius;
}

- (void)setMg_borderWidth:(CGFloat)mg_borderWidth {
    self.layer.borderWidth = mg_borderWidth;
}

- (CGFloat)mg_borderWidth {
    return self.layer.borderWidth;
}

- (void)setMg_borderColor:(UIColor *)mg_borderColor {
    self.layer.borderColor = mg_borderColor.CGColor;
}

- (UIColor *)mg_borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)mg_setCornerRadiusWithTopLeft:(BOOL)topleft topRight:(BOOL)topRight bottomLeft:(BOOL)bottomLeft bottomRight:(BOOL)bottomRight size:(CGSize)size {
    UIRectCorner corner = (topleft?UIRectCornerTopLeft:0) | (topRight?UIRectCornerTopRight:0) | (bottomLeft?UIRectCornerBottomLeft:0) | (bottomRight?UIRectCornerBottomRight:0);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:size];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = path.CGPath;
    self.layer.mask = maskLayer;
}

- (void)mg_whenTapOnceWithBlock:(void (^)(UIView *))block {
    if (!self.onceTapGesture) {
        self.onceTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onceTapHandle)];
        [self addGestureRecognizer:self.onceTapGesture];
        if (self.doubleTapGesture) {
            [self.onceTapGesture requireGestureRecognizerToFail:self.doubleTapGesture];
        }
    }
    self.tapBlock = block;
}

- (void)onceTapHandle {
    if (self.tapBlock) {
        self.tapBlock(self);
    }
}

- (void)mg_whenTapDoubleWithBlock:(void (^)(UIView *))block {
    if (!self.doubleTapGesture) {
        self.doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapHandle)];
        self.doubleTapGesture.numberOfTapsRequired = 2;
        [self addGestureRecognizer:self.doubleTapGesture];
        if (self.onceTapGesture) {
            [self.onceTapGesture requireGestureRecognizerToFail:self.doubleTapGesture];
        }
    }
    self.doubleBlock = block;
}

- (void)doubleTapHandle {
    if (self.doubleBlock) {
        self.doubleBlock(self);
    }
}

- (void)mg_whenLongPressWithBlock:(void (^)(UIView *))block {
    if (!self.longPressGesture) {
        self.longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressHandle:)];
        [self addGestureRecognizer:self.longPressGesture];
    }
    self.longPressBlock = block;
}

- (void)longPressHandle:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        if (self.longPressBlock) {
            self.longPressBlock(self);
        }
    }
}

- (void)setOnceTapGesture:(UITapGestureRecognizer *)onceTapGesture {
    objc_setAssociatedObject(self, _cmd, onceTapGesture, OBJC_ASSOCIATION_RETAIN);
}

- (UITapGestureRecognizer *)onceTapGesture {
    return objc_getAssociatedObject(self, @selector(setOnceTapGesture:));
}

- (void)setTapBlock:(void (^)(UIView *))tapBlock {
    objc_setAssociatedObject(self, _cmd, tapBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UIView *))tapBlock {
    return objc_getAssociatedObject(self, @selector(setTapBlock:));
}

- (void)setDoubleTapGesture:(UITapGestureRecognizer *)doubleTapGesture {
    objc_setAssociatedObject(self, _cmd, doubleTapGesture, OBJC_ASSOCIATION_RETAIN);
}

- (UITapGestureRecognizer *)doubleTapGesture {
    return objc_getAssociatedObject(self, @selector(setDoubleTapGesture:));
}

- (void)setDoubleBlock:(void (^)(UIView *))doubleBlock {
    objc_setAssociatedObject(self, _cmd, doubleBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UIView *))doubleBlock {
    return objc_getAssociatedObject(self, @selector(setDoubleBlock:));
}

- (void)setLongPressGesture:(UILongPressGestureRecognizer *)longPressGesture {
    objc_setAssociatedObject(self, _cmd, longPressGesture, OBJC_ASSOCIATION_RETAIN);
}

- (UILongPressGestureRecognizer *)longPressGesture {
    return objc_getAssociatedObject(self, @selector(setLongPressGesture:));
}

- (void)setLongPressBlock:(void (^)(id))longPressBlock {
    objc_setAssociatedObject(self, _cmd, longPressBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(id))longPressBlock {
    return objc_getAssociatedObject(self, @selector(setLongPressBlock:));
}

@end
