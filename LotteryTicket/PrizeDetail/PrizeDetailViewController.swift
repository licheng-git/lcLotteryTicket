//
//  PrizeDetailViewController.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/14.
//  Copyright © 2017年 李诚. All rights reserved.
//

class PrizeDetailViewController: UIViewController {
    
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
        self.vm.getData { [weak self] (arrModel) in
            self?.contentView.arrModel = arrModel
            self?.contentView.reloadData()
        }
        
    }
    
}
