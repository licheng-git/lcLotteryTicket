//
//  ApiConfig.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/20.
//  Copyright © 2017年 李诚. All rights reserved.
//

#if DEBUG
    let URL_Base = "http://centerapi.serverddc.com"
#else
    let URL_Base = ""
#endif

// 彩票列表
let URL_LotteryList  = URL_Base + "/lottery/lotteryList"
// 玩法
let URL_PlayingType  = URL_Base + "/playing/playingType"
let URL_PlayingGroup = URL_Base + "/playing/playingGroup"
// 奖金详情
let URL_PrizeDetail  = URL_Base + "/playing/getPrizeMoneyDetails"
