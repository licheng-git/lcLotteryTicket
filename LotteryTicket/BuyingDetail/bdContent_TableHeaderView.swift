//
//  bdContent_TableHeaderView.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/24.
//  Copyright © 2017年 李诚. All rights reserved.
//

class bdContent_TableHeaderView: UIView {
    
    static let hHeight:CGFloat = 50
    
    lazy var lbTitle: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 16)
        lb.textColor = UIColor.darkGray
        return lb
    } ()
    
    private var arrChoose = [String]()
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    var model: bdContent_AreaPos_Model? = nil {
        didSet {
            if self.model == nil {
                return
            }
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
                make.centerY.equalToSuperview()
                make.left.equalToSuperview().offset(5)
                make.height.equalTo(30)
                make.width.equalTo(70)
            }
            bgView_lbTitle.addSubview(self.lbTitle)
            self.lbTitle.snp.makeConstraints { (make) in
                make.left.right.top.bottom.equalToSuperview()
            }
            self.lbTitle.text = model!.title
            
            let dictPos = model!.pos!.sorted { $0.0 > $1.0 }  // key排序
            //print("*_* dictPos=\(dictPos), model.pos=\(model.pos!)")
            
            var btnPre:UIButton_Ext?
            //for dict in model.pos! {
            for dict in dictPos {
                let btn = UIButton_Ext()
                btn.setTitle(dict.value as? String, for: .normal)
                btn.setTitleColor(UIColor.gray, for: .normal)
                btn.setTitleColor(UIColor.white, for: .selected)
                btn.addTarget(self, action: #selector(btnAction_Specail(_:)), for: .touchUpInside)
                btn.posId = dict.key
                btn.layer.cornerRadius = 5
                btn.layer.borderColor = UIColor.lightGray.cgColor
                var bToChoose = false
                if model!.choose != nil {
                    self.arrChoose = model!.choose!
                    for strKey in model!.choose! {
                        if strKey == dict.key {
                            bToChoose = true
                            break
                        }
                    }
                }
                if bToChoose {
                    btn.isSelected = true
                    btn.backgroundColor = UIColor.red
                    btn.layer.borderWidth = 0
                }
                else {
                    btn.isSelected = false
                    btn.backgroundColor = UIColor.white
                    btn.layer.borderWidth = 1
                }
                self.addSubview(btn)
                if btnPre == nil {
                    btn.snp.makeConstraints({ (make) in
                        make.right.equalToSuperview().offset(-5)
                        make.centerY.equalToSuperview()
                        make.height.equalTo(30)
                        make.width.equalTo(43)
                    })
                }
                else {
                    btn.snp.makeConstraints({ (make) in
                        make.width.height.centerY.equalTo(btnPre!)
                        make.right.equalTo(btnPre!.snp.left).offset(-5)
                    })
                }
                btnPre = btn
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
    }
    
    weak var delegate: bdContent_AnyButton_Delegate?
    
    var cBtnAction_Specail:((_ arrChoose:[String])->Void)?
    
    @objc private func btnAction_Specail(_ sender: UIButton_Ext) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.backgroundColor = UIColor.red
            sender.layer.borderWidth = 0
        }
        else {
            sender.backgroundColor = UIColor.white
            sender.layer.borderWidth = 1
        }
        
        var existIndex = -1
        for i in 0..<self.arrChoose.count {
            let posId = self.arrChoose[i]
            if posId == sender.posId! {
                existIndex = i
                break
            }
        }
        if sender.isSelected && existIndex == -1 {
            self.arrChoose.append(sender.posId!)
        }
        else if !sender.isSelected && existIndex != -1 {
            self.arrChoose.remove(at: existIndex)
        }
        
        self.cBtnAction_Specail!(self.arrChoose)
        
        if self.delegate != nil {
            self.delegate!.dRunCalculate()
        }
    }
    
}


fileprivate class UIButton_Ext: UIButton {
    var posId: String?
}
