//
//  UserCenter_TableCell.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/3.
//  Copyright © 2017年 李诚. All rights reserved.
//

import UIKit
import SnapKit

class UserCenter_TableCell: UITableViewCell {
    
    static let ucHeight: CGFloat = 50
    
    let imgviewIcon: UIImageView = {
        let imgview = UIImageView()
        return imgview
    } ()
    
    let lbText: UILabel = {
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
            make.width.height.equalTo(20)
        }
        
        self.addSubview(self.lbText)
        self.lbText.snp.makeConstraints { (make) in
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

