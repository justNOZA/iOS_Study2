//
//  PhotoPresenter.swift
//  cameraApp
//
//  Created by Pasonatech on 2021/06/03.
//

import Foundation
import RealmSwift

protocol PhotoPresenterInput: AnyObject {
    func saveDataDB(_ list : [(name:String,value:String)]?)
    func getAllData() -> [(Int, String)]
    func deleteAllDB()
    func cleanDB()
    func updateDataDB(_ index : Int, _ value : String)
    func deleteOneDB(_ index : Int)
    func sortedDataDB() -> [(Int, String)]
    
    func readImage(_ image: (UIImage, UIImage)) -> [(String, String)]
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
    
    func saveDataDB(_ list : [(name:String,value:String)]?){
        model.saveDataDB(list)
    }
    
    func getAllData() -> [(Int, String)]{
        let result = model.getAllData()
        var rValue : [(Int,String)] = []
        for i in result.elements {
            rValue.append((i.index, i.value))
        }
        //get All Data
        return rValue
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
    func sortedDataDB() -> [(Int,String)]{
        let result = model.sortedDataDB()
        var rValue : [(Int,String)] = []
        for i in result.elements {
            rValue.append((i.index, i.value))
        }
        //get All Data
        return rValue
    }
    
    func readImage(_ image: (UIImage, UIImage)) -> [(String, String)] {
        
        let list = categoryName()
        var resultData : [(String, String)] = []
        
        var result = ocr.ocrRequest(image: image.0)!
        for i in 0..<result.count {
            resultData.append((list.first[i%4],result[i]))
        }
        
        result = ocr.ocrRequest(image: image.1)!
        for i in 0..<result.count {
            resultData.append((list.second[i%2],result[i]))
        }
        return resultData
    }
}
