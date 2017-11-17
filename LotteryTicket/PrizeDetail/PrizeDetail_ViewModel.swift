//
//  PrizeDetail_ViewModel.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/16.
//  Copyright © 2017年 李诚. All rights reserved.
//

class PrizeDetail_ViewModel {
    
    var arrModel = [PrizeDetail_Model]()
    
    func getData(_ cComplete:(_ arrModels:[PrizeDetail_Model])->Void) {
        self.arrModel.removeAll()
        let arrData = [
            [ "title":"定位胆", "items":[ ["type":"定位胆", "mode":"2元", "prize":["19.50元"]] ] ],
            [ "title":"五星玩法", "items":[ ["type":"五星直选", "mode":"2元", "prize":["1950000.00元"]],
                                           ["type":"五星组合", "mode":"2元", "prize":["1950000.00元","1950.00元","19.50元"]],
                                           ["type":"五星选120", "mode":"2元", "prize":["100.00元"]]
                ] ],
            [ "title":"kk玩法", "items":[ ["type":"中三一码不定位胆", "mode":"2元", "prize":["1950000.00元"]],
                                          ["type":"A", "mode":"2元", "prize":["1950000.00元","1950.00元","19.50元"]],
                                          ["type":"B", "mode":"2元", "prize":["100.00元"]]
                ] ],
            [ "title":"xx", "items":[ ["type":"xx", "mode":"xx元", "prize":["xxx.xx元"]] ] ]
        ]
        for dictItem in arrData {
            let model = PrizeDetail_Model()
            model.title = dictItem["title"] as? String
            model.arrCellModel = Array<PrizeDetail_Cell_Model>()
            let arrItems = dictItem["items"] as! Array<[String:Any]>
            for dictItem_cell in arrItems {
                let model_cell = PrizeDetail_Cell_Model()
                model_cell.playType = dictItem_cell["type"] as? String
                model_cell.bettingMode = dictItem_cell["mode"] as? String
                model_cell.arrPrizes = dictItem_cell["prize"] as? Array<String>
                model.arrCellModel?.append(model_cell)
            }
            self.arrModel.append(model)
        }
        cComplete(self.arrModel)
    }
    
}
