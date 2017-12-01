//
//  BuyingHall_ViewModel.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/1.
//  Copyright © 2017年 李诚. All rights reserved.
//


class BuyingHall_ViewModel {
    
    var model:BuyingHall_Model?
    
    func getData(_ selectType: Int, _ delegateView:UIView?, _ cSuccess:@escaping (_ model:BuyingHall_Model)->Void, _ cFailure:((_ msg:String?)->Void)?) {
        if kArrModels_BuyingHall.count != 0 {
            self.model = kArrModels_BuyingHall[selectType]
            cSuccess(self.model!)
            return
        }
        ConfigLotteryData.requestLotteryList(delegateView: delegateView, cSuccess: { [weak self] in
            self?.model = kArrModels_BuyingHall[selectType]
            cSuccess((self?.model)!)
        }) { (msg) in
            if cFailure != nil {
                cFailure!(msg)
            }
        }
    }
    
    func getData_SelectButtons() -> [String]? {
        if kArrModels_BuyingHall.count == 0 {
            return nil
        }
        var arrTitle = [String]()
        for model in kArrModels_BuyingHall {
            arrTitle.append(model.title!)
        }
        return arrTitle
    }
    
}
