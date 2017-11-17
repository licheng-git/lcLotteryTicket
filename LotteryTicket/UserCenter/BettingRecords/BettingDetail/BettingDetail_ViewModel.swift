//
//  BettingDetail_ViewModel.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/9.
//  Copyright © 2017年 李诚. All rights reserved.
//


class BettingDetail_Model: NSObject {
    var iconImgName: String?
    var title: String?
    var periodNum: String?     // 期数
    var result: String?        // 是否中奖
    var playType: String?      // 玩法
    var time: String?          // 投注时间
    var betId: String?         // 投注单号
    var betAmount: String?     // 投注金额
    var sendAmount: String?    // 派送金额
    var prizeNum: String?      // 开奖号码
    var content: String?       // 投注内容
}


class BettingDetail_ViewModel {
    
    var model: BettingDetail_Model?
    
    func getData(_ cComplete:(_ model:BettingDetail_Model)->Void) {
        self.model = BettingDetail_Model()
        self.model?.iconImgName = "icon_ssc"
        self.model?.title = "极速时时彩"
        self.model?.periodNum = "第17110108884期"
        self.model?.result = "未中奖"
        self.model?.playType = "定位胆"
        self.model?.time = "2017-11-01 15:00:00"
        self.model?.betId = "123465479879746413165746984"
        self.model?.betAmount = "2000.00"
        self.model?.sendAmount = "0.00"
        self.model?.prizeNum = "9,7,7,5,5"
        self.model?.content = "alkjf;lkandnasdjvnahfalkj"
        cComplete(self.model!)
    }
    
}
