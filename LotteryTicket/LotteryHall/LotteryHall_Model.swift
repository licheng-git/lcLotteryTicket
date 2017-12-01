//
//  LotteryHall_Model.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/21.
//  Copyright © 2017年 李诚. All rights reserved.
//

class LotteryHall_Cell_Model: NSObject {
    var id: String?
    var pid: String?
    var iconImgName: String?
    var name: String?
}

class LotteryHall_Model: NSObject {
    var category: String?
    var arrCellModels: Array<LotteryHall_Cell_Model>?
}
