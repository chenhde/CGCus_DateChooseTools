//
//  ViewController.m
//  CGCustomDateChooseDemo
//
//  Created by 陈鸿德 on 2021/1/7.
//
//屏幕宽度
#define UIScreenWidth   [UIScreen mainScreen].bounds.size.width
//屏幕高度
#define UIScreenHeight  [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"
#import <KHConsultScreenView.h>
#import <NSDateFormatter+BAKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)chooseYearAndMonthAction:(UIButton *)sender {

///主动设置类型及标题
    KHConsultScreenView *alertView = [[KHConsultScreenView alloc] initWithTimeType:KHConsultScreenTimeType_YM andTitleStr:@"选中日期"];
    ///默认选择年月日
//    KHConsultScreenView *alertView = [[KHConsultScreenView alloc] init];

    NSDateFormatter *fmt = [NSDateFormatter ba_setupDateFormatterWithYMD];
    alertView.cusMinYearDate = [fmt dateFromString:@"2010-06-05"];
    
    alertView.nowChooseDate =  [fmt dateFromString:@"2014-05-21"];
    
//    alertView.singleLineColor = [UIColor redColor];
//
//    alertView.pickerLabelColor = [UIColor blueColor];
//
//    alertView.pickerLabelFont = [UIFont systemFontOfSize:30];

    UIView *sView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, 260)];
    sView.backgroundColor = [UIColor whiteColor];

    [sView addSubview:alertView];

    [alertView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.edges.equalTo(sView);

    }];


    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:sView preferredStyle:TYAlertControllerStyleActionSheet];

    alertController.backgoundTapDismissEnable = NO;
    alertController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    
    
    @weakify(alertView);
    alertView.didCancelFinish = ^{
        
        @strongify(alertView);
        
        [alertView hideView];
        
    };
    
    alertView.didSelectFinish = ^(NSString * _Nonnull selectDate) {
        
        @strongify(alertView);
        [alertView hideView];
        
        NSLog(@"日期：%@",selectDate);
        
    };
    
    
    
}

@end
