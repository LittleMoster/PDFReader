//
//  ViewController.m
//  PDFViewTest
//
//  Created by cguo on 2017/4/29.
//  Copyright © 2017年 YX. All rights reserved.
//

#import "ViewController.h"
#import "ZPDFReaderController.h"
#import "RNEncryptor.h"
#import "PushView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    PushView *view=[[PushView alloc]init];
    
    
    [self.view addSubview:view];
    

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://edu.yonxin.com/data/upload/2017/0221/18/58ac191705827.pdf"]];
    
    NSString *path=[[NSBundle mainBundle]pathForResource:@"001" ofType:@"pdf"];
    NSData *pathpata=[NSData dataWithContentsOfFile:path];
    NSLog(@"%@",path);
    NSLog(@"%@",pathpata);
    NSError *error;
    NSData *encryData=[RNEncryptor encryptData:data withSettings:kRNCryptorAES256Settings password:@"123456" error:&error];
    NSLog(@"%@",encryData);
    ZPDFReaderController *ctl=[[ZPDFReaderController alloc]init];
    
    ctl.titleText=@"pdf";
//    ctl.fileName=@"http://edu.yonxin.com/data/upload/2017/0221/18/58ac191705827.pdf";
    ctl.fileName=@"001.pdf";
    [self.navigationController pushViewController:ctl animated:YES];
    

}



@end
