//
//  ConfigLotteryData.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/21.
//  Copyright © 2017年 李诚. All rights reserved.
//

var kArrModels_LotteryHall = Array<LotteryHall_Model>()
var kArrModels_BuyingHall  = Array<BuyingHall_Model>()
var kArrModels_bdNavRight  = Array<bdNavRightTable_Cell_Model>()
//var kArrModels_PrizeAnnounce = [PrizeAnnounce_Cell_Model]()

class ConfigLotteryData {
    
    static func requestLotteryList(delegateView:UIView?, cSuccess:@escaping ()->Void, cFailure:((_ msg:String?)->Void)?) {

        NetworkManager().request(URL_LotteryList, method: .post, delegateView, { (dictJson_data) in
            let sData = dictJson_data as! [String:Any]
            let sList = sData["result"] as! Array<[String:Any]>
            
            
            let lhModelTop_ffc = LotteryHall_Model()
            lhModelTop_ffc.category = "分分彩"
            lhModelTop_ffc.arrCellModels = [LotteryHall_Cell_Model]()
            kArrModels_LotteryHall.append(lhModelTop_ffc)
            let lhModelTop_offical = LotteryHall_Model()
            lhModelTop_offical.category = "官方彩"
            lhModelTop_offical.arrCellModels = [LotteryHall_Cell_Model]()
            kArrModels_LotteryHall.append(lhModelTop_offical)
            
            for sItem in sList {
                let sChildren = sItem["child"] as? Array<[String:Any]>
                if sChildren == nil {
                    let modelCell = LotteryHall_Cell_Model()
                    modelCell.id = (sItem["_id"] as! [String:String])["$oid"]
                    modelCell.pid = sItem["pid"] as? String
                    modelCell.name = sItem["name"] as? String
                    modelCell.alias = sItem["alias"] as? String
                    modelCell.iconImgName = ConfigLotteryData.imgnameConvert(sItem["alias"] as! String)
                    let cate = sItem["lottery_cate"] as? String
                    if cate == "ffc60" {
                        lhModelTop_ffc.arrCellModels?.append(modelCell)
                    }
                    else if cate == "official" {
                        lhModelTop_offical.arrCellModels?.append(modelCell)
                    }
                }
                else {
                    for sChild in sChildren! {
                        let modelCell = LotteryHall_Cell_Model()
                        modelCell.id = (sChild["_id"] as! [String:String])["$oid"]
                        modelCell.pid = sChild["pid"] as? String
                        modelCell.name = sChild["name"] as? String
                        modelCell.alias = sChild["alias"] as? String
                        //modelCell.iconImgName = self.imgnameConvert(sChild["alias"] as! String)
                        modelCell.iconImgName = ConfigLotteryData.imgnameConvert(sItem["alias"] as! String)  // 子节点与父节点图标一样名称不一样
                        let cate = sChild["lottery_cate"] as? String
                        if cate == "ffc60" {
                            lhModelTop_ffc.arrCellModels?.append(modelCell)
                        }
                        else if cate == "official" {
                            lhModelTop_offical.arrCellModels?.append(modelCell)
                        }
                    }
                }
            }
            
            
            var tempArrModels_BuyingHall = [BuyingHall_Model]()
            let bhModel_hot = BuyingHall_Model()
            bhModel_hot.title = "热门彩种"
            bhModel_hot.arrCellModel = [BuyingHall_Cell_Model]()
            for sItem in sList {
                let bhModel = BuyingHall_Model()
                bhModel.title = sItem["name"] as? String
                bhModel.arrCellModel = [BuyingHall_Cell_Model]()
                let sChildren = sItem["child"] as? Array<[String:Any]>
                if sChildren == nil {
                    let modelCell = BuyingHall_Cell_Model()
                    modelCell.id = (sItem["_id"] as! [String:String])["$oid"]
                    modelCell.pid = sItem["pid"] as? String
                    modelCell.name = sItem["name"] as? String
                    modelCell.alias = sItem["alias"] as? String
                    modelCell.iconImgName = ConfigLotteryData.imgnameConvert(sItem["alias"] as! String)
                    bhModel.arrCellModel?.append(modelCell)
                    if sItem["is_hot"] as! NSNumber == 1 {
                        bhModel_hot.arrCellModel?.append(modelCell)
                    }
                }
                else {
                    for sChild in sChildren! {
                        let modelCell = BuyingHall_Cell_Model()
                        modelCell.id = (sChild["_id"] as! [String:String])["$oid"]
                        modelCell.pid = sChild["pid"] as? String
                        modelCell.name = sChild["name"] as? String
                        modelCell.alias = sChild["alias"] as? String
                        modelCell.iconImgName = ConfigLotteryData.imgnameConvert(sItem["alias"] as! String)
                        bhModel.arrCellModel?.append(modelCell)
                        if sChild["is_hot"] as! Int == 1 {
                            bhModel_hot.arrCellModel?.append(modelCell)
                        }
                    }
                }
                tempArrModels_BuyingHall.append(bhModel)
            }
            kArrModels_BuyingHall.append(bhModel_hot)
            for model in tempArrModels_BuyingHall {
                kArrModels_BuyingHall.append(model)
            }
            
            
            for sItem in sList {
                let sChildren = sItem["child"] as? Array<[String:Any]>
                if sChildren == nil {
                    let modelCell = bdNavRightTable_Cell_Model()
                    modelCell.id = (sItem["_id"] as! [String:String])["$oid"]
                    modelCell.pid = sItem["pid"] as? String
                    modelCell.name = sItem["name"] as? String
                    modelCell.alias = sItem["alias"] as? String
                    modelCell.iconImgName = ConfigLotteryData.imgnameConvert(sItem["alias"] as! String)
                    kArrModels_bdNavRight.append(modelCell)
                }
                else {
                    for sChild in sChildren! {
                        let modelCell = bdNavRightTable_Cell_Model()
                        modelCell.id = (sChild["_id"] as! [String:String])["$oid"]
                        modelCell.pid = sChild["pid"] as? String
                        modelCell.name = sChild["name"] as? String
                        modelCell.alias = sChild["alias"] as? String
                        modelCell.iconImgName = ConfigLotteryData.imgnameConvert(sItem["alias"] as! String)
                        kArrModels_bdNavRight.append(modelCell)
                    }
                }
            }
            
            
            cSuccess()
            
        }, { (msg) in
            if cFailure != nil {
                cFailure!(msg)
            }
        })
        
    }
    
    
    private static func imgnameConvert(_ imgname_server:String) -> String {
        var imgname_local = "icon_ssc"
        if imgname_server == "ssc" {
            imgname_local = "icon_ssc"
        }
        else if imgname_server == "syxw" {
            imgname_local = "icon_11x5"
        }
        else if imgname_server == "ks" {
            imgname_local = "icon_k3"
        }
        else if imgname_server == "sd" {
            imgname_local = "icon_3d"
        }
        else if imgname_server == "plw" {
            imgname_local = "icon_pl5"
        }
        else if imgname_server == "pks" {
            imgname_local = "icon_pk10"
        }
        else if imgname_server == "lhc" {
            imgname_local = "icon_lhc"
        }
        return imgname_local
    }
    
}
