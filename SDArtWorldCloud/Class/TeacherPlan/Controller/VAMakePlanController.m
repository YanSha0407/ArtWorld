//
//  VAMakePlanController.m
//  SDArtWorldCloud
//
//  Created by metis on 2019/11/27.
//  Copyright © 2019 Sudo. All rights reserved.
//

#import "VAMakePlanController.h"
#import "VAMakePlanView.h"
#import "VASubjectModel.h"
#import "VAFormModel.h"
#import "VAMakePlanModel.h"
#import "VAPlanDetailController.h"
@interface VAMakePlanController ()<UITextFieldDelegate>
@property(nonatomic,strong)UILabel *courseName;//课件名称
@property(nonatomic,strong)UITextField *courseNameTextFiled;
@property(nonatomic,strong)UILabel *subjectName;//所属科目
@property(nonatomic,strong)UILabel *formName;//上课形式
@property(nonatomic,strong)VAMakePlanView *subjectView;//上课形式
@property(nonatomic,strong)VAMakePlanView *formView;//上课形式
@property(nonatomic,strong)VASubjectModel *subjectModel;//上课形式model
@property(nonatomic,strong)VAFormModel *formModel;//上课形式model
@property(nonatomic,strong)NSMutableArray *subjectMutableArray; // 所属科目数组
@property(nonatomic,strong)NSMutableArray *classFormMutableArray;// 上课形式数组
@property(nonatomic,strong)UIButton *nextBtn;// 下一步
@end

@implementation VAMakePlanController

-(void)viewWillDisappear:(BOOL)animated{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"制作课件";
    [self.view addSubview:self.courseName];
    [self.view addSubview:self.courseNameTextFiled];
    [self.view addSubview:self.subjectName];
    [self.view addSubview:self.formName];
    [self.view addSubview:self.subjectView];
    [self.view addSubview:self.formView];
    [self.view addSubview:self.nextBtn];
    [self getSubjectData];
    [self getClassFromData];
}
-(UILabel *)courseName{
    if (!_courseName) {
        _courseName = [[UILabel alloc]init];
        _courseName.text = @"课件名称";
        _courseName.textColor = VAMainTitleColor;
        _courseName.font = VAMainTitleFont;
    }
    return _courseName;
}
-(UILabel *)subjectName{
    if (!_subjectName) {
        _subjectName = [[UILabel alloc]init];
        _subjectName.text = @"所属科目";
        _subjectName.textColor = VAMainTitleColor;
        _subjectName.font = VAMainTitleFont;
    }
    return _subjectName;
}
-(UILabel *)formName{
    if (!_formName) {
        _formName = [[UILabel alloc]init];
        _formName.text = @"上课形式";
        _formName.textColor = VAMainTitleColor;
        _formName.font = VAMainTitleFont;
    }
    return _formName;
}
-(UITextField *)courseNameTextFiled{
    if (!_courseNameTextFiled) {
        _courseNameTextFiled = [[UITextField alloc]init];
        _courseNameTextFiled.delegate = self;
        _courseNameTextFiled.tintColor = VAMainTitleColor;
        _courseNameTextFiled.textColor = VAMainTitleColor;
        _courseNameTextFiled.placeholder = @"请输入课程标题...";
        [_courseNameTextFiled addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
        [_courseNameTextFiled becomeFirstResponder];
    }
    return _courseNameTextFiled;
}
-(VAMakePlanView *)subjectView{
    if (!_subjectView) {
        _subjectView = [[VAMakePlanView alloc]init];
    }
    return _subjectView;
}
-(VAMakePlanView *)formView{
    if (!_formView) {
        _formView = [[VAMakePlanView alloc]init];
    }
    return _formView;
}
-(UIButton *)nextBtn{
    if (!_nextBtn) {
        _nextBtn = [[UIButton alloc]init];
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextBtn setTitleColor:VAWhiteColor forState:UIControlStateNormal];
        [_nextBtn addTarget:self action:@selector(clickNextBtn) forControlEvents:UIControlEventTouchUpInside];
        _nextBtn.titleLabel.font = VAMainBlodTitleFont;
        _nextBtn.backgroundColor = VAGrayUnUseColor;
        _nextBtn.enabled = NO;
        KClipsCornerRadius(_nextBtn, 44/2);
    }
    return _nextBtn;
}
#pragma mark-----lazy MutableArray
-(NSMutableArray *)subjectMutableArray{
  if (!_subjectMutableArray) {
    _subjectMutableArray = [NSMutableArray array];
  }
  return _subjectMutableArray;
}
-(NSMutableArray *)classFormMutableArray{
  if (!_classFormMutableArray) {
    _classFormMutableArray = [NSMutableArray array];
  }
  return _classFormMutableArray;
}
#pragma mark - 点击下一步
-(void)clickNextBtn{
    if (self.courseNameTextFiled.text.length) {
        if (kIsNetwork) {
           NSDictionary *dic = @{@"class_period_id":[NSNumber numberWithInteger:self.courseModel.class_period_id.class_period_id],@"class_id":[NSNumber numberWithInteger:self.classModel.class_id],@"category_id":[NSNumber numberWithInteger:self.subjectModel.category_id],@"admin_id":[VAAccountManager getAccount].admin_id,@"course_material_name":self.courseNameTextFiled.text,@"class_content":self.courseNameTextFiled.text,@"time":self.planDate,@"instruction_method_id":self.formModel.method_id};
          
            [PPNetworkHelper POST:kMakePlanData parameters:dic success:^(id responseObject) {
                 VAMakePlanModel *makePlanModel = [VAMakePlanModel mj_objectWithKeyValues:responseObject[@"data"]];
                 VAPlanDetailController *planDetail = [[VAPlanDetailController alloc]init];
                 planDetail.title = @"制作课件";
                 planDetail.makePlanModel = makePlanModel;
                 [self.navigationController pushViewController:planDetail animated:YES];
            } failure:^(NSError *error) {
                
            }];
        }
        else{
            [TLUIUtility showErrorHint:VANetWorkErrorMessage];
        }
    }
}

#pragma mark - 监听值改变
-(void)textFieldChange:(UITextField *)textFiled{
    self.nextBtn.enabled = textFiled.text.length;
    self.nextBtn.enabled ? [self.nextBtn setBackgroundColor:VAMainAppColor] :  [self.nextBtn setBackgroundColor:VAGrayUnUseColor] ;
}
#pragma mark----获取所属科目
-(void)getSubjectData{
    if (kIsNetwork) {
        [PPNetworkHelper GET:kGetSubjectData parameters:nil success:^(id responseObject) {
            NSArray *array = [VASubjectModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"items"]];
            if (array) {
              [self.subjectMutableArray addObjectsFromArray:array];
              self.subjectModel = [self.subjectMutableArray firstObject];
              [self loadClassFormAndSubjectButton:VAMakePlanSubject];
            }
        } failure:^(NSError *error) {
            
        }];
    }
    else{
        [TLUIUtility showErrorHint:VANetWorkErrorMessage];
    }
}
#pragma mark - 获取上课形式
-(void)getClassFromData{
    if (kIsNetwork) {
        [PPNetworkHelper GET:kGetClassFormData parameters:nil success:^(id responseObject) {
            NSArray *result = responseObject[@"data"];
            if (result) {
                [self.classFormMutableArray addObjectsFromArray:[VAFormModel mj_objectArrayWithKeyValuesArray:result]];
                self.formModel = [self.classFormMutableArray firstObject];
                [self loadClassFormAndSubjectButton:VAMakePlanClassForm];
            }
        } failure:^(NSError *error) {
            
        }];
    }
    else{
        [TLUIUtility showErrorHint:VANetWorkErrorMessage];
    }
}
-(void)loadClassFormAndSubjectButton:(VAMakePlanTextType) textType{
  if (textType == VAMakePlanSubject) { // 科目
    [self.subjectView getArrayDataSourse:self.subjectMutableArray];
      weakify(self);
    [self.subjectView setChooseBlock:^(NSInteger index) {
      if (index < self.subjectMutableArray.count) {
          strongify(self);
          self.subjectModel = self.subjectMutableArray[index];
      }
      
    }];
  }
  else if (textType == VAMakePlanClassForm){ // 上课形式
    [self.formView getArrayDataSourse:self.classFormMutableArray];
      weakify(self);
    [self.formView setChooseBlock:^(NSInteger index) {
      if (index < self.classFormMutableArray.count) {
         strongify(self);
         self.formModel = self.classFormMutableArray[index];
      }
    }];
  }
    self.subjectView.height = self.subjectView.heightSize.height;
    self.formView.height = self.formView.heightSize.height;
}
#pragma mark - UITextFiledDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self.courseNameTextFiled resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.courseNameTextFiled resignFirstResponder];
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    return YES;
}
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.courseName.frame = CGRectMake(20, 25, 80, 20);
    self.courseNameTextFiled.frame = CGRectMake(self.courseName.right, 15, KSystemWidth - self.courseName.right - 20, 40);
    self.subjectName.frame = CGRectMake(self.courseName.left, self.courseName.bottom + 90, self.courseName.width, self.courseName.height);
    self.subjectView.frame = CGRectMake(self.courseName.right, self.courseNameTextFiled.bottom + 70, KSystemWidth - self.courseName.right - 20, 100);
    self.formName.frame = CGRectMake(self.courseName.left, self.subjectName.bottom + 110, self.courseName.width, self.courseName.height);
    self.formView.frame = CGRectMake(self.courseName.right, self.subjectName.bottom + 90 , KSystemWidth - self.courseName.right - 20, 100);
    self.nextBtn.frame = CGRectMake(50, self.formView.bottom + 100 , KSystemWidth - 100, 44);
}
@end
