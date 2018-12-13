//
//  FSPDragTableviewController.m
//  reviewKnowleage
//
//  Created by fushp on 2018/12/7.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "FSPDragTableviewController.h"

@interface FSPDragTableviewController()<QMUITableViewDataSource,QMUITableViewDelegate,UIGestureRecognizerDelegate>
@property(nonatomic, strong) QMUITableView *drapTableview;
@property(nonatomic, strong) NSMutableArray *arr;
@property(nonatomic, strong) UILongPressGestureRecognizer *longPress;
@end
@implementation FSPDragTableviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.drapTableview];
    self.arr = [@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8"] mutableCopy];
    //添加长按手势
    self.longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognized:)];
    self.longPress.delegate = self;
    [self.drapTableview addGestureRecognizer:self.longPress];
    [self.drapTableview reloadData];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.drapTableview.frame  = self.view.bounds;
}

#pragma mark - TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    QMUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[QMUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.imageView.image = [UIImage qmui_imageWithShape:QMUIImageShapeOval size:CGSizeMake(16, 16) lineWidth:2 tintColor:[QDCommonUI randomThemeColor]];
        cell.textLabel.text = self.arr[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        if (indexPath.section == 0) {
                [self.arr removeObjectAtIndex:indexPath.row];
                [self.drapTableview deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
     
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
}


#pragma mark -- UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    CGPoint location = [touch locationInView:self.drapTableview];
    NSIndexPath *indexPath = [self.drapTableview indexPathForRowAtPoint:location];
    if (indexPath.section == 0&&(indexPath.row == 0 || indexPath.row == self.arr.count -1)) {
        return NO;
    }
    return YES;
}

- (void)longPressGestureRecognized:(id)sender {
    
    //    UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)sender;
    UIGestureRecognizerState state = self.longPress.state;
    //获取拖拽的位置
    CGPoint location = [self.longPress locationInView:self.drapTableview];
    NSIndexPath *indexPath = [self.drapTableview indexPathForRowAtPoint:location];
    
    static UIView *snapshot = nil;        ///< A snapshot of the row user is moving.
    static NSIndexPath  *sourceIndexPath = nil; ///< Initial index path, where gesture begins.
    if(indexPath.section == 0){
        switch (state) {
            case UIGestureRecognizerStateBegan: {
                if (indexPath) {
                    sourceIndexPath = indexPath;
                    
                    UITableViewCell *cell = [self.drapTableview cellForRowAtIndexPath:indexPath];
                    
                    // Take a snapshot of the selected row using helper method.
                    snapshot = [self customSnapshoFromView:cell];
                    
                    // Add the snapshot as subview, centered at cell's center...
                    __block CGPoint center = cell.center;
                    snapshot.center = center;
                    snapshot.alpha = 0.0;
                    [self.drapTableview addSubview:snapshot];
                    [UIView animateWithDuration:0.25 animations:^{
                        
                        // Offset for gesture location.
                        center.y = location.y;
                        snapshot.center = center;
                        snapshot.transform = CGAffineTransformMakeScale(1.05, 1.05);
                        snapshot.alpha = 0.98;
                        cell.alpha = 0.0;
                        cell.hidden = YES;
                        
                    }];
                }
                break;
            }
                
            case UIGestureRecognizerStateChanged: {
                CGPoint center = snapshot.center;
                center.y = location.y;
                snapshot.center = center;
                
                // Is destination valid and is it different from source?
                if (indexPath && ![indexPath isEqual:sourceIndexPath]&&(indexPath.row > 0 && indexPath.row < self.arr.count-1)) {
                    
                    // ... update data source.
                    [self.arr exchangeObjectAtIndex:indexPath.row withObjectAtIndex:sourceIndexPath.row];
                    
                    // ... move the rows.
                    [self.drapTableview moveRowAtIndexPath:sourceIndexPath toIndexPath:indexPath];
                    
                    // ... and update source so it is in sync with UI changes.
                    sourceIndexPath = indexPath;
                    
                }
                break;
            }
                
            default: {
                // Clean up.
                UITableViewCell *cell = [self.drapTableview cellForRowAtIndexPath:sourceIndexPath];
                cell.alpha = 0.0;
                
                [UIView animateWithDuration:0.25 animations:^{
                    
                    snapshot.center = cell.center;
                    snapshot.transform = CGAffineTransformIdentity;
                    snapshot.alpha = 0.0;
                    cell.alpha = 1.0;
                    
                } completion:^(BOOL finished) {
                    
                    cell.hidden = NO;
                    sourceIndexPath = nil;
                    [snapshot removeFromSuperview];
                    snapshot = nil;
                    
                }];
                
                break;
            }
        }
    }
   
}

#pragma mark - private methods
//添加一个快照图片
- (UIView *)customSnapshoFromView:(UIView *)inputView {
    
    // Make an image from the input view.
    UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, NO, 0);
    [inputView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Create an image view.
    UIView *snapshot = [[UIImageView alloc] initWithImage:image];
    snapshot.layer.masksToBounds = NO;
    snapshot.layer.cornerRadius = 0.0;
    snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
    snapshot.layer.shadowRadius = 5.0;
    snapshot.layer.shadowOpacity = 0.4;
    
    return snapshot;
}

#pragma mark -  setting and getting
- (QMUITableView*)drapTableview {
    if (!_drapTableview) {
        _drapTableview = [[QMUITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _drapTableview.delegate = self;
        _drapTableview.dataSource = self;
        _drapTableview.tableFooterView = [UIView new];
    }
    return _drapTableview;
}
- (NSMutableArray*)arr {
    if (!_arr) {
        _arr  =[NSMutableArray array];
    }
    return _arr;
    
}
@end
