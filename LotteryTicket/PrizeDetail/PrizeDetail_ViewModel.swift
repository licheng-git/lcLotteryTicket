//
//  PrizeDetail_ViewModel.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/16.
//  Copyright © 2017年 李诚. All rights reserved.
//

import JavaScriptCore

class PrizeDetail_ViewModel {
    
    var arrModel = [PrizeDetail_Model]()
    
    func getData(_ pid:String, _ delegateView:UIView? ,_ cSuccess:@escaping (_ arrModels:[PrizeDetail_Model])->Void) {
        let params:[String:Any] = [
            "odds": "1950",
            "lotteryPid": pid
        ]
        NetworkManager().request(URL_PrizeDetail, method: .post, parameters: params, delegateView, { (dictJson_data) in
            let sList = dictJson_data as! Array<[String:Any]>
            self.arrModel.removeAll()
            for sItem in sList {
                let model = PrizeDetail_Model()
                model.title = sItem["name"] as? String
                model.arrCellModel = [PrizeDetail_Cell_Model]()
                let sChildren = sItem["child"] as! Array<[String:Any]>
                for sChild in sChildren {
                    let modelCell = PrizeDetail_Cell_Model()
                    modelCell.playType = sChild["name"] as? String
                    modelCell.bettingMode = sChild["pattern"] as? String
                    if let amount = sChild["amount"] as? Int {
                        let strAmount = self.moneyConvert(amount)
                        modelCell.arrPrizes = [strAmount]
                    }
                    //else if let dictAmount = sChild["amount"] as? [Int:Int] {  // err
                    //else if let dictAmount = sChild["amount"] as? [String:Int] {
                    else if let dictAmount = sChild["amount"] as? NSDictionary {
                        modelCell.arrPrizes = Array<String>()
                        //for v in dictAmount.allValues {  // 顺序乱了
                        //    let iAmount = v as! Int
                        for i in 1...dictAmount.count {
                            //let iAmount = dictAmount[i] as! Int
                            let iAmount = dictAmount[String(i)] as! Int
                            let sAmount = self.moneyConvert(iAmount)
                            modelCell.arrPrizes?.append(sAmount)
                        }
                    }
                    model.arrCellModel?.append(modelCell)
                }
                self.arrModel.append(model)
            }
            cSuccess(self.arrModel)
        }, nil)
    }
    
    private func moneyConvert(_ amount:Int) -> String {
//        let jsFilePath = Bundle.main.path(forResource: "lcTest.js", ofType: nil)
//        let jsStr = try! String(contentsOfFile: jsFilePath!, encoding: .utf8)
//        let jsContext = JSContext()
//        jsContext?.exceptionHandler = { (c, exception) in
//            print("js异常 \(String(describing: exception))")
//            c?.exception = exception
//        }
//        let _ = jsContext?.evaluateScript(jsStr)
//        let jsValue_Func = jsContext?.objectForKeyedSubscript("formatPenny")
//        let jsValue = jsValue_Func?.call(withArguments: [amount])
//        return (jsValue?.toString())!
        
        let f = Float(amount)/Float(1000)
        let s = String(format: "%0.3f元", f)
        //print("\(amount) -> \(f) -> \(s)")
        return s
    }
    
}
