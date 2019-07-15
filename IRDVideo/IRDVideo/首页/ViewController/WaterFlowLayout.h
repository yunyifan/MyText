//
//  WaterFlowLayout.h
//  IRDVideo
//
//  Created by 貟一凡 on 2017/4/5.
//  Copyright © 2017年 貟一凡. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WaterFlowLayout;

@protocol WaterFlowLayoutDelegate <NSObject>

@required

-(CGFloat)waterflowLayout:(WaterFlowLayout *)waterflowLayout heightForItemAtIndex:(NSInteger)index itemWidth:(CGFloat)itemWidth;

@optional

-(CGFloat)columnCountInWaterflowLayout:(WaterFlowLayout *)waterflowLayout;

-(CGFloat)columnMarginInWaterflowLayout:(WaterFlowLayout *)waterflowLayout;

-(CGFloat)rowMarginInWaterflowLayout:(WaterFlowLayout *)waterflowLayout;

-(UIEdgeInsets)edgeInsetsInWaterflowLayout:(WaterFlowLayout *)waterflowLayout;


@end

@interface WaterFlowLayout : UICollectionViewLayout

@property (nonatomic, weak) id <WaterFlowLayoutDelegate >delegate;

@end
