//
//  CommercialLeakDetectionVC.swift
//  Leaktronics
//
//  Created by Abhishek Mullick on 13/04/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import CoreData
import DLRadioButton
import Alamofire
import SVProgressHUD
import Photos
import OpalImagePicker

   

class CommercialLeakDetectionVC: UIViewController, UINavigationControllerDelegate, UploadCollectionProtocol {

    //MARK:- Variable Declaration
    @IBOutlet weak var tblCommercial: UITableView!
    
    var plumberDetailsDict = [String : AnyObject]()
    var plumberDict = [String : AnyObject]()
    var strReport_id = String()
    
    
    var coreDataValue = NSManagedObject()
    
    
    var monitorFiveMinuteOption = String()
    var shutdownBuildingFromMeterOption = String()
    var shutdownHotWaterToBuildingOption = String()
    var meterShutdownOption = String()
    var otherStructureMeterOption = String()
    var visualWalkOutsideOption = String()
    var leakHeardStubOption = String()
    var walkedInsideParameterOption = String()
    var leakHeardatTouchStubOption = String()
    var mainBuildingEntranceOption = String()
    var pressureTestedForLeakOption = String()
    
    private var sectionIndex = -1
    private var selectedRowIndex = -1
    var isPlumberType = String()
    
    var secPlumberCom2 = [formData]()
    var secPlumberCom3 = [formData]()
    
    //For Array of Images
    var arrPropertyImgs: [UIImage] = []
    var arrVisualWalkedImgs: [UIImage] = []
    var arrLeakHeardImgs: [UIImage] = []
    var arrWalkedInsideImgs: [UIImage] = []
    var arrLeakHeardTouchImgs: [UIImage] = []
    var arrEnteringBuildingImgs: [UIImage] = []
    var arrPressureTestedImgs: [UIImage] = []
    var arrCompleteImgs: [UIImage] = []
    
    //For Images
    var arrVisualWalkedImg: [CollectionImageObject] = []
    var arrLeakHeardImg: [CollectionImageObject] = []
    var arrWalkedInsideImg: [CollectionImageObject] = []
    var arrLeakHeardTouchImg: [CollectionImageObject] = []
    var arrEnteringBuildingImg: [CollectionImageObject] = []
    var arrPressureTestedImg: [CollectionImageObject] = []
    var arrCompleteImg: [CollectionImageObject] = []
    
//
//    //For Image Path
//    var strVisualWalkedImg = String()
//    var strLeakHeardImg = String()
//    var strWalkedInsideImg = String()
//    var strLeakHeardTouchImg = String()
//    var strEnteringBuildingImg = String()
//    var strPressureTestedImg = String()
//    var strCompleteImg = String()
//
    
    //For Image CoreData
    var dataVisualWalkedImg = NSData()
    var dataLeakHeardImg = NSData()
    var dataWalkedInsideImg = NSData()
    var dataLeakHeardTouchImg = NSData()
    var dataEnteringBuildingImg = NSData()
    var dataPressureTestedImg = NSData()
    var dataCompleteImg = NSData()
    
    
    var imagePicker = UIImagePickerController()
    var picker:UIImagePickerController? = UIImagePickerController()
    
    
    var fetchIndexForUpload = Int()
    enum CommercialLeakOutside: Int {
        case visualWalkOutsideText = 0
        case leakHeaderStubsText = 1
        case walkedInsideParameterText = 2
        case leakHeardTouchStubText = 3
    }
    
    enum CommercialLeakInterior: Int {
        case mainBuildingEntranceText = 0
        case pressureTestedText = 1
        case interiorSummaryText = 2
        case completeLeakDetectionText = 3
    }
    
    //MARK:- UploadCollectionProtocol
    func didTapOnCellItem(_indexpath: IndexPath, _imgUrl: String, _videoUrl: String) {
        
    }
    
    func didUpdateCellIndex(_indexpath: Int) {
        
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
        self.navigationController?.title = "Plumber Leak Detection Report"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        if strReport_id == "" {

        } else {
            self.postReportDetailsEdit()
        }
    }
    
    func prepareFormData() {
        for _ in 0..<4 {
            let obj = formData()
            self.secPlumberCom2.append(obj)
        }

        for _ in 0..<4 {
            let obj = formData()
            self.secPlumberCom3.append(obj)
        }
    }
    
    
     //MARK:- Method to Open camera
     func openCamera() {
         if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
             //self.strDetermineCameraOrMedia = "camera"
             picker!.sourceType = UIImagePickerController.SourceType.camera
             picker!.delegate = self
             self .present(picker!, animated: true, completion: nil)
         } else {
             let alertController = UIAlertController(title: "Alert!", message: "Camera not available on this device", preferredStyle: UIAlertController.Style.alert)
             let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
                 print("OK")
             }
             
             alertController.addAction(okAction);
             self.present(alertController, animated: true, completion: nil)
         }
     }
     
     //MARK:- Method to Open Gallery
     func openGallary() {
         let imagePickerController = OpalImagePickerController()
         imagePickerController.imagePickerDelegate = self
         imagePickerController.maximumSelectionsAllowed = 5
         present(imagePickerController, animated: true, completion: nil)
     }
     
    //MARK:- Function
    func actionSheetPopUpForGalleryOpen() {
         let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
         
         let cameraAction = UIAlertAction(title: "Photo", style: UIAlertAction.Style.default) {
             UIAlertAction in
             self.openGallary()
         }
         let gallaryAction = UIAlertAction(title: "Camera", style: UIAlertAction.Style.default) {
             UIAlertAction in
             self.openCamera()
         }
         let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
             UIAlertAction in
         }
         //picker?.delegate = self
         alert.addAction(cameraAction)
         alert.addAction(gallaryAction)
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
                popoverController.permittedArrowDirections = []
            }
             self.present(alert, animated: true, completion: nil)
             // popover=UIPopoverController(contentViewController: alert)
         }
     }
     @objc func btnClickedUpload(_ sender: Any) {
         print("Button pressed 👍 ")
         let btn = sender as! UIButton
         fetchIndexForUpload = btn.tag
        print("Upload Index : \(String(describing: fetchIndexForUpload))")
         
         self.actionSheetPopUpForGalleryOpen()
     }
    //MARK:- Function
    @objc func btnSubmitDidTap() {
       self.updateCoreData(strReport_id: strReport_id)
       //self.checkNetwork()
       if strReport_id == "" {
           self.postCommercialLeakDetection()
       } else {
           self.postCommercialLeakDetectionUpdate()
       }
    }
    
    func checkNetwork() {
        switch Network.reachability.status {
        case .unreachable:
            print("Check InterNet")
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
            self.postCommercialLeakDetection()
        case .wifi:
            self.postCommercialLeakDetection()
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
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Plumber3_CoreData")
        
        //let userName: String = UserDefaults.standard.value(forKey: "PoolDetectionUserName") as! String
        let predicate = NSPredicate(format: "%K == %@", "report_id", strReport_id)
        fetchRequest.predicate = predicate
        
        do {
            let reportResult = try managedContext.fetch(fetchRequest) as! [Plumber3_CoreData]
            print("Report Data\(reportResult) and count is \(reportResult.count)")
            
            if reportResult.count == 0 {
                print ("Inserting DB")
                
                //For data fetch in coredata
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Plumber3_CoreData")
                fetchRequest.returnsObjectsAsFaults = false
                
                let predicate = NSPredicate(format: "%K == %@", "report_id", strReport_id)
                fetchRequest.predicate = predicate
                
                let  rs = try managedContext.fetch(fetchRequest)
                for _ in rs as [NSManagedObject] {
                    // update
                    do {
                        let managedObject = rs[0]
                        
                        managedObject.setValue(self.plumberDict["report_id"], forKey: "report_id")
                        managedObject.setValue(plumberDict["monitorFiveMinuteOption"], forKey: "monitorFiveMinuteOption")
                        managedObject.setValue(plumberDict["shutdownBuildingFromMeterOption"], forKey: "shutdownBuildingFromMeterOption")
                        managedObject.setValue(plumberDict["shutdownHotWaterToBuildingOption"], forKey: "shutdownHotWaterToBuildingOption")
                        managedObject.setValue(plumberDict["meterShutdownOption"], forKey: "meterShutdownOption")
                        managedObject.setValue(plumberDict["otherStructureMeterOption"], forKey: "otherStructureMeterOption")
                        managedObject.setValue(plumberDict["visualWalkOutsideOption"], forKey: "visualWalkOutsideOption")
                        managedObject.setValue(plumberDict["leakHeardStubOption"], forKey: "leakHeardStubOption")
                        managedObject.setValue(plumberDict["walkedInsideParameterOption"], forKey: "walkedInsideParameterOption")
                        managedObject.setValue(plumberDict["leakHeardatTouchStubOption"], forKey: "leakHeardatTouchStubOption")
                        managedObject.setValue(plumberDict["mainBuildingEntranceOption"], forKey: "mainBuildingEntranceOption")
                        managedObject.setValue(plumberDict["pressureTestedForLeakOption"], forKey: "pressureTestedForLeakOption")
                        managedObject.setValue(plumberDict["walkedInsideParameterText"], forKey: "walkedInsideParameterText")
                        managedObject.setValue(plumberDict["leakHeardTouchStubText"], forKey: "leakHeardTouchStubText")
                        managedObject.setValue(plumberDict["leakHeaderStubsText"], forKey: "leakHeaderStubsText")
                        managedObject.setValue(plumberDict["visualWalkOutsideText"], forKey: "visualWalkOutsideText")
                        managedObject.setValue(plumberDict["mainBuildingEntranceText"], forKey: "mainBuildingEntranceText")
                        managedObject.setValue(plumberDict["interiorSummaryText"], forKey: "interiorSummaryText")
                        managedObject.setValue(plumberDict["completeLeakDetectionText"], forKey: "completeLeakDetectionText")
                        managedObject.setValue(plumberDict["pressureTestedText"], forKey: "pressureTestedText")
                        managedObject.setValue(plumberDict["visualWalkedImg"], forKey: "visualWalkedImg")
                        managedObject.setValue(plumberDict["leakHeardImg"], forKey: "leakHeardImg")
                        managedObject.setValue(plumberDict["walkedInsideImg"], forKey: "walkedInsideImg")
                        managedObject.setValue(plumberDict["leakHeardTouchImg"], forKey: "leakHeardTouchImg")
                        managedObject.setValue(plumberDict["enteringBuildingImg"], forKey: "enteringBuildingImg")
                        managedObject.setValue(plumberDict["pressureTestedImg"], forKey: "pressureTestedImg")
                        managedObject.setValue(plumberDict["completeImg"], forKey: "completeImg")
                        managedObject.setValue(plumberDict["isPlumberType"], forKey: "isPlumberType")
                        
                        try managedContext.save()
                        print("update successfull")
                    } catch let error as NSError {
                        print("Could not Update. \(error), \(error.userInfo)")
                    }
                    //end update
                }
                do {
                    try managedContext.save()
                    UserDefaults.standard.set(self.plumberDict["namePoolDetection"], forKey: "PoolDetectionUserName")
                    print("Inserted")
                } catch let error as NSError {
                    print(error)
                }
            } else {
                print ("Updating DB")
                //For data fetch in coredata
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Plumber3_CoreData")
                fetchRequest.returnsObjectsAsFaults = false
                
                let predicate = NSPredicate(format: "%K == %@", "report_id", strReport_id)
                fetchRequest.predicate = predicate
                
                let  rs = try managedContext.fetch(fetchRequest)
                for _ in rs as [NSManagedObject] {
                    // update
                    do {
                        let managedObject = rs[0]
                        
                        managedObject.setValue(strReport_id, forKey: "report_id")
                        managedObject.setValue(monitorFiveMinuteOption, forKey: "monitorFiveMinuteOption")
                        managedObject.setValue(shutdownBuildingFromMeterOption, forKey: "shutdownBuildingFromMeterOption")
                        managedObject.setValue(shutdownHotWaterToBuildingOption, forKey: "shutdownHotWaterToBuildingOption")
                        managedObject.setValue(meterShutdownOption, forKey: "meterShutdownOption")
                        managedObject.setValue(otherStructureMeterOption, forKey: "otherStructureMeterOption")
                        managedObject.setValue(visualWalkOutsideOption, forKey: "visualWalkOutsideOption")
                        managedObject.setValue(leakHeardStubOption, forKey: "leakHeardStubOption")
                        managedObject.setValue(walkedInsideParameterOption, forKey: "walkedInsideParameterOption")
                        managedObject.setValue(leakHeardatTouchStubOption, forKey: "leakHeardatTouchStubOption")
                        managedObject.setValue(mainBuildingEntranceOption, forKey: "mainBuildingEntranceOption")
                        managedObject.setValue(pressureTestedForLeakOption, forKey: "pressureTestedForLeakOption")
                        managedObject.setValue(self.secPlumberCom2[CommercialLeakOutside.walkedInsideParameterText.rawValue].formTextValue, forKey: "walkedInsideParameterText")
                        managedObject.setValue(self.secPlumberCom2[CommercialLeakOutside.leakHeardTouchStubText.rawValue].formTextValue, forKey: "leakHeardTouchStubText")
                        managedObject.setValue(self.secPlumberCom2[CommercialLeakOutside.leakHeaderStubsText.rawValue].formTextValue, forKey: "leakHeaderStubsText")
                        managedObject.setValue(self.secPlumberCom2[CommercialLeakOutside.visualWalkOutsideText.rawValue].formTextValue, forKey: "visualWalkOutsideText")
                        managedObject.setValue(self.secPlumberCom3[CommercialLeakInterior.mainBuildingEntranceText.rawValue].formTextValue, forKey: "mainBuildingEntranceText")
                        managedObject.setValue(self.secPlumberCom3[CommercialLeakInterior.interiorSummaryText.rawValue].formTextValue, forKey: "interiorSummaryText")
                        managedObject.setValue(self.secPlumberCom3[CommercialLeakInterior.completeLeakDetectionText.rawValue].formTextValue, forKey: "completeLeakDetectionText")
                        managedObject.setValue(self.secPlumberCom3[CommercialLeakInterior.pressureTestedText.rawValue].formTextValue, forKey: "pressureTestedText")
                        managedObject.setValue(dataVisualWalkedImg, forKey: "visualWalkedImg")
                        managedObject.setValue(dataLeakHeardImg, forKey: "leakHeardImg")
                        managedObject.setValue(dataWalkedInsideImg, forKey: "walkedInsideImg")
                        managedObject.setValue(dataLeakHeardTouchImg, forKey: "leakHeardTouchImg")
                        managedObject.setValue(dataEnteringBuildingImg, forKey: "enteringBuildingImg")
                        managedObject.setValue(dataPressureTestedImg, forKey: "pressureTestedImg")
                        managedObject.setValue(dataCompleteImg, forKey: "completeImg")
                        managedObject.setValue(isPlumberType, forKey: "isPlumberType")
                        
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
    }/*{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PlumberLeak_CoreData")
        
        let userName: String = UserDefaults.standard.value(forKey: "PlumberLeakUserName") as! String
        let predicate = NSPredicate(format: "%K == %@", "namePlumberLeak", userName)
        fetchRequest.predicate = predicate
        
        do {
            let  rs = try managedContext.fetch(fetchRequest)
            for _ in rs as [NSManagedObject] {
                // update
                do {
                    let managedObject = rs[0]
                    
                    managedObject.setValue(monitorFiveMinuteOption, forKey: "monitorFiveMinuteOption")
                    managedObject.setValue(shutdownBuildingFromMeterOption, forKey: "shutdownBuildingFromMeterOption")
                    managedObject.setValue(shutdownHotWaterToBuildingOption, forKey: "shutdownHotWaterToBuildingOption")
                    managedObject.setValue(meterShutdownOption, forKey: "meterShutdownOption")
                    managedObject.setValue(otherStructureMeterOption, forKey: "otherStructureMeterOption")
                    managedObject.setValue(visualWalkOutsideOption, forKey: "visualWalkOutsideOption")
                    managedObject.setValue(leakHeardStubOption, forKey: "leakHeardStubOption")
                    managedObject.setValue(walkedInsideParameterOption, forKey: "walkedInsideParameterOption")
                    managedObject.setValue(leakHeardatTouchStubOption, forKey: "leakHeardatTouchStubOption")
                    managedObject.setValue(mainBuildingEntranceOption, forKey: "mainBuildingEntranceOption")
                    managedObject.setValue(pressureTestedForLeakOption, forKey: "pressureTestedForLeakOption")
                    managedObject.setValue(self.secPool2[CommercialLeakOutside.walkedInsideParameterText.rawValue].formTextValue, forKey: "walkedInsideParameterText")
                    managedObject.setValue(self.secPool2[CommercialLeakOutside.leakHeardTouchStubText.rawValue].formTextValue, forKey: "leakHeardTouchStubText")
                    managedObject.setValue(self.secPool2[CommercialLeakOutside.leakHeaderStubsText.rawValue].formTextValue, forKey: "leakHeaderStubsText")
                    managedObject.setValue(self.secPool2[CommercialLeakOutside.visualWalkOutsideText.rawValue].formTextValue, forKey: "visualWalkOutsideText")
                    managedObject.setValue(self.secPool3[CommercialLeakInterior.mainBuildingEntranceText.rawValue].formTextValue, forKey: "mainBuildingEntranceText")
                    managedObject.setValue(self.secPool3[CommercialLeakInterior.interiorSummaryText.rawValue].formTextValue, forKey: "interiorSummaryText")
                    managedObject.setValue(self.secPool3[CommercialLeakInterior.completeLeakDetectionText.rawValue].formTextValue, forKey: "completeLeakDetectionText")
                    managedObject.setValue(self.secPool3[CommercialLeakInterior.pressureTestedText.rawValue].formTextValue, forKey: "pressureTestedText")
                    managedObject.setValue(dataVisualWalkedImg, forKey: "visualWalkedImg")
                    managedObject.setValue(dataLeakHeardImg, forKey: "leakHeardImg")
                    managedObject.setValue(dataWalkedInsideImg, forKey: "walkedInsideImg")
                    managedObject.setValue(dataLeakHeardTouchImg, forKey: "leakHeardTouchImg")
                    managedObject.setValue(dataEnteringBuildingImg, forKey: "enteringBuildingImg")
                    managedObject.setValue(dataPressureTestedImg, forKey: "pressureTestedImg")
                    managedObject.setValue(dataCompleteImg, forKey: "completeImg")
                    managedObject.setValue(isPlumberType, forKey: "isPlumberType")
                    
                    try managedContext.save()
                    print("update successfull")
                } catch let error as NSError {
                    print("Could not Update. \(error), \(error.userInfo)")
                }
                //end update
            }
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PlumberLeak_CoreData")
            request.returnsObjectsAsFaults = false
            
            do {
                let result = try managedContext.fetch(request)
                for data in result as! [NSManagedObject] {
                    if (data.value(forKey: "namePlumberLeak") as! String) == userName {
                        print("Data of PoolDetectContact:: \(data)")
                        coreDataValue = data
                        
                        if self.coreDataValue.value(forKey: "propertyImg") == nil {
                            print("no image")
                        } else {
                            if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "propertyImg") as! Data) as? NSArray {
                                //extract data..
                                print(mySavedData)
                                arrPropertyImgs = mySavedData as! [UIImage]
                            }
                        }
                        if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "visualWalkedImg") as! Data) as? NSArray {
                            //extract data..
                            print(mySavedData)
                            arrVisualWalkedImgs = mySavedData as! [UIImage]
                        }
                        if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "leakHeardImg") as! Data) as? NSArray {
                            //extract data..
                            print(mySavedData)
                            arrLeakHeardImgs = mySavedData as! [UIImage]
                        }
                        if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "walkedInsideImg") as! Data) as? NSArray {
                            //extract data..
                            print(mySavedData)
                            arrWalkedInsideImgs = mySavedData as! [UIImage]
                        }
                        if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "leakHeardTouchImg") as! Data) as? NSArray {
                            //extract data..
                            print(mySavedData)
                            arrLeakHeardTouchImgs = mySavedData as! [UIImage]
                        }
                        if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "enteringBuildingImg") as! Data) as? NSArray {
                            //extract data..
                            print(mySavedData)
                            arrEnteringBuildingImgs = mySavedData as! [UIImage]
                        }
                        if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "pressureTestedImg") as! Data) as? NSArray {
                            //extract data..
                            print(mySavedData)
                            arrPressureTestedImgs = mySavedData as! [UIImage]
                        }
                        if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.coreDataValue.value(forKey: "completeImg") as! Data) as? NSArray {
                            //extract data..
                            print(mySavedData)
                            arrCompleteImgs = mySavedData as! [UIImage]
                        }
                    }
                }
            } catch {
                
                print("Failed")
            }
            //self.checkNetwork()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }*/
     
     //MARK:: Function Api Calling
     func postReportDetailsEdit() {
         SVProgressHUD.setDefaultMaskType(.clear)
         SVProgressHUD.show(withStatus: "Processing...")
         
         let editDetails: NSMutableDictionary = [
             "report_id" : strReport_id,
             "type"        : "Plumbing Leak Detection"
         ]
         
         print("editDetails :: \(editDetails)")
         //if sharedExtension.connectedToNetwork() {
         ApiManager.sharedInstanceAPI.PostReportDetailsEdit(postId: 1, reportDetailsEdit: editDetails, onSuccess: { json in
             DispatchQueue.main.async {
                 print("PoolDetectionDetailsEdit json :: \(String(describing: json))")
                 //let poolDetectDict = (json["data"] as AnyObject) as! [String : AnyObject]
                 
                 self.plumberDetailsDict = (json["data"] as AnyObject) as! [String : AnyObject]
                 let strPlumberData: String = String(describing: self.plumberDetailsDict["page_3"]!)
                 if strPlumberData != "<null>" {
                     self.plumberDict = self.plumberDetailsDict["page_3"] as! [String : AnyObject]
                 }
                 print("plumberDict_3::\(self.plumberDict)")
                 
                 self.updateCoreData(strReport_id: self.strReport_id)
                 self.tblCommercial.reloadData()
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
    
    func postCommercialLeakDetection() {
        self.view.endEditing(true)
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        let token: String = UserDefaults.standard.value(forKey: "key_token") as! String
        
        let headers = [
            "Authorization": token,
            //"Content-Type": "application/x-www-form-urlencoded"
        ]
        let url = ServiceConstant.BASE_URL.appending(ServiceConstant.PostCommercialLeakDetection)
        print("PlumberLeakDetectionDetails URL:: \(url)")
        
        let plumberDetails: NSMutableDictionary = [
            "return_data_id"                   : strReport_id,
            "monitorFiveMinuteOption"          : monitorFiveMinuteOption,
            "shutdownBuildingFromMeterOption"  : shutdownBuildingFromMeterOption,
            "shutdownHotWaterToBuildingOption" : shutdownHotWaterToBuildingOption,
            "meterShutdownOption"              : meterShutdownOption,
            "otherStructureMeterOption"        : otherStructureMeterOption,
            "visualWalkOutsideOption"          : visualWalkOutsideOption,
            "leakHeardStubOption"              : leakHeardStubOption,
            "walkedInsideParameterOption"      : walkedInsideParameterOption,
            "leakHeardatTouchStubOption"       : leakHeardatTouchStubOption,
            "mainBuildingEntranceOption"       : mainBuildingEntranceOption,
            "pressureTestedForLeakOption"      : pressureTestedForLeakOption,
            "walkedInsideParameterText"        : self.secPlumberCom2[CommercialLeakOutside.walkedInsideParameterText.rawValue].formTextValue,
            "leakHeardTouchStubText"           : self.secPlumberCom2[CommercialLeakOutside.leakHeardTouchStubText.rawValue].formTextValue,
            "leakHeaderStubsText"              : self.secPlumberCom2[CommercialLeakOutside.leakHeaderStubsText.rawValue].formTextValue,
            "visualWalkOutsideText"            : self.secPlumberCom2[CommercialLeakOutside.visualWalkOutsideText.rawValue].formTextValue,
            "mainBuildingEntranceText"         : self.secPlumberCom3[CommercialLeakInterior.mainBuildingEntranceText.rawValue].formTextValue,
            "interiorSummaryText"              : self.secPlumberCom3[CommercialLeakInterior.interiorSummaryText.rawValue].formTextValue,
            "completeLeakDetectionText"        : self.secPlumberCom3[CommercialLeakInterior.completeLeakDetectionText.rawValue].formTextValue,
            "pressureTestedText"               : self.secPlumberCom3[CommercialLeakInterior.pressureTestedText.rawValue].formTextValue
        ]
        
        print(plumberDetails)
        Alamofire.upload(multipartFormData: { multipartFormData in
            if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.dataVisualWalkedImg as! Data) as? NSArray {
                //extract data..
                print(mySavedData)
                let arrImgs = mySavedData as! [UIImage]
                for image in arrImgs {
                    let imageData = image.jpegData(compressionQuality: 1.0)
                    multipartFormData.append(imageData!, withName: "visualWalkedImg[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                }
            }
            if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.dataLeakHeardImg as! Data) as? NSArray {
                //extract data..
                print(mySavedData)
                let arrImgs = mySavedData as! [UIImage]
                for image in arrImgs {
                    let imageData = image.jpegData(compressionQuality: 1.0)
                    multipartFormData.append(imageData!, withName: "leakHeardImg[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                }
            }
            if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.dataWalkedInsideImg as! Data) as? NSArray {
                //extract data..
                print(mySavedData)
                let arrImgs = mySavedData as! [UIImage]
                for image in arrImgs {
                    let imageData = image.jpegData(compressionQuality: 1.0)
                    multipartFormData.append(imageData!, withName: "walkedInsideImg[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                }
            }
            if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.dataLeakHeardTouchImg as! Data) as? NSArray {
                //extract data..
                print(mySavedData)
                let arrImgs = mySavedData as! [UIImage]
                for image in arrImgs {
                    let imageData = image.jpegData(compressionQuality: 1.0)
                    multipartFormData.append(imageData!, withName: "leakHeardTouchImg[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                }
            }
            if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.dataEnteringBuildingImg as! Data) as? NSArray {
                //extract data..
                print(mySavedData)
                let arrImgs = mySavedData as! [UIImage]
                for image in arrImgs {
                    let imageData = image.jpegData(compressionQuality: 1.0)
                    multipartFormData.append(imageData!, withName: "enteringBuildingImg[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                }
            }
            if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.dataPressureTestedImg as! Data) as? NSArray {
                //extract data..
                print(mySavedData)
                let arrImgs = mySavedData as! [UIImage]
                for image in arrImgs {
                    let imageData = image.jpegData(compressionQuality: 1.0)
                    multipartFormData.append(imageData!, withName: "pressureTestedImg[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                }
            }
            if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.dataCompleteImg as! Data) as? NSArray {
                //extract data..
                print(mySavedData)
                let arrImgs = mySavedData as! [UIImage]
                for image in arrImgs {
                    let imageData = image.jpegData(compressionQuality: 1.0)
                    multipartFormData.append(imageData!, withName: "completeImg[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                }
            }
            for (key, value) in plumberDetails {
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
                    SVProgressHUD.dismiss()
                }
            case .failure(let encodingError):
                print("error:\(encodingError)")
                SVProgressHUD.dismiss()
            }
        })
    }
    
    func postCommercialLeakDetectionUpdate() {
        self.view.endEditing(true)
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        let token: String = UserDefaults.standard.value(forKey: "key_token") as! String
        
        let headers = [
            "Authorization": token,
            //"Content-Type": "application/x-www-form-urlencoded"
        ]
        
        let urlString = ServiceConstant.BASE_URL.appending(ServiceConstant.PostCommercialLeakDetectionUpdate)
        print("PlumberDetectionDetailsUpdate URL:: \(urlString)")
        
        let myUrl = URL(string: urlString)
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "POST"
        request.timeoutInterval = 120
        
        let poolDetails: NSMutableDictionary = [
            "return_data_id"                   : strReport_id,
            "report_id"                             : strReport_id,
            "monitorFiveMinuteOption"          : monitorFiveMinuteOption,
            "shutdownBuildingFromMeterOption"  : shutdownBuildingFromMeterOption,
            "shutdownHotWaterToBuildingOption" : shutdownHotWaterToBuildingOption,
            "meterShutdownOption"              : meterShutdownOption,
            "otherStructureMeterOption"        : otherStructureMeterOption,
            "visualWalkOutsideOption"          : visualWalkOutsideOption,
            "leakHeardStubOption"              : leakHeardStubOption,
            "walkedInsideParameterOption"      : walkedInsideParameterOption,
            "leakHeardatTouchStubOption"       : leakHeardatTouchStubOption,
            "mainBuildingEntranceOption"       : mainBuildingEntranceOption,
            "pressureTestedForLeakOption"      : pressureTestedForLeakOption,
            "walkedInsideParameterText"        : self.secPlumberCom2[CommercialLeakOutside.walkedInsideParameterText.rawValue].formTextValue,
            "leakHeardTouchStubText"           : self.secPlumberCom2[CommercialLeakOutside.leakHeardTouchStubText.rawValue].formTextValue,
            "leakHeaderStubsText"              : self.secPlumberCom2[CommercialLeakOutside.leakHeaderStubsText.rawValue].formTextValue,
            "visualWalkOutsideText"            : self.secPlumberCom2[CommercialLeakOutside.visualWalkOutsideText.rawValue].formTextValue,
            "mainBuildingEntranceText"         : self.secPlumberCom3[CommercialLeakInterior.mainBuildingEntranceText.rawValue].formTextValue,
            "interiorSummaryText"              : self.secPlumberCom3[CommercialLeakInterior.interiorSummaryText.rawValue].formTextValue,
            "completeLeakDetectionText"        : self.secPlumberCom3[CommercialLeakInterior.completeLeakDetectionText.rawValue].formTextValue,
            "pressureTestedText"               : self.secPlumberCom3[CommercialLeakInterior.pressureTestedText.rawValue].formTextValue
        ]
        
        print(poolDetails)
        Alamofire.upload(multipartFormData: { multipartFormData in
            if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.dataVisualWalkedImg as! Data) as? NSArray {
                //extract data..
                print(mySavedData)
                let arrImgs = mySavedData as! [UIImage]
                for image in arrImgs {
                    let imageData = image.jpegData(compressionQuality: 1.0)
                    multipartFormData.append(imageData!, withName: "visualWalkedImg[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                }
            }
            if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.dataLeakHeardImg as! Data) as? NSArray {
                //extract data..
                print(mySavedData)
                let arrImgs = mySavedData as! [UIImage]
                for image in arrImgs {
                    let imageData = image.jpegData(compressionQuality: 1.0)
                    multipartFormData.append(imageData!, withName: "leakHeardImg[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                }
            }
            if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.dataWalkedInsideImg as! Data) as? NSArray {
                //extract data..
                print(mySavedData)
                let arrImgs = mySavedData as! [UIImage]
                for image in arrImgs {
                    let imageData = image.jpegData(compressionQuality: 1.0)
                    multipartFormData.append(imageData!, withName: "walkedInsideImg[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                }
            }
            if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.dataLeakHeardTouchImg as! Data) as? NSArray {
                //extract data..
                print(mySavedData)
                let arrImgs = mySavedData as! [UIImage]
                for image in arrImgs {
                    let imageData = image.jpegData(compressionQuality: 1.0)
                    multipartFormData.append(imageData!, withName: "leakHeardTouchImg[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                }
            }
            if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.dataEnteringBuildingImg as! Data) as? NSArray {
                //extract data..
                print(mySavedData)
                let arrImgs = mySavedData as! [UIImage]
                for image in arrImgs {
                    let imageData = image.jpegData(compressionQuality: 1.0)
                    multipartFormData.append(imageData!, withName: "enteringBuildingImg[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                }
            }
            if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.dataPressureTestedImg as! Data) as? NSArray {
                //extract data..
                print(mySavedData)
                let arrImgs = mySavedData as! [UIImage]
                for image in arrImgs {
                    let imageData = image.jpegData(compressionQuality: 1.0)
                    multipartFormData.append(imageData!, withName: "pressureTestedImg[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                }
            }
            if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.dataCompleteImg as! Data) as? NSArray {
                //extract data..
                print(mySavedData)
                let arrImgs = mySavedData as! [UIImage]
                for image in arrImgs {
                    let imageData = image.jpegData(compressionQuality: 1.0)
                    multipartFormData.append(imageData!, withName: "completeImg[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                }
            }
            for (key, value) in poolDetails {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key as! String)
            }
        }, to: urlString,
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
                    SVProgressHUD.dismiss()
                }
            case .failure(let encodingError):
                print("error:\(encodingError)")
                SVProgressHUD.dismiss()
            }
        })
    }
    
     /*func setPostImage(arrOfImages: [UIImage]) {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        let token: String = UserDefaults.standard.value(forKey: "key_token") as! String
        
        let headers = [
            "Authorization": token,
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        let url = ServiceConstant.BASE_IMAGEURL.appending(ServiceConstant.PostPoolDetectImg)
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            print(arrOfImages)
            for image in arrOfImages {
                //let imageData = image.jpegData(compressionQuality: 1.0)
                if let imageData = image.jpeg(.high) {
                    print(imageData.count)
                    multipartFormData.append(imageData, withName: "files[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                }
            }
        }
            
//        Alamofire.upload(multipartFormData: { multipartFormData in
//            print(arrOfImages)
//            for image in arrOfImages {
//                let imageData = image.jpegData(compressionQuality: 1.0)
//                multipartFormData.append(imageData!, withName: "files[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
//            }
//        }
            , to: url,
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

                    let data = json["data"] as? String
                    print("JSON data: \(String(describing: data))")
                    if self.fetchIndexForUpload == 10 {
                        self.strVisualWalkedImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 20 {
                        self.strLeakHeardImg  = String(describing: data!)
                    } else if self.fetchIndexForUpload == 30 {
                        self.strWalkedInsideImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 40 {
                        self.strLeakHeardTouchImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 50 {
                        self.strEnteringBuildingImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 60 {
                        self.strPressureTestedImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 70 {
                        self.strCompleteImg = String(describing: data!)
                    }
                    SVProgressHUD.dismiss()
                 }
            case .failure(let encodingError):
                print("error:\(encodingError)")
                SVProgressHUD.dismiss()
            }
        })
    }
    
    func postPlumberLeakDetectionDetails() {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        let token: String = UserDefaults.standard.value(forKey: "key_token") as! String
        
        let headers = [
            "Authorization": token,
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        let url = ServiceConstant.BASE_URL.appending(ServiceConstant.PostPlumberLeakDetection)
        print("PlumberLeakDetectionDetails URL:: \(url)")
        
        let plumberDetails: NSMutableDictionary = [
            "device_id"                         : (UIDevice.current.identifierForVendor?.uuidString)!,
            "namePoolDetection"                 : coreDataValue.value(forKey: "namePlumberLeak")!,
            "addressPool"                       : coreDataValue.value(forKey: "addressPlumber")!,
            "cityPool"                          : coreDataValue.value(forKey: "cityPlumber")!,
            "statePool"                         : coreDataValue.value(forKey: "statePlumber")!,
            "zipPool"                           : coreDataValue.value(forKey: "zipPlumber")!,
            "phoneNoPool"                       : coreDataValue.value(forKey: "phoneNoPlumber")!,
            "emailPool"                         : coreDataValue.value(forKey: "emailPlumber")!,
            "paymentPersonInspect"              : "",
            "notesPool"                         : coreDataValue.value(forKey: "notesPlumber")!,
            "otherNotesPool"                    : coreDataValue.value(forKey: "otherNotesPlumber")!,
            "priceForLeakPool"                  : coreDataValue.value(forKey: "priceForLeakPlumber")!,
            "inpectTimePool"                    : coreDataValue.value(forKey: "plumber_inspection_date_time")!,
            "inspection_date_time"              : coreDataValue.value(forKey: "plumber_inspection_date_time")!,
            
            "propertyPlumber_Option"            : coreDataValue.value(forKey: "propertyTypePlumber")!,
            "storiesPlumber_Option"             : coreDataValue.value(forKey: "storiesTypePlumber")!,
            "findUsPlumber_Option"              : coreDataValue.value(forKey: "findUsOptionPlumber")!,
            "reasonForCallPlumber_Option"       : coreDataValue.value(forKey: "reasonForCallPlumber")!,
            "swimming_Option"                   : coreDataValue.value(forKey: "swimmingOption")!,
            "residential_Option"                : coreDataValue.value(forKey: "residentialOption")!,
            "fireSuppression_Option"            : coreDataValue.value(forKey: "fireSuppressionOption")!,
            "floorHeating_Option"               : coreDataValue.value(forKey: "floorHeating")!,
            "plumberProperty_Text"              : coreDataValue.value(forKey: "plumberPropertyText")!,
            "plumberStories_Text"               : coreDataValue.value(forKey: "plumberStoriesText")!,
            "plumberFindUs_Text"                : coreDataValue.value(forKey: "plumberFindUsText")!,
            "plumberCallReason_Text"            : coreDataValue.value(forKey: "plumberCallReasonText")!,
            "plumberSwimming_Text"              : coreDataValue.value(forKey: "plumberSwimmingText")!,
            "plumberResident_Text"              : coreDataValue.value(forKey: "plumberResidentText")!,
            "plumberfireSuppression_Text"       : coreDataValue.value(forKey: "plumberfireSuppressionText")!,
            "numberOfBuilding_Text"             : coreDataValue.value(forKey: "numberOfBuilding")!,
            "plumber_type"                      : coreDataValue.value(forKey: "isPlumberType")!,
            
            "monitorFiveMinute_Option"          : coreDataValue.value(forKey: "monitorFiveMinuteOption")!,
            "shutdownBuildingFromMeter_Option"  : coreDataValue.value(forKey: "shutdownBuildingFromMeterOption")!,
            "shutdownHotWaterToBuilding_Option" : coreDataValue.value(forKey: "shutdownHotWaterToBuildingOption")!,
            "meterShutdown_Option"              : coreDataValue.value(forKey: "meterShutdownOption")!,
            "otherStructureMeter_Option"        : coreDataValue.value(forKey: "otherStructureMeterOption")!,
            "visualWalkOutside_Option"          : coreDataValue.value(forKey: "visualWalkOutsideOption")!,
            "leakHeardStub_Option"              : coreDataValue.value(forKey: "leakHeardStubOption")!,
            "walkedInsideParameter_Option"      : coreDataValue.value(forKey: "walkedInsideParameterOption")!,
            "leakHeardatTouchStub_Option"       : coreDataValue.value(forKey: "leakHeardatTouchStubOption")!,
            "mainBuildingEntrance_Option"       : coreDataValue.value(forKey: "mainBuildingEntranceOption")!,
            "pressureTestedForLeak_Option"      : coreDataValue.value(forKey: "pressureTestedForLeakOption")!,
            "walkedInsideParameter_Text"        : coreDataValue.value(forKey: "walkedInsideParameterText")!,
            "leakHeardTouchStub_Text"           : coreDataValue.value(forKey: "leakHeardTouchStubText")!,
            "leakHeaderStubs_Text"              : coreDataValue.value(forKey: "leakHeaderStubsText")!,
            "visualWalkOutside_Text"            : coreDataValue.value(forKey: "visualWalkOutsideText")!,
            "mainBuildingEntrance_Text"         : coreDataValue.value(forKey: "mainBuildingEntranceText")!,
            "interiorSummary_Text"              : coreDataValue.value(forKey: "interiorSummaryText")!,
            "completeLeakDetection_Text"        : coreDataValue.value(forKey: "completeLeakDetectionText")!,
            "pressureTested_Text"               : coreDataValue.value(forKey: "pressureTestedText")!,
        ]
        
        print(plumberDetails)
        Alamofire.upload(multipartFormData: { multipartFormData in
            for image in self.arrPropertyImgs {
                let imageData = image.jpegData(compressionQuality: 1.0)
                multipartFormData.append(imageData!, withName: "property_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
            }
            for image in self.arrVisualWalkedImgs {
                let imageData = image.jpegData(compressionQuality: 1.0)
                multipartFormData.append(imageData!, withName: "visualWalked_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
            }
            for image in self.arrLeakHeardImgs {
                let imageData = image.jpegData(compressionQuality: 1.0)
                multipartFormData.append(imageData!, withName: "leakHeard_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
            }
            for image in self.arrWalkedInsideImgs {
                let imageData = image.jpegData(compressionQuality: 1.0)
                multipartFormData.append(imageData!, withName: "walkedInside_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
            }
            for image in self.arrLeakHeardTouchImgs {
                let imageData = image.jpegData(compressionQuality: 1.0)
                multipartFormData.append(imageData!, withName: "leakHeardTouch_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
            }
            for image in self.arrEnteringBuildingImgs {
                let imageData = image.jpegData(compressionQuality: 1.0)
                multipartFormData.append(imageData!, withName: "enteringBuilding_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
            }
            for image in self.arrPressureTestedImgs {
                let imageData = image.jpegData(compressionQuality: 1.0)
                multipartFormData.append(imageData!, withName: "pressureTested_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
            }
            for image in self.arrCompleteImgs {
                let imageData = image.jpegData(compressionQuality: 1.0)
                multipartFormData.append(imageData!, withName: "complete_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
            }
            for (key, value) in plumberDetails {
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
                        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PlumberLeak_CoreData")

                        //let userName: String = UserDefaults.standard.value(forKey: "PlumberLeakUserName") as! String
                        //let predicate = NSPredicate(format: "%K == %@", "namePlumberLeak", userName)
                        
                        //fetchRequest.predicate = predicate
                        
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

extension CommercialLeakDetectionVC: UITableViewDelegate,UITableViewDataSource {
    
 //MARK:- UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let commercialLeakCell = tableView.dequeueReusableCell(withIdentifier: "CommercialLeakTableCell", for: indexPath) as! CommercialLeakTableCell
            
            if plumberDict.count > 0 {
                //monitorFiveMinuteOption
                if String(describing: plumberDict["monitorFiveMinuteOption"]!) == "Was spinning continuously" {
                    self.monitorFiveMinuteOption = "Was spinning continuously"
                    commercialLeakCell.imgMonitorOptn0.image = UIImage(named: "checkmark")
                    commercialLeakCell.imgMonitorOptn1.image = UIImage(named: "unchecked")
                    commercialLeakCell.imgMonitorOptn2.image = UIImage(named: "unchecked")
                    commercialLeakCell.imgMonitorOptn3.image = UIImage(named: "unchecked")
                } else if String(describing: plumberDict["monitorFiveMinuteOption"]!) == "On, off, intermittent" {
                    self.monitorFiveMinuteOption = "On, off, intermittent"
                    commercialLeakCell.imgMonitorOptn0.image = UIImage(named: "unchecked")
                    commercialLeakCell.imgMonitorOptn1.image = UIImage(named: "checkmark")
                    commercialLeakCell.imgMonitorOptn2.image = UIImage(named: "unchecked")
                    commercialLeakCell.imgMonitorOptn3.image = UIImage(named: "unchecked")
                } else if String(describing: plumberDict["monitorFiveMinuteOption"]!) == "Was not spinning at all" {
                    self.monitorFiveMinuteOption = "Was not spinning at all"
                    commercialLeakCell.imgMonitorOptn0.image = UIImage(named: "unchecked")
                    commercialLeakCell.imgMonitorOptn1.image = UIImage(named: "unchecked")
                    commercialLeakCell.imgMonitorOptn2.image = UIImage(named: "checkmark")
                    commercialLeakCell.imgMonitorOptn3.image = UIImage(named: "unchecked")
                } else if String(describing: plumberDict["monitorFiveMinuteOption"]!) == "Unreadable meter" {
                    self.monitorFiveMinuteOption = "Unreadable meter"
                    commercialLeakCell.imgMonitorOptn0.image = UIImage(named: "unchecked")
                    commercialLeakCell.imgMonitorOptn1.image = UIImage(named: "unchecked")
                    commercialLeakCell.imgMonitorOptn2.image = UIImage(named: "unchecked")
                    commercialLeakCell.imgMonitorOptn3.image = UIImage(named: "checkmark")
                }
                
                //shutdownBuildingFromMeterOption
                if String(describing: plumberDict["shutdownBuildingFromMeterOption"]!) == "Meter stopped" {
                    self.shutdownBuildingFromMeterOption = "Meter stopped"
                    commercialLeakCell.imgMeterOptn0.image = UIImage(named: "checkmark")
                    commercialLeakCell.imgMeterOptn1.image = UIImage(named: "unchecked")
                    commercialLeakCell.imgMeterOptn2.image = UIImage(named: "unchecked")
                } else if String(describing: plumberDict["shutdownBuildingFromMeterOption"]!) == "Meter continued" {
                    self.shutdownBuildingFromMeterOption = "Meter continued"
                    commercialLeakCell.imgMeterOptn0.image = UIImage(named: "unchecked")
                    commercialLeakCell.imgMeterOptn1.image = UIImage(named: "checkmark")
                    commercialLeakCell.imgMeterOptn2.image = UIImage(named: "unchecked")
                } else if String(describing: plumberDict["shutdownBuildingFromMeterOption"]!) == "Unreadable meter" {
                    self.shutdownBuildingFromMeterOption = "Unreadable meter"
                    commercialLeakCell.imgMeterOptn0.image = UIImage(named: "unchecked")
                    commercialLeakCell.imgMeterOptn1.image = UIImage(named: "unchecked")
                    commercialLeakCell.imgMeterOptn2.image = UIImage(named: "checkmark")
                }
                
                //shutdownHotWaterToBuildingOption
                if String(describing: plumberDict["shutdownHotWaterToBuildingOption"]!) == "Meter stopped" {
                    self.shutdownHotWaterToBuildingOption = "Meter stopped"
                    commercialLeakCell.imgHotWaterOptn0.image = UIImage(named: "checkmark")
                    commercialLeakCell.imgHotWaterOptn1.image = UIImage(named: "unchecked")
                    commercialLeakCell.imgHotWaterOptn2.image = UIImage(named: "unchecked")
                } else if String(describing: plumberDict["shutdownHotWaterToBuildingOption"]!) == "Meter continued" {
                    self.shutdownHotWaterToBuildingOption = "Meter continued"
                    commercialLeakCell.imgHotWaterOptn0.image = UIImage(named: "unchecked")
                    commercialLeakCell.imgHotWaterOptn1.image = UIImage(named: "checkmark")
                    commercialLeakCell.imgHotWaterOptn2.image = UIImage(named: "unchecked")
                } else if String(describing: plumberDict["shutdownHotWaterToBuildingOption"]!) == "Unreadable meter" {
                    self.shutdownHotWaterToBuildingOption = "Unreadable meter"
                    commercialLeakCell.imgHotWaterOptn0.image = UIImage(named: "unchecked")
                    commercialLeakCell.imgHotWaterOptn1.image = UIImage(named: "unchecked")
                    commercialLeakCell.imgHotWaterOptn2.image = UIImage(named: "checkmark")
                }
                
                //meterShutdownOption
                if String(describing: plumberDict["meterShutdownOption"]!) == "Irrigation" {
                    self.meterShutdownOption = "Irrigation"
                    commercialLeakCell.imgShutdownOptn0.image = UIImage(named: "checkmark")
                    commercialLeakCell.imgShutdownOptn1.image = UIImage(named: "unchecked")
                    commercialLeakCell.imgShutdownOptn2.image = UIImage(named: "unchecked")
                } else if String(describing: plumberDict["meterShutdownOption"]!) == "Water feature pool or spa" {
                    self.meterShutdownOption = "Water feature pool or spa"
                    commercialLeakCell.imgShutdownOptn0.image = UIImage(named: "unchecked")
                    commercialLeakCell.imgShutdownOptn1.image = UIImage(named: "checkmark")
                    commercialLeakCell.imgShutdownOptn2.image = UIImage(named: "unchecked")
                } else if String(describing: plumberDict["meterShutdownOption"]!) == "Fire suppression system" {
                    self.meterShutdownOption = "Fire suppression system"
                    commercialLeakCell.imgShutdownOptn0.image = UIImage(named: "unchecked")
                    commercialLeakCell.imgShutdownOptn1.image = UIImage(named: "unchecked")
                    commercialLeakCell.imgShutdownOptn2.image = UIImage(named: "checkmark")
                }
                
                //otherStructureMeterOption
                if String(describing: plumberDict["otherStructureMeterOption"]!) == "Ran" {
                    self.otherStructureMeterOption = "Ran"
                    commercialLeakCell.imgStructureOptn0.image = UIImage(named: "checkmark")
                    commercialLeakCell.imgStructureOptn1.image = UIImage(named: "unchecked")
                } else if String(describing: plumberDict["otherStructureMeterOption"]!) == "Stopped" {
                    self.otherStructureMeterOption = "Stopped"
                    commercialLeakCell.imgStructureOptn0.image = UIImage(named: "unchecked")
                    commercialLeakCell.imgStructureOptn1.image = UIImage(named: "checkmark")
                }
            }
            
            commercialLeakCell.delegateMonitorFiveMinute = self
            commercialLeakCell.delegateShutdownBuildingFromMeter = self
            commercialLeakCell.delegateShutdownHotWaterToBuilding = self
            commercialLeakCell.delegateMeterShutdown = self
            commercialLeakCell.delegateOtherStructureMeterShutdown = self
            
            return commercialLeakCell
        } else if indexPath.section == 1 {
            let leakOutsideCell = tableView.dequeueReusableCell(withIdentifier: "CommercialLeakOutsideCell", for: indexPath) as! CommercialLeakOutsideCell
            if plumberDict.count > 0 {
                //visualWalkOutsideOption
                if String(describing: plumberDict["visualWalkOutsideOption"]!) == "Noticed visible water" {
                    self.visualWalkOutsideOption = "Noticed visible water"
                    leakOutsideCell.imgVisualWalkOptn0.image = UIImage(named: "checkmark")
                    leakOutsideCell.imgVisualWalkOptn1.image = UIImage(named: "unchecked")
                    leakOutsideCell.imgVisualWalkOptn2.image = UIImage(named: "unchecked")
                } else if String(describing: plumberDict["visualWalkOutsideOption"]!) == "No" {
                    self.visualWalkOutsideOption = "No"
                    leakOutsideCell.imgVisualWalkOptn0.image = UIImage(named: "unchecked")
                    leakOutsideCell.imgVisualWalkOptn1.image = UIImage(named: "checkmark")
                    leakOutsideCell.imgVisualWalkOptn2.image = UIImage(named: "unchecked")
                } else if String(describing: plumberDict["visualWalkOutsideOption"]!) == "Yes" {
                    self.visualWalkOutsideOption = "Yes"
                    leakOutsideCell.imgVisualWalkOptn0.image = UIImage(named: "unchecked")
                    leakOutsideCell.imgVisualWalkOptn1.image = UIImage(named: "unchecked")
                    leakOutsideCell.imgVisualWalkOptn2.image = UIImage(named: "checkmark")
                }

                self.secPlumberCom2[CommercialLeakOutside.walkedInsideParameterText.rawValue].formTextValue = String(describing: plumberDict["walkedInsideParameterText"]!)
                leakOutsideCell.vwVisualWalkOutsideText.text = String(describing: plumberDict["walkedInsideParameterText"]!)
                
                if (self.plumberDict["visualWalked_Image"]! as! [String]).count > 0 {
                    let imgArr = self.plumberDict["visualWalked_Image"]! as! [String]
                    leakOutsideCell.collect10Vw.arrImgs = imgArr
                    if imgArr.count > 0 {
                        leakOutsideCell.btnImgUpload10.isHidden = true
                        leakOutsideCell.collect10Vw.isHidden = false
                    } else {
                        leakOutsideCell.btnImgUpload10.isHidden = false
                        leakOutsideCell.collect10Vw.isHidden = true
                    }
                } else {
                    leakOutsideCell.collect10Vw.arrItems = arrVisualWalkedImg

                    if arrVisualWalkedImg.count > 0 {
                        leakOutsideCell.collect10Vw.isHidden = false
                        leakOutsideCell.btnImgUpload10.isHidden = true
                    } else {
                        leakOutsideCell.collect10Vw.isHidden = true
                        leakOutsideCell.btnImgUpload10.isHidden = false
                    }
                }
                
                leakOutsideCell.collect10Vw.isEdit = true
                leakOutsideCell.collect10Vw.delegateItemCollection = self
                leakOutsideCell.collect10Vw.reloadImageCollection()
                
                //leakHeardStubOption
                if String(describing: plumberDict["leakHeardStubOption"]!) == "No" {
                    self.leakHeardStubOption = "No"
                    leakOutsideCell.imgLeakHeardOptn0.image = UIImage(named: "checkmark")
                    leakOutsideCell.imgLeakHeardOptn1.image = UIImage(named: "unchecked")
                } else if String(describing: plumberDict["leakHeardStubOption"]!) == "Yes" {
                    self.leakHeardStubOption = "Yes"
                    leakOutsideCell.imgLeakHeardOptn0.image = UIImage(named: "unchecked")
                    leakOutsideCell.imgLeakHeardOptn1.image = UIImage(named: "checkmark")
                }
                
                self.secPlumberCom2[CommercialLeakOutside.leakHeaderStubsText.rawValue].formTextValue = String(describing: plumberDict["leakHeaderStubsText"]!)
                leakOutsideCell.vwLeakHeaderStubs.text = String(describing: plumberDict["leakHeaderStubsText"]!)
                
                if (self.plumberDict["leakHeard_Image"]! as! [String]).count > 0 {
                    let imgArr = self.plumberDict["leakHeard_Image"]! as! [String]
                    leakOutsideCell.collect20Vw.arrImgs = imgArr
                    if imgArr.count > 0 {
                        leakOutsideCell.btnImgUpload20.isHidden = true
                        leakOutsideCell.collect20Vw.isHidden = false
                    } else {
                        leakOutsideCell.btnImgUpload20.isHidden = false
                        leakOutsideCell.collect20Vw.isHidden = true
                    }
                } else {
                    leakOutsideCell.collect20Vw.arrItems = arrLeakHeardImg

                    if arrLeakHeardImg.count > 0 {
                        leakOutsideCell.collect20Vw.isHidden = false
                        leakOutsideCell.btnImgUpload20.isHidden = true
                    } else {
                        leakOutsideCell.collect20Vw.isHidden = true
                        leakOutsideCell.btnImgUpload20.isHidden = false
                    }
                }
                
                leakOutsideCell.collect20Vw.isEdit = true
                leakOutsideCell.collect20Vw.delegateItemCollection = self
                leakOutsideCell.collect20Vw.reloadImageCollection()
                
                //walkedInsideParameterOption
                if String(describing: plumberDict["walkedInsideParameterOption"]!) == "Noticed visible water" {
                    self.walkedInsideParameterOption = "Noticed visible water"
                    leakOutsideCell.imgWalkedInsideOptn0.image = UIImage(named: "checkmark")
                    leakOutsideCell.imgWalkedInsideOptn1.image = UIImage(named: "unchecked")
                    leakOutsideCell.imgWalkedInsideOptn2.image = UIImage(named: "unchecked")
                } else if String(describing: plumberDict["walkedInsideParameterOption"]!) == "No" {
                    self.walkedInsideParameterOption = "No"
                    leakOutsideCell.imgWalkedInsideOptn0.image = UIImage(named: "unchecked")
                    leakOutsideCell.imgWalkedInsideOptn1.image = UIImage(named: "checkmark")
                    leakOutsideCell.imgWalkedInsideOptn2.image = UIImage(named: "unchecked")
                } else if String(describing: plumberDict["walkedInsideParameterOption"]!) == "Yes" {
                    self.walkedInsideParameterOption = "Yes"
                    leakOutsideCell.imgWalkedInsideOptn0.image = UIImage(named: "unchecked")
                    leakOutsideCell.imgWalkedInsideOptn1.image = UIImage(named: "unchecked")
                    leakOutsideCell.imgWalkedInsideOptn2.image = UIImage(named: "checkmark")
                }
                
                self.secPlumberCom2[CommercialLeakOutside.walkedInsideParameterText.rawValue].formTextValue = String(describing: plumberDict["walkedInsideParameterText"]!)
                leakOutsideCell.vwWalkedInsideParameter.text = String(describing: plumberDict["walkedInsideParameterText"]!)
                
                if (self.plumberDict["walkedInside_Image"]! as! [String]).count > 0 {
                    let imgArr = self.plumberDict["walkedInside_Image"]! as! [String]
                    leakOutsideCell.collect30Vw.arrImgs = imgArr
                    if imgArr.count > 0 {
                        leakOutsideCell.btnImgUpload30.isHidden = true
                        leakOutsideCell.collect30Vw.isHidden = false
                    } else {
                        leakOutsideCell.btnImgUpload30.isHidden = false
                        leakOutsideCell.collect30Vw.isHidden = true
                    }
                } else {
                    leakOutsideCell.collect30Vw.arrItems = arrWalkedInsideImg

                    if arrWalkedInsideImg.count > 0 {
                        leakOutsideCell.collect30Vw.isHidden = false
                        leakOutsideCell.btnImgUpload30.isHidden = true
                    } else {
                        leakOutsideCell.collect30Vw.isHidden = true
                        leakOutsideCell.btnImgUpload30.isHidden = false
                    }
                }
                
                leakOutsideCell.collect30Vw.isEdit = true
                leakOutsideCell.collect30Vw.delegateItemCollection = self
                leakOutsideCell.collect30Vw.reloadImageCollection()
                
                //leakHeardatTouchStubOption
                if String(describing: plumberDict["leakHeardStubOption"]!) == "No" {
                    self.leakHeardatTouchStubOption = "No"
                    leakOutsideCell.imgTouchStubOptn0.image = UIImage(named: "checkmark")
                    leakOutsideCell.imgTouchStubOptn1.image = UIImage(named: "unchecked")
                } else if String(describing: plumberDict["leakHeardStubOption"]!) == "Yes" {
                    self.leakHeardatTouchStubOption = "Yes"
                    leakOutsideCell.imgTouchStubOptn0.image = UIImage(named: "unchecked")
                    leakOutsideCell.imgTouchStubOptn1.image = UIImage(named: "checkmark")
                }
                
                self.secPlumberCom2[CommercialLeakOutside.leakHeardTouchStubText.rawValue].formTextValue = String(describing: plumberDict["leakHeardTouchStubText"]!)
                leakOutsideCell.vwLeakHeardTouchStub.text = String(describing: plumberDict["leakHeardTouchStubText"]!)
                
                if (self.plumberDict["leakHeardTouch_Image"]! as! [String]).count > 0 {
                    let imgArr = self.plumberDict["leakHeardTouch_Image"]! as! [String]
                    leakOutsideCell.collect40Vw.arrImgs = imgArr
                    if imgArr.count > 0 {
                        leakOutsideCell.btnImgUpload40.isHidden = true
                        leakOutsideCell.collect40Vw.isHidden = false
                    } else {
                        leakOutsideCell.btnImgUpload40.isHidden = false
                        leakOutsideCell.collect40Vw.isHidden = true
                    }
                } else {
                    leakOutsideCell.collect40Vw.arrItems = arrLeakHeardTouchImg

                    if arrLeakHeardTouchImg.count > 0 {
                        leakOutsideCell.collect40Vw.isHidden = false
                        leakOutsideCell.btnImgUpload40.isHidden = true
                    } else {
                        leakOutsideCell.collect40Vw.isHidden = true
                        leakOutsideCell.btnImgUpload40.isHidden = false
                    }
                }
                
                leakOutsideCell.collect40Vw.isEdit = true
                leakOutsideCell.collect40Vw.delegateItemCollection = self
                leakOutsideCell.collect40Vw.reloadImageCollection()
                
            } else {
                //visualWalkOutsideOption
                leakOutsideCell.collect10Vw.isEdit = false
                leakOutsideCell.collect10Vw.arrItems = arrVisualWalkedImg

                if arrVisualWalkedImg.count > 0 {
                    leakOutsideCell.collect10Vw.isHidden = false
                    leakOutsideCell.btnImgUpload10.isHidden = true
                } else {
                    leakOutsideCell.collect10Vw.isHidden = true
                    leakOutsideCell.btnImgUpload10.isHidden = false
                }
                
                //leakHeardStubOption
                leakOutsideCell.collect20Vw.isEdit = false
                leakOutsideCell.collect20Vw.arrItems = arrLeakHeardImg
                
                if arrLeakHeardImg.count > 0 {
                    leakOutsideCell.collect20Vw.isHidden = false
                    leakOutsideCell.btnImgUpload20.isHidden = true
                } else {
                    leakOutsideCell.collect20Vw.isHidden = true
                    leakOutsideCell.btnImgUpload20.isHidden = false
                }
                
                //walkedInsideParameterOption
                leakOutsideCell.collect20Vw.isEdit = false
                leakOutsideCell.collect30Vw.arrItems = arrWalkedInsideImg

                if arrWalkedInsideImg.count > 0 {
                    leakOutsideCell.collect30Vw.isHidden = false
                    leakOutsideCell.btnImgUpload30.isHidden = true
                } else {
                    leakOutsideCell.collect30Vw.isHidden = true
                    leakOutsideCell.btnImgUpload30.isHidden = false
                }
                
                //leakHeardatTouchStubOption
                leakOutsideCell.collect40Vw.isEdit = false
                leakOutsideCell.collect40Vw.arrItems = arrLeakHeardTouchImg

                if arrLeakHeardTouchImg.count > 0 {
                    leakOutsideCell.collect40Vw.isHidden = false
                    leakOutsideCell.btnImgUpload40.isHidden = true
                } else {
                    leakOutsideCell.collect40Vw.isHidden = true
                    leakOutsideCell.btnImgUpload40.isHidden = false
                }
            }
            
            leakOutsideCell.delegateVisualWalkOutside = self
            leakOutsideCell.delegateLeakHeardStub = self
            leakOutsideCell.delegateWalkedInsideParameter = self
            leakOutsideCell.delegateLeakHeardatTouchStub = self
            
            leakOutsideCell.vwVisualWalkOutsideText.delegate = self
            leakOutsideCell.vwLeakHeaderStubs.delegate = self
            leakOutsideCell.vwLeakHeardTouchStub.delegate = self
            leakOutsideCell.vwWalkedInsideParameter.delegate = self
            
            leakOutsideCell.btnImgUpload10.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            leakOutsideCell.btnImgUpload20.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            leakOutsideCell.btnImgUpload30.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            leakOutsideCell.btnImgUpload40.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            
            
            //leakOutsideCell.collect10Vw.arrItems = arrVisualWalkedImg
            leakOutsideCell.collect10Vw.delegateItemCollection = self
            leakOutsideCell.collect10Vw.reloadImageCollection()
            
            /*if arrLeakHeardImg.count > 0 {
                leakOutsideCell.collect20Vw.isHidden = false
                leakOutsideCell.btnImgUpload20.isHidden = true
            } else {
                leakOutsideCell.collect20Vw.isHidden = true
                leakOutsideCell.btnImgUpload20.isHidden = false
            }
            
            leakOutsideCell.collect20Vw.arrItems = arrLeakHeardImg*/
            leakOutsideCell.collect20Vw.delegateItemCollection = self
            leakOutsideCell.collect20Vw.reloadImageCollection()
            
            /*if arrWalkedInsideImg.count > 0 {
                leakOutsideCell.collect30Vw.isHidden = false
                leakOutsideCell.btnImgUpload30.isHidden = true
            } else {
                leakOutsideCell.collect30Vw.isHidden = true
                leakOutsideCell.btnImgUpload30.isHidden = false
            }
            
            leakOutsideCell.collect30Vw.arrItems = arrWalkedInsideImg*/
            leakOutsideCell.collect30Vw.delegateItemCollection = self
            leakOutsideCell.collect30Vw.reloadImageCollection()
            
            /*if arrLeakHeardTouchImg.count > 0 {
                leakOutsideCell.collect40Vw.isHidden = false
                leakOutsideCell.btnImgUpload40.isHidden = true
            } else {
                leakOutsideCell.collect40Vw.isHidden = true
                leakOutsideCell.btnImgUpload40.isHidden = false
            }
            
            leakOutsideCell.collect40Vw.arrItems = arrLeakHeardTouchImg*/
            leakOutsideCell.collect40Vw.delegateItemCollection = self
            leakOutsideCell.collect40Vw.reloadImageCollection()
            
            return leakOutsideCell
        }  else if indexPath.section == 2 {
            let leakInteriorCell = tableView.dequeueReusableCell(withIdentifier: "CommercialLeakInteriorCell", for: indexPath) as! CommercialLeakInteriorCell

            if plumberDict.count > 0 {
                //mainBuildingEntranceOption
                if String(describing: plumberDict["mainBuildingEntranceOption"]!) == "Washer(s)" {
                    self.mainBuildingEntranceOption = "Washer(s)"
                    leakInteriorCell.imgEntranceOptn0.image = UIImage(named: "checkmark")
                    leakInteriorCell.imgEntranceOptn1.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn2.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn3.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn4.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn5.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn6.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn7.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn8.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn9.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn10.image = UIImage(named: "unchecked")
                } else if String(describing: plumberDict["mainBuildingEntranceOption"]!) == "Hot Water Heater(s)" {
                    self.mainBuildingEntranceOption = "Hot Water Heater(s)"
                    leakInteriorCell.imgEntranceOptn0.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn1.image = UIImage(named: "checkmark")
                    leakInteriorCell.imgEntranceOptn2.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn3.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn4.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn5.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn6.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn7.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn8.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn9.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn10.image = UIImage(named: "unchecked")
                } else if String(describing: plumberDict["mainBuildingEntranceOption"]!) == "Bathroom(s)" {
                    self.mainBuildingEntranceOption = "Bathroom(s)"
                    leakInteriorCell.imgEntranceOptn0.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn1.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn2.image = UIImage(named: "checkmark")
                    leakInteriorCell.imgEntranceOptn3.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn4.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn5.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn6.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn7.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn8.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn9.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn10.image = UIImage(named: "unchecked")
                } else if String(describing: plumberDict["mainBuildingEntranceOption"]!) == "Sink(s)" {
                    self.mainBuildingEntranceOption = "Sink(s)"
                    leakInteriorCell.imgEntranceOptn0.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn1.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn2.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn3.image = UIImage(named: "checkmark")
                    leakInteriorCell.imgEntranceOptn4.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn5.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn6.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn7.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn8.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn9.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn10.image = UIImage(named: "unchecked")
                } else if String(describing: plumberDict["mainBuildingEntranceOption"]!) == "Toilet(s)" {
                    self.mainBuildingEntranceOption = "Toilet(s)"
                    leakInteriorCell.imgEntranceOptn0.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn1.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn2.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn3.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn4.image = UIImage(named: "checkmark")
                    leakInteriorCell.imgEntranceOptn5.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn6.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn7.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn8.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn9.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn10.image = UIImage(named: "unchecked")
                } else if String(describing: plumberDict["mainBuildingEntranceOption"]!) == "Tub(s)" {
                    self.mainBuildingEntranceOption = "Tub(s)"
                    leakInteriorCell.imgEntranceOptn0.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn1.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn2.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn3.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn4.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn5.image = UIImage(named: "checkmark")
                    leakInteriorCell.imgEntranceOptn6.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn7.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn8.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn9.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn10.image = UIImage(named: "unchecked")
                } else if String(describing: plumberDict["mainBuildingEntranceOption"]!) == "Eye Wash Station(s)" {
                    self.mainBuildingEntranceOption = "Eye Wash Station(s)"
                    leakInteriorCell.imgEntranceOptn0.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn1.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn2.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn3.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn4.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn5.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn6.image = UIImage(named: "checkmark")
                    leakInteriorCell.imgEntranceOptn7.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn8.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn9.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn10.image = UIImage(named: "unchecked")
                } else if String(describing: plumberDict["mainBuildingEntranceOption"]!) == "Any and all manufacturing processes that are tied to Potable water" {
                    self.mainBuildingEntranceOption = "Any and all manufacturing processes that are tied to Potable water"
                    leakInteriorCell.imgEntranceOptn0.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn1.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn2.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn3.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn4.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn5.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn6.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn7.image = UIImage(named: "checkmark")
                    leakInteriorCell.imgEntranceOptn8.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn9.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn10.image = UIImage(named: "unchecked")
                } else if String(describing: plumberDict["mainBuildingEntranceOption"]!) == "In Floor Heating System" {
                    self.mainBuildingEntranceOption = "In Floor Heating System"
                    leakInteriorCell.imgEntranceOptn0.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn1.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn2.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn3.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn4.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn5.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn6.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn7.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn8.image = UIImage(named: "checkmark")
                    leakInteriorCell.imgEntranceOptn9.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn10.image = UIImage(named: "unchecked")
                } else if String(describing: plumberDict["mainBuildingEntranceOption"]!) == "Water Softener(s) or Filtration System(s)" {
                    self.mainBuildingEntranceOption = "Water Softener(s) or Filtration System(s)"
                    leakInteriorCell.imgEntranceOptn0.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn1.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn2.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn3.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn4.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn5.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn6.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn7.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn8.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn9.image = UIImage(named: "checkmark")
                    leakInteriorCell.imgEntranceOptn10.image = UIImage(named: "unchecked")
                } else if String(describing: plumberDict["mainBuildingEntranceOption"]!) == "Other" {
                    self.mainBuildingEntranceOption = "Other"
                    leakInteriorCell.imgEntranceOptn0.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn1.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn2.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn3.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn4.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn5.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn6.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn7.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn8.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn9.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgEntranceOptn10.image = UIImage(named: "checkmark")
                }
                
                self.secPlumberCom3[CommercialLeakInterior.mainBuildingEntranceText.rawValue].formTextValue = String(describing: plumberDict["mainBuildingEntranceText"]!)
                leakInteriorCell.vwMainBuildingEntranceText.text = String(describing: plumberDict["mainBuildingEntranceText"]!)
                
                
                if (self.plumberDict["enteringBuilding_Image"]! as! [String]).count > 0 {
                    let imgArr = self.plumberDict["enteringBuilding_Image"]! as! [String]
                    leakInteriorCell.collect50Vw.arrImgs = imgArr
                    if imgArr.count > 0 {
                        leakInteriorCell.btnImgUpload50.isHidden = true
                        leakInteriorCell.collect50Vw.isHidden = false
                    } else {
                        leakInteriorCell.btnImgUpload50.isHidden = false
                        leakInteriorCell.collect50Vw.isHidden = true
                    }
                } else {
                    leakInteriorCell.collect50Vw.arrItems = arrEnteringBuildingImg

                    if arrEnteringBuildingImg.count > 0 {
                        leakInteriorCell.collect50Vw.isHidden = false
                        leakInteriorCell.btnImgUpload50.isHidden = true
                    } else {
                        leakInteriorCell.collect50Vw.isHidden = true
                        leakInteriorCell.btnImgUpload50.isHidden = false
                    }
                }
                
                leakInteriorCell.collect50Vw.isEdit = true
                leakInteriorCell.collect50Vw.delegateItemCollection = self
                leakInteriorCell.collect50Vw.reloadImageCollection()
                
                //pressureTestedForLeakOption
                if String(describing: plumberDict["pressureTestedForLeakOption"]!) == "Washer(s)" {
                    self.pressureTestedForLeakOption = "Washer(s)"
                    leakInteriorCell.imgPressureOptn0.image = UIImage(named: "checkmark")
                    leakInteriorCell.imgPressureOptn1.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn2.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn3.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn4.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn5.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn6.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn7.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn8.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn9.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn10.image = UIImage(named: "unchecked")
                } else if String(describing: plumberDict["pressureTestedForLeakOption"]!) == "Hot Water Heater(s)" {
                    self.pressureTestedForLeakOption = "Hot Water Heater(s)"
                    leakInteriorCell.imgPressureOptn0.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn1.image = UIImage(named: "checkmark")
                    leakInteriorCell.imgPressureOptn2.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn3.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn4.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn5.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn6.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn7.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn8.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn9.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn10.image = UIImage(named: "unchecked")
                } else if String(describing: plumberDict["pressureTestedForLeakOption"]!) == "Bathroom(s)" {
                    self.pressureTestedForLeakOption = "Bathroom(s)"
                    leakInteriorCell.imgPressureOptn0.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn1.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn2.image = UIImage(named: "checkmark")
                    leakInteriorCell.imgPressureOptn3.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn4.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn5.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn6.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn7.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn8.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn9.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn10.image = UIImage(named: "unchecked")
                } else if String(describing: plumberDict["pressureTestedForLeakOption"]!) == "Sink(s)" {
                    self.pressureTestedForLeakOption = "Sink(s)"
                    leakInteriorCell.imgPressureOptn0.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn1.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn2.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn3.image = UIImage(named: "checkmark")
                    leakInteriorCell.imgPressureOptn4.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn5.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn6.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn7.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn8.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn9.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn10.image = UIImage(named: "unchecked")
                } else if String(describing: plumberDict["pressureTestedForLeakOption"]!) == "Toilet(s)" {
                    self.pressureTestedForLeakOption = "Toilet(s)"
                    leakInteriorCell.imgPressureOptn0.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn1.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn2.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn3.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn4.image = UIImage(named: "checkmark")
                    leakInteriorCell.imgPressureOptn5.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn6.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn7.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn8.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn9.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn10.image = UIImage(named: "unchecked")
                } else if String(describing: plumberDict["pressureTestedForLeakOption"]!) == "Tub(s)" {
                    self.pressureTestedForLeakOption = "Tub(s)"
                    leakInteriorCell.imgPressureOptn0.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn1.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn2.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn3.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn4.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn5.image = UIImage(named: "checkmark")
                    leakInteriorCell.imgPressureOptn6.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn7.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn8.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn9.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn10.image = UIImage(named: "unchecked")
                } else if String(describing: plumberDict["pressureTestedForLeakOption"]!) == "Eye Wash Station(s)" {
                    self.pressureTestedForLeakOption = "Eye Wash Station(s)"
                    leakInteriorCell.imgPressureOptn0.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn1.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn2.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn3.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn4.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn5.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn6.image = UIImage(named: "checkmark")
                    leakInteriorCell.imgPressureOptn7.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn8.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn9.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn10.image = UIImage(named: "unchecked")
                } else if String(describing: plumberDict["pressureTestedForLeakOption"]!) == "Any and all manufacturing processes that are tied to Potable water" {
                    self.pressureTestedForLeakOption = "Any and all manufacturing processes that are tied to Potable water"
                    leakInteriorCell.imgPressureOptn0.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn1.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn2.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn3.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn4.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn5.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn6.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn7.image = UIImage(named: "checkmark")
                    leakInteriorCell.imgPressureOptn8.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn9.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn10.image = UIImage(named: "unchecked")
                } else if String(describing: plumberDict["pressureTestedForLeakOption"]!) == "In Floor Heating System" {
                    self.pressureTestedForLeakOption = "In Floor Heating System"
                    leakInteriorCell.imgPressureOptn0.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn1.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn2.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn3.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn4.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn5.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn6.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn7.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn8.image = UIImage(named: "checkmark")
                    leakInteriorCell.imgPressureOptn9.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn10.image = UIImage(named: "unchecked")
                } else if String(describing: plumberDict["pressureTestedForLeakOption"]!) == "Water Softener(s) or Filtration System(s)" {
                    self.pressureTestedForLeakOption = "Water Softener(s) or Filtration System(s)"
                    leakInteriorCell.imgPressureOptn0.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn1.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn2.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn3.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn4.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn5.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn6.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn7.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn8.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn9.image = UIImage(named: "checkmark")
                    leakInteriorCell.imgPressureOptn10.image = UIImage(named: "unchecked")
                } else if String(describing: plumberDict["pressureTestedForLeakOption"]!) == "Other" {
                    self.pressureTestedForLeakOption = "Other"
                    leakInteriorCell.imgPressureOptn0.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn1.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn2.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn3.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn4.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn5.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn6.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn7.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn8.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn9.image = UIImage(named: "unchecked")
                    leakInteriorCell.imgPressureOptn10.image = UIImage(named: "checkmark")
                }
                
                self.secPlumberCom3[CommercialLeakInterior.pressureTestedText.rawValue].formTextValue = String(describing: plumberDict["pressureTestedText"]!)
                leakInteriorCell.vwPressureTestedText.text = String(describing: plumberDict["pressureTestedText"]!)
                
                if (self.plumberDict["pressureTested_Image"]! as! [String]).count > 0 {
                    let imgArr = self.plumberDict["pressureTested_Image"]! as! [String]
                    leakInteriorCell.collect60Vw.arrImgs = imgArr
                    if imgArr.count > 0 {
                        leakInteriorCell.btnImgUpload60.isHidden = true
                        leakInteriorCell.collect60Vw.isHidden = false
                    } else {
                        leakInteriorCell.btnImgUpload60.isHidden = false
                        leakInteriorCell.collect60Vw.isHidden = true
                    }
                } else {
                    leakInteriorCell.collect60Vw.arrItems = arrPressureTestedImg

                    if arrPressureTestedImg.count > 0 {
                        leakInteriorCell.collect60Vw.isHidden = false
                        leakInteriorCell.btnImgUpload60.isHidden = true
                    } else {
                        leakInteriorCell.collect60Vw.isHidden = true
                        leakInteriorCell.btnImgUpload60.isHidden = false
                    }
                }
                
                leakInteriorCell.collect60Vw.isEdit = true
                leakInteriorCell.collect60Vw.delegateItemCollection = self
                leakInteriorCell.collect60Vw.reloadImageCollection()
                
                //interiorSummaryText
                self.secPlumberCom3[CommercialLeakInterior.interiorSummaryText.rawValue].formTextValue = String(describing: plumberDict["interiorSummaryText"]!)
                leakInteriorCell.vwInteriorSummaryText.text = String(describing: plumberDict["interiorSummaryText"]!)
                
                //completeLeakDetectionText
                self.secPlumberCom3[CommercialLeakInterior.completeLeakDetectionText.rawValue].formTextValue = String(describing: plumberDict["completeLeakDetectionText"]!)
                leakInteriorCell.vwCompleteLeakDetectionText.text = String(describing: plumberDict["completeLeakDetectionText"]!)
                
                if (self.plumberDict["complete_Image"]! as! [String]).count > 0 {
                    let imgArr = self.plumberDict["complete_Image"]! as! [String]
                    leakInteriorCell.collect70Vw.arrImgs = imgArr
                    if imgArr.count > 0 {
                        leakInteriorCell.btnImgUpload70.isHidden = true
                        leakInteriorCell.collect70Vw.isHidden = false
                    } else {
                        leakInteriorCell.btnImgUpload70.isHidden = false
                        leakInteriorCell.collect70Vw.isHidden = true
                    }
                } else {
                    leakInteriorCell.collect70Vw.arrItems = arrCompleteImg

                    if arrCompleteImg.count > 0 {
                        leakInteriorCell.collect70Vw.isHidden = false
                        leakInteriorCell.btnImgUpload70.isHidden = true
                    } else {
                        leakInteriorCell.collect70Vw.isHidden = true
                        leakInteriorCell.btnImgUpload70.isHidden = false
                    }
                }
                
                leakInteriorCell.collect70Vw.isEdit = true
                leakInteriorCell.collect70Vw.delegateItemCollection = self
                leakInteriorCell.collect70Vw.reloadImageCollection()
            } else {
                //mainBuildingEntranceOption
                leakInteriorCell.collect50Vw.isEdit = false
                leakInteriorCell.collect50Vw.arrItems = arrEnteringBuildingImg

                if arrEnteringBuildingImg.count > 0 {
                    leakInteriorCell.collect50Vw.isHidden = false
                    leakInteriorCell.btnImgUpload50.isHidden = true
                } else {
                    leakInteriorCell.collect50Vw.isHidden = true
                    leakInteriorCell.btnImgUpload50.isHidden = false
                }
                
                //pressureTestedText
                leakInteriorCell.collect60Vw.isEdit = false
                leakInteriorCell.collect60Vw.arrItems = arrPressureTestedImg

                if arrPressureTestedImg.count > 0 {
                    leakInteriorCell.collect60Vw.isHidden = false
                    leakInteriorCell.btnImgUpload60.isHidden = true
                } else {
                    leakInteriorCell.collect60Vw.isHidden = true
                    leakInteriorCell.btnImgUpload60.isHidden = false
                }
                
                //pressureTestedText
                leakInteriorCell.collect70Vw.isEdit = false
                leakInteriorCell.collect70Vw.arrItems = arrCompleteImg

                if arrCompleteImg.count > 0 {
                    leakInteriorCell.collect70Vw.isHidden = false
                    leakInteriorCell.btnImgUpload70.isHidden = true
                } else {
                    leakInteriorCell.collect70Vw.isHidden = true
                    leakInteriorCell.btnImgUpload70.isHidden = false
                }
            }
            
            leakInteriorCell.delegateMainBuildingEntrance = self
            leakInteriorCell.delegatePressureTestedForLeak = self
            
            leakInteriorCell.vwPressureTestedText.delegate = self
            leakInteriorCell.vwInteriorSummaryText.delegate = self
            leakInteriorCell.vwMainBuildingEntranceText.delegate = self
            leakInteriorCell.vwCompleteLeakDetectionText.delegate = self
            
            leakInteriorCell.btnImgUpload50.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            leakInteriorCell.btnImgUpload60.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            leakInteriorCell.btnImgUpload70.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            
            /*if arrEnteringBuildingImg.count > 0 {
                leakInteriorCell.collect50Vw.isHidden = false
                leakInteriorCell.btnImgUpload50.isHidden = true
            } else {
                leakInteriorCell.collect50Vw.isHidden = true
                leakInteriorCell.btnImgUpload50.isHidden = false
            }
            
            leakInteriorCell.collect50Vw.arrItems = arrEnteringBuildingImg*/
            leakInteriorCell.collect50Vw.delegateItemCollection = self
            leakInteriorCell.collect50Vw.reloadImageCollection()
            
            /*if arrPressureTestedImg.count > 0 {
                leakInteriorCell.collect60Vw.isHidden = false
                leakInteriorCell.btnImgUpload60.isHidden = true
            } else {
                leakInteriorCell.collect60Vw.isHidden = true
                leakInteriorCell.btnImgUpload60.isHidden = false
            }
            
            leakInteriorCell.collect60Vw.arrItems = arrPressureTestedImg*/
            leakInteriorCell.collect60Vw.delegateItemCollection = self
            leakInteriorCell.collect60Vw.reloadImageCollection()
            
            /*if arrCompleteImg.count > 0 {
                leakInteriorCell.collect70Vw.isHidden = false
                leakInteriorCell.btnImgUpload70.isHidden = true
            } else {
                leakInteriorCell.collect70Vw.isHidden = true
                leakInteriorCell.btnImgUpload70.isHidden = false
            }
            
            leakInteriorCell.collect70Vw.arrItems = arrCompleteImg*/
            leakInteriorCell.collect70Vw.delegateItemCollection = self
            leakInteriorCell.collect70Vw.reloadImageCollection()
            
            return leakInteriorCell
        } else {
            let cellBtn = tableView.dequeueReusableCell(withIdentifier: "SubmitFormCell", for: indexPath) as! SubmitFormTableCell
            
            cellBtn.btnSubmit.addTarget(self, action: #selector(btnSubmitDidTap), for: UIControl.Event.touchUpInside)
            return cellBtn
        }
    }
        
    //MARK:- UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .phone {
            if indexPath.section == 0 {
                return 965
            } else if indexPath.section == 1 {
                return 1485
            } else if indexPath.section == 2 {
                return 1875
            } else {
                return 125
            }
        } else {
            if indexPath.section == 0 {
                return 1535
            } else if indexPath.section == 1 {
                return 2790
            } else if indexPath.section == 2 {
                return 3300
            } else {
                return 175
            }
        }
    }
}

extension CommercialLeakDetectionVC: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        var cell = UITableViewCell()
        if UIDevice.current.userInterfaceIdiom == .phone {
            cell = (textView.superview?.superview as? UITableViewCell)!
            
            if let CommercialLeakOutsideCell = cell as? CommercialLeakOutsideCell {
                if textView == CommercialLeakOutsideCell.vwVisualWalkOutsideText {
                       self.secPlumberCom2[CommercialLeakOutside.visualWalkOutsideText.rawValue].formTextValue = (textView.text)!
               } else if  textView == CommercialLeakOutsideCell.vwLeakHeardTouchStub {
                       self.secPlumberCom2[CommercialLeakOutside.leakHeardTouchStubText.rawValue].formTextValue = (textView.text)!
               } else if textView == CommercialLeakOutsideCell.vwLeakHeaderStubs {
                       self.secPlumberCom2[CommercialLeakOutside.leakHeaderStubsText.rawValue].formTextValue = (textView.text)!
               } else  if textView == CommercialLeakOutsideCell.vwVisualWalkOutsideText {
                       self.secPlumberCom2[CommercialLeakOutside.walkedInsideParameterText.rawValue].formTextValue = (textView.text)!
               }
            } else if  let CommercialLeakInteriorCell = cell as? CommercialLeakInteriorCell {
                 if textView == CommercialLeakInteriorCell.vwMainBuildingEntranceText {
                        self.secPlumberCom3[CommercialLeakInterior.mainBuildingEntranceText.rawValue].formTextValue = (textView.text)!
                 } else if  textView == CommercialLeakInteriorCell.vwInteriorSummaryText {
                        self.secPlumberCom3[CommercialLeakInterior.interiorSummaryText.rawValue].formTextValue = (textView.text)!
                 } else if textView == CommercialLeakInteriorCell.vwCompleteLeakDetectionText {
                        self.secPlumberCom3[CommercialLeakInterior.completeLeakDetectionText.rawValue].formTextValue = (textView.text)!
                 }  else if textView == CommercialLeakInteriorCell.vwPressureTestedText {
                        self.secPlumberCom3[CommercialLeakInterior.pressureTestedText.rawValue].formTextValue = (textView.text)!
                 }
            }
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            cell = (textView.superview?.superview as? UITableViewCell)!
            
            if let CommercialLeakOutsideCell = cell as? CommercialLeakOutsideCell {
                if textView == CommercialLeakOutsideCell.vwWalkedInsideParameter {
                       self.secPlumberCom2[CommercialLeakOutside.visualWalkOutsideText.rawValue].formTextValue = (textView.text)!
                } else if  textView == CommercialLeakOutsideCell.vwLeakHeardTouchStub {
                       self.secPlumberCom2[CommercialLeakOutside.leakHeardTouchStubText.rawValue].formTextValue = (textView.text)!
                } else if textView == CommercialLeakOutsideCell.vwLeakHeaderStubs {
                       self.secPlumberCom2[CommercialLeakOutside.leakHeaderStubsText.rawValue].formTextValue = (textView.text)!
                } else  if textView == CommercialLeakOutsideCell.vwVisualWalkOutsideText {
                       self.secPlumberCom2[CommercialLeakOutside.visualWalkOutsideText.rawValue].formTextValue = (textView.text)!
                }
            } else if  let CommercialLeakInteriorCell = cell as? CommercialLeakInteriorCell {
                 if textView == CommercialLeakInteriorCell.vwMainBuildingEntranceText {
                        self.secPlumberCom3[CommercialLeakInterior.mainBuildingEntranceText.rawValue].formTextValue = (textView.text)!
                 } else if  textView == CommercialLeakInteriorCell.vwInteriorSummaryText {
                        self.secPlumberCom3[CommercialLeakInterior.interiorSummaryText.rawValue].formTextValue = (textView.text)!
                 } else if textView == CommercialLeakInteriorCell.vwCompleteLeakDetectionText {
                        self.secPlumberCom3[CommercialLeakInterior.completeLeakDetectionText.rawValue].formTextValue = (textView.text)!
                 }  else if textView == CommercialLeakInteriorCell.vwPressureTestedText {
                        self.secPlumberCom3[CommercialLeakInterior.pressureTestedText.rawValue].formTextValue = (textView.text)!
                 }
            }
        }
    }
}


extension CommercialLeakDetectionVC: OpalImagePickerControllerDelegate {
    func imagePickerDidCancel(_ picker: OpalImagePickerController) {
        //Cancel action?
    }

    func imagePicker(_ picker: OpalImagePickerController, didFinishPickingAssets assets: [PHAsset]) {
        //Save Images, update UI
        print(assets)
        
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        
        var count = 0
        var images = [UIImage]()
        
        for asset in assets {
            manager.requestImageData(for: asset, options: options, resultHandler: { (imageData, dataUTI, orientation, info) in
                defer {
                    count += 1
                    if (count == assets.count) {
                        for i in 0..<assets.count {
                            if self.fetchIndexForUpload == 10 {
                                self.arrVisualWalkedImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.setPostImage(arrOfImages: images)
                                self.dataVisualWalkedImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForUpload == 20 {
                                self.arrLeakHeardImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.setPostImage(arrOfImages: images)
                                self.dataLeakHeardImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForUpload == 30 {
                                self.arrWalkedInsideImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.setPostImage(arrOfImages: images)
                                self.dataWalkedInsideImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForUpload == 40 {
                                self.arrLeakHeardTouchImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.setPostImage(arrOfImages: images)
                                self.dataLeakHeardTouchImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForUpload == 50 {
                                self.arrEnteringBuildingImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.setPostImage(arrOfImages: images)
                                self.dataEnteringBuildingImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForUpload == 60 {
                                self.arrPressureTestedImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.setPostImage(arrOfImages: images)
                                self.dataPressureTestedImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForUpload == 70 {
                                self.arrCompleteImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.setPostImage(arrOfImages: images)
                                self.dataCompleteImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            }
                        }
                    }
                }
                
                guard let data = imageData else { return; }
                guard let image = UIImage(data: data) else { return; }
                
                images.append(image)
            })
        }
        //Dismiss Controller
        //presentedViewController?.dismiss(animated: true, completion: nil)
        presentedViewController?.dismiss(animated: true) {
            DispatchQueue.main.async {
                self.tblCommercial.reloadData()
                 //self.perform(#selector(QuickTipViewController.getAllImages), with: nil, afterDelay: 0.5)
              
            }
        }
    }

    func imagePickerNumberOfExternalItems(_ picker: OpalImagePickerController) -> Int {
        return 1
    }

    func imagePickerTitleForExternalItems(_ picker: OpalImagePickerController) -> String {
        return NSLocalizedString("External", comment: "External (title for UISegmentedControl)")
    }

    func imagePicker(_ picker: OpalImagePickerController, imageURLforExternalItemAtIndex index: Int) -> URL? {
        return URL(string: "https://placeimg.com/500/500/nature")
    }
}


extension CommercialLeakDetectionVC: UIImagePickerControllerDelegate {
    // MARK:: UIImagePickerControllerDelegate
    //For xcode 10
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let possibleImage = info[.originalImage] as? UIImage
            else {
                fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
                //return
            }
        
        if fetchIndexForUpload == 10 {
            self.arrVisualWalkedImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataVisualWalkedImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if fetchIndexForUpload == 20 {
            self.arrLeakHeardImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataLeakHeardImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if fetchIndexForUpload == 30 {
            self.arrWalkedInsideImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataWalkedInsideImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if fetchIndexForUpload == 40 {
            self.arrLeakHeardTouchImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataLeakHeardTouchImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if fetchIndexForUpload == 50 {
            self.arrEnteringBuildingImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataEnteringBuildingImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if fetchIndexForUpload == 60 {
            self.arrPressureTestedImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataPressureTestedImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if fetchIndexForUpload == 70 {
            self.arrCompleteImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataCompleteImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        }
        self.tblCommercial.reloadData()
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
}

extension CommercialLeakDetectionVC: MonitorFiveMinuteProtocol, ShutdownBuildingFromMeterProtocol, ShutdownHotWaterToBuildingProtocol, MeterShutdownProtocol, OtherStructureMeterShutdownProtocol, VisualWalkOutsideProtocol, LeakHeardStubProtocol, WalkedInsideParameterProtocol, LeakHeardatTouchStubProtocol, MainBuildingEntranceProtocol, PressureTestedForLeakProtocol  {
    
    //MARK:- MonitorFiveMinuteProtocol
    func didTapOnMonitorFiveMinute(_btnfFiveMinuteTag: Int) {
        if _btnfFiveMinuteTag == 0 {
            monitorFiveMinuteOption = "Was spinning continuously"
        } else if _btnfFiveMinuteTag == 1 {
            monitorFiveMinuteOption = "On, off, intermittent"
        } else if _btnfFiveMinuteTag == 2 {
            monitorFiveMinuteOption = "Was not spinning at all"
        } else {
            monitorFiveMinuteOption = "Unreadable meter"
        }
    }

    //MARK:- ShutdownBuildingFromMeterProtocol
    func didTapOnShutdownBuildingFromMeter(_btnShutdownBuildingFromMeter: Int) {
        if _btnShutdownBuildingFromMeter == 0 {
            shutdownBuildingFromMeterOption = "Meter stopped"
        } else if _btnShutdownBuildingFromMeter == 1 {
            shutdownBuildingFromMeterOption = "Meter continued"
        } else {
            shutdownBuildingFromMeterOption = "Unreadable meter"
        }
    }

    //MARK:- ShutdownHotWaterToBuildingProtocol
    func didTapOnShutdownHotWaterToBuilding(_btnDidTapOnShutdownHotWaterToBuilding: Int) {
        if _btnDidTapOnShutdownHotWaterToBuilding == 0 {
            shutdownHotWaterToBuildingOption = "Meter stopped"
        } else if _btnDidTapOnShutdownHotWaterToBuilding == 1 {
            shutdownHotWaterToBuildingOption = "Meter continued"
        } else {
            shutdownHotWaterToBuildingOption = "Unreadable meter"
        }
    }

    //MARK:-  MeterShutdownProtocol
    func didTapOnMeterShutdown(_btnMeterShutdown: Int) {
        if _btnMeterShutdown == 0 {
            meterShutdownOption = "Irrigation"
        } else if _btnMeterShutdown == 1 {
            meterShutdownOption = "Water feature pool or spa"
        } else if _btnMeterShutdown == 2 {
            meterShutdownOption = "Fire suppression system"
        }
    }

    //MARK:-  OtherStructureMeterShutdownProtocol
    func didTapOnOtherStructureMeterShutdown(_btnOtherStructureMeterShutdown: Int) {
        if _btnOtherStructureMeterShutdown == 0 {
            otherStructureMeterOption = "Ran"
        } else {
            otherStructureMeterOption = "Stopped"
        }
    }
    
    //MARK:- VisualWalkOutsideProtocol
    func didTapOnVisualWalkOutside(_btnVisualWalkOutside: Int) {
        if _btnVisualWalkOutside == 0 {
            visualWalkOutsideOption = "Noticed visible water"
        } else if _btnVisualWalkOutside == 1 {
            visualWalkOutsideOption = "No"
        } else {
            visualWalkOutsideOption = "Yes"
        }
    }

    //MARK:-  LeakHeardStubProtocol
    func didTapOnLeakHeardStub(_btnLeakHeardStub: Int) {
        if _btnLeakHeardStub == 0 {
            leakHeardStubOption = "No"
        } else {
            leakHeardStubOption = "Yes"
        }
    }

    //MARK:-  WalkedInsideParameterProtocol
    func didTapOnwalkedInsideParameter(_btnwalkedInsideParameter: Int) {
        if _btnwalkedInsideParameter == 0 {
            walkedInsideParameterOption = "Noticed visible water"
        } else if _btnwalkedInsideParameter == 1 {
            walkedInsideParameterOption = "No"
        } else {
            walkedInsideParameterOption = "Yes"
        }
    }

    //MARK:-  LeakHeardatTouchStubProtocol
    func didTapOnLeakHeardatTouchStub(_btnLeakHeardatTouchStub: Int) {
        if _btnLeakHeardatTouchStub == 0 {
            leakHeardatTouchStubOption = "No"
        } else {
            leakHeardatTouchStubOption = "Yes"
        }
    }
    
    //MARK:-  MainBuildingEntranceProtocol
    func didTapOnMainBuildingEntrance(_btnMainBuildingEntrance: Int) {
        if _btnMainBuildingEntrance == 0 {
            mainBuildingEntranceOption = "Washer(s)"
        } else if _btnMainBuildingEntrance == 1 {
            mainBuildingEntranceOption = "Hot Water Heater(s)"
        } else if _btnMainBuildingEntrance == 2 {
            mainBuildingEntranceOption = "Bathroom(s)"
        } else if _btnMainBuildingEntrance == 3 {
            mainBuildingEntranceOption = "Sink(s)"
        } else if _btnMainBuildingEntrance == 4 {
            mainBuildingEntranceOption = "Toilet(s)"
        } else if _btnMainBuildingEntrance == 5 {
            mainBuildingEntranceOption = "Tub(s)"
        } else if _btnMainBuildingEntrance == 6 {
            mainBuildingEntranceOption = "Eye Wash Station(s)"
        } else if _btnMainBuildingEntrance == 7 {
            mainBuildingEntranceOption = "Any and all manufacturing processes that are tied to Potable water"
        } else if _btnMainBuildingEntrance == 8 {
            mainBuildingEntranceOption = "In Floor Heating System"
        } else if _btnMainBuildingEntrance == 9 {
            mainBuildingEntranceOption = "Water Softener(s) or Filtration System(s)"
        } else {
            mainBuildingEntranceOption = "Other"
        }
    }

    //MARK:-  PressureTestedForLeakProtocol
    func didTapOnPressureTestedForLeak(_btnPressureTestedForLeak: Int) {
        if _btnPressureTestedForLeak == 0 {
           pressureTestedForLeakOption = "Washer(s)"
        } else if _btnPressureTestedForLeak == 1 {
           pressureTestedForLeakOption = "Hot Water Heater(s)"
        } else if _btnPressureTestedForLeak == 2 {
           pressureTestedForLeakOption = "Bathroom(s)"
        } else if _btnPressureTestedForLeak == 3 {
           pressureTestedForLeakOption = "Sink(s)"
        } else if _btnPressureTestedForLeak == 4 {
           pressureTestedForLeakOption = "Toilet(s)"
        } else if _btnPressureTestedForLeak == 5 {
           pressureTestedForLeakOption = "Tub(s)"
        } else if _btnPressureTestedForLeak == 6 {
           pressureTestedForLeakOption = "Eye Wash Station(s)"
        } else if _btnPressureTestedForLeak == 7 {
           pressureTestedForLeakOption = "Any and all manufacturing processes that are tied to Potable water"
        } else if _btnPressureTestedForLeak == 8 {
           pressureTestedForLeakOption = "In Floor Heating System"
        } else if _btnPressureTestedForLeak == 9 {
           pressureTestedForLeakOption = "Water Softener(s) or Filtration System(s)"
        } else {
           pressureTestedForLeakOption = "Other"
        }
    }
}
