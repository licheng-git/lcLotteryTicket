//
//  BettingDetailViewController.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/9.
//  Copyright © 2017年 李诚. All rights reserved.
//

import UIKit
import SnapKit

class BettingDetailViewController: UIViewController {
    
    let vm = BettingDetail_ViewModel()
    
    @IBOutlet weak var imgviewIcon: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbPeriodNum: UILabel!
    @IBOutlet weak var btnResult: UIButton!
    @IBOutlet weak var lbPlayType: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbBetId: UILabel!
    @IBOutlet weak var lbBetAmount: UILabel!
    @IBOutlet weak var lbSendAmount: UILabel!
    @IBOutlet weak var lbPrizeNum: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "注单详情"
        self.addDefaultBackNavItem()
        self.imgviewIcon.layer.cornerRadius = 25
        self.imgviewIcon.clipsToBounds = true
        self.btnResult.layer.cornerRadius = 5
        self.btnResult.isEnabled = false

        self.vm.getData() { [weak self] (model) in
            self?.imgviewIcon.image = UIImage(named: model.iconImgName!)
            self?.lbTitle.text = model.title
            self?.lbPeriodNum.text = model.periodNum
            self?.btnResult.setTitle(model.result, for: .normal)
            self?.lbPlayType.text = model.playType
            self?.lbTime.text = model.time
            self?.lbBetId.text = model.betId
            self?.lbBetAmount.text = model.betAmount
            self?.lbSendAmount.text = model.sendAmount
            self?.lbPrizeNum.text = model.prizeNum
            self?.lbContent.text = model.content
        }
    }
    
}
