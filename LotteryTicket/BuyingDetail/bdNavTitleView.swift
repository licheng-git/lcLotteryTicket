//
//  bdNavTitleView.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/6.
//  Copyright © 2017年 李诚. All rights reserved.
//

class bdNavTitleView: UIView {
    
    var cBtnClick_Toggle: ((_ bToHidden:Bool)->Void)?

    lazy var btnTitle: UIButton = {
        let btn = UIButton()
        btn.frame = CGRect(x: 0, y: 0, width: 200, height: kNAVIGATION_HEIGHT)
        btn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
        btn.backgroundColor = UIColor.clear
        btn.setTitle("变化的title", for: .normal)
        btn.setImage(UIImage(named: "btn_arrow_down"), for: .normal)
        btn.setImage(UIImage(named: "btn_arrow_up"), for: .selected)  // 无动画效果
        // *_* frame
        //btn.layoutIfNeeded()
        //let btnImgSize = btn.currentImage!.size
        let btnImgSize = btn.imageView!.frame.size
        let btnLbSize = btn.titleLabel!.frame.size
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: -btnImgSize.width, bottom: 0, right: btnImgSize.width)
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, btnLbSize.width+10, 0, -btnLbSize.width)
        return btn
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.lcAddObservers()  // kvo监测btn.titleLabel.text
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func btnClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if self.cBtnClick_Toggle != nil {
            self.cBtnClick_Toggle!(sender.isSelected)
        }
    }
    
    
//    override func willMove(toSuperview newSuperview: UIView?) {
//        super.willMove(toSuperview: newSuperview)
//        if newSuperview == nil {
//            print("bdNavTitleView willMove disappear")
//            self.lcRemoveObservers()
//            return
//        }
//        print("bdNavTitleView willMove appear")
//        self.lcAddObservers()
//    }
    
    private var LC_KVO_Context = "LC_KVO_Content"
    
    @objc private func lcAddObservers() {
        self.btnTitle.addObserver(self, forKeyPath: #keyPath(UIButton.titleLabel.text), options: .new, context: &LC_KVO_Context)
        //self.addObserver(self, forKeyPath: #keyPath(btnTitle.titleLabel.text), options: .new, context: &LC_KVO_Context)
    }
    
    @objc private func lcRemoveObservers() {
        self.btnTitle.removeObserver(self, forKeyPath: "titleLabel.text", context: &LC_KVO_Context)
        //self.removeObserver(self, forKeyPath: "btnTitle.titleLabel.text", context: &LC_KVO_Context)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        //print("kvo *_* object=\(object), keyPath=\(keyPath), context=\(context)")
        if context != &LC_KVO_Context {
            return
        }
        if keyPath == #keyPath(UIButton.titleLabel.text) {
            let btn = object as! UIButton
        //if keyPath == "btnTitle.titleLabel.text" {
        //    let btn = (object as! bdNavTitleView).btnTitle
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                let btnImgSize = btn.imageView!.frame.size
                let btnLbSize = btn.titleLabel!.frame.size
                btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: -btnImgSize.width, bottom: 0, right: btnImgSize.width)
                btn.imageEdgeInsets = UIEdgeInsetsMake(0, btnLbSize.width+10, 0, -btnLbSize.width)
            }
        }
    }
    
    deinit {
        self.lcRemoveObservers()
        print("bdNavTitleView deinit")
    }
    
//    func btnLayout_ReAdjust() {
//        let btn = self.btnTitle
//        btn.layoutIfNeeded()
//        btn.titleEdgeInsets = UIEdgeInsetsMake(0, -(btn.currentImage?.size.width)!, 0, (btn.currentImage?.size.width)!)
//        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: (btn.titleLabel?.bounds.width)!+10, bottom: 0, right: -(btn.titleLabel?.bounds.size.width)!)
//    }
    
}
