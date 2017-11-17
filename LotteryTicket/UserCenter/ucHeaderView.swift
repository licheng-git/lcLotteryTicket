//
//  ucHeaderView.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/3.
//  Copyright © 2017年 李诚. All rights reserved.
//

import UIKit
import SnapKit

class ucHeaderView: UIView {
    
    static let ucHeight:CGFloat = 180
    private let amountBgView_H: CGFloat = 60
    
    lazy var imgviewHeader: UIImageView = {
        let imgview = UIImageView()
        imgview.layer.borderColor = UIColor.lightGray.cgColor
        imgview.layer.borderWidth = 1
        return imgview
    } ()
    
    lazy var lbAccount: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 18)
        lb.textColor = UIColor.white
        return lb
    } ()
    
    lazy var lbBalance: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 16)
        lb.textColor = UIColor.darkText
        return lb
    } ()
    
    lazy var lbTodayProfit: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 16)
        lb.textColor = UIColor.darkText
        return lb
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.lightGray
        
        let headerBgView = UIView()
        headerBgView.backgroundColor = UIColor.red
        self.addSubview(headerBgView)
        headerBgView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(1)
            make.left.right.equalToSuperview()
            make.height.equalTo(ucHeaderView.ucHeight - self.amountBgView_H)
        }
        
        let imgviewHeader_WH: CGFloat = 60
        headerBgView.addSubview(self.imgviewHeader)
        self.imgviewHeader.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.width.height.equalTo(imgviewHeader_WH)
        }
        self.imgviewHeader.layer.cornerRadius = imgviewHeader_WH/2
        self.imgviewHeader.clipsToBounds = true
        
        let accountBgView = UIView()
        accountBgView.backgroundColor = UIColor.clear
        headerBgView.addSubview(accountBgView)
        accountBgView.snp.makeConstraints { (make) in
            make.top.equalTo(self.imgviewHeader.snp.bottom)
            make.bottom.left.right.equalToSuperview()
        }
        accountBgView.addSubview(self.lbAccount)
        self.lbAccount.snp.makeConstraints { (make) in
            make.centerY.left.right.equalToSuperview()
            make.height.equalTo(21)
        }
        
        let amountBgView = UIView()
        amountBgView.backgroundColor = UIColor.white
        self.addSubview(amountBgView)
        amountBgView.snp.makeConstraints { (make) in
            make.top.equalTo(headerBgView.snp.bottom).offset(1)
            make.bottom.equalToSuperview().offset(-1)
            make.left.right.equalToSuperview()
        }
        
        amountBgView.addSubview(self.lbBalance)
        self.lbBalance.snp.makeConstraints { (make) in
            make.bottom.equalTo(amountBgView.snp.centerY)
            make.left.equalToSuperview()
            make.right.equalTo(amountBgView.snp.centerX)
            make.height.equalTo(21)
        }
        let lbBalanceDesc = UILabel()
        lbBalanceDesc.text = "可用余额"
        lbBalanceDesc.textAlignment = .center
        lbBalanceDesc.font = UIFont.systemFont(ofSize: 16)
        lbBalanceDesc.textColor = UIColor.gray
        amountBgView.addSubview(lbBalanceDesc)
        lbBalanceDesc.snp.makeConstraints { (make) in
            make.top.equalTo(self.lbBalance.snp.bottom)
            make.height.left.right.equalTo(self.lbBalance)
        }
        
        amountBgView.addSubview(self.lbTodayProfit)
        self.lbTodayProfit.snp.makeConstraints { (make) in
            make.bottom.equalTo(amountBgView.snp.centerY)
            make.left.equalTo(amountBgView.snp.centerX)
            make.right.equalToSuperview()
            make.height.equalTo(21)
        }
        let lbTodayProfitDesc = UILabel()
        lbTodayProfitDesc.text = "今日输赢"
        lbTodayProfitDesc.textAlignment = .center
        lbTodayProfitDesc.font = UIFont.systemFont(ofSize: 16)
        lbTodayProfitDesc.textColor = UIColor.gray
        amountBgView.addSubview(lbTodayProfitDesc)
        lbTodayProfitDesc.snp.makeConstraints { (make) in
            make.top.equalTo(self.lbTodayProfit.snp.bottom)
            make.height.left.right.equalTo(self.lbTodayProfit)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
