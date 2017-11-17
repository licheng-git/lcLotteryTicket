//
//  bdContentTableView.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/15.
//  Copyright © 2017年 李诚. All rights reserved.
//

class bdContentTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var arrData = [ [ "title":"万位", "items":"0,1,2,3,4,5,6,7,8,9" ],
                    [ "title":"x位", "items":"0,1,2,3" ],
                    [ "title":"二重号", "items":"0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21" ],
                    [ "title":"选择", "items":"总和大,总和单,豹子,顺子,对子" ],
                    [ "title":"选择", "items":"龙,虎,和" ] ]
    
    private var dictCellHeight = [Int:CGFloat]()
    
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
        return self.arrData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //let dictItem = self.arrData[indexPath.row]
        //return bdContent_TableCell.fCaculateHeight(dictItem["items"]!)
        return self.dictCellHeight[indexPath.row] ?? 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! bdContent_TableCell
        let dictItem = self.arrData[indexPath.row]
        var bShowLine = true
        if indexPath.row == 0 {
            bShowLine = false
        }
        cell.fConfigCellData(dictItem["title"]!, dictItem["items"]!, bShowLine)
        self.dictCellHeight[indexPath.row] = cell.cHeight
        return cell
    }
    
}
