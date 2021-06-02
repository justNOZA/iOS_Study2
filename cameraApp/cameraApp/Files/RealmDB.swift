//
//  RealmDB.swift
//  cameraApp
//
//  Created by Pasonatech on 2021/06/02.
//

import RealmSwift

class PhotoValue : Object {
    @objc dynamic var index = 0
    @objc dynamic var value = ""
    
    override static func primaryKey() -> String? {
        return "index"
    }
}
