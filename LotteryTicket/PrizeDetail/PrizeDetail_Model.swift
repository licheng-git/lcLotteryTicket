//
//  PrizeDetail_Model.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/16.
//  Copyright © 2017年 李诚. All rights reserved.
//

class PrizeDetail_Cell_Model {
    var playType: String?
    var bettingMode: String?
    var arrPrizes: Array<String>?
}

class PrizeDetail_Model {
    var title: String?
    var arrCellModel: [PrizeDetail_Cell_Model]?
}
