//
//  PrizeAnnounce_ViewMondel.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/2.
//  Copyright © 2017年 李诚. All rights reserved.
//


class PrizeAnnounce_ViewModel {
    
    var arrModels = [PrizeAnnounce_Model]()
    
    func getData() {
        self.arrModels.removeAll()
        let arrData = [ ["text":"极速时时彩", "img":"icon_ssc"],
                        ["text":"天津时时彩", "img":"icon_ssc"],
                        ["text":"重庆时时彩", "img":"icon_ssc"],
                        ["text":"新疆时时彩", "img":"icon_ssc"],
                        ["text":"好运11选5", "img":"icon_11x5"],
                        ["text":"山东11选5", "img":"icon_11x5"],
                        ["text":"江苏11选5", "img":"icon_11x5"],
                        ["text":"江西11选5", "img":"icon_11x5"],
                        ["text":"广东11选5", "img":"icon_11x5"],
                        ["text":"极速快三", "img":"icon_k3"],
                        ["text":"湖北快3", "img":"icon_k3"],
                        ["text":"安徽快3", "img":"icon_k3"],
                        ["text":"江苏快3", "img":"icon_k3"],
                        ["text":"福彩3D", "img":"icon_3d"],
                        ["text":"排列5", "img":"icon_pl5"],
                        ["text":"极速飞车", "img":"icon_pk10"],
                        ["text":"北京PK10", "img":"icon_pk10"],
                        ["text":"极速六合彩", "img":"icon_lhc"] ]
        for dictItem in arrData {
            let model = PrizeAnnounce_Model()
            model.iconImgName = dictItem["img"]
            model.name = dictItem["text"]
            self.arrModels.append(model)
        }
    }
    
}
