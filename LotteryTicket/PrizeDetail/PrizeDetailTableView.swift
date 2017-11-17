//
//  PrizeDetailTableView.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/14.
//  Copyright © 2017年 李诚. All rights reserved.
//

class PrizeDetailTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var arrModel = [PrizeDetail_Model]()
    
    private var dictCellHeight = [IndexPath:CGFloat]()
    
    override init(frame: CGRect, style: UITableViewStyle) {
        //super.init(frame: frame, style: .grouped)
        super.init(frame: frame, style: style)
        self.backgroundColor = UIColor.white
        self.dataSource = self
        self.delegate = self
        self.separatorStyle = .none
        self.allowsSelection = false
        self.register(PrizeDetail_TableCell.classForCoder(), forCellReuseIdentifier: "Cell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.arrModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrModel[section].arrCellModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //let model_cell = self.arrModel[indexPath.section].arrCellModel?[indexPath.row]
        //let arrPrizes = model_cell?.arrPrizes
        //return arrPrizes != nil ? PrizeDetail_TableCell.fCaculateHeight(arrPrizes!) : 44
        return self.dictCellHeight[indexPath] ?? 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PrizeDetail_TableCell
        let model_cell = self.arrModel[indexPath.section].arrCellModel?[indexPath.row]
        let pType = model_cell?.playType ?? ""
        let pMode = model_cell?.bettingMode ?? ""
        let pPrizes = model_cell?.arrPrizes ?? [String]()
        cell.fConfigCellData(pType, pMode, pPrizes)
        self.dictCellHeight[indexPath] = cell.cHeight
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = PrizeDetail_SectionHeaderView()
        view.lbGroupTitle.text = self.arrModel[section].title
        return view
    }
    
}
