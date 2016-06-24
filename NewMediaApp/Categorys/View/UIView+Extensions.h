
//

#import <UIKit/UIKit.h>

#define CGRectIdentity CGRectMake(0, 0, 0, 0)

@interface UIView (Extensions)

@property float x_ext;

@property float y_ext;

@property float width_ext;

@property float height_ext;



@property(readonly) float right_ext;
@property(readonly) float bottom_ext;
@property(readonly) float left_ext;
@property(readonly) float top_ext;

@property(nonatomic, assign) CGSize size;

- (void)clearView;

- (void)removeViewWithTag:(NSInteger)viewTag;
- (void)addTopBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth ;
- (void)addBottomBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth;
- (void)addRightBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth;

-(UIView *(^)(UIView*))alignTop;
-(UIView *(^)(UIView*))alignBottom;
-(UIView *(^)(UIView*))alignRight;
-(UIView *(^)(UIView*))alignLeft;
-(UIView *(^)(float))offsetX;
-(UIView *(^)(float))offsetY;
-(UIView *(^)(UIView*))equalToView;
-(UIView *(^)(float))masksRadius;
@end
