//
//  ScannerMaskView.h
//  Haozhanggui
//
//  Created by Sim Jin on 2016/10/31.
//  Copyright © 2016年 UFunnetwork. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScannerMaskView : UIView
/// Description
@property (nonatomic, copy) NSString *desc;

/**
 * Init view
 *
 * @param frame Frame
 * @param aFrame Frame of center rectangle that would be cleared
 *
 * return self
 */
- (instancetype)initWithFrame:(CGRect)frame cropFrame:(CGRect)aFrame;
/// Stop scanning
- (void)stopScanning;
@end
