//
//  RegisterView.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/12/12.
//  Copyright © 2017年 李诚. All rights reserved.
//

import MBProgressHUD

//class RegisterView: UIScrollView {  // *_* 自动布局err
class RegisterView: UIView, UITextFieldDelegate {
    
    lazy var tfAccount: UITextField = {
        let tf = UITextField()
        tf.placeholder = "会员账号"
        tf.borderStyle = .roundedRect
        tf.textAlignment = .left
        tf.keyboardType = .asciiCapable
        tf.delegate = self
        return tf
    } ()
    
    lazy var tfPassword: UITextField = {
        let tf = UITextField()
        tf.placeholder = "会员密码"
        tf.borderStyle = .roundedRect
        tf.textAlignment = .left
        tf.keyboardType = .asciiCapable
        tf.isSecureTextEntry = true
        tf.delegate = self
        return tf
    } ()
    
    lazy var tfConfirmPassword: UITextField = {
        let tf = UITextField()
        tf.placeholder = "确认密码"
        tf.borderStyle = .roundedRect
        tf.textAlignment = .left
        tf.keyboardType = .asciiCapable
        tf.isSecureTextEntry = true
        tf.delegate = self
        return tf
    } ()
    
    let tfInvite: UITextField = {
        let tf = UITextField()
        tf.placeholder = "邀请码"
        tf.borderStyle = .roundedRect
        tf.textAlignment = .left
        tf.keyboardType = .asciiCapable
        return tf
    } ()
    
    lazy var tfValidate: UITextField = {
        let tf = UITextField()
        tf.placeholder = "验证码"
        tf.borderStyle = .roundedRect
        tf.textAlignment = .left
        tf.delegate = self
        tf.keyboardType = .asciiCapable
        return tf
    } ()
    
    lazy var imgviewValidate: UIImageView = {
        let imgveiw = UIImageView()
        imgveiw.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(gestureAction_ValidateTap(_:)))
        imgveiw.addGestureRecognizer(tapGesture)
        return imgveiw
    } ()
    
    let lbTip_Validate: UILabel = {
        let lb = UILabel()
        lb.text = "点击重获"
        lb.textAlignment = .center
        lb.textColor = .darkGray
        return lb
    } ()
    
    var lbTip:  UILabel?
    var lbTip1: UILabel?
    var lbTip2: UILabel?
    var lbTip3: UILabel?
    var lbTip_Invite: UILabel?
    
    var tfEmail:    UITextField?
    var tfMobile:   UITextField?
    var tfQQ:       UITextField?
    var tfRealName: UITextField?
    var lbTip_Email:    UILabel?
    var lbTip_Mobile:   UILabel?
    var lbTip_QQ:       UILabel?
    var lbTip_RealName: UILabel?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let imgviewIcon = UIImageView()
        imgviewIcon.image = UIImage(named: "AppIcon")
        self.addSubview(imgviewIcon)
        imgviewIcon.snp.makeConstraints { (make) in
            make.width.height.equalTo(100)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }
        self.addSubview(self.tfAccount)
        self.tfAccount.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(40)
            make.top.equalTo(imgviewIcon.snp.bottom).offset(20)
        }
        self.addSubview(self.tfPassword)
        self.tfPassword.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(self.tfAccount)
            make.top.equalTo(self.tfAccount.snp.bottom).offset(10)
        }
        self.addSubview(self.tfConfirmPassword)
        self.tfConfirmPassword.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(self.tfAccount)
            make.top.equalTo(self.tfPassword.snp.bottom).offset(10)
        }
        self.addSubview(self.tfInvite)
        self.tfInvite.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(self.tfAccount)
            make.top.equalTo(self.tfConfirmPassword.snp.bottom).offset(10)
        }
        self.addSubview(self.tfValidate)
        self.tfValidate.snp.makeConstraints { (make) in
            make.left.height.equalTo(self.tfAccount)
            make.right.equalTo(self.tfAccount).offset(-120)
            make.top.equalTo(self.tfInvite.snp.bottom).offset(10)
        }
        self.addSubview(self.imgviewValidate)
        self.imgviewValidate.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.tfValidate)
            make.left.equalTo(self.tfValidate.snp.right).offset(2)
            make.right.equalTo(self.tfAccount)
        }
        let btnRegister = UIButton()
        btnRegister.setTitle("提交注册", for: .normal)
        btnRegister.setTitleColor(.white, for: .normal)
        btnRegister.backgroundColor = .red
        btnRegister.addTarget(self, action: #selector(btnAction_Register(_:)), for: .touchUpInside)
        self.addSubview(btnRegister)
        btnRegister.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.tfAccount)
            make.height.equalTo(50)
            make.top.equalTo(self.tfValidate.snp.bottom).offset(20)
        }
        
        lbTip = UILabel()
        lbTip!.text = " * "
        lbTip!.textColor = .red
        self.addSubview(lbTip!)
        lbTip!.snp.makeConstraints { (make) in
            make.top.bottom.right.equalTo(self.tfAccount)
        }
        lbTip1 = lbTip!.extCopy_deep() as? UILabel
        self.addSubview(lbTip1!)
        lbTip1!.snp.makeConstraints { (make) in
            make.top.bottom.right.equalTo(self.tfPassword)
        }
        lbTip2 = lbTip!.extCopy_deep() as? UILabel
        self.addSubview(lbTip2!)
        lbTip2!.snp.makeConstraints { (make) in
            make.top.bottom.right.equalTo(self.tfConfirmPassword)
        }
        lbTip3 = lbTip!.extCopy_deep() as? UILabel
        self.addSubview(lbTip3!)
        lbTip3!.snp.makeConstraints { (make) in
            make.top.bottom.right.equalTo(self.tfValidate)
        }
        
        self.addSubview(self.lbTip_Validate)
        self.lbTip_Validate.snp.makeConstraints { (make) in
            make.height.equalTo(21)
            make.centerY.left.right.equalTo(self.imgviewValidate)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var scrollContentHeight: CGFloat = 0
    var model: RegisterModel? = nil {
        didSet {
            if model == nil {
                self.imgviewValidate.image = nil
                self.lbTip_Validate.isHidden = false
                return
            }
            self.imgviewValidate.image = model?.imgValidate
            self.lbTip_Validate.isHidden = true
            if model!.bInvite! && lbTip_Invite == nil {
                lbTip_Invite = lbTip!.extCopy_deep() as? UILabel
                self.addSubview(lbTip_Invite!)
                lbTip_Invite!.snp.makeConstraints { (make) in
                    make.top.bottom.right.equalTo(self.tfInvite)
                }
            }
            if model!.bEmail! && tfEmail == nil {
                tfEmail = tfAccount.extCopy_deep() as? UITextField
                tfEmail?.placeholder = "邮箱"
                tfEmail?.keyboardType = .emailAddress
                self.addSubview(tfEmail!)
                if model!.bEmail_Required! && lbTip_Email == nil {
                    lbTip_Email = lbTip!.extCopy_deep() as? UILabel
                    self.addSubview(lbTip_Email!)
                }
            }
            if model!.bMobile! && tfMobile == nil {
                tfMobile = tfAccount.extCopy_deep() as? UITextField
                tfMobile?.placeholder = "手机号"
                tfMobile?.keyboardType = .numberPad
                self.addSubview(tfMobile!)
                if model!.bMobile_Required! && lbTip_Mobile == nil {
                    lbTip_Mobile = lbTip!.extCopy_deep() as? UILabel
                    self.addSubview(lbTip_Mobile!)
                }
            }
            if model!.bQQ! && tfQQ == nil {
                tfQQ = tfAccount.extCopy_deep() as? UITextField
                tfQQ?.placeholder = "QQ号"
                tfQQ?.keyboardType = .numberPad
                self.addSubview(tfQQ!)
                if model!.bQQ_Required! && lbTip_QQ == nil {
                    lbTip_QQ = lbTip!.extCopy_deep() as? UILabel
                    self.addSubview(lbTip_QQ!)
                }
            }
            if model!.bRealName! && tfRealName == nil {
                tfRealName = tfAccount.extCopy_deep() as? UITextField
                tfRealName?.placeholder = "真实姓名"
                //tfRealName?.keyboardType = .default
                self.addSubview(tfRealName!)
                if model!.bRealName_Required! && lbTip_RealName == nil {
                    lbTip_RealName = lbTip!.extCopy_deep() as? UILabel
                    self.addSubview(lbTip_RealName!)
                }
            }
        }
    }
    
    
    var cValidateTap: (()->Void)?
    
    @objc private func gestureAction_ValidateTap(_ sender:UITapGestureRecognizer) {
        if self.cValidateTap != nil {
            self.cValidateTap!()
        }
    }
    
    var cRegister: (()->Void)?
    
    @objc private func btnAction_Register(_ sender:UIButton) {
        var bCorrect = true
        var msg = String()
        if self.tfAccount.text == nil || self.tfAccount.text!.isEmpty {
            bCorrect = false
            msg = "账号不能为空"
        }
        else if self.tfPassword.text == nil || self.tfPassword.text!.isEmpty {
            bCorrect = false
            msg = "密码不能为空"
        }
        else if self.tfConfirmPassword.text == nil || self.tfConfirmPassword.text!.isEmpty {
            bCorrect = false
            msg = "确认密码不能为空"
        }
        else if (model != nil && model!.bInvite!) && (self.tfInvite.text == nil || self.tfInvite.text!.isEmpty) {
            bCorrect = false
            msg = "邀请码不能为空"
        }
        else if self.tfValidate.text == nil || self.tfValidate.text!.isEmpty {
            bCorrect = false
            msg = "验证码不能为空"
        }
        else if self.tfPassword.text != self.tfConfirmPassword.text {
            bCorrect = false
            msg = "两次输入的密码不一样"
        }
        else if self.tfPassword.text!.characters.count < 6 {
            bCorrect = false
            msg = "密码为不小于6位的任意字符"
        }
        if bCorrect {
            let regStr_Account = "^[a-zA-Z0-9]{6,}$";
            let predicate = NSPredicate(format: "SELF MATCHES %@", regStr_Account)
            let bValidate_Account = predicate.evaluate(with: self.tfAccount.text!)
            if !bValidate_Account {
                bCorrect = false
                msg = "账号为不小于6位的数字或英文字符"
            }
        }
        if !bCorrect {
            let hud = MBProgressHUD.showAdded(to: self, animated: true)
            hud.mode = .text
            hud.detailsLabel.text = msg
            hud.backgroundView.backgroundColor = UIColor.black
            hud.backgroundView.alpha = 0.5
            hud.hide(animated: true, afterDelay: 1.0)
            return
        }
        if self.cRegister != nil {
            self.cRegister!()
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if self.tfAccount.text != nil && !self.tfAccount.text!.isEmpty {
            lbTip!.isHidden = true
        }
        else {
            lbTip!.isHidden = false
        }
        if self.tfPassword.text != nil && !self.tfPassword.text!.isEmpty {
            lbTip1!.isHidden = true
        }
        else {
            lbTip1!.isHidden = false
        }
        if self.tfConfirmPassword.text != nil && !self.tfConfirmPassword.text!.isEmpty {
            lbTip2!.isHidden = true
        }
        else {
            lbTip2!.isHidden = false
        }
        if self.tfValidate.text != nil && !self.tfValidate.text!.isEmpty {
            lbTip3!.isHidden = true
        }
        else {
            lbTip3!.isHidden = false
        }
        if model != nil && model!.bInvite! && lbTip_Invite != nil {
            if self.tfInvite.text != nil && !self.tfInvite.text!.isEmpty {
                lbTip_Invite?.isHidden = true
            }
            else {
                lbTip_Invite?.isHidden = false
            }
        }
    }
    
}
