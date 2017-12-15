//
//  LotteryHall_ViewModel.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/21.
//  Copyright © 2017年 李诚. All rights reserved.
//

class LotteryHall_ViewModel {
    
    var arrModels = Array<LotteryHall_Model>()
    
    func getData_List(_ delegateView:UIView?, _ cSuccess:@escaping (_ arrModels:[LotteryHall_Model])->Void, _ cFailure:((_ msg:String?)->Void)?) {
        if kArrModels_LotteryHall.count != 0 {
            self.arrModels = kArrModels_LotteryHall
            cSuccess(self.arrModels)
            return
        }
        ConfigLotteryData.requestLotteryList(delegateView: delegateView, cSuccess: { [weak self] in
            self?.arrModels = kArrModels_LotteryHall
            cSuccess((self?.arrModels)!)
        }) { (msg) in
            if cFailure != nil {
                cFailure!(msg)
            }
        }
    }
    
}
