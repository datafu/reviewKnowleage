//
//  SettingViewController.m
//  reviewKnowleage
//
//  Created by fushp on 2018/10/19.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "SettingViewController.h"
#import "HeadImgTableViewCell.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initTableView {
    [super initTableView];
    //
    [self datasource];
}
// 服务器请求数据源
- (void)datasource {
    QMUIStaticTableViewCellDataSource *dataSource = [[QMUIStaticTableViewCellDataSource alloc] initWithCellDataSections:@[
                                                                                                                          // section0
                                                                                                                          @[
                                                                                                                              // 一般情况下可以用 + 方法快速初始化一个 cellData
                                                                                                                              ({
        QMUIStaticTableViewCellData *d = [[QMUIStaticTableViewCellData alloc] init];
        d.identifier = 0;
        d.text = @"头像";
        d.cellClass = [HeadImgTableViewCell class];
        d.accessoryType = QMUIStaticTableViewCellAccessoryTypeDisclosureIndicator;
        d.style = UITableViewCellStyleValue1;
//        d.accessoryType = QMUIStaticTableViewCellAccessoryTypeSwitch;
//        d.accessoryValueObject = @YES;// switch 类型的，可以通过传一个 NSNumber 对象给 accessoryValueObject 来指定这个 switch.on 的值
//        d.accessoryTarget = self;
//        d.accessoryAction = @selector(handleSwitchCellEvent:);
        d.cellForRowBlock = ^(UITableView *tableView, __kindof QMUITableViewCell *cell, QMUIStaticTableViewCellData *cellData) {
            HeadImgTableViewCell * headCell = (HeadImgTableViewCell*)cell;
            QMUIButton* headBtn =headCell.headimgBtn;
            [headBtn addTarget:self
                        action:@selector(handleHeadImgBtnCellEvent:) forControlEvents:UIControlEventTouchUpInside];
//            switchControl.onTintColor = [QDThemeManager sharedInstance].currentTheme.themeTintColor;
//            switchControl.tintColor = switchControl.onTintColor;
        };
        d;
    }),
                                                                                                                              ({
        QMUIStaticTableViewCellData *d = [[QMUIStaticTableViewCellData alloc] init];
        d.identifier = 1;
        d.text = @"手机号";
        d.detailText = @"122383333333";
        d.didSelectTarget = self;
        d.didSelectAction = @selector(handleDisclosureIndicatorCellEvent:);
        d.accessoryType = QMUIStaticTableViewCellAccessoryTypeDisclosureIndicator;
        d.style = UITableViewCellStyleValue1;
        d;
    }) ,
                                                                                                                              ({
        QMUIStaticTableViewCellData *d = [[QMUIStaticTableViewCellData alloc] init];
        d.identifier = 2;
        d.text = @"用户名";
        d.detailText = @"xiaofu";
        d.didSelectTarget = self;
        d.didSelectAction = @selector(handleDisclosureIndicatorCellEvent:);
        d.accessoryType = QMUIStaticTableViewCellAccessoryTypeDisclosureIndicator;
        d.style = UITableViewCellStyleValue1;
        d;
    }) ,
                                                                                                                              ({
        QMUIStaticTableViewCellData *d = [[QMUIStaticTableViewCellData alloc] init];
        d.identifier = 3;
        d.text = @"登录密码";
        d.detailText = @"xiaofu";
        d.didSelectTarget = self;
        d.didSelectAction = @selector(handleDisclosureIndicatorCellEvent:);
        d.accessoryType = QMUIStaticTableViewCellAccessoryTypeDisclosureIndicator;
        d.style = UITableViewCellStyleValue1;
        d;
    }) ,
    ({
        QMUIStaticTableViewCellData *d = [[QMUIStaticTableViewCellData alloc] init];
        d.identifier = 4;
        d.text = @"安全码";
        d.detailText = @"编辑";
        d.didSelectTarget = self;
        d.didSelectAction = @selector(handleDisclosureIndicatorCellEvent:);
        d.accessoryType = QMUIStaticTableViewCellAccessoryTypeDisclosureIndicator;
        d.style = UITableViewCellStyleValue1;
        d;
    }) ,
    ({
        QMUIStaticTableViewCellData *d = [[QMUIStaticTableViewCellData alloc] init];
        d.identifier = 5;
        d.text = @"指纹识别";
        d.accessoryType = QMUIStaticTableViewCellAccessoryTypeSwitch;
        d.accessoryValueObject = @YES;// switch 类型的，可以通过传一个 NSNumber 对象给 accessoryValueObject 来指定这个 switch.on 的值
        d.accessoryTarget = self;
        d.accessoryAction = @selector(handleSwitchCellEvent:);
        d.cellForRowBlock = ^(UITableView *tableView, __kindof QMUITableViewCell *cell, QMUIStaticTableViewCellData *cellData) {
            UISwitch *switchControl = (UISwitch *)cell.accessoryView;
            switchControl.onTintColor = [QDThemeManager sharedInstance].currentTheme.themeTintColor;
            switchControl.tintColor = switchControl.onTintColor;
        };
        d;
    }),
    ({
        QMUIStaticTableViewCellData *d = [[QMUIStaticTableViewCellData alloc] init];
        d.identifier = 6;
        d.text = @"人脸识别";
        d.accessoryType = QMUIStaticTableViewCellAccessoryTypeSwitch;
        d.accessoryValueObject = @YES;// switch 类型的，可以通过传一个 NSNumber 对象给 accessoryValueObject 来指定这个 switch.on 的值
        d.accessoryTarget = self;
        d.accessoryAction = @selector(handleSwitchCellEvent:);
        d.cellForRowBlock = ^(UITableView *tableView, __kindof QMUITableViewCell *cell, QMUIStaticTableViewCellData *cellData) {
            UISwitch *switchControl = (UISwitch *)cell.accessoryView;
            switchControl.onTintColor = [QDThemeManager sharedInstance].currentTheme.themeTintColor;
            switchControl.tintColor = switchControl.onTintColor;
        };
        d;
    }),
    ({
        QMUIStaticTableViewCellData *d = [[QMUIStaticTableViewCellData alloc] init];
        d.identifier = 7;
        d.text = @"实名认证";
        d.detailText = @"已认证";
        d.didSelectTarget = self;
        d.didSelectAction = @selector(handleDisclosureIndicatorCellEvent:);
        d.accessoryType = QMUIStaticTableViewCellAccessoryTypeNone;
        d.style = UITableViewCellStyleValue1;
        d;
    }) ,
      ({
        QMUIStaticTableViewCellData *d = [[QMUIStaticTableViewCellData alloc] init];
        d.identifier = 8;
        d.text = @"车辆信息";
        d.detailText = @"编辑";
        d.didSelectTarget = self;
        d.didSelectAction = @selector(handleDisclosureIndicatorCellEvent:);
        d.accessoryType = QMUIStaticTableViewCellAccessoryTypeDisclosureIndicator;
        d.style = UITableViewCellStyleValue1;
        d;
    }) ,
            
//                                                                                                                              [QMUIStaticTableViewCellData staticTableViewCellDataWithIdentifier:0
//                                                                                                                                                                                           image:nil
//                                                                                                                                                                                            text:@"头像"
//                                                                                                                                                                                      detailText:@"详细标题"
//                                                                                                                                                                                 didSelectTarget:nil
//                                                                                                                                                                                 didSelectAction:NULL
//                                                                                                                                                                                   accessoryType:QMUIStaticTableViewCellAccessoryTypeDisclosureIndicator]
//                                                              ,
//                                                                                                                              [QMUIStaticTableViewCellData staticTableViewCellDataWithIdentifier:1
//                                                                                                                                                                                           image:nil
//                                                                                                                                                                                            text:@"手机号"
//                                                                                                                                                                                      detailText:@"详细标题1"
//                                                                                                                                                                                 didSelectTarget:nil
//                                                                                                                                                                                 didSelectAction:NULL
//                                                                                                                                                                                   accessoryType:QMUIStaticTableViewCellAccessoryTypeDisclosureIndicator]
//                                                                                                                              ,
//
                                                                                                                              ]]
                                                     
                                                        
                                                     ];
    // 把数据塞给 tableView 就可以刷新列表数据了
    self.tableView.qmui_staticCellDataSource = dataSource;
}

- (void)handleCheckmarkCellEvent:(QMUIStaticTableViewCellData *)cellData {
    // checkmark 类型的 cell 如果要实现单选，可以这么写
    
    if (cellData.accessoryType == QMUIStaticTableViewCellAccessoryTypeCheckmark) {
        // 选项没变化，直接结束
        return;
    }
    
    // 先取消之前的所有勾选
    for (QMUIStaticTableViewCellData *data in self.tableView.qmui_staticCellDataSource.cellDataSections[cellData.indexPath.section]) {
        data.accessoryType = QMUIStaticTableViewCellAccessoryTypeNone;
    }
    
    // 再勾选当前点击的 cell
    cellData.accessoryType = QMUIStaticTableViewCellAccessoryTypeCheckmark;
    
    // 注意：如果不需要考虑动画，则下面这两步不用这么麻烦，直接调用 [self.tableView reloadData] 即可
    
    // 刷新除了被点击的那个 cell 外的其他单选 cell
    NSMutableArray<NSIndexPath *> *indexPathsAnimated = [[NSMutableArray alloc] init];
    for (NSInteger i = 0, l = [self.tableView numberOfRowsInSection:cellData.indexPath.section]; i < l; i++) {
        if (i != cellData.indexPath.row) {
            [indexPathsAnimated addObject:[NSIndexPath indexPathForRow:i inSection:cellData.indexPath.section]];
        }
    }
    
    [self.tableView reloadRowsAtIndexPaths:indexPathsAnimated withRowAnimation:UITableViewRowAnimationNone];
    
    // 直接拿到 cell 去修改 accessoryType，保证动画不受 reload 的影响
    QMUITableViewCell *cell = [self.tableView cellForRowAtIndexPath:cellData.indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    cellData.accessoryType = QMUIStaticTableViewCellAccessoryTypeCheckmark;
}
- (void)handleAccessoryDetailButtonEvent:(QMUIStaticTableViewCellData *)cellData {
    [QMUITips showWithText:@"点击了右边的按钮" inView:self.view hideAfterDelay:1.2];
}

- (void)handleDisclosureIndicatorCellEvent:(QMUIStaticTableViewCellData *)cellData {
    // cell 的点击事件，注意第一个参数的类型是 QMUIStaticTableViewCellData
    [QMUITips showWithText:[NSString stringWithFormat:@"点击了 %@", cellData.text] inView:self.view hideAfterDelay:1.2];
}
- (void)handleSwitchCellEvent:(UISwitch *)switchControl {
    // UISwitch 的开关事件，注意第一个参数的类型是 UISwitch
    if (switchControl.on) {
        [QMUITips showSucceed:@"打开" inView:self.view hideAfterDelay:.8];
    } else {
        [QMUITips showError:@"关闭" inView:self.view hideAfterDelay:.8];
    }
}

- (void)handleHeadImgBtnCellEvent:(UIButton *)btn {
    // UISwitch 的开关事件，注意第一个参数的类型是 UISwitch
    [QMUITips showWithText:[NSString stringWithFormat:@"点击了handleHeadImgBtnCellEvent"] inView:self.view hideAfterDelay:1.2];
    //origin_image_checkbox_checked
    [btn setImage:[UIImage imageNamed:@"origin_image_checkbox_checked"] forState:0];
}



@end
