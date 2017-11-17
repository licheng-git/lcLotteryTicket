//
//  BuyingHall_ViewModel.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/1.
//  Copyright © 2017年 李诚. All rights reserved.
//


class BuyingHall_ViewModel {
    
    var arrModels = Array<BuyingHall_Model>()
    
    func getData(_ selectType: Int, _ cComplete:((_ arrModels:[BuyingHall_Model])->Void)?) {
        self.arrModels.removeAll()
        var arrData = [Any]()
        if selectType == 0 {
            arrData = [ ["img":"icon_ssc", "name":"极速时时彩", "description":"距离1711010970期截止还有", "time":"0" ],
                        ["img":"icon_11x5", "name":"好运11选5", "description":"距离1711010971期截止还有", "time":"10" ],
                        ["img":"icon_k3", "name":"极速快三", "description":"距离1711010972期截止还有", "time":"80" ],
                        ["img":"icon_pk10", "name":"极速飞车", "description":"距离1711010973期截止还有", "time":"1000000" ] ]
        }
        else if selectType == 1 {
            arrData = [ ["img":"icon_ssc", "name":"极速时时彩", "description":"距离1711010970期截止还有", "time":"00" ],
                        ["img":"icon_ssc", "name":"天津时时彩", "description":"距离1711010971期截止还有", "time":"10" ],
                        ["img":"icon_ssc", "name":"重庆时时彩", "description":"距离1711010972期截止还有", "time":"20" ],
                        ["img":"icon_ssc", "name":"新疆时时彩", "description":"距离1711010973期截止还有", "time":"30" ] ]
        }
        else if selectType == 2 {
            arrData = [ ["img":"icon_11x5", "name":"好运11选5", "description":"距离1711010970期截止还有", "time":"00" ],
                        ["img":"icon_11x5", "name":"山东11选5", "description":"距离1711010971期截止还有", "time":"10" ],
                        ["img":"icon_11x5", "name":"江苏11选5", "description":"距离1711010972期截止还有", "time":"20" ],
                        ["img":"icon_11x5", "name":"江西11选5", "description":"距离1711010973期截止还有", "time":"30" ],
                        ["img":"icon_11x5", "name":"广东11选5", "description":"距离1711010974期截止还有", "time":"40" ] ]
        }
        else if selectType == 3 {
            arrData = [ ["img":"icon_k3", "name":"极速快三", "description":"距离1711010970期截止还有", "time":"00" ],
                        ["img":"icon_k3", "name":"湖北快3", "description":"距离1711010971期截止还有", "time":"10" ],
                        ["img":"icon_k3", "name":"安徽快3", "description":"距离1711010972期截止还有", "time":"20" ],
                        ["img":"icon_k3", "name":"江苏快3", "description":"距离1711010973期截止还有", "time":"30" ] ]
        }
        else if selectType == 4 {
            arrData = [ ["img":"icon_3d", "name":"福彩3D", "description":"距离1711010970期截止还有", "time":"00" ]]
        }
        else if selectType == 5 {
            arrData = [ ["img":"icon_pl5", "name":"排列5", "description":"距离1711010970期截止还有", "time":"00" ]]
        }
        else if selectType == 6 {
            arrData = [ ["img":"icon_pk10", "name":"极速飞车", "description":"距离1711010970期截止还有", "time":"00" ],
                        ["img":"icon_pk10", "name":"北京PK10", "description":"距离1711010971期截止还有", "time":"10" ] ]
        }
        else if selectType == 7 {
            arrData = [ ["img":"icon_lhc", "name":"极速六合彩", "description":"距离1711010970期截止还有", "time":"00" ]]
        }
        for i in 0..<arrData.count {
            let dictItem = arrData[i] as! [String:String]
            let model = BuyingHall_Model()
            model.iconImgName = dictItem["img"]
            model.name = dictItem["name"]
            model.desc = dictItem["description"]
            model.time_int = Int(dictItem["time"]!)
            self.arrModels.append(model)
        }
        if cComplete != nil {
            cComplete!(self.arrModels)
        }
    }
    
}
