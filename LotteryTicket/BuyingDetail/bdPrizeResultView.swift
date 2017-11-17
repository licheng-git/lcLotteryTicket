//
//  bdPrizeResultView.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/13.
//  Copyright © 2017年 李诚. All rights reserved.
//

class bdPrizeResultView: UIView {
    
    static let headerHeight: CGFloat = 70
    
    lazy var lbPeriodNum: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .left
        lb.font = UIFont.systemFont(ofSize: 16)
        return lb
    } ()
    
    lazy var bgResultView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    } ()
    
    lazy var imgviewArrow: UIImageView = {
        let imgview = UIImageView()
        imgview.image = UIImage(named: "arrow_right")
        return imgview
    } ()
    
    var cToggle: ((_ bIsShowing:Bool)->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        self.addSubview(self.lbPeriodNum)
        self.lbPeriodNum.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(21)
            make.right.equalToSuperview().offset(-50)
        }
        self.addSubview(self.bgResultView)
        self.bgResultView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.lbPeriodNum)
            make.top.equalTo(self.lbPeriodNum.snp.bottom)
            make.bottom.equalToSuperview()
        }
        self.addSubview(self.imgviewArrow)
        self.imgviewArrow.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(7.5)
            make.height.equalTo(13.5)
        }
        let lineview = UIView()
        lineview.backgroundColor = UIColor.lightGray
        self.addSubview(lineview)
        lineview.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func fSetResult(_ strResult:String) {
        //print("func \(self.bgResultView.frame)")  // .zero
        self.layoutIfNeeded()
        //print("func self.layoutIfNeed() \(self.bgResultView.frame)")  // 正常
        for v in self.bgResultView.subviews {
            v.removeFromSuperview()
        }
        let arrChars = Array(strResult)
        let w: CGFloat = 30
        for i in 0..<arrChars.count {
            let c = arrChars[i]
            let strC = String(c)
            let btn = UIButton()
            btn.setTitle(strC, for: .normal)
            btn.setTitleColor(UIColor.white, for: .normal)
            btn.setBackgroundImage(UIImage(named: "bgRound"), for: .normal)
            btn.setBackgroundImage(UIImage(named: "bgRound"), for: .disabled)
            btn.isEnabled = false
            self.bgResultView.addSubview(btn)
            btn.frame = CGRect(x: (w+5)*CGFloat(i), y: 5, width: w, height: w)
        }
    }
    
    private var bIsShowing = false
    @objc private func tapAction(_ sender:UITapGestureRecognizer) {
        self.bIsShowing = !self.bIsShowing
        if self.bIsShowing {
            UIView.animate(withDuration: 0.5, animations: {
                self.imgviewArrow.transform = CGAffineTransform(rotationAngle: .pi*0.5)
            })
        }
        else {
            UIView.animate(withDuration: 0.5, animations: {
                self.imgviewArrow.transform = CGAffineTransform(rotationAngle: 0)
            })
        }
        if self.cToggle != nil {
            self.cToggle!(self.bIsShowing)
        }
    }
    
}
