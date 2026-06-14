//
//  AppDelegate.swift
//  DeepAdxSwift
//
//  Created by ext.jiangyelin1 on 2023/8/2.
//

import UIKit

import DeepAdxCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.settingDeepAdx()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    // 2.初始化SDK
    func settingDeepAdx() {

        DeepAdxSdkConfig.shareInstance().level = .debug;
        let model = DeepAdxConfigModel();
        model.debugMode = false;
        // [国内] a06460e31fce62fa
        // [海外] e3aa00b33d0927ec
        DeepAdxSdkConfig.shareInstance().registerAppID("a06460e31fce62fa", withConfig: model)

    }


}

