//
//  PhotoPresenter.swift
//  cameraApp
//
//  Created by Pasonatech on 2021/06/03.
//

import Foundation
import RealmSwift

protocol PhotoPresenterInput: AnyObject {
    func saveDataDB(_ list : [String]?)
    func getAllData() -> ([Int], [String])
    func deleteAllDB()
    func cleanDB()
    func updateDataDB(_ index : Int, _ value : String)
    func deleteOneDB(_ index : Int)
    func sortedDataDB() -> ([Int], [String])
    
    func readImage(_ image: UIImage) -> [String]
}

class PhotoPresenter: PhotoPresenterInput {
    
    weak var view: PhotoTextController!
    var model: PhotoModelInput
    var ocr: OCRReading

    init(view: PhotoTextController) {
        self.view = view
        self.model = PhotoModel()
        self.ocr = OCRReading()
    }
    
    func saveDataDB(_ list : [String]?){
        model.saveDataDB(list)
    }
    
    func getAllData() -> ([Int], [String]){
        let result = model.getAllData()
        var index : [Int] = []
        var value : [String] = []
        for i in result.elements {
            index.append(i.index)
            value.append(i.value)
        }
        //get All Data
        return (index, value)
    }
    
    //delete All _ in class
    func deleteAllDB(){
        model.deleteAllDB()
    }
    
    // all class clear
    func cleanDB(){
        model.cleanDB()
    }
    
    //update DB
    func updateDataDB(_ index : Int, _ value : String){
        model.updateDataDB(index, value)
    }
    
    //delete select one _ imn clas
    func deleteOneDB(_ index : Int){
        model.deleteOneDB(index)
    }
    
    //sort get
    func sortedDataDB() -> ([Int], [String]){
        let result = model.sortedDataDB()
        var index : [Int] = []
        var value : [String] = []
        for i in result.elements {
            index.append(i.index)
            value.append(i.value)
        }
        //get All Data
        return (index, value)
    }
    
    func readImage(_ image: UIImage) -> [String] {
        return ocr.ocrRequest(image: image)!
    }
}
