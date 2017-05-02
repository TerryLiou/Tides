//
//  Extension.swift
//  Tides
//
//  Created by 劉洧熏 on 2017/4/30.
//  Copyright © 2017年 劉洧熏. All rights reserved.
//

import Foundation
import UIKit

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

extension String {
    
    func getIndexFromStart(to index: Int) -> Index {
        
        return self.index(startIndex, offsetBy: index)
        
    }
    
    func getIndexFromEnd(to index: Int) -> Index {
        
        return self.index(endIndex, offsetBy: index)
        
    }
}

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
