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

//class PhotoValue2 : Object {
//    @objc dynamic var index = 0
//    @objc dynamic var value = ""
//    
//    override static func primaryKey() -> String? {
//        return "index"
//    }
//}
// if you make object -> RealDB make class table
//but you did delete object class but RealDB have class table not delete

//class PhotoValue3 : Object {
//    @objc dynamic var index = 0
//    @objc dynamic var value = ""
//
//    override static func primaryKey() -> String? {
//        return "index"
//    }
//}

/*
 delete Calss
 
 
 change Class
 
 
 extends Class
 constraint or cascade
 class Animal: Object {
     @objc dynamic var age = 0
 }

 // Models composed with Animal
 class Duck: Object {
     @objc dynamic var animal: Animal? = nil
     @objc dynamic var name = ""
 }
 class Frog: Object {
     @objc dynamic var animal: Animal? = nil
     @objc dynamic var dateProp = Date()
 }

 
 https://docs.mongodb.com/realm-legacy/docs/swift/latest/index.html
 */
