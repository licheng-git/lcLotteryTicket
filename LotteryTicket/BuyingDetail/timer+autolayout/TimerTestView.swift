//
//  TimerTestView.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/14.
//  Copyright © 2017年 李诚. All rights reserved.
//

class TimerTestView: UIView {
    
    lazy var lbTest: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 16)
        lb.text = "00"
        lb.textColor = UIColor.red
        return lb
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.lightGray
        
        self.addSubview(self.lbTest)
        self.lbTest.snp.makeConstraints { (make) in
            make.left.right.centerY.equalToSuperview()
            make.height.equalTo(21)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private var timer: Timer?
    private var remainSeconds: Int = 0
    
    func startTimer(_ totalSeconds: Int) {
        self.remainSeconds = totalSeconds
        self.stopTimer()
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction(_:)), userInfo: nil, repeats: true)
        RunLoop.current.add(self.timer!, forMode: .commonModes)
        self.timer?.fire()
    }
    
    @objc private func timerAction(_ t:Timer) {
        print("TestTimerView.timerAction \(self.remainSeconds)")
        self.lbTest.text = String(self.remainSeconds)  // *_*  autolayout err, frame ok
        self.remainSeconds -= 1
        if self.remainSeconds < 0 {
            self.stopTimer()
        }
    }
    
    func stopTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    deinit {
        print("TestTimerView deinit")
    }
    
}
