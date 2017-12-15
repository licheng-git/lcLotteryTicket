//
//  LoginView.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/12/11.
//  Copyright © 2017年 李诚. All rights reserved.
//

import MBProgressHUD

class LoginView: UIView, UITextFieldDelegate {
    
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
    
    lazy var tfValidate: UITextField = {
        let tf = UITextField()
        tf.placeholder = "验证码"
        tf.borderStyle = .roundedRect
        tf.textAlignment = .left
        tf.keyboardType = .asciiCapable
        tf.delegate = self
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
    
    var lbTip: UILabel?
    var lbTip1: UILabel?
    var lbTip2: UILabel?
    
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
        self.addSubview(self.tfValidate)
        self.tfValidate.snp.makeConstraints { (make) in
            make.left.height.equalTo(self.tfAccount)
            make.right.equalTo(self.tfAccount).offset(-120)
            make.top.equalTo(self.tfPassword.snp.bottom).offset(10)
        }
        self.addSubview(self.imgviewValidate)
        self.imgviewValidate.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.tfValidate)
            make.left.equalTo(self.tfValidate.snp.right).offset(2)
            make.right.equalTo(self.tfAccount)
        }
//        let btnForgetPassword = UIButton()
//        btnForgetPassword.setTitle("忘记密码？", for: .normal)
//        btnForgetPassword.setTitleColor(.darkGray, for: .normal)
//        btnForgetPassword.backgroundColor = .clear
//        btnForgetPassword.addTarget(self, action: #selector(btnAction_ForgetPassword(_:)), for: .touchUpInside)
//        self.addSubview(btnForgetPassword)
//        btnForgetPassword.snp.makeConstraints { (make) in
//            make.width.equalTo(90)
//            make.height.equalTo(40)
//            make.top.equalTo(self.tfValidate.snp.bottom).offset(10)
//            make.right.equalTo(self.tfAccount)
//        }
        let btnLogin = UIButton()
        btnLogin.setTitle("提交登录", for: .normal)
        btnLogin.setTitleColor(.white, for: .normal)
        btnLogin.backgroundColor = .red
        btnLogin.addTarget(self, action: #selector(btnAction_Login(_:)), for: .touchUpInside)
        self.addSubview(btnLogin)
        btnLogin.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.tfAccount)
            make.height.equalTo(50)
//            make.top.equalTo(btnForgetPassword.snp.bottom).offset(20)
            make.top.equalTo(self.tfValidate.snp.bottom).offset(20)
        }
        
        lbTip = UILabel()
        lbTip!.text = " * "
        lbTip!.textColor = .red
        self.addSubview(lbTip!)
        lbTip!.snp.makeConstraints { (make) in
            make.height.equalTo(21)
            make.centerY.right.equalTo(self.tfAccount)
        }
        lbTip1 = lbTip!.extCopy_deep() as? UILabel
        self.addSubview(lbTip1!)
        lbTip1!.snp.makeConstraints { (make) in
            make.height.equalTo(21)
            make.centerY.right.equalTo(self.tfPassword)
        }
        lbTip2 = lbTip!.extCopy_deep() as? UILabel
        self.addSubview(lbTip2!)
        lbTip2!.snp.makeConstraints { (make) in
            make.height.equalTo(21)
            make.centerY.right.equalTo(self.tfValidate)
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
    
    
    //var cValidateTap: (()->UIImage)?
    var cValidateTap: (()->Void)?
    
    @objc private func gestureAction_ValidateTap(_ sender:UITapGestureRecognizer) {
        if self.cValidateTap != nil {
            //let img = self.cValidateTap!()
            //self.imgviewValidate.image = img
            self.cValidateTap!()
        }
    }
    
//    var cForgetPassword: (()->Void)?
//
//    @objc private func btnAction_ForgetPassword(_ sender:UIButton) {
//        if self.cForgetPassword != nil {
//            self.cForgetPassword!()
//        }
//    }
    
    var cLogin: (()->Void)?
    
    @objc private func btnAction_Login(_ sender:UIButton) {
        var bFinished = true
        var msg = String()
        if self.tfAccount.text == nil || self.tfAccount.text!.isEmpty {
            bFinished = false
            msg = "账号不能为空"
        }
        else if self.tfPassword.text == nil || self.tfPassword.text!.isEmpty {
            bFinished = false
            msg = "密码不能为空"
        }
        else if self.tfValidate.text == nil || self.tfValidate.text!.isEmpty {
            bFinished = false
            msg = "验证码不能为空"
        }
        if !bFinished {
            let hud = MBProgressHUD.showAdded(to: self, animated: true)
            hud.mode = .text
            hud.label.text = msg
            hud.backgroundView.backgroundColor = UIColor.black
            hud.backgroundView.alpha = 0.5
            hud.hide(animated: true, afterDelay: 1.0)
            return
        }
        if self.cLogin != nil {
            self.cLogin!()
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if self.tfAccount.text != nil && !self.tfAccount.text!.isEmpty {
            lbTip?.isHidden = true
        }
        else {
            lbTip?.isHidden = false
        }
        if self.tfPassword.text != nil && !self.tfPassword.text!.isEmpty {
            lbTip1?.isHidden = true
        }
        else {
            lbTip1?.isHidden = false
        }
        if self.tfValidate.text != nil && !self.tfValidate.text!.isEmpty {
            lbTip2?.isHidden = true
        }
        else {
            lbTip2?.isHidden = false
        }
    }
    
}
