//
//  ViewController.m
//  ScanQrcodeDemo
//
//  Created by Sim Jin on 2016/10/31.
//  Copyright © 2016年 UFunnetwork. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ScannerMaskView.h"
#import "SJIndicatorView.h"

@interface ViewController ()<AVCaptureMetadataOutputObjectsDelegate>
/// AVCaptureSession Object that use to coordinate input and output
@property (nonatomic, strong) AVCaptureSession *captureSession;
/// Layer to see camera preview
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
/// Metadata output of camera
@property (nonatomic, strong) AVCaptureMetadataOutput *captureMetadataOutput;
/// Scan crop
@property (nonatomic, assign) CGRect scanCrop;
/// Mask view
@property (nonatomic, strong) ScannerMaskView *maskView;
@property (nonatomic, strong) UIView *topBarView;
@property (nonatomic, strong) SJIndicatorView *indicatorView;
@property (nonatomic, strong) UIButton *closeButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    {
        self.indicatorView = [[SJIndicatorView alloc] initWithFrame:self.view.bounds text:@"正在加载..."];
        [self.view addSubview:self.indicatorView];
    }

    {
        self.topBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:self.topBarView.bounds];
        titleLabel.text = @"二维码扫描";
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [self.topBarView addSubview:titleLabel];

        UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(16, 0, 44, 44)];
        [closeButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [closeButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateHighlighted];
        [closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        [self.topBarView addSubview:closeButton];
        [self.view addSubview:self.topBarView];
    }

    [self startScanning];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startScanning {
    // Find the input for default capture device
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if (!input) {
        NSLog(@"Failed to init capture input: %@", [error localizedDescription]);
        return;
    }

    self.captureSession = [[AVCaptureSession alloc] init];
    [self.captureSession addInput:input];

    // Add session output
    self.captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [self.captureSession addOutput:self.captureMetadataOutput];

    // Config metadata output
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("Scanner Queue", nil);
    [self.captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    [self.captureMetadataOutput setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];

    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.previewLayer.frame = self.view.bounds;

    dispatch_async(dispatchQueue, ^{
        [self.captureSession startRunning];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view.layer addSublayer:self.previewLayer];
            self.captureMetadataOutput.rectOfInterest = [self.previewLayer metadataOutputRectOfInterestForRect:self.scanCrop];
            self.maskView = [[ScannerMaskView alloc] initWithFrame:self.view.bounds cropFrame:self.scanCrop];
            [self.view addSubview:self.maskView];

            [self.view bringSubviewToFront:self.topBarView];
            [self.indicatorView removeFromSuperview];
        });
    });
}

- (void)close {
    [self.maskView stopScanning];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    NSLog(@"%@", metadataObjects);
}

#pragma mark - Lazy load
- (CGRect)scanCrop {
    if (CGRectEqualToRect(_scanCrop, CGRectZero)) {
        CGFloat width = self.view.frame.size.width * 3/5;
        CGFloat height = width;
        CGFloat x = self.view.frame.size.width / 5;
        CGFloat y = (self.view.frame.size.height - height) / 2;
        _scanCrop = CGRectMake(x, y, width, height);
    }
    return _scanCrop;
}

@end
