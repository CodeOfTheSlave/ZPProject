//
//  ZPMBProgressHUDViewController.m
//  ZPProject
//
//  Created by lizp on 16/5/23.
//  Copyright © 2016年 Apple05. All rights reserved.
//

#import "ZPMBProgressHUDViewController.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"   


@interface ZPMBExample : NSObject

@property (nonatomic,copy) NSString *title;
@property (nonatomic,assign) SEL sel;

@end

@implementation ZPMBExample

+(instancetype)exampleWitTitle:(NSString *)title sel:(SEL)sel {
    ZPMBExample *example = [[ZPMBExample alloc] init];
    example.title = title;
    example.sel = sel;
    return example;
    
}

@end


@interface ZPMBProgressHUDViewController ()<UITableViewDataSource,UITableViewDelegate,NSURLSessionTaskDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataSource;

@end


@implementation ZPMBProgressHUDViewController

#pragma mark - 懒加载
- (UITableView *)tableView {
    if(_tableView == nil) {
        _tableView  = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;

}

- (NSArray *)dataSource {
    if(_dataSource == nil) {
        _dataSource = @[[ZPMBExample exampleWitTitle:@"indeterminate mode" sel:@selector(indeterminate)],
                        [ZPMBExample exampleWitTitle:@"with label" sel:@selector(hudWithLabel)],
                        [ZPMBExample exampleWitTitle:@"with DetailLabel" sel:@selector(hudWithDetailLabel)],
                        [ZPMBExample exampleWitTitle:@"annularDeterminateModel" sel:@selector(annularDeterminateModel)],
                        [ZPMBExample exampleWitTitle:@"determinateModel" sel:@selector(determinateModel)],
                        [ZPMBExample exampleWitTitle:@"determinateHorizontalBarModel" sel:@selector(determinateHorizontalBarModel)],
                        [ZPMBExample exampleWitTitle:@"customView" sel:@selector(customView)],
                        [ZPMBExample exampleWitTitle:@"onlyText" sel:@selector(onlyText)],
                        [ZPMBExample exampleWitTitle:@"switching" sel:@selector(switching)],
                        [ZPMBExample exampleWitTitle:@"on Window" sel:@selector(onWindows)],
                        [ZPMBExample exampleWitTitle:@"urlSession" sel:@selector(urlSession)]
                        ];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
}

-(void)urlSession {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"preparing...";
    [self netWorkingRequest];

    
}

-(void)netWorkingRequest {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    NSURLSessionDownloadTask *task =[session downloadTaskWithURL:[NSURL URLWithString:ZPMBProgressHUDViewControllerURLStr]];
    [task resume];
}

#pragma mark - NSURLSessionTaskDelegate
- (void)URLSession:(NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(nonnull NSURL *)location {
    NSLog(@"finish");
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD HUDForView:self.navigationController.view];
        hud.mode = MBProgressHUDModeCustomView;
        UIImage *image = [[UIImage  imageNamed:@"img_succeed"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        hud.customView = [[UIImageView alloc] initWithImage:image];
        [hud hide:YES afterDelay:2];
    });
}

-(void)URLSession:(NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    CGFloat progress = (CGFloat)totalBytesWritten /(CGFloat)totalBytesExpectedToWrite;
    NSLog(@"%f",progress);

   dispatch_async(dispatch_get_main_queue(), ^{
       MBProgressHUD *hud = [MBProgressHUD HUDForView:self.navigationController.view];
       hud.mode  = MBProgressHUDModeAnnularDeterminate;
       hud.progress = progress;
       hud.labelText = [NSString stringWithFormat:@"%.2f%%",progress *100];
   });

}


-(void)onWindows {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        [self doSomeWork];
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hide:YES];
        });
        
    });

}



-(void)doSomeWork {
    sleep(3);
}

-(void)doSomeWorkWithProgress {

    CGFloat progress = 0.0f;
    while (progress < 1.0f) {
        progress+= 0.01f;
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD HUDForView:self.navigationController.view].progress = progress;
        });
        usleep(50000);
    }
}


-(void)switching {

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"preparing...";
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        [self doSwitching];
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hide:YES];
        });
    });
}


-(void)doSwitching {

    sleep(3);
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self.navigationController.view];
    hud.mode = MBProgressHUDModeDeterminate;
    hud.labelText = @"loading...";
    [self doSomeWorkWithProgress];
    
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"cleaning up...";
    sleep(3);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIImage *image = [[UIImage imageNamed:@"img_succeed"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        hud.customView = imageView;
        
        hud.mode = MBProgressHUDModeCustomView;
        hud.labelText = @"Completed";
    });
    
    sleep(2);
    
    

}

-(void)onlyText {

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"well done";
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        [self doSomeWork];
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud  hide:YES];
        });
    });
}


-(void)customView {

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = @"Done";
    UIImage *image = [[UIImage imageNamed:@"img_succeed"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        [self doSomeWork];
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hide:YES];
        });
    });
}

-(void)determinateHorizontalBarModel {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    hud.mode = MBProgressHUDModeDeterminateHorizontalBar ;
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        [self doSomeWorkWithProgress];
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hide:YES];
        });
    });
    
}



- (void)indeterminate {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeDeterminate;
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        [self doSomeWork];
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hide:YES];
        });
    });

}


-(void)hudWithLabel {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = @"loading...";
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_UNSPECIFIED, 0), ^{
        [self doSomeWork];
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hide:YES];
        });
    });
}

- (void)determinateModel {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    // Set the determinate mode to show task progress.
    hud.mode = MBProgressHUDModeDeterminate;
    hud.labelText = @"loading...";
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        // Do something useful in the background and update the HUD periodically.
        [self doSomeWorkWithProgress];
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hide:YES];
        });
    });
}


-(void)hudWithDetailLabel {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = @"loading...";
    hud.detailsLabelText = @"paring data\n(1/1)";
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        [self doSomeWork];
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hide:YES];
        });
    });
    
}

-(void)annularDeterminateModel {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        [self doSomeWorkWithProgress];
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hide:YES];
        });
    });
}

-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    ZPMBExample *example = self.dataSource[indexPath.row];
    cell.textLabel.text = example.title;
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZPMBExample *example = self.dataSource[indexPath.row];
    
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self performSelector:example.sel];
#pragma clang diagnostic pop

    

}




@end
