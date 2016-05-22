//
//  ZPNewFeatuersViewController.m
//  ZPProject
//
//  Created by lizp on 16/4/1.
//  Copyright © 2016年 Apple05. All rights reserved.
//

#import "ZPNewFeatuersViewController.h"

@interface ZPNewFeatuersViewController ()

@end

@implementation ZPNewFeatuersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
#if 0
#pragma mark - ios 8.0 以后 UIAlertView和UIActionSheet  用UIAlertController 代替
    //style 1、UIAlertControllerStyleAlert  代替 UIAlertView
    //      2、UIAlertControllerStyleActionSheet  代替 UIActionSheet
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"提示" message:@"hello" preferredStyle:UIAlertControllerStyleAlert];
    //取消  只能有一个 若多个 会导致程序崩溃
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
    }];
    
    //警告
    UIAlertAction *warningAction = [UIAlertAction actionWithTitle:@"警告" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"警告");
    }];
    
    //自定义
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"自定义" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"自定义");
    }];
    
    //添加文本框    只有在UIAlertControllerStyleAlert 下有效
    [alertControl addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = @"用户名";
        textField.secureTextEntry = NO;
    }];
    //取出文本框  需在 addTextFieldWithConfigurationHandler  代码之后
    UITextField *actionTextField = alertControl.textFields.firstObject;
    NSLog(@"%@",actionTextField.text);
    
    [alertControl addAction:cancelAction];
    [alertControl addAction:warningAction];
    [alertControl addAction:defaultAction];
    
    
    //取出 UIAlertAction 按钮  需 addAction 再代码 之后
    UIAlertAction *alertAction = alertControl.actions.firstObject;
    NSLog(@"title:%@  style:%ld  enabled:%d",alertAction.title,alertAction.style,alertAction.enabled);
    
#pragma mark - ios 9.0 属性preferredAction  让某个Action 看起来更显眼
    alertControl.preferredAction = defaultAction;
    
    
    [self presentViewController:alertControl animated:YES completion:nil];
    
#endif
    
    
    UIAlertController *sheetControll = [UIAlertController alertControllerWithTitle:@"sheetControll" message:@"sheet" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *sheetCancelAction  = [UIAlertAction actionWithTitle:@"sheetCancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"sheetCancel");
    }];
    
    UIAlertAction *sheetWarningAction  = [UIAlertAction actionWithTitle:@"sheetWarning" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"sheetDestructive");
    }];
    
    UIAlertAction *sheetDefaultAction = [UIAlertAction actionWithTitle:@"sheetDefault" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"sheetDefault");
    }];
    
    
    
    [sheetControll addAction:sheetCancelAction];
    [sheetControll addAction:sheetWarningAction];
    [sheetControll addAction:sheetDefaultAction];
    
    UIAlertAction *sheetAction = sheetControll.actions[1];
    NSLog(@"title:%@  style:%lu  enabled:%d",sheetAction.title,sheetAction.style,sheetAction.enabled);
    
    
    [self presentViewController:sheetControll animated:YES completion:nil];
}




@end
