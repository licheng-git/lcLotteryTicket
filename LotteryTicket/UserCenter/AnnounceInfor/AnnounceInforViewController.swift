//
//  AnnounceInforViewController.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/8.
//  Copyright © 2017年 李诚. All rights reserved.
//

import UIKit
import SnapKit

class AnnounceInforViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    lazy var myTableview: UITableView = {
        let tableview = UITableView()
        tableview.backgroundColor = kBgColorGray
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "CellId")
        //tableview.separatorStyle = .singleLine
        return tableview
    } ()
    
    var arrData = [ "卡司*秀[CS]官方彩票建议反馈邮箱开通公告",
                    "title",
                    "很长的标题 哈哈哈哈嘿嘿嘿嘿吼吼吼吼嘎嘎嘎嘎卡卡卡卡滋滋滋滋滋嘣" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "公告列表"
        self.addDefaultBackNavItem()
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(self.myTableview)
        self.myTableview.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kDEFAULT_MARGIN_Y)
            make.bottom.left.right.equalToSuperview()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)
        cell.textLabel?.text = self.arrData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //let cell = tableView.cellForRow(at: indexPath)
    }
    
}
