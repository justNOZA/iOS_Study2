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
    
    func saveDataDB(_ list : [(name:String,value:Any)]?)
//    func updateDataDB(_ index : Int, _ value : String, _ name : String)

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
    func saveDataDB(_ list : [(name:String,value:Any)]?){
        let cate = categoryName()
        var info:[Any] = []
        for i in list! {
            if i.name == cate.list[2]{
                info.append(Double(i.value as! String))
            }else {
                info.append(i.value as! String)
            }
            
        }
        let time = Utils.getToDay()
        model.saveDataDB(info, time)
    }
//    //update DB
//    func updateDataDB(_ index : Int, _ value : String, _ name : String){
//        let list = categoryName()
//        let num = list.list.lastIndex(of: name)!
//        model.updateDataDB(index, value, num, Utils.getDay())
//    }
    
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
