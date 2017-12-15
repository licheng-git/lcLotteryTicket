//
//  BuyingDetail_ViewModel.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/13.
//  Copyright © 2017年 李诚. All rights reserved.
//

import JavaScriptCore
import MBProgressHUD
import SocketIO

class BuyingDetail_ViewModel {
    
    var arrModel_NavTitleDetail_Header  = [bdNavTitleDetail_BtnModel]()
    var arrModel_NavTitleDetail_Cell    = [bdNavTitleDetail_SectionModel]()
    var arrModel_Content = [bdContent_Model]()
    
    func getData_All(_ id:String, _ pid:String, _ delegateView:UIView?,
                     _ cSuccess_NavTitleDetial_Header:@escaping (_ arrModel:[bdNavTitleDetail_BtnModel])->Void,
                     _ cSuccess_NavTitleDetial_Cell:@escaping (_ arrModel:[bdNavTitleDetail_SectionModel])->Void,
                     _ cSuccess_Content:@escaping (_ model:bdContent_Model)->Void) {
        
        let pid_new = pid.isEmpty ? id : pid
        
        let params:[String:Any] = [
            "lotteryId": id,
            "lotteryPid": pid_new
        ]
        NetworkManager().request(URL_PlayingType, method: .post, parameters: params, delegateView, { (dictJson_data) in
            let sData = dictJson_data as! [String:Any]
            let sList = sData["result"] as! Array<[String:Any]>
            self.arrModel_NavTitleDetail_Header.removeAll()
            for sItem in sList {
                let model = bdNavTitleDetail_BtnModel()
                model.playId = (sItem["_id"] as! [String:String])["$oid"]
                model.playPid = sItem["pid"] as? String
                model.name = sItem["name"] as? String
                self.arrModel_NavTitleDetail_Header.append(model)
            }
            cSuccess_NavTitleDetial_Header(self.arrModel_NavTitleDetail_Header)
            
            self.getData_NavTitleDetail_Header_Clicked(0, pid_new, delegateView,
                                                       cSuccess_NavTitleDetial_Cell,
                                                       cSuccess_Content)
            
        }, nil)
    }
    
    func getData_NavTitleDetail_Header_Clicked(_ atIndex:Int, _ pid:String, _ delegateView:UIView?,
                 _ cSuccess_NavTitleDetial_Cell:@escaping (_ arrModel_Cell:[bdNavTitleDetail_SectionModel])->Void,
                 _ cSuccess_Content:@escaping (_ model:bdContent_Model)->Void) {
        
        let modelP = self.arrModel_NavTitleDetail_Header[atIndex]
        let playPid = modelP.playPid!.isEmpty ? modelP.playId! : modelP.playPid!
        
        let params:[String:Any] = [
            "playingPid": playPid,
            "lotteryPid": pid
        ]
        NetworkManager().request(URL_PlayingGroup, method: .post, parameters: params, delegateView, { (dictJson_data) in
            let sData = dictJson_data as! [String:Any]
            let sList = sData["result"] as! Array<[String:Any]>
            
            self.arrModel_NavTitleDetail_Cell.removeAll()
            for sItem in sList {
                let model = bdNavTitleDetail_SectionModel()
                model.title = sItem["name"] as? String
                model.arrBtnModel = [bdNavTitleDetail_BtnModel]()
                let sChildren = sItem["child"] as! Array<[String:Any]>
                for sChild in sChildren {
                    let modelBtn = bdNavTitleDetail_BtnModel()
                    modelBtn.playId = (sChild["_id"] as! [String:String])["$oid"]
                    modelBtn.playPid = sChild["pid"] as? String
                    modelBtn.name = sChild["name"] as? String
                    model.arrBtnModel?.append(modelBtn)
                }
                self.arrModel_NavTitleDetail_Cell.append(model)
            }
            cSuccess_NavTitleDetial_Cell(self.arrModel_NavTitleDetail_Cell)
            
            self.arrModel_Content.removeAll()
            for sItem in sList {
                let sChildren = sItem["child"] as! Array<[String:Any]>
                for sChild in sChildren {
                    let model = bdContent_Model()
                    model.playId = (sChild["_id"] as! [String:String])["$oid"]
                    model.playPid = sChild["pid"] as? String
                    model.name = sChild["name"] as? String
                    //model.area = sChild["area"] as? [[String:Any]]
                    //model.list = sChild["list"] as? [[String:Any]]
                    //model.area_pos = sChild["area_pos"] as? [[String:Any]]
                    let arrArea = sChild["area"] as! [[String:Any]]
                    model.area = [bdContent_Area_Model]()
                    for dictArea in arrArea {
                        let modelArea = bdContent_Area_Model()
                        modelArea.id = dictArea["id"] as? String
                        modelArea.title = dictArea["title"] as? String
                        modelArea.length = dictArea["length"] as? Int
                        //modelArea.rule = dictArea["rule"] as? Int
                        model.area?.append(modelArea)
                    }
                    let arrList = sChild["list"] as! [[String:Any]]
                    model.list = [bdContent_List_Model]()
                    for dictList in arrList {
                        let modelList = bdContent_List_Model()
                        modelList.id = dictList["id"] as? Int
                        modelList.name = dictList["name"] as? String
                        model.list?.append(modelList)
                    }
                    let dictAreaPos = sChild["area_pos"] as? [String:Any]
                    if dictAreaPos != nil {
                        model.area_pos = bdContent_AreaPos_Model()
                        model.area_pos?.title = dictAreaPos!["title"] as? String
                        model.area_pos?.pos = dictAreaPos!["pos"] as? [String:Any]
                        model.area_pos?.choose = dictAreaPos!["choose"] as? [String]
                        //model.area_pos?.rule = dictAreaPos!["rule"] as? Int
                    }
                    model.explain = sChild["explain"] as? String
                    model.example = sChild["example"] as? String
                    model.note_operation = sChild["note_operation"] as? Int
                    //model.equal = sChild["equal"] as? Int
                    model.length = sChild["length"] as? Int
                    model.dictSelfModel = sChild
                    self.arrModel_Content.append(model)
                }
            }
            cSuccess_Content(self.arrModel_Content[0])
            
        }, nil)
    }
    
    
//    func jsReader() {
//        let jsFilePath = Bundle.main.path(forResource: "lcTest.js", ofType: nil)
//        let jsStr = try! String(contentsOfFile: jsFilePath!, encoding: .utf8)
//        let jsContext = JSContext()
//        jsContext?.exceptionHandler = { (c, exception) in
//            print("js异常 \(String(describing: exception))")
//            c?.exception = exception
//        }
//        let _ = jsContext?.evaluateScript(jsStr)
//        let jsValue_Func = jsContext?.objectForKeyedSubscript("jsFuncTest_debug")
//        let jsValue_Result = jsValue_Func?.call(withArguments: [])
//        //print("js calculate result = \(jsValue_Result!.toArray())")
//    }
    
    func jsReader_BetSelector() -> JSContext {
        return self.jsReader("betSelector_iOS.js")
    }
    
    func jsReader_Algorithm() -> JSContext {
        return self.jsReader("algorithm_iOS.js")
    }
    
    private func jsReader(_ jsFileName:String) -> JSContext {
        let jsFilePath = Bundle.main.path(forResource: jsFileName, ofType: nil)
        let jsStr = try! String(contentsOfFile: jsFilePath!, encoding: .utf8)
        let jsContext = JSContext()
        jsContext?.exceptionHandler = { (c, exception) in
            print("js异常 \(String(describing: exception))")
            c?.exception = exception
        }
        let _ = jsContext?.evaluateScript(jsStr)
        return jsContext!
    }
    
    
    //weak var delegateVC_bd: BuyingDetailViewController?
    var arrModel_ShoppingCar = [ShoppingCar_Cell_Model]()
    
    func validateBetting(_ delegateVC_bd: BuyingDetailViewController?) -> Bool {
        if delegateVC_bd == nil {
            return false
        }
        let dictPlaying = (delegateVC_bd?.contentView.bdcTableView.model?.dictSelfModel)!
        let dictSelectedCode = (delegateVC_bd?.contentView.bdcTableView.dictCodeOfChosen)!
        var intSeveralPos = delegateVC_bd?.contentView.bdcTableView.model?.length ?? 0
        if intSeveralPos == 0 {
            intSeveralPos = delegateVC_bd?.contentView.bdcTableView.model?.area?.count ?? 0
        }
        //let jsContext = delegateVC_bd?.vm.jsReader_BetSelector()
        let jsContext = self.jsReader_BetSelector()
        let jsFunc_validationIsFinished = jsContext.objectForKeyedSubscript("validationIsFinished")
        let jsResult = jsFunc_validationIsFinished?.call(withArguments: [dictPlaying, dictSelectedCode, intSeveralPos])
        let bValidateBetting = jsResult!.toBool()
        let hud = MBProgressHUD.showAdded(to: (delegateVC_bd?.navigationController?.view)!, animated: true)
        hud.mode = .text
        hud.label.text = "温馨提示"
        hud.detailsLabel.text = bValidateBetting ? "您的注单已经成功加入购物车" : "您还没有完成选号"
        hud.backgroundView.backgroundColor = UIColor.darkGray
        hud.backgroundView.alpha = 0.5
        hud.hide(animated: true, afterDelay: 1.5)
        return bValidateBetting
    }
    
    
    var websocket:SocketIOClient?
    
    func getData_PrizeResult(_ alias:String, _ cSuccess:@escaping (_ periodNum:String, _ prizeResult:String)->Void) {
        let url = URL(string: URL_WebSocket)!
        //websocket = SocketIOClient(socketURL: url)  // err
        websocket = SocketIOClient(socketURL: url, config: [.log(false), .compress])
        //websocket?.on("connect", callback: { [weak self] (data, ack) in
        websocket?.on(clientEvent: .connect) { [weak self] (data, ack) in
            print("websocket connected \(data)")
            self?.websocket?.emit("alias", ["alias": alias])
        }
        websocket?.on(clientEvent: .error) { (data, ack) in
            print("websocket error \(data)")
        }
        websocket?.on("reconnect") { [weak self] (data, ack) in
            print("websocket reconnect \(data)")
            self?.websocket?.emit("fetch_lottery_result", ["alias": alias])
        }
        websocket?.on(alias) { (data, ack) in
            print("websocket onReceive_\(alias) \(data)")
            let dictData0 = data[0] as! [String:Any]
            let dictList = dictData0["data"] as! [[String:Any]]
            let dictItem0 = dictList[0]
            let periodNum = dictItem0["number"] as! String
            let prizeResult = dictItem0["result"] as! String
            cSuccess(periodNum, prizeResult)
        }
        websocket?.connect()
    }
    
//    func getData_PrizeResult_js() {
//        let jsContext = JSContext()
//        jsContext?.exceptionHandler = { (c, exception) in
//            print("js异常 \(String(describing: exception))")
//            c?.exception = exception
//        }
//        let jsFilePath_framework = Bundle.main.path(forResource: "socket.js", ofType: nil)  // *_* js异常
//        let jsStr_framework = try! String(contentsOfFile: jsFilePath_framework!, encoding: .utf8)
//        let _ = jsContext?.evaluateScript(jsStr_framework)
//        let jsFilePath_business = Bundle.main.path(forResource: "dbPrizeResult.js", ofType: nil)
//        let jsStr_business = try! String(contentsOfFile: jsFilePath_business!, encoding: .utf8)
//        let _ = jsContext?.evaluateScript(jsStr_business)
//
//        let cFunc_WebsocketReceived: @convention(block) ()->() = {
//            let arrArgs = JSContext.currentArguments() ?? [Any]()
//            //for arg in arrArgs {
//            //    print("iOS*_* \(arg)")
//            //}
//            print("websocket onReceive \(arrArgs[0])")
//        }
//        jsContext?.setObject(cFunc_WebsocketReceived, forKeyedSubscript: "iosFunc_WebsocketReceived" as NSCopying & NSObjectProtocol)
//
//        let jsValue_Func = jsContext?.objectForKeyedSubscript("jsWebsocketConnect")
//        let jsValue_Result = jsValue_Func?.call(withArguments: [])
//        print("jsValue_Result = \(jsValue_Result!.toString())")
//    }
    
    func getData_Timer(_ alias:String, _ delegateView:UIView?, _ cSuccess:@escaping (_ model:bdTimer_Model)->Void) {
        let url_timer = URL_Timer + alias
        NetworkManager().request(url_timer, method: .get, delegateView, { (dictJson_data) in
            let sData = dictJson_data as! [String:Any]
            let model = bdTimer_Model()
            model.countdown = sData["countdown"] as? Int
            model.currentNumber = sData["currentNumber"] as? String
            model.sellNumber = sData["sellNumber"] as? String
            cSuccess(model)
        }, nil)
    }
    
    func getData_PrizeResultTable(_ alias:String, _ delegateView:UIView?, _ cSuccess:@escaping (_ arrModel:[bdPrizeResult_Cell_Model])->Void) {
        let url_PrizeHistory = URL_PrizeHistory + alias
        NetworkManager().request(url_PrizeHistory, method: .get, delegateView, { (dictJson_data) in
            let sData = dictJson_data as! [[String:Any]]
            var arrModel = [bdPrizeResult_Cell_Model]()
            for sItem in sData {
                let model = bdPrizeResult_Cell_Model()
                //model.periodNum = sItem["number"] as? String
                let tempNumber = sItem["number"] as! String
                let si = tempNumber.index(tempNumber.startIndex, offsetBy: 4)
                model.periodNum = tempNumber.substring(from: si)
                //model.prizeNum = sItem["result"] as? String
                //let arrResult = Array(sItem["result"] as! String)
                let arrResult = (sItem["result"] as! String).split(separator: ",")
                var tempResult = " "
                for i in 0..<arrResult.count {
                    let c = arrResult[i]
                    tempResult += String(c) + " "
                }
                model.prizeNum = tempResult
                arrModel.append(model)
            }
            cSuccess(arrModel)
        }, nil)
    }
    
    
    deinit {
        print("BuyingDetail_ViewModel deinit")
        self.websocket?.disconnect()
        self.websocket = nil
    }
    
}
