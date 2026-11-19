//
//  QuestionnaireForm2VC.swift
//  Leaktronics
//
//  Created by ivaninfotech on 4/8/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import CoreData
import DLRadioButton
import SVProgressHUD


class QuestionnaireForm2VC: UIViewController, PoolSurfaceProtocol, BoolProtocol, WaterFeatureProtocol {
    
     @IBOutlet weak var tblForm2: UITableView!
     var poolDetailsDict = [String : AnyObject]()
     var poolDict = [String : AnyObject]()
     var strReport_id = String()
    
    //MARK:- Variable Declaration
    var poolSurfaceOption = String()
    var pumpRunningOption = String()
    var isWaterVisible = String()
    var isRecentWorkAroundPool = String()
    var isPoolCleaning = String()
    var isFloorSystem = String()
    var isPoolWaterFeature = String()
    var isSolarSystem = String()
    var poolWaterFeatureOption = String()
    
    var MarciteCheckStatus = false
    var VinylCheckStatus = false
    var Fiberglass_CoatedCheckStatus = false
    var Fiberglass_dropCheckStatus = false
    var All_tile_poolCheckStatus = false


    
    var form2 = [formData]()
    
    private var sectionIndex = -1
    private var selectedRowIndex = -1
    
    enum Questionnaire: Int {
        case pumpRunning = 0
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
        for _ in 0..<2 {
            let obj = formData()
            self.form2.append(obj)
        }
    }
    
    //MARK:- PoolSurfaceProtocol
    func didTapOnPoolSurfacee(_btnPoolSurfaceTag: Int) {
        if _btnPoolSurfaceTag == 0 {
            poolSurfaceOption = "Marcite / Plaster / Exposed Aggregate"
        } else if _btnPoolSurfaceTag == 1 {
            poolSurfaceOption = "Vinyl"
        } else if _btnPoolSurfaceTag == 2 {
            poolSurfaceOption  = "Fiberglass Coated"
        } else if _btnPoolSurfaceTag == 3 {
            poolSurfaceOption  = "Fiberglass drop in"
        } else  {
            poolSurfaceOption = "All tile pool "
        }
    }
    
    //MARK:- BoolProtocol
    func didTapOnPumpRunningStatus(_btnPumpRunning: Int) {
        if  _btnPumpRunning == 0 {
            pumpRunningOption = "Yes"
        } else if _btnPumpRunning == 1 {
            pumpRunningOption = "No"
        } else {
            pumpRunningOption = "Unsure"
        }
    }
    
    func didTapOnWaterVisible(_isWaterVisible: Bool) {
        if _isWaterVisible == true {
            isWaterVisible = "Yes"
        }else{
            isWaterVisible = "No"
        }
    }
    
    func didTapOnRecentWorkAroundPool(_isRecentWorkAroundPool: Bool) {
        if _isRecentWorkAroundPool == true {
            isRecentWorkAroundPool = "Yes"
        } else{
             isRecentWorkAroundPool = "No"
        }
    }
    
    func didTapOnPoolCleaning(_isPoolCleaning: Bool) {
        if _isPoolCleaning == true {
            isPoolCleaning = "Yes"
        } else {
            isPoolCleaning = "No"
        }
    }
    
    func didTapOnFloorSystem(_isFloorSystem: Bool) {
        if _isFloorSystem == true {
            isFloorSystem = "Yes"
        }
    }
    
    //MARK:- WaterFeatureProtocol
    func didTapOnPoolWaterFeature(_isPoolWaterFeature: Bool) {
        if _isPoolWaterFeature == true {
            isPoolWaterFeature = "Yes"
        } else{
            isPoolWaterFeature = "No"
        }
    }
    
    func didTapOnPoolWaterFeatureOption(_btnPoolWaterFeatureTag: Int) {
        if _btnPoolWaterFeatureTag == 0 {
            poolWaterFeatureOption = "Sheer Decent Wall"
        } else if _btnPoolWaterFeatureTag == 1 {
            poolWaterFeatureOption = "Rock Formation Waterfall"
        } else if _btnPoolWaterFeatureTag == 2 {
            poolWaterFeatureOption = "Infinity Edge (Negative Edge)"
        } else if _btnPoolWaterFeatureTag == 3 {
            poolWaterFeatureOption = "Catch Basin"
        } else if _btnPoolWaterFeatureTag == 4 {
            poolWaterFeatureOption = "Other"
        }
    }
    
    func didTapOnSolarSystem(_isSolarSystem: Bool) {
        if _isSolarSystem == true {
            isSolarSystem = "Yes"
        } else {
            isSolarSystem = "No"
        }
    }
    
    //MARK:- ObjectiveC Function
    @objc func btnNextDidTap() {
        self.view.endEditing(true)
        self.updateCoreData(strReport_id: strReport_id)
        //self.checkNetwork()
        let isFrom: Bool = UserDefaults.standard.bool(forKey: "isFromReportList")
        if isFrom == true {
            self.postPoolPhoneQuestionnaire2Update()
        } else {
            self.postPoolPhoneQuestionnaire2()
        }
        /*if UIDevice.current.userInterfaceIdiom == .phone {
            let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection", bundle:nil)
            let VisualLeakVC = storyBoard.instantiateViewController(withIdentifier: "VisualLeak") as! VisualLeakVC
            self.navigationController?.pushViewController(VisualLeakVC, animated: true)
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection_iPad", bundle:nil)
            let VisualLeakVC = storyBoard.instantiateViewController(withIdentifier: "VisualLeak") as! VisualLeakVC
            self.navigationController?.pushViewController(VisualLeakVC, animated: true)
        }*/
    }
    
    //MARK:- CoreData
    func updateCoreData(strReport_id: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Pool3_CoreData")
        
        //let userName: String = UserDefaults.standard.value(forKey: "PoolDetectionUserName") as! String
        let predicate = NSPredicate(format: "%K == %@", "report_id", strReport_id)
        fetchRequest.predicate = predicate
        
        do {
            let reportResult = try managedContext.fetch(fetchRequest) as! [Pool3_CoreData]
            print("Report Data\(reportResult) and count is \(reportResult.count)")
            
            if reportResult.count == 0 {
                print ("Inserting DB")
                
                //For data fetch in coredata
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Pool3_CoreData")
                fetchRequest.returnsObjectsAsFaults = false
                
                let predicate = NSPredicate(format: "%K == %@", "report_id", strReport_id)
                fetchRequest.predicate = predicate
                
                let  rs = try managedContext.fetch(fetchRequest)
                for _ in rs as [NSManagedObject] {
                    // update
                    do {
                        let managedObject = rs[0]
                        
                        managedObject.setValue(self.poolDict["report_id"], forKey: "report_id")
                        managedObject.setValue(poolDict["poolSurfaceOption"], forKey: "poolSurfaceOption")
                        managedObject.setValue(poolDict["pumpRunningOption"], forKey: "pumpRunningOption")
                        managedObject.setValue(poolDict["pumpRunningInfo"], forKey: "pumpRunningInfo")
                        managedObject.setValue(poolDict["isWaterVisible"], forKey: "isWaterVisible")
                        managedObject.setValue(poolDict["isRecentWorkAroundPool"], forKey: "isRecentWorkAroundPool")
                        managedObject.setValue(poolDict["isPoolCleaning"], forKey: "isPoolCleaning")
                        managedObject.setValue(poolDict["isFloorSystem"], forKey: "isFloorSystem")
                        managedObject.setValue(poolDict["isPoolWaterFeature"], forKey: "isPoolWaterFeature")
                        managedObject.setValue(poolDict["isSolarSystem"], forKey: "isSolarSystem")
                        managedObject.setValue(poolDict["poolWaterFeatureOption"], forKey: "poolWaterFeatureOption")
                        
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
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Pool3_CoreData")
                fetchRequest.returnsObjectsAsFaults = false
                
                let predicate = NSPredicate(format: "%K == %@", "report_id", strReport_id)
                fetchRequest.predicate = predicate
                
                let  rs = try managedContext.fetch(fetchRequest)
                for _ in rs as [NSManagedObject] {
                    // update
                    do {
                        let managedObject = rs[0]
                        
                        managedObject.setValue(strReport_id, forKey: "report_id")
                        managedObject.setValue(poolSurfaceOption, forKey: "poolSurfaceOption")
                        managedObject.setValue(pumpRunningOption, forKey: "pumpRunningOption")
                        managedObject.setValue(self.form2[Questionnaire.pumpRunning.rawValue].formTextValue, forKey: "pumpRunningInfo")
                        managedObject.setValue(isWaterVisible, forKey: "isWaterVisible")
                        managedObject.setValue(isRecentWorkAroundPool, forKey: "isRecentWorkAroundPool")
                        managedObject.setValue(isPoolCleaning, forKey: "isPoolCleaning")
                        managedObject.setValue(isFloorSystem, forKey: "isFloorSystem")
                        managedObject.setValue(isPoolWaterFeature, forKey: "isPoolWaterFeature")
                        managedObject.setValue(isSolarSystem, forKey: "isSolarSystem")
                        managedObject.setValue(poolWaterFeatureOption, forKey: "poolWaterFeatureOption")
                        
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
                let strPoolData: String = String(describing: self.poolDetailsDict["page_3"]!)
                if strPoolData != "<null>" {
                    self.poolDict = self.poolDetailsDict["page_3"] as! [String : AnyObject]
                }
                print(self.poolDict)
                self.updateCoreData(strReport_id: self.strReport_id)
                self.tblForm2.reloadData()
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
    func postPoolPhoneQuestionnaire2() {
        self.view.endEditing(true)
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        
        let questionnaire2Details:  NSMutableDictionary = [
            "return_data_id"            : strReport_id,
            "poolSurfaceOption"         : poolSurfaceOption,
            "pumpRunningOption"         : pumpRunningOption,
            "pumpRunningInfo"           : self.form2[Questionnaire.pumpRunning.rawValue].formTextValue,
            "isWaterVisible"            : isWaterVisible,
            "isRecentWorkAroundPool"    : isRecentWorkAroundPool,
            "isPoolCleaning"            : isPoolCleaning,
            "isFloorSystem"             : isFloorSystem,
            "isPoolWaterFeature"        : isPoolWaterFeature,
            "isSolarSystem"             : isSolarSystem,
            "poolWaterFeatureOption"    : poolWaterFeatureOption
        ]
        
        print("questionnaire2Details :: \(questionnaire2Details)")
        ApiManager.sharedInstanceAPI.PostPoolPhoneQuestionnaire2(postId: 1, questionnaire2Details: questionnaire2Details, onSuccess: { json in
            DispatchQueue.main.async {
                print("PoolDetectionContactDetails json :: \(String(describing: json))")
                DispatchQueue.main.async(execute: {() -> Void in
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "VisualLeak") as! VisualLeakVC
                        formVC.strReport_id = self.strReport_id
                        self.navigationController?.pushViewController(formVC, animated: true)
                    } else if UIDevice.current.userInterfaceIdiom == .pad {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection_iPad", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "VisualLeak") as! VisualLeakVC
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
    func postPoolPhoneQuestionnaire2Update() {
        self.view.endEditing(true)
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        
        let questionnaire2Details:  NSMutableDictionary = [
            "report_id"     : strReport_id,
            "return_data_id"            : strReport_id,
            "poolSurfaceOption"         : poolSurfaceOption,
            "pumpRunningOption"         : pumpRunningOption,
            "pumpRunningInfo"           : self.form2[Questionnaire.pumpRunning.rawValue].formTextValue,
            "isWaterVisible"            : isWaterVisible,
            "isRecentWorkAroundPool"    : isRecentWorkAroundPool,
            "isPoolCleaning"            : isPoolCleaning,
            "isFloorSystem"             : isFloorSystem,
            "isPoolWaterFeature"        : isPoolWaterFeature,
            "isSolarSystem"             : isSolarSystem,
            "poolWaterFeatureOption"    : poolWaterFeatureOption
        ]
        
        print("questionnaire2Details :: \(questionnaire2Details)")
        ApiManager.sharedInstanceAPI.PostPoolPhoneQuestionnaire2Update(postId: 1, questionnaire2Details: questionnaire2Details, onSuccess: { json in
            DispatchQueue.main.async {
                print("PoolDetectionContactDetails json :: \(String(describing: json))")
                DispatchQueue.main.async(execute: {() -> Void in
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "VisualLeak") as! VisualLeakVC
                        formVC.strReport_id = self.strReport_id
                        self.navigationController?.pushViewController(formVC, animated: true)
                    } else if UIDevice.current.userInterfaceIdiom == .pad {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection_iPad", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "VisualLeak") as! VisualLeakVC
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


extension QuestionnaireForm2VC: UITableViewDataSource, UITableViewDelegate {
    
    //MARK:- UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let poolSurfaceCell = tableView.dequeueReusableCell(withIdentifier: "PoolSurfaceCell", for: indexPath) as! PoolSurfaceTableCell
            
            
            
            if poolDict.count > 0 {
                if String(describing: poolDict["poolSurfaceOption"]!) == "Marcite / Plaster / Exposed Aggregate" {
                    self.poolSurfaceOption = "Marcite / Plaster / Exposed Aggregate"
                    
                    if MarciteCheckStatus == false{
                        MarciteCheckStatus = true
                        poolSurfaceCell.imgPoolSurfaceOptn0.image = UIImage(named: "checkmark")
                    }
                    else{
                        MarciteCheckStatus = false
                        poolSurfaceCell.imgPoolSurfaceOptn0.image = UIImage(named: "unchecked")
                    }
                  //  poolSurfaceCell.imgPoolSurfaceOptn0.image = UIImage(named: "checkmark")
//                    poolSurfaceCell.imgPoolSurfaceOptn1.image = UIImage(named: "unchecked")
//                    poolSurfaceCell.imgPoolSurfaceOptn2.image = UIImage(named: "unchecked")
//                    poolSurfaceCell.imgPoolSurfaceOptn3.image = UIImage(named: "unchecked")
//                    poolSurfaceCell.imgPoolSurfaceOptn4.image = UIImage(named: "unchecked")
                }
                if String(describing: poolDict["poolSurfaceOption"]!) == "Vinyl" {
                    self.poolSurfaceOption = "Vinyl"
                    
                    if VinylCheckStatus == false{
                        VinylCheckStatus = true
                        poolSurfaceCell.imgPoolSurfaceOptn1.image = UIImage(named: "checkmark")
                    }
                    else{
                        VinylCheckStatus = false
                        poolSurfaceCell.imgPoolSurfaceOptn1.image = UIImage(named: "unchecked")
                    }
                   // poolSurfaceCell.imgPoolSurfaceOptn0.image = UIImage(named: "unchecked")
                   // poolSurfaceCell.imgPoolSurfaceOptn1.image = UIImage(named: "checkmark")
//                    poolSurfaceCell.imgPoolSurfaceOptn2.image = UIImage(named: "unchecked")
//                    poolSurfaceCell.imgPoolSurfaceOptn3.image = UIImage(named: "unchecked")
//                    poolSurfaceCell.imgPoolSurfaceOptn4.image = UIImage(named: "unchecked")
                }
                if String(describing: poolDict["poolSurfaceOption"]!) == "Fiberglass Coated" {
                    self.poolSurfaceOption = "Fiberglass Coated"
                    if Fiberglass_CoatedCheckStatus == false{
                        Fiberglass_CoatedCheckStatus = true
                        poolSurfaceCell.imgPoolSurfaceOptn2.image = UIImage(named: "checkmark")
                    }
                    else{
                        Fiberglass_CoatedCheckStatus = false
                        poolSurfaceCell.imgPoolSurfaceOptn2.image = UIImage(named: "unchecked")
                    }

//                    poolSurfaceCell.imgPoolSurfaceOptn0.image = UIImage(named: "unchecked")
//                    poolSurfaceCell.imgPoolSurfaceOptn1.image = UIImage(named: "unchecked")
//                    poolSurfaceCell.imgPoolSurfaceOptn2.image = UIImage(named: "checkmark")
//                    poolSurfaceCell.imgPoolSurfaceOptn3.image = UIImage(named: "unchecked")
//                    poolSurfaceCell.imgPoolSurfaceOptn4.image = UIImage(named: "unchecked")
                }
                if String(describing: poolDict["poolSurfaceOption"]!) == "Fiberglass drop in" {
                    self.poolSurfaceOption = "Fiberglass drop in"
                    if Fiberglass_dropCheckStatus == false{
                        Fiberglass_dropCheckStatus = true
                        poolSurfaceCell.imgPoolSurfaceOptn3.image = UIImage(named: "checkmark")
                    }
                    else{
                        Fiberglass_dropCheckStatus = false
                        poolSurfaceCell.imgPoolSurfaceOptn3.image = UIImage(named: "unchecked")
                    }

//                    poolSurfaceCell.imgPoolSurfaceOptn0.image = UIImage(named: "unchecked")
//                    poolSurfaceCell.imgPoolSurfaceOptn1.image = UIImage(named: "unchecked")
//                    poolSurfaceCell.imgPoolSurfaceOptn2.image = UIImage(named: "unchecked")
//                    poolSurfaceCell.imgPoolSurfaceOptn3.image = UIImage(named: "checkmark")
//                    poolSurfaceCell.imgPoolSurfaceOptn4.image = UIImage(named: "unchecked")
                }
                if String(describing: poolDict["poolSurfaceOption"]!) == "All tile pool" {
                    self.poolSurfaceOption = "All tile pool"
                    if All_tile_poolCheckStatus == false{
                        All_tile_poolCheckStatus = true
                        poolSurfaceCell.imgPoolSurfaceOptn4.image = UIImage(named: "checkmark")
                    }
                    else{
                        All_tile_poolCheckStatus = false
                        poolSurfaceCell.imgPoolSurfaceOptn4.image = UIImage(named: "unchecked")
                    }

//                    poolSurfaceCell.imgPoolSurfaceOptn0.image = UIImage(named: "unchecked")
//                    poolSurfaceCell.imgPoolSurfaceOptn1.image = UIImage(named: "unchecked")
//                    poolSurfaceCell.imgPoolSurfaceOptn2.image = UIImage(named: "unchecked")
//                    poolSurfaceCell.imgPoolSurfaceOptn3.image = UIImage(named: "unchecked")
//                    poolSurfaceCell.imgPoolSurfaceOptn4.image = UIImage(named: "checkmark")
                }
            }
            poolSurfaceCell.delegatePoolSurface = self
                
            return poolSurfaceCell
        } else if indexPath.section == 1 {
            let boolCell = tableView.dequeueReusableCell(withIdentifier: "BoolCell", for: indexPath) as! BoolTableCell
            
            boolCell.txtPumpRunning.keyboardType = UIKeyboardType.asciiCapable
            if poolDict.count > 0 {
                //pumpRunning
                if String(describing: poolDict["pumpRunningOption"]!) == "Yes" {
                    pumpRunningOption = "Yes"
                    boolCell.btnPumpRunningYes.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
                    boolCell.btnPumpRunningYes.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
                    boolCell.btnPumpRunningNo.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    boolCell.btnPumpRunningNo.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
                    boolCell.btnPumpRunningUnSure.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    boolCell.btnPumpRunningUnSure.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
                } else if String(describing: poolDict["pumpRunningOption"]!) == "No" {
                    pumpRunningOption = "No"
                    boolCell.btnPumpRunningYes.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    boolCell.btnPumpRunningYes.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
                    boolCell.btnPumpRunningNo.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
                    boolCell.btnPumpRunningNo.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
                    boolCell.btnPumpRunningUnSure.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    boolCell.btnPumpRunningUnSure.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
                } else if String(describing: poolDict["pumpRunningOption"]!) == "Unsure" {
                    pumpRunningOption = "Unsure"
                    boolCell.btnPumpRunningYes.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    boolCell.btnPumpRunningYes.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
                    boolCell.btnPumpRunningNo.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    boolCell.btnPumpRunningNo.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
                    boolCell.btnPumpRunningUnSure.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
                    boolCell.btnPumpRunningUnSure.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
                }
                
                //Water Visible
                if String(describing: poolDict["isWaterVisible"]!) == "Yes" {
                    isWaterVisible = "Yes"
                    boolCell.btnWaterVisibleYes.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
                    boolCell.btnWaterVisibleYes.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
                    boolCell.btnWaterVisibleNo.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    boolCell.btnWaterVisibleNo.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
                } else if String(describing: poolDict["isWaterVisible"]!) == "No" {
                    isWaterVisible = "No"
                    boolCell.btnWaterVisibleYes.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    boolCell.btnWaterVisibleYes.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
                    boolCell.btnWaterVisibleNo.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
                    boolCell.btnWaterVisibleNo.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
                }
                
                //isRecentWorkAroundPool
                if String(describing: poolDict["isRecentWorkAroundPool"]!) == "Yes" {
                    isRecentWorkAroundPool = "Yes"
                    boolCell.btnRecentWorkYes.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
                    boolCell.btnRecentWorkYes.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
                    boolCell.btnRecentWorkNo.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    boolCell.btnRecentWorkNo.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
                } else if String(describing: poolDict["isRecentWorkAroundPool"]!) == "No" {
                    isRecentWorkAroundPool = "No"
                    boolCell.btnRecentWorkYes.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    boolCell.btnRecentWorkYes.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
                    boolCell.btnRecentWorkNo.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
                    boolCell.btnRecentWorkNo.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
                }
                
                //isPoolCleaning
                if String(describing: poolDict["isPoolCleaning"]!) == "Yes" {
                    isPoolCleaning = "Yes"
                    boolCell.btnPoolCleanYes.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
                    boolCell.btnPoolCleanYes.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
                    boolCell.btnPoolCleanNo.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    boolCell.btnPoolCleanNo.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
                } else if String(describing: poolDict["isPoolCleaning"]!) == "No" {
                    isPoolCleaning = "No"
                    boolCell.btnPoolCleanYes.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    boolCell.btnPoolCleanYes.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
                    boolCell.btnPoolCleanNo.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
                    boolCell.btnPoolCleanNo.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
                }
                
                //isFloorSystem
                if String(describing: poolDict["isFloorSystem"]!) == "Yes" {
                    isFloorSystem = "Yes"
                    boolCell.btnFloorSystemYes.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
                    boolCell.btnFloorSystemYes.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
                    boolCell.btnFloorSystemNo.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    boolCell.btnFloorSystemNo.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
                } else if String(describing: poolDict["isFloorSystem"]!) == "No" {
                    isFloorSystem = "No"
                    boolCell.btnFloorSystemYes.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    boolCell.btnFloorSystemYes.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
                    boolCell.btnFloorSystemNo.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
                    boolCell.btnFloorSystemNo.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
                }
                
                self.form2[0].formTextValue = String(describing: poolDict["pumpRunningInfo"]!)
                boolCell.txtPumpRunning.text = String(describing: poolDict["pumpRunningInfo"]!)                
            } else {
                boolCell.txtPumpRunning.text = self.form2[indexPath.row].formTextValue
            }
            
            boolCell.delegateBool = self
            boolCell.txtPumpRunning.delegate = self
            
            return boolCell
        } else if indexPath.section == 2 {
            let waterFeatureCell = tableView.dequeueReusableCell(withIdentifier: "WaterFeatureCell", for: indexPath) as! WaterFeatureTableCell
            if poolDict.count > 0 {
                //isPoolWaterFeature
                if String(describing: poolDict["isPoolWaterFeature"]!) == "Yes" {
                    isPoolWaterFeature = "Yes"
                    waterFeatureCell.btnPoolWaterFeatureYes.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
                    waterFeatureCell.btnPoolWaterFeatureYes.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
                    waterFeatureCell.btnPoolWaterFeatureNo.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    waterFeatureCell.btnPoolWaterFeatureNo.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
                } else if String(describing: poolDict["isPoolWaterFeature"]!) == "No" {
                    isPoolWaterFeature = "No"
                    waterFeatureCell.btnPoolWaterFeatureYes.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    waterFeatureCell.btnPoolWaterFeatureYes.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
                    waterFeatureCell.btnPoolWaterFeatureNo.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
                    waterFeatureCell.btnPoolWaterFeatureNo.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
                }
                
                //poolWaterFeatureOption
                if String(describing: poolDict["poolWaterFeatureOption"]!) == "Sheer Decent Wall" {
                    self.poolWaterFeatureOption = "Sheer Decent Wall"
                    waterFeatureCell.imgWaterFeatureOptn0.image = UIImage(named: "checkmark")
                    waterFeatureCell.imgWaterFeatureOptn1.image = UIImage(named: "unchecked")
                    waterFeatureCell.imgWaterFeatureOptn2.image = UIImage(named: "unchecked")
                    waterFeatureCell.imgWaterFeatureOptn3.image = UIImage(named: "unchecked")
                    waterFeatureCell.imgWaterFeatureOptn4.image = UIImage(named: "unchecked")
                } else if String(describing: poolDict["poolWaterFeatureOption"]!) == "Rock Formation Waterfall" {
                    self.poolWaterFeatureOption = "Rock Formation Waterfall"
                    waterFeatureCell.imgWaterFeatureOptn0.image = UIImage(named: "unchecked")
                    waterFeatureCell.imgWaterFeatureOptn1.image = UIImage(named: "checkmark")
                    waterFeatureCell.imgWaterFeatureOptn2.image = UIImage(named: "unchecked")
                    waterFeatureCell.imgWaterFeatureOptn3.image = UIImage(named: "unchecked")
                    waterFeatureCell.imgWaterFeatureOptn4.image = UIImage(named: "unchecked")
                } else if String(describing: poolDict["poolWaterFeatureOption"]!) == "Infinity Edge (Negative Edge)" {
                    self.poolWaterFeatureOption = "Infinity Edge (Negative Edge)"
                    waterFeatureCell.imgWaterFeatureOptn0.image = UIImage(named: "unchecked")
                    waterFeatureCell.imgWaterFeatureOptn1.image = UIImage(named: "unchecked")
                    waterFeatureCell.imgWaterFeatureOptn2.image = UIImage(named: "checkmark")
                    waterFeatureCell.imgWaterFeatureOptn3.image = UIImage(named: "unchecked")
                    waterFeatureCell.imgWaterFeatureOptn4.image = UIImage(named: "unchecked")
                } else if String(describing: poolDict["poolWaterFeatureOption"]!) == "Catch Basin" {
                    self.poolWaterFeatureOption = "Catch Basin"
                    waterFeatureCell.imgWaterFeatureOptn0.image = UIImage(named: "unchecked")
                    waterFeatureCell.imgWaterFeatureOptn1.image = UIImage(named: "unchecked")
                    waterFeatureCell.imgWaterFeatureOptn2.image = UIImage(named: "unchecked")
                    waterFeatureCell.imgWaterFeatureOptn3.image = UIImage(named: "checkmark")
                    waterFeatureCell.imgWaterFeatureOptn4.image = UIImage(named: "unchecked")
                } else if String(describing: poolDict["poolWaterFeatureOption"]!) == "Other" {
                    self.poolWaterFeatureOption = "Other"
                    waterFeatureCell.imgWaterFeatureOptn0.image = UIImage(named: "unchecked")
                    waterFeatureCell.imgWaterFeatureOptn1.image = UIImage(named: "unchecked")
                    waterFeatureCell.imgWaterFeatureOptn2.image = UIImage(named: "unchecked")
                    waterFeatureCell.imgWaterFeatureOptn3.image = UIImage(named: "unchecked")
                    waterFeatureCell.imgWaterFeatureOptn4.image = UIImage(named: "checkmark")
                }
                
                //isSolarSystem
                if String(describing: poolDict["isSolarSystem"]!) == "Yes" {
                    isSolarSystem = "Yes"
                    waterFeatureCell.btnSolarSystemYes.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
                    waterFeatureCell.btnSolarSystemYes.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
                    waterFeatureCell.btnSolarSystemNo.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    waterFeatureCell.btnSolarSystemNo.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
                } else if String(describing: poolDict["isSolarSystem"]!) == "No" {
                    isSolarSystem = "No"
                    waterFeatureCell.btnSolarSystemYes.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    waterFeatureCell.btnSolarSystemYes.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
                    waterFeatureCell.btnSolarSystemNo.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
                    waterFeatureCell.btnSolarSystemNo.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
                }
            } else {
                waterFeatureCell.delegateWaterFeature = self
            }
            return waterFeatureCell
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
                return 285
            } else if indexPath.section == 1 {
                return 760
            } else if indexPath.section == 2 {
                return 430
            } else {
                return 105
            }
        } else {
            if indexPath.section == 0 {
               return 435
            } else if indexPath.section == 1 {
               return 1480
            } else if indexPath.section == 2 {
               return 1125
            } else {
               return 195
            }
        }
    }
}

extension QuestionnaireForm2VC: UITextViewDelegate {
    @objc func updateTextViewValue() {
        let cell = self.tblForm2.cellForRow(at: IndexPath.init(row: self.selectedRowIndex, section: self.sectionIndex))
        guard let _cell = cell else { return  }
        
        if let pumpRunningTblCell = _cell as? BoolTableCell {
            if let textView = pumpRunningTblCell.txtPumpRunning {
                if self.sectionIndex == 1 {
                    self.form2[self.selectedRowIndex].formTextValue = (textView.text)!
                }
            }
        }
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        let cell = (textView.superview?.superview as? UITableViewCell)!
        
        let indexpath = self.tblForm2.indexPath(for: cell)
        guard let _indexPath = indexpath else { return false }
        self.selectedRowIndex = _indexPath.row
        self.sectionIndex = _indexPath.section
        
        self.perform(#selector(QuestionnaireForm2VC.updateTextViewValue), with: nil, afterDelay: 1)
        
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let cell = (textView.superview?.superview as? UITableViewCell)!
        
        let indexpath = self.tblForm2.indexPath(for: cell)
        guard let _indexPath = indexpath else { return false }
        self.selectedRowIndex = _indexPath.row
        self.sectionIndex = _indexPath.section
        
        self.perform(#selector(QuestionnaireForm2VC.updateTextViewValue), with: nil, afterDelay: 1)
        
        return true
    }
}
