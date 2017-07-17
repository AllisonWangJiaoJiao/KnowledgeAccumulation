//
//  CALayer+Addition.h
//  YifengEnergy
//
//  Created by 吴强 on 2017/3/22.
//  Copyright © 2017年 ChongqingWirelessOasisCommunicationTechnology. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import <UIKit/UIKit.h>
@interface CALayer (Addition)

@property(nonatomic, strong) UIColor *borderColorFromUIColor;
@property(nonatomic, strong) UIColor *shadowColorFromUIColor;
- (void)setBorderColorFromUIColor:(UIColor *)color;
- (void)setShadowColorFromUIColor:(UIColor *)color;
@end

