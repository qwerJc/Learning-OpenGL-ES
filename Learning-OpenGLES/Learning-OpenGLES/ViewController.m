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
#import "ViewController_CH5_4.h"

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, nonatomic) NSArray *arrData;
@end

@implementation ViewController

- (void)createData {
    _arrData = [NSArray arrayWithObjects:@"Ch2-1",@"Ch2-3",@"Ch2-Try",@"Ch3-1",@"Ch3-2",@"Ch4-1",@"Ch4-2",@"Ch5-1",@"Ch5-4",nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createData];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 4.0;
    layout.minimumInteritemSpacing = 4.0;
    
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectMake(10., 84, 355, 500)
                                                      collectionViewLayout:layout];
    [collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"VideoListCollectionViewCell"];
    collection.delegate = self;
    collection.backgroundColor = [UIColor clearColor];
    collection.dataSource = self;
    collection.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:collection];
    
}

#pragma mark - collection datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _arrData.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VideoListCollectionViewCell" forIndexPath:indexPath];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = _arrData[indexPath.row];
    [label sizeToFit];
    label.center = CGPointMake(CGRectGetWidth(cell.frame)/2, CGRectGetHeight(cell.frame)/2);
    [cell addSubview:label];
    
    cell.backgroundColor = [UIColor colorWithRed:(arc4random()%10)*0.1f
                                          green:(arc4random()%10)*0.1f
                                           blue:(arc4random()%10)*0.1f
                                          alpha:1.f];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = 375 / 5;
    return CGSizeMake(width, width);
}

#pragma mark - collection delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *title = _arrData[indexPath.row];
    
    if ([title isEqualToString:@"Ch2-1"]) {
        [self onShowChapter2_1];
        
    } else if ([title isEqualToString:@"Ch2-3"]) {
        [self onShowChapter2_3];
        
    } else if ([title isEqualToString:@"Ch2-Try"]) {
        [self onShowChapter2_Practice];
        
    } else if ([title isEqualToString:@"Ch2-Try"]) {
        [self onShowChapter2_Practice];
        
    } else if ([title isEqualToString:@"Ch3-1"]) {
        [self onShowChapter3_1];
        
    } else if ([title isEqualToString:@"Ch3-2"]) {
        [self onShowChapter3_2];
        
    } else if ([title isEqualToString:@"Ch4-1"]) {
        [self onShowChapter4_1];
        
    } else if ([title isEqualToString:@"Ch4-2"]) {
        [self onShowChapter4_2];
        
    } else if ([title isEqualToString:@"Ch5-1"]) {
        [self onShowChapter5_1];
        
    } else if ([title isEqualToString:@"Ch5-4"]) {
        [self onShowChapter5_4];
        
    }
}

#pragma mark - Show Chapter
- (void)onShowChapter5_1 {
    ViewController_CH5_1 *vc = [[ViewController_CH5_1 alloc] init];
    vc.modalPresentationStyle = 0;
    [self presentViewController:vc
                       animated:YES
                     completion:^{}];
}

- (void)onShowChapter5_4 {
    ViewController_CH5_4 *vc = [[ViewController_CH5_4 alloc] init];
    vc.modalPresentationStyle = 0;
    [self presentViewController:vc
                       animated:YES
                     completion:^{}];
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


@end
