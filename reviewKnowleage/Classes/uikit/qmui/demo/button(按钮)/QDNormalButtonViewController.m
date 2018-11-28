//
//  QDNormalButtonViewController.m
//  reviewKnowleage
//
//  Created by fushp on 2018/10/17.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "QDNormalButtonViewController.h"

@interface QDNormalButtonViewController ()

@property(nonatomic, strong) UIScrollView *scrollview;

//普通按钮
@property(nonatomic, strong) QMUIButton *normalButton;
@property(nonatomic, strong) QMUIButton *borderedButton;

// 分割线
@property(nonatomic, strong) CALayer *separatorLayer;
@property(nonatomic, strong) QMUIButton *imagePositionButton1;
@property(nonatomic, strong) QMUIButton *imagePositionButton2;
@property(nonatomic, strong) CAShapeLayer *imageButtonSeparatorLayer;


//下划线按钮
@property(nonatomic, strong) QMUILinkButton *linkButton1;
@property(nonatomic, strong) CALayer *separatorLayer1;
@property(nonatomic, strong) QMUILinkButton *linkButton2;
@property(nonatomic, strong) CALayer *separatorLayer2;
@property(nonatomic, strong) QMUILinkButton *linkButton3;
@property(nonatomic, strong) CALayer *separatorLayer3;

//幽灵按钮
@property(nonatomic, strong) QMUIGhostButton *ghostButton1;
@property(nonatomic, strong) QMUIGhostButton *ghostButton2;
@property(nonatomic, strong) QMUIGhostButton *ghostButton3;
@property(nonatomic, strong) CALayer *ghostSeparatorLayer1;
@property(nonatomic, strong) CALayer *ghostSeparatorLayer2;
@property(nonatomic, strong) CALayer *ghostSeparatorLayer3;

//填充按钮  实心填充颜色的按钮，支持预定义的几个色值

@property(nonatomic, strong) QMUIFillButton *fillButton1;
@property(nonatomic, strong) QMUIFillButton *fillButton2;
@property(nonatomic, strong) QMUIFillButton *fillButton3;

@property(nonatomic, strong) CALayer *fillSeparatorLayer1;
@property(nonatomic, strong) CALayer *fillSeparatorLayer2;
@property(nonatomic, strong) CALayer *fillSeparatorLayer3;



//导航栏按钮

//标签按钮

@end

@implementation QDNormalButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initSubviews {
    [super initSubviews];
    self.scrollview = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollview.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height+300);
    self.scrollview.scrollEnabled = YES;
    [self.view addSubview:self.scrollview];
    [self initSubviewsNormal];
    [self initSubviewsLink];
    [self initSubviewGhost];
    [self initSubviewsFill];
    [self initSubviewsNav];
    [self initSubviewsToolbar];
}



#pragma mark -普通按钮
- (void)initSubviewsNormal {
    // 普通按钮
    self.normalButton = [QDUIHelper generateDarkFilledButton];
    [self.normalButton setTitle:NSLocalizedString(@"QMUIButton_Normal_Button_Title", @"按钮，支持高亮背景色") forState:UIControlStateNormal];
    [self.scrollview addSubview:self.normalButton];
    
    self.separatorLayer = [CALayer qmui_separatorLayer];
    [self.scrollview.layer addSublayer:self.separatorLayer];
    
    // 边框按钮
    self.borderedButton = [QDUIHelper generateLightBorderedButton];
    [self.borderedButton setTitle:NSLocalizedString(@"QMUIButton_Bordered_Button_Title", @"边框支持高亮的按钮") forState:UIControlStateNormal];
    [self.scrollview addSubview:self.borderedButton];
    
    // 图片+文字按钮
    self.imagePositionButton1 = [[QMUIButton alloc] init];
    self.imagePositionButton1.tintColorAdjustsTitleAndImage = [QDThemeManager sharedInstance].currentTheme.themeTintColor;
    self.imagePositionButton1.imagePosition = QMUIButtonImagePositionTop;// 将图片位置改为在文字上方
    self.imagePositionButton1.spacingBetweenImageAndTitle = 8;
    [self.imagePositionButton1 setImage:UIImageMake(@"icon_emotion") forState:UIControlStateNormal];
    [self.imagePositionButton1 setTitle:NSLocalizedString(@"QMUIButton_Image_Position_Button_Title_1", @"Text below image") forState:UIControlStateNormal];
    self.imagePositionButton1.titleLabel.font = UIFontMake(11);
    self.imagePositionButton1.qmui_borderPosition = QMUIViewBorderPositionTop | QMUIViewBorderPositionBottom;
    [self.scrollview addSubview:self.imagePositionButton1];
    
    self.imagePositionButton2 = [[QMUIButton alloc] init];
    self.imagePositionButton2.tintColorAdjustsTitleAndImage = [QDThemeManager sharedInstance].currentTheme.themeTintColor;
    self.imagePositionButton2.imagePosition = QMUIButtonImagePositionBottom;// 将图片位置改为在文字下方
    self.imagePositionButton2.spacingBetweenImageAndTitle = 8;
    [self.imagePositionButton2 setImage:UIImageMake(@"icon_emotion") forState:UIControlStateNormal];
    [self.imagePositionButton2 setTitle:NSLocalizedString(@"QMUIButton_Image_Position_Button_Title_2", @"Text above image") forState:UIControlStateNormal];
    self.imagePositionButton2.titleLabel.font = UIFontMake(11);
    self.imagePositionButton2.qmui_borderPosition = QMUIViewBorderPositionTop | QMUIViewBorderPositionBottom;
    [self.scrollview addSubview:self.imagePositionButton2];
    
    self.imageButtonSeparatorLayer = [CAShapeLayer qmui_separatorDashLayerWithLineLength:3 lineSpacing:0 lineWidth:PixelOne lineColor:UIColorSeparator.CGColor isHorizontal:NO];
    [self.scrollview.layer addSublayer:self.imageButtonSeparatorLayer];
}

- (void)viewDidLayoutSubviewsNormal {
    CGFloat contentMinY = 0;
//    CGFloat contentMinY = self.qmui_navigationBarMaxYInViewCoordinator;
    CGFloat buttonSpacingHeight = QDButtonSpacingHeight;
    //普通按钮
    self.normalButton.frame = CGRectSetXY(self.normalButton.frame, CGFloatGetCenter(CGRectGetWidth(self.scrollview.bounds), CGRectGetWidth(self.normalButton.frame)),contentMinY+ CGFloatGetCenter(buttonSpacingHeight, CGRectGetHeight(self.normalButton.frame)));
    self.separatorLayer.frame = CGRectFlatMake(0, contentMinY + buttonSpacingHeight - PixelOne, CGRectGetWidth(self.scrollview.bounds), PixelOne);
    //高亮按钮
    self.borderedButton.frame = CGRectSetY(self.normalButton.frame, CGRectGetMaxY(self.separatorLayer.frame) + CGFloatGetCenter(buttonSpacingHeight, CGRectGetHeight(self.normalButton.frame)));
    //图片文字按钮
    self.imagePositionButton1.frame = CGRectFlatMake(0, contentMinY + buttonSpacingHeight * 2, CGRectGetWidth(self.scrollview.bounds) / 2.0, buttonSpacingHeight);
    self.imagePositionButton2.frame = CGRectSetX(self.imagePositionButton1.frame, CGRectGetMaxX(self.imagePositionButton1.frame));
    
    self.imageButtonSeparatorLayer.frame = CGRectFlatMake(CGRectGetMaxX(self.imagePositionButton1.frame), CGRectGetMinY(self.imagePositionButton1.frame), PixelOne, buttonSpacingHeight);
}

#pragma mark -下划线按钮
- (void)initSubviewsLink {
    self.linkButton1 = [QDUIHelper generateLinkButtonWithTitle:@"带下划线的按钮"];
    [self.scrollview addSubview:self.linkButton1];
    
    self.separatorLayer1 = [QDUIHelper generateSeparatorLayer];
    [self.scrollview.layer addSublayer:self.separatorLayer1];
    
    self.linkButton2 = [QDUIHelper generateLinkButtonWithTitle:@"修改下划线颜色"];
    self.linkButton2.underlineColor = UIColorTheme8;
    [self.scrollview addSubview:self.linkButton2];
    
    self.separatorLayer2 = [QDUIHelper generateSeparatorLayer];
    [self.scrollview.layer addSublayer:self.separatorLayer2];
    
    self.linkButton3 = [QDUIHelper generateLinkButtonWithTitle:@"修改下划线的位置"];
    self.linkButton3.underlineInsets = UIEdgeInsetsMake(0, 32, 0, 46);
    [self.scrollview addSubview:self.linkButton3];
    
    self.separatorLayer3 = [QDUIHelper generateSeparatorLayer];
    [self.scrollview.layer addSublayer:self.separatorLayer3];
}

- (void)viewDidLayoutSubviewsLink {
    CGFloat contentMinY =  CGRectGetMaxY(self.imageButtonSeparatorLayer.frame);

//    CGFloat contentMinY = self.qmui_navigationBarMaxYInViewCoordinator;
    CGFloat buttonSpacingHeight = 64;
    
    self.separatorLayer1.frame = CGRectMake(0, contentMinY + buttonSpacingHeight - PixelOne, CGRectGetWidth(self.scrollview.bounds), PixelOne);
    self.separatorLayer2.frame = CGRectSetY(self.separatorLayer1.frame, contentMinY + buttonSpacingHeight * 2 - PixelOne);
    self.separatorLayer3.frame = CGRectSetY(self.separatorLayer1.frame, contentMinY + buttonSpacingHeight * 3 - PixelOne);
    self.linkButton1.frame = CGRectSetXY(self.linkButton1.frame, CGRectGetMinXHorizontallyCenterInParentRect(self.scrollview.bounds, self.linkButton1.frame), contentMinY + CGFloatGetCenter(buttonSpacingHeight, CGRectGetHeight(self.linkButton1.frame)));
    self.linkButton2.frame = CGRectSetXY(self.linkButton2.frame, CGRectGetMinXHorizontallyCenterInParentRect(self.scrollview.bounds, self.linkButton2.frame), contentMinY + buttonSpacingHeight + CGFloatGetCenter(buttonSpacingHeight, CGRectGetHeight(self.linkButton2.frame)));
    self.linkButton3.frame = CGRectSetXY(self.linkButton3.frame, CGRectGetMinXHorizontallyCenterInParentRect(self.scrollview.bounds, self.linkButton3.frame), contentMinY + buttonSpacingHeight * 2 + CGFloatGetCenter(buttonSpacingHeight, CGRectGetHeight(self.linkButton3.frame)));
}

#pragma mark -幽灵按钮
- (void)initSubviewGhost {
    self.ghostButton1 = [[QMUIGhostButton alloc] initWithGhostType:QMUIGhostButtonColorBlue];
    self.ghostButton1.titleLabel.font = UIFontMake(14);
    [self.ghostButton1 setTitle:@"QMUIGhostButtonColorBlue" forState:UIControlStateNormal];
    [self.scrollview addSubview:self.ghostButton1];
    
    self.ghostButton2 = [[QMUIGhostButton alloc] initWithGhostType:QMUIGhostButtonColorRed];
    self.ghostButton2.titleLabel.font = UIFontMake(14);
    [self.ghostButton2 setTitle:@"QMUIGhostButtonColorRed" forState:UIControlStateNormal];
    [self.scrollview addSubview:self.ghostButton2];
    
    self.ghostButton3 = [[QMUIGhostButton alloc] initWithGhostType:QMUIGhostButtonColorGreen];
    self.ghostButton3.titleLabel.font = UIFontMake(14);
    [self.ghostButton3 setTitle:@"点击修改ghostColor" forState:UIControlStateNormal];
    [self.ghostButton3 setImage:UIImageMake(@"icon_emotion") forState:UIControlStateNormal];
    self.ghostButton3.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 6);
    self.ghostButton3.adjustsImageWithGhostColor = YES;
    [self.ghostButton3 addTarget:self action:@selector(handleGhostButtonColorEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollview addSubview:self.ghostButton3];
    
    self.ghostSeparatorLayer1 = [QDUIHelper generateSeparatorLayer];
    [self.scrollview.layer addSublayer:self.ghostSeparatorLayer1];
    
    self.ghostSeparatorLayer2 = [QDUIHelper generateSeparatorLayer];
    [self.scrollview.layer addSublayer:self.ghostSeparatorLayer2];
    
    self.ghostSeparatorLayer3 = [QDUIHelper generateSeparatorLayer];
    [self.scrollview.layer addSublayer:self.ghostSeparatorLayer3];
}

- (void)viewDidLayoutSubviewsGhost {
    CGFloat contentMinY = CGRectGetMaxY(self.separatorLayer3.frame);
//    CGFloat contentMinY = self.qmui_navigationBarMaxYInViewCoordinator;
    CGFloat buttonSpacingHeight = QDButtonSpacingHeight;
    CGSize buttonSize = CGSizeMake(260, 40);
    CGFloat buttonMinX = CGFloatGetCenter(CGRectGetWidth(self.scrollview.bounds), buttonSize.width);
    CGFloat buttonOffsetY = CGFloatGetCenter(buttonSpacingHeight, buttonSize.height);
    
    self.ghostButton1.frame = CGRectFlatMake(buttonMinX, contentMinY + buttonOffsetY, buttonSize.width, buttonSize.height);
    self.ghostButton2.frame = CGRectFlatMake(buttonMinX, contentMinY + buttonSpacingHeight + buttonOffsetY, buttonSize.width, buttonSize.height);
    self.ghostButton3.frame = CGRectFlatMake(buttonMinX, contentMinY + buttonSpacingHeight * 2 + buttonOffsetY, buttonSize.width, buttonSize.height);
    
    self.ghostSeparatorLayer1.frame = CGRectMake(0, contentMinY + buttonSpacingHeight - PixelOne, CGRectGetWidth(self.scrollview.bounds), PixelOne);
    self.ghostSeparatorLayer2.frame = CGRectSetY(self.ghostSeparatorLayer1.frame, contentMinY + buttonSpacingHeight * 2 - PixelOne);
    self.ghostSeparatorLayer3.frame = CGRectSetY(self.ghostSeparatorLayer2.frame, contentMinY + buttonSpacingHeight * 3 - PixelOne);
}


#pragma mark -填充按钮
- (void)initSubviewsFill {
    self.fillButton1 = [[QMUIFillButton alloc] initWithFillType:QMUIFillButtonColorBlue];
    self.fillButton1.titleLabel.font = UIFontMake(14);
    [self.scrollview addSubview:self.fillButton1];
    [self.fillButton1 setTitle:@"QMUIFillButtonColorBlue" forState:UIControlStateNormal];
    
    self.fillButton2 = [[QMUIFillButton alloc] initWithFillType:QMUIFillButtonColorRed];
    [self.fillButton2 setTitle:@"QMUIFillButtonColorRed" forState:UIControlStateNormal];
    [self.scrollview addSubview:self.fillButton2];
    
    self.fillButton3 = [[QMUIFillButton alloc] initWithFillType:QMUIFillButtonColorGreen];
    [self.fillButton3 setTitle:@"点击修改按钮fillColor" forState:UIControlStateNormal];
    [self.fillButton3 setImage:UIImageMake(@"icon_emotion") forState:UIControlStateNormal];
//    self.fillButton3.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 6);
    self.fillButton3.adjustsImageWithTitleTextColor = YES;
    [self.fillButton3 addTarget:self action:@selector(handleFillButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollview addSubview:self.fillButton3];
    self.fillSeparatorLayer1 = [QDUIHelper generateSeparatorLayer];
    self.fillSeparatorLayer2 = [QDUIHelper generateSeparatorLayer];
    self.fillSeparatorLayer3 = [QDUIHelper generateSeparatorLayer];
    [self.scrollview.layer addSublayer:self.fillSeparatorLayer1];
    [self.scrollview.layer addSublayer:self.fillSeparatorLayer2];
    [self.scrollview.layer addSublayer:self.fillSeparatorLayer3];
}
- (void)viewDidLayoutSubviewsFill {
    CGFloat contentMinY = CGRectGetMaxY(self.ghostSeparatorLayer3.frame);
    CGFloat buttonSpacingHeight = QDButtonSpacingHeight;
    CGSize buttonSize = CGSizeMake(260, 40);
    CGFloat buttonMinX = CGFloatGetCenter(CGRectGetWidth(self.view.bounds), buttonSize.width);
    CGFloat buttonOffsetY = CGFloatGetCenter(buttonSpacingHeight, buttonSize.height);
    
    self.fillButton1.frame = CGRectFlatMake(buttonMinX, contentMinY + buttonOffsetY, buttonSize.width, buttonSize.height);
    self.fillButton2.frame = CGRectFlatMake(buttonMinX, contentMinY + buttonSpacingHeight + buttonOffsetY, buttonSize.width, buttonSize.height);
    self.fillButton3.frame = CGRectFlatMake(buttonMinX, contentMinY + buttonSpacingHeight * 2 + buttonOffsetY, buttonSize.width, buttonSize.height);
    
    self.fillSeparatorLayer1.frame = CGRectMake(0, contentMinY + buttonSpacingHeight - PixelOne, CGRectGetWidth(self.view.bounds), PixelOne);
    self.fillSeparatorLayer2.frame = CGRectSetY(self.fillSeparatorLayer1.frame, contentMinY + buttonSpacingHeight * 2 - PixelOne);
    self.fillSeparatorLayer3.frame = CGRectSetY(self.fillSeparatorLayer2.frame, contentMinY + buttonSpacingHeight * 3 - PixelOne);
    
}


#pragma mark -导航栏按钮
- (void)initSubviewsNav {
    
}

- (void)viewDidLayoutSubviewsNav {
    
}

#pragma mark -Toolbar按钮
- (void)initSubviewsToolbar {
    
}

- (void)viewDidLayoutSubviewsToolbar {
 
    
}

// 设置frame
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self viewDidLayoutSubviewsNormal];
    [self viewDidLayoutSubviewsLink];
    [self viewDidLayoutSubviewsGhost];
    [self viewDidLayoutSubviewsFill];
    [self viewDidLayoutSubviewsNav];
    [self viewDidLayoutSubviewsToolbar];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleGhostButtonColorEvent {
    UIColor *color = [QDCommonUI randomThemeColor];
    self.ghostButton3.ghostColor = color;
}

- (void)handleFillButtonEvent:(id)sender {
    UIColor *color = [QDCommonUI randomThemeColor];
    self.fillButton3.fillColor = color;
    self.fillButton3.titleTextColor = UIColorWhite;
}
@end
