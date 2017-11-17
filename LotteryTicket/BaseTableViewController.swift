//
//  BaseTableViewController.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/3.
//  Copyright © 2017年 李诚. All rights reserved.
//

import UIKit
import SnapKit
//import MJRefresh

class BaseTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    lazy var myTableview: UITableView = {
        //let tableview = UITableView(frame: CGRect.zero, style: .plain)
        let tableview = UITableView()
        tableview.backgroundColor = UIColor.white
        tableview.dataSource = self
        tableview.delegate = self
        //let cellXib = UINib.init(nibName: "myTableCell", bundle: Bundle.main)
        //collectionView.register(cellXib, forCellWithReuseIdentifier: "CellId")
        tableview.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "CellId")    // tableview.register(myTableCell.self, forCellReuseIdentifier: "CellId")
        tableview.separatorStyle = .none
        //tableview.rowHeight = myTableCell.myHeight  // 固定高度，优先级低于代理方法
        return tableview
    } ()
    
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(self.myTableview)
        self.myTableview.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kDEFAULT_MARGIN_Y)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-kBOTTOM_HEIGHT)
        }
        
//        self.myTableview.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
//            self?.currentPage = 0
//            self?.vm.getData((self?.currentPage)!, {(arrModels_page) in
//                self?.myTableview.reloadData()
//                self?.myTableview.mj_header.endRefreshing()
//                self?.myTableview.mj_footer.resetNoMoreData()
//                if arrModels_page.count < 10 {
//                    self?.myTableview.mj_footer.endRefreshingWithNoMoreData()
//                }
//            })
//        })
//        self.myTableview.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { [weak self] in
//            self?.currentPage += 1
//            //print("currentPage = \((self?.currentPage)!)")
//            self?.vm.getData((self?.currentPage)!) { (arrModels_page) in
//                self?.myTableview.reloadData()
//                self?.myTableview.mj_footer.endRefreshing()
//                if arrModels_page.count < 10 {
//                    self?.myTableview.mj_footer.endRefreshingWithNoMoreData()
//                }
//            }
//        })
//        self.myTableview.mj_header.beginRefreshing()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0    // return self.vm.arrModels.count
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 0    // return myTableCell.myHeight
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)    // as! myTableCell
        //if indexPath.row == 0 {
        //    cell.lineView_FristCell_Top.isHidden = false
        //}
        //else {
        //    cell.lineView_FristCell_Top.isHidden = true
        //}
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //let cell = tableView.cellForRow(at: indexPath)
    }
    
}
