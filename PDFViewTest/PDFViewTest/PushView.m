//
//  PushView.m
//  PDFViewTest
//
//  Created by cguo on 2017/5/15.
//  Copyright © 2017年 YX. All rights reserved.
//

#import "PushView.h"
#import "UIView+Extension.h"
#import "AnitamViewController.h"

@implementation PushView

-(instancetype)init
{
    if (self==[super init]) {
        self=[[PushView alloc]initWithFrame:CGRectMake(10, 80, 100, 100)];
        self.backgroundColor=[UIColor redColor];
        [self getViewbtn];
    }
              return self;
}


-(void)getViewbtn
{
    UIButton *btn=[[UIButton alloc]init];
    btn.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    [btn addTarget:self action:@selector(pushController) forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:btn];
}

-(void)pushController
{

    NSLog(@"%@",self.viewController);
    AnitamViewController *anitamView=[[AnitamViewController alloc]init];

    [self pushToNavtionViewController:anitamView anitam:Random];
    
//    [self.viewController.navigationController popViewControllerAnimated:YES];
}
              
@end
