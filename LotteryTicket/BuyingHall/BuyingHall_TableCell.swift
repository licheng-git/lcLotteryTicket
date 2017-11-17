//
//  BuyingHall_TableCell.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/1.
//  Copyright © 2017年 李诚. All rights reserved.
//

import UIKit
import SnapKit


protocol BuyingHall_TableCell_Delegate: class {
    func dNumberTrend(_ cell: BuyingHall_TableCell)
    //func dPrizeDetial(_ cell: BuyingHall_TableCell)
}


class BuyingHall_TableCell: UITableViewCell {
    
    static let bhHeight: CGFloat = 100
    
    weak var delegate: BuyingHall_TableCell_Delegate?
    //var cNumberTrend: ((_ cell: BuyingHall_TableCell)->())?
    var cPrizeDetail: ((_ cell: BuyingHall_TableCell)->Void)?
    
    let imgviewIcon: UIImageView = {
        let imgview = UIImageView()
        return imgview
    } ()
    
    let lbName: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .left
        lb.font = UIFont.systemFont(ofSize: 16)
        return lb
    } ()
    
    let lbDescription: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .left
        lb.font = UIFont.systemFont(ofSize: 14)
        lb.textColor = UIColor.lightGray
        return lb
    } ()
    
    let lbTime: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .right
        lb.font = UIFont.systemFont(ofSize: 14)
        lb.textColor = UIColor.red
        return lb
    } ()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        self.addSubview(self.imgviewIcon)
        self.imgviewIcon.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.width.height.equalTo(40)
        }
        
        self.addSubview(self.lbName)
        self.lbName.snp.makeConstraints { (make) in
            make.top.equalTo(self.imgviewIcon)
            make.left.equalTo(self.imgviewIcon.snp.right).offset(5)
            make.height.equalTo(21)
            make.width.equalTo(180)
        }
        
        self.addSubview(self.lbDescription)
        self.lbDescription.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.imgviewIcon)
            make.left.height.width.equalTo(self.lbName)
        }
        
        let imgviewArrow = UIImageView()
        imgviewArrow.image = UIImage(named: "arrow_right")
        self.addSubview(imgviewArrow)
        imgviewArrow.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-5)
            make.centerY.equalTo(self.imgviewIcon)
            make.width.equalTo(10)
            make.height.equalTo(18)
        }
        
        self.addSubview(self.lbTime)
        self.lbTime.snp.makeConstraints { (make) in
            make.right.equalTo(imgviewArrow.snp.left).offset(-5)
            make.centerY.equalTo(self.lbDescription)
            make.height.equalTo(21)
            make.width.equalTo(80)
        }
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor.lightGray
        self.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.top.equalTo(self.imgviewIcon.snp.bottom).offset(10)
            make.left.equalTo(self.imgviewIcon.snp.left)
            make.right.equalTo(imgviewArrow)
        }
        
        let btn0 = UIButton(type: .custom)
        btn0.setTitle("号码走势", for: .normal)
        btn0.setTitleColor(UIColor.darkText, for: .normal)
        btn0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn0.setImage(UIImage(named: "icon_3d"), for: .normal)
        btn0.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
        btn0.tag = 10
        self.addSubview(btn0)
        btn0.snp.makeConstraints { (make) in
            make.left.equalTo(self.imgviewIcon)
            make.right.equalTo(self.snp.centerX).offset(-10)
            make.top.equalTo(lineView)
            make.height.equalTo(30)
        }
        
        let btn1 = UIButton(type: .custom)
        btn1.setTitle("奖金详情", for: .normal)
        btn1.setTitleColor(UIColor.darkText, for: .normal)
        btn1.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn1.setImage(UIImage(named: "btn_arrow_down"), for: .normal)
        btn1.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
        btn1.tag = 11
        self.addSubview(btn1)
        btn1.snp.makeConstraints { (make) in
            make.right.equalTo(imgviewArrow)
            make.left.equalTo(self.snp.centerX).offset(10)
            make.top.bottom.equalTo(btn0)
        }
        
        let separatorView = UIView()
        separatorView.backgroundColor = kBgColorGray
        self.addSubview(separatorView)
        separatorView.snp.makeConstraints { (make) in
            make.top.equalTo(btn0.snp.bottom)
            make.bottom.left.right.equalToSuperview()
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc private func btnClick(_ sender: UIButton) {
        if self.delegate == nil {
            return
        }
        if sender.tag == 10 {
            self.delegate?.dNumberTrend(self)
        }
        
        if sender.tag == 11 && self.cPrizeDetail != nil {
            self.cPrizeDetail!(self)
        }
    }
    
    
    private var timer: Timer?
    private var remainSeconds: Int = 0
    
    func startTimer(_ model: BuyingHall_Model) {
        self.remainSeconds = model.time_int!
        self.stopTimer()
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction(_:)), userInfo: nil, repeats: true)
        RunLoop.current.add(self.timer!, forMode: .commonModes)
        self.timer?.fire()
    }
    
    @objc private func timerAction(_ t:Timer) {
        print("cell.timerAction \(self.lbName.text!) \(self.remainSeconds)")
        self.lbTime.text = self.timeConvert(self.remainSeconds)
        self.remainSeconds -= 1
        if self.remainSeconds < 0 {
            self.stopTimer()
        }
    }
    
    func timeConvert(_ t:Int) -> String {
        let h:Int = (t/(60*60))%60
        let m:Int = (t/60)%60
        let s:Int = t%60
        let result = String.init(format: "%02d:%02d:%02d", h, m, s)
        return result
    }
    
    func stopTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
    
}
