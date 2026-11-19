//
//  PlumbingStatistic2VC.swift
//  Leaktronics
//
//  Created by Abhishek Mullick on 08/04/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import CoreData
import DLRadioButton
import Alamofire
import SVProgressHUD

class PlumbingStatistic2VC: UIViewController, SuctionLineAirCellProtocol,MarkLocationCellProtocol,EstimateCellProtocol {
    
    @IBOutlet weak var tblStatic2: UITableView!
    var poolDetailsDict = [String : AnyObject]()
    var poolDict = [String : AnyObject]()
    var strReport_id = String()
    
    var coreDataValue = NSManagedObject()
    
    
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
    
    //For Array of Images
    var arrEquipmentAreaImg: [UIImage] = []
    var arrBackWashImg: [UIImage] = []
    var arrWaterFeatureImg: [UIImage] = []
    var arrSolarSystemImg: [UIImage] = []
    var arrCatchBasinImg: [UIImage] = []
    var arrSlotDrainImg: [UIImage] = []
    
    
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
            self.static2.append(obj)
        }
    }
    
    //MARK:- SuctionLineAirCellProtocol {
    func didTapOnCellSuctionLineAir(_btnSuctionLineAirTag: Int) {
        if _btnSuctionLineAirTag == 0 {
            suctionLineAirOption = "Pool M/D"
        } else if _btnSuctionLineAirTag == 1 {
            suctionLineAirOption = "Spa suctions"
        } else if _btnSuctionLineAirTag == 2 {
            suctionLineAirOption = "Pool Skimmer"
        } else if _btnSuctionLineAirTag == 3 {
            suctionLineAirOption = "Side suctions"
        } else if _btnSuctionLineAirTag == 4 {
            suctionLineAirOption = "Water Feature Suction"
        } else {
            suctionLineAirOption = "Other (if any air noted, describe)"
        }
    }
    
    //MARK:- MarkLocationCellProtocol
    func didTapOnCellMarkLocation(_isMarkLocation: Bool) {
        if _isMarkLocation == true {
            isLocationMarked = "Yes"
        } else {
            isLocationMarked = "No"
        }
    }
    
    //MARK:- EstimateCellProtocol
    func didTapOnCellEstimate(_isEstimate: Bool) {
        if _isEstimate == true {
            isEstimateToFollow = "Yes"
        } else {
            isEstimateToFollow = "No"
        }
    }
    
    //MARK:- ObjectiveC Function
    @objc func btnSubmitDidTap() {
        self.view.endEditing(true)
        self.updateCoreData(strReport_id: strReport_id)
        //self.checkNetwork()
        let isFrom: Bool = UserDefaults.standard.bool(forKey: "isFromReportList")
        if isFrom == true {
            self.postPoolPlumbingStaticTest2Update()
        } else {
            self.postPoolPlumbingStaticTest2()
        }
        //self.checkNetwork()
    }
    
    func checkNetwork() {
        switch Network.reachability.status {
        case .unreachable:
            print("Internet not available")
            //updateCoreData()
            if UIDevice.current.userInterfaceIdiom == .phone {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Home_iPhone", bundle:nil)
                let InspectionListVC = storyBoard.instantiateViewController(withIdentifier: "InspectionList") as! InspectionListVC
                self.navigationController?.pushViewController(InspectionListVC, animated: true)
            } else if UIDevice.current.userInterfaceIdiom == .pad {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Home_iPad", bundle:nil)
                let InspectionListVC = storyBoard.instantiateViewController(withIdentifier: "InspectionList") as! InspectionListVC
                self.navigationController?.pushViewController(InspectionListVC, animated: true)
            }
        case .wwan:
            self.postPoolPlumbingStaticTest2()
            //self.postPoolDetectionDetails()
        case .wifi:
        self.postPoolPlumbingStaticTest2()
            //self.postPoolDetectionDetails()
        }
        print("Reachability Summary")
        print("Status:", Network.reachability.status)
        print("HostName:", Network.reachability.hostname ?? "nil")
        print("Reachable:", Network.reachability.isReachable)
        print("Wifi:", Network.reachability.isReachableViaWiFi)
    }
    
    func actionSheetPopUp(URlString: String) {
        let alert:UIAlertController = UIAlertController(title: "", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        let showAction = UIAlertAction(title: "Show Report", style: UIAlertAction.Style.default) {
            UIAlertAction in
            if UIDevice.current.userInterfaceIdiom == .phone {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Home_iPhone", bundle:nil)
                let nextVC = storyBoard.instantiateViewController(withIdentifier: "ShowPDF") as! ShowPDFVC
                nextVC.reportUrl = URlString
                self.navigationController?.pushViewController(nextVC, animated: true)
            } else if UIDevice.current.userInterfaceIdiom == .pad {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Home_iPad", bundle:nil)
                let nextVC = storyBoard.instantiateViewController(withIdentifier: "ShowPDF") as! ShowPDFVC
                nextVC.reportUrl = URlString
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default) {
            UIAlertAction in
            if UIDevice.current.userInterfaceIdiom == .phone {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Home_iPhone", bundle:nil)
                let InspectionListVC = storyBoard.instantiateViewController(withIdentifier: "InspectionList") as! InspectionListVC
                self.navigationController?.pushViewController(InspectionListVC, animated: true)
            } else if UIDevice.current.userInterfaceIdiom == .pad {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Home_iPad", bundle:nil)
                let InspectionListVC = storyBoard.instantiateViewController(withIdentifier: "InspectionList") as! InspectionListVC
                self.navigationController?.pushViewController(InspectionListVC, animated: true)
            }
        }
        alert.addAction(showAction)
        alert.addAction(cancelAction)
        
        //------------------------
        // Present the controller
        //-------------------------
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.present(alert, animated: true, completion: nil)
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            if let popoverController = alert.popoverPresentationController {
                popoverController.sourceView = self.view
                popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                popoverController.permittedArrowDirections = UIPopoverArrowDirection.up
            }
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK:- CoreData
    func updateCoreData(strReport_id: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Pool6_CoreData")
        
        //let userName: String = UserDefaults.standard.value(forKey: "PoolDetectionUserName") as! String
        let predicate = NSPredicate(format: "%K == %@", "report_id", strReport_id)
        fetchRequest.predicate = predicate
        
        do {
            let reportResult = try managedContext.fetch(fetchRequest) as! [Pool6_CoreData]
            print("Report Data\(reportResult) and count is \(reportResult.count)")
            
            if reportResult.count == 0 {
                print ("Inserting DB")
                
                //For data fetch in coredata
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Pool6_CoreData")
                fetchRequest.returnsObjectsAsFaults = false
                
                let predicate = NSPredicate(format: "%K == %@", "report_id", strReport_id)
                fetchRequest.predicate = predicate
                
                let  rs = try managedContext.fetch(fetchRequest)
                for _ in rs as [NSManagedObject] {
                    // update
                    do {
                        let managedObject = rs[0]
                        
                        managedObject.setValue(poolDict["report_id"], forKey: "report_id")
                        managedObject.setValue(poolDict["suctionAir"], forKey: "suctionAir")
                        managedObject.setValue(poolDict["suctionLineAirOption"], forKey: "suctionLineAirOption")
                        managedObject.setValue(poolDict["surgeTank"], forKey: "surgeTank")
                        managedObject.setValue(poolDict["markLocationDescribe"], forKey: "markLocationDescribe")
                        managedObject.setValue(poolDict["leaksNoted"], forKey: "leaksNoted")
                        managedObject.setValue(poolDict["summaryNote"], forKey: "summaryNote")
                        managedObject.setValue(poolDict["isLocationMarked"], forKey: "isLocationMarked")
                        managedObject.setValue(poolDict["isEstimateToFollow"], forKey: "isEstimateToFollow")
                        
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
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Pool6_CoreData")
                fetchRequest.returnsObjectsAsFaults = false
                
                let predicate = NSPredicate(format: "%K == %@", "report_id", strReport_id)
                fetchRequest.predicate = predicate
                
                let  rs = try managedContext.fetch(fetchRequest)
                for _ in rs as [NSManagedObject] {
                    // update
                    do {
                        let managedObject = rs[0]
                        
                        managedObject.setValue(strReport_id, forKey: "report_id")
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
                let strPoolData: String = String(describing: self.poolDetailsDict["page_6"]!)
                if strPoolData != "<null>" {
                    self.poolDict = self.poolDetailsDict["page_6"] as! [String : AnyObject]
                }
                print(self.poolDict)
                self.updateCoreData(strReport_id: self.strReport_id)
                self.tblStatic2.reloadData()
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
    func postPoolDetectionDetails() {
        self.view.endEditing(true)
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        let token: String = UserDefaults.standard.value(forKey: "key_token") as! String
        
        let headers = [
            "Authorization": token,
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        let url = ServiceConstant.BASE_URL.appending(ServiceConstant.PostPoolDetection)
        print("PoolDetectionDetails URL:: \(url)")
        
        let poolDetails: NSMutableDictionary = [
            "device_id"                  : (UIDevice.current.identifierForVendor?.uuidString)!,
            "namePoolDetection"          : coreDataValue.value(forKey: "namePoolDetection")!,
            "addressPool"                : coreDataValue.value(forKey: "addressPool")!,
            "cityPool"                   : coreDataValue.value(forKey: "cityPool")!,
            "statePool"                  : coreDataValue.value(forKey: "statePool")!,
            "zipPool"                    : coreDataValue.value(forKey: "zipPool")!,
            "phoneNoPool"                : coreDataValue.value(forKey: "phoneNoPool")!,
            "emailPool"                  : coreDataValue.value(forKey: "emailPool")!,
            "paymentPersonInspect"       : "",
            "notesPool"                  : coreDataValue.value(forKey: "notesPool")!,
            "otherNotesPool"             : coreDataValue.value(forKey: "otherNotesPool")!,
            "priceForLeakPool"           : coreDataValue.value(forKey: "priceForLeakPool")!,
            "inpectTimePool"             : coreDataValue.value(forKey: "pool_inspection_date_time")!,
            "inspection_date_time"       : coreDataValue.value(forKey: "pool_inspection_date_time")!,
            
            "isCommercialPool"           : coreDataValue.value(forKey: "isCommercialPool")!,
            "isFountain"                 : coreDataValue.value(forKey: "isFountain")!,
            "findUsOption"               : coreDataValue.value(forKey: "findUsOption")!,
            "reasonForCallOption"        : coreDataValue.value(forKey: "reasonForCallOption")!,
            "poolSizeOption"             : coreDataValue.value(forKey: "poolSizeOption")!,
            "approxDimentionDescription" : coreDataValue.value(forKey: "approxDimentionDescription")!,
            "approxDimentionText"        : coreDataValue.value(forKey: "approxDimentionText")!,
            "otherFindUsText"            : coreDataValue.value(forKey: "otherFindUsText")!,
            "spaSizeOption"              : coreDataValue.value(forKey: "spaSizeOption")!,
            
            "poolSurfaceOption"          : coreDataValue.value(forKey: "poolSurfaceOption")!,
            "pumpRunningOption"          : coreDataValue.value(forKey: "pumpRunningOption")!,
            "pumpRunningInfo"            : coreDataValue.value(forKey: "pumpRunningInfo")!,
            "isWaterVisible"             : coreDataValue.value(forKey: "isWaterVisible")!,
            "isRecentWorkAroundPool"     : coreDataValue.value(forKey: "isRecentWorkAroundPool")!,
            "isPoolCleaning"             : coreDataValue.value(forKey: "isPoolCleaning")!,
            "isFloorSystem"              : coreDataValue.value(forKey: "isFloorSystem")!,
            "isPoolWaterFeature"         : coreDataValue.value(forKey: "isPoolWaterFeature")!,
            "isSolarSystem"              : coreDataValue.value(forKey: "isSolarSystem")!,
            "poolWaterFeatureOption"     : coreDataValue.value(forKey: "poolWaterFeatureOption")!,
            
            "equipAreaOption"            : coreDataValue.value(forKey: "equipAreaOption")!,
            "descriptionEquipArea"       : coreDataValue.value(forKey: "equipAreaData")!,
            "backWashOption"             : coreDataValue.value(forKey: "backWashOption")!,
            "waterFeatureOption"         : coreDataValue.value(forKey: "waterFeatureOption")!,
            "solarSystemOption"          : coreDataValue.value(forKey: "solarSystemOption")!,
            "catchBasinOption"           : coreDataValue.value(forKey: "catchBasinOption")!,
            "slotDrainOption"            : coreDataValue.value(forKey: "slotDrainOption")!,
            
            "suction"                    : coreDataValue.value(forKey: "suction")!,
            "cleanerLines"               : coreDataValue.value(forKey: "cleanerLines")!,
            "skimmerSuction"             : coreDataValue.value(forKey: "skimmerSuction")!,
            "spaJets"                    : coreDataValue.value(forKey: "spaJets")!,
            "spaFill"                    : coreDataValue.value(forKey: "spaFill")!,
            "autofillEQ"                 : coreDataValue.value(forKey: "autofillEQ")!,
            "isVinylLinearLeak"          : coreDataValue.value(forKey: "isVinylLinearLeak")!,
            "isLeaking"                  : coreDataValue.value(forKey: "isLeaking")!,
            
            "suctionAir"                 : coreDataValue.value(forKey: "suctionAir")!,
            "suctionLineAirOption"       : coreDataValue.value(forKey: "suctionLineAirOption")!,
            "surgeTank"                  : coreDataValue.value(forKey: "surgeTank")!,
            "markLocationDescribe"       : coreDataValue.value(forKey: "markLocationDescribe")!,
            "leaksNoted"                 : coreDataValue.value(forKey: "leaksNoted")!,
            "summaryNote"                : coreDataValue.value(forKey: "summaryNote")!,
            "isLocationMarked"           : coreDataValue.value(forKey: "isLocationMarked")!,
            "isEstimateToFollow"         : coreDataValue.value(forKey: "isEstimateToFollow")!
        ]
        
        print(poolDetails)
        Alamofire.upload(multipartFormData: { multipartFormData in
            for image in self.arrEquipmentAreaImg {
                let imageData = image.jpegData(compressionQuality: 1.0)
                multipartFormData.append(imageData!, withName: "equipArea_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
            }
            for image in self.arrBackWashImg {
                let imageData = image.jpegData(compressionQuality: 1.0)
                multipartFormData.append(imageData!, withName: "backWash_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
            }
            for image in self.arrWaterFeatureImg {
                let imageData = image.jpegData(compressionQuality: 1.0)
                multipartFormData.append(imageData!, withName: "waterFeature_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
            }
            for image in self.arrSolarSystemImg {
                let imageData = image.jpegData(compressionQuality: 1.0)
                multipartFormData.append(imageData!, withName: "solar_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
            }
            for image in self.arrCatchBasinImg {
                let imageData = image.jpegData(compressionQuality: 1.0)
                multipartFormData.append(imageData!, withName: "basin_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
            }
            for image in self.arrSlotDrainImg {
                let imageData = image.jpegData(compressionQuality: 1.0)
                multipartFormData.append(imageData!, withName: "drain_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
            }
            
            for (key, value) in poolDetails {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key as! String)
            }
        }, to: url,
           method:.post,
           headers:headers ,
           encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    guard let json = response.result.value as? [String: Any] else {
                        print(response)
                        print(response.data as Any)
                        print("didn't get todo object as JSON from API")
                        //print("Error: \(response.result.error as! NSString)")
                        SVProgressHUD.dismiss()
                        return
                    }
                    
                    print("JSON: \(json)")
                    
                    if ((json["status"]  as! Int) == 1) {
                        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                            return
                        }

                        let managedContext = appDelegate.persistentContainer.viewContext
                        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PoolDetection_CoreData")
                        
//                        let userName: String = UserDefaults.standard.value(forKey: "PoolDetectionUserName") as! String
//                        let predicate = NSPredicate(format: "%K == %@", "namePoolDetection", userName)
//
//                        fetchRequest.predicate = predicate
                        
                        do {
                            let  rs = try managedContext.fetch(fetchRequest)
                            print(rs)
                            let countNo: Int = (rs as [NSManagedObject]).count
                            let countNumber: Int = countNo-1
                            if (rs as [NSManagedObject]).count > 0 {
                                managedContext.delete(rs[countNumber])

                                try managedContext.save()
                            }
                        } catch let error as NSError {
                            print("Could not fetch. \(error), \(error.userInfo)")
                        }
                        let alertController = UIAlertController(title: "", message: (json["message"] as! String), preferredStyle: UIAlertController.Style.alert) //Replace
                        
                        // Replace UIAlertActionStyle.Default by UIAlertActionStyle.default
                        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                            (result : UIAlertAction) -> Void in
                            
                            if UIDevice.current.userInterfaceIdiom == .phone {
                                let storyBoard : UIStoryboard = UIStoryboard(name: "Home_iPhone", bundle:nil)
                                let InspectionListVC = storyBoard.instantiateViewController(withIdentifier: "InspectionList") as! InspectionListVC
                                self.navigationController?.pushViewController(InspectionListVC, animated: true)
                            } else if UIDevice.current.userInterfaceIdiom == .pad {
                                let storyBoard : UIStoryboard = UIStoryboard(name: "Home_iPad", bundle:nil)
                                let InspectionListVC = storyBoard.instantiateViewController(withIdentifier: "InspectionList") as! InspectionListVC
                                self.navigationController?.pushViewController(InspectionListVC, animated: true)
                            }
                        }
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                    } else {
                        let alertController = UIAlertController(title: "", message: (json["message"] as! String), preferredStyle: UIAlertController.Style.alert) //Replace
                        
                        // Replace UIAlertActionStyle.Default by UIAlertActionStyle.default
                        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                            (result : UIAlertAction) -> Void in
                        }
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                    SVProgressHUD.dismiss()
                }
            case .failure(let encodingError):
                print("error:\(encodingError)")
                SVProgressHUD.dismiss()
            }
        })
    }
    
    func postPoolPlumbingStaticTest2() {
        self.view.endEditing(true)
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        
        let plumbingStaticDetails:  NSMutableDictionary = [
            "return_data_id"        : strReport_id,
            "suctionAir"            : self.static2[Static2.suctionAir.rawValue].formTextValue,
            "suctionLineAirOption"  : suctionLineAirOption,
            "surgeTank"             : self.static2[Static2.surgeTank.rawValue].formTextValue,
            "markLocationDescribe"  : self.static2[Static2.markLocDes.rawValue].formTextValue,
            "leaksNoted"            : self.static2[Static2.leaksNote.rawValue].formTextValue,
            "summaryNote"           : self.static2[Static2.summaryNote.rawValue].formTextValue,
            "isLocationMarked"      : self.isLocationMarked,
            "isEstimateToFollow"    : self.isEstimateToFollow
        ]
        
        print("plumbingStaticDetails :: \(plumbingStaticDetails)")
        ApiManager.sharedInstanceAPI.PostPoolPlumbingStaticTest2(postId: 1, plumbingStatic2Details: plumbingStaticDetails, onSuccess: { json in
            DispatchQueue.main.async {
                print("PoolPlumbingStaticTest2 json :: \(String(describing: json))")
                
                let dic: NSDictionary = json["data"] as! NSDictionary
                let url = (String(describing: dic["report"]!))
                print(url)
                if ((json["status"]  as! Int) == 1) {
                    let alertController = UIAlertController(title: "", message: (json["message"] as! String), preferredStyle: UIAlertController.Style.alert)
                    //Replace
                    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                        (result : UIAlertAction) -> Void in
                        self.actionSheetPopUp(URlString: url)
                    }
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
//                DispatchQueue.main.async(execute: {() -> Void in
//                    if UIDevice.current.userInterfaceIdiom == .phone {
//                        let storyBoard : UIStoryboard = UIStoryboard(name: "Home_iPhone", bundle:nil)
//                        let InspectionListVC = storyBoard.instantiateViewController(withIdentifier: "InspectionList") as! InspectionListVC
//                        self.navigationController?.pushViewController(InspectionListVC, animated: true)
//                    } else if UIDevice.current.userInterfaceIdiom == .pad {
//                        let storyBoard : UIStoryboard = UIStoryboard(name: "Home_iPad", bundle:nil)
//                        let InspectionListVC = storyBoard.instantiateViewController(withIdentifier: "InspectionList") as! InspectionListVC
//                        self.navigationController?.pushViewController(InspectionListVC, animated: true)
//                    }
//                })
                SVProgressHUD.dismiss()
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
    
    func postPoolPlumbingStaticTest2Update() {
        self.view.endEditing(true)
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        
        let plumbingStaticDetails:  NSMutableDictionary = [
            "return_data_id"        : strReport_id,
            "report_id"                 : strReport_id,
            "suctionAir"            : self.static2[Static2.suctionAir.rawValue].formTextValue,
            "suctionLineAirOption"  : suctionLineAirOption,
            "surgeTank"             : self.static2[Static2.surgeTank.rawValue].formTextValue,
            "markLocationDescribe"  : self.static2[Static2.markLocDes.rawValue].formTextValue,
            "leaksNoted"            : self.static2[Static2.leaksNote.rawValue].formTextValue,
            "summaryNote"           : self.static2[Static2.summaryNote.rawValue].formTextValue,
            "isLocationMarked"      : self.isLocationMarked,
            "isEstimateToFollow"    : self.isEstimateToFollow
        ]
        
        print("plumbingStaticDetails :: \(plumbingStaticDetails)")
        ApiManager.sharedInstanceAPI.PostPoolPlumbingStaticTest2Update(postId: 1, plumbingStatic2Details: plumbingStaticDetails, onSuccess: { json in
            DispatchQueue.main.async {
                print("PoolPlumbingStaticTest2 json :: \(String(describing: json))")
                let dic: NSDictionary = json["data"] as! NSDictionary
                let url = (String(describing: dic["report"]!))
                print(url)
                if ((json["status"]  as! Int) == 1) {
                    let alertController = UIAlertController(title: "", message: (json["message"] as! String), preferredStyle: UIAlertController.Style.alert)
                    //Replace
                    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                        (result : UIAlertAction) -> Void in
                        self.actionSheetPopUp(URlString: url)
                    }
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
//                DispatchQueue.main.async(execute: {() -> Void in
//                    if UIDevice.current.userInterfaceIdiom == .phone {
//                        let storyBoard : UIStoryboard = UIStoryboard(name: "Home_iPhone", bundle:nil)
//                        let InspectionListVC = storyBoard.instantiateViewController(withIdentifier: "InspectionList") as! InspectionListVC
//                        self.navigationController?.pushViewController(InspectionListVC, animated: true)
//                    } else if UIDevice.current.userInterfaceIdiom == .pad {
//                        let storyBoard : UIStoryboard = UIStoryboard(name: "Home_iPad", bundle:nil)
//                        let InspectionListVC = storyBoard.instantiateViewController(withIdentifier: "InspectionList") as! InspectionListVC
//                        self.navigationController?.pushViewController(InspectionListVC, animated: true)
//                    }
//                })
                SVProgressHUD.dismiss()
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


extension PlumbingStatistic2VC: UITableViewDataSource, UITableViewDelegate {
    //MARK:- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == Static2.suctionAir.rawValue {
            let cellLineAir = tableView.dequeueReusableCell(withIdentifier: "SuctionLineAirCell", for: indexPath) as! SuctionLineAirTableCell


            cellLineAir.delegateSuctionLineAir = self
            cellLineAir.txtOther.keyboardType = UIKeyboardType.asciiCapable
            if poolDict.count > 0 {
                if String(describing: poolDict["suctionLineAirOption"]!) == "Pool M/D" {
                    suctionLineAirOption = "Pool M/D"
                    cellLineAir.imgSuctionLineAirOptn0.image = UIImage(named: "checkmark")
                    cellLineAir.imgSuctionLineAirOptn1.image = UIImage(named: "unchecked")
                    cellLineAir.imgSuctionLineAirOptn2.image = UIImage(named: "unchecked")
                    cellLineAir.imgSuctionLineAirOptn3.image = UIImage(named: "unchecked")
                    cellLineAir.imgSuctionLineAirOptn4.image = UIImage(named: "unchecked")
                    cellLineAir.imgSuctionLineAirOptn5.image = UIImage(named: "unchecked")
                } else if String(describing: poolDict["suctionLineAirOption"]!) == "Spa suctions" {
                    suctionLineAirOption = "Spa suctions"
                    cellLineAir.imgSuctionLineAirOptn0.image = UIImage(named: "unchecked")
                    cellLineAir.imgSuctionLineAirOptn1.image = UIImage(named: "checkmark")
                    cellLineAir.imgSuctionLineAirOptn2.image = UIImage(named: "unchecked")
                    cellLineAir.imgSuctionLineAirOptn3.image = UIImage(named: "unchecked")
                    cellLineAir.imgSuctionLineAirOptn4.image = UIImage(named: "unchecked")
                    cellLineAir.imgSuctionLineAirOptn5.image = UIImage(named: "unchecked")
                } else if String(describing: poolDict["suctionLineAirOption"]!) == "Pool Skimmer" {
                    suctionLineAirOption = "Pool Skimmer"
                    cellLineAir.imgSuctionLineAirOptn0.image = UIImage(named: "unchecked")
                    cellLineAir.imgSuctionLineAirOptn1.image = UIImage(named: "unchecked")
                    cellLineAir.imgSuctionLineAirOptn2.image = UIImage(named: "checkmark")
                    cellLineAir.imgSuctionLineAirOptn3.image = UIImage(named: "unchecked")
                    cellLineAir.imgSuctionLineAirOptn4.image = UIImage(named: "unchecked")
                    cellLineAir.imgSuctionLineAirOptn5.image = UIImage(named: "unchecked")
                } else if String(describing: poolDict["suctionLineAirOption"]!) == "Side suctions" {
                    suctionLineAirOption = "Side suctions"
                    cellLineAir.imgSuctionLineAirOptn0.image = UIImage(named: "unchecked")
                    cellLineAir.imgSuctionLineAirOptn1.image = UIImage(named: "unchecked")
                    cellLineAir.imgSuctionLineAirOptn2.image = UIImage(named: "unchecked")
                    cellLineAir.imgSuctionLineAirOptn3.image = UIImage(named: "checkmark")
                    cellLineAir.imgSuctionLineAirOptn4.image = UIImage(named: "unchecked")
                    cellLineAir.imgSuctionLineAirOptn5.image = UIImage(named: "unchecked")
                } else if String(describing: poolDict["suctionLineAirOption"]!) == "Water Feature Suction" {
                    suctionLineAirOption = "Water Feature Suction"
                    cellLineAir.imgSuctionLineAirOptn0.image = UIImage(named: "unchecked")
                    cellLineAir.imgSuctionLineAirOptn1.image = UIImage(named: "unchecked")
                    cellLineAir.imgSuctionLineAirOptn2.image = UIImage(named: "unchecked")
                    cellLineAir.imgSuctionLineAirOptn3.image = UIImage(named: "unchecked")
                    cellLineAir.imgSuctionLineAirOptn4.image = UIImage(named: "checkmark")
                    cellLineAir.imgSuctionLineAirOptn5.image = UIImage(named: "unchecked")
                } else if String(describing: poolDict["suctionLineAirOption"]!) == "Other (if any air noted, describe)" {
                    suctionLineAirOption = "Other (if any air noted, describe)"
                    cellLineAir.imgSuctionLineAirOptn0.image = UIImage(named: "unchecked")
                    cellLineAir.imgSuctionLineAirOptn1.image = UIImage(named: "unchecked")
                    cellLineAir.imgSuctionLineAirOptn2.image = UIImage(named: "unchecked")
                    cellLineAir.imgSuctionLineAirOptn3.image = UIImage(named: "unchecked")
                    cellLineAir.imgSuctionLineAirOptn4.image = UIImage(named: "unchecked")
                    cellLineAir.imgSuctionLineAirOptn5.image = UIImage(named: "checkmark")
                }
                
                self.static2[Static2.suctionAir.rawValue].formTextValue = String(describing: poolDict["suctionAir"]!)
                cellLineAir.txtOther.text = String(describing: poolDict["suctionAir"]!)
            } else {
                cellLineAir.txtOther.text = self.static2[indexPath.row].formTextValue
            }
            cellLineAir.txtOther.delegate = self
            
            return cellLineAir
        } else if indexPath.row == Static2.surgeTank.rawValue {
            let cellTank = tableView.dequeueReusableCell(withIdentifier: "SurgeTankCell", for: indexPath) as! SurgeTankTableCell
            
            cellTank.txtPressure.keyboardType = UIKeyboardType.asciiCapable
            
            if poolDict.count > 0 {
                self.static2[Static2.surgeTank.rawValue].formTextValue = String(describing: poolDict["surgeTank"]!)
                cellTank.txtPressure.text = String(describing: poolDict["surgeTank"]!)
            } else {
                cellTank.txtPressure.text = self.static2[indexPath.row].formTextValue
            }
            
            cellTank.txtPressure.delegate = self
            
            return cellTank
        } else if indexPath.row == 2 {
           let cellMarkLoc = tableView.dequeueReusableCell(withIdentifier: "MarkLocationCell", for: indexPath) as! MarkLocationTableCell
            
            cellMarkLoc.lblMarkLoc.text = "Was location marked?"
            
            if poolDict.count > 0 {
                if String(describing: poolDict["isLocationMarked"]!) == "Yes" {
                    isLocationMarked = "Yes"
                    cellMarkLoc.btnYes.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
                    cellMarkLoc.btnYes.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
                    cellMarkLoc.btnNo.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    cellMarkLoc.btnNo.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
                } else if String(describing: poolDict["isLocationMarked"]!) == "No" {
                    isLocationMarked = "No"
                    cellMarkLoc.btnYes.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    cellMarkLoc.btnYes.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
                    cellMarkLoc.btnNo.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
                    cellMarkLoc.btnNo.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
                }
            }
            
            cellMarkLoc.delegateMarkLocation = self
            
            return cellMarkLoc
        } else if indexPath.row == Static2.markLocDes.rawValue {
            let cellDataTxtVw = tableView.dequeueReusableCell(withIdentifier: "DataTextViewCell", for: indexPath) as! DataTextViewTableCell
            
            cellDataTxtVw.lblData.text = "Where (Describe)"
            
            if poolDict.count > 0 {
                self.static2[Static2.markLocDes.rawValue].formTextValue = String(describing: poolDict["markLocationDescribe"]!)
                cellDataTxtVw.txtData.text = String(describing: poolDict["markLocationDescribe"]!)
            } else {
                cellDataTxtVw.txtData.text = self.static2[indexPath.row].formTextValue
            }
            
            cellDataTxtVw.txtData.delegate = self
            
            return cellDataTxtVw
        } else if indexPath.row == Static2.leaksNote.rawValue {
            let cellDataTxtVw = tableView.dequeueReusableCell(withIdentifier: "DataTextViewCell", for: indexPath) as! DataTextViewTableCell
            
            cellDataTxtVw.lblData.text = "Leaks Noted"
            
            if poolDict.count > 0 {
                self.static2[Static2.leaksNote.rawValue].formTextValue = String(describing: poolDict["leaksNoted"]!)
                cellDataTxtVw.txtData.text = String(describing: poolDict["leaksNoted"]!)
            } else {
                cellDataTxtVw.txtData.text = self.static2[indexPath.row].formTextValue
            }
            
            cellDataTxtVw.txtData.delegate = self
            
            return cellDataTxtVw
        } else if indexPath.row == Static2.summaryNote.rawValue {
            let cellDataTxtVw = tableView.dequeueReusableCell(withIdentifier: "DataTextViewCell", for: indexPath) as! DataTextViewTableCell
            
            cellDataTxtVw.lblData.text = "Summery Notes"
            
            if poolDict.count > 0 {
                self.static2[Static2.summaryNote.rawValue].formTextValue = String(describing: poolDict["summaryNote"]!)
                cellDataTxtVw.txtData.text = String(describing: poolDict["summaryNote"]!)
            } else {
                cellDataTxtVw.txtData.text = self.static2[indexPath.row].formTextValue
            }
            
            cellDataTxtVw.txtData.delegate = self
            
            return cellDataTxtVw
        } else if indexPath.row == 6 {
            let cellEstimate = tableView.dequeueReusableCell(withIdentifier: "EstimateCell", for: indexPath) as! EstimateTableCell
            
            if poolDict.count > 0 {
                if String(describing: poolDict["isEstimateToFollow"]!) == "Yes" {
                    isEstimateToFollow = "Yes"
                    cellEstimate.btnYes.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
                    cellEstimate.btnYes.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
                    cellEstimate.btnNo.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    cellEstimate.btnNo.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
                } else if String(describing: poolDict["isEstimateToFollow"]!) == "No" {
                    isEstimateToFollow = "No"
                    cellEstimate.btnYes.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    cellEstimate.btnYes.layer.borderColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
                    cellEstimate.btnNo.backgroundColor = #colorLiteral(red: 0.9333333333, green: 1, blue: 0.937254902, alpha: 1)
                    cellEstimate.btnNo.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.5058823529, blue: 0.1098039216, alpha: 1)
                }
            }
            
            cellEstimate.delegateEstimate = self
            return cellEstimate
        } else {
            let cellBtn = tableView.dequeueReusableCell(withIdentifier: "SubmitFormCell", for: indexPath) as! SubmitFormTableCell
            
            cellBtn.btnSubmit.addTarget(self, action: #selector(btnSubmitDidTap), for: UIControl.Event.touchUpInside)
            return cellBtn
        }
    }
    
    
    //MARK:- UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .phone {
            if indexPath.row == Static2.suctionAir.rawValue {
                return 440
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
                return 655
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


extension PlumbingStatistic2VC: UITextViewDelegate {
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
                } else if self.sectionIndex == 0 && self.selectedRowIndex == 4 {
                    self.static2[Static2.leaksNote.rawValue].formTextValue = (textView.text)!
                } else {
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
