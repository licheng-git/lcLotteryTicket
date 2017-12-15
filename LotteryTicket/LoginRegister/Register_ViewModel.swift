//
//  Register_ViewModel.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/12/12.
//  Copyright © 2017年 李诚. All rights reserved.
//


class RegisterModel: NSObject {
    var bInvite: Bool?
    var bEmail: Bool?           // 是否显示输入框
    var bEmail_Required: Bool?  // 是否必填
    var bMobile: Bool?
    var bMobile_Required: Bool?
    var bQQ: Bool?
    var bQQ_Required: Bool?
    var bRealName: Bool?
    var bRealName_Required: Bool?
    var imgValidate: UIImage?
}


class Register_ViewModel {
    
    func getData_ValidateImageAndReigsterConfig(_ delegateView:UIView?, _ cSuccess:@escaping (_ model:RegisterModel)->Void, _ cFailure:@escaping ()->Void) {
        
        let param = [
            "domain": "http://www.democash.info",
            "appScene": "1002"
        ]
        NetworkManager().request(URL_OwnerInfo, method: .post, parameters: param, delegateView, { (dictJson_data) in
            let sData = dictJson_data as! [String:Any]
            let sOwnerName = sData["cs_owner_name"] as! String
            UserDefaults.standard.set(sOwnerName, forKey: kUserDefaultsKey_OwnerName)
            UserDefaults.standard.synchronize()
            
            let model = RegisterModel()
            let ownerType = sData["cs_type"] as? Int  // 1为代理模式，邀请码必填；2为广告模式，邀请码非必填
            model.bInvite = ownerType! == 1 ? true : false
            let configField = sData["cs_member_register_field"] as! [String:Any]
            let configField_Email = configField["memberEmail"] as! [String:String]
            model.bEmail          = configField_Email["show"]          == "yes" ? true : false
            model.bEmail_Required = configField_Email["checkRequired"] == "yes" ? true : false
            let configField_Mobile = configField["memberMobile"] as! [String:String]
            model.bMobile          = configField_Mobile["show"]          == "yes" ? true : false
            model.bMobile_Required = configField_Mobile["checkRequired"] == "yes" ? true : false
            let configField_QQ = configField["memberQq"] as! [String:String]
            model.bQQ          = configField_QQ["show"]          == "yes" ? true : false
            model.bQQ_Required = configField_QQ["checkRequired"] == "yes" ? true : false
            let configField_RealName = configField["memberQq"] as! [String:String]
            model.bRealName          = configField_RealName["show"]          == "yes" ? true : false
            model.bRealName_Required = configField_RealName["checkRequired"] == "yes" ? true : false
            
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
                model.imgValidate = UIImage(data: imgData!)
                cSuccess(model)
            }) { (msg) in
                cFailure()
            }
            
        }) { (msg) in
            cFailure()
        }
        
    }
    
    
    func postData_Register(_ userName:String,
                           _ password:String,
                           _ inviteCode:String?,
                           _ verifyCode:String,
                           _ delegateView:UIView?,
                           _ cSuccess:@escaping ()->Void,
                           _ cFailure:@escaping ()->Void) {
        //let md5Pwd = Tools.MD5(password)
        let md5Pwd = password
        let ownerName = UserDefaults.standard.object(forKey: kUserDefaultsKey_OwnerName) as? String
        let param = [
            "ownerName": ownerName ?? "",
            "userName": userName,
            "password": md5Pwd,
            "cpPassword": md5Pwd,
            "inviteCode": inviteCode ?? "",
            "verifyCode": verifyCode
        ]
        NetworkManager().request(URL_Register, method: .post, parameters: param, delegateView, { (dictJson_data) in
            cSuccess()
        }) { (msg) in
            cFailure()
        }
    }
    
}
