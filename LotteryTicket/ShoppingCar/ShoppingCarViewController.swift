//
//  ShoppingCarViewController.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/28.
//  Copyright © 2017年 李诚. All rights reserved.
//

import UIKit

class ShoppingCarViewController: UIViewController {
    
    let vm = ShoppingCar_ViewModel()
    
    let headerView = ShoppingCarHeaderView()
    let scTableView = ShoppingCarTableView()
    let bottomView = ShoppingCarBottomView()
    
    lazy var alertC_clear: UIAlertController = {
        let alertC = UIAlertController(title: "温馨提示", message: "您确定要清空购物车吗？", preferredStyle: .alert)
        let actionConfirm = UIAlertAction(title: "确定", style: .default, handler: { (action) in
            self.clearAndPop()
        })
        alertC.addAction(actionConfirm)
        let actionCancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertC.addAction(actionCancel)
        return alertC
    } ()
    
    lazy var alertC_BettingSuccess: UIAlertController = {
        let alertC = UIAlertController(title: "温馨提示", message: "下注成功", preferredStyle: .alert)
        let actionConfirm = UIAlertAction(title: "确定", style: .default, handler: { (action) in
            self.clearAndPop()
        })
        alertC.addAction(actionConfirm)
        return alertC
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "购物车"
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        self.addDefaultBackNavItem()
        
        let navItem_right = UIBarButtonItem()
        navItem_right.style = .plain
        navItem_right.title = "清空"
        navItem_right.target = self
        navItem_right.action = #selector(navItemClick_Right(_:))
        navItem_right.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = navItem_right
        
        self.view.addSubview(self.headerView)
        self.headerView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kDEFAULT_MARGIN_Y)
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        self.view.addSubview(self.bottomView)
        self.bottomView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        self.view.addSubview(self.scTableView)
        self.scTableView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.headerView.snp.bottom)
            make.bottom.equalTo(self.bottomView.snp.top)
        }
        
        self.scTableView.arrModel = self.vm.arrModel
        self.setBottomTotal()
        self.scTableView.cTableCell_Delete = { [weak self] (arrModel) in
            self?.vm.arrModel = arrModel
            self?.setBottomTotal()
        }
        
        self.bottomView.cBtnAction_Betting = { [weak self] in
            self?.present((self?.alertC_BettingSuccess)!, animated: true, completion: nil)
        }
    }
    
    @objc private func navItemClick_Right(_ sender: UIBarButtonItem) {
        self.present(self.alertC_clear, animated: true, completion: nil)
    }
    
    override func navItemClick_Back(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        let preVC_bdVC = self.navigationController?.viewControllers.last as! BuyingDetailViewController
        //self.vm.arrModel = self.scTableView.arrModel
        preVC_bdVC.vm.arrModel_ShoppingCar = self.scTableView.arrModel
    }
    
    private func clearAndPop() {
        //self.vm.arrModel.removeAll()
        //self.setBottomTotal()
        //self.scTableView.arrModel.removeAll()
        //self.scTableView.reloadData()
        self.navigationController?.popViewController(animated: true)
        let preVC_bdVC = self.navigationController?.viewControllers.last as! BuyingDetailViewController
        preVC_bdVC.vm.arrModel_ShoppingCar.removeAll()
    }
    
    private func setBottomTotal() {
        var numbers: Int = 0
        var amount: Float = 0
        for model in self.vm.arrModel {
            numbers += model.bettingNumber ?? 0
            amount += model.bettingAmount ?? 0
        }
        self.bottomView.fSetTotal(numbers, amount)
    }
    
}

