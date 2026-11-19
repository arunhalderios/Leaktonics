//
//  InspectPlumbingStatisticVC.swift
//  Leaktronics
//
//  Created by ivaninfotech on 5/27/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import CoreData
import DLRadioButton
import SVProgressHUD



class InspectPlumbingStatisticVC: UIViewController, LeakLocatorCellProtocol, EQLineCellProtocol {
    
    @IBOutlet weak var tblPlumbingStatistic: UITableView!
    
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
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.prepareFormData()
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
    
    //MARK:- Function
    @objc func btnNextDidTap() {
        self.updateCoreData()
        self.view.endEditing(true)
        //self.postPoolPlumbingStaticTest1()
        if UIDevice.current.userInterfaceIdiom == .phone {
           let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
           let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectPlumbingStatistic2") as! InspectPlumbingStatistic2VC
           self.navigationController?.pushViewController(formVC, animated: true)
        } else if UIDevice.current.userInterfaceIdiom == .pad {
           let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
           let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectPlumbingStatistic2") as! InspectPlumbingStatistic2VC
           self.navigationController?.pushViewController(formVC, animated: true)
        }
    }
    
    //MARK:- CoreData
    func updateCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "InspectionPool_CoreData")
        
        let userName: String = UserDefaults.standard.value(forKey: "InspectionUserName") as! String
        let predicate = NSPredicate(format: "%K == %@", "nameInspect", userName)
        fetchRequest.predicate = predicate
        
        do {
            let  rs = try managedContext.fetch(fetchRequest)
            for _ in rs as [NSManagedObject] {
                // update
                do {
                    let managedObject = rs[0]
                    
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
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "InspectionPool_CoreData")
            request.returnsObjectsAsFaults = false

            do {
                let result = try managedContext.fetch(request)
                for data in result as! [NSManagedObject] {
                    //print("Data of PoolDetectContact:: \(data)")
                   // if (data.value(forKey: "namePoolDetection") as! String) == userName {
//                        print("suction::",data.value(forKey: "suction") as Any)
//                        print("cleanerLines::",data.value(forKey: "cleanerLines") as Any)
//                        print("skimmerSuction::",data.value(forKey: "skimmerSuction") as Any)
//                        print("spaJets::",data.value(forKey: "spaJets") as Any)
//                        print("spaFill::",data.value(forKey: "spaFill") as Any)
//                        print("autofillEQ::",data.value(forKey: "autofillEQ") as Any)
//                        print("isVinylLinearLeak::",data.value(forKey: "isVinylLinearLeak") as Any)
//                        print("isLeaking::",data.value(forKey: "isLeaking") as Any)
                   // }
                }
            } catch {
                print("Failed")
            }

        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    /*//MARK:: Function Api Calling
    func postPoolPlumbingStaticTest1() {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        
        let return_id = UserDefaults.standard.value(forKey: "returnKeyForPoolDetect")
        
        let plumbingStaticDetails:  NSMutableDictionary = [
            "return_data_id"    : return_id!,
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
        ApiManager.sharedInstanceAPI.PostInspectStatic(postId: 1, staticDetails: plumbingStaticDetails, onSuccess: { json in
            DispatchQueue.main.async {
                print("PoolPlumbingStaticTest1 json :: \(String(describing: json))")
                DispatchQueue.main.async(execute: {() -> Void in
                    if UIDevice.current.userInterfaceIdiom == .phone {
                       let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
                       let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectPlumbingStatistic2") as! InspectPlumbingStatistic2VC
                       self.navigationController?.pushViewController(formVC, animated: true)
                    } else if UIDevice.current.userInterfaceIdiom == .pad {
                       let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
                       let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectPlumbingStatistic2") as! InspectPlumbingStatistic2VC
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
    }*/
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension InspectPlumbingStatisticVC: UITableViewDelegate, UITableViewDataSource {
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
            } else if indexPath.row == Static.cleanerLines.rawValue {
                cellData.lblTag.text = "Cleaner Lines"
            } else if indexPath.row == Static.skimmerSuction.rawValue {
                cellData.lblTag.text = "Skimmer Suction"
            } else if indexPath.row == Static.spaJets.rawValue {
                cellData.lblTag.text = "Spa Jets"
            } else if indexPath.row == Static.spaFill.rawValue {
                cellData.lblTag.text = "Spa Fill"
            } else if indexPath.row == Static.autofillEQ.rawValue {
                cellData.lblTag.text = "Autofill EQ Line"
                if UIDevice.current.userInterfaceIdiom == .phone {
                    cellData.lblTag.font = UIFont.boldSystemFont(ofSize: 13.0)
                } else {
                    cellData.lblTag.font = UIFont.boldSystemFont(ofSize: 24.0)
                }
            }

            cellData.txtData.keyboardType = UIKeyboardType.asciiCapable
            cellData.txtData.text = self.secStatic1[indexPath.row].formTextValue
            cellData.txtData.delegate = self
            
            return cellData
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                let cellEqLine = tableView.dequeueReusableCell(withIdentifier: "EQLineCell", for: indexPath) as! EQLineTableCell
                
                cellEqLine.delegateEQLine = self
                
                return cellEqLine
            } else {
                let cellLocator = tableView.dequeueReusableCell(withIdentifier: "LeakLocatorCell", for: indexPath) as! LeakLocatorTableCell
                
                cellLocator.delegateLeakLocator = self
                
                return cellLocator
            }
        }
        else {
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
                    return 145
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

extension InspectPlumbingStatisticVC: UITextFieldDelegate {
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
        
        self.perform(#selector(InspectPlumbingStatisticVC.updateTextfieldValue), with: nil, afterDelay: 1)
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range:NSRange, replacementString string: String) -> Bool {
        let cell = (textField.superview?.superview as? UITableViewCell)!
        
        let indexpath = self.tblPlumbingStatistic.indexPath(for: cell)
        guard let _indexPath = indexpath else { return false }
        self.selectedRowIndex = _indexPath.row
        self.sectionIndex = _indexPath.section
        
        self.perform(#selector(InspectPlumbingStatisticVC.updateTextfieldValue), with: nil, afterDelay: 1)
        
        return true
    }
}
