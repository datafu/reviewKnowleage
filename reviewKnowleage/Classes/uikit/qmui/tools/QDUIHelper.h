//
//  QDUIHelper.h
//  reviewKnowleage
//
//  Created by fushp on 2018/10/15.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FFDialogViewController.h"
#import "FFDialogTextFieldViewController.h"
@interface QDUIHelper : NSObject

@end


/////////////////////////////////////////Button /////////////////////////////////////////////////////
/**
    快速创建一个不同类型的按钮
 包括:
      1. 提交类按钮 
 */
@interface QDUIHelper (Button)
+ (QMUIButton *)generateDarkFilledButton;
+ (QMUIButton *)generateLightBorderedButton;
/** 下划线按钮*/
+ (QMUILinkButton*)generateLinkButtonWithTitle:(NSString*)title;
@end
//////////////////////////////////////////////////////////////////////////////////////////////





@interface QDUIHelper (Layer)
+ (CALayer *)generateSeparatorLayer;

@end

/**
 UITextField 封装
 */
@interface QDUIHelper (UITextField)

+ (QMUITextField*)initWithLeftImg:(NSString*)imagName;

@end

/**
 MoreOperation 样式
 */
@interface QDUIHelper (QMUIMoreOperationAppearance)

+ (void)customMoreOperationAppearance;

@end


/**
 AlertController 样式
 */
@interface QDUIHelper (QMUIAlertControllerAppearance)

+ (void)customAlertControllerAppearance;

@end


/**
 DialogViewController 样式
 */
@interface QDUIHelper (QMUIDialogViewControllerAppearance)

+ (void)customDialogViewControllerAppearance;

@end

/**
 EmotionView 样式
 */
@interface QDUIHelper (QMUIEmotionView)

+ (void)customEmotionViewAppearance;
@end



/**
 ImagePicker 样式
 */
@interface QDUIHelper (QMUIImagePicker)

+ (void)customImagePickerAppearance;

@end




/**
 UITabBarItem 方法封装
 */
@interface QDUIHelper (UITabBarItem)
+ (UITabBarItem *)tabBarItemWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage tag:(NSInteger)tag;

@end




/**
 创建一个textfiled 的dialog框
 */
@interface QDUIHelper (FFDialogTextFieldViewController)



+ (QMUIDialogTextFieldViewController*)showNormalTextFieldDialogViewController:(NSString*)title headTitleWithTextField:(NSString*)headTitleWithTextField  placeholderText:(NSString*)placeholderText;

/**
 普通的dialog弹出框

 @param title 标题
 @param contenText 中间的提示信息
 */
+ (FFDialogViewController*)showNormalDialogViewController:(NSString*)title contenText:(NSString*)contenText ;
@end


