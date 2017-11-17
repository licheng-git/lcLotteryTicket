//
//  PrizeDetail_SectionHeaderView.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/17.
//  Copyright © 2017年 李诚. All rights reserved.
//

class PrizeDetail_SectionHeaderView: UIView {
    
    let lbGroupTitle: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .left
        lb.font = UIFont.boldSystemFont(ofSize: 18)
        return lb
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        self.addSubview(lbGroupTitle)
        self.lbGroupTitle.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(21)
        }
        
        let lbSubTitle0 = UILabel()
        lbSubTitle0.text = "玩法"
        lbSubTitle0.backgroundColor = kBgColorGray
        lbSubTitle0.textAlignment = .center
        lbSubTitle0.font = UIFont.systemFont(ofSize: 15)
        lbSubTitle0.textColor = UIColor.darkGray
        self.addSubview(lbSubTitle0)
        lbSubTitle0.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalToSuperview().multipliedBy(0.45)
        }
        
        let lbSubTitle1 = lbSubTitle0.extCopy_deep() as! UILabel
        lbSubTitle1.text = "投注模式"
        lbSubTitle1.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbSubTitle1)
        lbSubTitle1.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(lbSubTitle0)
            make.left.equalTo(lbSubTitle0.snp.right)
            make.width.equalToSuperview().multipliedBy(0.2)
        }
        
        let lbSubTitle2 = lbSubTitle0.extCopy_deep() as! UILabel
        lbSubTitle2.text = "奖金"
        self.addSubview(lbSubTitle2)
        lbSubTitle2.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(lbSubTitle0)
            make.right.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.35)
        }
        
        let lineview_h0 = UIView()
        lineview_h0.backgroundColor = UIColor.lightGray
        self.addSubview(lineview_h0)
        lineview_h0.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.left.right.bottom.equalToSuperview()
        }
        let lineview_h1 = lineview_h0.extCopy_deep()
        self.addSubview(lineview_h1)
        lineview_h1.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.left.right.equalToSuperview()
            make.top.equalTo(lbSubTitle0)
        }
        let lineview_v0 = lineview_h0.extCopy_deep()
        self.addSubview(lineview_v0)
        lineview_v0.snp.makeConstraints { (make) in
            make.width.equalTo(1)
            make.top.bottom.equalTo(lbSubTitle0)
            make.left.equalToSuperview()
        }
        let lineview_v1 = lineview_h0.extCopy_deep()
        self.addSubview(lineview_v1)
        lineview_v1.snp.makeConstraints { (make) in
            make.width.equalTo(1)
            make.top.bottom.equalTo(lbSubTitle0)
            make.right.equalTo(lbSubTitle0)
        }
        let lineview_v2 = lineview_h0.extCopy_deep()
        self.addSubview(lineview_v2)
        lineview_v2.snp.makeConstraints { (make) in
            make.width.equalTo(1)
            make.top.bottom.equalTo(lbSubTitle0)
            make.right.equalTo(lbSubTitle1)
        }
        let lineview_v3 = lineview_h0.extCopy_deep()
        self.addSubview(lineview_v3)
        lineview_v3.snp.makeConstraints { (make) in
            make.width.equalTo(1)
            make.top.bottom.equalTo(lbSubTitle0)
            make.right.equalToSuperview()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
