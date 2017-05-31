//
//  ZPDFReaderController.m
//  pdfReader
//
//  Created by XuJackie on 15/6/6.
//  Copyright (c) 2015年 peter. All rights reserved.
//

#import "ZPDFReaderController.h"
#import "ZPDFPageController.h"
#import "AppDelegate.h"
@interface ZPDFReaderController ()
{
    UILabel *pagelabel;
}
@end

@implementation ZPDFReaderController
@synthesize titleText, fileName;
- (void) viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.titleText;
    
    if ([fileName hasPrefix:@"http://"]) {
        NSURL*url = [NSURL URLWithString:fileName];//将传入的字符串转化为一个NSURL地址
        CFURLRef pdfURL = (__bridge_retained CFURLRef)url;//将的到的NSURL转化为CFURLRefrefURL备用
        CGPDFDocumentRef pdfDocument = CGPDFDocumentCreateWithURL((CFURLRef)pdfURL);
        pdfPageModel = [[ZPDFPageModel alloc] initWithPDFDocument:pdfDocument];

    
    }else
    {
        CFURLRef pdfURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), CFSTR("001.pdf"), NULL, NULL);
        
        
        CGPDFDocumentRef pdfDocument = CGPDFDocumentCreateWithURL((CFURLRef)pdfURL);
        pdfPageModel = [[ZPDFPageModel alloc] initWithPDFDocument:pdfDocument];
         CFRelease(pdfURL);

    }
    NSDictionary *options = [NSDictionary dictionaryWithObject:
                             [NSNumber numberWithInteger: UIPageViewControllerSpineLocationMin]
                                                        forKey: UIPageViewControllerOptionSpineLocationKey];
    
    pageViewCtrl = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl
                                                   navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                 options:options];
    ZPDFPageController *initialViewController = [pdfPageModel viewControllerAtIndex:1];
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    [pageViewCtrl setDataSource:pdfPageModel];
  
    pageViewCtrl.doubleSided=NO;
    [pageViewCtrl setViewControllers:viewControllers
                           direction:UIPageViewControllerNavigationDirectionReverse
                            animated:NO
                          completion:^(BOOL f){
                              
                          }];
    [self addChildViewController:pageViewCtrl];

    [self.view addSubview:pageViewCtrl.view];
    [pageViewCtrl didMoveToParentViewController:self];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 22)];
//    [backButton setImage:[UIImage imageNamed:@"iconfont-FH"] forState:UIControlStateNormal];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:back];
    UIView *barView = [[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-28 - 6, [UIScreen mainScreen].bounds.size.width, 48 + 6)];
    barView.backgroundColor = [UIColor whiteColor];
    pagelabel=[[UILabel alloc]init];
    pagelabel.textAlignment=NSTextAlignmentCenter;
    pagelabel.font=[UIFont systemFontOfSize:11];
    pagelabel.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 48 + 6);
    pagelabel.textColor=[UIColor blackColor];

    [barView addSubview:pagelabel];
    [self.view addSubview:barView];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setLabel:) name:@"SetPageLabel" object:nil];
}
-(void)backBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)setLabel:(NSNotification*)noti
{
    NSDictionary *dic=noti.userInfo;
    
     pagelabel.text=[[NSString stringWithFormat:@"%@",dic[@"pageNo"]] stringByAppendingString:[NSString stringWithFormat:@"-%@",dic[@"pageSum"]]];
    

}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)viewWillAppear:(BOOL)animated
{

//    AppDelegate *app = [AppDelegate delegate];
//    rootViewController * nv = (rootViewController *)app.window.rootViewController;
//    [nv isHiddenCustomTabBarByBoolean:YES];
//       [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated
{
//    AppDelegate *app = [AppDelegate delegate];
//    rootViewController * nv = (rootViewController *)app.window.rootViewController;
//    [nv isHiddenCustomTabBarByBoolean:NO];
//    [super viewWillDisappear:animated];
}
- (void) viewDidUnload {
    
    [super viewDidUnload];
}
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
