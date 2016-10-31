//
//  UIColor+HexString.m
//  ElectricBike
//
//  Created by Sim Jin on 2016/10/25.
//  Copyright © 2016年 UFunnetwork. All rights reserved.
//

#import "UIColor+HexString.h"
#import "UIColor+RGB.h"

@implementation UIColor (HexString)

+ (UIColor *)colorWithHexString:(NSString *)hexString {
    NSAssert([hexString containsString:@"#"], @"The string isn't a valid hex");
    NSAssert((hexString.length != 4 || hexString.length != 7), @"The string isn't a valid hex");

    if (hexString.length == 4) {
		// While length of the string is 4, should judge the other 3 character is equal
        unichar firstChar = [hexString characterAtIndex:1];
        unichar secondChar = [hexString characterAtIndex:2];
        unichar lastChar = [hexString characterAtIndex:3];
        NSAssert((firstChar != secondChar || secondChar != lastChar || firstChar != lastChar), @"The string isn't a valid hex");
        CGFloat hexNum = [[NSNumber numberWithChar:firstChar] floatValue];
        CGFloat hex = hexNum * 16 + hexNum;
        return [UIColor colorWithRed:hex/255 green:hex/255 blue:hex/255 alpha:hex/255];
    } else {
        NSMutableArray *nums = [[NSMutableArray alloc] init];
        for (int i = 1; i < 6; i += 2) {
            NSString *s = [hexString substringWithRange:NSMakeRange(i, 2)];
            NSScanner *scanner = [NSScanner scannerWithString:s];
            unsigned int value = 0;
            [scanner scanHexInt:&value];
            [nums addObject:[NSNumber numberWithUnsignedInt:value]];
        }
        CGFloat red = [nums[0] floatValue] / 255;
		CGFloat green = [nums[1] floatValue] / 255;
        CGFloat blue = [nums[2] floatValue] / 255;
        return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    }
}

@end
