//
//  BannerView.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/10/31.
//  Copyright © 2017年 李诚. All rights reserved.
//

//import UIKit
//import SnapKit
//
//class BannerView: UIScrollView {
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//}


import UIKit
import SnapKit
import FSPagerView

class BannerView: UIView, FSPagerViewDataSource, FSPagerViewDelegate {
    
    //var arrImgName = [String]()
    var arrImgName = [ "banner", "banner1", "banner", "banner1" ]
    //var arrImgName = [ "", "", "", "" ]
    
    lazy var fsPagerView: FSPagerView = {
        let view = FSPagerView()
        view.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "fsCell")
        view.delegate = self
        view.dataSource = self
        view.automaticSlidingInterval = 3.0
        return view
    } ()
    
    lazy var fsPageControl: FSPageControl = {
        let control = FSPageControl()
        control.contentHorizontalAlignment = .right
        return control
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.fsPagerView)
        self.fsPagerView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }
        self.fsPagerView.addSubview(self.fsPageControl)
        self.fsPageControl.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(20)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        self.fsPageControl.numberOfPages = self.arrImgName.count
        return self.arrImgName.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "fsCell", at: index)
        cell.imageView?.image = UIImage(named: self.arrImgName[index])
        return cell
    }
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        self.fsPageControl.currentPage = pagerView.currentIndex
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
        self.fsPageControl.currentPage = index
        print("didSelectItemAt \(index)")
    }
    
}
