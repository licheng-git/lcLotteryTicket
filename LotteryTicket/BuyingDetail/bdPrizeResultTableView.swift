//
//  bdPrizeResultTableView.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/13.
//  Copyright © 2017年 李诚. All rights reserved.
//

class bdPrizeResultTableView: UITableView, UITableViewDelegate, UITableViewDataSource {

    //static let tableHeight: CGFloat = 200

    var arrModel = [bdPrizeResult_Cell_Model]()

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.backgroundColor = UIColor.white
        self.dataSource = self
        self.delegate = self
        self.separatorStyle = .none
        self.allowsSelection = false
        self.isScrollEnabled = false
        self.register(bdPrizeResult_TableCell.classForCoder(), forCellReuseIdentifier: "Cell")
        
        let tbHeaderView = UIView()
        tbHeaderView.backgroundColor = kBgColorGray
        tbHeaderView.frame = CGRect(x: 0, y: 0, width: 10, height: bdPrizeResult_TableCell.cHeight)
        self.tableHeaderView = tbHeaderView
        let lbTitle_PeriodNum = UILabel()
        lbTitle_PeriodNum.text = "期数"
        lbTitle_PeriodNum.textAlignment = .center
        lbTitle_PeriodNum.font = UIFont.systemFont(ofSize: 16)
        tbHeaderView.addSubview(lbTitle_PeriodNum)
        lbTitle_PeriodNum.snp.makeConstraints { (make) in
            make.top.bottom.left.equalToSuperview()
            make.right.equalTo(tbHeaderView.snp.centerX)
        }
        let lbTitle_PrizeNum = UILabel()
        lbTitle_PrizeNum.text = "开奖号码"
        lbTitle_PrizeNum.textAlignment = .center
        lbTitle_PrizeNum.font = UIFont.systemFont(ofSize: 16)
        tbHeaderView.addSubview(lbTitle_PrizeNum)
        lbTitle_PrizeNum.snp.makeConstraints { (make) in
            make.top.bottom.right.equalToSuperview()
            make.left.equalTo(tbHeaderView.snp.centerX)
        }
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
        return bdPrizeResult_TableCell.cHeight
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! bdPrizeResult_TableCell
        let model = self.arrModel[indexPath.row]
        cell.lbPeriodNum.text = model.periodNum
        cell.lbPrizeNum.text = model.prizeNum
        if indexPath.row%2 == 0 {
            cell.backgroundColor = UIColor.white
        }
        else {
            cell.backgroundColor = kBgColorGray
        }
        return cell
    }

}
