//
//  Photomodel.swift
//  cameraApp
//
//  Created by Pasonatech on 2021/06/03.
//

import Foundation
import RealmSwift

protocol PhotoModelInput  {
    func deleteAllDB()
    func cleanDB()
    func deleteOneDB(_ index : Int)
    func saveDataDB(_ info: [String], _ time: String)
    func updateDataDB(_ index : Int, _ value : String, _ name : Int, _ time: String)
}

class PhotoModel: PhotoModelInput {
    
    let realm : Realm
    
    init(){
        realm = try! Realm()
    }
    //delete All _ in class
    func deleteAllDB(){
        //get All data from DB
        let models = realm.objects(PhotoValue.self)
        do {
            try! realm.write{
                realm.delete(models)
            }
        }
    }
    
    // all class clear
    func cleanDB(){
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    //delete select one _ imn clas
    func deleteOneDB(_ index : Int){
        let userinfo = realm.objects(PhotoValue.self).filter("index == \(index)").first!
        try! realm.write {
            realm.delete(userinfo)
        }
    }
    
    //update DB
    func updateDataDB(_ index : Int, _ value : String, _ name : Int, _ time: String){
        let userinfo = realm.objects(PhotoValue.self).filter("index == \(index)").first!
        try! realm.write {
            switch name {
            case 0: userinfo.product_Name = value
            case 1: userinfo.Velocity_At_40_or_50 = value
            case 2: userinfo.COQ_Density = value
            case 3: userinfo.Water_Constraint = value
            case 4: userinfo.Flush_Point = value
            case 5: userinfo.Sulphur_Content = value
            default: return
            }
            userinfo.update_dateTime = time
        }
    }
    
    func saveDataDB(_ info: [String], _ time: String){
        //Add DB
        let setValue = PhotoValue()
        setValue.index = incrementalIndex()
        setValue.product_Name = info[0]
        setValue.Velocity_At_40_or_50 = info[1]
        setValue.COQ_Density = info[2]
        setValue.Water_Constraint = info[3]
        setValue.Flush_Point = info[4]
        setValue.Sulphur_Content = info[5]
        setValue.create_dateTime = time
        try! realm.write{
            realm.add(setValue)
        }
    }
    //index값 증가시켜서 가져오기
    func incrementalIndex() -> Int {
        return (realm.objects(PhotoValue.self).max(ofProperty: "index") as Int? ?? 0)+1
    }
}
