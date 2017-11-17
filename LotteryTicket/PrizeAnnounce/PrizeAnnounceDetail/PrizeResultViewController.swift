//
//  PrizeResultViewController.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/2.
//  Copyright © 2017年 李诚. All rights reserved.
//

import UIKit
import SnapKit
import MJRefresh

class PrizeResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let vm = PrizeResult_ViewModel()
    var currentPage = 0
    
    lazy var prTableview: UITableView = {
        let tableview = UITableView()
        tableview.backgroundColor = UIColor.white
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(PrizeResult_TableCell.classForCoder(), forCellReuseIdentifier: "CellId")
        tableview.separatorStyle = .none
        tableview.allowsSelection = false
        return tableview
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "开奖结果"
        self.addDefaultBackNavItem()
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(self.prTableview)
        self.prTableview.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kDEFAULT_MARGIN_Y)
            make.bottom.left.right.equalToSuperview()
        }
        
        self.prTableview.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            self?.currentPage = 0
            self?.vm.getData((self?.currentPage)!, {(arrModels_page) in
                self?.prTableview.reloadData()
                self?.prTableview.mj_header.endRefreshing()
                self?.prTableview.mj_footer.resetNoMoreData()
                if arrModels_page.count < 10 {
                    self?.prTableview.mj_footer.endRefreshingWithNoMoreData()
                }
            })
        })
        self.prTableview.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { [weak self] in
            self?.currentPage += 1
            //print("currentPage = \((self?.currentPage)!)")
            self?.vm.getData((self?.currentPage)!) { (arrModels_page) in
                self?.prTableview.reloadData()
                self?.prTableview.mj_footer.endRefreshing()
                if arrModels_page.count < 10 {
                    self?.prTableview.mj_footer.endRefreshingWithNoMoreData()
                }
            }
        })
        self.prTableview.mj_header.beginRefreshing()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.arrModels_all.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return PrizeResult_TableCell.prHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as! PrizeResult_TableCell
        let model = self.vm.arrModels_all[indexPath.row]
        cell.lbTitle.text = model.title
        cell.strResult = model.result
        //cell.fSetResult(model.result!)
        if indexPath.row == 0 {
            cell.lineView_FristCell_Top.isHidden = false
        }
        else {
            cell.lineView_FristCell_Top.isHidden = true
        }
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        //let cell = tableView.cellForRow(at: indexPath)
//    }
    
    deinit {
        print("PrizeResultViewController deinit")
    }
    
}
