//
//  DealRecordsViewController.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/8.
//  Copyright © 2017年 李诚. All rights reserved.
//

import UIKit
import SnapKit

class DealRecordsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let vm = DealRecords_ViewModel()
    
    lazy var myTableview: UITableView = {
        let tableview = UITableView()
        tableview.backgroundColor = UIColor.white
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(DealRecords_TableCell.classForCoder(), forCellReuseIdentifier: "CellId")
        tableview.separatorStyle = .none
        tableview.allowsSelection = false
        return tableview
    } ()
    
    lazy var alertC: UIAlertController = {
        let alertC = UIAlertController(title: "选择日期", message: nil, preferredStyle: .actionSheet)
        let actionCancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertC.addAction(actionCancel)
        let actionToday = UIAlertAction(title: "今天", style: .default, handler: { (action) in
            self.fAlertAction(action.title!, 0)
        })
        alertC.addAction(actionToday)
        let actionYesterday = UIAlertAction(title: "昨天", style: .default, handler: { (action) in
            self.fAlertAction(action.title!, 0)
        })
        alertC.addAction(actionYesterday)
        let actionWeek = UIAlertAction(title: "7天", style: .default, handler: { (action) in
            self.fAlertAction(action.title!, 0)
        })
        alertC.addAction(actionWeek)
        return alertC
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "交易记录"
        self.addDefaultBackNavItem()
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(self.myTableview)
        self.myTableview.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kDEFAULT_MARGIN_Y)
            make.bottom.left.right.equalToSuperview()
        }
        
        let navItem_right = UIBarButtonItem()
        navItem_right.style = .plain
        navItem_right.title = "今天"
        navItem_right.target = self
        navItem_right.action = #selector(self.navItemClick_Right(_:))
        navItem_right.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = navItem_right
        
        self.vm.getData(0, 0) { [weak self] (arrModels) in
            self?.myTableview.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.arrModel.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return DealRecords_TableCell.drHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as! DealRecords_TableCell
        let model = self.vm.arrModel[indexPath.row]
        cell.lbTitle.text = model.title
        cell.lbTime.text = model.time
        cell.lbAmount.text = model.amount
        if indexPath.row == 0 {
            cell.lineView_FristCell_Top.isHidden = false
        }
        else {
            cell.lineView_FristCell_Top.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //let cell = tableView.cellForRow(at: indexPath)
    }
    
    func navItemClick_Right(_ barBtnItem:UIBarButtonItem) {
        self.present(self.alertC, animated: true, completion: nil)
    }
    
    @objc private func fAlertAction(_ title: String, _ selectType: Int) {
        self.navigationItem.rightBarButtonItem?.title = title
        self.vm.getData(selectType, 0) { [weak self] (arrModels) in
            self?.myTableview.reloadData()
        }
    }
    
}
