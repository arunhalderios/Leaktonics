//
//  PlumbingStatisticVC.swift
//  Leaktronics
//
//  Created by Abhishek Mullick on 08/04/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import CoreData
import DLRadioButton
import SVProgressHUD


class PlumbingStatisticVC: UIViewController, LeakLocatorCellProtocol, EQLineCellProtocol {
    
    @IBOutlet weak var tblPlumbingStatistic: UITableView!
    var poolDetailsDict = [String : AnyObject]()
    var poolDict = [String : AnyObject]()
    var strReport_id = String()
    
    //MARK:- Variable Declaration
    var secStatic1 = [formData]()
    
    private var sectionIndex = -1
    private var selectedRowIndex = -1
    var isVinylLinearLeak = String()
    var isLeaking = String()
    var poolDetectUser: [PoolDetection_CoreData] = []
    
    enum Static: Int {
        case suction = 0
        case cleanerLines = 1
        case skimmerSuction = 2
        case spaJets = 3
        case spaFill = 4
        case autofillEQ = 5
        case anyEQLine = 6
    }
    
    
    @IBAction func PhoneContactClick(_ button:UIButton!){
        if UIDevice.current.userInterfaceIdiom == .phone {
            let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection", bundle:nil)
            let nextVC = storyBoard.instantiateViewController(withIdentifier: "PoolDetectionContactVC") as! PoolDetectionContactVC
            nextVC.strReport_id = String(describing: strReport_id)
            self.navigationController?.pushViewController(nextVC, animated: true)
        } else { //UIDevice.current.userInterfaceIdiom == .pad
            let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection_iPad", bundle:nil)
            let nextVC = storyBoard.instantiateViewController(withIdentifier: "PoolDetectionContactVC") as! PoolDetectionContactVC
            nextVC.strReport_id = String(describing: strReport_id)
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    @IBAction func VisualLickInspectionClick(_ button:UIButton!){
      //ReportListVC
        //Home_iPad
        //Home_iPhone
    }
    
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.prepareFormData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = UIColor.black
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton

        self.postReportDetailsEdit()
    }
    
    func prepareFormData() {
        for _ in 0..<6 {
            let obj = formData()
            self.secStatic1.append(obj)
        }
    }
    
    //MARK:- LeakLocatorCellProtocol
    func didTapOnCellPinHolesLeak(_btnPinHolesLeakTag: Int) {
        print(_btnPinHolesLeakTag)
        if _btnPinHolesLeakTag == 10 {
            isVinylLinearLeak = "Yes"
        } else if _btnPinHolesLeakTag == 20 {
            isVinylLinearLeak = "No"
        }
    }
    
    //MARK:- EQLineCellProtocol
    func didTapOnCellEQLine(_btnLeakingTag: Int) {
        if _btnLeakingTag == 0 {
            isLeaking = "Is leaking"
        } else{
             isLeaking = "Is not leaking"
        }
    }
    
    //MARK:- ObjectiveC Function
    @objc func btnNextDidTap() {
        self.view.endEditing(true)
        self.updateCoreData(strReport_id: strReport_id)
        //self.checkNetwork()
        let isFrom: Bool = UserDefaults.standard.bool(forKey: "isFromReportList")
        if isFrom == true {
            self.postPoolPlumbingStaticTest1Update()
        } else {
            self.postPoolPlumbingStaticTest1()
        }
        /*if UIDevice.current.userInterfaceIdiom == .phone {
           let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection", bundle:nil)
           let formVC = storyBoard.instantiateViewController(withIdentifier: "PlumbingStatistic2") as! PlumbingStatistic2VC
           self.navigationController?.pushViewController(formVC, animated: true)
        } else if UIDevice.current.userInterfaceIdiom == .pad {
           let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection_iPad", bundle:nil)
           let formVC = storyBoard.instantiateViewController(withIdentifier: "PlumbingStatistic2") as! PlumbingStatistic2VC
           self.navigationController?.pushViewController(formVC, animated: true)
        }*/
    }
    
    //MARK:- CoreData
    func updateCoreData(strReport_id: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Pool5_CoreData")
        
        //let userName: String = UserDefaults.standard.value(forKey: "PoolDetectionUserName") as! String
        let predicate = NSPredicate(format: "%K == %@", "report_id", strReport_id)
        fetchRequest.predicate = predicate
        
        do {
            let reportResult = try managedContext.fetch(fetchRequest) as! [Pool5_CoreData]
            print("Report Data\(reportResult) and count is \(reportResult.count)")
            
            if reportResult.count == 0 {
                print ("Inserting DB")
                
                //For data fetch in coredata
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Pool5_CoreData")
                fetchRequest.returnsObjectsAsFaults = false
                
                let predicate = NSPredicate(format: "%K == %@", "report_id", strReport_id)
                fetchRequest.predicate = predicate
                
                let  rs = try managedContext.fetch(fetchRequest)
                for _ in rs as [NSManagedObject] {
                    // update
                    do {
                        let managedObject = rs[0]
                        
                        managedObject.setValue(poolDict["report_id"], forKey: "report_id")
                        managedObject.setValue(poolDict["suction"], forKey: "suction")
                        managedObject.setValue(poolDict["cleanerLines"], forKey: "cleanerLines")
                        managedObject.setValue(poolDict["skimmerSuction"], forKey: "skimmerSuction")
                        managedObject.setValue(poolDict["spaJets"], forKey: "spaJets")
                        managedObject.setValue(poolDict["spaFill"], forKey: "spaFill")
                        managedObject.setValue(poolDict["autofillEQ"], forKey: "autofillEQ")
                        managedObject.setValue(poolDict["isVinylLinearLeak"], forKey: "isVinylLinearLeak")
                        managedObject.setValue(poolDict["isLeaking"], forKey: "isLeaking")
                        
                        try managedContext.save()
                        print("update successfull")
                    } catch let error as NSError {
                        print("Could not Update. \(error), \(error.userInfo)")
                    }
                    //end update
                }
                do {
                    try managedContext.save()
                    UserDefaults.standard.set(self.poolDict["namePoolDetection"], forKey: "PoolDetectionUserName")
                    print("Inserted")
                } catch let error as NSError {
                    print(error)
                }
            } else {
                print ("Updating DB")
                //For data fetch in coredata
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Pool5_CoreData")
                fetchRequest.returnsObjectsAsFaults = false
                
                let predicate = NSPredicate(format: "%K == %@", "report_id", strReport_id)
                fetchRequest.predicate = predicate
                
                let  rs = try managedContext.fetch(fetchRequest)
                for _ in rs as [NSManagedObject] {
                    // update
                    do {
                        let managedObject = rs[0]
                        
                        managedObject.setValue(strReport_id, forKey: "report_id")
                        managedObject.setValue(self.secStatic1[Static.suction.rawValue].formTextValue, forKey: "suction")
                        managedObject.setValue(self.secStatic1[Static.cleanerLines.rawValue].formTextValue, forKey: "cleanerLines")
                        managedObject.setValue(self.secStatic1[Static.skimmerSuction.rawValue].formTextValue, forKey: "skimmerSuction")
                        managedObject.setValue(self.secStatic1[Static.spaJets.rawValue].formTextValue, forKey: "spaJets")
                        managedObject.setValue(self.secStatic1[Static.spaFill.rawValue].formTextValue, forKey: "spaFill")
                        managedObject.setValue(self.secStatic1[Static.autofillEQ.rawValue].formTextValue, forKey: "autofillEQ")
                        managedObject.setValue(self.isVinylLinearLeak, forKey: "isVinylLinearLeak")
                        managedObject.setValue(self.isLeaking, forKey: "isLeaking")
                        
                        try managedContext.save()
                        print("update successfull")
                    } catch let error as NSError {
                        print("Could not Update. \(error), \(error.userInfo)")
                    }
                    //end update
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    //MARK:: Function Api Calling
    func postReportDetailsEdit() {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        
        let editDetails: NSMutableDictionary = [
            "report_id" : strReport_id,
            "type"        : "Pool Leak Detection"
        ]
        
        print("editDetails :: \(editDetails)")
        //if sharedExtension.connectedToNetwork() {
        ApiManager.sharedInstanceAPI.PostReportDetailsEdit(postId: 1, reportDetailsEdit: editDetails, onSuccess: { json in
            DispatchQueue.main.async {
                print("PoolDetectionDetailsEdit json :: \(String(describing: json))")
                //let poolDetectDict = (json["data"] as AnyObject) as! [String : AnyObject]
                
                self.poolDetailsDict = (json["data"] as AnyObject) as! [String : AnyObject]
                let strPoolData: String = String(describing: self.poolDetailsDict["page_5"]!)
                if strPoolData != "<null>" {
                    self.poolDict = self.poolDetailsDict["page_5"] as! [String : AnyObject]
                }
                print(self.poolDict)
                self.updateCoreData(strReport_id: self.strReport_id)
                self.tblPlumbingStatistic.reloadData()
                SVProgressHUD.dismiss()
            }
        }, onFailure: { error in
            DispatchQueue.main.sync(execute: {() -> Void in
                SVProgressHUD.dismiss()
                print("Error Message::\(error)")
                let alert = UIAlertController(title: "", message: error["message"] as? String, preferredStyle: .alert)
                let dismissAction = UIAlertAction(title: "OK", style: .default) { (_) -> Void in
                    DispatchQueue.main.async(execute: {() -> Void in
                        
                    })
                }
                alert.addAction(dismissAction)
                self.present(alert, animated: true, completion: nil)
            })
        })
    }
    
    func postPoolPlumbingStaticTest1() {
        self.view.endEditing(true)
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        
        let plumbingStaticDetails:  NSMutableDictionary = [
            "return_data_id"    : strReport_id,
            "suction"           : self.secStatic1[Static.suction.rawValue].formTextValue,
            "cleanerLines"      : self.secStatic1[Static.cleanerLines.rawValue].formTextValue,
            "skimmerSuction"    : self.secStatic1[Static.skimmerSuction.rawValue].formTextValue,
            "spaJets"           : self.secStatic1[Static.spaJets.rawValue].formTextValue,
            "spaFill"           : self.secStatic1[Static.spaFill.rawValue].formTextValue,
            "autofillEQ"        : self.secStatic1[Static.autofillEQ.rawValue].formTextValue,
            "isVinylLinearLeak" : self.isVinylLinearLeak,
            "isLeaking"         : self.isLeaking
        ]
        
        print("plumbingStaticDetails :: \(plumbingStaticDetails)")
        ApiManager.sharedInstanceAPI.PostPoolPlumbingStaticTest1(postId: 1, plumbingStatic1Details: plumbingStaticDetails, onSuccess: { json in
            DispatchQueue.main.async {
                print("PoolPlumbingStaticTest1 json :: \(String(describing: json))")
                DispatchQueue.main.async(execute: {() -> Void in
                    if UIDevice.current.userInterfaceIdiom == .phone {
                       let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection", bundle:nil)
                       let formVC = storyBoard.instantiateViewController(withIdentifier: "PlumbingStatistic2") as! PlumbingStatistic2VC
                       formVC.strReport_id = self.strReport_id
                       self.navigationController?.pushViewController(formVC, animated: true)
                    } else if UIDevice.current.userInterfaceIdiom == .pad {
                       let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection_iPad", bundle:nil)
                       let formVC = storyBoard.instantiateViewController(withIdentifier: "PlumbingStatistic2") as! PlumbingStatistic2VC
                       formVC.strReport_id = self.strReport_id
                       self.navigationController?.pushViewController(formVC, animated: true)
                    }
                    SVProgressHUD.dismiss()
                })
            }
        }, onFailure: { error in
            DispatchQueue.main.sync(execute: {() -> Void in
                SVProgressHUD.dismiss()
                print(error)
                let alert = UIAlertController(title: "", message: error["message"] as? String, preferredStyle: .alert)
                let dismissAction = UIAlertAction(title: "OK", style: .default) { (_) -> Void in
                    DispatchQueue.main.async(execute: {() -> Void in
                        
                    })
                }
                alert.addAction(dismissAction)
                self.present(alert, animated: true, completion: nil)
            })
        })
    }
    
    func postPoolPlumbingStaticTest1Update() {
        self.view.endEditing(true)
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        
        let plumbingStaticDetails:  NSMutableDictionary = [
            "return_data_id"    : strReport_id,
            "report_id"             : strReport_id,
            "suction"           : self.secStatic1[Static.suction.rawValue].formTextValue,
            "cleanerLines"      : self.secStatic1[Static.cleanerLines.rawValue].formTextValue,
            "skimmerSuction"    : self.secStatic1[Static.skimmerSuction.rawValue].formTextValue,
            "spaJets"           : self.secStatic1[Static.spaJets.rawValue].formTextValue,
            "spaFill"           : self.secStatic1[Static.spaFill.rawValue].formTextValue,
            "autofillEQ"        : self.secStatic1[Static.autofillEQ.rawValue].formTextValue,
            "isVinylLinearLeak" : self.isVinylLinearLeak,
            "isLeaking"         : self.isLeaking
        ]
        
        print("plumbingStaticDetails :: \(plumbingStaticDetails)")
        ApiManager.sharedInstanceAPI.PostPoolPlumbingStaticTest1Update(postId: 1, plumbingStatic1Details: plumbingStaticDetails, onSuccess: { json in
            DispatchQueue.main.async {
                print("PoolPlumbingStaticTest1 json :: \(String(describing: json))")
                DispatchQueue.main.async(execute: {() -> Void in
                    if UIDevice.current.userInterfaceIdiom == .phone {
                       let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection", bundle:nil)
                       let formVC = storyBoard.instantiateViewController(withIdentifier: "PlumbingStatistic2") as! PlumbingStatistic2VC
                       formVC.strReport_id = self.strReport_id
                       self.navigationController?.pushViewController(formVC, animated: true)
                    } else if UIDevice.current.userInterfaceIdiom == .pad {
                       let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection_iPad", bundle:nil)
                       let formVC = storyBoard.instantiateViewController(withIdentifier: "PlumbingStatistic2") as! PlumbingStatistic2VC
                       formVC.strReport_id = self.strReport_id
                       self.navigationController?.pushViewController(formVC, animated: true)
                    }
                    SVProgressHUD.dismiss()
                })
            }
        }, onFailure: { error in
            DispatchQueue.main.sync(execute: {() -> Void in
                SVProgressHUD.dismiss()
                print(error)
                let alert = UIAlertController(title: "", message: error["message"] as? String, preferredStyle: .alert)
                let dismissAction = UIAlertAction(title: "OK", style: .default) { (_) -> Void in
                    DispatchQueue.main.async(execute: {() -> Void in
                        
                    })
                }
                alert.addAction(dismissAction)
                self.present(alert, animated: true, completion: nil)
            })
        })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PlumbingStatisticVC: UITableViewDelegate, UITableViewDataSource {
    //MARK:- UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       if section == 0 {
            return 6
       } else if section == 1 {
            return 2
       } else {
            return 1
       }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cellData = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath) as! DataValueTableCell
            
            if indexPath.row == Static.suction.rawValue {
                cellData.lblTag.text = "Side Suctions"
                if poolDict.count > 0 {
                    self.secStatic1[Static.suction.rawValue].formTextValue = String(describing: poolDict["suction"]!)
                    cellData.txtData.text = String(describing: poolDict["suction"]!)
                } else {
                    cellData.txtData.text = self.secStatic1[indexPath.row].formTextValue
                }
            } else if indexPath.row == Static.cleanerLines.rawValue {
                cellData.lblTag.text = "Cleaner Lines"
                if poolDict.count > 0 {
                    self.secStatic1[Static.cleanerLines.rawValue].formTextValue = String(describing: poolDict["cleanerLines"]!)
                    cellData.txtData.text = String(describing: poolDict["cleanerLines"]!)
                } else {
                    cellData.txtData.text = self.secStatic1[indexPath.row].formTextValue
                }
            } else if indexPath.row == Static.skimmerSuction.rawValue {
                cellData.lblTag.text = "Skimmer Suction"
                if poolDict.count > 0 {
                    self.secStatic1[Static.skimmerSuction.rawValue].formTextValue = String(describing: poolDict["skimmerSuction"]!)
                    cellData.txtData.text = String(describing: poolDict["skimmerSuction"]!)
                } else {
                    cellData.txtData.text = self.secStatic1[indexPath.row].formTextValue
                }
            } else if indexPath.row == Static.spaJets.rawValue {
                cellData.lblTag.text = "Spa Jets"
                if poolDict.count > 0 {
                    self.secStatic1[Static.spaJets.rawValue].formTextValue = String(describing: poolDict["spaJets"]!)
                    cellData.txtData.text = String(describing: poolDict["spaJets"]!)
                } else {
                    cellData.txtData.text = self.secStatic1[indexPath.row].formTextValue
                }
            } else if indexPath.row == Static.spaFill.rawValue {
                cellData.lblTag.text = "Spa Fill"
                if poolDict.count > 0 {
                    self.secStatic1[Static.spaFill.rawValue].formTextValue = String(describing: poolDict["spaFill"]!)
                    cellData.txtData.text = String(describing: poolDict["spaFill"]!)
                } else {
                    cellData.txtData.text = self.secStatic1[indexPath.row].formTextValue
                }
            } else if indexPath.row == Static.autofillEQ.rawValue {
                cellData.lblTag.text = "Autofill EQ Line"
                if UIDevice.current.userInterfaceIdiom == .phone {
                    cellData.lblTag.font = UIFont.boldSystemFont(ofSize: 13.0)
                } else {
                    cellData.lblTag.font = UIFont.boldSystemFont(ofSize: 24.0)
                }
                if poolDict.count > 0 {
                    self.secStatic1[Static.autofillEQ.rawValue].formTextValue = String(describing: poolDict["autofillEQ"]!)
                    cellData.txtData.text = String(describing: poolDict["autofillEQ"]!)
                } else {
                    cellData.txtData.text = self.secStatic1[indexPath.row].formTextValue
                }
            }

            cellData.txtData.keyboardType = UIKeyboardType.asciiCapable
            cellData.txtData.text = self.secStatic1[indexPath.row].formTextValue
            cellData.txtData.delegate = self
            
            return cellData
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                let cellEqLine = tableView.dequeueReusableCell(withIdentifier: "EQLineCell", for: indexPath) as! EQLineTableCell
                if poolDict.count > 0 {
                    if String(describing: poolDict["isLeaking"]!) == "Is leaking" {
                        isLeaking = "Is leaking"
                        cellEqLine.imgEQLine0.image = UIImage(named: "checkmark")
                        cellEqLine.imgEQLine1.image = UIImage(named: "unchecked")
                    } else if String(describing: poolDict["isLeaking"]!) == "Is not leaking" {
                        isLeaking = "Is not leaking"
                        cellEqLine.imgEQLine0.image = UIImage(named: "unchecked")
                        cellEqLine.imgEQLine1.image = UIImage(named: "checkmark")
                    }
                }
                cellEqLine.delegateEQLine = self
                
                return cellEqLine
            } else {
                let cellLocator = tableView.dequeueReusableCell(withIdentifier: "LeakLocatorCell", for: indexPath) as! LeakLocatorTableCell
                
                if poolDict.count > 0 {
                    if String(describing: poolDict["isVinylLinearLeak"]!) == "Yes" {
                        isVinylLinearLeak = "Yes"
                        cellLocator.btnYes.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
                        cellLocator.btnYes.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
                        cellLocator.btnNo.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                        cellLocator.btnNo.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
                    } else {
                        isVinylLinearLeak = "No"
                        cellLocator.btnYes.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                        cellLocator.btnYes.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
                        cellLocator.btnNo.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
                        cellLocator.btnNo.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
                    }
                }
                
                cellLocator.delegateLeakLocator = self
                
                return cellLocator
            }
        } else {
           let cellBtn = tableView.dequeueReusableCell(withIdentifier: "NextCell", for: indexPath) as! NextForm1TableCell
           
           cellBtn.btnNext.addTarget(self, action: #selector(btnNextDidTap), for: UIControl.Event.touchUpInside)
           return cellBtn
       }
    }
    
    //MARK:- UITableViewDelegate
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            // get a reference to our storyboard cell
            let headerView : UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "CustomHeaderCell")!
            
            let lblHeaderTitle = headerView.viewWithTag(10) as! UILabel
            
            lblHeaderTitle.textColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.2352941176, alpha: 1)
            
            lblHeaderTitle.text = "Plumbing Static Test"  // set this however is appropriate for your app's model
            
            return headerView
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .phone {
            if section == 0 {
                return 65
            } else {
                return 0
            }
        } else { //if UIDevice.current.userInterfaceIdiom == .pad {
            if section == 0 {
                return 75
            } else {
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       if UIDevice.current.userInterfaceIdiom == .phone {
           if indexPath.section == 0 {
               return 100
           } else if indexPath.section == 1 {
                if indexPath.row == 0 {
                    return 155
                } else {
                    return 135
                }
           } else {
               return 125
           }
       } else {
           if indexPath.section == 0 {
               return 170
           } else if indexPath.section == 1 {
                if indexPath.row == 0 {
                    return 250
                } else {
                    return 255
                }
           } else {
               return 175
           }
       }
    }
}

extension PlumbingStatisticVC: UITextFieldDelegate {
    @objc func updateTextfieldValue() {
        let cell = self.tblPlumbingStatistic.cellForRow(at: IndexPath.init(row: self.selectedRowIndex, section: self.sectionIndex))
        guard let _cell = cell else { return  }
        
        if let dataValueTblCell = _cell as? DataValueTableCell {
            if let textfield = dataValueTblCell.txtData {
                if self.sectionIndex == 0 {
                    self.secStatic1[self.selectedRowIndex].formTextValue = (textfield.text)!
                } else {
                    //self.secPool2[self.selectedRowIndex].formTextValue = (textfield.text)!
                }
            }
        }
    }
        
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let cell = (textField.superview?.superview as? UITableViewCell)!
        
        let indexpath = self.tblPlumbingStatistic.indexPath(for: cell)
        guard let _indexPath = indexpath else { return false }
        self.selectedRowIndex = _indexPath.row
        self.sectionIndex = _indexPath.section
        
        self.perform(#selector(PlumbingStatisticVC.updateTextfieldValue), with: nil, afterDelay: 1)
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range:NSRange, replacementString string: String) -> Bool {
        let cell = (textField.superview?.superview as? UITableViewCell)!
        
        let indexpath = self.tblPlumbingStatistic.indexPath(for: cell)
        guard let _indexPath = indexpath else { return false }
        self.selectedRowIndex = _indexPath.row
        self.sectionIndex = _indexPath.section
        
        self.perform(#selector(PlumbingStatisticVC.updateTextfieldValue), with: nil, afterDelay: 1)
        
        return true
    }
}
