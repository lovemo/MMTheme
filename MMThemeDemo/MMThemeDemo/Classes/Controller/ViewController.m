//
//  ViewController.m
//  MMThemeDemo
//
//  Created by yuantao on 16/4/27.
//  Copyright © 2016年 momo. All rights reserved.
//

#import "ViewController.h"
#import "MMTheme.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *containView;
@property (weak, nonatomic) IBOutlet UIView *testView;
@property (weak, nonatomic) IBOutlet UIButton *btnControl;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (IBAction)greenBtnAction {
    NSDictionary *themes = @{
                                MMColorThemeName : [UIColor greenColor]
                                };
    [self configWithThemes:themes identifer:@"greenColor" ignoreViews:nil];
}

- (IBAction)blueBtnAction {
    NSDictionary *themes = @{
                             MMColorThemeName : [UIColor blueColor]
                             };
    [self configWithThemes:themes identifer:@"blueColor" ignoreViews:@[self.testView]];
  
}

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

@end
