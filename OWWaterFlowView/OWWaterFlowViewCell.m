//
//  OWWaterFlowViewCell.m
//  WaterFlowView
//
//  Created by Wyman Chen on 2016/11/29.
//  Copyright © 2016年 conpak. All rights reserved.
//

#import "OWWaterFlowViewCell.h"

@implementation OWWaterFlowViewCell

- (instancetype)initWithReusableIdentifier:(NSString *)identifier {
    OWWaterFlowViewCell *cell = [[OWWaterFlowViewCell alloc] init];
    cell.identifier = identifier;
    cell.clipsToBounds = YES;
    return cell;
}

@end
