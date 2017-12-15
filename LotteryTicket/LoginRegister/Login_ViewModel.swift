//
//  Login_ViewModel.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/12/12.
//  Copyright © 2017年 李诚. All rights reserved.
//

import Alamofire

let kUserDefaultsKey_OwnerName = "owner_name"
let kUserDefaultsKey_LoginName = "LoginName"
let kUserDefaultsKey_Md5Pwd    = "Md5Pwd"

class Login_ViewModel {
    
    func configOwnerInfo(_ delegateView:UIView?, _ cSuccess:(()->Void)?) {
        let ownerName = UserDefaults.standard.object(forKey: kUserDefaultsKey_OwnerName) as? String
        if ownerName != nil && !ownerName!.isEmpty {
            if cSuccess != nil {
                cSuccess!()
            }
            return
        }
        let param = [
            "domain": "http://www.democash.info",
            "appScene": "1002"
        ]
        NetworkManager().request(URL_OwnerInfo, method: .post, parameters: param, delegateView, { (dictJson_data) in
            let sData = dictJson_data as! [String:Any]
            let sOwnerName = sData["cs_owner_name"] as! String
            UserDefaults.standard.set(sOwnerName, forKey: kUserDefaultsKey_OwnerName)
            UserDefaults.standard.synchronize()
            if cSuccess != nil {
                cSuccess!()
            }
        }, nil)
    }
    
    func getData_ValidateImage(_ delegateView:UIView?, _ cSuccess:@escaping (_ img:UIImage)->Void, _ cFailure:@escaping ()->Void) {
        let param = [
            "ownerName": UserDefaults.standard.object(forKey: kUserDefaultsKey_OwnerName) as! String
        ]
        NetworkManager().request(URL_ValidateCode, method: .post, parameters: param, delegateView, { (dictJson_data) in
            let sData = dictJson_data as! [String:Any]
            let sImgageUrl = sData["codeUrl"] as! String
            let imgUrl = URL(string: sImgageUrl)
            let imgData = try? Data(contentsOf: imgUrl!)
            if imgData == nil {
                cFailure()
                return
            }
            let img = UIImage(data: imgData!)
            cSuccess(img!)
        }) { (msg) in
            cFailure()
        }
    }
    
    func postData_Login(_ userName:String, _ password:String, _ verifyCode:String, _ delegateView:UIView?, _ cSuccess:@escaping ()->Void, _ cFailure:@escaping ()->Void) {
        //let md5Pwd = Tools.MD5(password)
        let md5Pwd = password
        let ownerName = UserDefaults.standard.object(forKey: kUserDefaultsKey_OwnerName) as? String
        let param = [
            "ownerName": ownerName ?? "",
            "userName": userName,
            "password": password,
            "verifyCode": verifyCode
        ]
        NetworkManager().request(URL_Login, method: .post, parameters: param, delegateView, { (dictJson_data) in
            let sData = dictJson_data as! [String:Any]
            UserInfo.sharedInstance.token = sData["token"] as! String
            UserInfo.sharedInstance.userName = sData["cs_user_name"] as! String
            UserInfo.sharedInstance.intBalance = sData["cs_amount"] as! Int
            UserDefaults.standard.set(userName, forKey: kUserDefaultsKey_LoginName)
            UserDefaults.standard.set(md5Pwd, forKey: kUserDefaultsKey_Md5Pwd)
            UserDefaults.standard.synchronize()
            cSuccess()
        }) { (msg) in
            cFailure()
        }
    }
    
}
