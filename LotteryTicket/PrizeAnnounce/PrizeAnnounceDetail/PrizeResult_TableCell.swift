//
//  PrizeResult_TableCell.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/8.
//  Copyright © 2017年 李诚. All rights reserved.
//

import UIKit
import SnapKit

class PrizeResult_TableCell: UITableViewCell {
    
    static let prHeight: CGFloat = 80
    
    let lbTitle: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .left
        lb.font = UIFont.systemFont(ofSize: 16)
        return lb
    } ()
    
    let bgResultView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    } ()
    
    let lineView_FristCell_Top: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.lightGray
        lineView.isHidden = true
        return lineView
    } ()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.addSubview(self.lbTitle)
        self.lbTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(21)
        }
        self.addSubview(self.bgResultView)
        self.bgResultView.snp.makeConstraints { (make) in
            make.top.equalTo(self.lbTitle.snp.bottom)
            make.left.right.equalTo(self.lbTitle)
            make.bottom.equalToSuperview()
        }
        let lineView_bottom = UIView()
        lineView_bottom.backgroundColor = UIColor.lightGray
        self.addSubview(lineView_bottom)
        lineView_bottom.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-1)
        }
        self.addSubview(self.lineView_FristCell_Top)
        self.lineView_FristCell_Top.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(1)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var strResult: String? = nil {
        didSet {
            if (self.strResult?.isEmpty)! {
                return
            }
            //print("didSet \(self.strResult!) \(self.bgResultView.frame)")  // .zero
            //self.layoutIfNeeded()
            //print("didSet self.layoutIfNeed() \(self.bgResultView.frame)")  // 正常
            for v in self.bgResultView.subviews {
                v.removeFromSuperview()
            }
            let arrChars = Array(self.strResult!)
            let w: CGFloat = 25
            var btnPre: UIButton?
            for i in 0..<arrChars.count {
                let c = arrChars[i]
                let strC = String(c)
                let btn = UIButton()
                btn.isEnabled = false
                btn.setTitle(strC, for: .normal)
                btn.setTitleColor(UIColor.white, for: .normal)
                btn.backgroundColor = UIColor.red
                self.bgResultView.addSubview(btn)
                if btnPre == nil {
                    btn.snp.makeConstraints({ (make) in
                        make.centerY.equalToSuperview()
                        make.width.height.equalTo(w)
                        make.left.equalToSuperview()
                    })
                }
                else {
                    btn.snp.makeConstraints({ (make) in
                        make.centerY.equalToSuperview()
                        make.width.height.equalTo(w)
                        make.left.equalTo(btnPre!.snp.right).offset(5)
                    })
                }
                btnPre = btn
                btn.layer.cornerRadius = w/2
            }
        }
    }
    
//    func fSetResult(_ strResult:String) {
//        //print("func \(self.bgResultView.frame)")  // .zero
//        self.layoutIfNeeded()
//        //print("func self.layoutIfNeed() \(self.bgResultView.frame)")  // 正常
//        for v in self.bgResultView.subviews {
//            v.removeFromSuperview()
//        }
//        let arrChars = Array(strResult)
//        let w: CGFloat = 25
//        let y: CGFloat = (self.bgResultView.frame.height - w) / 2
//        for i in 0..<arrChars.count {
//            let c = arrChars[i]
//            let strC = String(c)
//            let btn = UIButton()
//            btn.isEnabled = false
//            btn.setTitle(strC, for: .normal)
//            btn.setTitleColor(UIColor.white, for: .normal)
//            btn.backgroundColor = UIColor.red
//            self.bgResultView.addSubview(btn)
//            btn.frame = CGRect(x: (w+5)*CGFloat(i), y: y, width: w, height: w)
//            btn.layer.cornerRadius = w/2
//        }
//    }
    
}
