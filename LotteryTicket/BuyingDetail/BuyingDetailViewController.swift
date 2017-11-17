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
    
    var detailId = String()
    
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
        self.navTitleDetailView.cBtnClick_Cell = { [weak self] (btnTitle) in
            self?.navTitleView.btnTitle.isSelected = false
            self?.navTitleView.btnTitle.setTitle(btnTitle, for: .normal)
        }
        self.navTitleDetailView.cBtnClick_Header = { [weak self] (cell0Btn0Title) in
            self?.navTitleView.btnTitle.setTitle(cell0Btn0Title, for: .normal)
        }
        self.navTitleView.btnTitle.setTitle("定位胆", for: .normal)
        
        let navItem_right = UIBarButtonItem()
        navItem_right.style = .plain
        navItem_right.image = UIImage(named: "navItem_menu")
        navItem_right.target = self
        navItem_right.action = #selector(navItemClick_Right(_:))
        navItem_right.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = navItem_right
        self.navRightTableView.cCellSelect = { [weak self] (cellId) in
            self?.timerView.lbTitle.text = cellId
        }
        
        self.view.addSubview(self.timerView)
        self.timerView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kDEFAULT_MARGIN_Y)
            make.left.right.equalToSuperview()
            make.height.equalTo(bdTimerView.Height)
        }
        self.timerView.lbTitle.text = self.detailId
        self.timerView.lbPeriodNum.text = "1711130531期"
        self.timerView.startTimer(80)
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
        self.prizeResultView.lbPeriodNum.text = "1711130530期开奖号码"
        self.prizeResultView.fSetResult("64620")
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
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            else if index == 3 {
                let vc = BettingRecordsViewController()
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }

        self.view.addSubview(self.bottomView)
        self.bottomView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(bdBottomView.height)
        }
        
    }
    
    @objc private func navItemClick_Right(_ sender: UIBarButtonItem) {
        self.navTitleDetailView.removeFromSuperview()
        self.navTitleView.btnTitle.isSelected = false
        
        if self.navRightTableView.bIsShowing {
            self.navRightTableView.remove()
        }
        else {
            self.view.addSubview(self.navRightTableView)
            if self.navRightTableView.arrModel.count == 0 {
                self.vm.getData_NavRightTable { [weak self] (arrModels) in
                    self?.navRightTableView.arrModel = arrModels
                    self?.navRightTableView.myTableview.reloadData()
                }
            }
        }
    }
    
    deinit {
        print("BuyDetailViewController deinit")
        self.timerView.stopTimer()
    }
    
}
