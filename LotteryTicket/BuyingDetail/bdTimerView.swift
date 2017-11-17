//
//  bdTimerView.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/13.
//  Copyright © 2017年 李诚. All rights reserved.
//

class bdTimerView: UIView {
    
    static let Height:CGFloat = 65
    
    lazy var lbTitle: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .left
        lb.font = UIFont.systemFont(ofSize: 18)
        return lb
    } ()
    
    lazy var lbPeriodNum: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .left
        lb.font = UIFont.systemFont(ofSize: 16)
        return lb
    } ()
    
    lazy var lbHours: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 16)
        lb.textColor = UIColor.white
        lb.text = "00"
        return lb
    } ()
    
    lazy var lbMinutes: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 16)
        lb.textColor = UIColor.white
        lb.text = "00"
        return lb
    } ()
    
    lazy var lbSeconds: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 16)
        lb.textColor = UIColor.white
        lb.text = "00"
        return lb
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        
        self.addSubview(self.lbTitle)
        self.lbTitle.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalTo(self.snp.centerX)
            make.height.equalTo(21)
            make.bottom.equalTo(self.snp.centerY).offset(-3)
        }
        
        self.addSubview(self.lbPeriodNum)
        self.lbPeriodNum.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.lbTitle)
            make.height.equalTo(21)
            make.top.equalTo(self.snp.centerY).offset(3)
        }
        
        let lbTimerDesc = UILabel()
        lbTimerDesc.text = "距离截止下注"
        lbTimerDesc.textAlignment = .center
        lbTimerDesc.font = UIFont.systemFont(ofSize: 16)
        self.addSubview(lbTimerDesc)
        lbTimerDesc.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.centerX)
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(5)
            make.height.equalTo(21)
        }
        
        let bgView_lbMinutes = UIView()
        bgView_lbMinutes.backgroundColor = UIColor.gray
        bgView_lbMinutes.layer.cornerRadius = 5
        self.addSubview(bgView_lbMinutes)
        bgView_lbMinutes.snp.makeConstraints { (make) in
            make.centerX.equalTo(lbTimerDesc)
            make.bottom.equalToSuperview().offset(-5)
            make.top.equalTo(lbTimerDesc.snp.bottom).offset(5)
            make.width.equalTo(30)
        }
        bgView_lbMinutes.addSubview(self.lbMinutes)
        self.lbMinutes.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        let lbSeparator_left = UILabel()
        lbSeparator_left.text = ":"
        lbSeparator_left.textAlignment = .center
        self.addSubview(lbSeparator_left)
        lbSeparator_left.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.lbMinutes)
            make.width.equalTo(10)
            make.right.equalTo(self.lbMinutes.snp.left)
        }
        let lbSeparator_right = UILabel()
        lbSeparator_right.text = ":"
        lbSeparator_right.textAlignment = .center
        self.addSubview(lbSeparator_right)
        lbSeparator_right.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.lbMinutes)
            make.width.equalTo(10)
            make.left.equalTo(self.lbMinutes.snp.right)
        }
        
        let bgView_lbHours = UIView()
        bgView_lbHours.backgroundColor = UIColor.gray
        bgView_lbHours.layer.cornerRadius = 5
        self.addSubview(bgView_lbHours)
        bgView_lbHours.snp.makeConstraints { (make) in
            make.top.bottom.width.equalTo(self.lbMinutes)
            make.right.equalTo(lbSeparator_left.snp.left)
        }
        bgView_lbHours.addSubview(self.lbHours)
        self.lbHours.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        let bgView_lbSeconds = UIView()
        bgView_lbSeconds.backgroundColor = UIColor.gray
        bgView_lbSeconds.layer.cornerRadius = 5
        self.addSubview(bgView_lbSeconds)
        bgView_lbSeconds.snp.makeConstraints { (make) in
            make.top.bottom.width.equalTo(self.lbMinutes)
            make.left.equalTo(lbSeparator_right.snp.right)
        }
        bgView_lbSeconds.addSubview(self.lbSeconds)
        self.lbSeconds.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        let lineview_centerY = UIView()
        lineview_centerY.backgroundColor = UIColor.lightGray
        self.addSubview(lineview_centerY)
        lineview_centerY.snp.makeConstraints { (make) in
            make.width.equalTo(1)
            make.centerX.top.bottom.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private var timer: Timer?
    private var remainSeconds: Int = 0
    
    var cCountToZero: ((_ currentPeriodNum: String)->Void)?
    
    func startTimer(_ totalSeconds: Int) {
        self.remainSeconds = totalSeconds
        self.stopTimer()
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction(_:)), userInfo: nil, repeats: true)
        RunLoop.current.add(self.timer!, forMode: .commonModes)
        self.timer?.fire()
    }
    
    @objc private func timerAction(_ t:Timer) {
        print("BuyingDetail.timerAction \(self.remainSeconds)")
        let arr = self.timeConvert(self.remainSeconds)
        self.lbHours.text = arr[0]
        self.lbMinutes.text = arr[1]
        self.lbSeconds.text = arr[2]
        self.remainSeconds -= 1
        if self.remainSeconds < 0 {
            self.stopTimer()
            if self.cCountToZero != nil {
                self.cCountToZero!(self.lbPeriodNum.text!)
            }
        }
    }
    
    private func timeConvert(_ t:Int) -> Array<String> {
        let h:Int = (t/(60*60))%60
        let m:Int = (t/60)%60
        let s:Int = t%60
        let arr = [ String.init(format: "%02d", h),
                    String(format: "%02d", m),
                    String(format: "%02d", s) ]
        return arr
    }
    
    func stopTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    deinit {
        print("bdTimerView deinit")
    }
    
}
