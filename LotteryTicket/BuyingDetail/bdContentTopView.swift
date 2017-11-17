//
//  bdContentTopView.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/15.
//  Copyright © 2017年 李诚. All rights reserved.
//

class bdContentTopView: UIView {
    
    private enum BtnTag : Int {
        case PlayRule = 100
        case PrizeExample
        case PrizeDetail
        case BettingRecord
    }
    
    lazy var btnPlayRule: UIButton = {
        let btn = UIButton()
        btn.setTitle("玩法规则", for: .normal)
        btn.setTitleColor(UIColor.red, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        btn.tag = BtnTag.PlayRule.rawValue
//        btn.setImage(UIImage(named: "bgRound"), for: .normal)
//        // *_*  frame方式 + 调整之前本身btn宽度足够
//        //let btnImgSize = (btn.imageView?.frame.size)!
//        //let btnLbSize = (btn.titleLabel?.frame.size)!
//        //btn.titleEdgeInsets =  UIEdgeInsets(top: 0, left: -btnImgSize.width, bottom: -btnImgSize.height-5, right: 0)
//        //btn.imageEdgeInsets = UIEdgeInsetsMake(-btnLbSize.height-5, 0, 0, -btnLbSize.width)
        btn.contentVerticalAlignment = .bottom
        let imgview = UIImageView()
        imgview.image = UIImage(named: "bgRound")
        btn.addSubview(imgview)
        imgview.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-25)
            make.width.height.equalTo(30)
        })
        return btn
    } ()
    
    lazy var btnPrizeExample: UIButton = {
        let btn = UIButton()
        btn.setTitle("中奖举例", for: .normal)
        btn.setTitleColor(UIColor.red, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        btn.tag = BtnTag.PrizeExample.rawValue
        btn.contentVerticalAlignment = .bottom
        let imgview = UIImageView()
        imgview.image = UIImage(named: "icon_3d")
        btn.addSubview(imgview)
        imgview.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-25)
            make.width.height.equalTo(30)
        })
        return btn
    } ()
    
    lazy var btnPrizeDetail: UIButton = {
        let btn = UIButton()
        btn.setTitle("彩金详情", for: .normal)
        btn.setTitleColor(UIColor.red, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        btn.tag = BtnTag.PrizeDetail.rawValue
        btn.contentVerticalAlignment = .bottom
        let imgview = UIImageView()
        imgview.image = UIImage(named: "bgRound")
        btn.addSubview(imgview)
        imgview.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-25)
            make.width.height.equalTo(30)
        })
        return btn
    } ()
    
    lazy var tapviewBettingRecord: UIView = {
        let view = UIView()
        let lb = UILabel()
        lb.text = "投注记录"
        lb.textColor = UIColor.red
        lb.font = UIFont.systemFont(ofSize: 14)
        lb.textAlignment = .center
        view.addSubview(lb)
        lb.snp.makeConstraints({ (make) in
            make.bottom.equalToSuperview().offset(-4.5)
            make.height.equalTo(21)
            make.left.right.equalToSuperview()
        })
        let imgview = UIImageView()
        imgview.image = UIImage(named: "bgRound")
        view.addSubview(imgview)
        imgview.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-25)
            make.width.height.equalTo(30)
        })
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction_BettingRecord(_:)))
        view.addGestureRecognizer(tapGesture)
        return view
    } ()
    
    var cClick: ((_ atIndex:Int)->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        self.addSubview(self.btnPlayRule)
        self.btnPlayRule.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(5)
            make.width.equalTo(kSCREEN_WIDTH/4)
        }
        self.addSubview(self.btnPrizeExample)
        self.btnPrizeExample.snp.makeConstraints { (make) in
            make.top.bottom.width.equalTo(self.btnPlayRule)
            make.left.equalTo(self.btnPlayRule.snp.right)
        }
        self.addSubview(self.btnPrizeDetail)
        self.btnPrizeDetail.snp.makeConstraints { (make) in
            make.top.bottom.width.equalTo(self.btnPlayRule)
            make.left.equalTo(self.btnPrizeExample.snp.right)
        }
        self.addSubview(self.tapviewBettingRecord)
        self.tapviewBettingRecord.snp.makeConstraints { (make) in
            make.top.bottom.width.equalTo(self.btnPlayRule)
            make.right.equalToSuperview()
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
    
    @objc private func btnAction(_ sender: UIButton) {
        var index = 0
        if sender.tag == BtnTag.PlayRule.rawValue {
            index = 0
        }
        else if sender.tag == BtnTag.PrizeExample.rawValue {
            index = 1
        }
        else if sender.tag == BtnTag.PrizeDetail.rawValue {
            index = 2
        }
        if self.cClick != nil {
            self.cClick!(index)
        }
    }
    
    @objc private func tapAction_BettingRecord(_ sender: UITapGestureRecognizer) {
        if self.cClick != nil {
            self.cClick!(3)
        }
    }
    
}
