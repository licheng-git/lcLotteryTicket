//
//  bdNavRightTableView.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/13.
//  Copyright © 2017年 李诚. All rights reserved.
//

class bdNavRightTableView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var cCellSelect: ((_ cellId:String)->())?
    
    var arrModel = [bdNavRightTable_Cell_Model]()
    
    lazy var myTableview: UITableView = {
        let tableview = UITableView()
        tableview.backgroundColor = UIColor.white
        tableview.dataSource = self
        tableview.delegate = self
        tableview.separatorStyle = .none
        tableview.register(bdNavRight_TableCell.classForCoder(), forCellReuseIdentifier: "Cell")
        return tableview
    } ()
    
    private let bgMaskView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.alpha = 0.5
        return view
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.bgMaskView)
        self.bgMaskView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(bgMaskViewTapAction(_:)))
        self.bgMaskView.addGestureRecognizer(tapGesture)
        
        self.addSubview(self.myTableview)
        self.myTableview.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(150)
            //make.right.equalToSuperview()
            make.left.equalTo(self.snp.right)
        }
    }
    
    var bIsShowing: Bool = false
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if self.superview == nil {
            self.bIsShowing = false
            return
        }
        self.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(kDEFAULT_MARGIN_Y)
        }
        self.bIsShowing = true
        
//        self.bgMaskView.alpha = 0.0
//        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
//            UIView.animate(withDuration: 0.5) {
//                //print(self.myTableview.frame)
//                var tempFrame = self.myTableview.frame
//                tempFrame.origin.x -= tempFrame.width
//                self.myTableview.frame = tempFrame
//                self.bgMaskView.alpha = 0.5
//            }
//        })
        self.bgMaskView.alpha = 0.0
        self.layoutIfNeeded()
        UIView.animate(withDuration: 0.5) {
            //print(self.myTableview.frame)
            var tempFrame = self.myTableview.frame
            tempFrame.origin.x -= tempFrame.width
            self.myTableview.frame = tempFrame
            self.bgMaskView.alpha = 0.5
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
        return bdNavRight_TableCell.cHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! bdNavRight_TableCell
        let model = self.arrModel[indexPath.row]
        cell.imgviewIcon.image = UIImage(named: model.iconImgName!)
        cell.lbName.text = model.name
        if indexPath.row == 0 {
            cell.lineView_FristCell_Top.isHidden = false
        }
        else {
            cell.lineView_FristCell_Top.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! bdNavRight_TableCell
        if self.cCellSelect != nil {
            self.cCellSelect!(cell.lbName.text!)
        }
        self.remove()
    }
    
    @objc private func bgMaskViewTapAction(_ gesture:UITapGestureRecognizer) {
        self.remove()
    }
    
    func remove(_ bAnimated: Bool = true) {
        if !bAnimated {
            self.removeFromSuperview()
        }
        else {
            UIView.animate(withDuration: 0.5, animations: {
                var tempFrame = self.myTableview.frame
                tempFrame.origin.x += tempFrame.width
                self.myTableview.frame = tempFrame
                self.bgMaskView.alpha = 0.0
            }, completion: { (bIsFinished) in
                self.removeFromSuperview()
            })
        }
    }
}
