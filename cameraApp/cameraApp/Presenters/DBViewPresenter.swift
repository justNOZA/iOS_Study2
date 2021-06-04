//
//  PhotoPresenter.swift
//  cameraApp
//
//  Created by Pasonatech on 2021/06/03.
//

import Foundation
import RealmSwift

protocol DBViewPresenterInput: AnyObject {

    func getAllData() -> [(Int, [String], (String,String))]
    func sortedDataDB() -> [(Int, [String], String)]
    
}

class DBViewPresenter: DBViewPresenterInput {
   
    weak var view: DBViewController!
    var model: DBViewModelInput
    var ocr: OCRReading

    init(view: DBViewController) {
        self.view = view
        self.model = DBViewModel()
        self.ocr = OCRReading()
    }

    
    func getAllData() -> [(Int, [String], (String,String))]{
        let result = model.getAllData()
        var data: [(Int, [String], (String,String))] = []
        for i in result.elements {
            let value = [i.product_Name, i.Velocity_At_40_or_50, i.COQ_Density, i.Water_Constraint, i.Flush_Point, i.Sulphur_Content]
            if i.update_dateTime == "0000/00/00" {
                data.append((i.index, value, (i.create_dateTime, "no update")))
            }else {
                data.append((i.index, value, (i.create_dateTime, i.update_dateTime)))
            }
        }
        //get All Data
        return data
    }

    //sort get
    func sortedDataDB() -> [(Int, [String], String)]{
        let result = model.sortedDataDB()
        var data: [(Int, [String], String)] = []
        for i in result.elements {
            let value = [i.product_Name, i.Velocity_At_40_or_50, i.COQ_Density, i.Water_Constraint, i.Flush_Point, i.Sulphur_Content]
            if i.update_dateTime == "0000/00/00" {
                data.append((i.index, value, i.create_dateTime))
            }else {
                data.append((i.index, value, i.update_dateTime))
            }
        }
        //get All Data
        return data
    }
    
}
