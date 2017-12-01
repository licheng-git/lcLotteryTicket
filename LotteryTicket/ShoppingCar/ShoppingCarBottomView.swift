//
//  ShoppingCarBottomView.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/29.
//  Copyright © 2017年 李诚. All rights reserved.
//

class ShoppingCarBottomView: UIView {
    
    let lbTotal: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .left
        lb.font = UIFont.systemFont(ofSize: 16)
        //lb.text = "共 x 注， xxxx 元"
        let attrText = NSMutableAttributedString(string: "共 ")
        attrText.append(NSAttributedString(string: "--", attributes: [NSForegroundColorAttributeName:UIColor.red]))
        attrText.append(NSAttributedString(string: " 注， "))
        attrText.append(NSAttributedString(string: "--", attributes: [NSForegroundColorAttributeName:UIColor.red]))
        attrText.append(NSAttributedString(string: " 元"))
        lb.attributedText = attrText
        return lb
    } ()
    
    lazy var btnBetting: UIButton = {
        let btn = UIButton()
        btn.setTitle("立即下注", for: .normal)
        btn.backgroundColor = UIColor.red
        btn.titleLabel?.textColor = UIColor.white
        btn.addTarget(self, action: #selector(btnAction_Betting(_:)), for: .touchUpInside)
        return btn
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.addSubview(self.btnBetting)
        self.btnBetting.snp.makeConstraints { (make) in
            make.top.bottom.right.equalToSuperview()
            make.width.equalTo(100)
        }
        self.addSubview(self.lbTotal)
        self.lbTotal.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.height.equalTo(21)
            make.right.equalTo(self.btnBetting.snp.left)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var cBtnAction_Betting:(()->())?
    
    @objc private func btnAction_Betting(_ sender: UIButton) {
        if self.cBtnAction_Betting != nil {
            self.cBtnAction_Betting!()
        }
    }
    
    func fSetTotal(_ numbers: Int, _ amount: Float) {
        let attrText = NSMutableAttributedString(string: "共 ")
        attrText.append(NSAttributedString(string: String(numbers), attributes: [NSForegroundColorAttributeName:UIColor.red]))
        attrText.append(NSAttributedString(string: " 注， "))
        attrText.append(NSAttributedString(string: String(format: "%0.3f", amount), attributes: [NSForegroundColorAttributeName:UIColor.red]))
        attrText.append(NSAttributedString(string: " 元"))
        self.lbTotal.attributedText = attrText
    }
    
}
