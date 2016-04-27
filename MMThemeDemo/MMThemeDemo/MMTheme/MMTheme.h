//
//  MMTheme.h
//  MMThemeDemo
//
//  Created by momo on 16/4/27.
//  Copyright © 2016年 momo. All rights reserved.
//

#import <UIKit/UIKit.h>

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
 *  @param view                 需配置的view，检测是否有子控件，如果有，遍历设置其所有控件主题，没有则设置其本身。
 *  @param themes            配置主题字典
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
