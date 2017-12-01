//
//  BuyingDetailViewController.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/10/31.
//  Copyright © 2017年 李诚. All rights reserved.
//

import UIKit
import MBProgressHUD

class BuyingDetailViewController: UIViewController {
    
    var id = String()
    var pid = String()
    var name = String()
    
    let vm = BuyingDetail_ViewModel()
    
    lazy var navTitleView: bdNavTitleView = {
        let view = bdNavTitleView()
        return view
    } ()
    
    lazy var navTitleDetailView: bdNavTitleDetailView = {
        let view = bdNavTitleDetailView()
        return view
    } ()
    
    lazy var navRightTableView: bdNavRightTableView = {
        let view = bdNavRightTableView()
        return view
    } ()
    
    let timerView: bdTimerView = {
        let view = bdTimerView()
        return view
    } ()
    
    let prizeResultView: bdPrizeResultView = {
        let view = bdPrizeResultView()
        return view
    } ()
    
    let prizeResultTableView: bdPrizeResultTableView = {
        let view = bdPrizeResultTableView()
        return view
    } ()
//    let prizeResultWebView: UIWebView = {
//        let webview = UIWebView()
//        return webview
//    } ()
    
    let contentView: bdContentView = {
        let view = bdContentView()
        return view
    } ()
    
    let bottomView: bdBottomView = {
        let view = bdBottomView()
        return view
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addDefaultBackNavItem()
        
        self.navigationItem.titleView = self.navTitleView.btnTitle
        self.view.backgroundColor = UIColor.white
        self.navTitleView.cBtnClick_Toggle = { [weak self] (bToShow) in
            if bToShow {
                self?.view.addSubview((self?.navTitleDetailView)!)
                self?.navTitleDetailView.snp.makeConstraints({ (make) in
                    make.top.equalToSuperview().offset(kDEFAULT_MARGIN_Y)
                    make.left.right.bottom.equalToSuperview()
                })
                self?.navRightTableView.remove()
            }
            else {
                self?.navTitleDetailView.removeFromSuperview()
            }
        } 
        self.navTitleDetailView.cBgViewTap = { [weak self] in
            self?.navTitleView.btnTitle.isSelected = false
        }
        
        let navItem_right = UIBarButtonItem()
        navItem_right.style = .plain
        navItem_right.image = UIImage(named: "navItem_menu")
        navItem_right.target = self
        navItem_right.action = #selector(navItemClick_Right(_:))
        navItem_right.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = navItem_right
        
        self.view.addSubview(self.timerView)
        self.timerView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kDEFAULT_MARGIN_Y)
            make.left.right.equalToSuperview()
            make.height.equalTo(bdTimerView.Height)
        }
        self.timerView.lbTitle.text = self.name
        self.timerView.lbPeriodNum.text = "--期"
        //self.timerView.startTimer(80)
        self.timerView.cCountToZero = { [weak self] (currentPeriodNum) in
            let hud = MBProgressHUD.showAdded(to: (self?.view)!, animated: true)
            hud.mode = .text
            hud.label.text = "温馨提示"
            hud.detailsLabel.text = "当前为" + currentPeriodNum + ",投注时请注意期数"
            hud.backgroundView.backgroundColor = UIColor.darkGray
            hud.backgroundView.alpha = 0.5
            hud.hide(animated: true, afterDelay: 3.0)
            hud.completionBlock = {
                self?.timerView.startTimer(10000)
            }
        }
        
        self.view.addSubview(self.prizeResultView)
        self.prizeResultView.snp.makeConstraints { (make) in
            make.top.equalTo(self.timerView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(bdPrizeResultView.headerHeight)
        }
        self.prizeResultView.lbPeriodNum.text = "------期开奖号码"
        self.prizeResultView.fSetResult("------")
        self.prizeResultView.cToggle = { [weak self] (bIsShowing) in
            if bIsShowing {
                UIView.animate(withDuration: 0.5, animations: {
                    //self?.prizeResultView.imgviewArrow.transform = CGAffineTransform(rotationAngle: .pi*0.5)
                    var tempFrame = self?.contentView.frame
                    tempFrame?.origin.y = (self?.prizeResultTableView.frame.maxY)!
                    self?.contentView.frame = tempFrame!
                })
            }
            else {
                UIView.animate(withDuration: 0.5, animations: {
                    //self?.prizeResultView.imgviewArrow.transform = CGAffineTransform(rotationAngle: 0)
                    var tempFrame = self?.contentView.frame
                    tempFrame?.origin.y = (self?.prizeResultView.frame.maxY)!
                    self?.contentView.frame = tempFrame!
                })
            }
        }
        
        self.view.addSubview(self.prizeResultTableView)
        self.prizeResultTableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.prizeResultView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(bdPrizeResult_TableCell.cHeight*6)
        }
        self.vm.getData_PrizeResultTable { [weak self] (arrModel) in
            self?.prizeResultTableView.arrModel = arrModel
            self?.prizeResultTableView.reloadData()
        }

//        self.view.addSubview(self.contentView)
//        self.contentView.snp.makeConstraints { (make) in
//            make.left.right.equalToSuperview()
//            make.top.equalTo(self.prizeResultView.snp.bottom)
//            make.bottom.equalToSuperview().offset(-bdBottomView.height)
//        }
        self.view.layoutIfNeeded()
        //print(self.prizeResultView.frame.maxY)
        self.contentView.frame = CGRect(x: 0, y: self.prizeResultView.frame.maxY, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT-self.prizeResultView.frame.maxY-bdBottomView.height)
        self.view.addSubview(self.contentView)
        self.contentView.topView.cClick = { [weak self] (index) in
            if index < 3 {
                let vc = BuyingDetailDescViewController()
                vc.selectedIndex = index
                vc.id = (self?.id)!
                vc.pid = (self?.pid)!
                vc.name = (self?.name)!
                vc.strPlayRule = self?.contentView.topView.strPlayRule
                vc.strPrizeExample = self?.contentView.topView.strPrizeExample
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            else if index == 3 {
                let vc = BettingRecordsViewController()
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }
        self.contentView.bdcTableView.jsContext = self.vm.jsReader_BetSelector()
        self.contentView.bdcTableView.delegateVC = self

        self.view.addSubview(self.bottomView)
        self.bottomView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(bdBottomView.height)
        }
        
        
        //let cSuccess_NavTitleDetail_Header:(([bdNavTitleDetail_BtnModel]) -> Void) = { [weak self] (_ arrModel_Header:[bdNavTitleDetail_BtnModel]) in
        let cSuccess_NavTitleDetail_Header = { [weak self] (_ arrModel:[bdNavTitleDetail_BtnModel]) -> () in
            self?.navTitleDetailView.fSetArrModel_Header(arrModel)
        }
        let cSuccess_NavTitleDetail_Cell = { [weak self] (_ arrModel:[bdNavTitleDetail_SectionModel]) in
            let model0 = arrModel[0].arrBtnModel![0]
            self?.navTitleView.btnTitle.setTitle(model0.name, for: .normal)
            self?.navTitleDetailView.fSetArrModel_Cell(arrModel)
        }
        let cSuccess_Content = { [weak self] (_ model:bdContent_Model) in
            self?.contentView.topView.strPlayRule = model.explain
            self?.contentView.topView.strPrizeExample = model.example
            self?.contentView.bdcTableView.dictCodeOfChosen = Dictionary()
            self?.contentView.bdcTableView.model = model
            self?.contentView.bdcTableView.reloadData()
            self?.contentView.bdcTableView.fSetHeader_SpecialPlaying()
            
        }
        self.vm.getData_All(self.id, self.pid, self.navigationController?.view,
                            cSuccess_NavTitleDetail_Header,
                            cSuccess_NavTitleDetail_Cell,
                            cSuccess_Content)
        
        self.navTitleDetailView.cBtnClick_Header = { [weak self] (index) in
            self?.vm.getData_NavTitleDetail_Header_Clicked(index, (self?.pid)!, self?.navigationController?.view,
                                                       cSuccess_NavTitleDetail_Cell,
                                                       cSuccess_Content)
            self?.bottomView.fResetData()
        }
        self.navTitleDetailView.cBtnClick_Cell = { [weak self] (index) in
            self?.navTitleView.btnTitle.isSelected = false
            var model: bdNavTitleDetail_BtnModel?
            var i = -1
            for modelSection in (self?.vm.arrModel_NavTitleDetail_Cell)! {
                for modelBtn in modelSection.arrBtnModel! {
                    i += 1
                    if i == index {
                        model = modelBtn
                        break
                    }
                }
                if i >= index {
                    break
                }
            }
            self?.navTitleView.btnTitle.setTitle(model?.name, for: .normal)
            cSuccess_Content((self?.vm.arrModel_Content[i])!)
            self?.bottomView.fResetData()
        }
        
        self.navRightTableView.cCellSelect = { [weak self] (cell) in
            self?.id = cell.id
            self?.pid = cell.pid
            self?.name = cell.lbName.text!
            self?.timerView.lbTitle.text = self?.name
            self?.vm.getData_All((self?.id)!, (self?.pid)!, self?.navigationController?.view,
                                 cSuccess_NavTitleDetail_Header,
                                 cSuccess_NavTitleDetail_Cell,
                                 cSuccess_Content)
            
            //self?.vm.arrModel_ShoppingCar.removeAll()
            self?.bottomView.fResetData()
        }
        
        self.bottomView.cBtnAction_AddShoppingCar = { [weak self] in
            let bValidate = self?.vm.validateBetting(self)
            if bValidate == nil || !bValidate! {
                return
            }
            self?.bottomView.btnBetting_Directly.isHidden = true
            self?.bottomView.btnBetting_GoToShoppingCar.isHidden = false
            let model = ShoppingCar_Cell_Model()
            model.playId = self?.contentView.bdcTableView.model?.playId
            model.playPid = self?.contentView.bdcTableView.model?.playPid
            model.name = self?.contentView.bdcTableView.model?.name
            model.dictCodeChosen = self?.contentView.bdcTableView.dictCodeOfChosen
            model.arrModelArea = self?.contentView.bdcTableView.model?.area
            model.bettingNumber = self?.bottomView.numbers ?? 0
            model.bettingAmount = self?.bottomView.amount  ?? 0
            if (self?.bottomView.btnYuan.isSelected)! {
                model.bettingUnit = "2元"
            }
            else if (self?.bottomView.btnJiao.isSelected)! {
                model.bettingUnit = "2角"
            }
            else if (self?.bottomView.btnFen.isSelected)! {
                model.bettingUnit = "2分"
            }
            model.bettingMultiple = Int(self?.bottomView.tfInput.text ?? "1") ?? 1
            self?.vm.arrModel_ShoppingCar.append(model)
            self?.bottomView.lbShoppingCarNum.text = String((self?.vm.arrModel_ShoppingCar.count)!)
            self?.contentView.bdcTableView.dictCodeOfChosen = Dictionary()
            self?.contentView.bdcTableView.reloadData()
            self?.contentView.bdcTableView.fSetHeader_SpecialPlaying()
            self?.bottomView.fResetData()
        }
        self.bottomView.cBtnAction_Betting_Directly = { [weak self] in
            let bValidate = self?.vm.validateBetting(self)
            if bValidate == nil || !bValidate! {
                return
            }
            self?.contentView.bdcTableView.dictCodeOfChosen = Dictionary()
            self?.contentView.bdcTableView.reloadData()
            self?.contentView.bdcTableView.fSetHeader_SpecialPlaying()
        }
        self.bottomView.cBtnAction_Betting_GoToShoppingCar = { [weak self] in
            let vc = ShoppingCarViewController()
            vc.vm.arrModel = (self?.vm.arrModel_ShoppingCar)!
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        self.bottomView.delegate = self
        
    }
    
    
    @objc private func navItemClick_Right(_ sender: UIBarButtonItem) {
        self.navTitleDetailView.removeFromSuperview()
        self.navTitleView.btnTitle.isSelected = false
        
        if self.navRightTableView.bIsShowing {
            self.navRightTableView.remove()
        }
        else {
            self.view.addSubview(self.navRightTableView)
            //if kArrModels_bdNavRight.count == 0 {
            //    self.vm.getData_NavRightTable({ [weak self] in
            //        self?.navRightTableView.myTableview.reloadData()
            //    })
            //}
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.bottomView.lbShoppingCarNum.text = String(self.vm.arrModel_ShoppingCar.count)
        if self.vm.arrModel_ShoppingCar.count == 0 {
            self.bottomView.btnBetting_Directly.isHidden = false
            self.bottomView.btnBetting_GoToShoppingCar.isHidden = true
        }
    }
    
    deinit {
        print("BuyDetailViewController deinit")
        self.timerView.stopTimer()
    }
    
}


extension BuyingDetailViewController: bdContent_AnyButton_Delegate {
    func dRunCalculate() {
        var yjf_Id = 0  // 元角分  [1:"2元", 2:"1元", 3:"2角", 4:"1角", 5:"2分", 6:"2厘"]
        if self.bottomView.btnYuan.isSelected {
            yjf_Id = 1
        }
        else if self.bottomView.btnJiao.isSelected {
            yjf_Id = 3
        }
        else if self.bottomView.btnFen.isSelected {
            yjf_Id = 5
        }
        let jsContext = self.vm.jsReader_Algorithm()
        let jsFunc_runCalculate = jsContext.objectForKeyedSubscript("runCalculate")
        let dictPlayingMessage = (self.contentView.bdcTableView.model?.dictSelfModel)!
        let dictOrderMessage = [ "bettingPattern": yjf_Id,
                                 "multiple": Int(self.bottomView.tfInput.text ?? "1") ?? 1,
                                 "bettingPos": [ "pos": self.contentView.bdcTableView.dictCodeOfChosen ]
            ] as [String : Any]
        let jsResult = jsFunc_runCalculate?.call(withArguments: [dictPlayingMessage, dictOrderMessage])
        let jsResult_dict = jsResult?.toDictionary()
        self.bottomView.numbers = jsResult_dict!["numbers"] as? Int
        let jsAmount = jsResult_dict!["amount"] as? Int
        self.bottomView.amount = Float(jsAmount ?? 0)/Float(1000)
    }
}
