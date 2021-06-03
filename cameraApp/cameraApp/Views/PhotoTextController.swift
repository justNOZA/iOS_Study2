//
//  PhotoText.swift
//  cameraApp
//
//  Created by Pasonatech on 2021/05/27.
//

import UIKit
import RealmSwift

class PhotoTextController : UIViewController {
    
    var imageData : UIImage?
    var ocr = OCRReading()
    var showDB : Bool = false
    var DBData : Results<PhotoValue>?
    var ReadData : [String]?
    
    @IBOutlet weak var listTable: UITableView!
    @IBOutlet weak var pageTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTable.delegate = self
        listTable.dataSource = self
        setCustomHeader()
        setTitle()
        
        if showDB {
            DBData = getAllData()
        }else {
            if imageData == nil {
                ReadData = [NSLocalizedString("no text", comment: "")]
            }else {
                ReadData = ocr.ocrRequest(image: imageData!)
                self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(saveDB)))
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async { [self] in
            reloadTable()
        }
    }
    
    private func setTitle(){
        if showDB {
            pageTitle.text = "SHOW DB"
        } else {
            pageTitle.text = "READ IMAGE BY OCR"
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
        let list = ReadData!
        //Add DB
        for i in list {
            let setValue = PhotoValue()
            setValue.index = incrementalIndex()
            setValue.value = String(i)
            try! realm.write{
                realm.add(setValue)
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

extension PhotoTextController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if showDB {
            return DBData!.count
        } else {
            return ReadData!.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "multiColumnCell", for: indexPath) as! MultiColumnTableViewCell

        cell.selectionStyle = .none

        if indexPath.row.isMultiple(of: 2){
            cell.backgroundColor = .systemPink
        }else{
            cell.backgroundColor = UIColor.white
        }

        if showDB {
            cell.label1.text = String(DBData!.elements[indexPath.row].index)
            cell.label2.text = DBData!.elements[indexPath.row].value
        }else {
            if imageData == nil {
                cell.label1.text = "no DATA"
                cell.label2.text = ReadData![0]
            }else {
                cell.label1.text = String(indexPath.row)
                cell.label2.text = ReadData![indexPath.row]
            }
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //Add subviews here
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TableHeader") as! TableHeader
        
        headerView.label1.text = "INDEX num"
        headerView.label2.text = "Value"
//        
        return headerView
    }
    
    func setCustomHeader(){
        listTable.separatorStyle = .none
        
        let nib = UINib(nibName: "TableCloumn", bundle: nil)
        listTable.register(nib, forCellReuseIdentifier: "multiColumnCell")
        
        let Headernib = UINib(nibName: "TableHeader", bundle: Bundle.main)
        listTable.register(Headernib, forHeaderFooterViewReuseIdentifier: "TableHeader")
    }
    
    func reloadTable() {
        listTable.reloadData()
    }
}
