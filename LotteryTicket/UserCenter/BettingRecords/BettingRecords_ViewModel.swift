//
//  BettingRecords_ViewModel.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/9.
//  Copyright © 2017年 李诚. All rights reserved.
//


class BettingRecords_Model: NSObject {
    var title: String?
    var time: String?
}


class BettingRecords_ViewModel {
    
    var arrModel = [BettingRecords_Model]()
    
    func getData(_ selectType:Int, _ pageIndex:Int, _ cComplete:(_ arrModels:[BettingRecords_Model])->Void) {
        self.arrModel.removeAll()
        var arrData = [Any]()
        if selectType == 0 {
            arrData = [ ["title":"极速时时彩-定位胆", "time":"2017-11-01 14:00:00"],
                        ["title":"极速时时彩-五星", "time":"2017-11-01 14:00:00"],
                        ["title":"极速时时彩-任选", "time":"2017-11-01 14:00:00"] ]
        }
        else if selectType == 1 {
            arrData = [ ["title":"好运11选5-定位胆", "time":"2017-11-01 14:00:00"],
                        ["title":"极速快三-定位胆", "time":"2017-11-01 14:00:00"] ]
        }
        else if selectType == 2 {
            arrData = [ ["title":"极速飞车-定位胆", "time":"2017-11-01 14:00:00"],
                        ["title":"极速六合彩-定位胆", "time":"2017-11-01 14:00:00"] ]
        }
        for anyItem in arrData {
            let dictItem = anyItem as! [String:String]
            let model = BettingRecords_Model()
            model.title = dictItem["title"]
            model.time = dictItem["time"]
            self.arrModel.append(model)
        }
        cComplete(self.arrModel)
    }
    
}
