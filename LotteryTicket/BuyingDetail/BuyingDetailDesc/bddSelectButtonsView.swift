//
//  bddSelectButtonsView.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/16.
//  Copyright © 2017年 李诚. All rights reserved.
//

import UIKit

class bddSelectButtonsView: UIView {
    
    static let height:CGFloat = 50
    
    lazy var btnPlayRule: UIButton = {
        let btn = UIButton()
        btn.setTitle("玩法规则", for: .normal)
        btn.setTitleColor(UIColor.darkText, for: .normal)
        btn.setTitleColor(UIColor.red, for: .selected)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
        btn.tag = 0
        return btn
    } ()
    
    lazy var btnPrizeExample: UIButton = {
        let btn = UIButton()
        btn.setTitle("中奖举例", for: .normal)
        btn.setTitleColor(UIColor.darkText, for: .normal)
        btn.setTitleColor(UIColor.red, for: .selected)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
        btn.tag = 1
        return btn
    } ()
    
    lazy var btnPrizeDetail: UIButton = {
        let btn = UIButton()
        btn.setTitle("彩金详情", for: .normal)
        btn.setTitleColor(UIColor.darkText, for: .normal)
        btn.setTitleColor(UIColor.red, for: .selected)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
        btn.tag = 2
        return btn
    } ()
    
    var cBtnClick: ((_ index:Int, _ btnTitle:String)->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.addSubview(self.btnPlayRule)
        self.btnPlayRule.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(kSCREEN_WIDTH/3)
            make.left.equalToSuperview()
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
        let lineview = UIView()
        lineview.backgroundColor = UIColor.lightGray
        self.addSubview(lineview)
        lineview.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//    var defaultClickedIndex = 0
//    override func draw(_ rect: CGRect) {
//        super.draw(rect)
//        //print("view draw \(self.defaultClickedIndex)")
//        let btn = self.viewWithTag(self.defaultClickedIndex)  // tag为0时找不到
//        if btn != nil && (btn?.isMember(of: UIButton.classForCoder()))! {
//            self.btnClick(btn as! UIButton)
//        }
//    }
    
    var defaultClickedIndex:Int = 0 {
        didSet {
            //print("view didSet \(self.defaultClickedIndex)")
            if self.defaultClickedIndex == 0 {
                self.btnClick(self.btnPlayRule)
            }
            else if self.defaultClickedIndex == 1 {
                self.btnClick(self.btnPrizeExample)
            }
            else if self.defaultClickedIndex == 2 {
                self.btnClick(self.btnPrizeDetail)
            }
        }
    }
    
    
    @objc private func btnClick(_ sender: UIButton) {
        if sender.isSelected {
            return
        }
        self.btnPlayRule.isSelected = false
        self.btnPrizeExample.isSelected = false
        self.btnPrizeDetail.isSelected = false
        sender.isSelected = true
        if self.cBtnClick != nil {
            self.cBtnClick!(sender.tag, (sender.titleLabel?.text)!)
        }
    }
    
}
