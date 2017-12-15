//
//  WebViewController_html.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/12/6.
//  Copyright © 2017年 李诚. All rights reserved.
//

import UIKit
import SnapKit
import JavaScriptCore

class WebViewController_html: UIViewController {
    
    private let webview = UIWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addDefaultBackNavItem()
        self.view.addSubview(self.webview)
        self.automaticallyAdjustsScrollViewInsets = false
        self.webview.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kDEFAULT_MARGIN_Y)
            make.left.right.bottom.equalToSuperview()
        }
        //self.webview.isHidden = true
        
//        let htmlFilePath = Bundle.main.path(forResource: "dbPrizeResult.html", ofType: nil)
//        let htmlFileUrl = URL(fileURLWithPath: htmlFilePath!)
//        let request = URLRequest(url: htmlFileUrl)
//        self.webview.loadRequest(request)
        
        let htmlFilePath = Bundle.main.path(forResource: "dbPrizeResult.html", ofType: nil)
        let htmlStr = try! String(contentsOfFile: htmlFilePath!, encoding: .utf8)
        //self.webview.loadHTMLString(htmlStr, baseURL: nil)  // js websocket err
        let baseUrl = URL(fileURLWithPath: Bundle.main.bundlePath)
        self.webview.loadHTMLString(htmlStr, baseURL: baseUrl)
        
        
        let jsContext = webview.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext") as? JSContext
        jsContext?.exceptionHandler = { (c, exception) in
            print("js异常 \(String(describing: exception))")
            c?.exception = exception
        }
        
        //jsContext?["iosFunc_popVC"] = {  // swift中去掉了[Subscript]方式
        //let cFunc_popVC: ()->String = {  // js err
        let cFunc_popVC: @convention(block) ()->String = { [weak self] in
            let arrArgs = JSContext.currentArguments() ?? [Any]()
            for arg in arrArgs {
                print("iOS*_* \(arg)")
            }
            self?.navigationController?.popViewController(animated: true)
            return "iOS*_*"
        }
        jsContext?.setObject(cFunc_popVC, forKeyedSubscript: "iosFunc_popVC" as NSCopying & NSObjectProtocol)
        
        let model = SwiftJavascriptModel()
        model.vc = self
        model.jsContext = jsContext
        jsContext?.setObject(model, forKeyedSubscript: "SwiftJavascriptBridge" as NSCopying & NSObjectProtocol)
    }
    
//    func webViewDidFinishLoad(_ webView: UIWebView) {
//    }
    
}


//protocol SwiftJavascriptDelegate: JSExport {  // js err
@objc protocol SwiftJavascriptDelegate: JSExport {
    func iosFunc_popVC1(_ param0:String, _ param1:Int, _ param2:Bool, _ param3:[String:Any]) -> String
}

class SwiftJavascriptModel: NSObject, SwiftJavascriptDelegate {
    weak var vc: UIViewController?
    weak var jsContext: JSContext?
    
    func iosFunc_popVC1(_ param0:String, _ param1:Int, _ param2:Bool, _ param3:[String:Any]) -> String {
        print("iOS*_* \(param0), \(param1), \(param2), \(param3)")
        self.vc?.navigationController?.popViewController(animated: true)
        return "iOS*_*"
    }
}

