

@implementation UIView (Extensions)



- (float)x_ext {
    return self.frame.origin.x;
}
-(float)y_ext{
    return self.frame.origin.y;
}

-(float)left_ext{
    return self.frame.origin.x;
}

-(float)right_ext{
    return self.frame.origin.x+self.frame.size.width;
}


-(float)top_ext{
    return self.frame.origin.y;
}

-(float)bottom_ext{
    return self.frame.origin.y+self.frame.size.height;
}

- (void)setX_ext:(float)newX {
    CGRect frame = self.frame;
    frame.origin.x = newX;
    self.frame = frame;
}



- (void)setY_ext:(float)newY {
    CGRect frame = self.frame;
    frame.origin.y = newY;
    self.frame = frame;
}

- (float)width_ext {
    return self.frame.size.width;
}

- (void)setWidth_ext:(float)newWidth {
    CGRect frame = self.frame;
    frame.size.width = newWidth;
    self.frame = frame;
}

- (float)height_ext {
    return self.frame.size.height;
}

- (void)setHeight_ext:(float)newHeight {
    CGRect frame = self.frame;
    frame.size.height = newHeight;
    self.frame = frame;
}


- (void)clearView {
    for (UIView *v in self.subviews) {
        [v removeFromSuperview];
    }
}

- (void)removeViewWithTag:(NSInteger)viewTag {
    UIView *view = [self viewWithTag:viewTag];
    [view removeFromSuperview];
}

- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (CGSize)size{
    return self.frame.size;
}
- (void)addTopBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth {
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    
    border.frame = CGRectMake(0, 0, self.frame.size.width, borderWidth);
    [self.layer addSublayer:border];
}

- (void)addBottomBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth {
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    
    border.frame = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, borderWidth);
    
    [self.layer addSublayer:border];
}
- (void)addRightBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth {
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    
    border.frame = CGRectMake(self.frame.size.width-borderWidth, 0, borderWidth,self.frame.size.height);
    
    [self.layer addSublayer:border];
}

-(UIView *(^)(UIView*))alignTop{
    return ^id(UIView *view){
        self.x_ext=view.y_ext-self.frame.size.height;
        return self;
    };
}
-(UIView *(^)(UIView*))alignBottom{
    return ^id(UIView *view){
        self.y_ext=view.frame.origin.y+view.frame.size.height;
        return self;
    };
}
-(UIView *(^)(UIView*))equalToView{
    return ^id(UIView *view){
        self.x_ext=view.x_ext;
        self.y_ext=view.y_ext;
        self.width_ext=view.width_ext;
        self.height_ext=view.height_ext;
        return self;
    };
}

-(UIView *(^)(UIView*))alignRight{
    return ^id(UIView *view){
        self.x_ext=view.x_ext+view.frame.size.width;
        return self;
    };

}

-(UIView *(^)(UIView*))alignLeft{
    return ^id(UIView *view){
        self.x_ext=view.x_ext-self.frame.size.width;
        return self;
    };
}

-(UIView *(^)(float))offsetX{
    return ^id(float x){
        self.x_ext=self.x_ext+x;
        return self;
    };
}
-(UIView *(^)(float))offsetY{
    return ^id(float x){
        self.y_ext=self.y_ext+x;
        return self;
        
    };
}
-(UIView *(^)(float))masksRadius{
    return ^id(float x){
        self.layer.masksToBounds=YES;
        self.layer.cornerRadius=x;
        return self;
        
    };
}
@end
