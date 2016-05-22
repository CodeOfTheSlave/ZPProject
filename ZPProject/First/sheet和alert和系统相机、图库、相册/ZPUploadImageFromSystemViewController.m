//
//  ZPUploadImageFromSystemViewController.m
//  ZPProject
//
//  Created by lizp on 16/4/1.
//  Copyright © 2016年 Apple05. All rights reserved.
//

#import "ZPUploadImageFromSystemViewController.h"


@interface ZPUploadImageFromSystemViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,weak) UIImagePickerController *pickek;
@property (nonatomic,strong) UIImageView *imageView ;

@end

@implementation ZPUploadImageFromSystemViewController

- (UIImageView *)imageView {
    if(!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        [self.view addSubview:_imageView];
    }
    return _imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIImagePickerController *pickek = [[UIImagePickerController alloc] init];
    pickek.delegate = self;
    
    
    //属性 mediaTypes ，设置相机支持的类型，拍照和录像, 默认为public.image 拍照
    pickek.mediaTypes = @[@"public.image",@"public.movie"];
    for (NSString *str in pickek.mediaTypes) {
        NSLog(@"%@",str );
    }
    
    //是否允许照片编辑 ,默认NO (即剪裁图片)
    pickek.allowsEditing = NO;
    //设置录像最大时长 （默认十分钟）
    pickek.videoMaximumDuration = 100;//100秒
    //设置录像质量 ,默认UIImagePickerControllerQualityTypeMedium
    pickek.videoQuality  = UIImagePickerControllerQualityTypeIFrame960x540;
   
    
   
    
    
#if 0
    //检查设备是否有后置摄像头
    BOOL rear = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
    NSLog(@"%d",rear);
    //检查设备是否有前置摄像头
    rear = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
    NSLog(@"%d",rear);
    //检查支持的媒体类型
    NSArray *arr = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    for (NSString *str in arr) {
        
        NSLog(@"%@",str);
        if([str isEqualToString:@"public.image"]) {
            NSLog(@"支持拍照");
        }else if ([str isEqualToString:@"public.movie"]){
            NSLog(@"支持录像");
        }
    }
    
    // 摄像头设备是否支持闪光灯和手电筒
    rear = [UIImagePickerController isFlashAvailableForCameraDevice:UIImagePickerControllerCameraDeviceRear];
    NSLog(@"%i",rear);
    
    //返回照相机、相册、照片库   所支持的媒体类型  ,返回类型有照片和视频
    
   arr =  [UIImagePickerController availableCaptureModesForCameraDevice:UIImagePickerControllerCameraDeviceRear];
    for (NSNumber *number in arr) {
        NSLog(@"%@",number);
        if([number integerValue] == UIImagePickerControllerCameraCaptureModePhoto) {
            NSLog(@"支持媒体类型：照片");
        }else if([number integerValue] == UIImagePickerControllerCameraCaptureModeVideo) {
            NSLog(@"支持媒体类型:视频");
        }
        
    }
    
#endif
 
    UIAlertController *alertControll = [UIAlertController alertControllerWithTitle:nil message:@"请选择图片来源" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cameraAction  = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        
        //检查设备是否有摄像设备
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            pickek.sourceType = UIImagePickerControllerSourceTypeCamera;
            //设置是否显示 拍照时，与用户的交互的UI （如，取消，确定等）设置showsCameraControls时， sourceType的类型必须为UIImagePickerControllerSourceTypeCamera  否则程序会崩溃
            pickek.showsCameraControls = YES;
            
            //之定义一些界面  覆盖在相机的界面上，设置时sourceType的类型必须为UIImagePickerControllerSourceTypeCamera
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
            view.backgroundColor = [UIColor lightGrayColor];
            pickek.cameraOverlayView = view;
            //设置设定图像缩放
            pickek.cameraViewTransform = CGAffineTransformScale(pickek.cameraViewTransform, 1.0, 1.0);
            self.pickek = pickek    ;
            
            
            // 获取  属性cameraCaptureMode 模式，1 照片 UIImagePickerControllerCameraCaptureModePhoto,  2 、录像UIImagePickerControllerCameraCaptureModeVideo
            //注意  获取该模式  必须设置 sourceType的类型必须为UIImagePickerControllerSourceTypeCamera
            if(pickek.cameraCaptureMode == UIImagePickerControllerCameraCaptureModePhoto) {
                NSLog(@"照片模式");
            }else if(pickek.cameraCaptureMode == UIImagePickerControllerCameraCaptureModeVideo) {
                NSLog(@"视频模式");
            }
            
            //获取摄像头
            if(pickek.cameraDevice == UIImagePickerControllerCameraDeviceFront) {
                NSLog(@"前置摄像头");
            }else if(pickek.cameraDevice == UIImagePickerControllerCameraDeviceRear) {
                NSLog(@"后置摄像头");
            }
            
            
            //获取闪光灯 模式
            if(pickek.cameraFlashMode == UIImagePickerControllerCameraFlashModeAuto) {
                NSLog(@"闪光灯自动");
            }else if (pickek.cameraFlashMode == UIImagePickerControllerCameraFlashModeOff) {
                NSLog(@"闪光灯关闭");
            }else if(pickek.cameraFlashMode == UIImagePickerControllerCameraFlashModeOn) {
                NSLog(@"闪光灯打开");
            }

            //图像捕获
            [pickek takePicture];
            [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timeClick) userInfo:nil repeats:NO];
            
            


            [self presentViewController:pickek animated:YES completion:nil];
        }else {
            NSLog(@"提示:没有摄像设备");
        }
 
        
    }];
    
    UIAlertAction *photoLibraryAction = [UIAlertAction actionWithTitle:@"图库" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        // 默认 UIImagePickerControllerSourceTypePhotoLibrary
        pickek.sourceType = UIImagePickerControllerSourceTypePhotoLibrary  ;
        
        
        [self presentViewController:pickek animated:YES completion:nil];
    }];
    
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        pickek.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentViewController:pickek animated:YES completion:nil];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *videoStartAction = [UIAlertAction actionWithTitle:@"录像" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            NSLog(@"没有摄像设备");
            return ;
        }
        
        pickek.sourceType = UIImagePickerControllerSourceTypeCamera;
        pickek.mediaTypes = @[@"public.movie"];
        pickek.showsCameraControls = YES;

       
        [self presentViewController:pickek animated:YES completion:nil];

        
    }];

    [alertControll addAction:cameraAction];
    [alertControll addAction:photoLibraryAction];
    [alertControll addAction:albumAction];
    [alertControll addAction:cancelAction];
    [alertControll addAction:videoStartAction];

    [self presentViewController:alertControll animated:YES completion:nil];
    
}

-(void)timeClick {
    
    [self.pickek takePicture];
    
}




#pragma mark - UIImagePickerControllerDelegate
//选取 完成
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    //是否选取的是 录像（sourceType必须是 UIImagePickerControllerSourceTypeCamera ）
    if(picker.sourceType  == UIImagePickerControllerSourceTypeCamera) {
        BOOL videoStart = [picker startVideoCapture];
        NSLog(@"%d",videoStart);
    }
    
    
    
    
    
    // info  里面包含 所有有关的信息
    
    if([info[@"UIImagePickerControllerMediaType"] isEqualToString:@"public.image"]) {
        //原始图片
        UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
        self.imageView.image = image;
        //保存照片到相册
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), @"gege");
    }
    
    
    
    

    [picker dismissViewControllerAnimated:YES completion:nil];
    

}

//取消
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES   completion:nil];
    
}


- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if(error) {
        NSLog(@"保存图片失败");
    }else {
         NSLog(@"保存图片成功");
    }
}


@end
