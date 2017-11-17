//
//  DealRecords_TableCell.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/9.
//  Copyright © 2017年 李诚. All rights reserved.
//

import UIKit
import SnapKit

class DealRecords_TableCell: UITableViewCell {
    
    static let drHeight: CGFloat = 60
    
    let lbTitle: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .left
        lb.font = UIFont.systemFont(ofSize: 16)
        return lb
    } ()
    
    let lbTime: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .left
        lb.font = UIFont.systemFont(ofSize: 14)
        lb.textColor = UIColor.gray
        return lb
    } ()
    
    let lbAmount: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .right
        lb.font = UIFont.systemFont(ofSize: 16)
        return lb
    } ()
    
    let lineView_FristCell_Top: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.lightGray
        lineView.isHidden = true
        return lineView
    } ()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.addSubview(self.lbTitle)
        self.lbTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(21)
            make.width.equalTo(200)
        }
        self.addSubview(self.lbTime)
        self.lbTime.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.lbTitle)
            make.height.equalTo(21)
            make.bottom.equalToSuperview().offset(-10)
        }
        self.addSubview(self.lbAmount)
        self.lbAmount.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(21)
            make.width.equalTo(100)
        }
        let lineView_bottom = UIView()
        lineView_bottom.backgroundColor = UIColor.lightGray
        self.addSubview(lineView_bottom)
        lineView_bottom.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-1)
        }
        self.addSubview(self.lineView_FristCell_Top)
        self.lineView_FristCell_Top.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(1)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
