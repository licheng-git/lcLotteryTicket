//
//  TimerTestViewController.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/14.
//  Copyright © 2017年 李诚. All rights reserved.
//

import UIKit

class TimerTestViewController: UIViewController {
    
    let timerView: TimerTestView = {
        let view = TimerTestView()
        return view
    } ()
    
    let tapView: TimerTestTapView = {
        let view = TimerTestTapView()
        view.backgroundColor = UIColor.green
        return view
    } ()
    
    let movingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.orange
        return view
    } ()
    
    let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.yellow
        return view
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "timer+autolayout"
        self.addDefaultBackNavItem()
        //self.automaticallyAdjustsScrollViewInsets = false
        
        
//        // err
//        self.view.addSubview(self.timerView)
//        self.timerView.snp.makeConstraints { (make) in
//            make.top.equalToSuperview().offset(kDEFAULT_MARGIN_Y)
//            make.left.right.equalToSuperview()
//            make.height.equalTo(50)
//        }
//        self.view.addSubview(self.tapView)
//        self.tapView.snp.makeConstraints { (make) in
//            make.top.equalTo(self.timerView.snp.bottom)
//            make.left.right.equalToSuperview()
//            make.height.equalTo(100)
//        }
//        self.view.addSubview(self.movingView)
//        self.movingView.snp.makeConstraints { (make) in
//            make.top.equalTo(self.tapView.snp.bottom)
//            make.left.right.equalToSuperview()
//            make.height.equalTo(100)
//        }
//        self.view.addSubview(self.bottomView)
//        self.bottomView.snp.makeConstraints { (make) in
//            make.bottom.left.right.equalToSuperview()
//            make.height.equalTo(50)
//        }
        
//        // ok
//        self.timerView.frame = CGRect(x: 0, y: kDEFAULT_MARGIN_Y, width: kSCREEN_WIDTH, height: 50)
//        self.view.addSubview(self.timerView)
//        self.tapView.frame = CGRect(x: 0, y: self.timerView.frame.maxY, width: kSCREEN_WIDTH, height: 100)
//        self.view.addSubview(self.tapView)
//        self.movingView.frame = CGRect(x: 0, y: self.tapView.frame.maxY, width: kSCREEN_WIDTH, height: 100)
//        self.view.addSubview(self.movingView)
//        self.bottomView.frame = CGRect(x: 0, y: kSCREEN_HEIGHT-50, width: kSCREEN_WIDTH, height: 50)
//        self.view.addSubview(self.bottomView)
        
        // good
        self.view.addSubview(self.timerView)
        self.timerView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kDEFAULT_MARGIN_Y)
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        self.view.addSubview(self.tapView)
        self.tapView.snp.makeConstraints { (make) in
            make.top.equalTo(self.timerView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(100)
        }
        self.view.layoutIfNeeded()
        //print(self.tapView.frame.maxY)  // good
        self.movingView.frame = CGRect(x: 0, y: self.tapView.frame.maxY, width: kSCREEN_WIDTH, height: 100)
        self.view.addSubview(self.movingView)
        self.view.addSubview(self.bottomView)
        self.bottomView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        
        self.timerView.startTimer(100)
        
        self.tapView.cToggle = { [weak self] (bIsShowing) in
            if bIsShowing {
                UIView.animate(withDuration: 0.5, animations: {
                    //print(self?.tapView.frame)
                    self?.tapView.imgviewArrow.transform = CGAffineTransform(rotationAngle: .pi*0.5)
                    var tempFrame = self?.movingView.frame
                    tempFrame?.origin.y += 50
                    self?.movingView.frame = tempFrame!
                })
            }
            else {
                UIView.animate(withDuration: 0.5, animations: {
                    self?.tapView.imgviewArrow.transform = CGAffineTransform(rotationAngle: 0)
                    var tempFrame = self?.movingView.frame
                    tempFrame?.origin.y -= 50
                    self?.movingView.frame = tempFrame!
                })
            }
        }
        
    }
    
    deinit {
        print("TestTimerViewController deinit")
        self.timerView.stopTimer()
    }
    
}
