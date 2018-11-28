//
//  QDUIHelper.m
//  reviewKnowleage
//
//  Created by fushp on 2018/10/15.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "QDUIHelper.h"

@implementation QDUIHelper

@end





@implementation QDUIHelper (QMUIMoreOperationAppearance)

+ (void)customMoreOperationAppearance {
    // 如果需要统一修改全局的 QMUIMoreOperationController 样式，在这里修改 appearance 的值即可
  
}

@end


@implementation QDUIHelper (QMUIDialogViewControllerAppearance)

+ (void)customDialogViewControllerAppearance {
   
}

@end

@implementation QDUIHelper (QMUIEmotionView)

+ (void)customEmotionViewAppearance {
  
}

@end

@implementation QDUIHelper (QMUIImagePicker)

+ (void)customImagePickerAppearance {
   
}

@end

@implementation QDUIHelper (QMUIAlertControllerAppearance)

+ (void)customAlertControllerAppearance {
    // 如果需要统一修改全局的 QMUIAlertController 样式，在这里修改 appearance 的值即可
  
}

@end



@implementation QDUIHelper (Button)
+ (QMUIButton *)generateDarkFilledButton {
    QMUIButton *button = [[QMUIButton alloc] qmui_initWithSize:CGSizeMake(200, 40)];
    button.adjustsButtonWhenHighlighted = YES;
    button.titleLabel.font = UIFontBoldMake(14);
    [button setTitleColor:UIColorWhite forState:UIControlStateNormal];
    button.backgroundColor = [QDThemeManager sharedInstance].currentTheme.themeTintColor;
    button.highlightedBackgroundColor = [[QDThemeManager sharedInstance].currentTheme.themeTintColor qmui_transitionToColor:UIColorBlack progress:.15];// 高亮时的背景色
    button.layer.cornerRadius = 4;
    return button;
}



+ (QMUIButton *)generateLightBorderedButton {
    QMUIButton *button = [[QMUIButton alloc] qmui_initWithSize:CGSizeMake(200, 40)];
    button.titleLabel.font = UIFontBoldMake(14);
    [button setTitleColor:[QDThemeManager sharedInstance].currentTheme.themeTintColor forState:UIControlStateNormal];
    button.backgroundColor = [[QDThemeManager sharedInstance].currentTheme.themeTintColor qmui_transitionToColor:UIColorWhite progress:.9];
    button.highlightedBackgroundColor = [[QDThemeManager sharedInstance].currentTheme.themeTintColor qmui_transitionToColor:UIColorWhite progress:.75];// 高亮时的背景色
    button.layer.borderColor = [button.backgroundColor qmui_transitionToColor:[QDThemeManager sharedInstance].currentTheme.themeTintColor progress:.5].CGColor;
    button.layer.borderWidth = 1;
    button.layer.cornerRadius = 4;
    button.highlightedBorderColor = [button.backgroundColor qmui_transitionToColor:[QDThemeManager sharedInstance].currentTheme.themeTintColor progress:.9];// 高亮时的边框颜色
    return button;
}
// 下划线
+ (QMUILinkButton*)generateLinkButtonWithTitle:(NSString*)title {
    QMUILinkButton *linkButton = [[QMUILinkButton alloc] init];
    linkButton.adjustsTitleTintColorAutomatically = YES;
    linkButton.tintColor = [QDThemeManager sharedInstance].currentTheme.themeTintColor;
    linkButton.titleLabel.font = UIFontMake(15);
    [linkButton setTitle:title forState:UIControlStateNormal];
    [linkButton sizeToFit];
    return linkButton;
}
@end


@implementation QDUIHelper (Layer)

+ (CALayer *)generateSeparatorLayer {
    CALayer *layer = [CALayer layer];
    [layer qmui_removeDefaultAnimations];
    layer.backgroundColor = UIColorSeparator.CGColor;
    return layer;
}



@end

@implementation QDUIHelper (UITabBarItem)

+ (UITabBarItem *)tabBarItemWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage tag:(NSInteger)tag {
    UITabBarItem * tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:image tag:tag];
    tabBarItem.selectedImage = selectedImage;
    return tabBarItem;
}

@end


@implementation QDUIHelper (FFDialogTextFieldViewController)



+ (QMUIDialogTextFieldViewController*)showNormalTextFieldDialogViewController:(NSString*)title headTitleWithTextField:(NSString*)headTitleWithTextField  placeholderText:(NSString*)placeholderText{
    FFDialogTextFieldViewController *dialogViewController = [[FFDialogTextFieldViewController alloc] init];
//    dialogViewController.title = @"请输入短信验证码";
    dialogViewController.title = title;
    [dialogViewController addTextFieldWithTitle:headTitleWithTextField configurationHandler:^(QMUILabel *titleLabel, QMUITextField *textField, CALayer *separatorLayer) {
        titleLabel.numberOfLines = 0;
        NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:titleLabel.text];
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle1 setLineSpacing:9];
        [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [titleLabel.text length])];
        [titleLabel setAttributedText:attributedString1];
        textField.placeholder = placeholderText;
        textField.maximumTextLength = 10;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    dialogViewController.textFieldHeight = 50;
    dialogViewController.dialogViewMargins = UIEdgeInsetsMake(20, 50, 20, 50);
    [dialogViewController setTextFieldLabelFont:[UIFont systemFontOfSize:14]];
    [dialogViewController addCancelButtonWithText:@"取消" block:nil];
    [dialogViewController addSubmitButtonWithText:@"确定" block:^(QMUIDialogTextFieldViewController *aDialogViewController) {
        if (aDialogViewController.textFields.firstObject.text.length > 0) {
            [aDialogViewController hide];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [QMUITips showSucceed:@"提交成功" inView:self.view hideAfterDelay:1.2];
            });
        } else {
//            [QMUITips showInfo:@"请填写内容" inView:self.view hideAfterDelay:1.2];
        }
    }];
    
    return dialogViewController;
}


//+ (FFDialogViewController*)showNormalDialogViewController {
//    FFDialogViewController *dialogViewController = [[FFDialogViewController alloc] init];
//    dialogViewController.title = @"提示";
//    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
//    contentView.backgroundColor = UIColorWhite;
//    UILabel *label = [[UILabel alloc] qmui_initWithFont:UIFontMake(14) textColor:Color_15152D_alpha(0.7)];
//    label.text = @"清除缓存？";
//    [label sizeToFit];
//    label.center = CGPointMake(CGRectGetWidth(contentView.bounds) / 2.0, CGRectGetHeight(contentView.bounds) / 2.0);
//    [contentView addSubview:label];
//    dialogViewController.contentView = contentView;
//    [dialogViewController addCancelButtonWithText:@"取消" block:nil];
//    [dialogViewController addSubmitButtonWithText:@"确定" block:^(QMUIDialogViewController *aDialogViewController) {
//        [aDialogViewController hide];
//    }];
//    return dialogViewController;
//}

+ (FFDialogViewController*)showNormalDialogViewController:(NSString*)title contenText:(NSString*)contenText {
    FFDialogViewController *dialogViewController = [[FFDialogViewController alloc] init];
    dialogViewController.title = title;
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
    contentView.backgroundColor = UIColorWhite;
    UILabel *label = [[UILabel alloc] qmui_initWithFont:UIFontMake(14) textColor:Color_15152D_alpha(0.7)];
    label.text = contenText;
    [label sizeToFit];
    label.center = CGPointMake(CGRectGetWidth(contentView.bounds) / 2.0, CGRectGetHeight(contentView.bounds) / 2.0);
    [contentView addSubview:label];
    dialogViewController.contentView = contentView;
    [dialogViewController addCancelButtonWithText:@"取消" block:nil];
    [dialogViewController addSubmitButtonWithText:@"确定" block:^(QMUIDialogViewController *aDialogViewController) {
        [aDialogViewController hide];
    }];
    return dialogViewController;
}
@end








