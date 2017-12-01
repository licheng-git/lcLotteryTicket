//
//  PrizeDetailViewController.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/14.
//  Copyright © 2017年 李诚. All rights reserved.
//

class PrizeDetailViewController: UIViewController {
    
    var id = String()
    var pid = String()
    var name = String()
    
    let vm = PrizeDetail_ViewModel()
    
    let contentView: PrizeDetailTableView = {
        //let view = PrizeDetailTableView()
        let view = PrizeDetailTableView(frame: .zero, style: .grouped)
        return view
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.name + "奖金详情"
        self.view.backgroundColor = UIColor.white
        self.addDefaultBackNavItem()
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.view.addSubview(self.contentView)
        self.contentView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kDEFAULT_MARGIN_Y+10)
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-5)
        }
        self.vm.getData(self.pid, self.navigationController?.view) { [weak self] (arrModels) in
            self?.contentView.arrModel = arrModels
            self?.contentView.reloadData()
        }
        
    }
    
    deinit {
        print("PrizeDetailViewController deinit")
    }
    
}
