//
//  NSString+Size.h
//  ElectricBike
//
//  Created by Sim Jin on 2016/10/26.
//  Copyright © 2016年 UFunnetwork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Size)

/**
 * @brief String height with attributes
 *
 * @param string String
 * @param attributes Attributes
 *
 * @return String height
 */
+ (CGFloat)heightOfString:(NSString *)string withAttributes:(NSDictionary *)attributes;

/**
 * @brief String width with attributes
 *
 * @param string String
 * @param attributes Attributes
 *
 * @return String width
 */
+ (CGFloat)widthOfString:(NSString *)string withAttributes:(NSDictionary *)attributes;

@end
