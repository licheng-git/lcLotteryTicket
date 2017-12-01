//
//  BuyingHall_Model.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/1.
//  Copyright © 2017年 李诚. All rights reserved.
//


class BuyingHall_Cell_Model: NSObject {
    var id: String?
    var pid: String?
    var iconImgName: String?
    var name: String?
    var desc: String?
    var time_int: Int?
    var time_string: String?
}

class BuyingHall_Model: NSObject {
    var title: String?
    var arrCellModel: [BuyingHall_Cell_Model]?
}
