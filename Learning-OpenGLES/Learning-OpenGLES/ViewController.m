//
//  ViewController.m
//  Learning-OpenGLES
//
//  Created by 贾辰 on 2020/6/20.
//  Copyright © 2020 JJC. All rights reserved.
//

#import "ViewController.h"
#import "ViewController_CH2_1.h"
#import "ViewController_CH2_3.h"
#import "ViewController_CH3_1.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(10, 74.f, 80, 40)];
    btn1.backgroundColor = [UIColor redColor];
    [btn1 setTitle:@"Ch2-1" forState:UIControlStateNormal];
    [btn1 addTarget:self
             action:@selector(onShowChapter2_1)
   forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(100, 74.f, 80, 40)];
    btn2.backgroundColor = [UIColor redColor];
    [btn2 setTitle:@"Ch2-3" forState:UIControlStateNormal];
    [btn2 addTarget:self
             action:@selector(onShowChapter2_3)
   forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(10, 130.f, 80, 40)];
    btn3.backgroundColor = [UIColor redColor];
    [btn3 setTitle:@"Ch3-1" forState:UIControlStateNormal];
    [btn3 addTarget:self
             action:@selector(onShowChapter3_1)
   forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
}

- (void)onShowChapter2_1 {
    ViewController_CH2_1 *vc = [[ViewController_CH2_1 alloc] init];
    vc.modalPresentationStyle = 0;
    [self presentViewController:vc
                       animated:YES
                     completion:^{}];

}

- (void)onShowChapter2_3 {
    ViewController_CH2_3 *vc = [[ViewController_CH2_3 alloc] init];
    vc.modalPresentationStyle = 0;
    [self presentViewController:vc animated:YES completion:^{}];

}

- (void)onShowChapter3_1 {
    ViewController_CH3_1 *vc = [[ViewController_CH3_1 alloc] init];
    vc.modalPresentationStyle = 0;
    [self presentViewController:vc
                       animated:YES
                     completion:^{}];
}
@end
