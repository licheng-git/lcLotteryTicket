//
//  DealRecords_ViewModel.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/9.
//  Copyright © 2017年 李诚. All rights reserved.
//


class DealRecords_Model: NSObject {
    var title: String?
    var time: String?
    var amount: String?
}


class DealRecords_ViewModel {
    
    var arrModel = [DealRecords_Model]()
    
    func getData(_ selectType:Int, _ pageIndex:Int, _ cComplete:(_ arrModels:[DealRecords_Model])->Void) {
        self.arrModel.removeAll()
        var arrData = [Any]()
        if selectType == 0 {
            arrData = [ ["title":"注单资金扣除", "time":"2017-11-01 14:00:00", "amount":"-0.04"],
                        ["title":"注单派彩", "time":"2017-11-01 14:00:00", "amount":"1.00"],
                        ["title":"注单资金扣除", "time":"2017-11-01 14:00:00", "amount":"-1000.04"],
                        ["title":"注单派彩", "time":"2017-11-01 14:00:00", "amount":"1000.50"] ]
        }
        else if selectType == 1 {
            arrData = [ ["title":"注单资金扣除", "time":"2017-11-01 14:00:00", "amount":"-0.04"],
                        ["title":"注单资金扣除", "time":"2017-11-01 14:00:00", "amount":"-1000.04"] ]
        }
        else if selectType == 2 {
            arrData = [ ["title":"注单派彩", "time":"2017-11-01 14:00:00", "amount":"1.00"],
                        ["title":"注单派彩", "time":"2017-11-01 14:00:00", "amount":"1000.50"] ]
        }
        for anyItem in arrData {
            let dictItem = anyItem as! [String:String]
            let model = DealRecords_Model()
            model.title = dictItem["title"]
            model.time = dictItem["time"]
            model.amount = dictItem["amount"]
            self.arrModel.append(model)
        }
        cComplete(self.arrModel)
    }
    
}
