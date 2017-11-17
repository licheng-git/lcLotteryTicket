//
//  bdNavTitleDetailView.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/6.
//  Copyright © 2017年 李诚. All rights reserved.
//

class bdNavTitleDetailView: UIView {
    
    var cBgViewTap: (()->Void)?
    var cBtnClick_Cell: ((_ btnTitle:String)->())?
    var cBtnClick_Header: ((_ cell0Btn0Title:String)->())?
    
    private let bgMaskView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.alpha = 0.5
        return view
    } ()
    
    private let kBtnTag_Header = 100
    private let kBtnTag_Cell   = 1000
    
    let arrData_header = [ "定位胆", "五星", "四星", "三星", "二星", "不定胆", "任选" ]
    let arrData_sub_0 = [ [ "title":"定位胆", "items":["定位胆"] ]
    ]
    let arrData_sub_1 = [ [ "title":"五星", "items":["五星直选", "五星组合", "五星组选120", "五星组选5", "总和"] ]
    ]
    let arrData_sub_2 = [ [ "title":"前四", "items":["前四直选", "前四组合", "前四组选4"] ],
                          [ "title":"后四", "items":["后四直选", "后四组合", "后四组选24"] ]
    ]
    let arrData_sub_n = [ [ "title":"后三", "items":["后三组合", "后三大小单双", "后三组三", "后三和值", "后三和值尾数", "后三包点", "后三直选", "后三组六", "后三特殊"] ],
                          [ "title":"前三", "items":["前三包点", "btn", "button_2_width"] ],
                          [ "title":"中三", "items":["中三组三", "."] ],
                          [ "title":"0", "items":["1", "2", "."] ],
                          [ "title":"cs", "items":["a", "b", "."] ]
    ]
    
    private var arrBtns_header = [UIButton]()
    private var arrBtns_cells = Array<UIButton>()
    
    private var bgHeaderView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear  // bgMaskView.alpha
        self.addSubview(self.bgMaskView)
        self.bgMaskView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(bgMaskViewTapAction(_:)))
        self.bgMaskView.addGestureRecognizer(tapGesture)
        
        // header btns
        let marginX: CGFloat = 10
        let marginY: CGFloat = 10
        let btnH: CGFloat = 30
        var arrBtnFrame = [CGRect]()
        var btnRows = 1
        var btnY = marginY
        var btnMaxX_pre: CGFloat = 0
        for i in 0..<self.arrData_header.count {
            let btnW: CGFloat = CGFloat(15 * (self.arrData_header[i].characters.count+2))  // 每个汉字长度为15，左右再空一点
            if btnMaxX_pre + marginX + btnW >= kSCREEN_WIDTH {
                btnRows += 1
                btnY += btnH + marginY
                btnMaxX_pre = 0
            }
            let btnX: CGFloat = marginX + btnMaxX_pre
            let btnFrame = CGRect(x: btnX, y: btnY, width: btnW, height: btnH)
            arrBtnFrame.append(btnFrame)
            btnMaxX_pre = btnFrame.maxX
        }
        let bgHeaderView_H: CGFloat = marginY + (btnH + marginY) * CGFloat(btnRows)
        self.bgHeaderView.backgroundColor = UIColor.white
        self.bgHeaderView.layer.borderColor = UIColor.lightGray.cgColor
        self.bgHeaderView.layer.borderWidth = 1
        self.bgHeaderView.frame = CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: bgHeaderView_H)
        self.addSubview(self.bgHeaderView)
        for i in 0..<self.arrData_header.count {
            let btn = UIButton()
            btn.tag = kBtnTag_Header + i
            btn.addTarget(self, action: #selector(btnClick_header(_:)), for: .touchUpInside)
            btn.setTitle(self.arrData_header[i], for: .normal)
            btn.layer.borderColor = UIColor.lightGray.cgColor
            btn.layer.borderWidth = 1
            btn.layer.cornerRadius = 5
            btn.backgroundColor = UIColor.clear
            btn.setTitleColor(UIColor.lightGray, for: .normal)
            btn.setTitleColor(UIColor.white, for: .selected)
            self.bgHeaderView.addSubview(btn)
            btn.frame = arrBtnFrame[i]
            if i == 0 {
                btn.isSelected = true
                btn.backgroundColor = UIColor.red
                btn.layer.borderColor = UIColor.red.cgColor
            }
            self.arrBtns_header.append(btn)
        }
        
        // cells btns
//        self.loadData_cells(0) { [weak self] (cell0Btn0Title) in
//            if self?.cBtnClick_Header != nil {  // init时为nil
//                self?.cBtnClick_Header!(cell0Btn0Title)
//            }
//        }
        self.loadData_cells(0, nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func bgMaskViewTapAction(_ gesture:UITapGestureRecognizer) {
        self.removeFromSuperview()
        if self.cBgViewTap != nil {
            self.cBgViewTap!()
        }
    }
    
    @objc private func btnClick_header(_ sender: UIButton) {
        if sender.isSelected {
            return
        }
        for btn in arrBtns_header {
            btn.isSelected = false
            btn.backgroundColor = UIColor.white
            btn.layer.borderColor = UIColor.lightGray.cgColor
        }
        sender.isSelected = true
        sender.backgroundColor = UIColor.red
        sender.layer.borderColor = UIColor.red.cgColor
        self.loadData_cells(sender.tag-kBtnTag_Header) { [weak self] (cell0Btn0Title) in
            if self?.cBtnClick_Header != nil {
                self?.cBtnClick_Header!(cell0Btn0Title)
            }
        }
    }
    
    
    private var bgCellsView: UIScrollView?
    
    @objc private func loadData_cells(_ headerIndex: Int, _ cComplete:((_ cell0Btn0Title:String)->Void)?) {
        var arrData_cells = Array<[String:Any]>()
        if headerIndex == 0 {
            arrData_cells = self.arrData_sub_0
        }
        else if headerIndex == 1 {
            arrData_cells = self.arrData_sub_1
        }
        else if headerIndex == 2 {
            arrData_cells = self.arrData_sub_2
        }
        else {
            arrData_cells = self.arrData_sub_n
        }
        
        self.bgCellsView?.removeFromSuperview()
        self.bgCellsView = nil
        self.bgCellsView = UIScrollView()
        self.bgCellsView?.backgroundColor = UIColor.white
        self.addSubview(self.bgCellsView!)
        self.arrBtns_cells.removeAll()
        
        let lbTitle_H: CGFloat = 21
        let lbTitle_W: CGFloat = 70
        var bgCellView_Y: CGFloat = 0
        for dictItem in arrData_cells {
            let arrItems = dictItem["items"] as! [String]
            let marginX: CGFloat = 10
            let marginY: CGFloat = 10
            let btnH: CGFloat = 30
            var arrBtnFrame = [CGRect]()
            var btnRows = 1
            var btnY = marginY
            var btnMaxX_pre: CGFloat = lbTitle_W
            for i in 0..<arrItems.count {
                let btnW: CGFloat = CGFloat(15 * (arrItems[i].characters.count+2))
                if btnMaxX_pre + marginX + btnW >= kSCREEN_WIDTH {
                    btnRows += 1
                    btnY += btnH + marginY
                    btnMaxX_pre = lbTitle_W
                }
                let btnX: CGFloat = marginX + btnMaxX_pre
                let btnFrame = CGRect(x: btnX, y: btnY, width: btnW, height: btnH)
                arrBtnFrame.append(btnFrame)
                btnMaxX_pre = btnFrame.maxX
            }
            let bgCellView_H: CGFloat = marginY + (btnH + marginY) * CGFloat(btnRows)
            let bgCellView = UIView()
            bgCellView.frame = CGRect(x: 0, y: bgCellView_Y, width: kSCREEN_WIDTH, height: bgCellView_H)
            bgCellView_Y += bgCellView_H
            self.bgCellsView?.addSubview(bgCellView)
            for i in 0..<arrItems.count {
                let btn = UIButton()
                btn.tag = kBtnTag_Cell + i
                btn.addTarget(self, action: #selector(btnClick_cell(_:)), for: .touchUpInside)
                btn.setTitle(arrItems[i], for: .normal)
                btn.layer.borderColor = UIColor.lightGray.cgColor
                btn.layer.borderWidth = 1
                btn.layer.cornerRadius = 5
                btn.backgroundColor = UIColor.clear
                btn.setTitleColor(UIColor.lightGray, for: .normal)
                btn.setTitleColor(UIColor.white, for: .selected)
                bgCellView.addSubview(btn)
                btn.frame = arrBtnFrame[i]
                self.arrBtns_cells.append(btn)
            }
            
            let strTitle = dictItem["title"] as! String
            let lbTitle = UILabel()
            lbTitle.text = strTitle
            let lbTitle_Y: CGFloat = (bgCellView.bounds.height - lbTitle_H) / 2
            lbTitle.frame = CGRect(x: marginX, y: lbTitle_Y, width: lbTitle_W, height: lbTitle_H)
            bgCellView.addSubview(lbTitle)
            
            let lineView = UIView()
            lineView.backgroundColor = UIColor.lightGray
            lineView.frame = CGRect(x: 0, y: bgCellView_Y, width: bgCellView.bounds.width, height: 1)
            self.bgCellsView?.addSubview(lineView)
        }
        
        let bgCellsView_Y = self.bgHeaderView.frame.maxY
        let bgCellsView_H = bgCellView_Y
        let bgCellsView_MaxH = kSCREEN_HEIGHT - kDEFAULT_MARGIN_Y - bgCellsView_Y  - 150
        if bgCellsView_H < bgCellsView_MaxH {
            self.bgCellsView?.frame = CGRect(x: 0, y: bgCellsView_Y, width: kSCREEN_WIDTH, height: bgCellsView_H)
            self.bgCellsView?.isScrollEnabled = false
        }
        else {
            self.bgCellsView?.frame = CGRect(x: 0, y: bgCellsView_Y, width: kSCREEN_WIDTH, height: bgCellsView_MaxH)
            self.bgCellsView?.contentSize = CGSize(width: kSCREEN_WIDTH, height: bgCellsView_H)
        }
        
        let btn0 = self.arrBtns_cells[0]
        btn0.isSelected = true
        btn0.backgroundColor = UIColor.red
        btn0.layer.borderColor = UIColor.red.cgColor
        if cComplete != nil {
            cComplete!((btn0.titleLabel?.text)!)
        }
    }
    
    @objc private func btnClick_cell(_ sender: UIButton) {
        self.removeFromSuperview()
        for btn in arrBtns_cells {
            btn.isSelected = false
            btn.backgroundColor = UIColor.white
            btn.layer.borderColor = UIColor.lightGray.cgColor
        }
        sender.isSelected = true
        sender.backgroundColor = UIColor.red
        sender.layer.borderColor = UIColor.red.cgColor
        if self.cBtnClick_Cell != nil {
            let btnTitle = sender.titleLabel?.text
            self.cBtnClick_Cell!(btnTitle!)
        }
    }
    
}
