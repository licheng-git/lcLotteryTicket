//
//  SelectButtonsView.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/1.
//  Copyright © 2017年 李诚. All rights reserved.
//

import UIKit

class SelectButtonsView: UIScrollView {
    
    let arrData = [ "热门彩种", "时时彩", "11选5", "快3", "福彩3D", "排列5", "PK10", "六合彩" ]
    
    var cBtnClick: ((_ index:Int)->())?
    
    var defaultClickedIndex = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = kBgColorGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let btnW: CGFloat = 80
        var btnX: CGFloat = 0
        var btnDefault: UIButton?
        for i in 0..<arrData.count {
            let btn = UIButton(type: .custom)
            btn.setTitle(arrData[i], for: .normal)
            btn.setTitleColor(UIColor.darkText, for: .normal)
            btn.setTitleColor(UIColor.red, for: .selected)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            btn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
            btn.tag = i
            btnX = 10 + btnW * CGFloat(i)
            btn.frame = CGRect(x: btnX, y: 0, width: btnW, height: rect.height)
            btn.backgroundColor = UIColor.clear
            self.addSubview(btn)
            if i == defaultClickedIndex {
                btnDefault = btn
            }
        }
        if btnDefault != nil {
            DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                self.btnClick(btnDefault!)
            })
        }
        let contentSize_W = 20 + btnW * CGFloat(arrData.count)
        self.contentSize = CGSize(width: contentSize_W, height: rect.height)
        //self.showsHorizontalScrollIndicator = false
    }
    
    @objc private func btnClick(_ sender: UIButton) {
        if sender.isSelected {
            return
        }
        for v in self.subviews {
            if v.isMember(of: UIButton.classForCoder()) {
                let btn = v as! UIButton
                btn.isSelected = false
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            }
        }
        sender.isSelected = true
        sender.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        
        //self.setContentOffset(CGPoint(x: sender.frame.minX, y: 0), animated: true)
        var offsetX = sender.center.x - self.bounds.width/2
        if offsetX < 0 {
            offsetX = 0
        }
        else if offsetX > self.contentSize.width - self.bounds.width {
            offsetX = self.contentSize.width - self.bounds.width
        }
        self.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
        
        if self.cBtnClick != nil {
            self.cBtnClick!(sender.tag)
        }
    }
    
}
