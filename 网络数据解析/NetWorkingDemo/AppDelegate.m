//
//  AppDelegate.m
//  NetWorkingDemo
//
//  Created by 张敬 on 2020/2/12.
//  Copyright © 2020年 xiuxiu. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self initWindow];
    return YES;
}

//MARK: 初始化 window
-(void)initWindow{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self initUserManager];
    [self.window makeKeyAndVisible];
}

//MARK: 初始化用户系统
- (void)initUserManager{
    /*
     UIViewController *viewController = nil;
     //读UserModel
     UserModel *userModel = [UserModel readUserDefaults];
     DDLog(@"token = %@",userModel.token);
     if (!userModel)
     {
     viewController = [[RegisterViewController alloc] init];
     }
     else
     {
     viewController = [[HomeViewController alloc] init];
     }
     
     UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
     [nav setNavigationBarHidden:YES animated:YES];
     */
    
    
    HomeViewController *vc = [[HomeViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [nav setNavigationBarHidden:YES animated:NO];
    
    // self.window.rootViewController = vc;
    
    self.window.rootViewController = nav;
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


@end
