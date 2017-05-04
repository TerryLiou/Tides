//
//  Extension.swift
//  Tides
//
//  Created by 劉洧熏 on 2017/4/30.
//  Copyright © 2017年 劉洧熏. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration

// MARK: - isConnectedToNetwork

public class Reachability {
    
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        /* Only Working for WIFI
         let isReachable = flags == .reachable
         let needsConnection = flags == .connectionRequired
         
         return isReachable && !needsConnection
         */
        
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
        
    }
}

// MARK: - colorWithHexvalue

extension UIColor {
    
    convenience init(colorWithHexvalue value: Int, alpha: CGFloat = 1.0){
        
        self.init(
            
            red: CGFloat((value & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((value & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(value & 0x0000FF) / 255.0,
            alpha: alpha)
        
    }
}

// MARK: - StringExtension

extension String {
    
    func getIndexFromStart(to index: Int) -> Index {
        
        return self.index(startIndex, offsetBy: index)
        
    }
    
    func getIndexFromEnd(to index: Int) -> Index {
        
        return self.index(endIndex, offsetBy: index)
        
    }
}

// MARK: - DateExtension

extension Date {

    static func getTodayDateOfString(_ text: String) -> String {

        let formatter = DateFormatter()
        let currentDate = Date()

        formatter.dateFormat = text

        return formatter.string(from: currentDate)

    }

    static func getTodayDateOfStringAndDate(_ text: String, _ date: Date) -> String {
        
        let formatter = DateFormatter()
        let date = date
        
        formatter.dateFormat = text
        
        return formatter.string(from: date)
        
    }
}
