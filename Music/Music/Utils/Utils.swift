//
//  Utils.swift
//  Music
//
//  Created by RZK on 2020/11/22.
//

import Foundation

class Utils: NSObject {
    static func getFormatDuration(duration: Int) -> String {
        let min = duration/60
        var minStr = ""
        if min < 10 {
            minStr = "0\(min)"
        } else {
            minStr = "\(min)"
        }
        
        let second = duration%60
        var secondStr = ""
        if second < 10 {
            secondStr = "0\(second)"
        } else {
            secondStr = "\(second)"
        }
        
        return minStr + ":" + secondStr
    }
}
