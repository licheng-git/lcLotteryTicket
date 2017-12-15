//
//  LoginViewController.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/12/11.
//  Copyright © 2017年 李诚. All rights reserved.
//

import UIKit
import MBProgressHUD

class LoginViewController: UIViewController {
    
    let vm = Login_ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登录"
        self.view.backgroundColor = UIColor.white
        self.addDefaultBackNavItem()
        
        let navItem_right = UIBarButtonItem()
        navItem_right.style = .plain
        navItem_right.title = "注册"
        navItem_right.target = self
        navItem_right.action = #selector(navItemClick_Right(_:))
        navItem_right.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = navItem_right
        
        let bgView = LoginView()
        self.view.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kDEFAULT_MARGIN_Y)
            make.left.right.bottom.equalToSuperview()
        }
        
        let cSuccess_ConfigOwnerInfo:()->Void = { [weak self] in
            self?.vm.getData_ValidateImage(self?.navigationController?.view, { (img) in
                bgView.imgviewValidate.image = img
                bgView.lbTip_Validate.isHidden = true
            }, {
                bgView.imgviewValidate.image = nil
                bgView.lbTip_Validate.isHidden = false
            })
        }
        bgView.cValidateTap = { [weak self] in
            self?.vm.configOwnerInfo(self?.navigationController?.view, cSuccess_ConfigOwnerInfo)
        }
        bgView.cValidateTap!()
        
        bgView.cLogin = { [weak self] in
            self?.vm.postData_Login(bgView.tfAccount.text!, bgView.tfPassword.text!, bgView.tfValidate.text!, self?.navigationController?.view, {
                let hud = MBProgressHUD.showAdded(to: (self?.navigationController?.view)!, animated: true)
                hud.mode = .text
                hud.label.text = "登录成功"
                hud.backgroundView.backgroundColor = UIColor.black
                hud.backgroundView.alpha = 0.5
                hud.hide(animated: true, afterDelay: 1.0)
                hud.completionBlock = {
                    self?.navigationController?.popViewController(animated: true)
                }
            }, { })
        }
        
        bgView.tfAccount.text = "youyou88"
        bgView.tfPassword.text = "123456"
    }
    
    @objc private func navItemClick_Right(_ sender: UIBarButtonItem) {
        let vc = RegisterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

