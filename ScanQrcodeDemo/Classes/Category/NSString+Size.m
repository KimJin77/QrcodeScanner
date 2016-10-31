//
//  NSString+Size.m
//  ElectricBike
//
//  Created by Sim Jin on 2016/10/26.
//  Copyright © 2016年 UFunnetwork. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)

+ (CGFloat)heightOfString:(NSString *)string withAttributes:(NSDictionary *)attributes {
    return [string sizeWithAttributes:attributes].height;
}

+ (CGFloat)widthOfString:(NSString *)string withAttributes:(NSDictionary *)attributes {
	return [string sizeWithAttributes:attributes].width;
}


@end
