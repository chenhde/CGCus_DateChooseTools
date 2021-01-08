//
//  KHConsultScreenView.m
//  KHealthDoctor
//
//  Created by 陈鸿德 on 2020/12/25.
//  Copyright © 2020 lambert. All rights reserved.
//

//屏幕宽度
#define UIScreenWidth   [UIScreen mainScreen].bounds.size.width
//屏幕高度
#define UIScreenHeight  [UIScreen mainScreen].bounds.size.height


#import "KHConsultScreenView.h"
#import "NSDate+BAKit.h"
#import "NSDateFormatter+BAKit.h"
@interface KHConsultScreenView () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *_pickerView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property(assign,nonatomic)NSInteger timeType;

@property (nonatomic, strong) NSMutableArray *yearArray;
@property (nonatomic, strong) NSMutableArray *monthArray;
@property (nonatomic, strong) NSMutableArray *dayArray;

@property (nonatomic, strong) NSDate *minYearDate;//最小年
@property (nonatomic, strong) NSDate *maxYearDate;//最大年

@property(copy,nonatomic)NSString *selectYear;

@property(copy,nonatomic)NSString *selectMonth;

@property(copy,nonatomic)NSString *selectDay;




@end


@implementation KHConsultScreenView
@synthesize _pickerView;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithTimeType:(KHConsultScreenTimeType)type andTitleStr:(NSString *)title{
    
    if (self = [super init]) {
        
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];

        self = [[bundle loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
        
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        
        _titleLabel.text = title;
        
        _timeType = type;

        [self setup];
        
        
     
    }
    return self;
    
   
}


- (instancetype)init{
    if (self = [super init]) {
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];

        self = [[bundle loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
        
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        
        _titleLabel.text = @"选择日期";
        
        _timeType = KHConsultScreenTimeType_YMD;

        [self setup];
        
       
    }
    return self;
}

#pragma mark 配置
- (void)setup{
    NSString *minString = @"1990-01";
    NSDateFormatter *fmt = [NSDateFormatter ba_setupDateFormatterWithYM];
    self.minYearDate = [fmt dateFromString:minString];
    self.maxYearDate = [NSDate date];
    
    self.nowChooseDate = [NSDate date];

}

-(void)setNowChooseDate:(NSDate *)nowChooseDate{
    
    _nowChooseDate = nowChooseDate;
    
    self.selectYear = [NSNumber numberWithInteger:self.nowChooseDate.year].stringValue;
    
    self.selectMonth = [NSNumber numberWithInteger:self.nowChooseDate.month].stringValue;
    
    self.selectDay = [NSNumber numberWithInteger:self.nowChooseDate.day].stringValue;
    
    
    [self refreshYears];
    
    
}

-(void)setCusMinYearDate:(NSDate *)cusMinYearDate{
    
    _cusMinYearDate = cusMinYearDate;
    
    self.minYearDate = cusMinYearDate;
    
    [self refreshYears];
    
}

-(void)setSingleLineColor:(UIColor *)singleLineColor{
    
    _singleLineColor = singleLineColor;
    
    [_pickerView reloadAllComponents];
    
}

-(void)setPickerLabelFont:(UIFont *)pickerLabelFont{
    
    _pickerLabelFont = pickerLabelFont;
    
    [_pickerView reloadAllComponents];
    
}

-(void)setPickerLabelColor:(UIColor *)pickerLabelColor{
    
    _pickerLabelColor = pickerLabelColor;
    
    [_pickerView reloadAllComponents];
}

- (IBAction)cancelAction:(UIButton *)sender{
    
    void (^myBlock)(void) = self.didCancelFinish;
    
    if (myBlock) {
        
        myBlock();
    }
    
    
}

- (IBAction)confirmAction:(UIButton *)sender{

    NSString *didStr = @"";
    
    
    if (self.timeType == KHConsultScreenTimeType_YM) {
        
        if (self.selectYear.length&&self.selectMonth.length) {
            
            NSString *mStr = self.selectMonth;
            
            if (self.selectMonth.integerValue<10) {
                
                mStr = [NSString stringWithFormat:@"0%@",self.selectMonth];
            }
            
            didStr = [NSString stringWithFormat:@"%@-%@",self.selectYear,mStr];
            
            
        }
        
    }else{
        
        if (self.selectYear.length&&self.selectMonth.length&&self.selectDay.length) {
            
            NSString *mStr = self.selectMonth;
            NSString *dStr = self.selectDay;
            
            if (self.selectMonth.integerValue<10) {
                
                mStr = [NSString stringWithFormat:@"0%@",self.selectMonth];
            }
            if (self.selectDay.integerValue<10) {
                
                dStr = [NSString stringWithFormat:@"0%@",self.selectDay];
            }
            
            
            didStr = [NSString stringWithFormat:@"%@-%@-%@",self.selectYear,mStr,dStr];

            
        }
    }
    
    void (^myBlock)(NSString *parm) = self.didSelectFinish;

    if (myBlock) {
        myBlock(didStr);
    }
}

- (NSMutableArray *)yearArray{
    if (!_yearArray) {
        _yearArray = [NSMutableArray array];
    }
    return _yearArray;
}

- (NSMutableArray *)monthArray{
    if (!_monthArray) {
        _monthArray = [NSMutableArray array];
    }
    return _monthArray;
}

- (NSMutableArray *)dayArray{
    if (!_dayArray) {
        _dayArray = [NSMutableArray array];
    }
    return _dayArray;
}




- (void)refreshYears{
    [self.yearArray removeAllObjects];
    
    for (NSInteger i = self.minYearDate.year; i <=self.maxYearDate.year ; i++) {
        NSString *str = [NSString stringWithFormat:@"%ld", (long)i];
        [_yearArray addObject:str];
    }

    [_pickerView reloadComponent:0];
    
  
    
    if ([self.yearArray containsObject:self.selectYear]) {
        
        
        NSInteger index = [self.yearArray indexOfObject:self.selectYear];
        
        [_pickerView selectRow:index inComponent:0 animated:NO];

    }else{
        
        
        [_pickerView selectRow:0 inComponent:0 animated:NO];
        
        self.selectYear = self.yearArray[0];
    }
    
    
    
    
    [self refreshMonths];
}

- (void)refreshMonths{
    
    [self.monthArray removeAllObjects];

    NSDate *nowDate = [NSDate date];

    NSInteger startMonth = 1;
    
    NSInteger monthCount = 12;
    
    if (self.selectYear) {
        

        if (self.selectYear.integerValue == nowDate.year) {
            
            monthCount = nowDate.month;
        }
        
        if (self.selectYear.integerValue == self.minYearDate.year) {
            
            startMonth = self.minYearDate.month;
            
        }
        
    }

    for (NSInteger i = startMonth; i <= monthCount; i++) {
        NSString *str = [NSString stringWithFormat:@"%ld", (long)i];
        [self.monthArray addObject:str];
    }
    
    [_pickerView reloadComponent:1];

    if (self.monthArray.count) {
        
        if ([self.monthArray containsObject:self.selectMonth]) {
            
            NSInteger index = [self.monthArray indexOfObject:self.selectMonth];
            
            [_pickerView selectRow:index inComponent:1 animated:NO];
            
        }else{
            
            [_pickerView selectRow:0 inComponent:1 animated:NO];
            
            self.selectMonth = self.monthArray[0];
            
        }
    }
    
    
    
    
    
    [self refreshDays];
}

-(void)refreshDays{
    
    if (self.timeType == KHConsultScreenTimeType_YM) {
        
        return;
        
    }
    
    [self.dayArray removeAllObjects];
    
    NSDate *nowDate = [NSDate date];
    
    NSInteger dayCount = 0;
    
    NSInteger startDay = 1;

    
    if (!self.selectYear.length) {
        
        self.selectYear =self.yearArray.count?self.yearArray[0]:@"1990";
    }
    if (!self.selectMonth.length) {
        
        self.selectMonth =self.monthArray.count?self.monthArray[0]:@"01";
    }

    NSDateFormatter *fmt = [NSDateFormatter ba_setupDateFormatterWithYM];
    NSDate *dDate = [fmt dateFromString:[NSString stringWithFormat:@"%@-%@", self.selectYear, self.selectMonth]];
    dayCount = [NSDate ba_dateGetDayNumbersOfYear:dDate];
    
    
    if (self.selectYear.integerValue == nowDate.year && self.selectMonth.integerValue == nowDate.month) {
       
        dayCount = nowDate.day;
        
    }
    if (self.selectYear.integerValue == self.minYearDate.year && self.selectMonth.integerValue == self.minYearDate.month){
       
        startDay = self.minYearDate.day;
        
    }
    
    for (NSInteger i = startDay; i <= dayCount; i++) {
        
        NSString *str = [NSString stringWithFormat:@"%ld", (long)i];
        
        [self.dayArray addObject:str];
    }
    

    [_pickerView reloadComponent:2];
    if (self.dayArray.count) {
        
        if ([self.dayArray containsObject:self.selectDay]) {
            
            NSInteger index = [self.dayArray indexOfObject:self.selectDay];
            
            [_pickerView selectRow:index inComponent:2 animated:NO];
            
        }else{
            
            [_pickerView selectRow:0 inComponent:2 animated:NO];
            
            self.selectDay = self.dayArray[0];
            
        }
    }
    
   
    
    
}



#pragma mark - UIPickerViewDelegate,UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    if (self.timeType == KHConsultScreenTimeType_YMD) {
        
        return 3;
    }
    return 2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return self.yearArray.count;
    }else if (component==1){
        
        return self.monthArray.count;
        
    }
    return self.dayArray.count;
   
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 50.0f;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    //设置分割线的颜色
    for (UIView *singleLine in pickerView.subviews) {
        if (singleLine.frame.size.height < 1) {
            singleLine.backgroundColor = self.singleLineColor?self.singleLineColor:[UIColor lightGrayColor];
        }
    }

    UILabel *pickerLabel = (UILabel *)view;
    if (!pickerLabel) {
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor whiteColor]];
        [pickerLabel setFont:self.pickerLabelFont?self.pickerLabelFont:[UIFont systemFontOfSize:16 weight:UIFontWeightMedium]];
        [pickerLabel setTextColor:self.pickerLabelColor?self.pickerLabelColor:[UIColor colorWithRed:51/255 green:51/255 blue:51/255 alpha:1.0f]];
    }
    // Fill the label text here
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    if (self.timeType == KHConsultScreenTimeType_YMD) {
        
        return ceilf(UIScreenWidth / 3.0);
    }
 
    return ceilf(UIScreenWidth / 2.0);
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {

        return [NSString stringWithFormat:@"%@年", self.yearArray[row]];
        
    }else if (component==1){
        
        return [NSString stringWithFormat:@"%@月", self.monthArray[row]];
    }

    return [NSString stringWithFormat:@"%@日", self.dayArray[row]];
   
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        
        if (self.yearArray.count>row) {
            
            self.selectYear = self.yearArray[row];
        }
        
        
        [self refreshMonths];
        
    }else if (component==1){
        
        if (self.monthArray.count>row) {
            
            self.selectMonth = self.monthArray[row];
        }
        [self refreshDays];
        
    }else if (component==2){
        
        if (self.dayArray.count>row) {
            
            self.selectDay = self.dayArray[row];
        }
        
    }
}


@end
