//
//  KHConsultScreenView.h
//  KHealthDoctor
//
//  Created by 陈鸿德 on 2020/12/25.
//  Copyright © 2020 lambert. All rights reserved.
//
typedef NS_ENUM(NSInteger, KHConsultScreenTimeType) {
    
    KHConsultScreenTimeType_YMD,//年月日
    
    KHConsultScreenTimeType_YM //年月
    
};
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface KHConsultScreenView : UIView

/// 初始化
/// @param type 类型，年月日或者年月
/// @param title 标题
-(instancetype)initWithTimeType:(KHConsultScreenTimeType )type andTitleStr:(NSString *)title;
///起始年份
@property (nonatomic, strong) NSDate *cusMinYearDate;//起始年
///当前选中时间，格式为"2018-10-10"，"2018-10"，默认当前时间。
@property(nonatomic,strong) NSDate *nowChooseDate;

///分割线颜色
@property(nonatomic,strong)UIColor * singleLineColor;
///内容字体
@property(nonatomic,strong)UIFont * pickerLabelFont;
///内容颜色
@property(nonatomic,strong)UIColor * pickerLabelColor;


///点击取消
@property (nonatomic, copy) void (^didCancelFinish)(void);
///点击完成
@property (nonatomic, copy) void (^didSelectFinish)(NSString *selectDate);


@end

NS_ASSUME_NONNULL_END
