# JKRCategory
自定义分类，拆分常用的功能

NSObject+JKR_Observer:
KVO封装
```
@weakify(self);
[self.imageView jkr_addObserver:self forKeyPath:@"hidden" change:^(id newValue) {
        @strongify(self);
        self.bannerView.hidden = [newValue  isEqual:@(YES)];
    }];
```

NSString+JKRMD5:
MD5加密
```
NSString *md5String = [@"123456" jkr_md5String];
```

UIColor+JKRColor:
通过十六进制颜色码获取颜色
```
[UIColor jkr_colorWithHexString:@"ffffff"];
```
通过RGB获取颜色
```
[UIColor jkr_colorWithRed:255 green:255 blue:255 alpha:1.0];
```


UIGestureRecognizer+JKRTouch:
设置一个手势是否生效
```
@property (nonatomic, assign) BOOL unTouch;
```

UIImage+JKR_MessageImage:
根据原图片，快速生成一张带角标的图片
```
/**
 Message tip icon

 @param count     message count
 @param imageSize imageSize
 @param tipRadius tipRadius
 @param tipTop    topMargin
 @param tipRight  rightMargin
 @param fontSize  tipTextFontSize
 @param textColor tipTextColor
 @param tipColor  tipBackgroundColor

 @return New image with tip count in the top-right corner
 */
- (instancetype)jkr_messageImageWithCount:(NSInteger)count imageSize:(CGSize)imageSize tipRadius:(CGFloat)tipRadius tipTop:(CGFloat)tipTop tipRight:(CGFloat)tipRight fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor tipColor:(UIColor *)tipColor;
```

UIImage+JKRImage:
图片创建／压缩／渲染
```
/// 通过颜色获取一张宽高都为1px的图片
+ (UIImage *)jkr_imageWithColor:(UIColor *)color;
/// 通过颜色获取一张规定尺寸的图片
+ (UIImage *)jkr_imageWithColor:(UIColor *)color size:(CGSize)size;
/// 将图片裁剪成一张圆形图片
- (UIImage *)jkr_clipCircleImageWithBorder:(CGFloat)borderWidth withColor:(UIColor *)borderColor;
/// 将图片压缩到指定宽度
- (UIImage *)jkr_compressWithWidth:(CGFloat)width;
/// 将图片在子线程中压缩，block在主线层回调，保证压缩到指定文件大小，尽量减少失真
- (void)jkr_compressToDataLength:(NSInteger)length withBlock:(void(^)(NSData *data))block;
/// 尽量将图片压缩到指定大小，不一定满足条件
- (void)jkr_tryCompressToDataLength:(NSInteger)length withBlock:(void(^)(NSData *data))block;
/// 快速将图片压缩到指定大小，失真严重
- (void)jkr_fastCompressToDataLength:(NSInteger)length withBlock:(void(^)(NSData *data))block;
/// 通过修改r.g.b像素点来处理图片
- (void)jkr_fliterImageWithFliterBlock:(void(^)(int *red, int *green, int *blue))Fliterblock success:(void(^)(UIImage *image))success;
```

UIImage+JKRRender:
图片拉伸
```
/// 不拉伸的图片
+ (instancetype)jkr_originalImageNamed:(NSString *)name;
/// 中心拉伸的图片
+ (instancetype)jkr_stretchableImageNamed:(NSString *)name;
```

UINavigationController+JKRBackButton:
根据方法交换自定义导航控制器返回按钮，不需要其他地方分散代码。

UINavigationController+JKRStatusBar：
处理导航控制器下定义自控制器顶部状态栏的问题。

UIView+JKR_HitTest：
重写模拟实现系统响应链传递方法。

UITextView+JKRPlaceHolder：
给UITextView添加placeHolder功能
```
self.textView.placeHolder = @"宝宝不开心了";
```

UIView+JKR_Frame:
便捷获取和设置视图的frame
```
self.imageView.x = 0;
self.imageView.y = 12;
self.imageView.witdh = self.view.width;
self.imageView.height = 120;
```

UIView+JKRSnap:
给当前View截图
```
UIImage *snapImage = [self.view jkr_snapImage];
```

UIView+JKRTapGestureRecognizer:
快捷给一个视图添加一个Tap手势
```
[self.iconImageView jkr_addTapGestureRecognizerWithBlock:^(UIGestureRecognizer *gestureRecognizer) {
 
}];
```

UIView+JKRTouch:
设置一个UIView的触摸事件响应范围
```
// 是否能够响应touch事件
self.view.unTouch = NO;
// 不响应touch事件的区域
self.view.unTouchRect = CGGrectMake(0, 0, 10, 10);
```

UIView+JKRViewController:获取一个视图所在的控制器
```
[self.jkr_viewController dismissViewControllerAnimated:YES completion:nil];
```

UIViewController+JKRStatusBarStyle:设置当前控制器下状态栏的颜色
```
self.jkr_lightStatusBar = YES;
```
