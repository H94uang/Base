//
//  SUVC.m
//
//  Created by June on 17/3/7.
//  Copyright © 2017年 http://h94uang@gmail.com All rights reserved.
//

#import "SUViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface SUViewController ()

@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;
@property (nonatomic, assign) BOOL statusBarHidden;
@property (nonatomic, assign) BOOL changeStatusBarAnimated;

@end

@implementation SUViewController

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    SUViewController *viewController = [super allocWithZone:zone];
    
    @weakify(viewController)
    
    /**
     订阅两个信号
     该信号会在方法被调用时,将方法中的所有参数以 @see RACTuple 的形式发送到返回的信号上
     
     @param 方法: 触发器
     @return nil
     */
    [[viewController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
        
        @strongify(viewController)
        [viewController addSubviews];
        [viewController bindViewModel];
    }];
    
    [[viewController rac_signalForSelector:@selector(viewWillAppear:)] subscribeNext:^(id x) {
        
        @strongify(viewController)
        [viewController layoutNavigation];
        [viewController getNewData];
    }];
    
    return viewController;
}

- (instancetype)initWithViewModel:(id<SUViewModelProtocol>)viewModel {
    
    self = [super init];
    if (self) { }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    slog(@"");
}

#pragma mark - system

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    if (self.statusBarStyle) {
        
        return self.statusBarStyle;
    } else {
        
        return UIStatusBarStyleLightContent;
    }
}

- (BOOL)prefersStatusBarHidden {
    
    return self.statusBarHidden;
}

- (void)dealloc {
    
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
}

#pragma mark - private
/**
 *  去除nav 上的line
 */
- (void)removeNavgationBarLine {
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]){
        
        NSArray *list=self.navigationController.navigationBar.subviews;
        
        for (id obj in list) {
            
            if ([obj isKindOfClass:[UIImageView class]]) {
                
                UIImageView *imageView=(UIImageView *)obj;
                
                NSArray *list2=imageView.subviews;
                
                for (id obj2 in list2) {
                    
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        
                        UIImageView *imageView2=(UIImageView *)obj2;
                        
                        imageView2.hidden=YES;
                        
                    }
                }
            }
        }
    }
}

- (void)setIsExtendLayout:(BOOL)isExtendLayout {
    
    if (!isExtendLayout) {
        [self initializeSelfVCSetting];
    }
}

- (void)initializeSelfVCSetting {
    
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
}

- (void)changeStatusBarStyle:(UIStatusBarStyle)statusBarStyle
             statusBarHidden:(BOOL)statusBarHidden
     changeStatusBarAnimated:(BOOL)animated {
    
    self.statusBarStyle=statusBarStyle;
    self.statusBarHidden=statusBarHidden;
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            [self setNeedsStatusBarAppearanceUpdate];
        }];
    }
    else{
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

- (void)hideNavigationBar:(BOOL)isHide
                 animated:(BOOL)animated{
    
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            self.navigationController.navigationBarHidden=isHide;
        }];
    }
    else{
        self.navigationController.navigationBarHidden=isHide;
    }
}

- (void)layoutNavigationBar:(UIImage*)backGroundImage
                 titleColor:(UIColor*)titleColor
                  titleFont:(UIFont*)titleFont
          leftBarButtonItem:(UIBarButtonItem*)leftItem
         rightBarButtonItem:(UIBarButtonItem*)rightItem {
    
    if (backGroundImage) {
        [self.navigationController.navigationBar setBackgroundImage:backGroundImage forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
    if (titleColor&&titleFont) {
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor,NSFontAttributeName:titleFont}];
    }
    else if (titleFont) {
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:titleFont}];
    }
    else if (titleColor){
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor}];
    }
    if (leftItem) {
        self.navigationItem.leftBarButtonItem=leftItem;
    }
    if (rightItem) {
        self.navigationItem.rightBarButtonItem=rightItem;
    }
}

#pragma mark - 屏幕旋转
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate {
    
    return NO;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    
    return UIInterfaceOrientationPortrait;
}

#pragma mark - RAC
/**
 *  添加控件
 */
- (void)addSubviews { }

/**
 *  绑定
 */
- (void)bindViewModel { }

/**
 *  设置navation
 */
- (void)layoutNavigation { }

/**
 *  初次获取数据
 */
- (void)getNewData { }

@end
