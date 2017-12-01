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
            self?.vm.getData(index, nil, { [weak self] (model) in
                self?.bhTableview.reloadData()
            }, nil)
        }
        //self.selectBtnsView.defaultClickedIndex = -1
        self.selectBtnsView.arrData = self.vm.getData_SelectButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.selectBtnsView.arrData == nil {
            if kArrModels_BuyingHall.count == 0 {
                let delegateView = self.tabBarController?.navigationController?.view
                self.vm.getData(0, delegateView, { [weak self] (model) in
                    self?.bhTableview.reloadData()
                    self?.selectBtnsView.arrData = self?.vm.getData_SelectButtons()
                    }, nil)
            }
            else {
                self.bhTableview.reloadData()
                self.selectBtnsView.arrData = self.vm.getData_SelectButtons()
            }
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.model?.arrCellModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return BuyingHall_TableCell.bhHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as! BuyingHall_TableCell
        let model = self.vm.model?.arrCellModel?[indexPath.row]
        if model != nil {
            cell.id = model!.id!
            cell.pid = model!.pid!
            cell.imgviewIcon.image = UIImage(named: model!.iconImgName!)
            cell.lbName.text = model!.name
            cell.lbDescription.text = "--"
            cell.startTimer(model!)
            cell.delegate = self
            //cell.cPrizeDetail = { [weak self] (_ cell: BuyingHall_TableCell) -> () in
            cell.cPrizeDetail = { [weak self] (cell) in
                let vc = PrizeDetailViewController()
                vc.id = cell.id
                vc.pid = cell.pid
                vc.name = cell.lbName.text!
                self?.tabBarController?.navigationController?.pushViewController(vc, animated: true)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! BuyingHall_TableCell
        let vc = BuyingDetailViewController()
        vc.id = cell.id
        vc.pid = cell.pid
        vc.name = cell.lbName.text!
        self.tabBarController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func cleanCellTimer() {
        let count = self.vm.model?.arrCellModel?.count ?? 0
        for i in 0..<count {
            let indexPath = IndexPath(row: i, section: 0)
            let cell = self.bhTableview.cellForRow(at: indexPath) as? BuyingHall_TableCell
            cell?.stopTimer()
            if cell == nil {
                print("*_* !? \(i)")
            }
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

