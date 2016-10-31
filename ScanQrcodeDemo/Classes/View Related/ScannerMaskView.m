//
//  ScannerMaskView.m
//  Haozhanggui
//
//  Created by Sim Jin on 2016/10/31.
//  Copyright © 2016年 UFunnetwork. All rights reserved.
//

#import "ScannerMaskView.h"
#import "UIColor+RGB.h"

@interface ScannerMaskView ()
/// Scan crop rect
@property (nonatomic, assign) CGRect cropRect;
/// A line that indicated scanning
@property (nonatomic, strong) UIImageView *scanLine;
/// Timer that repeat move line
@property (nonatomic, strong) NSTimer *timer;
@end


@implementation ScannerMaskView {
    CGFloat _qrLineY;
    CGFloat _startPointY;
    CGFloat _endPointY;
}

- (instancetype)initWithFrame:(CGRect)frame cropFrame:(CGRect)aFrame {
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        self.cropRect = aFrame;
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        {
            self.scanLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scan_line"]];
            self.scanLine.frame = CGRectMake(aFrame.origin.x, aFrame.origin.y, aFrame.size.width, 3);
            [self addSubview:self.scanLine];
            _qrLineY = aFrame.origin.y;
            _startPointY = aFrame.origin.y;
            _endPointY = aFrame.origin.y + aFrame.size.height;
        }

        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.02
                                                      target:self
                                                    selector:@selector(startScanning)
                                                    userInfo:nil
                                                     repeats:YES];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // Fill the view
    [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8] set];
    CGContextAddRect(ctx, self.frame);
    CGContextFillPath(ctx);

    // Clear the center rect
    CGContextClearRect(ctx, self.cropRect);

    // Add a white border rectangle
    CGContextStrokeRect(ctx, self.cropRect);
    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(ctx, 0.8);
    CGContextAddRect(ctx, self.cropRect);
    CGContextStrokePath(ctx);
    
	// Add corner line
    CGContextSetLineWidth(ctx, 4.0);
    CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:12 green:120 blue:195].CGColor);
	// Top left
    CGFloat originX = self.cropRect.origin.x;
    CGFloat originY = self.cropRect.origin.y;
    CGFloat width = originX + self.cropRect.size.width;
    CGFloat height = originY + self.cropRect.size.height;
    CGPoint topLeftA[] = { CGPointMake(originX + 1, originY), CGPointMake(originX + 1, originY + 20)};
    CGPoint topLeftB[] = { CGPointMake(originX - 1, originY + 1), CGPointMake(originX - 1 + 20, originY + 1)};
    CGPoint topRightA[] = { CGPointMake(width - 1, originY), CGPointMake(width - 1, originY + 20)};
    CGPoint topRightB[] = { CGPointMake(width + 1, originY + 1), CGPointMake(width + 1 - 20, originY + 1)};
    CGPoint bottomLeftA[] = { CGPointMake(originX + 1, height - 20), CGPointMake(originX + 1, height + 1)};
    CGPoint bottomLeftB[] = { CGPointMake(originX, height - 1), CGPointMake(originX + 20, height - 1)};
    CGPoint bottomRightA[] = { CGPointMake(width - 1, height - 20), CGPointMake(width - 1, height + 1)};
    CGPoint bottomRightB[] = { CGPointMake(width, height - 1), CGPointMake(width - 20, height - 1)};
    CGContextAddLines(ctx, topLeftA, 2);
    CGContextAddLines(ctx, topLeftB, 2);
    CGContextAddLines(ctx, topRightA, 2);
    CGContextAddLines(ctx, topRightB, 2);
    CGContextAddLines(ctx, bottomLeftA, 2);
    CGContextAddLines(ctx, bottomLeftB, 2);
    CGContextAddLines(ctx, bottomRightA, 2);
    CGContextAddLines(ctx, bottomRightB, 2);
    CGContextStrokePath(ctx);

    // Description text
    NSString *descriptionText = @"将二维码放入框内，即可自动识别";
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *textAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14],
                                     NSForegroundColorAttributeName: [UIColor whiteColor],
                                     NSParagraphStyleAttributeName: paragraphStyle};
	[descriptionText drawInRect:CGRectMake(originX, height + 10, self.cropRect.size.width, 20)
                 withAttributes:textAttributes];

}

- (void)startScanning {
	[UIView animateWithDuration:0.02 animations:^{
        CGRect frame = self.scanLine.frame;
        frame.origin.y = _qrLineY;
        self.scanLine.frame = frame;
    } completion:^(BOOL finished) {
        if (_qrLineY >= _endPointY) {
            _qrLineY = _startPointY;
        }
        _qrLineY++;
    }];
}

- (void)stopScanning {
    [self.timer invalidate];
    self.timer = nil;
}


@end
