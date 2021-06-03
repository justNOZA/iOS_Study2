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
    var showDB : Bool = false
    var DBData : ([Int], [String])?
    var ReadData : [String]?
    var presenter : PhotoPresenter!
    
    @IBOutlet weak var listTable: UITableView!
    @IBOutlet weak var pageTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = PhotoPresenter(view: self)
        listTable.delegate = self
        listTable.dataSource = self
        setCustomHeader()
        setTitle()
        
        if showDB {
            DBData = presenter.getAllData()
        }else {
            if imageData == nil {
                ReadData = [NSLocalizedString("notext", comment: "")]
            }else {
                ReadData = presenter.readImage(imageData!)
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
            presenter.saveDataDB(ReadData)
        }))
        alert.addAction(UIAlertAction(title: "no", style: .default, handler: { [self] action in
            let alerts = UIAlertController(title: alertDel.title.rawValue, message: alertDel.message.rawValue, preferredStyle: .alert)
            alerts.addAction(UIAlertAction(title: "yes", style: .default, handler: {[self] action in
                presenter.deleteAllDB()
            }))
            alerts.addAction(UIAlertAction(title: "no", style: .default, handler: { action in}))
            self.present(alerts, animated: true)
        }))
        self.present(alert, animated: true)
    }
}

extension PhotoTextController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if showDB {
            return DBData!.1.count
        } else {
            return ReadData!.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "multiColumnCell", for: indexPath) as! MultiColumnTableViewCell

        cell.selectionStyle = .none

        if indexPath.row.isMultiple(of: 2){
            cell.backgroundColor = UIColor(red: 255, green: 214, blue: 0, alpha: 0.2)
        }else{
            cell.backgroundColor = UIColor.white
        }

        if showDB {
            cell.label1.text = String(DBData!.0[indexPath.row])
            cell.label2.text = DBData!.1[indexPath.row]
        }else {
            if imageData == nil {
                cell.label1.text = "no DATA"
                cell.label2.text = ReadData![0]
            }else {
                cell.label1.text = String(indexPath.row+1)
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
