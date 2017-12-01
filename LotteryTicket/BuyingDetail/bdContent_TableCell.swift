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
    
    var areaId = String()
    var maxChooseLenght:Int?
    
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        self.backgroundColor = UIColor.white
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    
    var arrBtn = [UIButton]()
    var arrBtnOperation = [UIButton]()
    
    var arrId_all = [Int]()
    var arrId_choose = [Int]()
    
    func fConfigCellData(_ modelArea:bdContent_Area_Model, _ arrModelList:[bdContent_List_Model], _ bOperationBtns:Bool, _ bShowLine:Bool = true) {
        for v in self.subviews {
            v.removeFromSuperview()
        }
        self.arrBtn.removeAll()
        self.arrBtnOperation.removeAll()
        self.arrId_all.removeAll()
        self.arrId_choose.removeAll()
        self.areaId = String()
        self.maxChooseLenght = nil
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
            make.width.equalTo(70)
        }
        bgView_lbTitle.addSubview(self.lbTitle)
        self.lbTitle.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        self.lbTitle.text = modelArea.title
        self.areaId = modelArea.id!
        self.maxChooseLenght = modelArea.length
        
        self.layoutIfNeeded()
        let btnsItems_MaxX:CGFloat = kSCREEN_WIDTH - 5
        let btn_H: CGFloat = bgView_lbTitle.frame.height
        var btn_W: CGFloat = btn_H
        var btn_Y: CGFloat = bgView_lbTitle.frame.minY
        let btn0_X: CGFloat = bgView_lbTitle.frame.maxX + 10
        var btn_NextX:CGFloat = btn0_X
        var btnTag_Index = 0
        for modelList in arrModelList {
            let strC = modelList.name!
            let btn = UIButton()
            btn.setTitle(strC, for: .normal)
            btn.setTitleColor(UIColor.red, for: .normal)
            btn.setTitleColor(UIColor.white, for: .selected)
            btn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
            btn.tag = btnTag_Index
            btnTag_Index += 1
            btn.layer.borderColor = UIColor.lightGray.cgColor
            btn.layer.borderWidth = 1
            self.addSubview(btn)
            self.arrBtn.append(btn)
            self.arrId_all.append(modelList.id!)
            btn_W = btn_H
            btn.layer.cornerRadius = btn_H/2
            let intC = Int(strC)
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
        
        let btnOperation_H:CGFloat = 30
        if bOperationBtns {
            let arrStr = ["全", "大", "小", "单", "双", "清"]
            var btnPre:UIButton?
            for i in (0..<arrStr.count).reversed() {
                let btn = UIButton()
                btn.setTitle(arrStr[i], for: .normal)
                btn.setTitleColor(UIColor.gray, for: .normal)
                btn.setTitleColor(UIColor.white, for: .selected)
                btn.addTarget(self, action: #selector(btnAction_Operation(_:)), for: .touchUpInside)
                btn.tag = i
                btn.layer.borderWidth = 1
                btn.layer.borderColor = UIColor.gray.cgColor
                btn.layer.cornerRadius = 5
                self.addSubview(btn)
                self.arrBtnOperation.append(btn)
                if btnPre == nil {
                    btn.snp.makeConstraints({ (make) in
                        make.right.equalToSuperview().offset(-5)
                        make.bottom.equalToSuperview().offset(-10)
                        make.width.height.equalTo(btnOperation_H)
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
        if bOperationBtns {
            self.cHeight += btnOperation_H + 10
        }
    }
    
    weak var delegate: bdContent_AnyButton_Delegate?
    
    var cBtnAction_SingleChioce:((_ modelList_curCode:bdContent_List_Model)->Bool)?
    var cBtnAction_SingleChoice_SaveChosen:(()->())?
    
    @objc private func btnAction(_ sender: UIButton) {
        let modelList_curCode = bdContent_List_Model()
        modelList_curCode.name = sender.titleLabel?.text
        modelList_curCode.id = self.arrId_all[sender.tag]
        let bIsRepeat = self.cBtnAction_SingleChioce!(modelList_curCode)
        if bIsRepeat {
            // 不同行的重号
            return
        }
        
        sender.isSelected = !sender.isSelected
        self.setBtnBgColor(sender)
        
        let btnSender_id = self.arrId_all[sender.tag]
        if sender.isSelected {
            self.arrId_choose.append(btnSender_id)
            if self.maxChooseLenght != nil && self.arrId_choose.count > self.maxChooseLenght! {  // 同一行最多选择个数
                let btnToUnSelect_id = self.arrId_choose[0]
                for i in 0..<self.arrBtn.count {
                    if btnToUnSelect_id == self.arrId_all[i] {
                        let btnToUnSelect = self.arrBtn[i]
                        btnToUnSelect.isSelected = false
                        self.setBtnBgColor(btnToUnSelect)
                        break
                    }
                }
                self.arrId_choose.removeFirst()
            }
        }
        else {
            for i in 0..<self.arrId_choose.count {
                if self.arrId_choose[i] == btnSender_id {
                    self.arrId_choose.remove(at: i)
                    break
                }
            }
        }
        
        self.cBtnAction_SingleChoice_SaveChosen!()
        
        if self.delegate != nil {
            self.delegate!.dRunCalculate()
        }
    }
    
    var cBtnAction_Operation: ((_ operationType:String)->[Int])?
    
    @objc private func btnAction_Operation(_ sender: UIButton) {
        for btnOperation in self.arrBtnOperation {
            if btnOperation != sender {
                btnOperation.isSelected = false
                self.setBtnBgColor(btnOperation)
            }
            sender.isSelected = true
            self.setBtnBgColor(sender)
            if sender.tag == self.arrBtnOperation.count-1 {  // 清
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                    sender.isSelected = false
                    self.setBtnBgColor(sender)
                })
            }
        }
        
        let arrOperationType = ["all", "big", "small", "odd", "even", "clear"]
        let operationType = arrOperationType[sender.tag]
        if self.cBtnAction_Operation != nil {
            let arrId_jsChoose = self.cBtnAction_Operation!(operationType)
            self.arrId_choose = arrId_jsChoose
            for i in 0..<self.arrBtn.count {
                let btn = self.arrBtn[i]
                let btn_id = self.arrId_all[i]
                var bToSelect = false
                for chooseId in arrId_jsChoose {
                    if chooseId == btn_id {
                        bToSelect = true
                        break
                    }
                }
                btn.isSelected = bToSelect
                self.setBtnBgColor(btn)
            }
        }
        
        if self.delegate != nil {
            self.delegate!.dRunCalculate()
        }
    }
    
    private func setBtnBgColor(_ btn: UIButton) {
        if btn.isSelected {
            btn.backgroundColor = UIColor.red
            btn.layer.borderWidth = 0
        }
        else {
            btn.backgroundColor = UIColor.white
            btn.layer.borderWidth = 1
        }
    }
    
    
    func fConfigWhenReuse() {
        for btnSelect_id in self.arrId_choose {
            for i in 0..<self.arrBtn.count {
                let btn_id = self.arrId_all[i]
                if btnSelect_id == btn_id {
                    let btn = self.arrBtn[i]
                    btn.isSelected = true
                    self.setBtnBgColor(btn)
                    break
                }
            }
        }
    }
    
}
