//
//  AnnounceInforViewController.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/8.
//  Copyright © 2017年 李诚. All rights reserved.
//

import UIKit
import SnapKit
import MJRefresh

class AnnounceInforViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let vm = AnnounceInfor_ViewModel()
    var arrModels_all = [AnnounceInfor_Model]()
    var currentPage = 1
    let pageSize = 10
    
    lazy var myTableview: UITableView = {
        let tableview = UITableView()
        tableview.backgroundColor = kBgColorGray
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "CellId")
        //tableview.separatorStyle = .singleLine
        return tableview
    } ()
    
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
        
        let cGetData = { [weak self] in
            self?.vm.getData((self?.currentPage)!, (self?.pageSize)!, self?.navigationController?.view, { (arrModels_page) in
                self?.currentPage += 1
                self?.arrModels_all.append(contentsOf: arrModels_page)
                self?.myTableview.reloadData()
                self?.myTableview.mj_header.endRefreshing()
                self?.myTableview.mj_footer.endRefreshing()
                self?.myTableview.mj_footer.resetNoMoreData()
                if arrModels_page.count < (self?.pageSize)! {
                    self?.myTableview.mj_footer.endRefreshingWithNoMoreData()
                }
            }, {
                self?.myTableview.mj_header.endRefreshing()
                self?.myTableview.mj_footer.endRefreshing()
            })
        }
        self.myTableview.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            self?.currentPage = 1
            self?.arrModels_all.removeAll()
            cGetData()
        })
        self.myTableview.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { //[weak self] in
            cGetData()
        })
        self.myTableview.mj_header.beginRefreshing()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrModels_all.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)
        cell.textLabel?.text = self.arrModels_all[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = self.arrModels_all[indexPath.row]
        let vc = AnnounceInforDetailsViewController()
        vc.model = model
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
