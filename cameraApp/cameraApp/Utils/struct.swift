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
    case text = "showText"
    case camera = "showCamera"
}

enum PortraitEffectsMatteDeliveryMode {
    case on
    case off
}

enum alert: String {
    case title = "save DB?"
    case message = "if you want save value to DB, click yes"
}
