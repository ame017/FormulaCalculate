//
//  AMEQRScanViewController.m
//  TJSWorking
//
//  Created by ame on 2017/12/3.
//  Copyright © 2017年 tejisong. All rights reserved.
//

#import "AMEQRScanViewController.h"

@interface AMEQRScanViewController ()<CALayerDelegate>

@end

@implementation AMEQRScanViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.title = @"扫描";
        //扫码器
        QRCodeReader *reader = [QRCodeReader readerWithMetadataObjectTypes:AME_QRSCAN_ALLTYPE];
        _codeReader = reader;
        __weak __typeof__(self) weakSelf = self;
        [_codeReader setCompletionWithBlock:^(NSString *resultAsString) {
//            NSLog(@"resultAsString--->%@",resultAsString);
            if (kDelegateEnable(weakSelf.delegate, @selector(ame_QRScanViewController:didGetResult:))) {
                [weakSelf.delegate ame_QRScanViewController:weakSelf didGetResult:resultAsString];
            }
        }];
        [_codeReader.previewLayer setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kStatusBarAndNavigationBarHeight)];
        [self.view.layer insertSublayer:_codeReader.previewLayer atIndex:0];
        if ([_codeReader.previewLayer.connection isVideoOrientationSupported]) {
            UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
            _codeReader.previewLayer.connection.videoOrientation = [QRCodeReader videoOrientationFromInterfaceOrientation:orientation];
        }
        _codeReader.metadataOutput.rectOfInterest = CGRectMake(0, 0, (SCREEN_HEIGHT-kStatusBarAndNavigationBarHeight)/SCREEN_HEIGHT, 1);
        [_codeReader startScanning];
        
        //扫描框
        self.scanView = [[AMEQRScanView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 200)/2.0, (SCREEN_HEIGHT - 200 - kStatusBarAndNavigationBarHeight)/2.0, 200, 200)];
        [self.view addSubview:self.scanView];

        //蒙板
        self.maskLayer = [[CALayer alloc]init];
        self.maskLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kStatusBarAndNavigationBarHeight);
        self.maskLayer.delegate = self;
        [self.view.layer insertSublayer:self.maskLayer above:_codeReader.previewLayer];
        [self.maskLayer setNeedsDisplay];
        
        //手电筒
        self.fightButton = [AMEButton buttonWithType:AMEButtonTypeClean event:^(AMEButton *button) {
            if ([_codeReader isTorchAvailable]) {
                [_codeReader toggleTorch];
            }else{
                [SVProgressHUD showInfoWithStatus:@"该设备不支持手电筒"];
            }
        }];
        [self.fightButton setBackgroundImage:[UIImage imageNamed:@"scan_open_flashlight"] forState:UIControlStateNormal];
        self.fightButton.frame = CGRectMake((SCREEN_WIDTH-46.5)/2.0, SCREEN_HEIGHT-kStatusBarAndNavigationBarHeight-44.5-50, 46.5, 44.5);
        [self.view addSubview:self.fightButton];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.codeReader stopScanning];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//蒙板生成
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    if (layer == self.maskLayer) {
        UIGraphicsBeginImageContextWithOptions(self.maskLayer.frame.size, NO, 1.0);
        CGContextSetFillColorWithColor(ctx, [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6].CGColor);
        CGContextFillRect(ctx, self.maskLayer.frame);
        CGRect scanFrame = [self.view convertRect:self.scanView.frame fromView:self.scanView.superview];
        CGContextClearRect(ctx, scanFrame);
    }
}
@end
