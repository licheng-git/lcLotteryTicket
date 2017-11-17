//
//  BuyingHallViewController.swift
//  LotteryTicket
//
//  Created by 李诚 on 17/10/26.
//  Copyright © 2017年 李诚. All rights reserved.
//

import UIKit

class BuyingHallViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let vm = BuyingHall_ViewModel()
    
    lazy var selectBtnsView: SelectButtonsView = {
        let view = SelectButtonsView()
        return view
    } ()
    
    lazy var bhTableview: UITableView = {
        //let tableview = UITableView(frame: CGRect.zero, style: .plain)
        let tableview = UITableView()
        tableview.backgroundColor = UIColor.white
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(BuyingHall_TableCell.classForCoder(), forCellReuseIdentifier: "CellId")
        tableview.separatorStyle = .none
        return tableview
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "卡司秀彩票"
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(self.selectBtnsView)
        self.selectBtnsView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kDEFAULT_MARGIN_Y)
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        self.view.addSubview(self.bhTableview)
        self.bhTableview.snp.makeConstraints { (make) in
            make.top.equalTo(self.selectBtnsView.snp.bottom)
            make.bottom.equalToSuperview().offset(-kBOTTOM_HEIGHT)
            make.left.right.equalToSuperview()
        }
        
        self.selectBtnsView.cBtnClick = { [weak self] (index) in
            self?.cleanCellTimer()
            self?.vm.getData(index) { [weak self] (arrModels) in
                self?.bhTableview.reloadData()
            }
        }
        //self.selectBtnsView.defaultClickedIndex = -1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.arrModels.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return BuyingHall_TableCell.bhHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as! BuyingHall_TableCell
        let model = self.vm.arrModels[indexPath.row]
        cell.imgviewIcon.image = UIImage(named: model.iconImgName!)
        cell.lbName.text = model.name!
        cell.lbDescription.text = model.desc!
        cell.startTimer(model)
        cell.delegate = self
        //cell.cPrizeDetail = { [weak self] (_ cell: BuyingHall_TableCell) -> () in
        cell.cPrizeDetail = { [weak self] (cell) in
            let vc = PrizeDetailViewController()
            vc.name = model.name!
            self?.tabBarController?.navigationController?.pushViewController(vc, animated: true)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! BuyingHall_TableCell
        let vc = BuyingDetailViewController()
        vc.detailId = cell.lbName.text!
        self.tabBarController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func cleanCellTimer() {
        //self.vm.arrModels.removeAll()
        //self.bhTableview.reloadData()
        for i in 0..<self.vm.arrModels.count {
            let indexPath = IndexPath(row: i, section: 0)
            let cell = self.bhTableview.cellForRow(at: indexPath) as! BuyingHall_TableCell
            cell.stopTimer()
        }
    }
    
    deinit {
        print("BuyingHallViewController deinit")
    }
}


extension BuyingHallViewController: BuyingHall_TableCell_Delegate {
    func dNumberTrend(_ cell: BuyingHall_TableCell) {
        let vc = WebViewController()
        vc.title = cell.lbName.text! + "走势图"
        vc.url_str = "http://magent.serverddc.com/"
        self.tabBarController?.navigationController?.pushViewController(vc, animated: true)
    }
}

