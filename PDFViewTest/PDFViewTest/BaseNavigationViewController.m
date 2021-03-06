//
//  BaseNavigationViewController.m
//  PDFViewTest
//
//  Created by cguo on 2017/4/29.
//  Copyright © 2017年 YX. All rights reserved.
//

#import "BaseNavigationViewController.h"

@interface BaseNavigationViewController ()

@end

@implementation BaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 先给外面传进来的小控制器 包装 一个导航控制器

    //如果滑动移除控制器的功能失效，清空代理（让控制器重新设置功能）
    self.interactivePopGestureRecognizer.delegate=nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
+(void)initialize
{
    
    
    
    
    
}


-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count>0) {
        // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
        /* 自动显示和隐藏tabbar */
        viewController.hidesBottomBarWhenPushed = YES;
        
        
        //设置导航条上面的内容
        //        设置左边的返回按钮
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
//        [btn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
//        [btn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        btn.backgroundColor=[UIColor blueColor];
//        [btn setTitle:@"返回" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
      
        // 让按钮的内容往左边偏移10
//        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        //让按钮中的内容全部往左对齐
        btn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        [btn addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchDown];
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }
    [super pushViewController:viewController animated:animated];
}
-(void)fanhui
{
    [self popViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
