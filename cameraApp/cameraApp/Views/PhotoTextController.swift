//
//  PhotoText.swift
//  cameraApp
//
//  Created by Pasonatech on 2021/05/27.
//

import UIKit
import RealmSwift

class PhotoTextController : UIViewController {
    
    @IBOutlet weak var photoText: UILabel!
    var imageData : UIImage?
    var ocr = OCRReading()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readImagetoText()
        if photoText.text == NSLocalizedString("no text", comment: ""){}
        else {
            self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(saveDB)))
        }
    }
    
    private func readImagetoText(){
        if let data = imageData {
            photoText.text = ocr.ocrRequest(image: data)
        } else {
            photoText.text = NSLocalizedString("no text", comment: "")
        }
    }
    
    @objc func saveDB(){
        let alert = UIAlertController(title: alertSave.title.rawValue, message: alertSave.message.rawValue, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "yes", style: .default, handler: { [self] action in
            saveDataDB()
        }))
        alert.addAction(UIAlertAction(title: "no", style: .default, handler: { [self] action in
            let alerts = UIAlertController(title: alertDel.title.rawValue, message: alertDel.message.rawValue, preferredStyle: .alert)
            alerts.addAction(UIAlertAction(title: "yes", style: .default, handler: {[self] action in
                deleteAllDB()
            }))
            alerts.addAction(UIAlertAction(title: "no", style: .default, handler: { action in}))
            self.present(alerts, animated: true)
        }))
        self.present(alert, animated: true)
    }
}

extension PhotoTextController {
    func saveDataDB(){
        let realm = try! Realm()
        let list = photoText.text!.split(separator: "\n")
        //Add DB
        for i in list {
            let setValue = PhotoValue()
            let setValue2 = PhotoValue2()
            setValue.index = incrementalIndex()
            setValue.value = String(i)
            setValue2.index = incrementalIndex2()
            setValue2.value = String(i)
            try! realm.write{
                realm.add(setValue)
                realm.add(setValue2)
            }
        }
    }
    
    func getAllData() -> Results<PhotoValue>{
        let realm = try! Realm()
        //get All Data
        return realm.objects(PhotoValue.self)
    }
    
    //index값 증가시켜서 가져오기
    func incrementalIndex() -> Int {
        let realm = try! Realm()
        return (realm.objects(PhotoValue.self).max(ofProperty: "index") as Int? ?? 0)+1
    }
    
    //delete All _ in class
    func deleteAllDB(){
        let realm = try! Realm()
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
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    //update DB
    func updateDataDB(){
        let realm = try! Realm()
        let userinfo = realm.objects(PhotoValue.self).filter("index == 11").first!
        try! realm.write {
            userinfo.value = "47"
        }
    }
    
    //delete select one _ imn clas
    func deleteOneDB(){
        let realm = try! Realm()
        let userinfo = realm.objects(PhotoValue.self).filter("index == 11").first!
        try! realm.write {
            realm.delete(userinfo)
        }
    }
    
    //sort get
    func sortedDataDB() -> Results<PhotoValue>{
        let realm = try! Realm()
        let data = realm.objects(PhotoValue.self).sorted(byKeyPath: "index", ascending: true) //오름차순
        return data
    }
}
