//
//  InspectQuestionnaireFormVC.swift
//  Leaktronics
//
//  Created by ivaninfotech on 4/14/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import CoreData
import DLRadioButton
import SVProgressHUD
import Alamofire



class InspectQuestionnaireFormVC: UIViewController {
    
    @IBOutlet weak var tblInspectionPhone: UITableView!
    
    var secPhQuestion = [formInspectionPoolData]()
    
    private var sectionIndex = -1
    private var selectedRowIndex = -1
    
    //For Options
    var strFindUsOption = String()
    var strRealEstateOption = String()
    var strInsuranceOption = String()
    
    enum Questionnaire: Int {
        case otherFindUsText = 0
    }
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.prepareFormInspectionPoolQuestionnaireData()
    }
    
    func prepareFormInspectionPoolQuestionnaireData() {
        for _ in 0..<7 {
            let obj = formInspectionPoolData()
            self.secPhQuestion.append(obj)
        }
    }
    
    //MARK:- Function
    @objc func btnNextDidTap() {
        self.updateCoreData()
        self.view.endEditing(true)
        
       //self.postInspectPhoneQuestionnaire()
        if UIDevice.current.userInterfaceIdiom == .phone {
            let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
            let formVC = storyBoard.instantiateViewController(withIdentifier: "Inspection") as! InspectionVC
            self.navigationController?.pushViewController(formVC, animated: true)
        } else {
            let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
            let formVC = storyBoard.instantiateViewController(withIdentifier: "Inspection") as! InspectionVC
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
                    
                    managedObject.setValue(strFindUsOption, forKey: "inspectFindUsOption")
                    managedObject.setValue(self.secPhQuestion[Questionnaire.otherFindUsText.rawValue].formTextValue, forKey: "otherFindUsText")
                    managedObject.setValue(strRealEstateOption, forKey: "realEstateOption")
                    managedObject.setValue(strInsuranceOption, forKey: "insuranceOption")
                    
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
                    if (data.value(forKey: "nameInspect") as! String) == userName {
                        print("Data of QuestionnaireFormVC:: \(data)")
                    }
                }
            } catch {
                print("Failed")
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    /*//MARK:: Function Api Calling
    func postInspectPhoneQuestionnaire() {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        
        let return_id = UserDefaults.standard.value(forKey: "returnKeyForInspection")
        let questionnaireInspectDetails:  NSMutableDictionary = [
            "return_data_id"        :     return_id!,
            "inspectFindUsOption"   : strFindUsOption,
            "otherFindUsText"       : self.secPhQuestion[Questionnaire.otherFindUsText.rawValue].formTextValue,
            "realEstateOption"      : strRealEstateOption,
            "insuranceOption"       : strInsuranceOption
        ]
        
        print("questionnaireInspectDetails :: \(questionnaireInspectDetails)")
        //if sharedExtension.connectedToNetwork() {
        ApiManager.sharedInstanceAPI.PostInspectionPoolPhoneQuestionnaire(postId: 1, questionnaireDetails: questionnaireInspectDetails, onSuccess: { json in
            DispatchQueue.main.async {
                print("InspectPhoneQuestionnaireDetails json :: \(String(describing: json))")
                DispatchQueue.main.async(execute: {() -> Void in
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "Inspection") as! InspectionVC
                        self.navigationController?.pushViewController(formVC, animated: true)
                    } else {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "Inspection") as! InspectionVC
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
}

extension InspectQuestionnaireFormVC: UITextViewDelegate {
    @objc func updateInspectTextViewValue() {
        let cell = self.tblInspectionPhone.cellForRow(at: IndexPath.init(row: self.selectedRowIndex, section: self.sectionIndex))
        guard let _cell = cell else { return  }
        
        if let addressTblCell = _cell as? FindUsTableCell {
            if let textView = addressTblCell.txtOther {
                if self.sectionIndex == 1 {
                    self.secPhQuestion[self.selectedRowIndex].formTextValue = (textView.text)!
                }
            }
        }
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        let cell = (textView.superview?.superview as? UITableViewCell)!
        
        let indexpath = self.tblInspectionPhone.indexPath(for: cell)
        guard let _indexPath = indexpath else { return false }
        self.selectedRowIndex = _indexPath.row
        self.sectionIndex = _indexPath.section
        
        self.perform(#selector(InspectQuestionnaireFormVC.updateInspectTextViewValue), with: nil, afterDelay: 1)
        
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let cell = (textView.superview?.superview as? UITableViewCell)!
        
        let indexpath = self.tblInspectionPhone.indexPath(for: cell)
        guard let _indexPath = indexpath else { return false }
        self.selectedRowIndex = _indexPath.row
        self.sectionIndex = _indexPath.section
        
        self.perform(#selector(InspectQuestionnaireFormVC.updateInspectTextViewValue), with: nil, afterDelay: 1)
        
        return true
    }
}

extension InspectQuestionnaireFormVC: UITableViewDataSource, UITableViewDelegate {
    //MARK:- UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let headerView : UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "CustomHeaderCell")!
            
            let lblHeaderTitle = headerView.viewWithTag(10) as! UILabel
            
            lblHeaderTitle.textColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.2352941176, alpha: 1)
            
            lblHeaderTitle.text = "Phone Questionnaire"  // set this however is appropriate for your app's model
            
            return headerView
        } else if indexPath.section == 1 {
            let findCell = tableView.dequeueReusableCell(withIdentifier: "FindUsCell", for: indexPath) as! FindUsTableCell
            
            findCell.txtOther.text = self.secPhQuestion[indexPath.row].formTextValue
            findCell.txtOther.delegate = self
            findCell.delegateFindUs = self
            
            return findCell
        } else if indexPath.section == 2 {
            let dealCell = tableView.dequeueReusableCell(withIdentifier: "RealEstateDealCell", for: indexPath) as! RealEstateDealTableCell
            
            dealCell.delegateRealEstateDeal = self
            
            return dealCell
        } else if indexPath.section == 3 {
            let claimCell = tableView.dequeueReusableCell(withIdentifier: "InsuranceClaimCell", for: indexPath) as! InsuranceClaimTableCell
            
            claimCell.delegateInsuranceClaim =  self
            
            return claimCell
        } else {
            let cellBtn = tableView.dequeueReusableCell(withIdentifier: "NextCell", for: indexPath) as! NextForm1TableCell
            
            cellBtn.btnNext.addTarget(self, action: #selector(btnNextDidTap), for: UIControl.Event.touchUpInside)
            return cellBtn
        }
    }
    
    //MARK:- UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .phone {
            if indexPath.section == 0 {
                return 45
            } else if indexPath.section == 1 {
                return 277
            } else if indexPath.section == 2 {
                return 150
            } else if indexPath.section == 3 {
                return 150
            } else {
                return 105
            }
        } else {   //.pad
            if indexPath.section == 0 {
                return 75
            } else if indexPath.section == 1 {
                return 490
            } else if indexPath.section == 2 {
                return 275
            } else if indexPath.section == 3 {
                return 275
            } else {
                return 175
            }
        }
    }
}


extension InspectQuestionnaireFormVC: FindUsCellProtocol, RealEstateDealProtocol, InsuranceClaimProtocol {
    func didTapOnCellFindUs(_btnFindUsTag: Int) {
        if _btnFindUsTag == 0 {
            strFindUsOption = "Existing customer (used our services in the past)"
        } else if _btnFindUsTag == 1 {
            strFindUsOption = "Online"
        } else {
            strFindUsOption  = "Other"
        }
    }
    
    func didTapOnCellRealEstateDeal(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strRealEstateOption = "Buyer"
        } else if _btnDescribeTag == 1 {
            strRealEstateOption = "Seller"
        }
    }
    
    func didTapOnCellInsuranceClaim(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strInsuranceOption = "Yes"
        } else if _btnDescribeTag == 1 {
            strInsuranceOption = "No"
        }
    }
}
