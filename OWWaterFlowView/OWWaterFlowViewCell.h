//
//  OWWaterFlowViewCell.h
//  WaterFlowView
//
//  Created by Wyman Chen on 2016/11/29.
//  Copyright © 2016年 conpak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OWWaterFlowViewCell : UIView

@property (nonatomic, copy) NSString *identifier;

- (instancetype)initWithReusableIdentifier:(NSString *)identifier;

@end
