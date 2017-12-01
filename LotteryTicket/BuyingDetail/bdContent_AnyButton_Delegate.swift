//
//  bdContent_AnyButton_Delegate.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/30.
//  Copyright © 2017年 李诚. All rights reserved.
//

enum BtnType: Int {
    case SingleChoice = 100
    case Operation
    case Special
}

protocol bdContent_AnyButton_Delegate: class {
    func dRunCalculate()
}
