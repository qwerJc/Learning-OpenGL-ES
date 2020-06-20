//
//  ViewController.m
//  Learning-OpenGLES
//
//  Created by 贾辰 on 2020/6/20.
//  Copyright © 2020 JJC. All rights reserved.
//

#import "ViewController.h"
#import "ViewController_CH2_1.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(10, 74.f, 80, 40)];
    btn1.backgroundColor = [UIColor redColor];
    [btn1 addTarget:self
             action:@selector(onShowChapter2)
   forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
}

- (void)onShowChapter2 {
    ViewController_CH2_1 *vc = [[ViewController_CH2_1 alloc] init];
    vc.modalPresentationStyle = 0;
    [self presentViewController:vc
                       animated:YES
                     completion:^{}];

}
@end
