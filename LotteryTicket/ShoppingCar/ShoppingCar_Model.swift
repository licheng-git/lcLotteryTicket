//
//  ShoppingCar_Model.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/28.
//  Copyright © 2017年 李诚. All rights reserved.
//

class ShoppingCar_Cell_Model {
    var playId: String?
    var playPid: String?
    var name: String?
    var dictCodeChosen: [String:[Any]]?
    var arrModelArea: [bdContent_Area_Model]?
    var bettingNumber: Int?      // x 注
    var bettingUnit: String?     // 2元／2角／2分
    var bettingMultiple: Int?    // x 倍
    var bettingAmount: Float?    // = xxx元
}
