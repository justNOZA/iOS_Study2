//
//  Photomodel.swift
//  cameraApp
//
//  Created by Pasonatech on 2021/06/03.
//

import Foundation
import RealmSwift

protocol DBViewModelInput  {
    
    func getAllData() -> Results<PhotoValue>
    func sortedDataDB() -> Results<PhotoValue>
     
}

class DBViewModel: DBViewModelInput {
    
    let realm : Realm
    
    init(){
        realm = try! Realm()
    }
    
    func getAllData() -> Results<PhotoValue>{
        //get All Data
        return realm.objects(PhotoValue.self)
    }
     
    //sort get
    func sortedDataDB() -> Results<PhotoValue>{
        let data = realm.objects(PhotoValue.self).sorted(byKeyPath: "index", ascending: true) //오름차순
        return data
    }
 
}
