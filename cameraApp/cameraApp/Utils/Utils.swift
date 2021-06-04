//
//  Utils.swift
//  cameraApp
//
//  Created by Pasonatech on 2021/06/03.
//

import Foundation

class Utils {
    static func getDay() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.string(from: date)
    }
}
