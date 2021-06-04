//
//  PhotoText.swift
//  cameraApp
//
//  Created by Pasonatech on 2021/05/27.
//

import UIKit
import RealmSwift

class PhotoTextController : UIViewController {
    
    var imageData : (UIImage, UIImage)?
    var ReadData : [(name: String, value: String)]?
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

        if imageData == nil {
            ReadData = [(NSLocalizedString("noPart", comment: ""),NSLocalizedString("notext", comment: ""))]
        }else {
            ReadData = presenter.readImage(imageData!)
            self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(saveDB)))
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async { [self] in
            reloadTable()
        }
    }
    
    private func setTitle(){
        pageTitle.text = "READ IMAGE BY OCR"
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
        return ReadData!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "multiColumnCell", for: indexPath) as! MultiColumnTableViewCell

        cell.selectionStyle = .none

        if indexPath.row.isMultiple(of: 2){
            cell.backgroundColor = UIColor(red: 255, green: 214, blue: 0, alpha: 0.2)
        }else{
            cell.backgroundColor = UIColor.white
        }

        if imageData == nil {
            cell.label1.text = ReadData![0].name
            cell.label2.text = ReadData![0].value
        }else {
            cell.label1.text = ReadData![indexPath.row].name
            cell.label2.text = ReadData![indexPath.row].value
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
        
        headerView.label1.text = "Category"
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
    
    func dispErrorAlert(_ str: String) {
        let alert = UIAlertController(title: "", message: str, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "再試行", style: .default, handler: { [self] action in
            self.ReadData = self.presenter.readImage(self.imageData!)
            self.reloadTable()
        }))
        alert.addAction(UIAlertAction(title: "キャンセル", style: .default, handler: { [self] action in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true)
    }
}
