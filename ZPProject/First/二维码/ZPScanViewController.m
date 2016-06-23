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
    
    QRCodeReaderViewController* reader = [[QRCodeReaderViewController alloc] init];
    reader.modalPresentationStyle = UIModalPresentationFormSheet;
    reader.delegate = self;
    reader.title = @"扫一扫";
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:reader animated:YES];
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
