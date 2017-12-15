//
//  PrizeResult_ViewModel.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/8.
//  Copyright © 2017年 李诚. All rights reserved.
//

import MBProgressHUD


class PrizeResult_Model: NSObject {
    var title: String?
    var result: String?
}


class PrizeResult_ViewModel {
    
    var arrModels_all = [PrizeResult_Model]()
    let nm = NetworkManager()
    var currentPage = 1
    
    func getData(_ id:String, _ pid:String, _ delegateView:UIView?, _ cSuccess:@escaping (_ arrModels_page:[PrizeResult_Model])->Void, _ cFailure:@escaping ()->()) {
        let params:[String:Any] = [
            "game_type": id,
            "pageIndex": self.currentPage,
            "pageSize": 10
        ]
        if self.currentPage == 1 {
            self.arrModels_all.removeAll()
        }
        self.nm.request(URL_LotteryResults, method: .post, parameters: params, nil, { (dictJson_data) in
            let sData = dictJson_data as! [String:Any]
            let sList = sData["result"] as! [[String:Any]]
            var arrModels_page = Array<PrizeResult_Model>()
            for sItem in sList {
                let model = PrizeResult_Model()
                model.title = sItem["self_period_number"] as? String
                model.result = sItem["results"] as? String
                arrModels_page.append(model)
            }
            self.arrModels_all.append(contentsOf: arrModels_page)
            self.currentPage += 1
            cSuccess(arrModels_page)
        }, { (msg) in
            if delegateView != nil {
                let hud = MBProgressHUD.showAdded(to: delegateView!, animated: true)
                hud.mode = .text
                hud.label.text = "数据加载失败"
                hud.backgroundView.backgroundColor = UIColor.black
                hud.backgroundView.alpha = 0.5
                hud.hide(animated: true, afterDelay: 1.0)
            }
            cFailure()
        })
    }
    
}
