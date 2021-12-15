//
//  AppDelegate.swift
//  Music
//
//  Created by Rzk on 2020/11/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // 数据库初始化
        debugPrint("---- dbPath:\(dbPath)")
        PlaylistDao.creatTable()
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        self.window?.rootViewController = BaseTabBarViewController()
        window?.makeKeyAndVisible()
        
        return true
    }


}

