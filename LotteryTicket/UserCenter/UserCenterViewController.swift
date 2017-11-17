//
//  UserCenterViewController.swift
//  LotteryTicket
//
//  Created by 李诚 on 17/10/26.
//  Copyright © 2017年 李诚. All rights reserved.
//

import UIKit

class UserCenterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let vm = UserCenter_ViewModel()
    
    lazy var headerView: ucHeaderView = {
        let view = ucHeaderView()
        return view
    } ()
    
    lazy var ucTableview: UITableView = {
        let tableview = UITableView()
        tableview.backgroundColor = kBgColorGray
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(UserCenter_TableCell.classForCoder(), forCellReuseIdentifier: "CellId")
        //tableview.separatorStyle = .singleLine
        return tableview
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "卡司秀彩票"
        self.view.backgroundColor = kBgColorGray
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(self.headerView)
        self.headerView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kDEFAULT_MARGIN_Y)
            make.left.right.equalToSuperview()
            make.height.equalTo(ucHeaderView.ucHeight)
        }
        self.view.addSubview(self.ucTableview)
        self.ucTableview.snp.makeConstraints { (make) in
            make.top.equalTo(self.headerView.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-kBOTTOM_HEIGHT)
        }
        
        self.vm.getCellData()
        self.vm.getHeaderData() { [weak self] (model) in
            self?.headerView.imgviewHeader.image = UIImage(named: model.headerImgName!)
            self?.headerView.lbAccount.text = model.account
            self?.headerView.lbBalance.text = model.balance
            self?.headerView.lbTodayProfit.text = model.todayProfit
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let allCellsHeight = UserCenter_TableCell.ucHeight * CGFloat(self.vm.arrCellModel.count)
        let screenLeftHeight = kSCREEN_HEIGHT - self.ucTableview.frame.minY - kBOTTOM_HEIGHT
        if allCellsHeight < screenLeftHeight {
            self.ucTableview.isScrollEnabled = false
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.arrCellModel.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UserCenter_TableCell.ucHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as! UserCenter_TableCell
        let cm = self.vm.arrCellModel[indexPath.row]
        cell.imgviewIcon.image = UIImage(named: cm.iconImgName!)
        cell.lbText.text = cm.text
        return cell
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)
//        let cm = self.vm.arrCellModel[indexPath.row]
//        cell.imageView?.image = UIImage(named: cm.iconImgName!)  // 只能是图片本身大小
//        cell.textLabel?.text = cm.text
//        cell.accessoryType = .disclosureIndicator
//        cell.layer.borderColor = UIColor.lightGray.cgColor
//        cell.layer.borderWidth = 0.5
//        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //let cell = tableView.cellForRow(at: indexPath)
        var vc: UIViewController?
        if indexPath.row == 0 {
            vc = AnnounceInforViewController()
        }
        else if indexPath.row == 1 {
            vc = BettingRecordsViewController()
        }
        else if indexPath.row == 2 {
            vc = DealRecordsViewController()
        }
        else {
            return
        }
        self.tabBarController?.navigationController?.pushViewController(vc!, animated: true)
    }
    
    // tableview 上边框线
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }
    // tableview 下边框线  (底部数据不会动态增加时可以这样搞)
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }
    
}
