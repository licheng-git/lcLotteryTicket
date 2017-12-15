//
//  AnnounceInforDetailsViewController.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/12/15.
//  Copyright © 2017年 李诚. All rights reserved.
//

import UIKit

class AnnounceInforDetailsViewController: UIViewController {
    
    var model: AnnounceInfor_Model?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "公告信息"
        self.view.backgroundColor = UIColor.white
        self.addDefaultBackNavItem()
        
        if self.model == nil {
            return
        }
        
        let lbTitle = UILabel()
        lbTitle.text = self.model!.title
        lbTitle.textAlignment = .left
        lbTitle.font = UIFont.systemFont(ofSize: 18)
        lbTitle.numberOfLines = 0
        self.view.addSubview(lbTitle)
        lbTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kDEFAULT_MARGIN_Y+10)
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            //make.height.equalTo(0)
        }
        
        let imgviewTime = UIImageView()
        imgviewTime.backgroundColor = UIColor.red
        self.view.addSubview(imgviewTime)
        imgviewTime.snp.makeConstraints { (make) in
            make.width.height.equalTo(20)
            make.left.equalTo(lbTitle)
            make.top.equalTo(lbTitle.snp.bottom).offset(10)
        }
        let lbTime = UILabel()
        lbTime.text = self.model!.time
        lbTime.textAlignment = .left
        lbTime.textColor = UIColor.gray
        lbTime.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(lbTime)
        lbTime.snp.makeConstraints { (make) in
            make.height.equalTo(21)
            make.centerY.equalTo(imgviewTime)
            make.left.equalTo(imgviewTime.snp.right).offset(5)
            make.right.equalToSuperview().offset(-5)
        }
        
        let lineview = UIView()
        lineview.backgroundColor = UIColor.lightGray
        self.view.addSubview(lineview)
        lineview.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.left.right.equalTo(lbTitle)
            make.top.equalTo(imgviewTime.snp.bottom).offset(10)
        }
        
        let tvHtmlContent = UITextView()
        //self.model!.htmlContent = "<p>哈哈&nbsp;abcde<br/>asdfsadf</p>"
        //self.model!.htmlContent = "&lt;p&gt;&lt;strong&gt;&lt;em&gt;公告gads 发短发时代&lt;/em&gt;&lt;/strong&gt;&lt;/p&gt;"
        let attrData = self.model!.htmlContent?.data(using: .unicode)
        let attrOptions = [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType]
        //tvHtmlContent.attributedText = try? NSAttributedString(data: attrData!, options: attrOptions, documentAttributes: nil)
        let attrStr = try? NSAttributedString(data: attrData!, options: attrOptions, documentAttributes: nil)
        let htmlStr1 = attrStr?.string
        let attrData1 = htmlStr1?.data(using: .unicode)
        tvHtmlContent.attributedText = try? NSAttributedString(data: attrData1!, options: attrOptions, documentAttributes: nil)
        tvHtmlContent.isEditable = false
        tvHtmlContent.font = UIFont.systemFont(ofSize: 16)
        self.view.addSubview(tvHtmlContent)
        tvHtmlContent.snp.makeConstraints { (make) in
            make.left.right.equalTo(lbTitle)
            make.top.equalTo(lineview.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
}
