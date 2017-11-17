//
//  AccountView.swift
//  LotteryTicket
//
//  Created by 李诚 on 17/10/30.
//  Copyright © 2017年 李诚. All rights reserved.
//

import UIKit

class AccountView: UIView {
    
    @IBOutlet weak var lbAccount: UILabel!
    @IBOutlet weak var lbBalance: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
    }
    
}
