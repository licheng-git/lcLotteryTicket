//
//  ShoppingCarTableView.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/29.
//  Copyright © 2017年 李诚. All rights reserved.
//

class ShoppingCarTableView: UITableView, UITableViewDelegate, UITableViewDataSource {

    var arrModel = [ShoppingCar_Cell_Model]()

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.backgroundColor = kBgColorGray
        self.dataSource = self
        self.delegate = self
        self.separatorStyle = .none
        self.allowsSelection = false
        self.register(ShoppingCar_TableCell.classForCoder(), forCellReuseIdentifier: "Cell")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrModel.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ShoppingCar_TableCell.scHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ShoppingCar_TableCell
        let model = self.arrModel[indexPath.row]
        cell.lbName.text = model.name
        var tempChoose = ""
        for modelArea in model.arrModelArea! {
            let arrCodeName = model.dictCodeChosen![modelArea.id!] as? [Int]
            if arrCodeName != nil {
                for i in 0..<arrCodeName!.count {
                    tempChoose += String(arrCodeName![i])
                    if i != arrCodeName!.count - 1 {
                        tempChoose += ","
                    }
                }
            }
            tempChoose += "|"
        }
        let arrSpecail = model.dictCodeChosen!["pos"] as? [String]
        if arrSpecail == nil {
            //let si = tempChoose.index(tempChoose.startIndex, offsetBy: tempChoose.characters.count-1)
            let si = tempChoose.index(tempChoose.endIndex, offsetBy: -1)
            tempChoose = tempChoose.substring(to: si)
        }
        else {
            for _ in arrSpecail! {
                //tempChoose += str + ","
                tempChoose += ","
            }
        }
        cell.lbChoose.text = tempChoose
        cell.lbAmount.text = String(format: "%d注 x %@ x %d倍 = %0.3f元", model.bettingNumber!, model.bettingUnit!, model.bettingMultiple!, model.bettingAmount!)
        return cell
    }
    
    
    var cTableCell_Delete: ((_ arrModel: [ShoppingCar_Cell_Model])->())?
    
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
//        return .delete
//    }
//
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            self.arrModel.remove(at: indexPath.row)
//            self.deleteRows(at: [indexPath], with: .right)
//        }
//    }
//
//    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
//        return "删除"
//    }
    
    
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let actionDelete = UITableViewRowAction(style: .destructive, title: "删除") { (action, indexPath) in
            self.arrModel.remove(at: indexPath.row)
            self.deleteRows(at: [indexPath], with: .right)
            if self.cTableCell_Delete != nil {
                self.cTableCell_Delete!(self.arrModel)
            }
        }
        return [actionDelete]
    }
    
}
