//
//  ApiConfig.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/20.
//  Copyright © 2017年 李诚. All rights reserved.
//

#if DEBUG
    private let URL_Base      = "http://centerapi.serverddc.com"
    private let URL_Cash      = "http://cashapi.serverddc.com"          // 账户相关
    public  let URL_WebSocket = "http://push.pushsystem.serverddc.com"  // 开奖结果 websocket
    private let URL_Push      = "http://api.pushsystem.serverddc.com"   // 倒计时+开奖结果历史
#else
    private let URL_Base      = "http://centerapi.serverddc.com"
    private let URL_Cash      = "http://cashapi.serverddc.com"
    public  let URL_WebSocket = "http://push.pushsystem.serverddc.com"
    private let URL_Push      = "http://api.pushsystem.serverddc.com"
#endif


let URL_LotteryList     = URL_Base + "/lottery/lotteryList"               // 彩票列表
let URL_PlayingType     = URL_Base + "/playing/playingType"               // 玩法
let URL_PlayingGroup    = URL_Base + "/playing/playingGroup"              // 玩法组
let URL_PrizeDetail     = URL_Base + "/playing/getPrizeMoneyDetails"      // 奖金详情
let URL_Timer           = URL_Push + "/drawCountdowns/"  // + alias       // 彩票详情 倒计时
let URL_PrizeHistory    = URL_Push + "/drawResults/"  // + alias          // 彩票详情 开奖结果历史
let URL_Betting         = URL_Base + "/order/orderBetting"                // 下注
let URL_LotteryResults  = URL_Base + "/lottery/lotteryResults"            // 开奖结果列表

let URL_OwnerInfo       = URL_Cash + "/memberApi/siteInfo/ownerInfo"      // 会员中心根据域名获取业主
let URL_ValidateCode    = URL_Cash + "/memberApi/member/getVerifyCode"    // 验证码图片地址
let URL_Register        = URL_Cash + "/memberApi/member/register"         // 注册
let URL_Login           = URL_Cash + "/memberApi/member/login"            // 登录
let URL_Logout          = URL_Cash + "/memberApi/member/logout"           // 退出
let URL_NoticeList      = URL_Cash + "/memberApi/notice/list"                 // 公告信息列表
