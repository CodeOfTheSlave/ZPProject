//
//  ZPQRCodeViewController.m
//  ZPProject
//
//  Created by lizp on 16/6/23.
//  Copyright © 2016年 LZP. All rights reserved.
//

#import "ZPQRCodeViewController.h"

@interface ZPQRCodeViewController ()

@end

@implementation ZPQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"二维码";
    self.view.backgroundColor = [UIColor blackColor];
    self.view.alpha = 0.5;
    
    
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, kScreenWidth - 2 * 100, kScreenWidth - 2 * 100)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 2 * 110, kScreenWidth - 2 * 110)];
    [view addSubview:imageView];
    
    UIImage* qrImage = [self createQRImageWithString:@"这是你的二维码" size:CGSizeMake(kScreenWidth - 2 * 110, kScreenWidth - 2 * 110)];
    imageView.image = qrImage;

}

- (UIImage*)createQRImageWithString:(NSString*)qrString size:(CGSize)size
{
    
    // Need to convert the string to a UTF-8 encoded NSData object
    NSData* stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    // Create the filter
    CIFilter* qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // Set the message content and error-correction level
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    
    CGRect extent = CGRectIntegral(qrFilter.outputImage.extent);
    CGFloat scale = MIN(size.width / CGRectGetWidth(extent), size.height / CGRectGetHeight(extent));
    // create a bitmap image that we'll draw into a bitmap context at the desired size;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext* context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:qrFilter.outputImage fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // Create an image with the contents of our bitmap
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    // Cleanup
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}




@end
