//
//  FSPFoldingUnfoldingViewController.m
//  reviewKnowleage
//
//  Created by fushp on 2018/12/7.
//  Copyright © 2018年 fushp. All rights reserved.
//


#define kCell_Height 64

#import "FSPFoldingUnfoldingViewController.h"

@interface FSPFoldingUnfoldingViewController ()<QMUITableViewDataSource,QMUITableViewDelegate,UIGestureRecognizerDelegate>
@property(nonatomic, strong) QMUITableView *foldTableview;
@property(nonatomic, strong) NSMutableArray      *dataSource;
@property(nonatomic, strong) NSMutableArray      *sectionArray;
@property(nonatomic, strong) NSMutableArray      *stateArray;
@end

@implementation FSPFoldingUnfoldingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSource];
    [self initTable];
    // Do any additional setup after loading the view.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.stateArray[section] isEqualToString:@"1"]){
        //如果是展开状态
        NSArray *array = [self.dataSource objectAtIndex:section];
        return array.count;
    }else{
        //如果是闭合，返回0
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kCell_Height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kCell_Height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    [button setTag:section+1];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 60)];
    [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *tlabel = [[UILabel alloc]initWithFrame:CGRectMake(45, (kCell_Height-20)/2, 200, 20)];
    [tlabel setBackgroundColor:[UIColor clearColor]];
    [tlabel setFont:[UIFont systemFontOfSize:14]];
    [tlabel setText:self.sectionArray[section]];
    [button addSubview:tlabel];
    return button;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    QMUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[QMUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.textLabel.text = self.dataSource[indexPath.section][indexPath.row];
    }
    return cell;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.sectionArray[section];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark - private methods
- (void)initDataSource
{
    self.sectionArray  = [NSMutableArray arrayWithObjects:@"A类车故障",
                     @"B类车故障",
                     @"C类车故障",
                     @"D类车故障",nil];
    
    NSArray *one = @[@"车压",@"窗户",@"车轮"];
    NSArray *two = @[@"车压",@"窗户",@"车轮"];
    NSArray *three =@[@"车压",@"窗户",@"车轮"];
    NSArray *four = @[@"车压",@"窗户",@"车轮"];
    
    self.dataSource = [NSMutableArray arrayWithObjects:one,two,three,four, nil];
    self.stateArray = [NSMutableArray array];
    
    for (int i = 0; i < self.dataSource.count; i++)
    {
        //所有的分区都是闭合
        [self.stateArray addObject:@"0"];
    }
    
}




-(void)initTable{
    self.foldTableview = [[QMUITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.foldTableview.dataSource = self;
    self.foldTableview.delegate =  self;
    self.foldTableview.tableFooterView = [UIView new];
    [self.view addSubview:self.foldTableview];
}

- (void)buttonPress:(UIButton *)sender//headButton点击
{
    //判断状态值
    if ([self.stateArray[sender.tag - 1] isEqualToString:@"1"]){
        //修改
        [self.stateArray replaceObjectAtIndex:sender.tag - 1 withObject:@"0"];
    }else{
        [self.stateArray replaceObjectAtIndex:sender.tag - 1 withObject:@"1"];
    }
    [self.foldTableview reloadSections:[NSIndexSet indexSetWithIndex:sender.tag-1] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

@end
