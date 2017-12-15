//
//  UserInfo.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/12/11.
//  Copyright © 2017年 李诚. All rights reserved.
//

class UserInfo {
    static let sharedInstance = UserInfo()
    private init() {}
    
    var token     = String()
    var userName  = String()
    //var ownerName = String()
    
    var strBalance = "0.000"
    var intBalance = 0 {
        didSet {
            let f = Float(self.intBalance)/Float(1000)
            self.strBalance = String(format: "%0.3f", f)
        }
    }
}
