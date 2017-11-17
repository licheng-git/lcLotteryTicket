//
//  LotteryHall_CollectionSectionHeaderView.swift
//  LotteryTicket
//
//  Created by 李诚 on 17/10/25.
//  Copyright © 2017年 李诚. All rights reserved.
//

import UIKit
import SnapKit

class LotteryHall_CollectionSectionHeaderView: UICollectionReusableView {
    
    let lbName: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .left
        lb.font = UIFont.systemFont(ofSize: 16)
        return lb
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let imgview = UIImageView()
        imgview.image = UIImage(named: "")
        imgview.backgroundColor = UIColor.red
        self.addSubview(imgview)
        imgview.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20)
        }
        self.addSubview(self.lbName)
        self.lbName.snp.makeConstraints { (make) in
            make.left.equalTo(imgview.snp.right).offset(5)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
