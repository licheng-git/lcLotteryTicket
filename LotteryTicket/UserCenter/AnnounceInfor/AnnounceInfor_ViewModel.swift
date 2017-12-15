//
//  AnnounceInfor_ViewModel.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/12/15.
//  Copyright © 2017年 李诚. All rights reserved.
//

class AnnounceInfor_Model: NSObject {
    var title: String?
    var time: String?
    var htmlContent: String?
}

class AnnounceInfor_ViewModel {
    
    func getData(_ pageIndex:Int, _ pageSize:Int, _ delegateView:UIView?, _ cSuccess:@escaping (_ arrModels_page:[AnnounceInfor_Model])->Void, _ cFailure:@escaping ()->()) {
        let ownerName = UserDefaults.standard.object(forKey: kUserDefaultsKey_OwnerName) as? String
        let params:[String:Any] = [
            "ownerName": ownerName ?? "",
            "page": pageIndex,
            "pageSize": pageSize
        ]
        print(params)
        NetworkManager().request(URL_NoticeList, method: .post, parameters: params, delegateView, { (dictJson_data) in
            let sData = dictJson_data as! [String:Any]
            let sList = sData["lists"] as! [[String:Any]]
            var arrModels_page = [AnnounceInfor_Model]()
            for sItem in sList {
                let model = AnnounceInfor_Model()
                model.title = sItem["cs_title"] as? String
                let timestamp = sItem["cs_update_at"] as! Int
                model.time = Tools.convertTimestamp(timestamp)
                model.htmlContent = sItem["cs_content"] as? String
                arrModels_page.append(model)
            }
            cSuccess(arrModels_page)
        }) { (msg) in
            cFailure()
        }
    }
    
}
