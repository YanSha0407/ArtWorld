//
//  VAClassController.m
//  SDArtWorldCloud
//
//  Created by metis on 2019/11/22.
//  Copyright © 2019 Sudo. All rights reserved.
//

#import "VAClassController.h"
#import "VAClassModel.h"
@interface VAClassController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *classTableView;
@property(nonatomic,strong)NSMutableArray *classMutableArray;
@property(nonatomic,strong)VAClassModel *classMainModel;
@property(nonatomic,strong)NSIndexPath *lastPath;
@property(nonatomic,strong)Classes *selectedModel;
@end

@implementation VAClassController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"班级选择";
    [self.view addSubview:self.classTableView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(clickSureBtn)];
    [self getClassData];
}
-(UITableView *)classTableView{
    if (!_classTableView) {
        _classTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSystemWidth, KSystemHeight - NavigationContentTop - TabBarHeight)];
        _classTableView.delegate = self;
        _classTableView.dataSource = self;
        _classTableView.showsVerticalScrollIndicator = NO;
        _classTableView.showsHorizontalScrollIndicator = NO;
        _classTableView.tableFooterView = [[UIView alloc]init];
    }
    return _classTableView;
}
-(NSMutableArray *)classMutableArray{
  if (!_classMutableArray) {
    _classMutableArray = [NSMutableArray array];
  }
  return _classMutableArray;
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
                    [self.classTableView reloadData];
                }
                
            } failure:^(NSError *error) {
                
            }];
        }
        else{
            VANetWorkError
        }
    }
}

#pragma mark -点击确定按钮
-(void)clickSureBtn{
    if (self.clickSureBtnBlock) {
        [YSFileManager clearCacheWithFilePath:@"ClassModel"];
        [YSFileManager setCustomObject:self.selectedModel forKey:@"ClassModel"];
        self.clickSureBtnBlock(self.selectedModel);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma - UITableViewDelegate

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.classMutableArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell  =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        if (self.classMutableArray.count) {
            Classes *classModel = self.classMutableArray[indexPath.row];
            cell.textLabel.text = classModel.name;
        }
    }
      NSInteger row = [indexPath row];
      NSInteger oldRow = [self.lastPath row];
       if (row == oldRow && self.lastPath!=nil) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;

       }else{
         cell.accessoryType = UITableViewCellAccessoryNone;

    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
       NSInteger newRow = [indexPath row];
       NSInteger oldRow = (self.lastPath !=nil)?[self.lastPath row]:-1;
       if (newRow != oldRow) {
           UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
           newCell.accessoryType = UITableViewCellAccessoryCheckmark;
           UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:self.lastPath];
           oldCell.accessoryType = UITableViewCellAccessoryNone;
           self.lastPath = indexPath;
           self.selectedModel = self.classMutableArray[indexPath.row];
        }
       [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
