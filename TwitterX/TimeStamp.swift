//
//  TimeStamp.swift
//  TwitterX
//
//  Created by Xavier on 9/12/22.
//

import Foundation

struct TimeStamp {
    static let shared = TimeStamp()
    
    func timestamp17(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "EST")
        dateFormatter.dateFormat = "yyyyMMddHHmmssSSS"
        return dateFormatter.string(from: date)
    }
}
