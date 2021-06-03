//
//  Photomodel.swift
//  cameraApp
//
//  Created by Pasonatech on 2021/06/03.
//

import Foundation
import RealmSwift

protocol PhotoModelInput  {
    func saveDataDB(_ list : [String]?)
    func getAllData() -> Results<PhotoValue>
    func deleteAllDB()
    func cleanDB()
    func updateDataDB(_ index : Int, _ value : String)
    func deleteOneDB(_ index : Int)
    func sortedDataDB() -> Results<PhotoValue>
}

class PhotoModel: PhotoModelInput {
    
    let realm : Realm
    
    init(){
        realm = try! Realm()
    }
    
    func saveDataDB(_ list : [String]?){
        //Add DB
        for i in list! {
            let setValue = PhotoValue()
            setValue.index = incrementalIndex()
            setValue.value = String(i)
            try! realm.write{
                realm.add(setValue)
            }
        }
    }
    
    func getAllData() -> Results<PhotoValue>{
        //get All Data
        return realm.objects(PhotoValue.self)
    }
    
    //index값 증가시켜서 가져오기
    func incrementalIndex() -> Int {
        return (realm.objects(PhotoValue.self).max(ofProperty: "index") as Int? ?? 0)+1
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
    
    //update DB
    func updateDataDB(_ index : Int, _ value : String){
        let userinfo = realm.objects(PhotoValue.self).filter("index == \(index)").first!
        try! realm.write {
            userinfo.value = value
        }
    }
    
    //delete select one _ imn clas
    func deleteOneDB(_ index : Int){
        let userinfo = realm.objects(PhotoValue.self).filter("index == \(index)").first!
        try! realm.write {
            realm.delete(userinfo)
        }
    }
    
    //sort get
    func sortedDataDB() -> Results<PhotoValue>{
        let data = realm.objects(PhotoValue.self).sorted(byKeyPath: "index", ascending: true) //오름차순
        return data
    }
}
