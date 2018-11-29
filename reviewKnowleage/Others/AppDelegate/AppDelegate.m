//
//  AppDelegate.m
//  reviewKnowleage
//
//  Created by fushp on 2018/10/7.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "AppDelegate.h"
#import "QDGridViewController.h"
#import "BaseNavigationController.h"
#import "BaseTabBarViewController.h"
#import "LLDebug.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BaseNavigationController *)extracted:(QDGridViewController *)uikitViewController {
    BaseNavigationController * nav = [[ BaseNavigationController alloc] initWithRootViewController:uikitViewController];
    return nav;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    QDGridViewController *uikitViewController = [[QDGridViewController alloc] init];
    uikitViewController.hidesBottomBarWhenPushed = NO;
    BaseNavigationController * nav = [self extracted:uikitViewController];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    [self createTabBarController];
    [[LLDebugTool sharedTool] startWorking];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - private methods
- (void)createTabBarController {
    BaseTabBarViewController *tabBarViewController = [[BaseTabBarViewController alloc] init];
    
    // QMUIKit
    QDGridViewController *uikitViewController = [[QDGridViewController alloc] init];
    uikitViewController.hidesBottomBarWhenPushed = NO;
    BaseNavigationController *uikitNavController = [[BaseNavigationController alloc] initWithRootViewController:uikitViewController];
    uikitNavController.tabBarItem = [QDUIHelper tabBarItemWithTitle:@"QMUIKit" image:[UIImageMake(@"icon_tabbar_uikit") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:UIImageMake(@"icon_tabbar_uikit_selected") tag:0];
    
    // UIComponents
//    QDComponentsViewController *componentViewController = [[QDComponentsViewController alloc] init];
//    componentViewController.hidesBottomBarWhenPushed = NO;
//    QDNavigationController *componentNavController = [[QDNavigationController alloc] initWithRootViewController:componentViewController];
//    componentNavController.tabBarItem = [QDUIHelper tabBarItemWithTitle:@"Components" image:[UIImageMake(@"icon_tabbar_component") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:UIImageMake(@"icon_tabbar_component_selected") tag:1];
//
//    // Lab
//    QDLabViewController *labViewController = [[QDLabViewController alloc] init];
//    labViewController.hidesBottomBarWhenPushed = NO;
//    QDNavigationController *labNavController = [[QDNavigationController alloc] initWithRootViewController:labViewController];
//    labNavController.tabBarItem = [QDUIHelper tabBarItemWithTitle:@"Lab" image:[UIImageMake(@"icon_tabbar_lab") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:UIImageMake(@"icon_tabbar_lab_selected") tag:2];
//
//    // window root controller
//    tabBarViewController.viewControllers = @[uikitNavController, componentNavController, labNavController];
     tabBarViewController.viewControllers = @[uikitNavController];
    self.window.rootViewController = tabBarViewController;
    [self.window makeKeyAndVisible];
}
@end
