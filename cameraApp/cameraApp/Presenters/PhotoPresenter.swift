//
//  PhotoPresenter.swift
//  cameraApp
//
//  Created by Pasonatech on 2021/06/03.
//

import Foundation
import RealmSwift

protocol PhotoPresenterInput: AnyObject {
    func deleteAllDB()
    func cleanDB()
    func deleteOneDB(_ index : Int)
    
    func saveDataDB(_ list : [(name:String,value:String)]?)
    func updateDataDB(_ index : Int, _ value : String, _ name : String)

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
    //delete All _ in class
    func deleteAllDB(){
        model.deleteAllDB()
    }
    
    // all class clear
    func cleanDB(){
        model.cleanDB()
    }
    //delete select one _ imn clas
    func deleteOneDB(_ index : Int){
        model.deleteOneDB(index)
    }
    func saveDataDB(_ list : [(name:String,value:String)]?){
        var info:[String] = []
        for i in list! {
            info.append(i.value)
        }
        let time = Utils.getDay()
        model.saveDataDB(info, time)
    }
    //update DB
    func updateDataDB(_ index : Int, _ value : String, _ name : String){
        let list = categoryName()
        let num = list.list.lastIndex(of: name)!
        model.updateDataDB(index, value, num, Utils.getDay())
    }
    
    func readImage(_ image: (UIImage, UIImage)) -> [(String, String)] {
        
        let list = categoryName()
        var resultData : [(String, String)] = []
        
        var result = ocr.ocrRequest(image: image.0)!
        result += ocr.ocrRequest(image: image.1)!
        if result.count > 6 {
            view.dispErrorAlert(NSLocalizedString("ERROR OCRReading", comment: ""))
        }
        for i in 0..<result.count {
            resultData.append((list.list[i],result[i]))
        }
        return resultData
    }
}
