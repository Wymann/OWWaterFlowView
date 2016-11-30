//
//  ViewController.m
//  WaterFlowView
//
//  Created by Wyman Chen on 2016/11/29.
//  Copyright © 2016年 conpak. All rights reserved.
//

#import "ViewController.h"
#import "OWWaterFlowView.h"

@interface ViewController ()<OWWaterFlowViewDelegate, OWWaterFlowViewDataSource>

@property (nonatomic, strong) NSArray *imagesArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _imagesArr = @[@"01.JPG", @"02.png", @"03.JPG", @"04.jpg", @"05.png", @"06.jpg", @"07.png", @"08.jpg", @"09.jpg", @"10.jpg", @"11.png", @"12.jpg", @"13.jpg", @"14.jpg", @"15.jpg", @"16.jpg", @"17.jpg", @"18.jpg", @"19.jpg", @"20.jpg", @"21.png", @"22.jpg", @"23.jpg"];
    
    OWWaterFlowView *waterFlowView = [[OWWaterFlowView alloc] init];
    waterFlowView.delegate = self;
    waterFlowView.dataSource = self;
    waterFlowView.frame = CGRectMake(0, 20.0, self.view.frame.size.width, self.view.frame.size.height - 20.0);
    [self.view addSubview:waterFlowView];
}

#pragma mark - XBWaterflowViewDataSource
// 总共的列数(默认是两列)
- (CGFloat)numberOfColumsOnWaterflowView:(OWWaterFlowView *)waterflowView {
    return 3;
}

// cell的个数
- (CGFloat)numberOfCellsOnWaterflowView:(OWWaterFlowView *)waterflowView {
    return _imagesArr.count;
}

// 每个index位置的cell
- (OWWaterFlowViewCell *)waterflowView:(OWWaterFlowView *)waterflowView cellAtIndex:(NSUInteger)index{
    static NSString *reuseIdentifier = @"cell";
    OWWaterFlowViewCell *cell = [waterflowView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[OWWaterFlowViewCell alloc] initWithReusableIdentifier:reuseIdentifier];
    }
    for (UIView *view in cell.subviews) {
        [view removeFromSuperview];
    }
    
    CGFloat width = (self.view.frame.size.width / 3 - 5.0 * 4 / 3);
    
    UIImage *image = [UIImage imageNamed:_imagesArr[index]];
    CGSize size = image.size;
    CGFloat height = size.height * (self.view.frame.size.width / 3 - 5.0 * 4 / 3)/size.width;
    
    CGSize scaledSize = CGSizeMake(width * 2.0, height * 2.0);
    
    UIImage *scaledImage = [self OriginImage:image scaleToSize:scaledSize];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:scaledImage];
    imageView.frame = CGRectMake(0, 0, width, height);
    [cell addSubview:imageView];
    return cell;
}

#pragma mark - XBWaterflowViewDelegate
// 每个index位置的高度
- (CGFloat)waterflowView:(OWWaterFlowView *)waterflowView heightAtIndex:(NSUInteger)index {
    // 随机高度
    UIImage *image = [UIImage imageNamed:_imagesArr[index]];
    CGSize size = image.size;
    return size.height * (self.view.frame.size.width / 3 - 5.0 * 4 / 3)/size.width;
}

// 间距(可以设置上,左,下,右,列,行间距)有默认间距
- (CGFloat)waterflowView:(OWWaterFlowView *)waterflowView marginForType:(OWWaterFlowMarginType)type {
    switch (type) {
        case WaterFlowMarginType_Top: return 5.0;
        case WaterFlowMarginType_Left: return 5.0;
        case WaterFlowMarginType_Bottom: return 5.0;
        case WaterFlowMarginType_Right: return 5.0;
        case WaterFlowMarginType_Colum: return 5.0;
        case WaterFlowMarginType_Row: return 5.0;
        default: return arc4random_uniform(10);
    }
}

// 点击cell
- (void)waterflowView:(OWWaterFlowView *)waterflowView didSelectedCellAtIndex:(NSUInteger)index {
    NSLog(@"%ld", index);
}

// 随机色
- (UIColor *)randomColor {
    CGFloat r = arc4random_uniform(256) / 255.0;
    CGFloat g = arc4random_uniform(256) / 255.0;
    CGFloat b = arc4random_uniform(256) / 255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0];
}


//等比例缩放
-(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

@end
