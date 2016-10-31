//
//  SJIndicatorView.m
//  Haozhanggui
//
//  Created by Sim Jin on 2016/10/31.
//  Copyright © 2016年 UFunnetwork. All rights reserved.
//

#import "SJIndicatorView.h"

@interface SJIndicatorView ()
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@end

@implementation SJIndicatorView

- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)aText {
    self = [super initWithFrame:frame];
    if (self) {
        self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.indicatorView.bounds = CGRectMake(0, 0, 60, 60);
        self.indicatorView.center = self.center;
        [self.indicatorView startAnimating];
        [self addSubview:self.indicatorView];

        UILabel *label = [[UILabel alloc] init];
        label.text = aText;
        label.font = [UIFont systemFontOfSize:13];
        label.center = CGPointMake(self.center.x, self.center.y + self.indicatorView.frame.size.height / 2 + 10);
        label.bounds = CGRectMake(0, 0, self.frame.size.width, 20);
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
    }
    return self;
}

- (void)setHidden:(BOOL)hidden {
    [self.indicatorView stopAnimating];
}

@end
