//
//  MMTheme.m
//  MMThemeDemo
//
//  Created by momo on 16/4/27.
//  Copyright © 2016年 momo. All rights reserved.
//

#import "MMTheme.h"

NSString * const MMColorThemeName = @"com.mm.theme.color.www";
NSString * const MMImageThemeName = @"com.mm.theme.image.www";


@interface MMTheme ()

/**
 *  当前主题
 */
@property (nonatomic, nonnull, copy) NSString *currentTheme;

/**
 *  添加的imagesView数组
 */
@property (nonatomic, strong) NSMutableArray *imagesViewArray;

/**
 *  当前的主题配置字典
 */
@property (nonatomic, strong) NSDictionary *currentThemesDict;

/**
 *  原来的主题
 */
@property (nonatomic, strong) NSMutableDictionary *themesDict;

@end

@implementation MMTheme

- (NSMutableArray *)imagesViewArray {
    if (_imagesViewArray == nil) {
        _imagesViewArray = [NSMutableArray array];
    }
    return _imagesViewArray;
}

- (NSDictionary *)currentThemesDict {
    if (_currentThemesDict == nil) {
        _currentThemesDict = [NSDictionary dictionary];
    }
    return _currentThemesDict;
}

- (NSMutableDictionary *)themesDict {
    if (_themesDict ==nil) {
        _themesDict = [NSMutableDictionary dictionary];
    }
    return _themesDict;
}

+ (instancetype)themeManger {
    static MMTheme *themeManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        themeManager = [[MMTheme alloc]init];
    });
    
    return themeManager;
}

// 配置主题
- (void)themeConfig:(nonnull __kindof UIView *)view themes:(nullable NSDictionary<NSString *, id> *)themes completion:(nullable void (^)())completion {
    
    if (self.themesDict.count <= 0) {
        // 保存原始配置
        [self.themesDict setObject:view.backgroundColor forKey:[NSString stringWithFormat:@"%p", view]];
        if (view.subviews.count > 0) {
            UIColor *color = nil;
            for (UIView *subView in view.subviews) {
                color = subView.backgroundColor;
                if (color) {
                    [self.themesDict setObject:color forKey:[NSString stringWithFormat:@"%p",subView]];
                }
            }
        }
    }

    // 判断是否和上一次配置相同，避免重复设置
    if (![self.currentThemesDict isEqualToDictionary:themes]) {
        self.currentThemesDict = themes;
        if ([[themes allKeys]containsObject:MMColorThemeName]) {
            [self setupColorTheme:view themes:themes];
        }
        
        if ([[themes allKeys]containsObject:MMImageThemeName]) {
            [self setupImageTheme:view themes:themes];
        }
    }
    
    self.currentTheme = self.themeIdentifer;
    
    if (completion) {
        completion();
    }
    
}

// 配置颜色主题
- (void)setupColorTheme:(nonnull __kindof UIView *)view themes:(nullable NSDictionary<NSString *, id> *)themes {
    UIColor *color = themes[MMColorThemeName];
    if (color) {
        
        [self.imagesViewArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [view setBackgroundColor:color];
        
        if (view.subviews.count > 0) {
            for (UIView *subView in view.subviews) {
                if (![self.ignoreViews containsObject:subView]) {
                    @autoreleasepool {
                        [subView setBackgroundColor:color];
                    }
                }
                
            }
        }
    }
}

// 配置图片主题
- (void)setupImageTheme:(nonnull __kindof UIView *)view themes:(nullable NSDictionary<NSString *, id> *)themes {
    
    UIImage *image = themes[MMImageThemeName];
    
    if (image) {
        view.backgroundColor = [self.themesDict objectForKey:[NSString stringWithFormat:@"%p", view]];
        [self.imagesViewArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:view.bounds];
        [bgImgView setImage:image];
        bgImgView.contentMode = UIViewContentModeScaleAspectFill;
        bgImgView.clipsToBounds = YES;
        [view insertSubview:bgImgView atIndex:0];
        [self.imagesViewArray addObject:bgImgView];

        if (view.subviews.count > 0) {
            for (UIView *subView in view.subviews) {
                
                if (![self.imagesViewArray containsObject:subView]) {
                    subView.backgroundColor = [self.themesDict objectForKey:[NSString stringWithFormat:@"%p", subView]];
                    
                    if (![self.ignoreViews containsObject:subView]) {
                        @autoreleasepool {
                            UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:subView.bounds];
                            [bgImgView setImage:image];
                            bgImgView.contentMode = UIViewContentModeScaleAspectFill;
                            bgImgView.clipsToBounds = YES;
                            [subView insertSubview:bgImgView atIndex:0];
                            [self.imagesViewArray addObject:bgImgView];
                        }
                    }
                }

            }
        }
    }
}
@end
