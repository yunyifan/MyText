//
//  MainViewController.m
//  IRDVideo
//
//  Created by 貟一凡 on 2017/4/1.
//  Copyright © 2017年 貟一凡. All rights reserved.
//

#import "MainViewController.h"
#import "VideoPlayViewController.h"
#import "ImageScrollView.h"
#import "MainCollectionCell.h"
#import "WaterFlowLayout.h"


#import "MakeVideoViewController.h"
@interface MainViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,WaterFlowLayoutDelegate>

@property (nonatomic,strong)UICollectionView *collecView;

@property (nonatomic,strong)ImageScrollView *imgSc;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"精彩视频";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //  iOS 测试
    [self creatCollectionView];
}
-(void)creatCollectionView{

    WaterFlowLayout *layout = [[WaterFlowLayout alloc] init];
    // 定义大小
    layout.delegate = self;
    self.collecView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) collectionViewLayout:layout];
    self.collecView.backgroundColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1.0];
    self.collecView.dataSource = self;
    self.collecView.delegate = self;
    self.collecView.scrollEnabled = YES;
    [self.view addSubview:self.collecView];
    
    [self.collecView registerClass:[MainCollectionCell class] forCellWithReuseIdentifier:@"cell"];

    [self.collecView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell1"];

    [self creatScrollView];
    
}
-(void)creatScrollView{

    //轮播图
    
    self.imgSc  = [[ImageScrollView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, ViewHeight(200))];
    [self.imgSc.pics addObject:@"http://g.hiphotos.baidu.com/image/w%3D310/sign=6f9ce22079ec54e741ec1c1f89399bfd/9d82d158ccbf6c81cea943f6be3eb13533fa4015.jpg"];
    [self.imgSc.pics addObject:@"http://b.hiphotos.baidu.com/image/pic/item/4bed2e738bd4b31cc6476eb985d6277f9e2ff8bd.jpg"];
    [self.imgSc.pics addObject:@"http://c.hiphotos.baidu.com/image/pic/item/94cad1c8a786c9174d18e030cb3d70cf3bc7579b.jpg"];
    [self.collecView addSubview:self.imgSc];

    //点击事件
    [self.imgSc returnIndex:^(NSInteger index) {
        NSLog(@"点击了第%zi张", index);
        
        MakeVideoViewController *makeVc = [[MakeVideoViewController alloc] init];
        [self.navigationController pushViewController:makeVc animated:YES];
        
    }];
    //刷新（必需的步骤）
    self.imgSc.openTimer = YES;
    [self.imgSc reloadView];

}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.item == 1) {
        UICollectionViewCell *cell = [self.collecView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
        
        cell.backgroundColor = [UIColor brownColor];
        
        return cell;

 
    }else{
        MainCollectionCell *cell = [self.collecView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        
        cell.backgroundColor = [UIColor redColor];
        return cell;

    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    VideoPlayViewController *videoPaly = [[VideoPlayViewController alloc] init];
    [self.navigationController pushViewController:videoPaly animated:YES];
    
}
#pragma mark -- WaterFlowLayoutDelegate -

-(CGFloat)waterflowLayout:(WaterFlowLayout *)waterflowLayout heightForItemAtIndex:(NSInteger)index itemWidth:(CGFloat)itemWidth{
    
    if (index == 1) {
        return DEF_SCREEN_WIDTH/2-60;
    }else{
    
        return DEF_SCREEN_WIDTH/2-2;
    }
}


//- (CGFloat)rowMarginInWaterflowLayout:(WaterFlowLayout *)waterflowLayout
//{
//    return 10;
//}
//
//- (CGFloat)columnCountInWaterflowLayout:(WaterFlowLayout *)waterflowLayout
//{
//    return 3;
//}
//
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(WaterFlowLayout *)waterflowLayout
{
    return UIEdgeInsetsMake(ViewHeight(200), 0, 0, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
