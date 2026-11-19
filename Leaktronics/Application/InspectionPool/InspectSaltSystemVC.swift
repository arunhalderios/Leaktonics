//
//  InspectionSaltSystemVC.swift
//  Leaktronics
//
//  Created by Abhishek Mullick on 07/05/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import CoreData
import DLRadioButton
import SVProgressHUD
import Alamofire
import Photos
import OpalImagePicker

class InspectSaltSystemVC: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var tblSaltSystem: UITableView!
    
    var secInspectSaltSystem = [formInspectionPoolData]()
    var secSaltSystem = [formInspectionPoolData]()
    var secSaltSelfClean = [formInspectionPoolData]()
    
    enum InspectSaltSystem: Int {
        case saltSystem = 1
        case purification = 2
        case selfClean = 3
    }
    
    enum SaltSystem: Int {
        case saltSystemMaintain = 0
        case saltPower = 1
        case saltSystemWorking = 2
        case saltVisibleLeak = 3
        case saltCalcification = 4
    }
    
    enum SaltSelfClean: Int {
        case cleanFloorHead = 0
        case cleanHeadCondition = 1
        case cleanHeadSync = 2
        case cleanLatching = 3
        case cleanController = 4
    }
    
    var fetchIndexForUpload: Int = -1
    var fetchIndexForSubSaltSystemUpload: Int = -1
    var fetchIndexForSubSelfCleanUpload: Int = -1
    
    
    var imagePicker = UIImagePickerController()
    var picker:UIImagePickerController? = UIImagePickerController()
    
    
    //For Images
    var arrImgSaltSystemMain: [CollectionImageObject] = []
    var arrImgSaltSystem: [CollectionImageObject] = []
    var arrImgPurification: [CollectionImageObject] = []
    var arrImgSaltCleaning: [CollectionImageObject] = []
    
    var arrImgSaltMaintain: [CollectionImageObject] = []
    var arrImgSaltPowerBtn: [CollectionImageObject] = []
    var arrImgSaltWorking: [CollectionImageObject] = []
    var arrImgSaltLeak: [CollectionImageObject] = []
    var arrImgSaltCalcification: [CollectionImageObject] = []
    
    var arrImgSelfFloorHead: [CollectionImageObject] = []
    var arrImgSelfCondition: [CollectionImageObject] = []
    var arrImgSaltHeadSync: [CollectionImageObject] = []
    var arrImgSaltLatchingSafety: [CollectionImageObject] = []
    var arrImgSaltControllerLeak: [CollectionImageObject] = []
    
    
    //For Image Server path
    var strImgSaltSystemMain = String()
    var strImgSaltSystem = String()
    var strImgPurification = String()
    var strImgSelfCleaning = String()
    
    var strImgSaltMaintain = String()
    var strImgSaltPowerBtn = String()
    var strImgSaltWorking = String()
    var strImgSaltLeak = String()
    var strImgSaltCalcification = String()
    
    var strImgSelfFloorHead = String()
    var strImgSelfCondition = String()
    var strImgSelfHeadSync = String()
    var strImgSelfLatchingSafety = String()
    var strImgSelfControllerLeak = String()
        
    
    //For Image CoreData
    var dataImgSaltSystemMain = NSData()
    var dataImgSaltSystem = NSData()
    var dataImgPurification = NSData()
    var dataImgSelfCleaning = NSData()
    
    var dataImgSaltMaintain = NSData()
    var dataImgSaltPowerBtn = NSData()
    var dataImgSaltWorking = NSData()
    var dataImgSaltLeak = NSData()
    var dataImgSaltCalcification = NSData()
    
    var dataImgSelfFloorHead = NSData()
    var dataImgSelfCondition = NSData()
    var dataImgSelfHeadSync = NSData()
    var dataImgSelfLatchingSafety = NSData()
    var dataImgSelfControllerLeak = NSData()
    
    
    //For Optional Value
    var strSaltSystemOption = String()
    var strWaterPurificationOption = String()
    var strSaltSelfCleanOption = String()
    
    var strOptSaltMaintain = String()
    var strOptSaltPowerBtn = String()
    var strOptSaltWorking = String()
    var strOptSaltLeak = String()
    var strOptSaltCalcification = String()
    
    var strOptSelfFloorHead = String()
    var strOptSelfCondition = String()
    var strOptSelfHeadSync = String()
    var strOptSelfLatchingSafety = String()
    var strOptSelfControllerLeak = String()
    
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.prepareFormSaltSystemData()
    }
    
    func prepareFormSaltSystemData() {
        for _ in 0..<6 {
            let obj = formInspectionPoolData()
            self.secInspectSaltSystem.append(obj)
        }
        for _ in 0..<6 {
            let obj = formInspectionPoolData()
            self.secSaltSystem.append(obj)
        }
        for _ in 0..<6 {
            let obj = formInspectionPoolData()
            self.secSaltSelfClean.append(obj)
        }
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
                popoverController.permittedArrowDirections = UIPopoverArrowDirection.up
            }
            self.present(alert, animated: true, completion: nil)
        }
    }
                        
    //MARK: Method to Open camera
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
    
    //MARK: Method to Open Gallery
    func openGallary() {
        let imagePickerController = OpalImagePickerController()
        imagePickerController.imagePickerDelegate = self
        imagePickerController.maximumSelectionsAllowed = 5
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func btnClickedUpload(_ sender: Any) {
        print("Button pressed 👍 ")
        let btn = sender as! UIButton
        let cell = btn.superview?.superview?.superview as! UITableViewCell
        let indexOfCell = self.tblSaltSystem.indexPath(for: cell)
        print("Clicked Index : \(String(describing: indexOfCell?.row))")
        
        fetchIndexForSubSaltSystemUpload = -1
        fetchIndexForSubSelfCleanUpload = -1
        fetchIndexForUpload = (indexOfCell?.row)!
        print("Upload Index : \(String(describing: fetchIndexForUpload))")
        
        self.actionSheetPopUpForGalleryOpen()
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc func btnSelfCleanImgUpload(_ sender: Any) {
        print("Button pressed 👍 ")
        let btn = sender as! UIButton
        let cell = btn.superview?.superview?.superview as! UITableViewCell
        let tblSubSwim = self.view.viewWithTag(35) as! UITableView
        let indexOfCell = tblSubSwim.indexPath(for: cell)
        print("Clicked Index : \(String(describing: indexOfCell?.row))")
        fetchIndexForUpload = -1
        fetchIndexForSubSelfCleanUpload = (indexOfCell?.row)!
        
        print("Upload Index : \(String(describing: fetchIndexForSubSelfCleanUpload))")
        
        self.actionSheetPopUpForGalleryOpen()
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc func btnSaltSystemImgUpload(_ sender: Any) {
        print("Button pressed 👍 ")
        let btn = sender as! UIButton
        let cell = btn.superview?.superview?.superview as! UITableViewCell
        let tblSubSwim = self.view.viewWithTag(25) as! UITableView
        let indexOfCell = tblSubSwim.indexPath(for: cell)
        print("Clicked Index : \(String(describing: indexOfCell?.row))")
        fetchIndexForUpload = -1
        fetchIndexForSubSaltSystemUpload = (indexOfCell?.row)!
        
        print("Upload Index : \(String(describing: fetchIndexForSubSaltSystemUpload))")
        
        self.actionSheetPopUpForGalleryOpen()
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    //MARK:- ObjectiveC Function
    @objc func btnNextDidTap() {
        self.updateCoreData()
        self.view.endEditing(true)
        
        //self.postInspectSaltSystem()
        if UIDevice.current.userInterfaceIdiom == .phone {
            let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
            let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectClock") as! InspectClockVC
            self.navigationController?.pushViewController(formVC, animated: true)
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
            let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectClock") as! InspectClockVC
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
                    
                    managedObject.setValue(dataImgSaltSystemMain, forKey: "saltSystemMainImage")
                    managedObject.setValue(strSaltSystemOption, forKey: "saltSystemOption")
                    managedObject.setValue(dataImgSaltSystem, forKey: "saltSystemImage")
                    managedObject.setValue(self.secInspectSaltSystem[InspectSaltSystem.saltSystem.rawValue].formTextValue, forKey: "saltSystemData")
                    managedObject.setValue(strWaterPurificationOption, forKey: "purificationOption")
                    managedObject.setValue(dataImgPurification, forKey: "purificationImage")
                    managedObject.setValue(self.secInspectSaltSystem[InspectSaltSystem.purification.rawValue].formTextValue, forKey: "purificationData")
                    managedObject.setValue(strSaltSelfCleanOption, forKey: "selfCleaningOption")
                    managedObject.setValue(dataImgSelfCleaning, forKey: "selfCleaningImage")
                    managedObject.setValue(self.secInspectSaltSystem[InspectSaltSystem.selfClean.rawValue].formTextValue, forKey: "selfCleaningData")
                    managedObject.setValue(strOptSaltMaintain, forKey: "saltSystemMaintainOption")
                    managedObject.setValue(dataImgSaltMaintain, forKey: "saltSystemMaintainImage")
                    managedObject.setValue(self.secSaltSystem[SaltSystem.saltSystemMaintain.rawValue].formTextValue, forKey: "saltSystemMaintainData")
                    managedObject.setValue(strOptSaltPowerBtn, forKey: "saltSystemPowerBtnOption")
                    managedObject.setValue(dataImgSaltPowerBtn, forKey: "saltSystemPowerBtnImage")
                    managedObject.setValue(self.secSaltSystem[SaltSystem.saltPower.rawValue].formTextValue, forKey: "saltSystemPowerBtnData")
                    managedObject.setValue(strOptSaltWorking, forKey: "saltSystemWorkingOption")
                    managedObject.setValue(dataImgSaltWorking, forKey: "saltSystemWorkingImage")
                    managedObject.setValue(self.secSaltSystem[SaltSystem.saltSystemWorking.rawValue].formTextValue, forKey: "saltSystemWorkingData")
                    managedObject.setValue(strOptSaltLeak, forKey: "saltSystemLeakOption")
                    managedObject.setValue(dataImgSaltLeak, forKey: "saltSystemLeakImage")
                    managedObject.setValue(self.secSaltSystem[SaltSystem.saltVisibleLeak.rawValue].formTextValue, forKey: "saltSystemLeakData")
                    managedObject.setValue(strOptSaltCalcification, forKey: "saltSystemCalcificationOption")
                    managedObject.setValue(dataImgSaltCalcification, forKey: "saltSystemCalcificationImage")
                    managedObject.setValue(self.secSaltSystem[SaltSystem.saltCalcification.rawValue].formTextValue, forKey: "saltSystemCalcificationData")
                    managedObject.setValue(strOptSelfFloorHead, forKey: "selfFloorHeadOption")
                    managedObject.setValue(dataImgSelfFloorHead, forKey: "selfFloorHeadImage")
                    managedObject.setValue(self.secSaltSelfClean[SaltSelfClean.cleanFloorHead.rawValue].formTextValue, forKey: "selfFloorHeadData")
                    managedObject.setValue(strOptSelfCondition, forKey: "selfConditionOption")
                    managedObject.setValue(dataImgSelfCondition, forKey: "selfConditionImage")
                    managedObject.setValue(self.secSaltSelfClean[SaltSelfClean.cleanHeadCondition.rawValue].formTextValue, forKey: "selfConditionData")
                    managedObject.setValue(strOptSelfHeadSync, forKey: "selfHeadSyncOption")
                    managedObject.setValue(dataImgSelfHeadSync, forKey: "selfHeadSyncImage")
                    managedObject.setValue(self.secSaltSelfClean[SaltSelfClean.cleanHeadSync.rawValue].formTextValue, forKey: "selfHeadSyncData")
                    managedObject.setValue(strOptSelfLatchingSafety, forKey: "selfLatchingSafetyOption")
                    managedObject.setValue(dataImgSelfLatchingSafety, forKey: "selfLatchingSafetyImage")
                    managedObject.setValue(self.secSaltSelfClean[SaltSelfClean.cleanLatching.rawValue].formTextValue, forKey: "selfLatchingSafetyData")
                    managedObject.setValue(strOptSelfControllerLeak, forKey: "selfControllerLeakOption")
                    managedObject.setValue(dataImgSelfControllerLeak, forKey: "selfControllerLeakImage")
                    managedObject.setValue(self.secSaltSelfClean[SaltSelfClean.cleanController.rawValue].formTextValue, forKey: "selfControllerLeakData")
                    
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
                        print("Data of InspectSaltSystemVC:: \(data)")
//                        print("TextView::",data.value(forKey: "approxDimentionDescription") as! String)
//                        print("Text::",data.value(forKey: "approxDimentionText") as! String)
//                        print("Other Find Text::",data.value(forKey: "otherFindUsText") as! String)
                    }
                }
            } catch {
                print("Failed")
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    /*//MARK:- Function Api Calling
    func setPostImage(arrOfImages: [UIImage]) {
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
                        self.strImgSaltSystemMain = String(describing: data!)
                    } else if self.fetchIndexForUpload == 1 {
                        self.strImgSaltSystem = String(describing: data!)
                    } else if self.fetchIndexForUpload == 2 {
                        self.strImgPurification = String(describing: data!)
                    } else if self.fetchIndexForUpload == 4 {
                        self.strImgSelfCleaning = String(describing: data!)
                    }
                    
                    if self.fetchIndexForSubSaltSystemUpload == 0 {
                        self.strImgSaltMaintain = String(describing: data!)
                    } else if self.fetchIndexForSubSaltSystemUpload == 1 {
                        self.strImgSaltPowerBtn = String(describing: data!)
                    } else if self.fetchIndexForSubSaltSystemUpload == 2 {
                        self.strImgSaltWorking = String(describing: data!)
                    } else if self.fetchIndexForSubSaltSystemUpload == 3 {
                        self.strImgSaltLeak = String(describing: data!)
                    } else if self.fetchIndexForSubSaltSystemUpload == 4 {
                        self.strImgSaltCalcification = String(describing: data!)
                    }
                    
                    if self.fetchIndexForSubSelfCleanUpload == 0 {
                        self.strImgSelfFloorHead = String(describing: data!)
                    } else if self.fetchIndexForSubSelfCleanUpload == 1 {
                        self.strImgSelfCondition = String(describing: data!)
                    } else if self.fetchIndexForSubSelfCleanUpload == 2 {
                        self.strImgSelfHeadSync = String(describing: data!)
                    } else if self.fetchIndexForSubSelfCleanUpload == 3 {
                        self.strImgSelfLatchingSafety = String(describing: data!)
                    } else if self.fetchIndexForSubSelfCleanUpload == 4 {
                        self.strImgSelfControllerLeak = String(describing: data!)
                    }

                    SVProgressHUD.dismiss()
                }
            case .failure(let encodingError):
                    print("error:\(encodingError)")
                    SVProgressHUD.dismiss()
                }
            }
        )
    }
    
    func postInspectSaltSystem() {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        
        let return_id = UserDefaults.standard.value(forKey: "returnKeyForInspection")
        
        let inspectSaltSystemDetails: NSMutableDictionary = [
            "return_data_id"                : return_id!,
            "saltSystemMainImage"           : strImgSaltSystemMain,
            "saltSystemOption"              : strSaltSystemOption,
            "saltSystemImage"               : strImgSaltSystem,
            "saltSystemData"                : self.secInspectSaltSystem[InspectSaltSystem.saltSystem.rawValue].formTextValue,
            "purificationOption"            : strWaterPurificationOption,
            "purificationImage"             : strImgPurification,
            "purificationData"              : self.secInspectSaltSystem[InspectSaltSystem.purification.rawValue].formTextValue,
            "selfCleaningOption"            : strSaltSelfCleanOption,
            "selfCleaningImage"             : strImgSelfCleaning,
            "selfCleaningData"              : self.secInspectSaltSystem[InspectSaltSystem.selfClean.rawValue].formTextValue,
            "saltSystemMaintainOption"      : strOptSaltMaintain,
            "saltSystemMaintainImage"       : strImgSaltMaintain,
            "saltSystemMaintainData"        : self.secSaltSystem[SaltSystem.saltSystemMaintain.rawValue].formTextValue,
            "saltSystemPowerBtnOption"      : strOptSaltPowerBtn,
            "saltSystemPowerBtnImage"       : strImgSaltPowerBtn,
            "saltSystemPowerBtnData"        : self.secSaltSystem[SaltSystem.saltPower.rawValue].formTextValue,
            "saltSystemWorkingOption"       : strOptSaltWorking,
            "saltSystemWorkingImage"        : strImgSaltWorking,
            "saltSystemWorkingData"         : self.secSaltSystem[SaltSystem.saltSystemWorking.rawValue].formTextValue,
            "saltSystemLeakOption"          : strOptSaltLeak,
            "saltSystemLeakImage"           : strImgSaltLeak,
            "saltSystemLeakData"            : self.secSaltSystem[SaltSystem.saltVisibleLeak.rawValue].formTextValue,
            "saltSystemCalcificationOption" : strOptSaltCalcification,
            "saltSystemCalcificationImage"  : strImgSaltMaintain,
            "saltSystemCalcificationData"   : self.secSaltSystem[SaltSystem.saltCalcification.rawValue].formTextValue,
            "selfFloorHeadOption"           : strOptSelfFloorHead,
            "selfFloorHeadImage"            : strImgSelfFloorHead,
            "selfFloorHeadData"             : self.secSaltSelfClean[SaltSelfClean.cleanFloorHead.rawValue].formTextValue,
            "selfConditionOption"           : strOptSelfCondition,
            "selfConditionImage"            : strImgSelfCondition,
            "selfConditionData"             : self.secSaltSelfClean[SaltSelfClean.cleanHeadCondition.rawValue].formTextValue,
            "selfHeadSyncOption"            : strOptSelfHeadSync,
            "selfHeadSyncImage"             : strImgSelfHeadSync,
            "selfHeadSyncData"              : self.secSaltSelfClean[SaltSelfClean.cleanHeadSync.rawValue].formTextValue,
            "selfLatchingSafetyOption"      : strOptSelfLatchingSafety,
            "selfLatchingSafetyImage"       : strImgSelfLatchingSafety,
            "selfLatchingSafetyData"        : self.secSaltSelfClean[SaltSelfClean.cleanLatching.rawValue].formTextValue,
            "selfControllerLeakOption"      : strOptSelfControllerLeak,
            "selfControllerLeakImage"       : strImgSelfControllerLeak,
            "selfControllerLeakData"        : self.secSaltSelfClean[SaltSelfClean.cleanController.rawValue].formTextValue
        ]

        print("inspectSaltSystemDetails :: \(inspectSaltSystemDetails)")
        //if sharedExtension.connectedToNetwork() {
        ApiManager.sharedInstanceAPI.PostInspectSaltSystem(postId: 1, saltDetails: inspectSaltSystemDetails, onSuccess: { json in
            DispatchQueue.main.async {
                print("InspectionSaltSystemDetails json :: \(String(describing: json))")
                DispatchQueue.main.async(execute: {() -> Void in
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectClock") as! InspectClockVC
                        self.navigationController?.pushViewController(formVC, animated: true)
                    } else if UIDevice.current.userInterfaceIdiom == .pad {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectClock") as! InspectClockVC
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

extension InspectSaltSystemVC: UploadCollectionProtocol {
    func didTapOnCellItem(_indexpath: IndexPath, _imgUrl: String, _videoUrl: String) {
        
    }
    
    func didUpdateCellIndex(_indexpath: Int) {
        
    }
}

extension InspectSaltSystemVC: OpalImagePickerControllerDelegate {
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
                                self.arrImgSaltSystemMain.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataImgSaltMaintain = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 1 {
                                self.arrImgSaltSystem.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataImgSaltSystem = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 2 {
                                self.arrImgPurification.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataImgPurification = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 4 {
                                self.arrImgSaltCleaning.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataImgSelfCleaning = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            }
                            
                            if self.fetchIndexForSubSaltSystemUpload == 0 {
                                self.arrImgSaltMaintain.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataImgSaltMaintain = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubSaltSystemUpload == 1 {
                                self.arrImgSaltPowerBtn.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataImgSaltPowerBtn = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubSaltSystemUpload == 2 {
                                self.arrImgSaltWorking.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataImgSaltWorking = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubSaltSystemUpload == 3 {
                                self.arrImgSaltLeak.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataImgSaltLeak = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubSaltSystemUpload == 4 {
                                self.arrImgSaltCalcification.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataImgSaltCalcification = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            }
                            
                            if self.fetchIndexForSubSelfCleanUpload == 0 {
                                self.arrImgSelfFloorHead.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataImgSelfFloorHead = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubSelfCleanUpload == 1 {
                                self.arrImgSelfCondition.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataImgSelfCondition = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubSelfCleanUpload == 2 {
                                self.arrImgSaltHeadSync.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataImgSelfHeadSync = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubSelfCleanUpload == 3 {
                                self.arrImgSaltLatchingSafety.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataImgSelfLatchingSafety = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubSelfCleanUpload == 4 {
                                self.arrImgSaltControllerLeak.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataImgSelfControllerLeak = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
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
                self.tblSaltSystem.reloadData()
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

extension InspectSaltSystemVC: UIImagePickerControllerDelegate {
    // MARK:: UIImagePickerControllerDelegate
    //For xcode 10
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let possibleImage = info[.originalImage] as? UIImage
            else {
                fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
                //return
            }
        
        if self.fetchIndexForUpload == 0 {
            self.arrImgSaltSystemMain.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataImgSaltSystemMain = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForUpload == 1 {
            self.arrImgSaltSystem.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataImgSaltSystem = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForUpload == 2 {
            self.arrImgPurification.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataImgPurification = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForUpload == 4 {
            self.arrImgSaltCleaning.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataImgSelfCleaning = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        }
        
        if self.fetchIndexForSubSaltSystemUpload == 0 {
            self.arrImgSaltMaintain.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataImgSaltMaintain = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForSubSaltSystemUpload == 1 {
            self.arrImgSaltPowerBtn.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataImgSaltPowerBtn = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForSubSaltSystemUpload == 2 {
            self.arrImgSaltWorking.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataImgSaltWorking = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForSubSaltSystemUpload == 3 {
            self.arrImgSaltLeak.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataImgSaltLeak = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForSubSaltSystemUpload == 4 {
            self.arrImgSaltCalcification.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataImgSaltCalcification = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        }
        
        if self.fetchIndexForSubSelfCleanUpload == 0 {
            self.arrImgSelfFloorHead.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataImgSelfFloorHead = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForSubSelfCleanUpload == 1 {
            self.arrImgSelfCondition.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataImgSelfCondition = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForSubSelfCleanUpload == 2 {
            self.arrImgSaltHeadSync.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataImgSelfHeadSync = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForSubSelfCleanUpload == 3 {
            self.arrImgSaltLatchingSafety.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataImgSelfLatchingSafety = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForSubSelfCleanUpload == 4 {
            self.arrImgSaltControllerLeak.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataImgSelfControllerLeak = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        }
        
        self.tblSaltSystem.reloadData()
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
}

extension InspectSaltSystemVC: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        var cell = UITableViewCell()
        cell = (textView.superview?.superview as? UITableViewCell)!
        
        if let InspectionSaltSystemTableCell = cell as? InspectionSaltSystemTableCell {
            if textView == InspectionSaltSystemTableCell.txtSaltSystem {
                  self.secInspectSaltSystem[InspectSaltSystem.saltSystem.rawValue].formTextValue = (textView.text)!
           }
        } else if let InspectionWaterPurificationTableCell = cell as? InspectionWaterPurificationTableCell {
            if textView == InspectionWaterPurificationTableCell.txtWaterPurification {
                self.secInspectSaltSystem[InspectSaltSystem.purification.rawValue].formTextValue = (textView.text)!
            }
        } else if let InspectionSaltSelfCleaningTableCell = cell as? InspectionSaltSelfCleaningTableCell {
            if textView == InspectionSaltSelfCleaningTableCell.txtSaltSelfClean {
                  self.secInspectSaltSystem[InspectSaltSystem.selfClean.rawValue].formTextValue = (textView.text)!
            }
        }
        
        if let InspectionSaltSystemMaintainTableCell = cell as? InspectionSaltSystemMaintainTableCell {
            if textView == InspectionSaltSystemMaintainTableCell.txtSaltSystemMaintain {
                  self.secSaltSystem[SaltSystem.saltSystemMaintain.rawValue].formTextValue = (textView.text)!
            }
        } else if let InspectionSaltSystemPowerButtonTableCell = cell as? InspectionSaltSystemPowerButtonTableCell {
            if textView == InspectionSaltSystemPowerButtonTableCell.txtSaltPower {
                  self.secSaltSystem[SaltSystem.saltPower.rawValue].formTextValue = (textView.text)!
            }
        } else if let InspectionSaltSystemWorkingTableCell = cell as? InspectionSaltSystemWorkingTableCell {
            if textView == InspectionSaltSystemWorkingTableCell.txtSaltSystemWorking {
                  self.secSaltSystem[SaltSystem.saltSystemWorking.rawValue].formTextValue = (textView.text)!
            }
        } else if let InspectionSaltSystemVisibleLeakTableCell = cell as? InspectionSaltSystemVisibleLeakTableCell {
            if textView == InspectionSaltSystemVisibleLeakTableCell.txtSaltVisibleLeak {
                  self.secSaltSystem[SaltSystem.saltVisibleLeak.rawValue].formTextValue = (textView.text)!
            }
        } else if let InspectionSaltSystemCalcificationTableCell = cell as? InspectionSaltSystemCalcificationTableCell {
            if textView == InspectionSaltSystemCalcificationTableCell.txtSaltCalcification {
                self.secSaltSystem[SaltSystem.saltCalcification.rawValue].formTextValue = (textView.text)!
            }
        }
        
        if let InspectionSelfCleanFloorHeadTableCell = cell as? InspectionSelfCleanFloorHeadTableCell {
            if textView == InspectionSelfCleanFloorHeadTableCell.txtCleanFloorHead {
                self.secSaltSelfClean[SaltSelfClean.cleanFloorHead.rawValue].formTextValue = (textView.text)!
            }
        } else if let InspectionSelfCleanHeadConditionTableCell = cell as? InspectionSelfCleanHeadConditionTableCell {
            if textView == InspectionSelfCleanHeadConditionTableCell.txtCleanHeadCondition {
                  self.secSaltSelfClean[SaltSelfClean.cleanHeadCondition.rawValue].formTextValue = (textView.text)!
            }
        } else if let InspectionSelfCleanHeadSyncTableCell = cell as? InspectionSelfCleanHeadSyncTableCell {
            if textView == InspectionSelfCleanHeadSyncTableCell.txtCleanHeadSync {
                  self.secSaltSelfClean[SaltSelfClean.cleanHeadSync.rawValue].formTextValue = (textView.text)!
            }
        } else if let InspectionSelfCleanLatchingSafetyTableCell = cell as? InspectionSelfCleanLatchingSafetyTableCell {
            if textView == InspectionSelfCleanLatchingSafetyTableCell.txtCleanLatching {
                  self.secSaltSelfClean[SaltSelfClean.cleanLatching.rawValue].formTextValue = (textView.text)!
            }
        } else if let InspectionSelfCleanControllerLeakTableCell = cell as? InspectionSelfCleanControllerLeakTableCell {
            if textView == InspectionSelfCleanControllerLeakTableCell.txtCleanController {
                  self.secSaltSelfClean[SaltSelfClean.cleanController.rawValue].formTextValue = (textView.text)!
            }
        }
    }
}

extension InspectSaltSystemVC: UITableViewDataSource, UITableViewDelegate {
    //MARK:- UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 25 {
            return 5
        } else if tableView.tag == 35 {
            return 5
        } else {
            return 6
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 25 {
            if indexPath.row == 0 {
                let subSaltSystemCell = tableView.dequeueReusableCell(withIdentifier: "InspectionSaltSystemMaintainCell", for: indexPath) as! InspectionSaltSystemMaintainTableCell
                
                subSaltSystemCell.btnUpload.addTarget(self, action: #selector(btnSaltSystemImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                subSaltSystemCell.collectionvw.arrItems = arrImgSaltMaintain
                subSaltSystemCell.collectionvw.delegateItemCollection = self
                subSaltSystemCell.collectionvw.reloadImageCollection()
                
                if arrImgSaltMaintain.count > 0 {
                    subSaltSystemCell.btnUpload.isHidden = true
                    subSaltSystemCell.collectionvw.isHidden = false
                } else {
                    subSaltSystemCell.btnUpload.isHidden = false
                    subSaltSystemCell.collectionvw.isHidden = true
                }
                
                subSaltSystemCell.delegateSaltSystemMaintain = self
                subSaltSystemCell.txtSaltSystemMaintain.delegate = self
                
                return subSaltSystemCell
            } else if indexPath.row == 1 {
                let subSaltSystemCell = tableView.dequeueReusableCell(withIdentifier: "InspectionSaltSystemPowerButtonCell", for: indexPath) as! InspectionSaltSystemPowerButtonTableCell
                
                subSaltSystemCell.btnUpload.addTarget(self, action: #selector(btnSaltSystemImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                subSaltSystemCell.collectionvw.arrItems = arrImgSaltPowerBtn
                subSaltSystemCell.collectionvw.delegateItemCollection = self
                subSaltSystemCell.collectionvw.reloadImageCollection()
                
                if arrImgSaltPowerBtn.count > 0 {
                    subSaltSystemCell.btnUpload.isHidden = true
                    subSaltSystemCell.collectionvw.isHidden = false
                } else {
                    subSaltSystemCell.btnUpload.isHidden = false
                    subSaltSystemCell.collectionvw.isHidden = true
                }
                
                subSaltSystemCell.delegateSaltSystemPower = self
                subSaltSystemCell.txtSaltPower.delegate = self
                
                return subSaltSystemCell
            } else if indexPath.row == 2 {
                let subSaltSystemCell = tableView.dequeueReusableCell(withIdentifier: "InspectionSaltSystemWorkingCell", for: indexPath) as! InspectionSaltSystemWorkingTableCell
                
                subSaltSystemCell.btnUpload.addTarget(self, action: #selector(btnSaltSystemImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                subSaltSystemCell.collectionvw.arrItems = arrImgSaltWorking
                subSaltSystemCell.collectionvw.delegateItemCollection = self
                subSaltSystemCell.collectionvw.reloadImageCollection()
                
                if arrImgSaltWorking.count > 0 {
                    subSaltSystemCell.btnUpload.isHidden = true
                    subSaltSystemCell.collectionvw.isHidden = false
                } else {
                    subSaltSystemCell.btnUpload.isHidden = false
                    subSaltSystemCell.collectionvw.isHidden = true
                }
                
                subSaltSystemCell.delegateSaltSystemWorking = self
                subSaltSystemCell.txtSaltSystemWorking.delegate = self
                
                return subSaltSystemCell
            } else if indexPath.row == 3 {
                let subSaltSystemCell = tableView.dequeueReusableCell(withIdentifier: "InspectionSaltSystemVisibleLeakCell", for: indexPath) as! InspectionSaltSystemVisibleLeakTableCell
                
                subSaltSystemCell.btnUpload.addTarget(self, action: #selector(btnSaltSystemImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                subSaltSystemCell.collectionvw.arrItems = arrImgSaltLeak
                subSaltSystemCell.collectionvw.delegateItemCollection = self
                subSaltSystemCell.collectionvw.reloadImageCollection()
                
                if arrImgSaltLeak.count > 0 {
                    subSaltSystemCell.btnUpload.isHidden = true
                    subSaltSystemCell.collectionvw.isHidden = false
                } else {
                    subSaltSystemCell.btnUpload.isHidden = false
                    subSaltSystemCell.collectionvw.isHidden = true
                }
                
                subSaltSystemCell.delegateSaltSystemLeak = self
                subSaltSystemCell.txtSaltVisibleLeak.delegate =  self
                
                return subSaltSystemCell
            } else {//if indexPath.row == 4 {
                let subSaltSystemCell = tableView.dequeueReusableCell(withIdentifier: "InspectionSaltSystemCalcificationCell", for: indexPath) as! InspectionSaltSystemCalcificationTableCell
                
                subSaltSystemCell.btnUpload.addTarget(self, action: #selector(btnSaltSystemImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                subSaltSystemCell.collectionvw.arrItems = arrImgSaltCalcification
                subSaltSystemCell.collectionvw.delegateItemCollection = self
                subSaltSystemCell.collectionvw.reloadImageCollection()
                
                if arrImgSaltCalcification.count > 0 {
                    subSaltSystemCell.btnUpload.isHidden = true
                    subSaltSystemCell.collectionvw.isHidden = false
                } else {
                    subSaltSystemCell.btnUpload.isHidden = false
                    subSaltSystemCell.collectionvw.isHidden = true
                }
                
                subSaltSystemCell.delegateSaltSystemCalcification = self
                subSaltSystemCell.txtSaltCalcification.delegate = self
                
                return subSaltSystemCell
            }
         } else if tableView.tag == 35 {
            if indexPath.row == 0 {
                let subSelfCleanCell = tableView.dequeueReusableCell(withIdentifier: "InspectionSelfCleanFloorHeadCell", for: indexPath) as! InspectionSelfCleanFloorHeadTableCell
                
                subSelfCleanCell.btnUpload.addTarget(self, action: #selector(btnSelfCleanImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                subSelfCleanCell.collectionvw.arrItems = arrImgSelfFloorHead
                subSelfCleanCell.collectionvw.delegateItemCollection = self
                subSelfCleanCell.collectionvw.reloadImageCollection()
                
                if arrImgSelfFloorHead.count > 0 {
                    subSelfCleanCell.btnUpload.isHidden = true
                    subSelfCleanCell.collectionvw.isHidden = false
                } else {
                    subSelfCleanCell.btnUpload.isHidden = false
                    subSelfCleanCell.collectionvw.isHidden = true
                }
                
                subSelfCleanCell.delegateSaltSelfFloorHead = self
                subSelfCleanCell.txtCleanFloorHead.delegate = self
                
                return subSelfCleanCell
            } else if indexPath.row == 1 {
                let subSelfCleanCell = tableView.dequeueReusableCell(withIdentifier: "InspectionSelfCleanHeadConditionCell", for: indexPath) as! InspectionSelfCleanHeadConditionTableCell
                
                subSelfCleanCell.btnUpload.addTarget(self, action: #selector(btnSelfCleanImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                subSelfCleanCell.collectionvw.arrItems = arrImgSelfCondition
                subSelfCleanCell.collectionvw.delegateItemCollection = self
                subSelfCleanCell.collectionvw.reloadImageCollection()
                
                if arrImgSelfCondition.count > 0 {
                    subSelfCleanCell.btnUpload.isHidden = true
                    subSelfCleanCell.collectionvw.isHidden = false
                } else {
                    subSelfCleanCell.btnUpload.isHidden = false
                    subSelfCleanCell.collectionvw.isHidden = true
                }
                
                subSelfCleanCell.delegateSaltSelfCondition = self
                subSelfCleanCell.txtCleanHeadCondition.delegate = self
                
                return subSelfCleanCell
            } else if indexPath.row == 2 {
                let subSelfCleanCell = tableView.dequeueReusableCell(withIdentifier: "InspectionSelfCleanHeadSyncCell", for: indexPath) as! InspectionSelfCleanHeadSyncTableCell
                
                subSelfCleanCell.btnUpload.addTarget(self, action: #selector(btnSelfCleanImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                subSelfCleanCell.collectionvw.arrItems = arrImgSaltHeadSync
                subSelfCleanCell.collectionvw.delegateItemCollection = self
                subSelfCleanCell.collectionvw.reloadImageCollection()
                
                if arrImgSaltHeadSync.count > 0 {
                    subSelfCleanCell.btnUpload.isHidden = true
                    subSelfCleanCell.collectionvw.isHidden = false
                } else {
                    subSelfCleanCell.btnUpload.isHidden = false
                    subSelfCleanCell.collectionvw.isHidden = true
                }
                
                subSelfCleanCell.delegateSaltSelfHeadSync = self
                subSelfCleanCell.txtCleanHeadSync.delegate = self
                
                return subSelfCleanCell
            } else if indexPath.row == 3 {
                let subSelfCleanCell = tableView.dequeueReusableCell(withIdentifier: "InspectionSelfCleanLatchingSafetyCell", for: indexPath) as! InspectionSelfCleanLatchingSafetyTableCell
                
                subSelfCleanCell.btnUpload.addTarget(self, action: #selector(btnSelfCleanImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                subSelfCleanCell.collectionvw.arrItems = arrImgSaltLatchingSafety
                subSelfCleanCell.collectionvw.delegateItemCollection = self
                subSelfCleanCell.collectionvw.reloadImageCollection()
                
                if arrImgSaltLatchingSafety.count > 0 {
                    subSelfCleanCell.btnUpload.isHidden = true
                    subSelfCleanCell.collectionvw.isHidden = false
                } else {
                    subSelfCleanCell.btnUpload.isHidden = false
                    subSelfCleanCell.collectionvw.isHidden = true
                }
                
                subSelfCleanCell.delegateSaltSelfLatching = self
                subSelfCleanCell.txtCleanLatching.delegate = self
                
                return subSelfCleanCell
            } else {//if indexPath.row == 4 {
                let subSelfCleanCell = tableView.dequeueReusableCell(withIdentifier: "InspectionSelfCleanControllerLeakCell", for: indexPath) as! InspectionSelfCleanControllerLeakTableCell
                
                subSelfCleanCell.btnUpload.addTarget(self, action: #selector(btnSelfCleanImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                subSelfCleanCell.collectionvw.arrItems = arrImgSaltControllerLeak
                subSelfCleanCell.collectionvw.delegateItemCollection = self
                subSelfCleanCell.collectionvw.reloadImageCollection()
                
                if arrImgSaltControllerLeak.count > 0 {
                    subSelfCleanCell.btnUpload.isHidden = true
                    subSelfCleanCell.collectionvw.isHidden = false
                } else {
                    subSelfCleanCell.btnUpload.isHidden = false
                    subSelfCleanCell.collectionvw.isHidden = true
                }
                
                subSelfCleanCell.delegateSaltSelfLeak = self
                subSelfCleanCell.txtCleanController.delegate = self
                
                return subSelfCleanCell
            }
        } else {
            if indexPath.row == 0 {
                let cameraCell = tableView.dequeueReusableCell(withIdentifier: "CameraCell", for: indexPath) as! CameraTableCell
                
                cameraCell.lblHeader.text = "Salt System"
                if UIDevice.current.userInterfaceIdiom == .phone {
                    cameraCell.lblHeader.font = UIFont.init(name: "Roboto-bold", size: 16.0)
                } else {
                    cameraCell.lblHeader.font = UIFont.init(name: "Roboto-bold", size: 24.0)
                }
                cameraCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                cameraCell.collectionVw.arrItems = arrImgSaltSystemMain
                cameraCell.collectionVw.delegateItemCollection = self
                cameraCell.collectionVw.reloadImageCollection()
                
                if arrImgSaltSystemMain.count > 0 {
                    cameraCell.btnUpload.isHidden = true
                    cameraCell.collectionVw.isHidden = false
                } else {
                    cameraCell.btnUpload.isHidden = false
                    cameraCell.collectionVw.isHidden = true
                }
                
                return cameraCell
            } else if indexPath.row == 1 {
                let saltSystemCell = tableView.dequeueReusableCell(withIdentifier: "InspectionSaltSystemCell", for: indexPath) as! InspectionSaltSystemTableCell
                
                saltSystemCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                saltSystemCell.collectionvw.arrItems = arrImgSaltSystem
                saltSystemCell.collectionvw.delegateItemCollection = self
                saltSystemCell.collectionvw.reloadImageCollection()
                
                if arrImgSaltSystem.count > 0 {
                    saltSystemCell.btnUpload.isHidden = true
                    saltSystemCell.collectionvw.isHidden = false
                } else {
                    saltSystemCell.btnUpload.isHidden = false
                    saltSystemCell.collectionvw.isHidden = true
                }
                
                if strSaltSystemOption == "Yes" {
                    //Declare the outlet in our custom class
                    let tblSaltSystem = saltSystemCell.viewWithTag(25) as! UITableView
                    
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        saltSystemCell.tblSaltHtConstraint.constant = 345*5
                    } else {
                        saltSystemCell.tblSaltHtConstraint.constant = 600*5
                    }
                    tblSaltSystem.delegate = self
                    tblSaltSystem.dataSource = self
                    tblSaltSystem.reloadData()
                } else if strSaltSystemOption == "No" {
                    saltSystemCell.tblSaltHtConstraint.constant = 0
                }

                saltSystemCell.delegateSaltSystem = self
                saltSystemCell.txtSaltSystem.delegate = self
                
                return saltSystemCell
            } else if indexPath.row == 2 {
                let waterCell = tableView.dequeueReusableCell(withIdentifier: "InspectionWaterPurificationCell", for: indexPath) as! InspectionWaterPurificationTableCell
                
                waterCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                waterCell.collectionvw.arrItems = arrImgPurification
                waterCell.collectionvw.delegateItemCollection = self
                waterCell.collectionvw.reloadImageCollection()
                
                if arrImgPurification.count > 0 {
                    waterCell.btnUpload.isHidden = true
                    waterCell.collectionvw.isHidden = false
                } else {
                    waterCell.btnUpload.isHidden = false
                    waterCell.collectionvw.isHidden = true
                }
                
                waterCell.delegateWaterPurification = self
                waterCell.txtWaterPurification.delegate = self
                
                return waterCell
            } else if indexPath.row == 3 {
                let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as! HeaderTableCell
                
                headerCell.lblHeaderText.text = "Self Cleaning System"
                if UIDevice.current.userInterfaceIdiom == .phone {
                    headerCell.lblHeaderText.font = UIFont.init(name: "Roboto-bold", size: 16.0)
                } else {
                    headerCell.lblHeaderText.font = UIFont.init(name: "Roboto-bold", size: 24.0)
                }
                
                return headerCell
            } else if indexPath.row == 4 {
                let selfCleaningCell = tableView.dequeueReusableCell(withIdentifier: "InspectionSaltSelfCleaningCell", for: indexPath) as! InspectionSaltSelfCleaningTableCell
                
                selfCleaningCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                selfCleaningCell.collectionvw.arrItems = arrImgSaltCleaning
                selfCleaningCell.collectionvw.delegateItemCollection = self
                selfCleaningCell.collectionvw.reloadImageCollection()
                
                if arrImgSaltCleaning.count > 0 {
                    selfCleaningCell.btnUpload.isHidden = true
                    selfCleaningCell.collectionvw.isHidden = false
                } else {
                    selfCleaningCell.btnUpload.isHidden = false
                    selfCleaningCell.collectionvw.isHidden = true
                }
                
                if strSaltSelfCleanOption == "Yes" {
                    //Declare the outlet in our custom class
                    let tblSelfClean = selfCleaningCell.viewWithTag(35) as! UITableView
                    
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        selfCleaningCell.tblSelfCleanHeightConstraint.constant = 345*5
                    } else {
                        selfCleaningCell.tblSelfCleanHeightConstraint.constant = 600*5
                    }
                    tblSelfClean.delegate = self
                    tblSelfClean.dataSource = self
                    tblSelfClean.reloadData()
                } else if strSaltSelfCleanOption == "No" {
                    selfCleaningCell.tblSelfCleanHeightConstraint.constant = 0
                }
                
                selfCleaningCell.delegateSaltSelfClean = self
                selfCleaningCell.txtSaltSelfClean.delegate = self
                
                return selfCleaningCell
            } else {
                let cellBtn = tableView.dequeueReusableCell(withIdentifier: "NextCell", for: indexPath) as! NextForm1TableCell
                       
                cellBtn.btnNext.addTarget(self, action: #selector(btnNextDidTap), for: UIControl.Event.touchUpInside)
                return cellBtn
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .phone {
            if tableView.tag == 25 {
                return 340
           } else if tableView.tag == 35 {
                return 340
           } else if indexPath.row == 0 {
                return 185
           } else if indexPath.row == 1 {
                if strSaltSystemOption == "Yes" {
                    return 340+340*5
                } else {
                    return 340
                }
           } else if indexPath.row == 2 {
                return 340
           } else if indexPath.row == 3 {
                return 65
           } else if indexPath.row == 4 {
                if strSaltSelfCleanOption == "Yes" {
                    return 340+345*5
                } else {
                    return 340
                }
           } else {
                return 105
           }
       } else {         //.pad
            if tableView.tag == 25 {
                return 600
           } else if tableView.tag == 35 {
                return 600
           } else if indexPath.row == 0 {
                return 320
           } else if indexPath.row == 1 {
                if strSaltSystemOption == "Yes" {
                    return 615+600*5
                } else {
                    return 615
                }
           } else if indexPath.row == 2 {
                return 600
           } else if indexPath.row == 3 {
                return 65
           } else if indexPath.row == 4 {
                if strSaltSelfCleanOption == "Yes" {
                    return 615+600*5
                } else {
                    return 615
                }
           } else {
                return 175
           }
       }
    }
}

extension InspectSaltSystemVC: SaltSystemCellProtocol, SaltSystemMaintainCellProtocol, SaltSystemPowerCellProtocol, SaltSystemWorkingCellProtocol, SaltSystemLeakCellProtocol, SaltSystemCalcificationCellProtocol, WaterPurificationCellProtocol, SaltSelfCleanCellProtocol, SaltSelfConditionCellProtocol, SaltSelfHeadSyncCellProtocol, SaltSelfFloorHeadCellProtocol, SaltSelfLatchingCellProtocol, SaltSelfLeakCellProtocol {
    //MARK:- SaltSystem
    func didTapOnCellSaltSystem(_btnSaltSystemTag: Int) {
        if _btnSaltSystemTag == 0 {
            strSaltSystemOption = "Yes"
        }  else if _btnSaltSystemTag == 1 {
            strSaltSystemOption = "No"
        }
        self.tblSaltSystem.reloadData()
    }
    
    func didTapOnCellSaltSystemMaintain(_btnSaltSystemTag: Int) {
        if _btnSaltSystemTag == 0 {
            strOptSaltMaintain = "Yes"
        }  else if _btnSaltSystemTag == 1 {
            strOptSaltMaintain = "No"
        }
        self.tblSaltSystem.reloadData()
    }
    
    func didTapOnCellSaltSystemPower(_btnSaltSystemTag: Int) {
        if _btnSaltSystemTag == 0 {
            strOptSaltPowerBtn = "Yes"
        }  else if _btnSaltSystemTag == 1 {
            strOptSaltPowerBtn = "No"
        }
        self.tblSaltSystem.reloadData()
    }
    
    func didTapOnCellSaltSystemWorking(_btnSaltSystemTag: Int) {
        if _btnSaltSystemTag == 0 {
            strOptSaltWorking = "Yes"
        }  else if _btnSaltSystemTag == 1 {
            strOptSaltWorking = "No"
        }
        self.tblSaltSystem.reloadData()
    }
    
    func didTapOnCellSaltSystemLeak(_btnSaltSystemTag: Int) {
        if _btnSaltSystemTag == 0 {
            strOptSaltLeak = "Yes"
        }  else if _btnSaltSystemTag == 1 {
            strOptSaltLeak = "No"
        }
        self.tblSaltSystem.reloadData()
    }
    
    func didTapOnCellSaltSystemCalcification(_btnSaltSystemTag: Int) {
        if _btnSaltSystemTag == 0 {
            strOptSaltCalcification = "Yes"
        }  else if _btnSaltSystemTag == 1 {
            strOptSaltCalcification = "No"
        }
        self.tblSaltSystem.reloadData()
    }
    
    //MARK:- WaterPurification
    func didTapOnCellWaterPurification(_btnWaterPurificationTag: Int) {
        if _btnWaterPurificationTag == 0 {
           strWaterPurificationOption = "Yes"
        }  else if _btnWaterPurificationTag == 1 {
           strWaterPurificationOption = "No"
        }
        self.tblSaltSystem.reloadData()
    }
    
    func didTapOnCellSaltSelfCleaning(_btnSaltSelfCleaningTag: Int) {
        if _btnSaltSelfCleaningTag == 0 {
           strSaltSelfCleanOption = "Yes"
        }  else if _btnSaltSelfCleaningTag == 1 {
           strSaltSelfCleanOption = "No"
        }
        self.tblSaltSystem.reloadData()
    }
    
    func didTapOnCellSaltSelfCondition(_btnSaltSelfCleaningTag: Int) {
        if _btnSaltSelfCleaningTag == 0 {
           strOptSelfCondition = "Yes"
        }  else if _btnSaltSelfCleaningTag == 1 {
           strOptSelfCondition = "No"
        }
        self.tblSaltSystem.reloadData()
    }
    
    func didTapOnCellSaltSelfHeadSync(_btnSaltSelfCleaningTag: Int) {
        if _btnSaltSelfCleaningTag == 0 {
           strOptSelfHeadSync = "Yes"
        }  else if _btnSaltSelfCleaningTag == 1 {
           strOptSelfHeadSync = "No"
        }
        self.tblSaltSystem.reloadData()
    }
    
    func didTapOnCellSaltSelfFloorHead(_btnSaltSelfCleaningTag: Int) {
        if _btnSaltSelfCleaningTag == 0 {
           strOptSelfFloorHead = "Yes"
        }  else if _btnSaltSelfCleaningTag == 1 {
           strOptSelfFloorHead = "No"
        }
        self.tblSaltSystem.reloadData()
    }
    
    func didTapOnCellSaltSelfLatching(_btnSaltSelfCleaningTag: Int) {
        if _btnSaltSelfCleaningTag == 0 {
           strOptSelfLatchingSafety = "Yes"
        }  else if _btnSaltSelfCleaningTag == 1 {
           strOptSelfLatchingSafety = "No"
        }
        self.tblSaltSystem.reloadData()
    }
    
    func didTapOnCellSaltSelfLeak(_btnSaltSelfCleaningTag: Int) {
        if _btnSaltSelfCleaningTag == 0 {
           strOptSelfControllerLeak = "Yes"
        }  else if _btnSaltSelfCleaningTag == 1 {
           strOptSelfControllerLeak = "No"
        }
        self.tblSaltSystem.reloadData()
    }
    
    
}
