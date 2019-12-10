//
//  VATeacherPlanController.m
//  SDArtWorldCloud
//
//  Created by metis on 2019/11/22.
//  Copyright © 2019 Sudo. All rights reserved.
//

#import "VATeacherPlanController.h"
#import "VAPlanCell.h"
#import "VAClassController.h"
#import "VAClassModel.h"
#import "VACalendarModel.h"
#import "VAMakePlanController.h"
#define VAPlanCellIndentify @"VAPlanCell"
#define UITableViewCellCount 5
#define CalendarMenuViewHeight 44
#define IPAD_CalendarContentViewHeight 300
#define IPHONE_CalendarContentViewHeight 260

@interface VATeacherPlanController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableDictionary *_eventsByDate;
    NSDate *_todayDate;
    NSDate *_minDate;
    NSDate *_maxDate;
    NSDate *_dateSelected;
}
@property(nonatomic,strong)UITableView *planTableView;
@property(nonatomic,strong)UIView *classNameView;
@property(nonatomic,strong)UILabel *classLabel;
@property(nonatomic,strong)Classes *classModel;
@property(nonatomic,strong)NSString *startTime;
@property(nonatomic,strong)NSString *endTime;
@property(nonatomic,strong)NSMutableArray *planMutableArray;
@property(nonatomic,strong)NSMutableArray *classMutableArray;
@property(nonatomic,strong)VAClassModel *classMainModel;
@property(nonatomic,strong)VACalendarCourseModel *selectedCourseModel;
@end

@implementation VATeacherPlanController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.calendarMenuView];
    [self.view addSubview:self.calendarContentView];
    [self.view addSubview:self.planTableView];
    [self.view layoutSubviews];
    self.calendarManager = [JTCalendarManager new];
    [self createMinAndMaxDate];
    [self initCalendarManager];
    _dateSelected = [NSDate date];
    self.startTime = [[self dateFormatter] stringFromDate:[NSDate date]];
    self.endTime = self.startTime;
    if ([[VAAccountManager getAccount].user_role isEqualToString:@"student"]) {
        [self getClassData];
    }
    else{
        Classes *class = [YSFileManager getCustomObjectWithKey:@"ClassModel"];
        if (class) {
          self.classModel = class;
          [self selectedClassData];
          [self getCoursePlanData];
        }
        else{
            [self getClassData];
        }
    }
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.classNameView];
    [VANotificationCenter addObserver:self.classLabel selector:@selector(getCoursePlanData) name:@"ChangeClassName" object:nil];
}
-(void )initCalendarManager{
    self.calendarManager.delegate = self;
    [self.calendarManager setMenuView:self.calendarMenuView];
    [self.calendarManager setContentView:self.calendarContentView];
    [self.calendarManager setDate:_todayDate];
}
-(UITableView *)planTableView{
    if (!_planTableView) {
        _planTableView = [[UITableView alloc]init];
        _planTableView.delegate = self;
        _planTableView.dataSource = self;
        _planTableView.tableFooterView = [[UIView alloc]init];
        _planTableView.showsVerticalScrollIndicator = NO;
        _planTableView.showsVerticalScrollIndicator = NO;
        [_planTableView registerClass:[VAPlanCell class] forCellReuseIdentifier:VAPlanCellIndentify];
    }
    return _planTableView;
}
-(JTCalendarMenuView *)calendarMenuView{
    if (!_calendarMenuView) {
        _calendarMenuView = [[JTCalendarMenuView alloc]init];
    }
    return _calendarMenuView;
}

-(JTHorizontalCalendarView *)calendarContentView{
    if (!_calendarContentView) {
        _calendarContentView = [[JTHorizontalCalendarView  alloc]init];
    }
    return _calendarContentView;
}
-(NSMutableArray *)planMutableArray{
    if (!_planMutableArray) {
        _planMutableArray = [NSMutableArray array];
    }
    return _planMutableArray;
}
-(UIView *)classNameView{
    if (!_classNameView) {
        _classNameView = [[UIView alloc]init];
        CGFloat classViewWidth = 0.0;
        if (IS_IPAD) {
          classViewWidth = 100;
        }
        else{
           classViewWidth = 70;
        }
        UIView *classView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, classViewWidth, 40)];
        classView.backgroundColor = VAClearColor;
        classView.userInteractionEnabled = YES;
        self.classNameView = classView;
        UILabel *classLable = [[UILabel alloc]initWithFrame:classView.bounds];
        classLable.font = VASubTitleFont;
        classLable.numberOfLines = 0;
        classLable.textColor = VAWhiteColor;
        classLable.userInteractionEnabled = YES;
        [classView addSubview:classLable];
        if ([[VAAccountManager getAccount].user_role isEqualToString:@"teacher"] && [VAAccountManager getAccount].code_number.length != 0) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickSelectedClass)];
            [classLable addGestureRecognizer:tap];
        }
        _classLabel = classLable;
        _classNameView = classView;
    }
    return _classNameView;
}
-(NSMutableArray *)classMutableArray{
  if (!_classMutableArray) {
    _classMutableArray = [NSMutableArray array];
  }
  return _classMutableArray;
}

#pragma mark - 给班级View赋值
-(void)selectedClassData{
    if (IS_IPAD) {
      self.classLabel.text = self.classModel.name;
    }
    else{
      if (self.classModel.name.length <= 5) {
        self.classLabel.text = self.classModel.name;
      }
      else{
        NSString *str1 = [self.classModel.name substringToIndex:self.classModel.name.length/2];
        NSString *str2 = [self.classModel.name substringFromIndex:self.classModel.name.length/2];
        self.classLabel.text = [NSString stringWithFormat:@"%@\n%@",str1,str2];
      }
    }
}
#pragma mark - 获取班级
-(void)clickSelectedClass{
    VAClassController *classVC = [[VAClassController alloc]init];
    classVC.clickSureBtnBlock = ^(Classes * _Nonnull classModel) {
        _classModel = classModel;
        if (IS_IPAD) {
          self.classLabel.text = self.classModel.name;
        }
        else{
          if (self.classModel.name.length <= 5) {
            self.classLabel.text = self.classModel.name;
          }
          else{
            NSString *str1 = [self.classModel.name substringToIndex:self.classModel.name.length/2];
            NSString *str2 = [self.classModel.name substringFromIndex:self.classModel.name.length/2];
            self.classLabel.text = [NSString stringWithFormat:@"%@\n%@",str1,str2];
          }
        }
    };
    [self.navigationController pushViewController:classVC animated:YES];
}
#pragma mark - 获取课程表数据
-(void)getCoursePlanData{
    if (kIsNetwork) {
        //  1、班级ID  2.开始时间 3.结束时间 4.日、周、月、年
        NSDictionary *dic = @{@"class_id":[NSNumber numberWithInteger:self.classModel.class_id],@"started_at":self.startTime,@"ended_at":self.endTime,@"type":@"3"};
        [PPNetworkHelper GET:KGetCoursePlanData parameters:dic success:^(id responseObject) {
            NSArray *result = responseObject[@"data"];
            if (result.count) {
                VACalendarModel *allModel = [VACalendarModel mj_objectWithKeyValues:[result firstObject]];
                [self.planMutableArray addObjectsFromArray:[VACalendarCourseModel mj_objectArrayWithKeyValuesArray:allModel.course]];
                
                [self.planTableView reloadData];
            }
            else{
                [TLUIUtility showErrorHint:@"暂无课程"];
            }
            
        } failure:^(NSError *error) {
             
        }];
    }
    else{
        VANetWorkError
    }
}

#pragma mark - 获取班级数据
-(void)getClassData{
    if ([VAAccountManager getAccount].studio_id) {
        NSString *type = [[VAAccountManager getAccount].user_role isEqualToString:@"teacher"] ? @"1" : @"2";
        NSDictionary *dic = @{@"admin_id":[VAAccountManager getAccount].admin_id,@"studio_id":[VAAccountManager getAccount].studio_id,@"type":type};
        if (kIsNetwork) {
            [PPNetworkHelper GET:kGetClassListData parameters:dic success:^(id responseObject) {
                NSArray *result = responseObject[@"data"];
                if (result) {
                    NSArray *array = [VAClassModel mj_objectArrayWithKeyValuesArray:result];
                    self.classMainModel = [array firstObject];
                    [self.classMutableArray addObjectsFromArray:self.classMainModel.classes];
                    [self selectedClassData];
                    [self getCoursePlanData];
                }
                
            } failure:^(NSError *error) {
                
            }];
        }
        else{
            VANetWorkError
        }
    }
}
#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return UITableViewCellCount;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VAPlanCell *cell =[tableView dequeueReusableCellWithIdentifier:VAPlanCellIndentify];
    if (!cell) {
        cell = [[VAPlanCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:VAPlanCellIndentify];
    }
    if (self.planMutableArray.count) {
        cell.courseModel = self.planMutableArray[indexPath.row];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (KSystemHeight - self.calendarContentView.bottom - TabBarHeight - NavigationContentTop)/UITableViewCellCount;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < self.planMutableArray.count) {
        VACalendarCourseModel *courseModel = self.planMutableArray[indexPath.row];
        self.selectedCourseModel = courseModel;
        if (courseModel.class_content.length != 0) { //有课  跳到对应的查看课程界面
            
        }
        else{ // 无课
             // 如果角色是老师且有激活码可以创建课件   其他无事件操作
            if ([[VAAccountManager getAccount].user_role isEqualToString:@"teacher"] && [VAAccountManager getAccount].code_number.length != 0) {
                [self showRadioSelectionDialogViewController];
            }
        }
        
    }
}

#pragma mark - CalendarManager delegate

- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView
{
    // Today
    if([_calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor blueColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Selected date
    else if(_dateSelected && [_calendarManager.dateHelper date:_dateSelected isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor redColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Other month
    else if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor lightGrayColor];
    }
    // Another day of the current month
    else{
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor blackColor];
    }
    
    if([self haveEventForDay:dayView.date]){
        dayView.dotView.hidden = NO;
    }
    else{
        dayView.dotView.hidden = YES;
    }
}

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView
{
    _dateSelected = dayView.date;
    self.startTime = [[self dateFormatter] stringFromDate:_dateSelected];
    self.endTime = self.startTime;
    // Animation for the circleView
    dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
    [UIView transitionWithView:dayView
                      duration:.3
                       options:0
                    animations:^{
                        dayView.circleView.transform = CGAffineTransformIdentity;
                        [_calendarManager reload];
                    } completion:nil];
    
    // Don't change page in week mode because block the selection of days in first and last weeks of the month
    if(_calendarManager.settings.weekModeEnabled){
        return;
    }
    // Load the previous or next page if touch a day from another month
    if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        if([_calendarContentView.date compare:dayView.date] == NSOrderedAscending){
            [_calendarContentView loadNextPageWithAnimation];
        }
        else{
            [_calendarContentView loadPreviousPageWithAnimation];
        }
    }
    [self getCoursePlanData];
}

#pragma mark - CalendarManager delegate - Page mangement

// Used to limit the date for the calendar, optional
- (BOOL)calendar:(JTCalendarManager *)calendar canDisplayPageWithDate:(NSDate *)date
{
    return [_calendarManager.dateHelper date:date isEqualOrAfter:_minDate andEqualOrBefore:_maxDate];
}

- (void)calendarDidLoadNextPage:(JTCalendarManager *)calendar
{
    //    NSLog(@"Next page loaded");
}

- (void)calendarDidLoadPreviousPage:(JTCalendarManager *)calendar
{
    //    NSLog(@"Previous page loaded");
}

#pragma mark - Fake data

- (void)createMinAndMaxDate
{
    _todayDate = [NSDate date];
    
    // Min date will be 2 month before today
    _minDate = [_calendarManager.dateHelper addToDate:_todayDate months:-2];
    
    // Max date will be 2 month after today
    _maxDate = [_calendarManager.dateHelper addToDate:_todayDate months:2];
}

// Used only to have a key for _eventsByDate
- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"yyyy-MM-dd";
    }
    return dateFormatter;
}

- (BOOL)haveEventForDay:(NSDate *)date
{
    NSString *key = [[self dateFormatter] stringFromDate:date];
    if(_eventsByDate[key] && [_eventsByDate[key] count] > 0){
        return YES;
    }
    return NO;
}

- (void)createRandomEvents
{
    _eventsByDate = [NSMutableDictionary new];
    for(int i = 0; i < 30; ++i){
        // Generate 30 random dates between now and 60 days later
        NSDate *randomDate = [NSDate dateWithTimeInterval:(rand() % (3600 * 24 * 60)) sinceDate:[NSDate date]];
        // Use the date as key for eventsByDate
        NSString *key = [[self dateFormatter] stringFromDate:randomDate];
        if(!_eventsByDate[key]){
            _eventsByDate[key] = [NSMutableArray new];
        }
        [_eventsByDate[key] addObject:randomDate];
    }
}
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.calendarMenuView.frame = CGRectMake(0, 0, KSystemWidth, CalendarMenuViewHeight);
    CGFloat height = IS_IPAD ? IPAD_CalendarContentViewHeight : IPHONE_CalendarContentViewHeight;
    self.calendarContentView.frame = CGRectMake(self.calendarMenuView.left, self.calendarMenuView.bottom, KSystemWidth, height);
    self.planTableView.frame = CGRectMake(self.calendarMenuView.left, self.calendarContentView.bottom, KSystemWidth, KSystemHeight - self.calendarContentView.bottom - TabBarHeight);
}


#pragma mark ---选择创建课程方式
- (void)showRadioSelectionDialogViewController{
    QMUIOrderedDictionary *citys = [[QMUIOrderedDictionary alloc] initWithKeysAndObjects:
                                    @"制作课件",@"制作课件",
                                    @"选择本校课件",@"选择本校课件",
                                    @"选择云课件",@"选择云课件",
                                    nil];
    QMUIDialogSelectionViewController *dialogViewController = [[QMUIDialogSelectionViewController alloc] init];
    dialogViewController.title = @"选择课件来源";
    dialogViewController.items = citys.allKeys;
    dialogViewController.rowHeight = 56;
    dialogViewController.titleLabelTextColor = VAMainTitleColor;
    [dialogViewController addCancelButtonWithText:@"取消" block:nil];
    [dialogViewController addSubmitButtonWithText:@"确定" block:^(QMUIDialogViewController *aDialogViewController) {
        QMUIDialogSelectionViewController *d = (QMUIDialogSelectionViewController *)aDialogViewController;
        if (d.selectedItemIndex == QMUIDialogSelectionViewControllerSelectedItemIndexNone) {
            [QMUITips showError:@"请至少选一个" inView:d.qmui_modalPresentationViewController.view hideAfterDelay:1.2];
            return;
        }
        NSString *city = d.items[d.selectedItemIndex];
        NSString *resultString = (NSString *)[citys objectForKey:city];
        weakify(self);
        [aDialogViewController hideWithAnimated:YES completion:^(BOOL finished) {
            strongify(self);
            [self clickCourseSource:resultString];
        }];
    }];
    [dialogViewController show];
}

#pragma mark - 点击课件来源 对应跳转
-(void)clickCourseSource:(NSString *)sourceName{
    if ([sourceName isEqualToString:@"制作课件"]) {
        VAMakePlanController *makePlanVC = [[VAMakePlanController alloc]init];
        makePlanVC.classModel = self.classModel;
        makePlanVC.courseModel = self.selectedCourseModel;
        makePlanVC.planDate = [[self dateFormatter]stringFromDate:_dateSelected];
        [self.navigationController pushViewController:makePlanVC animated:YES];
    }
    else{
        
    }
}
@end
