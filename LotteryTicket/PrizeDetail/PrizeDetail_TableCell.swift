//
//  PrizeDetail_TableCell.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/16.
//  Copyright © 2017年 李诚. All rights reserved.
//

fileprivate let lbH:CGFloat = 21

class PrizeDetail_TableCell: UITableViewCell {
    
    var cHeight: CGFloat = 0
    
    let lbPlayType: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 16)
        return lb
    } ()
    
    let lbBettingMode: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 16)
        return lb
    } ()
    
    var arrPrizes = [String]()
    
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        self.backgroundColor = UIColor.white
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    func fConfigCellData(_ pType:String, _ pMode:String, _ pPrizes:[String]) {
        for v in self.subviews {
            v.removeFromSuperview()
        }
        self.backgroundColor = UIColor.white
        
        self.addSubview(self.lbPlayType)
        self.lbPlayType.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(lbH)
            //make.width.equalTo(kSCREEN_WIDTH/3)
            //make.width.equalToSuperview().multipliedBy(0.33)  // == .divideBy(3)
            make.width.equalToSuperview().multipliedBy(0.45)
        }
        self.lbPlayType.text = pType
        self.addSubview(self.lbBettingMode)
        self.lbBettingMode.snp.makeConstraints { (make) in
            make.left.equalTo(self.lbPlayType.snp.right)
            make.centerY.height.equalTo(self.lbPlayType)
            make.width.equalToSuperview().multipliedBy(0.2)
        }
        self.lbBettingMode.text = pMode
        
        var lbY: CGFloat = 5
        for prize in pPrizes {
            //let lb = UILabel()
            //lb.textAlignment = .center
            //lb.font = UIFont.systemFont(ofSize: 16)
            let lb = self.lbPlayType.extCopy_deep() as! UILabel
            self.addSubview(lb)
            lb.snp.makeConstraints({ (make) in
                make.top.equalTo(lbY)
                make.height.equalTo(lbH)
                make.right.equalToSuperview()
                make.width.equalToSuperview().multipliedBy(0.35)
            })
            lb.text = prize
            lbY += lbH
        }
        
        let lineview_h = UIView()
        lineview_h.backgroundColor = UIColor.lightGray
        self.addSubview(lineview_h)
        lineview_h.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        let lineview_v0 = UIView()
        lineview_v0.backgroundColor = UIColor.lightGray
        self.addSubview(lineview_v0)
        lineview_v0.snp.makeConstraints { (make) in
            make.width.equalTo(1)
            make.top.bottom.left.equalToSuperview()
        }
        let lineview_v1 = lineview_v0.extCopy_deep()
        self.addSubview(lineview_v1)
        lineview_v1.snp.makeConstraints { (make) in
            make.width.equalTo(1)
            make.top.bottom.equalToSuperview()
            make.right.equalTo(self.lbPlayType)
        }
        let lineview_v2 = lineview_v0.extCopy_deep()
        self.addSubview(lineview_v2)
        lineview_v2.snp.makeConstraints { (make) in
            make.width.equalTo(1)
            make.top.bottom.equalToSuperview()
            make.right.equalTo(self.lbBettingMode)
        }
        let lineview_v3 = lineview_v0.extCopy_deep()
        self.addSubview(lineview_v3)
        lineview_v3.snp.makeConstraints { (make) in
            make.width.equalTo(1)
            make.top.bottom.right.equalToSuperview()
        }
        
        let num = pPrizes.count > 1 ? pPrizes.count : 1
        self.cHeight = lbH * CGFloat(num) + 10
    }
    
    static func fCaculateHeight(_ pPrizes:[String]) -> CGFloat {
        let num = pPrizes.count > 1 ? pPrizes.count : 1
        return lbH * CGFloat(num) + 10
    }
    
}
