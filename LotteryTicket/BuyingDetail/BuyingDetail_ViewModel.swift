//
//  BuyingDetail_ViewModel.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/13.
//  Copyright © 2017年 李诚. All rights reserved.
//

class bdNavRightTable_Cell_Model: NSObject {
    var iconImgName: String?
    var name: String?
}

class bdPrizeResult_Cell_Model: NSObject {
    var periodNum: String?
    var prizeNum: String?
}


class BuyingDetail_ViewModel {
    
    var arrModel_NavRightTable = [bdNavRightTable_Cell_Model]()
    
    func getData_NavRightTable(_ cComplete:(_ arrModels:[bdNavRightTable_Cell_Model])->Void) {
        self.arrModel_NavRightTable.removeAll()
        let arrData = [ ["text":"极速时时彩", "img":"icon_ssc"],
                        ["text":"卡司时时彩", "img":"icon_ssc"],
                        ["text":"重庆时时彩", "img":"icon_ssc"],
                        ["text":"天津时时彩", "img":"icon_ssc"],
                        ["text":"新疆时时彩", "img":"icon_ssc"],
                        ["text":"极速飞车", "img":"icon_pk10"],
                        ["text":"卡司PK10", "img":"icon_pk10"],
                        ["text":"北京PK10", "img":"icon_pk10"],
                        ["text":"好运11选5", "img":"icon_11x5"],
                        ["text":"卡司11选5", "img":"icon_11x5"],
                        ["text":"广东11选5", "img":"icon_11x5"],
                        ["text":"江西11选5", "img":"icon_11x5"],
                        ["text":"江苏11选5", "img":"icon_11x5"],
                        ["text":"山东11选5", "img":"icon_11x5"],
                        ["text":"极速快三", "img":"icon_k3"],
                        ["text":"卡司快三", "img":"icon_k3"],
                        ["text":"江苏快3", "img":"icon_k3"],
                        ["text":"湖北快3", "img":"icon_k3"],
                        ["text":"安徽快3", "img":"icon_k3"],
                        ["text":"福彩3D", "img":"icon_3d"],
                        ["text":"排列5", "img":"icon_pl5"],
                        ["text":"极速六合彩", "img":"icon_lhc"],
                        ["text":"卡司六合彩", "img":"icon_lhc"] ]
        for dictItem in arrData {
            let model = bdNavRightTable_Cell_Model()
            model.iconImgName = dictItem["img"]
            model.name = dictItem["text"]
            self.arrModel_NavRightTable.append(model)
        }
        cComplete(self.arrModel_NavRightTable)
    }
    
    
    var arrModel_PrizeResultTable = [bdPrizeResult_Cell_Model]()
    
    func getData_PrizeResultTable(_ cComplete:(_ arrModels:[bdPrizeResult_Cell_Model])->Void) {
        self.arrModel_PrizeResultTable.removeAll()
        let arrData = [ ["periodNum":"130529", "prizeNum":"72634"],
                        ["periodNum":"130528", "prizeNum":"0"],
                        ["periodNum":"130527", "prizeNum":"0123456789"],
                        ["periodNum":"130526", "prizeNum":"123"],
                        ["periodNum":"130525", "prizeNum":""] ]
        for dictItem in arrData {
            let model = bdPrizeResult_Cell_Model()
            model.periodNum = dictItem["periodNum"]
            //model.prizeNum = dictItem["prizeNum"]
            let arrChars = Array(dictItem["prizeNum"]!)
            var tempPrizeNum = " "
            for i in 0..<arrChars.count {
                let c = arrChars[i]
                tempPrizeNum += String(c) + " "
            }
            model.prizeNum = tempPrizeNum
            self.arrModel_PrizeResultTable.append(model)
        }
        cComplete(self.arrModel_PrizeResultTable)
    }
    
}
