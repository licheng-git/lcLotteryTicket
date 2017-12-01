//
//  bdContentTableView.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/15.
//  Copyright © 2017年 李诚. All rights reserved.
//

import JavaScriptCore
import SwiftyJSON
import MBProgressHUD

class bdContentTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var model:bdContent_Model?
    
    private var dictCellHeight = [Int:CGFloat]()
    
    var jsContext:JSContext?
    
    weak var delegateVC: BuyingDetailViewController?

//    lazy var alertC: UIAlertController = {
//        let alertC = UIAlertController(title: "温馨提示", message: "这个号码已经选过了", preferredStyle: .alert)
//        let actionCancel = UIAlertAction(title: "确定", style: .cancel, handler: nil)
//        alertC.addAction(actionCancel)
//        return alertC
//    } ()
    
    //var dictCodeOfChosen:[String:[Int]] = Dictionary()
    //var dictCodeOfChosen:[String:[Int]] = [:]  // {areaId:[ListIds]}
    var dictCodeOfChosen:[String:[Any]] = [:]    // {areaId:[ListIds], pos:[areaIds]}    // {常规玩法，特殊玩法}
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.backgroundColor = UIColor.white
        self.dataSource = self
        self.delegate = self
        self.separatorStyle = .none
        self.allowsSelection = false
        self.register(bdContent_TableCell.classForCoder(), forCellReuseIdentifier: "Cell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model?.area?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //let dictItem = self.arrData[indexPath.row]
        //return bdContent_TableCell.fCaculateHeight(dictItem["items"]!)
        return self.dictCellHeight[indexPath.row] ?? 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! bdContent_TableCell
        
//        let CellIdentifier = String(format: "Cell_%d_%d", indexPath.section, indexPath.row)
//        var cell_UnReuse = tableView.dequeueReusableCell(withIdentifier: CellIdentifier) as? bdContent_TableCell
//        if cell_UnReuse != nil {
//            //print("*_* cell不复用  \(cell_UnReuse!.areaId), \(cell_UnReuse!.arrId_choose)")
//            return cell_UnReuse!
//        }
//        cell_UnReuse = bdContent_TableCell(style: .default, reuseIdentifier: CellIdentifier)
//        let cell = cell_UnReuse!
        
        let modelArea = self.model!.area![indexPath.row]
        let bOperationBtns = self.model!.note_operation! == 1 ? true : false
        var bShowLine = true
        if indexPath.row == 0 {
            bShowLine = false
        }
        cell.fConfigCellData(modelArea, self.model!.list!, bOperationBtns, bShowLine)
        self.dictCellHeight[indexPath.row] = cell.cHeight
        cell.cBtnAction_Operation = { [weak self] (_ strOperationType) in
            let jsFunc_runMultipleChoice = self?.jsContext?.objectForKeyedSubscript("runMultipleChoice")
            let dictPlaying = (self?.model?.dictSelfModel)!  // || self.model.runtimeToDict()
            let jsResult = jsFunc_runMultipleChoice?.call(withArguments: [ dictPlaying, (self?.dictCodeOfChosen)!, cell.areaId, strOperationType])
            let jsResutl_Dict = jsResult!.toDictionary()
            let arrId_choose = jsResutl_Dict!["betCodes"] as! [Int]
            //cell.arrId_choose = arrId_choose
            self?.dictCodeOfChosen[cell.areaId] = arrId_choose
            return arrId_choose
        }
        cell.cBtnAction_SingleChioce = { [weak self] (modelList_curCode) in
            let jsFunc_runRadioChoice = self?.jsContext?.objectForKeyedSubscript("runRadioChoice")  // 根据玩法检测是否重号，重号就不让选
            let dictPlaying = (self?.model?.dictSelfModel)!
            let intCurCode = modelList_curCode.id!
            let jsResult = jsFunc_runRadioChoice?.call(withArguments: [ dictPlaying, (self?.dictCodeOfChosen)!, cell.areaId, intCurCode])
            let bIsRepeat = jsResult!.toBool()
            if bIsRepeat {
                // 例：11选5 -> 任选二(胆拖)
                //self?.delegateVC?.present((self?.alertC)!, animated: true, completion: nil)
                let hud = MBProgressHUD.showAdded(to: (self?.delegateVC?.navigationController?.view)!, animated: true)
                hud.mode = .text
                hud.label.text = "温馨提示"
                hud.detailsLabel.text = "这个号码已经选过了"
                hud.backgroundView.backgroundColor = UIColor.darkGray
                hud.backgroundView.alpha = 0.5
                hud.hide(animated: true, afterDelay: 1.5)
            }
            return bIsRepeat
        }
        cell.cBtnAction_SingleChoice_SaveChosen = { [weak self] in
            self?.dictCodeOfChosen[cell.areaId] = cell.arrId_choose
        }
        
        //print("*_* \(cell.areaId), \(cell.arrId_choose), \(self.dictCodeOfChosen)")
        let arrId_choose = self.dictCodeOfChosen[cell.areaId] as? [Int]
        if arrId_choose != nil {
            cell.arrId_choose = arrId_choose!
            cell.fConfigWhenReuse()
        }
        
        cell.delegate = self.delegateVC
        
        return cell
    }
    
    func fSetHeader_SpecialPlaying() {
        // 例：极速时时彩 -> 任选 -> 任四组选4
        if self.model?.area_pos == nil {
            self.tableHeaderView = nil
            return
        }
        let frame = CGRect(x: 0, y: 0, width: 10, height: bdContent_TableHeaderView.hHeight)
        let tbHeaderView = bdContent_TableHeaderView(frame: frame)
        tbHeaderView.model = self.model!.area_pos
        self.tableHeaderView = tbHeaderView
        
        if self.model?.area_pos?.choose != nil {
            self.dictCodeOfChosen["pos"] = (self.model?.area_pos?.choose)!
        }
        tbHeaderView.cBtnAction_Specail = { [weak self] (arrChoose) in
            self?.dictCodeOfChosen["pos"] = arrChoose
        }
        
        tbHeaderView.delegate = self.delegateVC
    }
    
}
