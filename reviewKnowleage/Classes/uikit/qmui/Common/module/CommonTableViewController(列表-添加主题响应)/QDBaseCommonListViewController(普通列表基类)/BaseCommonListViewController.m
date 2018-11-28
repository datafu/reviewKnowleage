//
//  BaseCommonListViewController.m
//  reviewKnowleage
//
//  Created by fushp on 2018/10/16.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "BaseCommonListViewController.h"

@implementation BaseCommonListViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:style]) {
        [self initDataSource];
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifierNormal = @"cellNormal";
    QMUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierNormal];
    if (!cell) {
        if (self.dataSourceWithDetailText) {
            cell = [[QMUITableViewCell alloc] initForTableView:tableView withStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifierNormal];
        } else {
            cell = [[QMUITableViewCell alloc] initForTableView:tableView withStyle:UITableViewCellStyleValue1 reuseIdentifier:identifierNormal];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (self.dataSourceWithDetailText) {
        NSString *keyName = self.dataSourceWithDetailText.allKeys[indexPath.row];
        cell.textLabel.text = keyName;
        cell.detailTextLabel.text = (NSString *)[self.dataSourceWithDetailText objectForKey:keyName];
    } else {
        cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.row];
    }
    cell.textLabel.font = UIFontMake(15);
    cell.detailTextLabel.font = UIFontMake(13);
    [cell updateCellAppearanceWithIndexPath:indexPath];
    return cell;
}

#pragma mark - UITableView Delegate & DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceWithDetailText ? self.dataSourceWithDetailText.count : self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataSourceWithDetailText && ((NSString *)[self.dataSourceWithDetailText objectForKey:self.dataSourceWithDetailText.allKeys[indexPath.row]]).length) {
        return 64;
    }
    return TableViewCellNormalHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = nil;
    if (self.dataSourceWithDetailText) {
        title = self.dataSourceWithDetailText.allKeys[indexPath.row];
    } else {
        title = [self.dataSource objectAtIndex:indexPath.row];
    }
    [self didSelectCellWithTitle:title];
}




@end
