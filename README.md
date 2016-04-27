# MMTheme
MMTheme -- set views theme

##Usage
```objc
- (IBAction)redBtnAction {
    NSDictionary *themes = @{
                             MMImageThemeName : [UIImage imageNamed:@"phil"]
                             };
    [self configWithThemes:themes identifer:@"主题图片" ignoreViews:@[self.testView, self.btnControl]];
}

- (void)configWithThemes:(NSDictionary *)themes identifer:(NSString *)identifer ignoreViews:(NSArray *)ignoreViews {
    
    MMTheme *theme = [MMTheme themeManger];
    theme.themeIdentifer = identifer;
    theme.ignoreViews = ignoreViews;
    [theme themeConfig:self.containView themes:themes completion:^{
        NSLog(@"目前我是主题 ：%@", theme.currentTheme);
    }];
    
}
```

##Code
```objc
FOUNDATION_EXPORT  NSString * _Nonnull  const MMColorThemeName;
FOUNDATION_EXPORT  NSString * _Nonnull  const MMImageThemeName;


@interface MMTheme : NSObject

/**
 *  单例对象
 *
 *  @return MMtheme
 */
+ (nonnull instancetype)themeManger;

/**
 *  配置主题
 *
 *  @param view             需配置的view，检测是否有子控件，如果有，遍历设置其所有控件主题，没有则设置其本身。
 *  @param themes           配置主题字典
 *  @param completion       设置完成
 */
- (void)themeConfig:(nonnull __kindof UIView *)view themes:(nullable NSDictionary<NSString *, id> *)themes completion:(nullable void (^)())completion;

/**
 *  主题标识符
 */
@property (nonatomic, nonnull, copy) NSString *themeIdentifer;

/**
 *  从view中设置需要忽略配置主题的view
 */
@property (nonatomic, nonnull, copy) NSArray *ignoreViews;

/**
 *  获取当前主题的唯一标识
 */
@property (nonatomic, nonnull, readonly, copy) NSString *currentTheme;

/**
 *  当前的主题配置字典
 */
@property (nonatomic, nullable, readonly, strong) NSDictionary *currentThemesDict;

@end
```
##image
![image](https://github.com/lovemo/MMTheme/blob/master/ScreenShot.png)
