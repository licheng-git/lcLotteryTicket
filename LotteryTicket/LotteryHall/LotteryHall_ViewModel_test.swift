//
//  LotteryHall_ViewModel_test.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/20.
//  Copyright © 2017年 李诚. All rights reserved.
//

import Alamofire
import Reachability
import MBProgressHUD

class LotteryHall_ViewModel_test {
    
    var arrModels = [Array<LotteryHall_Model>]()
    
    func getData_List(_ delegateVC:UIViewController, _ cSuccess:(_ arrModels:[LotteryHall_Model])->Void) {
        
        let hostReach = Reachability()!
        do {
            try hostReach.startNotifier()
        }
        catch {
            print("网络监测失败")
        }
        if !hostReach.isReachable {
            let hud = MBProgressHUD.showAdded(to: (delegateVC.tabBarController?.navigationController?.view)!, animated: true)
            hud.mode = .text
            hud.label.text = "请检查网络连接"
            hud.hide(animated: true, afterDelay: 1.0)
            return
        }
        
        MBProgressHUD.showAdded(to: (delegateVC.tabBarController?.navigationController?.view)!, animated: true)
        //let manager = Alamofire.SessionManager.default
        //manager.session.configuration.timeoutIntervalForRequest = 30
        Alamofire.request(URL_LotteryList, method: .post).responseJSON { (dataResp) in
            print("网络请求地址 \(dataResp.request!.url!.absoluteString)")
            MBProgressHUD.hide(for: (delegateVC.tabBarController?.navigationController?.view)!, animated: true)
            dataResp.result.ifSuccess({
                print("网络请求成功 \(dataResp.result.value!)")
                let dictJson = dataResp.result.value as! [String:Any]
                let sCode = dictJson["code"] as! Int
                if sCode != 200 {
                    let hud = MBProgressHUD.showAdded(to: (delegateVC.tabBarController?.navigationController?.view)!, animated: true)
                    hud.mode = .text
                    hud.label.text = dictJson["message"] as? String
                    hud.hide(animated: true, afterDelay: 1.0)
                    return
                }
                let sData = dictJson["data"] as! [String:Any]
                let sList = sData["result"] as! Array<[String:Any]>
                for sListItem in sList {
                    var sChildren = sListItem["child"] as? Array<[String:Any]>
                    if sChildren == nil {
                        sChildren = Array<[String:Any]>()
                    }
                    print("*_* name = \(sListItem["name"]!), child.count=\(sChildren!.count)")
                    for sChildItem in sChildren! {
                        print("  \(sChildItem["name"]!), \(sChildItem["description"]!), \(sChildItem["result_length"]!)")
                    }
                }
            })
            dataResp.result.ifFailure {
                print("网络请求失败 \(dataResp.result.error!)")
                let hud = MBProgressHUD.showAdded(to: (delegateVC.tabBarController?.navigationController?.view)!, animated: true)
                hud.mode = .text
                hud.label.text = "数据加载失败"
                hud.hide(animated: true, afterDelay: 1.0)
            }
        }
        
        
//        Alamofire.request(URL_LotteryList, method: .post).responseData { (dataResp) in
//            print("网络请求地址 \(dataResp.request!.url!.absoluteString)")
//            dataResp.result.ifSuccess({
//                //let respStr = String(data: dataResp.result.value!, encoding: .utf8)
//                //print("网络请求成功 \(respStr!)")
//                if let dictJson = try? JSONSerialization.jsonObject(with: dataResp.result.value!, options: .allowFragments) as! [String:Any] {
//                    print("网络请求成功dictJson \(dictJson)")
//                    //print("msg \(dictJson["message"]!)")
//                }
//                if JSONSerialization.isValidJSONObject(dataResp.result.value!) {
//                    print("*_* isValidJSONObject")
//                }
//
//            })
//            dataResp.result.ifFailure {
//                print("网络请求失败 \(dataResp.result.error!)")
//            }
//        }
//
//        Alamofire.request(URL_LotteryList, method: .post).responseJSON { (dataResp) in
//            print("网络请求地址 \(dataResp.request!.url!.absoluteString)")
//            dataResp.result.ifSuccess({
//                print("网络请求成功 \(dataResp.result.value!)")
//                let dictJson = dataResp.result.value as! [String:Any]
//                //print("msg \(dictJson["message"]!)")
//            })
//            dataResp.result.ifFailure {
//                print("网络请求失败 \(dataResp.result.error!)")
//            }
//        }
        
        
//        //let headers: HTTPHeaders = [
//        let headers: [String:String] = [
//            "AhwApi-Access-Token": "fc85a7ce091aea86ef3463b9166e9b06",
//            "Version": "",
//            "Client": "",
//            "DeviceToken": ""
//        ]
//        //let params:Parameters = [  // ?page=2&k=v&foo[]=a&foo[]=1&foo1[x]=1&foo1[y]=sb&foo1[z]=3
//        let params:[String:Any] = [
//            "page": 1,
//            "k": "v",
//            "foo": ["a", 1],  // 数组
//            "foo1": ["x":1, "y":"sb", "z":3]  // 键值对
//        ]
////        Alamofire.request("http://119.147.82.70:7771/api/Invest/List", parameters: params, headers: headers).responseData { (dataResp) in
////            print("网络请求地址 \(dataResp.request!.url!.absoluteString)")
////            dataResp.result.ifSuccess({
////                //let respStr = String(data: dataResp.result.value!, encoding: .utf8)
////                //print("网络请求成功 \(respStr!)")
////                if let dictJson = try? JSONSerialization.jsonObject(with: dataResp.result.value!, options: .allowFragments) as! [String:Any] {
////                    print("网络请求成功dictJson \(dictJson)")
////                }
////            })
////            dataResp.result.ifFailure {
////                print("网络请求失败 \(dataResp.result.error!)")
////            }
////        }
//        Alamofire.request("http://119.147.82.70:7771/api/Invest/List?page=2", parameters: params, headers: headers).responseJSON { (dataResp) in
//            print("网络请求地址 \((dataResp.request?.url?.absoluteString)!)")
//            dataResp.result.ifSuccess({
//                print("网络请求成功 \(dataResp.result.value!)")
//                let dictJson = dataResp.result.value as! [String:Any]
//                print(dictJson["ResponseStatus"]!)
//            })
//            dataResp.result.ifFailure {
//                print("网络请求失败 \(dataResp.result.error!)")
//            }
//        }
        
    }
}
