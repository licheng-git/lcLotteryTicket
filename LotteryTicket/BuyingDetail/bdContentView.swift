//
//  bdContentView.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/14.
//  Copyright © 2017年 李诚. All rights reserved.
//

class bdContentView: UIView {
    
    let topView: bdContentTopView = {
        let view = bdContentTopView()
        return view
    } ()
    
    let tableView: bdContentTableView = {
        let view = bdContentTableView()
        return view
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        self.addSubview(self.topView)
        self.topView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.left.right.equalToSuperview()
            make.height.equalTo(60)
        }
        self.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.topView.snp.bottom).offset(5)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
