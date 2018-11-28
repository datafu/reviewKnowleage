//
//  FSPselfAdaptViewController.m
//  reviewKnowleage
//
//  Created by fushp on 2018/11/16.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "FSPselfAdaptViewController.h"
#import "FSPviolationTableViewViewCell.h"

@interface FSPselfAdaptViewController ()
@property (weak, nonatomic) IBOutlet UITableView *self_adaptTableviwe;

@end

@implementation FSPselfAdaptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.self_adaptTableviwe.tableFooterView =[UIView new];
    [self.self_adaptTableviwe registerNib:[UINib nibWithNibName:@"FSPviolationTableViewViewCell" bundle:nil] forCellReuseIdentifier:@"FSPviolationTableViewViewCell"];
    self.self_adaptTableviwe.estimatedRowHeight = 100; //设置估计高度
    self.self_adaptTableviwe.rowHeight = UITableViewAutomaticDimension; //
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  5;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 125;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"FSPviolationTableViewViewCell";
    FSPviolationTableViewViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[FSPviolationTableViewViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.backgroundColor = [UIColor clearColor];
  
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableView *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
 
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
