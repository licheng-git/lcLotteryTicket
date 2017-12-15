//
//  AppDelegate.swift
//  LotteryTicket
//
//  Created by 李诚 on 17/10/25.
//  Copyright © 2017年 李诚. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Reachability
import UserNotifications


let kReach = Reachability()!


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
        
//        do {
//            try kReach.startNotifier()
//        }
//        catch {
//            print("网络监测失败")
//        }
        try? kReach.startNotifier()
        
        Login_ViewModel().configOwnerInfo(nil, nil)
        
        if #available(iOS 10.0, *) {
            let unUNC = UNUserNotificationCenter.current()
            unUNC.delegate = self
            let unAuthorizeOptions = UNAuthorizationOptions([.alert, .badge, .sound])
            unUNC.requestAuthorization(options: unAuthorizeOptions, completionHandler: { (flag, error) in
                if flag {
                    print("*_* 消息推送 iOS10 权限 成功")
                }
                else {
                    print("*_* 消息推送 iOS10 权限 失败 \(String(describing: error))")
                }
            })
        }
        else {  // iOS8
            let setting = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(setting)
        }
        UIApplication.shared.registerForRemoteNotifications()
        
        return true
    }
    
    
    // Target -> Capabilities -> PushNotifications + BackgroundModes.RemoteNotifications
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("*_* 消息推送 注册成功 \(deviceToken)")
        // 保存设备令牌deviceToken（————然后在网络请求时放到http请求头中发送到WebApi服务器）
        let dataDeviceToken = NSData.init(data: deviceToken)
        let strDeviceToken = dataDeviceToken.description.replacingOccurrences(of: "<", with: "")
                                                        .replacingOccurrences(of: ">", with: "")
                                                        .replacingOccurrences(of: " ", with: "")
        print("*_* \(dataDeviceToken), \(strDeviceToken)")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("*_* 消息推送 注册失败 \(error)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        print("*_* 消息推送 iOS8 接收 \(application.applicationState), \(userInfo)")
        // .active   前台
        // .inactive 后台（home，锁屏）
        // .background  未启动，推送程序中访问不到
        // （系统默认 前台接收时没有“叮咚”，直接执行代码；后台接收时有“叮咚”，点击推送栏才执行代码）
        if application.applicationState == .active {  // 前台接收
        }
        else {
        }
    }

}


extension AppDelegate: UNUserNotificationCenterDelegate {
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        print("*_* 消息推送 iOS10 前台接收 \(userInfo)")
        completionHandler([.alert, .badge, .sound])
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print("*_* 消息推送 iOS10 后台接收 \(userInfo)")
        completionHandler()
    }
    
}

