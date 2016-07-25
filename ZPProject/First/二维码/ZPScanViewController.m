//
//  ZPScanViewController.m
//  ZPProject
//
//  Created by lizp on 16/6/23.
//  Copyright © 2016年 LZP. All rights reserved.
//

#import "ZPScanViewController.h"
#import "QRCodeReaderViewController.h"
#import "ZPScanResultViewController.h"

@interface ZPScanViewController ()<QRCodeReaderDelegate>

@end

@implementation ZPScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
#pragma mark -忽略ios新方法警告
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    if (![self cameraAvailable]) {
        UIAlertView* alert = [[UIAlertView alloc]
                              initWithTitle:@"提示"
                              message:@"设备不支持拍照功能;或权限被禁止,请在系统设置,个人隐私检测权限！"
                              delegate:nil
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:nil];
        [alert show]; 
        return;
    }
#pragma clang diagnostic pop
    
    QRCodeReaderViewController* reader = [[QRCodeReaderViewController alloc] init];
    reader.modalPresentationStyle = UIModalPresentationFormSheet;
    reader.delegate = self;
    reader.title = @"扫一扫";
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:reader animated:YES];
}


- (BOOL)cameraAvailable
{
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied || ![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        return NO;
    }
    
    return YES;
}


#pragma mark - QRCodeReaderDelegate
- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result {
    [reader stopScanning];
    
    if(result) {
    
        ZPScanResultViewController *scan = [[ZPScanResultViewController alloc] init];
        scan.relust = result;
        scan.title = @"扫描结果";
        [self.navigationController pushViewController:scan animated:YES];
    }
    
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
