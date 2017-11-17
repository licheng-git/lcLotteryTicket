//
//  MainTabbarViewController.swift
//  LotteryTicket
//
//  Created by 李诚 on 17/10/25.
//  Copyright © 2017年 李诚. All rights reserved.
//

import UIKit

class MainTabbarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabbarItem0 = UITabBarItem(title: "投注大厅", image: UIImage(named: "index_icon_tab0_off")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "index_icon_tab0_on")?.withRenderingMode(.alwaysOriginal))
        tabbarItem0.titlePositionAdjustment = UIOffset.init(horizontal: 0, vertical: -4)
        let tabbarItem1 = UITabBarItem(title: "购彩大厅", image: UIImage(named: "index_icon_tab1_off")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "index_icon_tab1_on")?.withRenderingMode(.alwaysOriginal))
        tabbarItem1.titlePositionAdjustment = UIOffset.init(horizontal: 0, vertical: -4)
        let tabbarItem2 = UITabBarItem(title: "开奖公告", image: UIImage(named: "index_icon_tab2_off"), selectedImage: UIImage(named: "index_icon_tab2_on"))
        let tabbarItem3 = UITabBarItem(title: "用户中心", image: nil, tag: 0)
        
        let vc0 = LotteryHallViewController()
        let vc1 = BuyingHallViewController()
        let vc2 = PrizeAnnounceViewController()
        let vc3 = UserCenterViewController()
        let navC0 = UINavigationController(rootViewController: vc0)
        let navC1 = UINavigationController(rootViewController: vc1)
        let navC2 = UINavigationController(rootViewController: vc2)
        let navC3 = UINavigationController(rootViewController: vc3)
        navC0.tabBarItem = tabbarItem0
        navC1.tabBarItem = tabbarItem1
        navC2.tabBarItem = tabbarItem2
        navC3.tabBarItem = tabbarItem3
        self.viewControllers = [navC0, navC1, navC2, navC3]
        
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if tabBarController.selectedIndex == 3 {
            print("登陆状态检测")
        }
    }

}
