//
//  LotteryHallViewController.swift
//  LotteryTicket
//
//  Created by 李诚 on 17/10/26.
//  Copyright © 2017年 李诚. All rights reserved.
//

import UIKit
import SnapKit

class LotteryHallViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let vm = LotteryHall_ViewModel()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kSCREEN_WIDTH/3-1, height: 100)
        layout.minimumLineSpacing = 0.5
        layout.minimumInteritemSpacing = 0.5
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(LotteryHall_CollectionCell.classForCoder(), forCellWithReuseIdentifier: "Cell")
        collectionView.register(LotteryHall_CollectionSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "SectionHeader")
        return collectionView
    } ()
    
    lazy var headerView: UIView = {
        let view = UIView()
        return view
    } ()
    
//    lazy var bannerView: BannerView = {
//        let view = BannerView()
//        return view
//    } ()
    lazy var bannerView: UIImageView = {
        let imgview = UIImageView()
        imgview.image = UIImage(named: "banner")
        return imgview
    } ()
    
    lazy var runningTipView: RunningTipView = {
        let view = RunningTipView()
        return view
    } ()
    
    lazy var accountView: AccountView = {
        let arr = Bundle.main.loadNibNamed("AccountView", owner: nil, options: nil)
        let view = arr![0] as! AccountView
        return view
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "卡司秀彩票"
        
//        // 滚动headerView
//        self.automaticallyAdjustsScrollViewInsets = false
//        self.view.addSubview(self.collectionView)
//        self.collectionView.frame = CGRect(x: 0, y: kDEFAULT_MARGIN_Y, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT-kDEFAULT_MARGIN_Y-kBOTTOM_HEIGHT)
//        //self.collectionView.snp.makeConstraints { (make) in
//        //    make.top.equalToSuperview().offset(kDEFAULT_MARGIN_Y)
//        //    make.left.right.equalToSuperview()
//        //    make.bottom.equalToSuperview().offset(-kBOTTOM_HEIGHT)
//        //}
//        
//        let headerView_H: CGFloat = 200.0
//        self.collectionView.contentInset = UIEdgeInsetsMake(headerView_H, 0, 0, 0)
//        self.collectionView.addSubview(self.headerView)
//        self.headerView.frame = CGRect(x: 0, y: -(headerView_H), width: self.collectionView.bounds.size.width, height: headerView_H)
//        //self.headerView.snp.makeConstraints { (make) in
//        //    make.top.equalToSuperview().offset(0-headerView_H)
//        //    make.left.right.equalToSuperview()  // *_* right err
//        //    make.height.equalTo(headerView_H)
//        //}
//        
//        self.headerView.addSubview(self.bannerView)
//        self.bannerView.frame = CGRect(x: 0, y: 0, width: headerView.bounds.size.width, height: headerView.bounds.size.height-50)
//        //self.bannerView.snp.makeConstraints { (make) in
//        //    make.top.left.right.equalToSuperview()
//        //    make.height.equalToSuperview().offset(-80)
//        //}
        
        // 固定headerView
        self.view.addSubview(self.headerView)
        self.headerView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kDEFAULT_MARGIN_Y)
            make.left.right.equalToSuperview()
            make.height.equalTo(200)
        }
        self.headerView.addSubview(self.bannerView)
        self.bannerView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalToSuperview().offset(-80)
        }
        self.headerView.addSubview(self.runningTipView)
        self.runningTipView.snp.makeConstraints { (make) in
            make.top.equalTo(self.bannerView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(35)
        }
        self.headerView.addSubview(self.accountView)
        self.accountView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(35)
        }
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.headerView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-kBOTTOM_HEIGHT)
        }
        
        self.runningTipView.lbText.text = "----"
        self.runningTipView.lbText.sizeToFit()
        self.runningTipView.keepRunning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.collectionView.visibleCells.count == 0 {
            if kArrModels_LotteryHall.count == 0 {
                let delegateView = self.tabBarController?.navigationController?.view
                self.vm.getData_List(delegateView, { [weak self] (arrModels) in
                    self?.collectionView.reloadData()
                    }, nil)
            }
            else {
                self.collectionView.reloadData()
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return kArrModels_LotteryHall.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return kArrModels_LotteryHall[section].arrCellModels!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = "Cell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! LotteryHall_CollectionCell
        let model = kArrModels_LotteryHall[indexPath.section].arrCellModels![indexPath.row]
        cell.id = model.id!
        cell.pid = model.pid!
        cell.lbName.text = model.name
        cell.imgviewIcon.image = UIImage(named: model.iconImgName!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! LotteryHall_CollectionCell
        let vc = BuyingDetailViewController()
        vc.id = cell.id
        vc.pid = cell.pid
        vc.name = cell.lbName.text!
        self.tabBarController?.navigationController?.pushViewController(vc, animated: true)
        //self.tabBarController?.navigationController?.pushViewController(TimerTestViewController(), animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerIdentifier = "SectionHeader"
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerIdentifier, for: indexPath) as! LotteryHall_CollectionSectionHeaderView
        header.lbName.text = kArrModels_LotteryHall[indexPath.section].category
        return header
    }
    
}
