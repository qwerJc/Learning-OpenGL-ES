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
#import "ViewController_CH2_Practice.h"

#import "ViewController_CH3_1.h"
#import "ViewController_CH3_2.h"

#import "ViewController_CH4_1.h"

#import "ViewController_CH5_1.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createChapter2Btn];
    
    [self createChapter3Btn];
    
    [self createChapter4Btn];
    
    [self createChapter5Btn];
}

#pragma mark - Chapter 2
- (void)createChapter2Btn {
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
    
    UIButton *btn2Practice = [[UIButton alloc] initWithFrame:CGRectMake(200, 74.f, 120, 40)];
    btn2Practice.backgroundColor = [UIColor redColor];
    [btn2Practice setTitle:@"Ch2-Practice" forState:UIControlStateNormal];
    [btn2Practice addTarget:self
                     action:@selector(onShowChapter2_Practice)
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2Practice];
    
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

- (void)onShowChapter2_Practice {
    ViewController_CH2_Practice *vc = [[ViewController_CH2_Practice alloc] init];
    vc.modalPresentationStyle = 0;
    [self presentViewController:vc animated:YES completion:^{}];
}

#pragma mark - Chapter 3
- (void)createChapter3Btn {
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(10, 130.f, 80, 40)];
    btn1.backgroundColor = [UIColor redColor];
    [btn1 setTitle:@"Ch3-1" forState:UIControlStateNormal];
    [btn1 addTarget:self
             action:@selector(onShowChapter3_1)
   forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(100, 130.f, 80, 40)];
    btn2.backgroundColor = [UIColor redColor];
    [btn2 setTitle:@"Ch3-2" forState:UIControlStateNormal];
    [btn2 addTarget:self
             action:@selector(onShowChapter3_2)
   forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}

- (void)onShowChapter3_1 {
    ViewController_CH3_1 *vc = [[ViewController_CH3_1 alloc] init];
    vc.modalPresentationStyle = 0;
    [self presentViewController:vc
                       animated:YES
                     completion:^{}];
}

- (void)onShowChapter3_2 {
    ViewController_CH3_2 *vc = [[ViewController_CH3_2 alloc] init];
    vc.modalPresentationStyle = 0;
    [self presentViewController:vc animated:YES completion:^{}];
}

#pragma mark - Chapter 4
- (void)createChapter4Btn {
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(10, 230.f, 80, 40)];
    btn1.backgroundColor = [UIColor redColor];
    [btn1 setTitle:@"Ch4-1" forState:UIControlStateNormal];
    [btn1 addTarget:self
             action:@selector(onShowChapter4_1)
   forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(100, 230.f, 80, 40)];
    btn2.backgroundColor = [UIColor redColor];
    [btn2 setTitle:@"Ch4-2" forState:UIControlStateNormal];
    [btn2 addTarget:self
             action:@selector(onShowChapter4_2)
   forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}

- (void)onShowChapter4_1 {
    ViewController_CH4_1 *vc = [[ViewController_CH4_1 alloc] init];
    vc.modalPresentationStyle = 0;
    [self presentViewController:vc
                       animated:YES
                     completion:^{}];
}

- (void)onShowChapter4_2 {
    ViewController_CH4_1 *vc = [[ViewController_CH4_1 alloc] init];
    vc.modalPresentationStyle = 0;
    [self presentViewController:vc
                       animated:YES
                     completion:^{}];
}

#pragma mark - Chapter 5
- (void)createChapter5Btn {
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(10, 300.f, 80, 40)];
    btn1.backgroundColor = [UIColor redColor];
    [btn1 setTitle:@"Ch5-1" forState:UIControlStateNormal];
    [btn1 addTarget:self
             action:@selector(onShowChapter5_1)
   forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(100, 300.f, 80, 40)];
    btn2.backgroundColor = [UIColor redColor];
    [btn2 setTitle:@"Ch5-2" forState:UIControlStateNormal];
    [btn2 addTarget:self
             action:@selector(onShowChapter5_2)
   forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}

- (void)onShowChapter5_1 {
    ViewController_CH5_1 *vc = [[ViewController_CH5_1 alloc] init];
    vc.modalPresentationStyle = 0;
    [self presentViewController:vc
                       animated:YES
                     completion:^{}];
}

- (void)onShowChapter5_2 {
//    ViewController_CH4_1 *vc = [[ViewController_CH4_1 alloc] init];
//    vc.modalPresentationStyle = 0;
//    [self presentViewController:vc
//                       animated:YES
//                     completion:^{}];
}
@end
