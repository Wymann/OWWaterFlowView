//
//  OWWaterFlowView.h
//  WaterFlowView
//
//  Created by Wyman Chen on 2016/11/29.
//  Copyright © 2016年 conpak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OWWaterFlowViewCell.h"

typedef NS_ENUM(NSInteger, OWWaterFlowMarginType) {
    WaterFlowMarginType_Top = 0,
    WaterFlowMarginType_Left,
    WaterFlowMarginType_Bottom,
    WaterFlowMarginType_Right,
    WaterFlowMarginType_Colum,
    WaterFlowMarginType_Row,
};

@class OWWaterFlowView;

@protocol OWWaterFlowViewDataSource <NSObject>

@required
- (CGFloat)numberOfCellsOnWaterflowView:(OWWaterFlowView *)waterflowView;
- (OWWaterFlowViewCell *)waterflowView:(OWWaterFlowView *)waterflowView cellAtIndex:(NSUInteger)index;

@optional
- (CGFloat)numberOfColumsOnWaterflowView:(OWWaterFlowView *)waterflowView;

@end

@protocol OWWaterFlowViewDelegate <UIScrollViewDelegate>

@optional
- (CGFloat)waterflowView:(OWWaterFlowView *)waterflowView heightAtIndex:(NSUInteger)index;
- (CGFloat)waterflowView:(OWWaterFlowView *)waterflowView marginForType:(OWWaterFlowMarginType)type;
- (void)waterflowView:(OWWaterFlowView *)waterflowView didSelectedCellAtIndex:(NSUInteger)index;

@end

@interface OWWaterFlowView : UIScrollView

@property (nonatomic, weak) id <OWWaterFlowViewDataSource> dataSource;
@property (nonatomic, weak) id <OWWaterFlowViewDelegate> delegate;

@end
