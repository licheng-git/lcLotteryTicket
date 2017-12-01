//
//  ShoppingCarHeaderView.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/29.
//  Copyright © 2017年 李诚. All rights reserved.
//

class ShoppingCarHeaderView: UIView {
    
    let lbAccount: UILabel = {
        let lb = UILabel()
        lb.text = "账号：--"
        lb.textAlignment = .left
        lb.font = UIFont.systemFont(ofSize: 16)
        lb.textColor = UIColor.red
        return lb
    } ()
    
    let lbBalance: UILabel = {
        let lb = UILabel()
        lb.text = "余额：--"
        lb.textAlignment = .left
        lb.font = UIFont.systemFont(ofSize: 16)
        lb.textColor = UIColor.red
        return lb
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.addSubview(self.lbAccount)
        self.lbAccount.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalTo(21)
            make.left.equalToSuperview().offset(10)
            make.right.equalTo(self.snp.centerX).offset(-5)
        }
        self.addSubview(self.lbBalance)
        self.lbBalance.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalTo(21)
            make.left.equalTo(self.lbAccount.snp.right).offset(5)
            make.right.equalToSuperview().offset(-10)
        }
        let lineview = UIView()
        lineview.backgroundColor = UIColor.lightGray
        self.addSubview(lineview)
        lineview.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
