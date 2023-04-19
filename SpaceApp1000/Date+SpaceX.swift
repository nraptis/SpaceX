//
//  Date+SpaceX.swift
//  SpaceApp1000
//
//  Created by Tiger Nixon on 4/13/23.
//

import Foundation

extension Date {
    
    static func fromSpaceXString(string: String?) -> Date? {
        guard let string = string else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter.date(from: string)
    }
    
    func toYYYYMMDD() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
}
