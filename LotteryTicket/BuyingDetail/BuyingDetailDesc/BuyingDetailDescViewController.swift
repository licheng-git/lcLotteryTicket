//
//  BuyingDetailDescViewController.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/16.
//  Copyright © 2017年 李诚. All rights reserved.
//

import UIKit

class BuyingDetailDescViewController: UIViewController {

    var selectedIndex = 0
    var id = String()
    var pid = String()
    var name = String()
    
    var strPlayRule: String?
    var strPrizeExample: String?
    private var bArrDataLoaded = false
    
    let selectBtnsView: bddSelectButtonsView = {
        let view = bddSelectButtonsView()
        return view
    } ()
    
    lazy var tvPlayRule: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.font = UIFont.systemFont(ofSize: 16)
        return tv
    } ()
    
    lazy var tvPrizeExample: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.font = UIFont.systemFont(ofSize: 16)
        return tv
    } ()
    
    lazy var viewPrizeDetail: PrizeDetailTableView = {
        //let view = PrizeDetailTableView()
        let view = PrizeDetailTableView(frame: .zero, style: .grouped)
        return view
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.addDefaultBackNavItem()
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.view.addSubview(self.selectBtnsView)
        self.selectBtnsView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kDEFAULT_MARGIN_Y)
            make.left.right.equalToSuperview()
            make.height.equalTo(bddSelectButtonsView.height)
        }
        
        self.view.addSubview(self.tvPlayRule)
        self.tvPlayRule.snp.makeConstraints { (make) in
            make.top.equalTo(self.selectBtnsView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
        self.tvPlayRule.isHidden = true
        self.tvPlayRule.text = self.strPlayRule
        
        self.view.addSubview(self.tvPrizeExample)
        self.tvPrizeExample.snp.makeConstraints { (make) in
            make.top.equalTo(self.selectBtnsView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
        self.tvPrizeExample.isHidden = true
        self.tvPrizeExample.text = self.strPrizeExample
        
        self.view.addSubview(self.viewPrizeDetail)
        self.viewPrizeDetail.snp.makeConstraints { (make) in
            make.top.equalTo(self.selectBtnsView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-5)
        }
        self.viewPrizeDetail.isHidden = true
        
        self.selectBtnsView.cBtnClick = { [weak self] (index, btnTitle) in
            self?.title = btnTitle
            if index == 0 {
                self?.tvPlayRule.isHidden = false
                self?.tvPrizeExample.isHidden = true
                self?.viewPrizeDetail.isHidden = true
            }
            else if index == 1 {
                self?.tvPlayRule.isHidden = true
                self?.tvPrizeExample.isHidden = false
                self?.viewPrizeDetail.isHidden = true
            }
            else if index == 2 {
                self?.tvPlayRule.isHidden = true
                self?.tvPrizeExample.isHidden = true
                self?.viewPrizeDetail.isHidden = false
                if !(self?.bArrDataLoaded)! {
                    PrizeDetail_ViewModel().getData((self?.pid)!, self?.navigationController?.view) { [weak self] (arrModels) in
                        self?.bArrDataLoaded = true
                        self?.viewPrizeDetail.arrModel = arrModels
                        self?.viewPrizeDetail.reloadData()
                    }
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.selectBtnsView.defaultClickedIndex = self.selectedIndex
    }

}
