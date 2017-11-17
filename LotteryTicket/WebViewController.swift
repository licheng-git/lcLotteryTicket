//
//  WebViewController.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/1.
//  Copyright © 2017年 李诚. All rights reserved.
//

import UIKit
import SnapKit
import MBProgressHUD

class WebViewController: UIViewController, UIWebViewDelegate {
    
    private let webview = UIWebView()
    
    var url_str: String? = nil {
        didSet {
            if (self.url_str?.isEmpty)! {
                return
            }
            let url = URL(string: self.url_str!)
            let request = URLRequest(url: url!)
            self.webview.loadRequest(request)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addDefaultBackNavItem()
        self.view.addSubview(self.webview)
        self.automaticallyAdjustsScrollViewInsets = false
        self.webview.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kDEFAULT_MARGIN_Y)
            make.left.right.bottom.equalToSuperview()
        }
        self.webview.delegate = self
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow!, animated: true)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        MBProgressHUD.hide(for: UIApplication.shared.keyWindow!, animated: true)
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        MBProgressHUD.hide(for: UIApplication.shared.keyWindow!, animated: true)
        let hud = MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow!, animated: true)
        hud.mode = .text
        hud.label.text = "网页加载失败"
        hud.hide(animated: true, afterDelay: 3.0)
    }
    
    
    
    
    //let webview1 = WKWebView()
}

