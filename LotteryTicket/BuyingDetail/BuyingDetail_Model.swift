//
//  BuyingDetail_Model.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/13.
//  Copyright © 2017年 李诚. All rights reserved.
//

class bdNavRightTable_Cell_Model: NSObject {
    var id: String?
    var pid: String?
    var iconImgName: String?
    var name: String?
    var alias: String?
}


class bdNavTitleDetail_BtnModel: NSObject {
    var playId: String?
    var playPid: String?
    var name: String?
}

class bdNavTitleDetail_SectionModel: NSObject {
    var title:String?
    var arrBtnModel: [bdNavTitleDetail_BtnModel]?
}


class bdTimer_Model:NSObject {
    var countdown: Int?
    var currentNumber: String?
    var sellNumber: String?
}

class bdPrizeResult_Cell_Model: NSObject {
    var periodNum: String?
    var prizeNum: String?
}


class bdContent_Model: NSObject {
    var playId: String?
    var playPid: String?
    var name: String?
//    var area: [[String:Any]]?  // 玩法配置 行  [{"id":"a","title":"x位","rule":1}, ...]
//    var list: [[String:Any]]?  // 玩法配置 列  [{"id":"0","name":"0"},{"id":"1","name":"龙"},{"id":"2","name":"豹子"}, ...]
//    var area_pos: [String:Any]?   // 玩法位置配置（特殊玩法） {"title":"选择位置","pos":{},"choose":[],"rule":4}
    var area: [bdContent_Area_Model]?
    var list: [bdContent_List_Model]?
    var area_pos: bdContent_AreaPos_Model?
    var explain: String?       // 玩法规则
    var example: String?       // 中奖举例
    var note_operation: Int?   // 是否需要操作 1是2否  （全、大、小、单、双、清）
    //var equal: Int?            // js校验  是否需要检测重号  1否2是
    var length: Int?           // 至少要选几行，若为0则全部要选（if lenght == 0 -> length = area.count）
    //var playing: String?       // js计算 注数+金额  算法名称
    //var base_note: Int?        // js计算 注数+金额  注数基数，0为特殊计算
    
    //func runtimeToDict() -> Dictionary { ... }
    var dictSelfModel: [String:Any]?
}

// 玩法位置配置（特殊玩法）
class bdContent_AreaPos_Model: NSObject {
    var title: String?
    var pos: [String:Any]?  // {areaId:areaTitle}
    var choose: [String]?   // [areaId, ...]
    //var rule: Int?          // js校验 choose的最少个数
}

// 玩法配置 行
class bdContent_Area_Model: NSObject {
    var id: String?
    var title: String?
    var length: Int?  // 最多可选个数，为空表示全部可选。（如果点击超出就把第一个去掉）
    //var rule: Int?    // js校验  单行满足验证 最少需要选择的个数
}

// 玩法配置 列
class bdContent_List_Model: NSObject {
    var id: Int?
    var name: String?
}

