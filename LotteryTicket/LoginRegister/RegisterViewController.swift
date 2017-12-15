//
//  RegisterViewController.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/12/12.
//  Copyright © 2017年 李诚. All rights reserved.
//

import UIKit
import MBProgressHUD

class RegisterViewController: UIViewController {
    
    let vm = Register_ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "注册"
        self.view.backgroundColor = UIColor.white
        self.addDefaultBackNavItem()
        self.automaticallyAdjustsScrollViewInsets = false
        let bgView = RegisterView()
        //self.view.addSubview(bgView)  // bgView继承UIScrollView时自动布局有问题
        //bgView.snp.makeConstraints { (make) in
        //    make.top.equalToSuperview().offset(kDEFAULT_MARGIN_Y)
        //    make.left.right.bottom.equalToSuperview()
        //}
        let scrollview = UIScrollView()
        self.view.addSubview(scrollview)
        scrollview.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kDEFAULT_MARGIN_Y)
            make.left.right.bottom.equalToSuperview()
        }
        scrollview.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        self.view.layoutIfNeeded()
        bgView.frame = scrollview.bounds
        //scrollview.contentSize = CGSize(width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT + 100)
        
        bgView.cValidateTap = { [weak self] in
            self?.vm.getData_ValidateImageAndReigsterConfig(self?.navigationController?.view, { (model) in
                //bgView.imgviewValidate.image = model.imgValidate
                //bgView.lbTip_Validate.isHidden = true
                bgView.model = model
                
            }, {
                //bgView.imgviewValidate.image = nil
                //bgView.lbTip_Validate.isHidden = false
                bgView.model = nil
            })
        }
        bgView.cValidateTap!()

        bgView.cRegister = { [weak self] in
            self?.vm.postData_Register(bgView.tfAccount.text!,
                                       bgView.tfPassword.text!,
                                       bgView.tfInvite.text!,
                                       bgView.tfValidate.text!,
                                       self?.navigationController?.view, {
                let hud = MBProgressHUD.showAdded(to: (self?.navigationController?.view)!, animated: true)
                hud.mode = .text
                hud.label.text = "注册成功"
                hud.backgroundView.backgroundColor = UIColor.black
                hud.backgroundView.alpha = 0.5
                hud.hide(animated: true, afterDelay: 1.0)
                hud.completionBlock = {
                    self?.navigationController?.popViewController(animated: true)
                }
            }, { })
        }
        
    }
    
}
