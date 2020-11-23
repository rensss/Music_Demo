//
//  Utils.swift
//  Music
//
//  Created by RZK on 2020/11/22.
//

import Foundation

class Utils: NSObject {
    static func getFormatTime(duration: Int) -> String {
        let min = duration/60
        let second = duration%60
        return "\(min):\(second)"
    }
}
