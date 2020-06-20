//
//  AppDelegate.m
//  Learning-OpenGLES
//
//  Created by 贾辰 on 2020/6/20.
//  Copyright © 2020 JJC. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    ViewController *rootVC = [[ViewController alloc]init];
//    //初始化导航控制器的时候把上面创建的root1初始化给它
//    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:rootVC];
//    //最后，我们把window的根视图控制器设为导航控制器，这样导航控制器就能够显示在屏幕上
//    
//    self.window = [[UIWindow alloc] init];
//    [self.window makeKeyWindow];
//    [self.window setFrame:[[UIScreen mainScreen] bounds]];
//    self.window.rootViewController = navigationController;
//    // Override point for customization after application launch.
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
