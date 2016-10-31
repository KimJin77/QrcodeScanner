//
//  UIColor+RGB.h
//  ElectricBike
//
//  Created by Sim Jin on 2016/10/25.
//  Copyright © 2016年 UFunnetwork. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (RGB)

/**
 * @brief Get UIColor from rgba
 *
 * @return UIColor
 */
+ (UIColor *)colorWithR:(CGFloat)red g:(CGFloat)green b:(CGFloat)blue a:(CGFloat)alpha;

/**
 * @brief Get UIColor from rgb, alpha equal to 1
 *
 * @return UIColor
 */
+ (UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;

@end
