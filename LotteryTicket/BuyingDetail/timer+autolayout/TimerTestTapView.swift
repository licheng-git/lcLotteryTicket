//
//  TimerTestTapView.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/14.
//  Copyright © 2017年 李诚. All rights reserved.
//

class TimerTestTapView: UIView {
    
    lazy var imgviewArrow: UIImageView = {
        let imgview = UIImageView()
        imgview.image = UIImage(named: "arrow_right")
        return imgview
    } ()
    
    var cToggle: ((_ bIsShowing:Bool)->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.imgviewArrow)
        self.imgviewArrow.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(7.5)
            make.height.equalTo(13.5)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var bIsShowing = false
    @objc private func tapAction(_ sender:UITapGestureRecognizer) {
        self.bIsShowing = !self.bIsShowing
        if self.cToggle != nil {
            self.cToggle!(self.bIsShowing)
        }
    }
    
}
