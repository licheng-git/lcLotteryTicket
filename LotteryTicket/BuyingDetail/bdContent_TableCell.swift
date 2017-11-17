//
//  bdContentTableCell.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/15.
//  Copyright © 2017年 李诚. All rights reserved.
//

class bdContent_TableCell: UITableViewCell {
    
    var cHeight: CGFloat = 0
    
    lazy var lbTitle: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 16)
        lb.textColor = UIColor.darkGray
        return lb
    } ()
    
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        self.backgroundColor = UIColor.white
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    
    func fConfigCellData(_ title:String, _ items:String, _ bShowLine:Bool = true) {
        for v in self.subviews {
            v.removeFromSuperview()
        }
        self.backgroundColor = UIColor.white
        
        let bgView_lbTitle = UIView()
        bgView_lbTitle.backgroundColor = kBgColorGray
        bgView_lbTitle.layer.borderColor = UIColor.lightGray.cgColor
        bgView_lbTitle.layer.borderWidth = 1
        bgView_lbTitle.layer.cornerRadius = 5
        self.addSubview(bgView_lbTitle)
        bgView_lbTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(5)
            make.height.equalTo(30)
            make.width.equalTo(60)
        }
        bgView_lbTitle.addSubview(self.lbTitle)
        self.lbTitle.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        self.lbTitle.text = title
        
        self.layoutIfNeeded()
        let btnsItems_MaxX:CGFloat = kSCREEN_WIDTH - 5
        let btn_H: CGFloat = bgView_lbTitle.frame.height
        var btn_W: CGFloat = btn_H
        var btn_Y: CGFloat = bgView_lbTitle.frame.minY
        let btn0_X: CGFloat = bgView_lbTitle.frame.maxX + 10
        var btn_NextX:CGFloat = btn0_X
        let arrChars = items.split(separator: ",")
        for i in 0..<arrChars.count {
            let c = arrChars[i]
            let strC = String(c)
            let btn = UIButton()
            btn.setTitle(strC, for: .normal)
            btn.setTitleColor(UIColor.red, for: .normal)
            btn.setTitleColor(UIColor.white, for: .selected)
            btn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
            btn.layer.borderColor = UIColor.lightGray.cgColor
            btn.layer.borderWidth = 1
            self.addSubview(btn)
            btn_W = btn_H
            btn.layer.cornerRadius = btn_H/2
            let intC = Int(c)
            if intC == nil {
                if strC.characters.count > 1 {
                    btn_W = CGFloat((strC.characters.count+2) * 15)
                    btn.layer.cornerRadius = 5
                }
            }
            if btn_NextX + btn_W > btnsItems_MaxX {
                btn_NextX = btn0_X
                btn_Y += btn_H + 5
            }
            btn.frame = CGRect(x: btn_NextX, y: btn_Y, width: btn_W, height: btn_H)
            btn_NextX = btn.frame.maxX + 10
        }
        
        if bShowLine {
            let lineview = UIView()
            lineview.backgroundColor = UIColor.lightGray
            self.addSubview(lineview)
            lineview.snp.makeConstraints { (make) in
                make.height.equalTo(1)
                make.left.right.equalToSuperview()
                make.top.equalToSuperview()
            }
        }
        
        self.cHeight = btn_Y + btn_H + 10
    }
    
//    static func fCaculateHeight(_ items:String) -> CGFloat {
//        let btnsItems_MaxX:CGFloat = kSCREEN_WIDTH - 5
//        let btn_H: CGFloat = 30
//        var btn_W: CGFloat = btn_H
//        var btn_Y: CGFloat = 10
//        let btn0_X: CGFloat = 5 + 60 + 10
//        var btn_NextX:CGFloat = btn0_X
//        let arrChars = items.split(separator: ",")
//        for i in 0..<arrChars.count {
//            let c = arrChars[i]
//            let strC = String(c)
//            btn_W = btn_H
//            let intC = Int(c)
//            if intC == nil {
//                if strC.characters.count > 1 {
//                    btn_W = CGFloat((strC.characters.count+2) * 15)
//                }
//            }
//            if btn_NextX + btn_W > btnsItems_MaxX {
//                btn_NextX = btn0_X
//                btn_Y += btn_H + 5
//            }
//            btn_NextX += btn_W + 10
//        }
//        return btn_Y + btn_H + 10
//    }
    
    @objc private func btnAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.backgroundColor = UIColor.red
            sender.layer.borderWidth = 0
        }
        else {
            sender.backgroundColor = UIColor.white
            sender.layer.borderWidth = 1
        }
    }
    
}
