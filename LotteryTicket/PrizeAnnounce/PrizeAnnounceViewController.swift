//
//  PrizeAnnounceViewController.swift
//  LotteryTicket
//
//  Created by 李诚 on 17/10/26.
//  Copyright © 2017年 李诚. All rights reserved.
//

import UIKit
import SnapKit

class PrizeAnnounceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let vm = PrizeAnnounce_ViewModel()
    
    lazy var paTableview: UITableView = {
        let tableview = UITableView()
        tableview.backgroundColor = UIColor.white
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(PrizeAnnounce_TableCell.classForCoder(), forCellReuseIdentifier: "CellId")
        tableview.separatorStyle = .none
        return tableview
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "卡司秀彩票"
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(self.paTableview)
        self.paTableview.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kDEFAULT_MARGIN_Y)
            make.bottom.equalToSuperview().offset(-kBOTTOM_HEIGHT)
            make.left.right.equalToSuperview()
        }
        self.vm.getData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.arrModels.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return PrizeAnnounce_TableCell.paHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as! PrizeAnnounce_TableCell
        let model = self.vm.arrModels[indexPath.row]
        cell.imgviewIcon.image = UIImage(named: model.iconImgName!)
        cell.lbName.text = model.name!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //let cell = tableView.cellForRow(at: indexPath)
        let vc = PrizeResultViewController()
        self.tabBarController?.navigationController?.pushViewController(vc, animated: true)
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

}
