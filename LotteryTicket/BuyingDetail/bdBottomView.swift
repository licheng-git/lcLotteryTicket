//
//  bdBottomView.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/14.
//  Copyright © 2017年 李诚. All rights reserved.
//

class bdBottomView: UIView, UITextFieldDelegate {
    
    private enum BtnTag : Int {
        case minus = 100, add, yuan, jiao, fen, shoppingCar, betting
    }
    
    static let height:CGFloat = 120
    
    let lbBalance: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .left
        lb.font = UIFont.systemFont(ofSize: 14)
        lb.textColor = UIColor.red
        lb.text = "余额：20000.00"
        return lb
    } ()
    
    let lbDesc: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .left
        lb.font = UIFont.systemFont(ofSize: 14)
        lb.textColor = UIColor.red
        lb.text = "单注单倍最高奖金2000.00元"
        return lb
    } ()
    
    lazy var tfInput: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.textAlignment = .center
        tf.keyboardType = .numberPad
        tf.text = "1"
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.delegate = self
        return tf
    } ()
    
    lazy var btnMinus: UIButton = {
        let btn = UIButton()
        btn.setTitle("-", for: .normal)
        btn.setTitleColor(UIColor.darkText, for: .normal)
        btn.addTarget(self, action: #selector(btnAction_tf(_:)), for: .touchUpInside)
        btn.tag = BtnTag.minus.rawValue
        return btn
    } ()
    
    lazy var btnAdd: UIButton = {
        let btn = UIButton()
        btn.setTitle("+", for: .normal)
        btn.setTitleColor(UIColor.darkText, for: .normal)
        btn.addTarget(self, action: #selector(btnAction_tf(_:)), for: .touchUpInside)
        btn.tag = BtnTag.add.rawValue
        return btn
    } ()
    
    lazy var btnYuan: UIButton = {
        let btn = UIButton()
        btn.setTitle("元", for: .normal)
        btn.setTitleColor(UIColor.darkText, for: .normal)
        btn.setTitleColor(UIColor.white, for: .selected)
        btn.addTarget(self, action: #selector(btnAction_yjf(_:)), for: .touchUpInside)
        btn.tag = BtnTag.yuan.rawValue
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.red.cgColor
        btn.isSelected = true
        btn.backgroundColor = UIColor.red
        return btn
    } ()
    
    lazy var btnJiao: UIButton = {
        let btn = UIButton()
        btn.setTitle("角", for: .normal)
        btn.setTitleColor(UIColor.darkText, for: .normal)
        btn.setTitleColor(UIColor.white, for: .selected)
        btn.addTarget(self, action: #selector(btnAction_yjf(_:)), for: .touchUpInside)
        btn.tag = BtnTag.jiao.rawValue
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.lightGray.cgColor
        return btn
    } ()
    
    lazy var btnFen: UIButton = {
        let btn = UIButton()
        btn.setTitle("分", for: .normal)
        btn.setTitleColor(UIColor.darkText, for: .normal)
        btn.setTitleColor(UIColor.white, for: .selected)
        btn.addTarget(self, action: #selector(btnAction_yjf(_:)), for: .touchUpInside)
        btn.tag = BtnTag.fen.rawValue
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.lightGray.cgColor
        return btn
    } ()
    
    let lbTotalBetting: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .left
        lb.font = UIFont.systemFont(ofSize: 14)
        //lb.text = "总投注 0 注"
        var attrText = NSMutableAttributedString(string: "总投注 ", attributes: [NSForegroundColorAttributeName:UIColor.darkText])
        attrText.append(NSAttributedString(string: "0", attributes: [NSForegroundColorAttributeName:UIColor.red]))
        attrText.append(NSAttributedString(string: " 注"))
        lb.attributedText = attrText
        return lb
    } ()
    
    let lbTotalAmount: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .left
        lb.font = UIFont.systemFont(ofSize: 14)
        //lb.text = "总投注金额 0.00 注"
        var attrText = NSMutableAttributedString(string: "总投注金额 ", attributes: [NSForegroundColorAttributeName:UIColor.darkText])
        attrText.append(NSAttributedString(string: "0.00", attributes: [NSForegroundColorAttributeName:UIColor.red]))
        attrText.append(NSAttributedString(string: " 元 "))
        lb.attributedText = attrText
        return lb
    } ()
    
    lazy var btnShoppingCar: UIButton = {
        let btn = UIButton()
        btn.setTitle("加入购物车", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.orange
        btn.layer.cornerRadius = 5
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        btn.tag = BtnTag.shoppingCar.rawValue
        return btn
    } ()
    
    lazy var btnBetting: UIButton = {
        let btn = UIButton()
        btn.setTitle("下注", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.red
        btn.layer.cornerRadius = 5
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        btn.tag = BtnTag.betting.rawValue
        return btn
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        let lineview0 = UIView()
        lineview0.backgroundColor = UIColor.lightGray
        self.addSubview(lineview0)
        lineview0.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
        }
        self.addSubview(self.lbBalance)
        self.lbBalance.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.height.equalTo(21)
            make.left.equalToSuperview().offset(5)
            make.width.equalTo(120)
        }
        self.addSubview(self.lbDesc)
        self.lbDesc.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.lbBalance)
            make.right.equalToSuperview()
            make.left.equalTo(self.lbBalance.snp.right)
        }
        let lineview1 = UIView()
        lineview1.backgroundColor = UIColor.lightGray
        self.addSubview(lineview1)
        lineview1.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.left.right.equalToSuperview()
            make.top.equalTo(self.lbBalance.snp.bottom).offset(5)
        }
        
        self.addSubview(btnMinus)
        btnMinus.snp.makeConstraints { (make) in
            make.top.equalTo(lineview1.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(5)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        self.addSubview(self.tfInput)
        self.tfInput.snp.makeConstraints { (make) in
            make.left.equalTo(btnMinus.snp.right)
            make.top.bottom.equalTo(btnMinus)
            make.width.equalTo(70)
        }
        self.addSubview(btnAdd)
        btnAdd.snp.makeConstraints { (make) in
            make.left.equalTo(self.tfInput.snp.right)
            make.top.bottom.width.equalTo(btnMinus)
        }
        self.addSubview(self.btnFen)
        self.btnFen.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(btnMinus)
            make.right.equalToSuperview().offset(-5)
            make.width.equalTo(50)
        }
        self.addSubview(self.btnJiao)
        self.btnJiao.snp.makeConstraints { (make) in
            make.top.bottom.width.equalTo(self.btnFen)
            make.right.equalTo(self.btnFen.snp.left)
        }
        self.addSubview(self.btnYuan)
        self.btnYuan.snp.makeConstraints { (make) in
            make.top.bottom.width.equalTo(self.btnFen)
            make.right.equalTo(self.btnJiao.snp.left)
        }
        let lineview2 = UIView()
        lineview2.backgroundColor = UIColor.lightGray
        self.addSubview(lineview2)
        lineview2.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.left.right.equalToSuperview()
            make.top.equalTo(btnMinus.snp.bottom).offset(5)
        }
        
        self.addSubview(self.lbTotalBetting)
        self.lbTotalBetting.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.top.equalTo(lineview2.snp.bottom).offset(3)
            make.height.equalTo(21)
            make.width.equalTo(160)
        }
        self.addSubview(self.lbTotalAmount)
        self.lbTotalAmount.snp.makeConstraints { (make) in
            make.left.equalTo(self.lbTotalBetting)
            make.bottom.equalToSuperview().offset(-3)
            make.height.equalTo(21)
            make.width.equalTo(self.lbTotalBetting)
        }
        self.addSubview(self.btnBetting)
        self.btnBetting.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-5)
            make.top.equalTo(lineview2.snp.bottom).offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalTo(80)
        }
        self.addSubview(self.btnShoppingCar)
        self.btnShoppingCar.snp.makeConstraints { (make) in
            make.top.bottom.width.equalTo(self.btnBetting)
            make.right.equalTo(self.btnBetting.snp.left).offset(-5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc private func btnAction_tf(_ sender: UIButton) {
        if (self.tfInput.text?.isEmpty)! {
            self.tfInput.text = "1"
            return
        }
        var n = Int(self.tfInput.text!)
        if sender.tag == BtnTag.minus.rawValue {
            if n! > 1 {
                n! -= 1
            }
            else if n! > 9999 {
                n! = 9999
            }
        }
        else if sender.tag == BtnTag.add.rawValue {
            n! += 1
            if n! > 9999 {
                n! = 9999
            }
        }
        self.tfInput.text = String(n!)
    }
    
    @objc private func btnAction_yjf(_ sender: UIButton) {
        let arrBtns = [ self.btnYuan, self.btnJiao, self.btnFen ]
        for btn in arrBtns {
            if btn != sender {
                btn.isSelected = false
                btn.backgroundColor = UIColor.white
                btn.layer.borderColor = UIColor.lightGray.cgColor
            }
        }
        sender.isSelected = true
        sender.backgroundColor = UIColor.red
        sender.layer.borderColor = UIColor.red.cgColor
        if sender.tag == BtnTag.yuan.rawValue {
        }
        else if sender.tag == BtnTag.jiao.rawValue {
        }
        else if sender.tag == BtnTag.fen.rawValue {
        }
    }
    
    @objc private func btnAction(_ sender: UIButton) {
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (self.tfInput.text?.isEmpty)! {
            self.tfInput.text = "1"
        }
        else {
            var n = Int(self.tfInput.text!)
            if n! < 1 {
                n! = 1
            }
            else if n! > 9999 {
                n! = 9999
            }
            self.tfInput.text = String(n!)
        }
    }
    
}
