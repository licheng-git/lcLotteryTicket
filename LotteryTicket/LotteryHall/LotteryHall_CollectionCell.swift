//
//  LotteryHall_CollectionViewCell.swift
//  LotteryTicket
//
//  Created by 李诚 on 17/10/25.
//  Copyright © 2017年 李诚. All rights reserved.
//

import UIKit
import SnapKit

class LotteryHall_CollectionCell: UICollectionViewCell {
    
    let imgviewIcon: UIImageView = {
        let imgview = UIImageView()
        return imgview
    } ()
    
    let lbName: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 14)
        return lb
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        self.addSubview(self.imgviewIcon)
        self.addSubview(self.lbName)
        self.imgviewIcon.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.width.height.equalTo(48)
        }
        self.lbName.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(21)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
