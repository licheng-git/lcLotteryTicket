//
//  UIView+Extension.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/17.
//  Copyright © 2017年 李诚. All rights reserved.
//

extension UIView {
    
    func extCopy_deep() -> UIView {
        let dataKA = NSKeyedArchiver.archivedData(withRootObject: self)
        let newView = NSKeyedUnarchiver.unarchiveObject(with: dataKA) as! UIView
        return newView
        
        // string,array等基本数据类型可以直接copy(),mutableCopy()
        // view等 和 自定义类    拷贝需实现协议copyWithZone
    }
    
}
