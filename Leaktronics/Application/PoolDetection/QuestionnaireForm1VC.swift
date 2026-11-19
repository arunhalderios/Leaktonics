//
//  QuestionnaireForm1VC.swift
//  Leaktronics
//
//  Created by ivaninfotech on 4/8/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import CoreData
import DLRadioButton
import SVProgressHUD


class QuestionnaireForm1VC: UIViewController {
    
    
    @IBOutlet weak var tblPhone: UITableView!
    
    var poolDetailsDict = [String : AnyObject]()
    var poolDict = [String : AnyObject]()
    var strReport_id = String()
    
    var secPool1 = [formData]()
    var secPool4 = [formData]()
    var secPool5 = [formData]()
    
    private var sectionIndex = -1
    private var selectedRowIndex = -1
    
    enum FindText: Int {
        case otherFindUsText = 0
    }
    
    enum SpaSize: Int {
        case approxDimentionText = 0
    }
    
    enum SpaDescription: Int {
        case approxDimentionDescription = 0
    }
    
    //MARK:- Variable Declaration
    var isCommercialPool = String()
    var isFountain = String()
    var findUsOption = String()
    var reasonForCallOption = String()
    var poolSizeOption = String()
    var spaSizeOption = String()
    
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
        for _ in 0..<1 {
            let obj = formData()
            self.secPool1.append(obj)
        }
        
        for _ in 0..<1 {
            let obj = formData()
            self.secPool4.append(obj)
        }
        
        for _ in 0..<1 {
            let obj = formData()
            self.secPool5.append(obj)
        }
    }
    
    //MARK:- ObjectiveC Function
    @objc func btnNextDidTap() {
        self.updateCoreData(strReport_id: strReport_id)
        //self.checkNetwork()
        let isFrom: Bool = UserDefaults.standard.bool(forKey: "isFromReportList")
        if isFrom == true {
            self.postPoolPhoneQuestionnaire1Update()
        } else {
            self.postPoolPhoneQuestionnaire1()
        }
        /*if UIDevice.current.userInterfaceIdiom == .phone {
            let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection", bundle:nil)
            let formVC = storyBoard.instantiateViewController(withIdentifier: "QuestionnaireForm2") as! QuestionnaireForm2VC
            self.navigationController?.pushViewController(formVC, animated: true)
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection_iPad", bundle:nil)
            let formVC = storyBoard.instantiateViewController(withIdentifier: "QuestionnaireForm2") as! QuestionnaireForm2VC
            self.navigationController?.pushViewController(formVC, animated: true)
        }*/
    }
    
    //MARK:- CoreData
    func updateCoreData(strReport_id: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Pool2_CoreData")
        
        //let userName: String = UserDefaults.standard.value(forKey: "PoolDetectionUserName") as! String
        let predicate = NSPredicate(format: "%K == %@", "report_id", strReport_id)
        fetchRequest.predicate = predicate
        
        do {
            let reportResult = try managedContext.fetch(fetchRequest) as! [Pool2_CoreData]
            print("Report Data\(reportResult) and count is \(reportResult.count)")
            
            if reportResult.count == 0 {
                print ("Inserting DB")
                
                //For data fetch in coredata
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Pool2_CoreData")
                fetchRequest.returnsObjectsAsFaults = false
                
                let predicate = NSPredicate(format: "%K == %@", "report_id", strReport_id)
                fetchRequest.predicate = predicate
                
                let  rs = try managedContext.fetch(fetchRequest)
                for _ in rs as [NSManagedObject] {
                    // update
                    do {
                        let managedObject = rs[0]
                        
                        managedObject.setValue(self.poolDict["report_id"], forKey: "report_id")
                        managedObject.setValue(poolDict["isCommercialPool"], forKey: "isCommercialPool")
                        managedObject.setValue(poolDict["isFountain"], forKey: "isFountain")
                        managedObject.setValue(poolDict["findUsOption"], forKey: "findUsOption")
                        managedObject.setValue(poolDict["reasonForCallOption"], forKey: "reasonForCallOption")
                        managedObject.setValue(poolDict["poolSizeOption"], forKey: "poolSizeOption")
                        managedObject.setValue(poolDict["approxDimentionDescription"], forKey: "approxDimentionDescription")
                        managedObject.setValue(poolDict["approxDimentionText"], forKey: "approxDimentionText")
                        managedObject.setValue(poolDict["otherFindUsText"], forKey: "otherFindUsText")
                        managedObject.setValue(poolDict["spaSizeOption"], forKey: "spaSizeOption")
                        
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
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Pool2_CoreData")
                fetchRequest.returnsObjectsAsFaults = false
                
                let predicate = NSPredicate(format: "%K == %@", "report_id", strReport_id)
                fetchRequest.predicate = predicate
                
                let  rs = try managedContext.fetch(fetchRequest)
                for _ in rs as [NSManagedObject] {
                    // update
                    do {
                        let managedObject = rs[0]
                        
                        managedObject.setValue(strReport_id, forKey: "report_id")
                        managedObject.setValue(isCommercialPool, forKey: "isCommercialPool")
                        managedObject.setValue(isFountain, forKey: "isFountain")
                        managedObject.setValue(findUsOption, forKey: "findUsOption")
                        managedObject.setValue(reasonForCallOption, forKey: "reasonForCallOption")
                        managedObject.setValue(poolSizeOption, forKey: "poolSizeOption")
                        managedObject.setValue(self.secPool5[SpaDescription.approxDimentionDescription.rawValue].formTextValue, forKey: "approxDimentionDescription")
                        managedObject.setValue(self.secPool4[SpaSize.approxDimentionText.rawValue].formTextValue, forKey: "approxDimentionText")
                        managedObject.setValue(self.secPool1[FindText.otherFindUsText.rawValue].formTextValue, forKey: "otherFindUsText")
                        managedObject.setValue(spaSizeOption, forKey: "spaSizeOption")
                        
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
                let strPoolData: String = String(describing: self.poolDetailsDict["page_2"]!)
                if strPoolData != "<null>" {
                    self.poolDict = self.poolDetailsDict["page_2"] as! [String : AnyObject]
                }
                print(self.poolDict)
                self.updateCoreData(strReport_id: self.strReport_id)
                self.tblPhone.reloadData()
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
    func postPoolPhoneQuestionnaire1() {
        self.view.endEditing(true)
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        
        let questionnaire1Details:  NSMutableDictionary = [
            "return_data_id"       : strReport_id,
            "isCommercialPool"     : isCommercialPool,
            "isFountain"           : isFountain,
            "findUsOption"               : findUsOption,
            "reasonForCallOption"        : reasonForCallOption,
            "poolSizeOption"             : poolSizeOption,
            "approxDimentionDescription" : self.secPool5[SpaDescription.approxDimentionDescription.rawValue].formTextValue,
            "approxDimentionText" : self.secPool4[SpaSize.approxDimentionText.rawValue].formTextValue,
            "otherFindUsText" : self.secPool1[FindText.otherFindUsText.rawValue].formTextValue,
            "spaSizeOption" : spaSizeOption
        ]
        
        print("questionnaire1Details :: \(questionnaire1Details)")
        //if sharedExtension.connectedToNetwork() {
        ApiManager.sharedInstanceAPI.PostPoolPhoneQuestionnaire1(postId: 1, questionnaire1Details: questionnaire1Details, onSuccess: { json in
            DispatchQueue.main.async {
                print("PoolDetectionContactDetails json :: \(String(describing: json))")
                DispatchQueue.main.async(execute: {() -> Void in
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "QuestionnaireForm2") as! QuestionnaireForm2VC
                        formVC.strReport_id = self.strReport_id
                        self.navigationController?.pushViewController(formVC, animated: true)
                    } else if UIDevice.current.userInterfaceIdiom == .pad {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection_iPad", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "QuestionnaireForm2") as! QuestionnaireForm2VC
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
    
    func postPoolPhoneQuestionnaire1Update() {
        self.view.endEditing(true)
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        
        let questionnaire1Details:  NSMutableDictionary = [
            "report_id"       : strReport_id,
            "return_data_id"    : strReport_id,
            "isCommercialPool"     : isCommercialPool,
            "isFountain"           : isFountain,
            "findUsOption"               : findUsOption,
            "reasonForCallOption"        : reasonForCallOption,
            "poolSizeOption"             : poolSizeOption,
            "approxDimentionDescription" : self.secPool5[SpaDescription.approxDimentionDescription.rawValue].formTextValue,
            "approxDimentionText" : self.secPool4[SpaSize.approxDimentionText.rawValue].formTextValue,
            "otherFindUsText" : self.secPool1[FindText.otherFindUsText.rawValue].formTextValue,
            "spaSizeOption" : spaSizeOption
        ]
        
        print("questionnaire1Details :: \(questionnaire1Details)")
        //if sharedExtension.connectedToNetwork() {
        ApiManager.sharedInstanceAPI.PostPoolPhoneQuestionnaire1Update(postId: 1, questionnaire1Details: questionnaire1Details, onSuccess: { json in
            DispatchQueue.main.async {
                print("PoolDetectionContactDetails json :: \(String(describing: json))")
                SVProgressHUD.dismiss()
                DispatchQueue.main.async(execute: {() -> Void in
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "QuestionnaireForm2") as! QuestionnaireForm2VC
                        formVC.strReport_id = self.strReport_id
                        self.navigationController?.pushViewController(formVC, animated: true)
                    } else if UIDevice.current.userInterfaceIdiom == .pad {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection_iPad", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "QuestionnaireForm2") as! QuestionnaireForm2VC
                        formVC.strReport_id = self.strReport_id
                        self.navigationController?.pushViewController(formVC, animated: true)
                    }
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
}


extension QuestionnaireForm1VC: UITableViewDataSource, UITableViewDelegate {
    
    //MARK:- UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let addressCell = tableView.dequeueReusableCell(withIdentifier: "PhoneQuestionnaireCell", for: indexPath) as! PhoneQuestionnaireCell
            
            if poolDict.count > 0 {
                if String(describing: poolDict["isCommercialPool"]!) == "Yes" {
                    isCommercialPool = "Yes"
                    addressCell.btnCPoolYes.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
                    addressCell.btnCPoolNo.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    addressCell.btnCPoolYes.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
                    addressCell.btnCPoolNo.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
                } else {
                    isCommercialPool = "No"
                    addressCell.btnCPoolYes.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    addressCell.btnCPoolNo.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
                    addressCell.btnCPoolYes.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
                    addressCell.btnCPoolNo.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
                }
                if String(describing: poolDict["isFountain"]!) == "Yes" {
                    isFountain = "Yes"
                    addressCell.btnFountainYes.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
                    addressCell.btnFountainNo.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    addressCell.btnFountainYes.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
                    addressCell.btnFountainNo.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
                } else {
                    isFountain = "No"
                    addressCell.btnFountainYes.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    addressCell.btnFountainNo.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
                    addressCell.btnFountainYes.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
                    addressCell.btnFountainNo.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
                }
            } else {
                addressCell.delegatePhoneQuestionnaire = self
            }
            return addressCell
        } else if indexPath.section == 1 {
            let findCell = tableView.dequeueReusableCell(withIdentifier: "FindUsCell", for: indexPath) as! FindUsTableCell
            if poolDict.count > 0 {
                if String(describing: poolDict["findUsOption"]!) == "Existing customer (used our services in the past)" {
                    self.findUsOption = "Existing customer (used our services in the past)"
                    findCell.imgFindUsOptn0.image = UIImage(named: "checkmark")
                    findCell.imgFindUsOptn1.image = UIImage(named: "unchecked")
                    findCell.imgFindUsOptn2.image = UIImage(named: "unchecked")
                } else if String(describing: poolDict["findUsOption"]!) == "Online" {
                    self.findUsOption = "Online"
                    findCell.imgFindUsOptn0.image = UIImage(named: "unchecked")
                    findCell.imgFindUsOptn1.image = UIImage(named: "checkmark")
                    findCell.imgFindUsOptn2.image = UIImage(named: "unchecked")
                } else if String(describing: poolDict["findUsOption"]!) == "Other" {
                    self.findUsOption = "Other"
                    findCell.imgFindUsOptn0.image = UIImage(named: "unchecked")
                    findCell.imgFindUsOptn1.image = UIImage(named: "unchecked")
                    findCell.imgFindUsOptn2.image = UIImage(named: "checkmark")
                }
                self.secPool1[0].formTextValue = String(describing: poolDict["otherFindUsText"]!)
                findCell.txtOther.text = self.secPool1[indexPath.row].formTextValue
            } else {
                findCell.txtOther.text = self.secPool1[indexPath.row].formTextValue
            }
            findCell.txtOther.delegate = self
            findCell.delegateFindUs = self
            return findCell
        } else if indexPath.section == 2 {
            let reasonCell = tableView.dequeueReusableCell(withIdentifier: "ReasonForCallCell", for: indexPath) as! ReasonForCallTableCell
            if poolDict.count > 0 {
                if String(describing: poolDict["reasonForCallOption"]!) == "Pool water level dropping" {
                    self.reasonForCallOption = "Pool water level dropping"
                    reasonCell.imgReasonForCallOptn0.image = UIImage(named: "checkmark")
                    reasonCell.imgReasonForCallOptn1.image = UIImage(named: "unchecked")
                    reasonCell.imgReasonForCallOptn2.image = UIImage(named: "unchecked")
                    reasonCell.imgReasonForCallOptn3.image = UIImage(named: "unchecked")
                } else if String(describing: poolDict["reasonForCallOption"]!) == "Spa water level is dropping" {
                    self.reasonForCallOption = "Spa water level is dropping"
                    reasonCell.imgReasonForCallOptn0.image = UIImage(named: "unchecked")
                    reasonCell.imgReasonForCallOptn1.image = UIImage(named: "checkmark")
                    reasonCell.imgReasonForCallOptn2.image = UIImage(named: "unchecked")
                    reasonCell.imgReasonForCallOptn3.image = UIImage(named: "unchecked")
                } else if String(describing: poolDict["reasonForCallOption"]!) == "Pool company told to call" {
                    self.reasonForCallOption = "Pool company told to call"
                    reasonCell.imgReasonForCallOptn0.image = UIImage(named: "unchecked")
                    reasonCell.imgReasonForCallOptn1.image = UIImage(named: "unchecked")
                    reasonCell.imgReasonForCallOptn2.image = UIImage(named: "checkmark")
                    reasonCell.imgReasonForCallOptn3.image = UIImage(named: "unchecked")
                } else if String(describing: poolDict["reasonForCallOption"]!) == "Other" {
                    self.reasonForCallOption = "Other"
                    reasonCell.imgReasonForCallOptn0.image = UIImage(named: "unchecked")
                    reasonCell.imgReasonForCallOptn1.image = UIImage(named: "unchecked")
                    reasonCell.imgReasonForCallOptn2.image = UIImage(named: "unchecked")
                    reasonCell.imgReasonForCallOptn3.image = UIImage(named: "checkmark")
                }
            }
            
            reasonCell.delegateReasonForCall = self
            return reasonCell
        } else if indexPath.section == 3 {
            let poolSizeCell = tableView.dequeueReusableCell(withIdentifier: "PoolSizeCell", for: indexPath) as! PoolSizeTableCell
            
            if poolDict.count > 0 {
                if String(describing: poolDict["poolSizeOption"]!) == "Normal size (approximately 15 x 30, 20 x 40)" {
                    self.poolSizeOption = "Normal size (approximately 15 x 30, 20 x 40)"
                    poolSizeCell.imgPoolSizeOptn0.image = UIImage(named: "checkmark")
                    poolSizeCell.imgPoolSizeOptn1.image = UIImage(named: "unchecked")
                    poolSizeCell.imgPoolSizeOptn2.image = UIImage(named: "unchecked")
                    poolSizeCell.imgPoolSizeOptn3.image = UIImage(named: "unchecked")
                } else if String(describing: poolDict["poolSizeOption"]!) == "Smaller than normal" {
                    self.poolSizeOption = "Smaller than normal"
                    poolSizeCell.imgPoolSizeOptn0.image = UIImage(named: "unchecked")
                    poolSizeCell.imgPoolSizeOptn1.image = UIImage(named: "checkmark")
                    poolSizeCell.imgPoolSizeOptn2.image = UIImage(named: "unchecked")
                    poolSizeCell.imgPoolSizeOptn3.image = UIImage(named: "unchecked")
                } else if String(describing: poolDict["poolSizeOption"]!) == "Larger than normal" {
                    self.poolSizeOption = "Larger than normal"
                    poolSizeCell.imgPoolSizeOptn0.image = UIImage(named: "unchecked")
                    poolSizeCell.imgPoolSizeOptn1.image = UIImage(named: "unchecked")
                    poolSizeCell.imgPoolSizeOptn2.image = UIImage(named: "checkmark")
                    poolSizeCell.imgPoolSizeOptn3.image = UIImage(named: "unchecked")
                } else if String(describing: poolDict["poolSizeOption"]!) == "Other" {
                    self.poolSizeOption = "Other"
                    poolSizeCell.imgPoolSizeOptn0.image = UIImage(named: "unchecked")
                    poolSizeCell.imgPoolSizeOptn1.image = UIImage(named: "unchecked")
                    poolSizeCell.imgPoolSizeOptn2.image = UIImage(named: "unchecked")
                    poolSizeCell.imgPoolSizeOptn3.image = UIImage(named: "checkmark")
                }
            }
            
            poolSizeCell.delegatePoolSize = self
            return poolSizeCell
        } else if indexPath.section == 4 {
            let spaSizeCell = tableView.dequeueReusableCell(withIdentifier: "SpaSizeCell", for: indexPath) as! SpaSizeTableCell
            
            if poolDict.count > 0 {
                if String(describing: poolDict["spaSizeOption"]!) == "true" {
                    spaSizeOption = "true"
                    spaSizeCell.imgSpaSize.image = UIImage(named: "checkmark")
                } else if String(describing: poolDict["spaSizeOption"]!) == "false" {
                    spaSizeOption = "false"
                    spaSizeCell.imgSpaSize.image = UIImage(named: "unchecked")
                }
                self.secPool4[0].formTextValue = String(describing: poolDict["approxDimentionText"]!)
                spaSizeCell.txtDimension.text = self.secPool4[indexPath.row].formTextValue
            } else {
                spaSizeCell.txtDimension.text = self.secPool4[indexPath.row].formTextValue
            }
            spaSizeCell.txtDimension.delegate = self
            spaSizeCell.delegateSpaSize = self
            return spaSizeCell
        } else if indexPath.section == 5 {
            let SpaSizeDescriptionCell = tableView.dequeueReusableCell(withIdentifier: "SpaSizeDescriptionCell", for: indexPath) as! SpaSizeDescriptionTableCell
            
            SpaSizeDescriptionCell.txtDescription.keyboardType = UIKeyboardType.asciiCapable
            if poolDict.count > 0 {
                self.secPool5[0].formTextValue = String(describing: poolDict["approxDimentionDescription"]!)
                SpaSizeDescriptionCell.txtDescription.text = self.secPool5[indexPath.row].formTextValue
            } else {
                SpaSizeDescriptionCell.txtDescription.text = self.secPool5[indexPath.row].formTextValue
            }
            SpaSizeDescriptionCell.txtDescription.delegate = self
            return SpaSizeDescriptionCell
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
                return 340
            } else if indexPath.section == 1 {
                return 310
            } else if indexPath.section == 2 {
                return 240
            } else if indexPath.section == 3 {
                return 240
            } else if indexPath.section == 4 {
                return 145
            } else if indexPath.section == 5 {
                return 155
            } else {
                return 105
            }
        } else {
            if indexPath.section == 0 {
                return 595
            } else if indexPath.section == 1 {
                return 540
            } else if indexPath.section == 2 {
                return 590
            } else if indexPath.section == 3 {
                return 355
            } else if indexPath.section == 4 {
                return 205
            } else if indexPath.section == 5 {
                return 238
            } else {
                return 135
            }
        }
    }
}

extension QuestionnaireForm1VC: UITextFieldDelegate {
    @objc func updateTextfieldValue() {
        let cell = self.tblPhone.cellForRow(at: IndexPath.init(row: self.selectedRowIndex, section: self.sectionIndex))
        guard let _cell = cell else { return  }
        
        if let SpaSizeTableCell = _cell as? SpaSizeTableCell {
            if let textfield = SpaSizeTableCell.txtDimension {
                if self.sectionIndex == 4 {
                    self.secPool4[self.selectedRowIndex].formTextValue = (textfield.text)!
                } else {
                    //self.secPool2[self.selectedRowIndex].formTextValue = (textfield.text)!
                }
            }
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let cell = (textField.superview?.superview as? UITableViewCell)!
        
        let indexpath = self.tblPhone.indexPath(for: cell)
        guard let _indexPath = indexpath else { return false }
        self.selectedRowIndex = _indexPath.row
        self.sectionIndex = _indexPath.section
        
        self.perform(#selector(QuestionnaireForm1VC.updateTextfieldValue), with: nil, afterDelay: 1)
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range:NSRange, replacementString string: String) -> Bool {
        let cell = (textField.superview?.superview as? UITableViewCell)!
        
        let indexpath = self.tblPhone.indexPath(for: cell)
        guard let _indexPath = indexpath else { return false }
        self.selectedRowIndex = _indexPath.row
        self.sectionIndex = _indexPath.section
        
        self.perform(#selector(QuestionnaireForm1VC.updateTextfieldValue), with: nil, afterDelay: 1)
        
        return true
    }
}

extension QuestionnaireForm1VC: UITextViewDelegate {
    @objc func updateTextViewValue() {
        let cell = self.tblPhone.cellForRow(at: IndexPath.init(row: self.selectedRowIndex, section: self.sectionIndex))
        guard let _cell = cell else { return  }
        
        if let SpaSizeDescriptionTableCell = _cell as? SpaSizeDescriptionTableCell {
            if let textView = SpaSizeDescriptionTableCell.txtDescription {
                if self.sectionIndex == 5 {
                    self.secPool5[self.selectedRowIndex].formTextValue = (textView.text)!
                } else {
                    //self.secPool1[self.selectedRowIndex].formTextValue = (textView.text)!
                }
            }
        } else if let FindUsTableCell = _cell as? FindUsTableCell{
            if let textView = FindUsTableCell.txtOther {
                if self.sectionIndex == 1 {
                    self.secPool1[self.selectedRowIndex].formTextValue = (textView.text)!
                } else {
                    //self.secPool1[self.selectedRowIndex].formTextValue = (textView.text)!
                }
            }
        }
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        let cell = (textView.superview?.superview as? UITableViewCell)!
        
        let indexpath = self.tblPhone.indexPath(for: cell)
        guard let _indexPath = indexpath else { return false }
        self.selectedRowIndex = _indexPath.row
        self.sectionIndex = _indexPath.section
        
        self.perform(#selector(QuestionnaireForm1VC.updateTextViewValue), with: nil, afterDelay: 1)
        
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let cell = (textView.superview?.superview as? UITableViewCell)!
        
        let indexpath = self.tblPhone.indexPath(for: cell)
        guard let _indexPath = indexpath else { return false }
        self.selectedRowIndex = _indexPath.row
        self.sectionIndex = _indexPath.section
        
        self.perform(#selector(QuestionnaireForm1VC.updateTextViewValue), with: nil, afterDelay: 1)
        
        return true
    }
}

extension QuestionnaireForm1VC: PhoneQuestionnaireProtocol, FindUsCellProtocol, ReasonForCallProtocol, PoolSizeProtocol, SpaSizeProtocol {
    
    //MARK:- PhoneQuestionnaireProtocol
    func didTapOnCommercialPool(_isCommercialPool: Bool) {
        if _isCommercialPool == true {
            isCommercialPool = "Yes"
        } else {
            isCommercialPool = "No"
        }
    }
    
    func didTapOnFountain(_isFountain: Bool) {
        if _isFountain == true {
            isFountain = "Yes"
        } else {
            isFountain = "No"
        }
    }
    
    //MARK:- FindUsCellProtocol
    func didTapOnCellFindUs(_btnFindUsTag: Int) {
        if _btnFindUsTag == 0 {
            findUsOption = "Existing customer (used our services in the past)"
        } else if _btnFindUsTag == 1 {
            findUsOption = "Online"
        } else {
            findUsOption  = "Other"
        }
    }
    
    //MARK:- ReasonForCallProtocol
    func didTapOnReasonForCall(_btnReasonForCallTag: Int) {
        if _btnReasonForCallTag == 0 {
           reasonForCallOption = "Pool water level dropping"
        } else if _btnReasonForCallTag == 1 {
           reasonForCallOption = "Spa water level is dropping"
        } else if _btnReasonForCallTag == 2 {
           reasonForCallOption  = "Pool company told to call"
        } else {
           reasonForCallOption  = "Other"
        }
    }
    
    //MARK:- PoolSizeProtocol
    func didTapOnPoolSize(_btnPoolSizeTag: Int) {
        if _btnPoolSizeTag == 0 {
            poolSizeOption = "Normal size (approximately 15 x 30, 20 x 40)"
        } else if _btnPoolSizeTag == 1 {
            poolSizeOption = "Smaller than normal"
        } else if _btnPoolSizeTag == 2 {
            poolSizeOption = "Larger than normal"
        } else {
            poolSizeOption = "Other"
        }
    }
    
    //MARK:- SpaSizeProtocol
    func didTapOnSpaSize(_btnSpaSizeTag: Bool) {
        if _btnSpaSizeTag == true {
            spaSizeOption = "true"
        } else {
            spaSizeOption = "false"
        }
    }
}
