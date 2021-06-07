//
//  PhotoText.swift
//  cameraApp
//
//  Created by Pasonatech on 2021/05/27.
//

import UIKit
import RealmSwift

class DBViewController : UIViewController {
    
    @IBOutlet weak var pageTitle: UILabel!
    
    @IBOutlet weak var showValue: UICollectionView!
    
    var imageData : (UIImage, UIImage)?
    var showDB : Bool = false
    var DBData : [(index:Int, value:[Any], time:(Date,Date?))]?
    var presenter : DBViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = DBViewPresenter(view: self)
        showValue.collectionViewLayout = settingLayout()
        showValue.dataSource = self
        showValue.delegate = self
        setCustomHeader()
        setTitle()
        DBData = presenter.getAllData()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if DBData?.count == 0 {
            showValue.isHidden = true
            setNoData()
        } else {
            DispatchQueue.main.async { [self] in
                reloadTable()
            }
        }
    }
    private func setTitle(){
        pageTitle.text = "SHOW DB"
    }
    
    private func setNoData(){
        let info = UITextView()
        info.text = NSLocalizedString("NO_DB", comment: "")
        info.font = UIFont(name: "Callout", size: 20)
        info.textAlignment = .center
        
        self.view.addSubview(info)
        plusConstraintOneText(info)
    }
    func plusConstraintOneText(_ view: UITextView){
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: pageTitle.bottomAnchor, constant: 100),
            view.bottomAnchor.constraint(equalTo: view.superview!.bottomAnchor, constant: 0),
            view.widthAnchor.constraint(equalTo: view.superview!.widthAnchor, multiplier: 1),
            view.leadingAnchor.constraint(equalTo: view.superview!.leadingAnchor, constant: 0)
        ])
    }
    // Scroll Horizontal
    func settingLayout() -> UICollectionViewFlowLayout{
        let layout = UICollectionViewFlowLayout()
//        layout.estimatedItemSize  -> if you setting this -> cant use UICollectionViewDelegateFlowLayout to cell size
        layout.scrollDirection = .horizontal
        return layout
    }
}

extension DBViewController : UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DBData!.count+1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DBValueCollectionCell", for: indexPath) as! DBValueCollectionCell
        
        if indexPath.row.isMultiple(of: 2){
            cell.backgroundColor = UIColor.white
        }else{
            cell.backgroundColor = UIColor(red: 255, green: 214, blue: 0, alpha: 0.2)
        }
        if indexPath.row == 0 {
            let cg = categoryName()
            
            align(cell, .left)
            cell.index.text = ""
            cell.value1.text = cg.list[0]
            cell.value2.text = cg.list[1]
            cell.value3.text = cg.list[2]
            cell.value4.text = cg.list[3]
            cell.value5.text = cg.list[4]
            cell.value6.text = cg.list[5]
            cell.saveDay.text = "save time"
            cell.updateDay.text = "update time"
        } else {
            align(cell, .center)
            
            cell.index.text = String(DBData![indexPath.row-1].index)
            cell.value1.text = DBData![indexPath.row-1].value[0] as? String
            cell.value2.text = DBData![indexPath.row-1].value[1] as? String
            cell.value3.text = String(DBData![indexPath.row-1].value[2] as! Double)
            cell.value4.text = DBData![indexPath.row-1].value[3] as? String
            cell.value5.text = DBData![indexPath.row-1].value[4] as? String
            cell.value6.text = DBData![indexPath.row-1].value[5] as? String
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd"
            cell.saveDay.text = formatter.string(from: DBData![indexPath.row-1].time.0)
            if let uday = DBData![indexPath.row-1].time.1 {
                cell.updateDay.text = formatter.string(from: uday)
            } else {
                cell.updateDay.text = ""
            }
        }
        return cell
    }
    
    func setCustomHeader(){
        let nib = UINib(nibName: "DBValueCollectionCell", bundle: nil)
        showValue.register(nib, forCellWithReuseIdentifier: "DBValueCollectionCell")
    }
    
    func reloadTable() {
        showValue.reloadData()
    }
    
    func align(_ cell : DBValueCollectionCell, _ ver:  NSTextAlignment ){
        cell.index.textAlignment = ver
        cell.value1.textAlignment = ver
        cell.value2.textAlignment = ver
        cell.value3.textAlignment = ver
        cell.value4.textAlignment = ver
        cell.value5.textAlignment = ver
        cell.value6.textAlignment = ver
        cell.saveDay.textAlignment = ver
        cell.updateDay.textAlignment = ver
    }
}
extension DBViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200.0, height: showValue.frame.height)
    }
}
