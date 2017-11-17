//
//  bdPrizeResult_TableCell.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/13.
//  Copyright © 2017年 李诚. All rights reserved.
//

class bdPrizeResult_TableCell: UITableViewCell {
    
    static let cHeight: CGFloat = 30
    
    let lbPeriodNum: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 16)
        return lb
    } ()
    
    let lbPrizeNum: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 16)
        lb.textColor = UIColor.red
        return lb
    } ()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        self.addSubview(self.lbPeriodNum)
        self.lbPeriodNum.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.right.equalTo(self.snp.centerX)
        }
        
        self.addSubview(self.lbPrizeNum)
        self.lbPrizeNum.snp.makeConstraints { (make) in
            make.top.bottom.right.equalToSuperview()
            make.left.equalTo(self.snp.centerX)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
