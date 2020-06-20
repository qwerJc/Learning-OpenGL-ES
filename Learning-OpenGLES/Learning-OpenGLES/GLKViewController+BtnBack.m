//
//  GLKViewController+BtnBack.m
//  Learning-OpenGLES
//
//  Created by 贾辰 on 2020/6/20.
//  Copyright © 2020 JJC. All rights reserved.
//

#import "GLKViewController+BtnBack.h"

@implementation GLKViewController (BtnBack)
- (void)addBtnBackOnView:(UIView *)view {
    UIButton *btnBack = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 64, 44)];
    [btnBack setTitle:@"返回" forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(onBackAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnBack];
}

- (void)onBackAction {
    [self dismissViewControllerAnimated:YES
                             completion:^{
    }];
}
@end
