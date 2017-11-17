//
//  PrizeResult_ViewModel.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/8.
//  Copyright © 2017年 李诚. All rights reserved.
//


class PrizeResult_ViewModel {
    
    var arrModels_all = [PrizeResult_Model]()
    
    func getData(_ pageIndex:Int, _ cComplete:(_ arrModels_page:[PrizeResult_Model])->Void) {
        var arrModels_page = Array<PrizeResult_Model>()
        if pageIndex == 0 {
            self.arrModels_all.removeAll()
        }
        else if pageIndex == 3 {
            cComplete(arrModels_page)
            return
        }
        let arrData = [ ["title":"第1711080629期", "result":"36099"],
                        ["title":"第1711080628期", "result":"0123456789"],
                        ["title":"第1711080627期", "result":"1a2b3c"],
                        ["title":"第1711080626期", "result":"1"],
                        ["title":"第1711080625期", "result":"123"],
                        ["title":"第1711080624期", "result":"12345"],
                        ["title":"第1711080623期", "result":"123456"],
                        ["title":"第1711080622期", "result":"1234567"],
                        ["title":"第1711080621期", "result":"12345678"],
                        ["title":"第1711080620期", "result":"123456789"] ]
        for dictItem in arrData {
            let model = PrizeResult_Model()
            model.title = dictItem["title"]
            model.result = dictItem["result"]
            self.arrModels_all.append(model)
            arrModels_page.append(model)
        }
        cComplete(arrModels_page)
    }
    
}
