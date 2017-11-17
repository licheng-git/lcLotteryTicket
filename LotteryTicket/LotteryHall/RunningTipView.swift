//
//  RunningTipView.swift
//  LotteryTicket
//
//  Created by 李诚 on 17/10/30.
//  Copyright © 2017年 李诚. All rights reserved.
//

import UIKit
import SnapKit

class RunningTipView: UIView {
    
    lazy var lbText: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .left
        lb.font = UIFont.systemFont(ofSize: 14)
        //lb.adjustsFontSizeToFitWidth = true
        //lb.sizeToFit()
        return lb
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        
        let imgview = UIImageView()
        imgview.image = UIImage(named: "")
        imgview.backgroundColor = UIColor.red
        self.addSubview(imgview)
        imgview.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20)
        }
        
        let lbBgView = UIView()
        //lbBgView.mask?.clipsToBounds = true
        self.addSubview(lbBgView)
        lbBgView.snp.makeConstraints { (make) in
            make.left.equalTo(imgview.snp.right).offset(20)
            make.right.equalToSuperview().offset(-5)
            make.top.bottom.equalToSuperview()
        }
        
        lbBgView.addSubview(self.lbText)
        self.lbText.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalTo(21)
            make.left.equalTo(lbBgView.snp.right)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if self.superview == nil {
            return
        }
        self.lbText.superview?.clipsToBounds = true
    }
    
    func keepRunning() {
        //print("lb.w=\(self.lbText.bounds.size.width), lb.x=\(self.lbText.frame.origin.x)")
        self.layoutIfNeeded()
        //print("lb.w=\(self.lbText.bounds.size.width), lb.x=\(self.lbText.frame.origin.x)")
        let translateX: CGFloat = 5
        UIView.animate(withDuration: 0.1, animations: {
            self.lbText.frame.origin.x -= translateX
        }) { (finished) in
            var pasueSeconds = 0
            if self.lbText.frame.maxX < 0 {
                self.lbText.frame.origin.x = (self.lbText.superview?.bounds.width)!
                pasueSeconds = 2
            }
            if self.lbText.frame.minX >= 0 && self.lbText.frame.minX < translateX {
                pasueSeconds = 2
            }
            //DispatchQueue.main.asyncAfter(deadline: (.now() + 2), execute: {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(pasueSeconds)) {
                self.keepRunning()
            }
        }
    }
    
}
