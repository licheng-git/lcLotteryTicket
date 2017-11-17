//
//  PrizeAnnounce_TableCell.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/2.
//  Copyright © 2017年 李诚. All rights reserved.
//

import UIKit
import SnapKit

class PrizeAnnounce_TableCell: UITableViewCell {
    
    static let paHeight: CGFloat = 70
    
    let imgviewIcon: UIImageView = {
        let imgview = UIImageView()
        return imgview
    } ()
    
    let lbName: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .left
        lb.font = UIFont.systemFont(ofSize: 16)
        return lb
    } ()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        self.addSubview(self.imgviewIcon)
        self.imgviewIcon.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(40)
        }
        
        self.addSubview(self.lbName)
        self.lbName.snp.makeConstraints { (make) in
            make.left.equalTo(self.imgviewIcon.snp.right).offset(10)
            make.centerY.equalToSuperview()
            make.height.equalTo(21)
            make.right.equalToSuperview().offset(-50)
        }
        
        let imgviewArrow = UIImageView()
        imgviewArrow.image = UIImage(named: "arrow_right")
        self.addSubview(imgviewArrow)
        imgviewArrow.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.width.equalTo(10)
            make.height.equalTo(18)
        }
        
        let lineView_bottom = UIView()
        lineView_bottom.backgroundColor = UIColor.lightGray
        self.addSubview(lineView_bottom)
        lineView_bottom.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-1)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
