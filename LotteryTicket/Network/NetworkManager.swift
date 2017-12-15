//
//  NetworkManager.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/20.
//  Copyright © 2017年 李诚. All rights reserved.
//

import Alamofire
//import Reachability
import MBProgressHUD
import SwiftyJSON

class NetworkManager {
    
//    init() {
//        //print("NetworkManager init")
//    }
    
    func request(_ url: String,
                 method: HTTPMethod = .get,
                 parameters: Parameters? = nil,
                 encoding: ParameterEncoding = URLEncoding.default,
                 headers: HTTPHeaders? = nil,
                 _ delegateView:UIView?,
                 _ cSuccess:@escaping (_ dictJson_data:Any)->Void,
                 _ cFailure:((_ msg:String?)->Void)?) {
        
        var hud: MBProgressHUD?
        
        if !kReach.isReachable {
            if delegateView != nil {
                hud = MBProgressHUD.showAdded(to: delegateView!, animated: true)
                hud?.mode = .text
                hud?.label.text = "请检查网络连接"
                hud?.backgroundView.backgroundColor = UIColor.black
                hud?.backgroundView.alpha = 0.5
                hud?.hide(animated: true, afterDelay: 1.0)
            }
            if cFailure != nil {
                cFailure!(nil)
            }
            return
        }
        
        if delegateView != nil {
            //MBProgressHUD.showAdded(to: delegateView!, animated: true)
            hud = MBProgressHUD.showAdded(to: delegateView!, animated: true)
            hud?.backgroundView.backgroundColor = UIColor.black
            hud?.backgroundView.alpha = 0.5
        }
        
        //let manager = Alamofire.SessionManager.default
        //manager.session.configuration.timeoutIntervalForRequest = 10
        //manager.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).responseJSON { (dataResp) in
        Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).responseJSON { (dataResp) in
            print("网络请求地址 \(dataResp.request!.url!.absoluteString)")
            
            //if delegateView != nil {
            //    //MBProgressHUD.hide(for: delegateView!, animated: true)
            //    MBProgressHUD.hideAllHUDs(for: delegateView!, animated: true)
            //}
            hud?.hide(animated: true)
            
            dataResp.result.ifSuccess({
                //print("网络请求成功 \(dataResp.result.value!)")
                print("网络请求成功 \(JSON(dataResp.result.value!))")
                let dictJson = dataResp.result.value as! [String:Any]
                let sCode = dictJson["code"] as! Int
                if sCode != 200 {
                    let msgErr_business = dictJson["message"] as! String
                    if delegateView != nil {
                        let hud = MBProgressHUD.showAdded(to: delegateView!, animated: true)
                        hud.mode = .text
                        hud.label.text = msgErr_business
                        hud.hide(animated: true, afterDelay: 1.0)
                    }
                    if cFailure != nil {
                        cFailure!(msgErr_business)
                    }
                    return
                }
                cSuccess(dictJson["data"]!)
                
            })
            dataResp.result.ifFailure {
                print("网络请求失败 \(dataResp.result.error!)")
                if delegateView != nil {
                    //MBProgressHUD.hideAllHUDs(for: delegateView!, animated: true)
                    hud = MBProgressHUD.showAdded(to: delegateView!, animated: true)
                    hud?.mode = .text
                    hud?.label.text = "数据加载失败"
                    hud?.hide(animated: true, afterDelay: 1.0)
                }
                if cFailure != nil {
                    cFailure!("数据加载失败")
                }
            }
        }
        
    }
    
}
