//
//  AMEQRScanViewController.h
//  TJSWorking
//
//  Created by ame on 2017/12/3.
//  Copyright © 2017年 tejisong. All rights reserved.
//

#import "AMEViewController.h"
#import "AMEQRScanView.h"
#import "AMEButton.h"
#import "QRCodeReader.h"


#define AME_QRSCAN_ALLTYPE @[AVMetadataObjectTypeUPCECode,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeCode39Mod43Code,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode93Code,AVMetadataObjectTypeCode128Code,AVMetadataObjectTypePDF417Code,AVMetadataObjectTypeQRCode,AVMetadataObjectTypeAztecCode,AVMetadataObjectTypeInterleaved2of5Code,AVMetadataObjectTypeITF14Code,AVMetadataObjectTypeDataMatrixCode]

@class AMEQRScanViewController;
@protocol AMEQRScanViewControllerDelegate <NSObject>

@optional
- (void)ame_QRScanViewController:(AMEQRScanViewController *)viewController didGetResult:(NSString *)result;

@end

@interface AMEQRScanViewController : AMEViewController

@property (strong, nonatomic, readonly) QRCodeReader * codeReader;

@property (nonatomic, strong) AMEQRScanView * scanView;

@property (nonatomic, weak) id<AMEQRScanViewControllerDelegate> delegate;

@property (nonatomic, strong) CALayer * maskLayer;

@property (nonatomic, strong) AMEButton * fightButton;
@end
