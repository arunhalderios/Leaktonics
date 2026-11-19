//
//  VisualLeakVC.swift
//  Leaktronics
//
//  Created by Abhishek Mullick on 08/04/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import CoreData
import DLRadioButton 
import SVProgressHUD
import Alamofire
import Photos
import OpalImagePicker


class VisualLeakVC: UIViewController, UINavigationControllerDelegate, UploadCollectionProtocol {
    
    @IBOutlet weak var tblVisualLeak: UITableView!
    var poolDetailsDict = [String : AnyObject]()
    var poolDict = [String : AnyObject]()
    var strReport_id = String()
    
    //MARK:- Variable Declaration
    
    //For Images
    var arrEquipmentAreaImg: [CollectionImageObject] = []
    var arrBackWashImg: [CollectionImageObject] = []
    var arrWaterFeatureImg: [CollectionImageObject] = []
    var arrSolarSystemImg: [CollectionImageObject] = []
    var arrCatchBasinImg: [CollectionImageObject] = []
    var arrSlotDrainImg: [CollectionImageObject] = []
    
    var imagePicker = UIImagePickerController()
    var picker:UIImagePickerController? = UIImagePickerController()
    
    var fetchIndexForUpload = Int()
    
    //For Image Server path
    var strEqueImg = String()
    var strBackWashImg = String()
    var strWaterFeatureImg = String()
    var strSolarImg = String()
    var strBasinImg = String()
    var strDrainImg = String()
    
    //For Image CoreData
    var dataEqueImg = NSData()
    var dataBackWashImg = NSData()
    var dataWaterFeatureImg = NSData()
    var dataSolarImg = NSData()
    var dataBasinImg = NSData()
    var dataDrainImg = NSData()
    
    //For Optional Value
    var equaiAreaOption = String()
    var backwashOption = String()
    var waterFeatureOption = String()
    var solarOption = String()
    var basinOption = String()
    var drainOption = String()
    
    
    var secVisualLeak = [formData]()
    
    enum VisualLeak: Int {
        case equipmentArea = 0
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
        for _ in 0..<1 {
            let obj = formData()
            self.secVisualLeak.append(obj)
        }
    }
    
    //MARK:- UploadCollectionProtocol
    func didTapOnCellItem(_indexpath: IndexPath, _imgUrl: String, _videoUrl: String) {
        
    }
    
    func didUpdateCellIndex(_indexpath: Int) {
        self.actionSheetPopUpForGalleryOpen()
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
        let alert:UIAlertController = UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
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
//            if let popoverController = alert.popoverPresentationController {
//                popoverController.sourceView = self.view
//              //popoverController.barButtonItem = sender as? UIBarButtonItem
//            }
            if let popoverController = alert.popoverPresentationController {
                popoverController.sourceView = self.view
                popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                popoverController.permittedArrowDirections = UIPopoverArrowDirection.up
            }
            self.present(alert, animated: true, completion: nil)
            
            // popover=UIPopoverController(contentViewController: alert)
        }
    }
    
    @objc func btnClickedUpload(_ sender: Any) {
        print("Button pressed 👍 ")
        let btn = sender as! UIButton
        let cell = btn.superview?.superview?.superview as! UITableViewCell
        let indexOfCell = self.tblVisualLeak.indexPath(for: cell)
        fetchIndexForUpload = (indexOfCell?.row)!
        print("Upload Index : \(String(describing: fetchIndexForUpload))")
        
        self.actionSheetPopUpForGalleryOpen()
    }
    
    //MARK:- ObjectiveC Function
    @objc func btnNextDidTap() {
        self.view.endEditing(true)
        self.updateCoreData(strReport_id: strReport_id)
        //self.checkNetwork()
        let isFrom: Bool = UserDefaults.standard.bool(forKey: "isFromReportList")
        if isFrom == true {
            self.postPoolVisualLeakInspectUpdate()
        } else {
            self.postPoolVisualLeakInspect()
        }
        /*if UIDevice.current.userInterfaceIdiom == .phone {
            let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection", bundle:nil)
            let formVC = storyBoard.instantiateViewController(withIdentifier: "PlumbingStatistic") as! PlumbingStatisticVC
            self.navigationController?.pushViewController(formVC, animated: true)
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection_iPad", bundle:nil)
            let formVC = storyBoard.instantiateViewController(withIdentifier: "PlumbingStatistic") as! PlumbingStatisticVC
            self.navigationController?.pushViewController(formVC, animated: true)
        }*/
    }
    
    //MARK:- CoreData
    func updateCoreData(strReport_id: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Pool4_CoreData")
        
        //let userName: String = UserDefaults.standard.value(forKey: "PoolDetectionUserName") as! String
        let predicate = NSPredicate(format: "%K == %@", "report_id", strReport_id)
        fetchRequest.predicate = predicate
        
        do {
            let reportResult = try managedContext.fetch(fetchRequest) as! [Pool4_CoreData]
            print("Report Data\(reportResult) and count is \(reportResult.count)")
            
            if reportResult.count == 0 {
                print ("Inserting DB")
                
                //For data fetch in coredata
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Pool4_CoreData")
                fetchRequest.returnsObjectsAsFaults = false
                
                let predicate = NSPredicate(format: "%K == %@", "report_id", strReport_id)
                fetchRequest.predicate = predicate
                
                let  rs = try managedContext.fetch(fetchRequest)
                for _ in rs as [NSManagedObject] {
                    // update
                    do {
                        let managedObject = rs[0]
                        
                        managedObject.setValue(poolDict["report_id"], forKey: "report_id")
                        managedObject.setValue(poolDict["equipAreaImage"], forKey: "equipAreaImage")
                        managedObject.setValue(poolDict["equipAreaOption"], forKey: "equipAreaOption")
                        managedObject.setValue(poolDict["equipAreaData"], forKey: "equipAreaData")
                        managedObject.setValue(poolDict["backwashImage"], forKey: "backwashImage")
                        managedObject.setValue(poolDict["backWashOption"], forKey: "backWashOption")
                        managedObject.setValue(poolDict["waterFeatureImage"], forKey: "waterFeatureImage")
                        managedObject.setValue(poolDict["waterFeatureOption"], forKey: "waterFeatureOption")
                        managedObject.setValue(poolDict["solarSystemImage"], forKey: "solarSystemImage")
                        managedObject.setValue(poolDict["solarSystemOption"], forKey: "solarSystemOption")
                        managedObject.setValue(poolDict["catchBasinImage"], forKey: "catchBasinImage")
                        managedObject.setValue(poolDict["catchBasinOption"], forKey: "catchBasinOption")
                        managedObject.setValue(poolDict["slotDrainImage"], forKey: "slotDrainImage")
                        managedObject.setValue(poolDict["slotDrainOption"], forKey: "slotDrainOption")
                        
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
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Pool4_CoreData")
                fetchRequest.returnsObjectsAsFaults = false
                
                let predicate = NSPredicate(format: "%K == %@", "report_id", strReport_id)
                fetchRequest.predicate = predicate
                
                let  rs = try managedContext.fetch(fetchRequest)
                for _ in rs as [NSManagedObject] {
                    // update
                    do {
                        let managedObject = rs[0]
                        
                        managedObject.setValue(strReport_id, forKey: "report_id")
                        managedObject.setValue(dataEqueImg, forKey: "equipAreaImage")
                        managedObject.setValue(equaiAreaOption, forKey: "equipAreaOption")
                        managedObject.setValue(self.secVisualLeak[VisualLeak.equipmentArea.rawValue].formTextValue, forKey: "equipAreaData")
                        managedObject.setValue(dataBackWashImg, forKey: "backwashImage")
                        managedObject.setValue(backwashOption, forKey: "backWashOption")
                        managedObject.setValue(dataWaterFeatureImg, forKey: "waterFeatureImage")
                        managedObject.setValue(waterFeatureOption, forKey: "waterFeatureOption")
                        managedObject.setValue(dataSolarImg, forKey: "solarSystemImage")
                        managedObject.setValue(solarOption, forKey: "solarSystemOption")
                        managedObject.setValue(dataSolarImg, forKey: "catchBasinImage")
                        managedObject.setValue(basinOption, forKey: "catchBasinOption")
                        managedObject.setValue(dataSolarImg, forKey: "slotDrainImage")
                        managedObject.setValue(drainOption, forKey: "slotDrainOption")
                        
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
                let strPoolData: String = String(describing: self.poolDetailsDict["page_4"]!)
                if strPoolData != "<null>" {
                    self.poolDict = self.poolDetailsDict["page_4"] as! [String : AnyObject]
                }
                print(self.poolDict)
                self.updateCoreData(strReport_id: self.strReport_id)
                self.tblVisualLeak.reloadData()
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
                    
                    let data = json["data"] as? String
                    print("JSON data: \(String(describing: data))")
                    if self.fetchIndexForUpload == 0 {
                        self.strEqueImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 1 {
                        self.strBackWashImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 2 {
                        self.strWaterFeatureImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 3 {
                        self.strSolarImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 4 {
                        self.strBasinImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 5 {
                        self.strDrainImg = String(describing: data!)
                    }
                    SVProgressHUD.dismiss()
                }
            case .failure(let encodingError):
                print("error:\(encodingError)")
                SVProgressHUD.dismiss()
            }
        })
    }*/
    
    func postPoolVisualLeakInspect() {
        self.view.endEditing(true)
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        let token: String = UserDefaults.standard.value(forKey: "key_token") as! String
        
        let headers = [
            "Authorization": token,
            //"Content-Type": "application/x-www-form-urlencoded"
        ]
        
        let url = ServiceConstant.BASE_URL.appending(ServiceConstant.PostPoolVisualLeakInspect)
        print("PoolDetectionDetails URL:: \(url)")
        
        let poolDetails: NSMutableDictionary = [
            "return_data_id"        : strReport_id,
            "equipAreaOption"       : equaiAreaOption,
           /*
            "descriptionEquipArea"  : self.secVisualLeak[VisualLeak.equipmentArea.rawValue].formTextValue,
            //"equipAreaImgs"         : strEqueImg,
            "backWashOption"        : backwashOption,
            //"backWashImgs"          : strBackWashImg,
            "waterFeatureOption"    : waterFeatureOption,
            //"waterFeatureImgs"      : strWaterFeatureImg,
            "solarSystemOption"     : solarOption,
            //"solarImgs"             : strSolarImg,
            "catchBasinOption"      : basinOption,
            //"basinImgs"             : strBasinImg,
            "slotDrainOption"       : drainOption,
            //"drainImgs"             : strDrainImg,
             */
            
            
            "equipAreaImgs"         : self.secVisualLeak[VisualLeak.equipmentArea.rawValue].formTextValue,
            "backWashImgs"        : backwashOption,
            "waterFeatureImgs"    : waterFeatureOption,
            "solarImgs"     : solarOption,
            "basinImgs"      : basinOption,
            "drainImgs"       : drainOption,
            
            
        ]
        
        print(poolDetails)
        Alamofire.upload(multipartFormData: { multipartFormData in
            if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.dataEqueImg as! Data) as? NSArray {
                //extract data..
                print(mySavedData)
                let arrImgs = mySavedData as! [UIImage]
                for image in arrImgs {
                    let imageData = image.jpegData(compressionQuality: 1.0)
                    multipartFormData.append(imageData!, withName: "equipAreaImgs[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                }
            }
            if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.dataBackWashImg as! Data) as? NSArray {
                //extract data..
                print(mySavedData)
                let arrImgs = mySavedData as! [UIImage]
                for image in arrImgs {
                    let imageData = image.jpegData(compressionQuality: 1.0)
                    multipartFormData.append(imageData!, withName: "backWashImgs[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                }
            }
            if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.dataWaterFeatureImg as! Data) as? NSArray {
                //extract data..
                print(mySavedData)
                let arrImgs = mySavedData as! [UIImage]
                for image in arrImgs {
                    let imageData = image.jpegData(compressionQuality: 1.0)
                    multipartFormData.append(imageData!, withName: "waterFeatureImgs[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                }
            }
            if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.dataSolarImg as! Data) as? NSArray {
                //extract data..
                print(mySavedData)
                let arrImgs = mySavedData as! [UIImage]
                for image in arrImgs {
                    let imageData = image.jpegData(compressionQuality: 1.0)
                    multipartFormData.append(imageData!, withName: "solarImgs[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                }
            }
            if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.dataBasinImg as! Data) as? NSArray {
                //extract data..
                print(mySavedData)
                let arrImgs = mySavedData as! [UIImage]
                for image in arrImgs {
                    let imageData = image.jpegData(compressionQuality: 1.0)
                    multipartFormData.append(imageData!, withName: "basinImgs[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                }
            }
            if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.dataDrainImg as! Data) as? NSArray {
                //extract data..
                print(mySavedData)
                let arrImgs = mySavedData as! [UIImage]
                for image in arrImgs {
                    let imageData = image.jpegData(compressionQuality: 1.0)
                    multipartFormData.append(imageData!, withName: "drainImgs[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                }
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
                        if UIDevice.current.userInterfaceIdiom == .phone {
                            let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection", bundle:nil)
                            let formVC = storyBoard.instantiateViewController(withIdentifier: "PlumbingStatistic") as! PlumbingStatisticVC
                            formVC.strReport_id = self.strReport_id
                            self.navigationController?.pushViewController(formVC, animated: true)
                        } else if UIDevice.current.userInterfaceIdiom == .pad {
                            let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection_iPad", bundle:nil)
                            let formVC = storyBoard.instantiateViewController(withIdentifier: "PlumbingStatistic") as! PlumbingStatisticVC
                            formVC.strReport_id = self.strReport_id
                            self.navigationController?.pushViewController(formVC, animated: true)
                        }
                    }
                    SVProgressHUD.dismiss()
                }
            case .failure(let encodingError):
                print("error:\(encodingError)")
                SVProgressHUD.dismiss()
            }
        })
    }
    
    func postPoolVisualLeakInspectUpdate() {
        self.view.endEditing(true)
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        let token: String = UserDefaults.standard.value(forKey: "key_token") as! String
        
        let headers = [
            "Authorization": token,
            //"Content-Type": "application/json"//"application/x-www-form-urlencoded"
        ]
        let urlString = ServiceConstant.BASE_URL.appending(ServiceConstant.PostPoolVisualLeakInspectUpdate)
        print("PoolDetectionDetails URL:: \(urlString)")
        let myUrl = URL(string: urlString)
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "POST"
        request.timeoutInterval = 120
        
        
        let poolDetails: NSMutableDictionary = [
            "return_data_id"        : strReport_id,
            "report_id"        : strReport_id,
            "equipAreaOption"       : equaiAreaOption,
            "descriptionEquipArea"  : self.secVisualLeak[VisualLeak.equipmentArea.rawValue].formTextValue,
            //"equipAreaImgs"         : strEqueImg,
            "backWashOption"        : backwashOption,
            //"backWashImgs"          : strBackWashImg,
            "waterFeatureOption"    : waterFeatureOption,
            //"waterFeatureImgs"      : strWaterFeatureImg,
            "solarSystemOption"     : solarOption,
            //"solarImgs"             : strSolarImg,
            "catchBasinOption"      : basinOption,
            //"basinImgs"             : strBasinImg,
            "slotDrainOption"       : drainOption,
            //"drainImgs"             : strDrainImg,
        ]
        print(poolDetails)
        Alamofire.upload(multipartFormData: { multipartFormData in
            if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.dataEqueImg as! Data) as? NSArray {
                //extract data..
                print(mySavedData)
                let arrImgs = mySavedData as! [UIImage]
                for image in arrImgs {
                    let imageData = image.jpegData(compressionQuality: 1.0)
                    multipartFormData.append(imageData!, withName: "equipAreaImgs[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                }
            }
            if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.dataBackWashImg as! Data) as? NSArray {
                //extract data..
                print(mySavedData)
                let arrImgs = mySavedData as! [UIImage]
                for image in arrImgs {
                    let imageData = image.jpegData(compressionQuality: 1.0)
                    multipartFormData.append(imageData!, withName: "backWashImgs[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                }
            }
            if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.dataWaterFeatureImg as! Data) as? NSArray {
                //extract data..
                print(mySavedData)
                let arrImgs = mySavedData as! [UIImage]
                for image in arrImgs {
                    let imageData = image.jpegData(compressionQuality: 1.0)
                    multipartFormData.append(imageData!, withName: "waterFeatureImgs[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                }
            }
            if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.dataSolarImg as! Data) as? NSArray {
                //extract data..
                print(mySavedData)
                let arrImgs = mySavedData as! [UIImage]
                for image in arrImgs {
                    let imageData = image.jpegData(compressionQuality: 1.0)
                    multipartFormData.append(imageData!, withName: "solarImgs[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                }
            }
            if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.dataBasinImg as! Data) as? NSArray {
                //extract data..
                print(mySavedData)
                let arrImgs = mySavedData as! [UIImage]
                for image in arrImgs {
                    let imageData = image.jpegData(compressionQuality: 1.0)
                    multipartFormData.append(imageData!, withName: "basinImgs[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                }
            }
            if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.dataDrainImg as! Data) as? NSArray {
                //extract data..
                print(mySavedData)
                let arrImgs = mySavedData as! [UIImage]
                for image in arrImgs {
                    let imageData = image.jpegData(compressionQuality: 1.0)
                    multipartFormData.append(imageData!, withName: "drainImgs[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
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
                    
                    if ((json["status"]  as! Int) == 1) {
                        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                            return
                        }
                        let alertController = UIAlertController(title: "", message: (json["message"] as! String), preferredStyle: UIAlertController.Style.alert) //Replace
                        
                        // Replace UIAlertActionStyle.Default by UIAlertActionStyle.default
                        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                            (result : UIAlertAction) -> Void in
                            
                            if UIDevice.current.userInterfaceIdiom == .phone {
                                let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection", bundle:nil)
                                let formVC = storyBoard.instantiateViewController(withIdentifier: "PlumbingStatistic") as! PlumbingStatisticVC
                                formVC.strReport_id = self.strReport_id
                                self.navigationController?.pushViewController(formVC, animated: true)
                            } else if UIDevice.current.userInterfaceIdiom == .pad {
                                let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection_iPad", bundle:nil)
                                let formVC = storyBoard.instantiateViewController(withIdentifier: "PlumbingStatistic") as! PlumbingStatisticVC
                                formVC.strReport_id = self.strReport_id
                                self.navigationController?.pushViewController(formVC, animated: true)
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension VisualLeakVC: OpalImagePickerControllerDelegate {
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
                            if self.fetchIndexForUpload == 0 {
                                self.arrEquipmentAreaImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.setPostImage(arrOfImages: images)
                                self.dataEqueImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForUpload == 1 {
                                self.arrBackWashImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.setPostImage(arrOfImages: images)
                                self.dataBackWashImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForUpload == 2 {
                                self.arrWaterFeatureImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.setPostImage(arrOfImages: images)
                                self.dataWaterFeatureImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForUpload == 3 {
                                self.arrSolarSystemImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.setPostImage(arrOfImages: images)
                                self.dataSolarImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForUpload == 4 {
                                self.arrCatchBasinImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.setPostImage(arrOfImages: images)
                                self.dataBasinImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForUpload == 5 {
                                self.arrSlotDrainImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.setPostImage(arrOfImages: images)
                                self.dataDrainImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
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
                self.tblVisualLeak.reloadData()
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


extension VisualLeakVC: UIImagePickerControllerDelegate {
    // MARK:: UIImagePickerControllerDelegate
    //For xcode 10
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let possibleImage = info[.originalImage] as? UIImage
            else {
                fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
                //return
            }
        
        if fetchIndexForUpload == 0 {
            self.arrEquipmentAreaImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataEqueImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if fetchIndexForUpload == 1 {
            self.arrBackWashImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataBackWashImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if fetchIndexForUpload == 2 {
            self.arrWaterFeatureImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataWaterFeatureImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if fetchIndexForUpload == 3 {
            self.arrSolarSystemImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataSolarImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if fetchIndexForUpload == 4 {
            self.arrCatchBasinImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataBasinImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if fetchIndexForUpload == 5 {
            self.arrSlotDrainImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataDrainImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        }
        self.tblVisualLeak.reloadData()
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
}


extension VisualLeakVC: UITableViewDataSource, UITableViewDelegate {
    //MARK:- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cellArea = tableView.dequeueReusableCell(withIdentifier: "EquipmentAreaCell", for: indexPath) as! EquipmentAreaCell
            
            cellArea.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            
            if poolDict.count > 0 {
                if String(describing: poolDict["equipAreaOption"]!) == "Noted leak(s)" {
                    self.equaiAreaOption = "Noted leak(s)"
                    cellArea.imgEquipmentArea0.image = UIImage(named: "checkmark")
                    cellArea.imgEquipmentArea1.image = UIImage(named: "unchecked")
                } else if String(describing: poolDict["equipAreaOption"]!) == "No leaks noted" {
                    self.equaiAreaOption = "No leaks noted"
                    cellArea.imgEquipmentArea0.image = UIImage(named: "unchecked")
                    cellArea.imgEquipmentArea1.image = UIImage(named: "checkmark")
                }
                if String(describing: poolDict["descriptionEquipArea"]) != ""{
                    cellArea.vwWhereDescription.text = String(describing: poolDict["descriptionEquipArea"])
                }
                else{
                    cellArea.vwWhereDescription.text = ""
                }

                if (self.poolDict["equipAreaImgs"]! as! [String]).count > 0 {
                    let imgArr = self.poolDict["equipAreaImgs"]! as! [String]
                    cellArea.collectionVw.arrImgs = imgArr
                    if imgArr.count > 0 {
                        cellArea.btnUpload.isHidden = true
                        cellArea.collectionVw.isHidden = false
                    } else {
                        cellArea.btnUpload.isHidden = false
                        cellArea.collectionVw.isHidden = true
                    }
                } else {
                    cellArea.collectionVw.arrItems = arrEquipmentAreaImg
                    if arrEquipmentAreaImg.count > 0 {
                        cellArea.btnUpload.isHidden = true
                        cellArea.collectionVw.isHidden = false
                    } else {
                        cellArea.btnUpload.isHidden = false
                        cellArea.collectionVw.isHidden = true
                    }
                }
                cellArea.collectionVw.isEdit = true
                
                //cellArea.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
                
            } else {
                cellArea.collectionVw.isEdit = false
                cellArea.collectionVw.arrItems = arrEquipmentAreaImg

                if arrEquipmentAreaImg.count > 0 {
                    cellArea.btnUpload.isHidden = true
                    cellArea.collectionVw.isHidden = false
                } else {
                    cellArea.btnUpload.isHidden = false
                    cellArea.collectionVw.isHidden = true
                }
            }
            cellArea.collectionVw.delegateItemCollection = self
            cellArea.collectionVw.reloadImageCollection()

            //cellArea.btnUpload.isHidden = true
            
            cellArea.delegateEquiArea = self
            cellArea.vwWhereDescription.delegate = self
            
            return cellArea
        } else if indexPath.row == 1 {
            let cellImg = tableView.dequeueReusableCell(withIdentifier: "BackWashImageCell", for: indexPath) as! BackWashImageTableCell
            
            cellImg.lblOptionalImg.text = "Back wash"
            
            cellImg.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            
            cellImg.collectionVw.delegateItemCollection = self
            cellImg.collectionVw.reloadImageCollection()
            
            print(String("backWashOption: \(poolDict["backWashOption"])"))
            if poolDict.count > 0 {
                if poolDict["backWashOption"] != nil{
                    if String(describing: poolDict["backWashOption"]!) == "Leaking" {
                        self.backwashOption = "Leaking"
                        cellImg.imgBackWash0.image = UIImage(named: "checkmark")
                        cellImg.imgBackWash1.image = UIImage(named: "unchecked")
                    } else if String(describing: poolDict["backWashOption"]!) == "No leaks noted" {
                        self.backwashOption = "No leaks noted"
                        cellImg.imgBackWash0.image = UIImage(named: "unchecked")
                        cellImg.imgBackWash1.image = UIImage(named: "checkmark")
                    }
                }
                
                
                if (self.poolDict["backWashImgs"]! as! [String]).count > 0 {
                    let imgArr = self.poolDict["backWashImgs"]! as! [String]
                    cellImg.collectionVw.arrImgs = imgArr
                    if imgArr.count > 0 {
                        cellImg.btnUpload.isHidden = true
                        cellImg.collectionVw.isHidden = false
                    } else {
                        cellImg.btnUpload.isHidden = false
                        cellImg.collectionVw.isHidden = true
                    }
                } else {
                    cellImg.collectionVw.arrItems = arrBackWashImg
                    if arrBackWashImg.count > 0 {
                        cellImg.btnUpload.isHidden = true
                        cellImg.collectionVw.isHidden = false
                    } else {
                        cellImg.btnUpload.isHidden = false
                        cellImg.collectionVw.isHidden = true
                    }
                }
                cellImg.collectionVw.isEdit = true
            } else {
                cellImg.collectionVw.isEdit = false
                cellImg.collectionVw.arrItems = arrBackWashImg
                if arrBackWashImg.count > 0 {
                    cellImg.btnUpload.isHidden = true
                    cellImg.collectionVw.isHidden = false
                } else {
                    cellImg.btnUpload.isHidden = false
                    cellImg.collectionVw.isHidden = true
                }
            }
            
            cellImg.delegateBackWash = self
            
            return cellImg
        } else if indexPath.row == 2 {
            let cellImg = tableView.dequeueReusableCell(withIdentifier: "AroundWaterImageCell", for: indexPath) as! AroundWaterImageTableCell
            
            cellImg.lblOptionalImg.text = "Around water feature"
            
            cellImg.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            
            cellImg.collectionVw.delegateItemCollection = self
            cellImg.collectionVw.reloadImageCollection()
            
            if poolDict.count > 0 {
                
                if poolDict["backWashOption"] != nil{
                    if String(describing: poolDict["waterFeatureOption"]!) == "Leaking" {
                                       self.waterFeatureOption = "Leaking"
                                       cellImg.imgAroundWater0.image = UIImage(named: "checkmark")
                                       cellImg.imgAroundWater1.image = UIImage(named: "unchecked")
                                   } else if String(describing: poolDict["waterFeatureOption"]!) == "No leaks noted" {
                                       self.waterFeatureOption = "No leaks noted"
                                       cellImg.imgAroundWater0.image = UIImage(named: "unchecked")
                                       cellImg.imgAroundWater1.image = UIImage(named: "checkmark")
                                   }
                }
                
               
                
                if (self.poolDict["waterFeatureImgs"]! as! [String]).count > 0 {
                    let imgArr = self.poolDict["waterFeatureImgs"]! as! [String]
                    cellImg.collectionVw.arrImgs = imgArr
                    if imgArr.count > 0 {
                        cellImg.btnUpload.isHidden = true
                        cellImg.collectionVw.isHidden = false
                    } else {
                        cellImg.btnUpload.isHidden = false
                        cellImg.collectionVw.isHidden = true
                    }
                } else {
                    cellImg.collectionVw.arrItems = arrWaterFeatureImg
                    if arrWaterFeatureImg.count > 0 {
                        cellImg.btnUpload.isHidden = true
                        cellImg.collectionVw.isHidden = false
                    } else {
                        cellImg.btnUpload.isHidden = false
                        cellImg.collectionVw.isHidden = true
                    }
                }
                cellImg.collectionVw.isEdit = true
            } else {
                cellImg.collectionVw.isEdit = false
                cellImg.collectionVw.arrItems = arrWaterFeatureImg
                if arrWaterFeatureImg.count > 0 {
                    cellImg.btnUpload.isHidden = true
                    cellImg.collectionVw.isHidden = false
                } else {
                    cellImg.btnUpload.isHidden = false
                    cellImg.collectionVw.isHidden = true
                }
            }
            
            cellImg.delegateAroundWater = self
            
            return cellImg
        } else if indexPath.row == 3 {
            let cellImg = tableView.dequeueReusableCell(withIdentifier: "SolarSystemImageCell", for: indexPath) as! SolarSystemImageTableCell
            
            cellImg.lblOptionalImg.text = "Solar System"
            
            cellImg.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            
            cellImg.collectionVw.delegateItemCollection = self
            cellImg.collectionVw.reloadImageCollection()
            
            if poolDict.count > 0 {
                if poolDict["solarSystemOption"] != nil{
                    if String(describing: poolDict["solarSystemOption"]!) == "Leaking" {
                        self.solarOption = "Leaking"
                        cellImg.imgSolarSystem0.image = UIImage(named: "checkmark")
                        cellImg.imgSolarSystem1.image = UIImage(named: "unchecked")
                    } else if String(describing: poolDict["solarSystemOption"]!) == "No leaks noted" {
                        self.solarOption = "No leaks noted"
                        cellImg.imgSolarSystem0.image = UIImage(named: "unchecked")
                        cellImg.imgSolarSystem1.image = UIImage(named: "checkmark")
                    }

                }
                
                
                if (self.poolDict["solarImgs"]! as! [String]).count > 0 {
                    let imgArr = self.poolDict["solarImgs"]! as! [String]
                    cellImg.collectionVw.arrImgs = imgArr
                    if imgArr.count > 0 {
                        cellImg.btnUpload.isHidden = true
                        cellImg.collectionVw.isHidden = false
                    } else {
                        cellImg.btnUpload.isHidden = false
                        cellImg.collectionVw.isHidden = true
                    }
                } else {
                    cellImg.collectionVw.arrItems = arrSolarSystemImg
                    if arrSolarSystemImg.count > 0 {
                        cellImg.btnUpload.isHidden = true
                        cellImg.collectionVw.isHidden = false
                    } else {
                        cellImg.btnUpload.isHidden = false
                        cellImg.collectionVw.isHidden = true
                    }
                }
                cellImg.collectionVw.isEdit = true
            } else {
                cellImg.collectionVw.isEdit = false
                cellImg.collectionVw.arrItems = arrSolarSystemImg
                if arrSolarSystemImg.count > 0 {
                    cellImg.btnUpload.isHidden = true
                    cellImg.collectionVw.isHidden = false
                } else {
                    cellImg.btnUpload.isHidden = false
                    cellImg.collectionVw.isHidden = true
                }
            }
            
            cellImg.delegateSolarSystem = self
            
            return cellImg
        } else if indexPath.row == 4 {
            let cellImg = tableView.dequeueReusableCell(withIdentifier: "CatchBasinImageCell", for: indexPath) as! CatchBasinImageTableCell
            
            cellImg.lblOptionalImg.text = "Catch Basin (if applicable)"
            
            cellImg.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            
            cellImg.collectionVw.delegateItemCollection = self
            cellImg.collectionVw.reloadImageCollection()
            
            if poolDict.count > 0 {
                
                if poolDict["catchBasinOption"] != nil{
                    if String(describing: poolDict["catchBasinOption"]!) == "Leaking" {
                        self.basinOption = "Leaking"
                        cellImg.imgCatchBasin0.image = UIImage(named: "checkmark")
                        cellImg.imgCatchBasin1.image = UIImage(named: "unchecked")
                    } else if String(describing: poolDict["catchBasinOption"]!) == "No leaks noted" {
                        self.basinOption = "No leaks noted"
                        cellImg.imgCatchBasin0.image = UIImage(named: "unchecked")
                        cellImg.imgCatchBasin1.image = UIImage(named: "checkmark")
                    }
                }

                
                if (self.poolDict["basinImgs"]! as! [String]).count > 0 {
                    let imgArr = self.poolDict["basinImgs"]! as! [String]
                    cellImg.collectionVw.arrImgs = imgArr
                    if imgArr.count > 0 {
                        cellImg.btnUpload.isHidden = true
                        cellImg.collectionVw.isHidden = false
                    } else {
                        cellImg.btnUpload.isHidden = false
                        cellImg.collectionVw.isHidden = true
                    }
                } else {
                    cellImg.collectionVw.arrItems = arrCatchBasinImg
                    if arrCatchBasinImg.count > 0 {
                        cellImg.btnUpload.isHidden = true
                        cellImg.collectionVw.isHidden = false
                    } else {
                        cellImg.btnUpload.isHidden = false
                        cellImg.collectionVw.isHidden = true
                    }
                }
                cellImg.collectionVw.isEdit = true
            } else {
                cellImg.collectionVw.isEdit = false
                cellImg.collectionVw.arrItems = arrCatchBasinImg
                if arrCatchBasinImg.count > 0 {
                    cellImg.btnUpload.isHidden = true
                    cellImg.collectionVw.isHidden = false
                } else {
                    cellImg.btnUpload.isHidden = false
                    cellImg.collectionVw.isHidden = true
                }
            }
            
            cellImg.delegateCatchBasin = self
            
            return cellImg
        } else if indexPath.row == 5 {
            let cellImg = tableView.dequeueReusableCell(withIdentifier: "SlotDrainImageCell", for: indexPath) as! SlotDrainImageTableCell
            
            cellImg.lblOptionalImg.text = "Slot Drains (if applicable)"
            
            cellImg.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            
            if poolDict.count > 0 {
                
                if poolDict["slotDrainOption"] != nil{
                    if String(describing: poolDict["slotDrainOption"]!) == "Leaking" {
                        self.drainOption = "Leaking"
                        cellImg.imgSlotDrain0.image = UIImage(named: "checkmark")
                        cellImg.imgSlotDrain1.image = UIImage(named: "unchecked")
                    } else if String(describing: poolDict["slotDrainOption"]!) == "No leaks noted" {
                        self.drainOption = "No leaks noted"
                        cellImg.imgSlotDrain0.image = UIImage(named: "unchecked")
                        cellImg.imgSlotDrain1.image = UIImage(named: "checkmark")
                    }

                }
                
                if (self.poolDict["drainImgs"]! as! [String]).count > 0 {
                    let imgArr = self.poolDict["drainImgs"]! as! [String]
                    cellImg.collectionVw.arrImgs = imgArr
                    if imgArr.count > 0 {
                        cellImg.btnUpload.isHidden = true
                        cellImg.collectionVw.isHidden = false
                    } else {
                        cellImg.btnUpload.isHidden = false
                        cellImg.collectionVw.isHidden = true
                    }
                } else {
                    cellImg.collectionVw.arrItems = arrSlotDrainImg
                    if arrSlotDrainImg.count > 0 {
                        cellImg.btnUpload.isHidden = true
                        cellImg.collectionVw.isHidden = false
                    } else {
                        cellImg.btnUpload.isHidden = false
                        cellImg.collectionVw.isHidden = true
                    }
                }
                cellImg.collectionVw.isEdit = true
            } else {
                cellImg.collectionVw.isEdit = false
                cellImg.collectionVw.arrItems = arrSlotDrainImg
                if arrSlotDrainImg.count > 0 {
                    cellImg.btnUpload.isHidden = true
                    cellImg.collectionVw.isHidden = false
                } else {
                    cellImg.btnUpload.isHidden = false
                    cellImg.collectionVw.isHidden = true
                }
            }
            
            cellImg.collectionVw.delegateItemCollection = self
            cellImg.collectionVw.reloadImageCollection()
            cellImg.delegateSlotDrain = self
            
            return cellImg
        } else { //if indexPath.row == 6 {
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
            
            lblHeaderTitle.text = "Visual Leak Inspection"  // set this however is appropriate for your app's model
            
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
            if indexPath.row == 0 {
                return 450
            } else if indexPath.row == 6 {
                return 105
            } else {
                return 260
            }
        } else {        //UIDevice.current.userInterfaceIdiom == .pad{
            if indexPath.row == 0 {
                return 850
            } else if indexPath.row == 6 {
                return 175
            } else {
                return 420
            }
        }
    }
}

/*extension VisualLeakVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var str: String = String(describing: self.poolDict["equipAreaImgs"]!)
        str.remove(at: str.startIndex)
        print(str)
        str.removeLast()
        print(str)
        let arrImgs = String(describing: str).split(separator: ",")
        print(arrImgs)
        return arrImgs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageViewCell", for: indexPath) as! ImageViewCell
        var str: String = String(describing: self.poolDict["equipAreaImgs"]!)
        str.remove(at: str.startIndex)
        print(str)
        str.removeLast()
        print(str)
        let arrImgs = String(describing: str).split(separator: ",")
        print(arrImgs)
        let urlStr: String = String(describing: arrImgs[indexPath.row])
        
        cell.imgV?.sd_setImage(with: URL(string: urlStr), placeholderImage: UIImage(named: ""))
         
        return cell
    }
}*/
extension VisualLeakVC: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        var cell = UITableViewCell()
        cell = (textView.superview?.superview as? UITableViewCell)!
        if UIDevice.current.userInterfaceIdiom == .phone {
            if let equiCell = cell as? EquipmentAreaCell {
                if textView == equiCell.vwWhereDescription {
                    self.secVisualLeak[VisualLeak.equipmentArea.rawValue].formTextValue = (textView.text)!
               }
            }
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            if let equiCell = cell as? EquipmentAreaCell {
                if textView == equiCell.vwWhereDescription {
                       self.secVisualLeak[VisualLeak.equipmentArea.rawValue].formTextValue = (textView.text)!
               }
            }
        }
    }
}


extension VisualLeakVC:EquipmentAreaCellProtocol, BackWashImageCellProtocol, AroundWaterImageCellProtocol, SolarSystemImageCellProtocol, CatchBasinImageCellProtocol, SlotDrainImageCellProtocol {
    func didTapOnCellEquipmentArea(_btnEquipmentAreaTag: Int) {
        if _btnEquipmentAreaTag == 0 {
            equaiAreaOption = "Noted leak(s)"
        } else if _btnEquipmentAreaTag == 1 {
            equaiAreaOption = "No leaks noted"
        }
    }
    
    func didTapOnCellBackWash(_btnBackWashTag: Int) {
        if _btnBackWashTag == 0 {
            backwashOption = "Leaking"
        } else if _btnBackWashTag == 1 {
            backwashOption = "No leaks noted"
        }
    }
    
    func didTapOnCellAroundWater(_btnAroundWaterTag: Int) {
        if _btnAroundWaterTag == 0 {
            waterFeatureOption = "Leaking"
        } else if _btnAroundWaterTag == 1 {
            waterFeatureOption = "No leaks noted"
        }
    }
    
    func didTapOnCellSolarSystem(_btnSolarSystemTag: Int) {
        if _btnSolarSystemTag == 0 {
            solarOption = "Leaking"
        } else if _btnSolarSystemTag == 1 {
            solarOption = "No leaks noted"
        }
    }
    
    func didTapOnCellCatchBasin(_btnCatchBasinTag: Int) {
        if _btnCatchBasinTag == 0 {
            basinOption = "Leaking"
        } else if _btnCatchBasinTag == 1 {
            basinOption = "No leaks noted"
        }
    }
    
    func didTapOnCellSlotDrain(_btnSlotDrainTag: Int) {
        if _btnSlotDrainTag == 0 {
            drainOption = "Leaking"
        } else if _btnSlotDrainTag == 1 {
            drainOption = "No leaks noted"
        }
    }
}
