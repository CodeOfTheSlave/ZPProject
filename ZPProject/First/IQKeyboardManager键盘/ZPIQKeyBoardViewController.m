//
//  ZPIQKeyBoardViewController.m
//
//  Created by lizp on 16/7/26.
//  Copyright © 2016年 LZP. All rights reserved.
//

#import "ZPIQKeyBoardViewController.h"
#import <IQKeyboardManager.h>
#import <IQKeyboardReturnKeyHandler.h>

@interface ZPIQKeyBoardViewController ()

@end

@implementation ZPIQKeyBoardViewController
{
    IQKeyboardReturnKeyHandler *returnKeyHandler;
}

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
    
     returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
//    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"Show Controller: %@", [self class]);
    
    

}

- (void)dealloc {
    NSLog(@"Dealloc Controller: %@", [self class]);
}

-(void)loadView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view = scrollView;
}

// #pragma mark - SystemDelegate   
// #pragma mark TableView Delegate    
// #pragma mark - CustomDelegate  
// #pragma mark - event response  

#pragma mark - private methods 
- (void)initView
{
    self.title = @"IQKeyboardManager键盘";
    self.view.backgroundColor = kDefaultVCBackgroundColor;
    NSLog(@"Load Controller: %@", [self class]);
    
    //http://www.jianshu.com/p/9d7d246bd350/comments/1518291
    
    UITextField *textFieldName = [[UITextField alloc] initWithFrame:CGRectMake(100, 400, 200, 20)];
    textFieldName.backgroundColor = [UIColor lightGrayColor];
    textFieldName.placeholder = @"name";
    [self.view addSubview:textFieldName];
    
    UITextField *textFieldPwd = [[UITextField alloc] initWithFrame:CGRectMake(100, 450, 200, 20)];
    textFieldPwd.backgroundColor = [UIColor lightGrayColor];
    textFieldPwd.placeholder = @"pwd";
    [self.view addSubview:textFieldPwd];
    
}

#pragma mark - getters and setters  


@end
