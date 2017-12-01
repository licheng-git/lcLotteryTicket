//
//  ShoppingCar_TableCell.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/29.
//  Copyright © 2017年 李诚. All rights reserved.
//

class ShoppingCar_TableCell: UITableViewCell {
    
    static let scHeight: CGFloat = 80
    
    let lbName: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .left
        lb.font = UIFont.systemFont(ofSize: 16)
        return lb
    } ()
    
    let lbChoose: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .left
        lb.font = UIFont.systemFont(ofSize: 14)
        lb.textColor = UIColor.red
        return lb
    } ()
    
    let lbAmount: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .left
        lb.font = UIFont.systemFont(ofSize: 14)
        return lb
    } ()
    
//    lazy var btnDelete: UIButton = {
//        let btn = UIButton()
//        btn.setImage(UIImage(named: "bgRound"), for: .normal)
//        btn.addTarget(self, action: #selector(btnAction_Delete(_:)), for: .touchUpInside)
//        return btn
//    } ()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.addSubview(self.lbName)
        self.lbName.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(10)
//            make.right.equalToSuperview().offset(-40)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(21)
        }
        self.addSubview(self.lbChoose)
        self.lbChoose.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.lbName)
            make.top.equalTo(self.lbName.snp.bottom)
            make.height.equalTo(21)
        }
        self.addSubview(self.lbAmount)
        self.lbAmount.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.lbName)
            make.top.equalTo(self.lbChoose.snp.bottom)
            make.height.equalTo(21)
        }
//        self.addSubview(self.btnDelete)
//        self.btnDelete.snp.makeConstraints { (make) in
//            make.centerY.equalToSuperview()
//            make.right.equalToSuperview().offset(-10)
//            make.width.height.equalTo(20)
//        }
        let lineview = UIView()
        lineview.backgroundColor = UIColor.lightGray
        self.addSubview(lineview)
        lineview.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//    var cBtnAction_Delete:(()->())?
//
//    @objc private func btnAction_Delete(_ sender: UIButton) {
//    }
    
}
