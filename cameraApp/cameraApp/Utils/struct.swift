//
//  SessionResult.swift
//  cameraApp
//
//  Created by Pasonatech on 2021/05/28.
//

import Foundation

enum SessionSetupResult {
    case success
    case notAuthorized
    case configurationFailed
}

enum toView: String {
    case db = "showDB"
    case text = "showText"
    case camera = "showCamera"
}

enum PortraitEffectsMatteDeliveryMode {
    case on
    case off
}

enum alertSave: String {
    case title = "save DB?"
    case message = "if you want save value to DB, click yes"
}

enum alertDel: String {
    case title = "delete DB?"
    case message = "if you want delete all of DB, click yes"
}

struct categoryName {
    let list = ["Product Name", "Velocity At 40 or 50", "COQ Density", "Water Constraint", "Flush Point", "Sulphur Content"]
}
