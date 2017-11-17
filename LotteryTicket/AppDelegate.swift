//
//  AppDelegate.swift
//  LotteryTicket
//
//  Created by 李诚 on 17/10/25.
//  Copyright © 2017年 李诚. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()
        
        //self.window?.rootViewController = MainTabbarViewController()
        self.window?.rootViewController = UINavigationController(rootViewController: MainTabbarViewController())
        
        UINavigationBar.appearance().barTintColor = UIColor.red
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
        IQKeyboardManager.sharedManager().enable = true
        
        return true
    }


}

