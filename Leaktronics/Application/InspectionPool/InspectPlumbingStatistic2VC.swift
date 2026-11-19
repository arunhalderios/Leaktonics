//
//  InspectPlumbingStatistic2VC.swift
//  Leaktronics
//
//  Created by ivaninfotech on 5/27/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import CoreData
import DLRadioButton
import SVProgressHUD

class InspectPlumbingStatistic2VC: UIViewController, SuctionLineAirCellProtocol,MarkLocationCellProtocol,EstimateCellProtocol {
    
    @IBOutlet weak var tblStatic2: UITableView!
    
    //MARK:- Variable Declaration
    var static2 = [formData]()
    var isVinylLinearLeak = Bool()
    var isLeaking = Bool()
    var poolDetectUser: [PoolDetection_CoreData] = []
    
    private var sectionIndex = -1
    private var selectedRowIndex = -1
    var suctionLineAirOption = String()
    var isLocationMarked = String()
    var isEstimateToFollow = String()
    
    
    enum Static2: Int {
        case suctionAir = 0
        case surgeTank = 1
        case markLocDes = 3
        case leaksNote = 4
        case summaryNote = 5
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
            self.static2.append(obj)
        }
    }
    
    //MARK:- SuctionLineAirCellProtocol {
    func didTapOnCellSuctionLineAir(_btnSuctionLineAirTag: Int) {
        if  _btnSuctionLineAirTag == 0{
            suctionLineAirOption = "Pool M/D"
        }else if _btnSuctionLineAirTag == 1{
            suctionLineAirOption = "Spa suctions"
        } else if _btnSuctionLineAirTag == 2{
            suctionLineAirOption = "Pool Skimmer"
        } else if _btnSuctionLineAirTag == 3{
            suctionLineAirOption = "Side suctions"
        } else if _btnSuctionLineAirTag == 4{
            suctionLineAirOption = "Water Feature Suction"
        } else{
            suctionLineAirOption = "Other (if any air noted, describe)"
        }
    }
    
    //MARK:- MarkLocationCellProtocol
    func didTapOnCellMarkLocation(_isMarkLocation: Bool) {
        if _isMarkLocation == true{
            isLocationMarked = "Yes"
        } else{
            isLocationMarked = "No"
        }
    }
    
    //MARK:- EstimateCellProtocol
    func didTapOnCellEstimate(_isEstimate: Bool) {
        if _isEstimate == true{
            isEstimateToFollow = "Yes"
        } else{
            isEstimateToFollow = "No"
        }
    }
    
    
    //MARK:- Function
    @objc func btnNextDidTap() {
        self.updateCoreData()
        self.view.endEditing(true)
        //self.postPoolPlumbingStaticTest2()
        if UIDevice.current.userInterfaceIdiom == .phone {
            let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
            let InspectionListVC = storyBoard.instantiateViewController(withIdentifier: "InspectCompleteSummary") as! InspectCompleteSummaryVC
            self.navigationController?.pushViewController(InspectionListVC, animated: true)
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
            let InspectionListVC = storyBoard.instantiateViewController(withIdentifier: "InspectCompleteSummary") as! InspectCompleteSummaryVC
            self.navigationController?.pushViewController(InspectionListVC, animated: true)
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
                    
                    managedObject.setValue(self.static2[Static2.suctionAir.rawValue].formTextValue, forKey: "suctionAir")
                    managedObject.setValue(suctionLineAirOption, forKey: "suctionLineAirOption")
                    managedObject.setValue(self.static2[Static2.surgeTank.rawValue].formTextValue, forKey: "surgeTank")
                    managedObject.setValue(self.static2[Static2.markLocDes.rawValue].formTextValue, forKey: "markLocationDescribe")
                    managedObject.setValue(self.static2[Static2.leaksNote.rawValue].formTextValue, forKey: "leaksNoted")
                    managedObject.setValue(self.static2[Static2.summaryNote.rawValue].formTextValue, forKey: "summaryNote")
                    
                    managedObject.setValue(self.isLocationMarked, forKey: "isLocationMarked")
                    managedObject.setValue(self.isEstimateToFollow, forKey: "isEstimateToFollow")
                    
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
                    print("Data of PoolDetectContact:: \(data)")
                    //if (data.value(forKey: "namePoolDetection") as! String) == userName {
//                        print("suctionAir::",data.value(forKey: "suctionAir") as Any)
//                        print("suctionOption::",data.value(forKey: "suctionLineAirOption") as Any)
//                        print("surgeTank::",data.value(forKey: "surgeTank") as Any)
//                        print("markLocationDescribe::",data.value(forKey: "markLocationDescribe") as Any)
//                        print("leaksNoted::",data.value(forKey: "leaksNoted") as Any)
//                        print("summaryNote::",data.value(forKey: "summaryNote") as Any)
//                        print("isLocationMarked::",data.value(forKey: "isLocationMarked") as Any)
//                        print("isEstimateToFollow::",data.value(forKey: "isEstimateToFollow") as Any)
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
    func postPoolPlumbingStaticTest2() {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        
        let return_id = UserDefaults.standard.value(forKey: "returnKeyForPoolDetect")
        
        let plumbingStaticDetails:  NSMutableDictionary = [
            "return_data_id"        : return_id!,
            "suctionAir"            : self.static2[Static2.suctionAir.rawValue].formTextValue,
            "suctionLineAirOption"  : suctionLineAirOption,
            "surgeTank"             : self.static2[Static2.surgeTank.rawValue].formTextValue,
            "markLocationDescribe"  : self.static2[Static2.markLocDes.rawValue].formOption,
            "leaksNoted"            : self.static2[Static2.leaksNote.rawValue].formOption,
            "summaryNote"           : self.static2[Static2.summaryNote.rawValue].formOption,
            "isLocationMarked"      : self.isLocationMarked,
            "isEstimateToFollow"    : self.isEstimateToFollow
        ]
        
        print("plumbingStaticDetails :: \(plumbingStaticDetails)")
        ApiManager.sharedInstanceAPI.PostInspectStatic2(postId: 1, staticDetails: plumbingStaticDetails, onSuccess: { json in
            DispatchQueue.main.async {
                print("PoolPlumbingStaticTest2 json :: \(String(describing: json))")
                DispatchQueue.main.async(execute: {() -> Void in
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Home_iPhone", bundle:nil)
                        let InspectionListVC = storyBoard.instantiateViewController(withIdentifier: "InspectCompleteSummary") as! InspectCompleteSummaryVC
                        self.navigationController?.pushViewController(InspectionListVC, animated: true)
                    } else if UIDevice.current.userInterfaceIdiom == .pad {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Home_iPad", bundle:nil)
                        let InspectionListVC = storyBoard.instantiateViewController(withIdentifier: "InspectCompleteSummary") as! InspectCompleteSummaryVC
                        self.navigationController?.pushViewController(InspectionListVC, animated: true)
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

extension InspectPlumbingStatistic2VC: UITableViewDataSource, UITableViewDelegate {
    //MARK:- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == Static2.suctionAir.rawValue {
            let cellLineAir = tableView.dequeueReusableCell(withIdentifier: "SuctionLineAirCell", for: indexPath) as! SuctionLineAirTableCell


            cellLineAir.delegateSuctionLineAir = self
            cellLineAir.txtOther.keyboardType = UIKeyboardType.asciiCapable
            cellLineAir.txtOther.text = self.static2[indexPath.row].formTextValue
            cellLineAir.txtOther.delegate = self
            
            return cellLineAir
        } else if indexPath.row == Static2.surgeTank.rawValue {
            let cellTank = tableView.dequeueReusableCell(withIdentifier: "SurgeTankCell", for: indexPath) as! SurgeTankTableCell
            
            cellTank.txtPressure.keyboardType = UIKeyboardType.asciiCapable
            cellTank.txtPressure.text = self.static2[indexPath.row].formTextValue
            cellTank.txtPressure.delegate = self
            
            return cellTank
        } else if indexPath.row == 2 {
           let cellMarkLoc = tableView.dequeueReusableCell(withIdentifier: "MarkLocationCell", for: indexPath) as! MarkLocationTableCell
            
            cellMarkLoc.lblMarkLoc.text = "Was location marked?"
            cellMarkLoc.delegateMarkLocation = self
            
            return cellMarkLoc
        } else if indexPath.row == Static2.markLocDes.rawValue {
            let cellDataTxtVw = tableView.dequeueReusableCell(withIdentifier: "DataTextViewCell", for: indexPath) as! DataTextViewTableCell
            
            cellDataTxtVw.lblData.text = "Where (Describe)"
            cellDataTxtVw.txtData.text = self.static2[indexPath.row].formTextValue
            cellDataTxtVw.txtData.delegate = self
            
            return cellDataTxtVw
        } else if indexPath.row == Static2.leaksNote.rawValue {
            let cellDataTxtVw = tableView.dequeueReusableCell(withIdentifier: "DataTextViewCell", for: indexPath) as! DataTextViewTableCell
            
            cellDataTxtVw.lblData.text = "Leaks Noted"
            cellDataTxtVw.txtData.text = self.static2[indexPath.row].formTextValue
            cellDataTxtVw.txtData.delegate = self
            
            return cellDataTxtVw
        } else if indexPath.row == Static2.summaryNote.rawValue {
            let cellDataTxtVw = tableView.dequeueReusableCell(withIdentifier: "DataTextViewCell", for: indexPath) as! DataTextViewTableCell
            
            cellDataTxtVw.lblData.text = "Summery Notes"
            cellDataTxtVw.txtData.text = self.static2[indexPath.row].formTextValue
            cellDataTxtVw.txtData.delegate = self
            
            return cellDataTxtVw
        } else if indexPath.row == 6 {
            let cellEstimate = tableView.dequeueReusableCell(withIdentifier: "EstimateCell", for: indexPath) as! EstimateTableCell
            
            cellEstimate.delegateEstimate = self
            return cellEstimate
        }
        else {
             let cellBtn = tableView.dequeueReusableCell(withIdentifier: "NextCell", for: indexPath) as! NextForm1TableCell
                       
             cellBtn.btnNext.addTarget(self, action: #selector(btnNextDidTap), for: UIControl.Event.touchUpInside)
             return cellBtn
        }
    }
    
    
    //MARK:- UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .phone {
            if indexPath.row == Static2.suctionAir.rawValue {
                return 385
            } else if indexPath.row == Static2.surgeTank.rawValue {
                 return 235
            } else if indexPath.row == 2 {
                 return 125
            } else if indexPath.row == Static2.markLocDes.rawValue {
                 return 175
            } else if indexPath.row == Static2.leaksNote.rawValue {
                 return 175
            } else if indexPath.row == Static2.summaryNote.rawValue {
                 return 175
            } else if indexPath.row == 6 {
                 return 145
            } else {
                return 125
            }
        } else {
            if indexPath.row == Static2.suctionAir.rawValue {
                return 585
            } else if indexPath.row == Static2.surgeTank.rawValue {
                return 385
            } else if indexPath.row == 2 {
                 return 210
            } else if indexPath.row == Static2.markLocDes.rawValue {
                 return 315
            } else if indexPath.row == Static2.leaksNote.rawValue {
                 return 315
            } else if indexPath.row == Static2.summaryNote.rawValue {
                 return 315
            } else if indexPath.row == 6 {
                return 210
            } else {
                return 175
            }
        }
    }
}


extension InspectPlumbingStatistic2VC: UITextViewDelegate {
    @objc func updateTextViewValue() {
        let cell = self.tblStatic2.cellForRow(at: IndexPath.init(row: self.selectedRowIndex, section: self.sectionIndex))
        guard let _cell = cell else { return  }
        
        if let SuctionLineAirTableCell = _cell as? SuctionLineAirTableCell {
            if let textView = SuctionLineAirTableCell.txtOther {
                if self.sectionIndex == 0 {
                    self.static2[self.sectionIndex].formTextValue = (textView.text)!
                }
            }
        } else if let SurgeTankTableCell = _cell as? SurgeTankTableCell {
            if let textView = SurgeTankTableCell.txtPressure {
                print(self.sectionIndex)
                print(self.selectedRowIndex)
                if self.sectionIndex == 0 && self.selectedRowIndex == 1 {
                    self.static2[Static2.surgeTank.rawValue].formTextValue = (textView.text)!
                }
            }
        } else if let DataTextViewTableCell = _cell as? DataTextViewTableCell {
            if let textView = DataTextViewTableCell.txtData {
                if self.sectionIndex == 0 && self.selectedRowIndex == 3 {
                    self.static2[Static2.markLocDes.rawValue].formTextValue = (textView.text)!
                } else if self.sectionIndex == 0 && self.selectedRowIndex == 4{
                    self.static2[Static2.leaksNote.rawValue].formTextValue = (textView.text)!
                } else{
                    self.static2[Static2.summaryNote.rawValue].formTextValue = (textView.text)!
                }
            }
        }
        
        
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        let cell = (textView.superview?.superview as? UITableViewCell)!
        
        let indexpath = self.tblStatic2.indexPath(for: cell)
        guard let _indexPath = indexpath else { return false }
        self.selectedRowIndex = _indexPath.row
        self.sectionIndex = _indexPath.section
        
        self.perform(#selector(PoolDetectionContactVC.updateTextViewValue), with: nil, afterDelay: 1)
        
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let cell = (textView.superview?.superview as? UITableViewCell)!
        
        let indexpath = self.tblStatic2.indexPath(for: cell)
        guard let _indexPath = indexpath else { return false }
        self.selectedRowIndex = _indexPath.row
        self.sectionIndex = _indexPath.section
        
        self.perform(#selector(PoolDetectionContactVC.updateTextViewValue), with: nil, afterDelay: 1)
        
        return true
    }
}
