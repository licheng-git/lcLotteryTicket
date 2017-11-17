//
//  bdNavRight_TableCell.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/13.
//  Copyright © 2017年 李诚. All rights reserved.
//

class bdNavRight_TableCell: UITableViewCell {
    
    static let cHeight: CGFloat = 60
    
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
    
    let lineView_FristCell_Top: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.lightGray
        lineView.isHidden = true
        return lineView
    } ()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        self.addSubview(self.imgviewIcon)
        self.imgviewIcon.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(30)
        }
        
        self.addSubview(self.lbName)
        self.lbName.snp.makeConstraints { (make) in
            make.left.equalTo(self.imgviewIcon.snp.right).offset(10)
            make.centerY.equalToSuperview()
            make.height.equalTo(21)
            make.right.equalToSuperview().offset(-10)
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
    
}
