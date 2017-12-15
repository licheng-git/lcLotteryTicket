//
//  Tools.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/12/1.
//  Copyright © 2017年 李诚. All rights reserved.
//

//#import <CommonCrypto/CommonDigest.h>

class Tools {
    
    static func getIP(_ remoteDomain: String) -> String? {
        
        let host = CFHostCreateWithName(nil, remoteDomain as CFString).takeRetainedValue()
        CFHostStartInfoResolution(host, .addresses, nil)
        var dbSuccess: DarwinBoolean = false
        let arrAddress = CFHostGetAddressing(host, &dbSuccess)?.takeUnretainedValue() as? Array<Any>
        if arrAddress == nil || arrAddress?.count == 0 || dbSuccess == false {
            return nil
        }
        let dataAddress = arrAddress?.first as? NSData
        if dataAddress == nil {
            return nil
        }
        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
        let intNameInfo = getnameinfo(dataAddress?.bytes.assumingMemoryBound(to: sockaddr.self),
                                      socklen_t(dataAddress!.length), &hostname, socklen_t(hostname.count),
                                      nil, 0, NI_NUMERICHOST)
        if intNameInfo != 0 {
            return nil
        }
        let ip = String(cString: hostname)
        //print("ip:\(ip)")
        return ip
        
    }
    
    
    static func MD5(_ str: String) -> String {
        let cStr = str.cString(using: .utf8)
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
        CC_MD5(cStr!, CC_LONG(strlen(cStr!)), buffer)
        let md5Str = NSMutableString();
        for i in 0..<16 {
            md5Str.appendFormat("%02x", buffer[i])
        }
        return md5Str as String
    }
    
    
    static func convertTimestamp(_ timestamp:Int) -> String {
        //let ti = Double(exactly: timestamp)! / 1000.0
        let ti = Double(exactly: timestamp)!
        let d = Date(timeIntervalSince1970: ti)
        let dFormatter = DateFormatter()
        dFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dFormatter.string(from: d)
    }
    
}
