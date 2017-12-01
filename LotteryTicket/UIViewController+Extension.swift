//
//  UIViewController+Extension.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/1.
//  Copyright © 2017年 李诚. All rights reserved.
//

import MBProgressHUD

extension UIViewController {
    
    func addDefaultBackNavItem() {
        let navItem_left = UIBarButtonItem()
        navItem_left.style = .plain
        navItem_left.image = UIImage(named: "navItem_back")
        //navItem_left.title = "返回"  // 图片和文字二选一 ，若同时需自定义 UIBarButtonItem(customView: )
        navItem_left.target = self
        navItem_left.action = #selector(navItemClick_Back(_:))
        navItem_left.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = navItem_left
    }
    
    //@objc private func navItemClick_Back(_ sender: UIBarButtonItem) {
    func navItemClick_Back(_ sender: UIBarButtonItem) {  // 可以override
        self.navigationController?.popViewController(animated: true)
        if self.navigationController != nil {
            MBProgressHUD.hide(for: self.navigationController!.view, animated: true)
        }
    }
    
}

