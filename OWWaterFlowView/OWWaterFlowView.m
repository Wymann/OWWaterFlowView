//
//  OWWaterFlowView.m
//  WaterFlowView
//
//  Created by Wyman Chen on 2016/11/29.
//  Copyright © 2016年 conpak. All rights reserved.
//

#import "OWWaterFlowView.h"

#define self_width self.frame.size.width
#define self_height self.frame.size.height

#define OWWaterflowViewDefaultColum 2
#define OWWaterflowViewDefaultMargin 5
#define OWWaterflowViewDefaultHeight 70

@interface OWWaterFlowView ()

@property (nonatomic, strong) NSMutableArray *cellFrames;
@property (nonatomic, strong) NSMutableDictionary *displayingCells;
@property (nonatomic, strong) NSMutableSet *reusableCells;

@end

@implementation OWWaterFlowView
@dynamic delegate;

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger numberOfCells = self.cellFrames.count;
    for (int i = 0; i < numberOfCells; i++) {
        CGRect frame = [self.cellFrames[i] CGRectValue];
        OWWaterFlowViewCell *cell = self.displayingCells[@(i)];
        if ([self isOnScreen:frame]) {
            if (cell == nil) {
                cell = [self.dataSource waterflowView:self cellAtIndex:i];
                cell.frame = frame;
                [self addSubview:cell];
                self.displayingCells[@(i)] = cell;
            }
        }else {
            if (cell) {
                [cell removeFromSuperview];
                [self.displayingCells removeObjectForKey:@(i)];
                [self.reusableCells addObject:cell];
            }
        }
    }
}

- (void)loadData
{
    [self.displayingCells.allValues makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.displayingCells removeAllObjects];
    [self.cellFrames removeAllObjects];
    [self.reusableCells removeAllObjects];
    
    NSUInteger numberOfCells = [self.dataSource numberOfCellsOnWaterflowView:self];
    NSUInteger numberOfColums = [self numberOfColums];
    CGFloat topMargin = [self marginForType:WaterFlowMarginType_Top];
    CGFloat leftMargin = [self marginForType:WaterFlowMarginType_Left];
    CGFloat bottomMargin = [self marginForType:WaterFlowMarginType_Bottom];
    CGFloat columMargin = [self marginForType:WaterFlowMarginType_Colum];
    CGFloat rowMargin = [self marginForType:WaterFlowMarginType_Row];
    CGFloat cellWidth = [self cellWidth];
    
    CGFloat maxYOfColums[numberOfColums];
    for (int i = 0; i < numberOfColums; i++) {
        maxYOfColums[i] = 0.0;
    }
    
    for (int i = 0; i < numberOfCells; i++) {
        
        NSUInteger cellColum = 0;
        CGFloat maxYOfCellColum = maxYOfColums[cellColum];
        for (int j = 1; j < numberOfColums; j++) {
            if (maxYOfColums[j] < maxYOfCellColum) {
                maxYOfCellColum = maxYOfColums[j];
                cellColum = j;
            }
        }
        
        CGFloat cellHeight = [self heightAtIndex:i];
        CGFloat cellX = leftMargin + cellColum * (cellWidth + columMargin);
        CGFloat cellY = 0;
        if (maxYOfCellColum == 0.0) {
            cellY = topMargin;
        }else {
            cellY = maxYOfCellColum + rowMargin;
        }
        
        CGRect frame = CGRectMake(cellX, cellY, cellWidth, cellHeight);
        [self.cellFrames addObject:[NSValue valueWithCGRect:frame]];
        
        maxYOfColums[cellColum] = CGRectGetMaxY(frame);
    }
    
    CGFloat contentH = maxYOfColums[0];
    for (int i = 1; i < numberOfColums; i++) {
        if (maxYOfColums[i] > contentH) {
            contentH = maxYOfColums[i];
        }
    }
    
    contentH += bottomMargin;
    self.contentSize = CGSizeMake(0, contentH);
}

- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier {
    __block OWWaterFlowViewCell *myCell = nil;
    [self.reusableCells enumerateObjectsUsingBlock:^(OWWaterFlowViewCell *cell, BOOL * _Nonnull stop) {
        if ([cell.identifier isEqualToString:identifier]) {
            myCell = cell;
            *stop = YES;
        }
    }];
    if (myCell) {
        [self.reusableCells removeObject:myCell];
    }
    return myCell;
}


-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [self loadData];
}

- (BOOL)isOnScreen:(CGRect)frame {
    return (CGRectGetMaxY(frame) > self.contentOffset.y) && (CGRectGetMinY(frame) < self.contentOffset.y + self.bounds.size.height);
}

- (NSUInteger)numberOfColums {
    if ([self.delegate respondsToSelector:@selector(numberOfColumsOnWaterflowView:)]) {
        return [self.dataSource numberOfColumsOnWaterflowView:self];
    }else {
        return OWWaterflowViewDefaultColum;
    }
}

- (CGFloat)marginForType:(OWWaterFlowMarginType)type {
    if ([self.delegate respondsToSelector:@selector(waterflowView:marginForType:)]) {
        return [self.delegate waterflowView:self marginForType:type];
    }else {
        return OWWaterflowViewDefaultMargin;
    }
}

- (CGFloat)heightAtIndex:(NSUInteger)index {
    if ([self.delegate respondsToSelector:@selector(waterflowView:heightAtIndex:)]) {
        return [self.delegate waterflowView:self heightAtIndex:index];
    }else {
        return OWWaterflowViewDefaultHeight;
    }
}

- (CGFloat)cellWidth {
    NSUInteger numberOfColums = [self numberOfColums];
    
    CGFloat leftMargin = [self marginForType:WaterFlowMarginType_Left];
    CGFloat rightMargin = [self marginForType:WaterFlowMarginType_Right];
    CGFloat columMargin = [self marginForType:WaterFlowMarginType_Colum];
    
    CGFloat cellWidth = (self_width - leftMargin - rightMargin - (numberOfColums - 1) * columMargin) / numberOfColums;
    return cellWidth;
}

- (NSMutableArray *)cellFrames {
    if (!_cellFrames) {
        _cellFrames = [NSMutableArray array];
    }
    return _cellFrames;
}

- (NSMutableDictionary *)displayingCells {
    if (!_displayingCells) {
        _displayingCells = [NSMutableDictionary dictionary];
    }
    return _displayingCells;
}

- (NSMutableSet *)reusableCells {
    if (!_reusableCells) {
        _reusableCells = [NSMutableSet set];
    }
    return _reusableCells;
}

@end
