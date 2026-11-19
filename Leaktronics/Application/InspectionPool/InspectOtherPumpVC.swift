//
//  InspectOtherPumpVC.swift
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

class InspectOtherPumpVC: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var tblOtherPump: UITableView!
    
    var secInspectOtherPump = [formInspectionPoolData]()
    var secOtherPump = [formInspectionPoolData]()
    var secBlowers = [formInspectionPoolData]()
    
    enum InspectOtherPump: Int {
        case otherPump = 1
        case blowers = 3
    }
    
    enum OtherPump: Int {
        case otherPumpTypes = 0
        case pumpOperating = 1
        case pumpMaintenance = 2
        case pumpRightSize = 3
        case pumpMounted = 4
        case pumpVisibleLeak = 5
        case pumpGaskets = 6
        case plumbingPumpPresent = 7
        case equipmentRun = 8
    }
    
    enum Blowers: Int {
        case blowerRepair = 0
        case blowerBonding = 1
        case blowerAdequateSize = 2
        case blowerMounted = 3
        case blowerStrapped = 4
        case blowerValve = 5
        case blowerQuiet = 6
    }
    
    var fetchIndexForUpload: Int = -1
    var fetchIndexForSubOtherPumpUpload: Int = -1
    var fetchIndexForSubBlowerUpload: Int = -1
    
    var imagePicker = UIImagePickerController()
    var picker:UIImagePickerController? = UIImagePickerController()
    
    
    //For Images
    var arrImgOtherPumpMain: [CollectionImageObject] = []
    var arrImgOtherPump: [CollectionImageObject] = []
    var arrImgBlowersMain: [CollectionImageObject] = []
    var arrImgBlowers: [CollectionImageObject] = []
    
    var arrImgOtherPumpOperating: [CollectionImageObject] = []
    var arrImgOtherPumpMaintaince: [CollectionImageObject] = []
    var arrImgOtherPumpRightSize: [CollectionImageObject] = []
    var arrImgOtherPumpMounted: [CollectionImageObject] = []
    var arrImgOtherPumpVisibleLeak: [CollectionImageObject] = []
    var arrImgOtherPumpGaskets: [CollectionImageObject] = []
    var arrImgOtherPumpPlumbing: [CollectionImageObject] = []
    var arrImgOtherPumpEquipment: [CollectionImageObject] = []
    
    var arrImgBlowerRepair: [CollectionImageObject] = []
    var arrImgBlowerBonding: [CollectionImageObject] = []
    var arrImgBlowerAdequateSize: [CollectionImageObject] = []
    var arrImgBlowerMounted: [CollectionImageObject] = []
    var arrImgBlowerStrapped: [CollectionImageObject] = []
    var arrImgBlowerValve: [CollectionImageObject] = []
    var arrImgBlowerQuiet: [CollectionImageObject] = []
    
    //For Image Server path
    var strImgOtherPumpMain = String()
    var strImgOtherPump = String()
    var strImgBlowerMain = String()
    var strImgBlower = String()
    
    var strOtherPumpOperatingImg = String()
    var strOtherPumpMaintainceImg = String()
    var strOtherPumpRightSizeImg = String()
    var strOtherPumpMountedImg = String()
    var strOtherPumpVisibleLeakImg = String()
    var strOtherPumpGasketsImg = String()
    var strOtherPumpPlumbingImg = String()
    var strOtherPumpEquipmentImg = String()
    
    var strBlowerRepairImg = String()
    var strBlowerBondingImg = String()
    var strBlowerAdequateSizeImg = String()
    var strBlowerMountedImg = String()
    var strBlowerStrappedImg = String()
    var strBlowerValveImg = String()
    var strBlowerQuietImg = String()
    
    
    //For Image CoreData
    var dataImgOtherPumpMain = NSData()
    var dataImgOtherPump = NSData()
    var dataImgBlowerMain = NSData()
    var dataImgBlower = NSData()
    
    var dataOtherPumpOperatingImg = NSData()
    var dataOtherPumpMaintainceImg = NSData()
    var dataOtherPumpRightSizeImg = NSData()
    var dataOtherPumpMountedImg = NSData()
    var dataOtherPumpVisibleLeakImg = NSData()
    var dataOtherPumpGasketsImg = NSData()
    var dataOtherPumpPlumbingImg = NSData()
    var dataOtherPumpEquipmentImg = NSData()
    
    var dataBlowerRepairImg = NSData()
    var dataBlowerBondingImg = NSData()
    var dataBlowerAdequateSizeImg = NSData()
    var dataBlowerMountedImg = NSData()
    var dataBlowerStrappedImg = NSData()
    var dataBlowerValveImg = NSData()
    var dataBlowerQuietImg = NSData()
    
    
    //For Optional Value
    var strOtherPumpOption = String()
    var strBlowersOption = String()
    
    var strOptOtherPumpOperating = String()
    var strOptOtherPumpMaintaince = String()
    var strOptOtherPumpRightSize = String()
    var strOptOtherPumpMounted = String()
    var strOptOtherPumpVisibleLeak = String()
    var strOptOtherPumpGaskets = String()
    var strOptOtherPumpPlumbing = String()
    var strOptOtherPumpEquipment = String()
    
    var strOptBlowerRepair = String()
    var strOptBlowerBonding = String()
    var strOptBlowerAdequateSize = String()
    var strOptBlowerMounted = String()
    var strOptBlowerStrapped = String()
    var strOptBlowerValve = String()
    var strOptBlowerQuiet = String()
    
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.prepareFormOtherPumpData()
    }
    
    func prepareFormOtherPumpData() {
        for _ in 0..<4 {
            let obj = formInspectionPoolData()
            self.secInspectOtherPump.append(obj)
        }
        for _ in 0..<9 {
            let obj = formInspectionPoolData()
            self.secOtherPump.append(obj)
        }
        for _ in 0..<7 {
            let obj = formInspectionPoolData()
            self.secBlowers.append(obj)
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
        let indexOfCell = self.tblOtherPump.indexPath(for: cell)
        print("Clicked Index : \(String(describing: indexOfCell?.row))")
        
        fetchIndexForSubOtherPumpUpload = -1
        fetchIndexForSubBlowerUpload = -1
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
    
    @objc func btnOtherPumpImgUpload(_ sender: Any) {
        print("Button pressed 👍 ")
        let btn = sender as! UIButton
        let cell = btn.superview?.superview?.superview as! UITableViewCell
        let tblSubSwim = self.view.viewWithTag(25) as! UITableView
        let indexOfCell = tblSubSwim.indexPath(for: cell)
        print("Clicked Index : \(String(describing: indexOfCell?.row))")
        fetchIndexForUpload = -1
        fetchIndexForSubOtherPumpUpload = (indexOfCell?.row)!
        
        print("Upload Index : \(String(describing: fetchIndexForSubOtherPumpUpload))")
        
        self.actionSheetPopUpForGalleryOpen()
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc func btnBlowerImgUpload(_ sender: Any) {
        print("Button pressed 👍 ")
        let btn = sender as! UIButton
        let cell = btn.superview?.superview?.superview as! UITableViewCell
        let tblSubSwim = self.view.viewWithTag(35) as! UITableView
        let indexOfCell = tblSubSwim.indexPath(for: cell)
        print("Clicked Index : \(String(describing: indexOfCell?.row))")
        fetchIndexForUpload = -1
        fetchIndexForSubBlowerUpload = (indexOfCell?.row)!
        
        print("Upload Index : \(String(describing: fetchIndexForSubBlowerUpload))")
        
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
        //self.postInspectOtherPump()
        if UIDevice.current.userInterfaceIdiom == .phone {
            let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
            let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectValves") as! InspectValvesVC
            self.navigationController?.pushViewController(formVC, animated: true)
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
            let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectValves") as! InspectValvesVC
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
                    
                    managedObject.setValue(dataImgOtherPumpMain, forKey: "otherPumpMainImage")
                    managedObject.setValue(strOtherPumpOption, forKey: "otherPumpOption")
                    managedObject.setValue(dataImgOtherPump, forKey: "otherPumpImage")
                    managedObject.setValue(self.secInspectOtherPump[InspectOtherPump.otherPump.rawValue].formTextValue, forKey: "otherPumpData")
                    managedObject.setValue(dataImgBlowerMain, forKey: "blowersMainImage")
                    managedObject.setValue(strBlowersOption, forKey: "blowersOption")
                    managedObject.setValue(dataImgBlower, forKey: "blowersImage")
                    managedObject.setValue(self.secInspectOtherPump[InspectOtherPump.blowers.rawValue].formTextValue, forKey: "blowersData")
                    managedObject.setValue(self.secOtherPump[OtherPump.otherPumpTypes.rawValue].formTextValue, forKey: "otherPumpTypesData")
                    managedObject.setValue(strOptOtherPumpOperating, forKey: "otherPumpOperatingOption")
                    managedObject.setValue(dataOtherPumpOperatingImg, forKey: "otherPumpOperatingImage")
                    managedObject.setValue(self.secOtherPump[OtherPump.pumpOperating.rawValue].formTextValue, forKey: "otherPumpOperatingData")
                    managedObject.setValue(strOptOtherPumpMaintaince, forKey: "otherPumpMaintainceOption")
                    managedObject.setValue(dataOtherPumpMaintainceImg, forKey: "otherPumpMaintainceImage")
                    managedObject.setValue(self.secOtherPump[OtherPump.pumpMaintenance.rawValue].formTextValue, forKey: "otherPumpMaintainceData")
                    managedObject.setValue(strOptOtherPumpRightSize, forKey: "otherPumpRightSizeOption")
                    managedObject.setValue(dataOtherPumpRightSizeImg, forKey: "otherPumpRightSizeImage")
                    managedObject.setValue(self.secOtherPump[OtherPump.pumpRightSize.rawValue].formTextValue, forKey: "otherPumpRightSizeData")
                    managedObject.setValue(strOptOtherPumpMounted, forKey: "otherPumpMountedOption")
                    managedObject.setValue(dataOtherPumpMountedImg, forKey: "otherPumpMountedImage")
                    managedObject.setValue(self.secOtherPump[OtherPump.pumpMounted.rawValue].formTextValue, forKey: "otherPumpMountedData")
                    managedObject.setValue(strOptOtherPumpVisibleLeak, forKey: "otherPumpVisibleLeakOption")
                    managedObject.setValue(dataOtherPumpVisibleLeakImg, forKey: "otherPumpVisibleLeakImage")
                    managedObject.setValue(self.secOtherPump[OtherPump.pumpVisibleLeak.rawValue].formTextValue, forKey: "otherPumpVisibleLeakData")
                    managedObject.setValue(strOptOtherPumpGaskets, forKey: "otherPumpGasketsOption")
                    managedObject.setValue(dataOtherPumpGasketsImg, forKey: "otherPumpGasketsImage")
                    managedObject.setValue(self.secOtherPump[OtherPump.pumpGaskets.rawValue].formTextValue, forKey: "otherPumpGasketsData")
                    managedObject.setValue(strOptOtherPumpPlumbing, forKey: "otherPumpPlumbingOption")
                    managedObject.setValue(dataOtherPumpPlumbingImg, forKey: "otherPumpPlumbingImage")
                    managedObject.setValue(self.secOtherPump[OtherPump.plumbingPumpPresent.rawValue].formTextValue, forKey: "otherPumpPlumbingData")
                    managedObject.setValue(strOptOtherPumpEquipment, forKey: "otherPumpEquipmentOption")
                    managedObject.setValue(dataOtherPumpEquipmentImg, forKey: "otherPumpEquipmentImage")
                    managedObject.setValue(self.secOtherPump[OtherPump.equipmentRun.rawValue].formTextValue, forKey: "otherPumpEquipmentData")
                    managedObject.setValue(strOptBlowerRepair, forKey: "blowerRepairOption")
                    managedObject.setValue(dataBlowerRepairImg, forKey: "blowerRepairImage")
                    managedObject.setValue(self.secBlowers[Blowers.blowerRepair.rawValue].formTextValue, forKey: "blowerRepairData")
                    managedObject.setValue(strOptBlowerBonding, forKey: "blowerBondingOption")
                    managedObject.setValue(dataBlowerBondingImg, forKey: "blowerBondingImage")
                    managedObject.setValue(self.secBlowers[Blowers.blowerBonding.rawValue].formTextValue, forKey: "blowerBondingData")
                    managedObject.setValue(strOptBlowerAdequateSize, forKey: "blowerAdequateSizeOption")
                    managedObject.setValue(dataBlowerAdequateSizeImg, forKey: "blowerAdequateSizeImage")
                    managedObject.setValue(self.secBlowers[Blowers.blowerAdequateSize.rawValue].formTextValue, forKey: "blowerAdequateSizeData")
                    managedObject.setValue(strOptBlowerMounted, forKey: "blowerMountedOption")
                    managedObject.setValue(dataBlowerMountedImg, forKey: "blowerMountedImage")
                    managedObject.setValue(self.secBlowers[Blowers.blowerMounted.rawValue].formTextValue, forKey: "blowerMountedData")
                    managedObject.setValue(strOptBlowerStrapped, forKey: "blowerStrappedOption")
                    managedObject.setValue(dataBlowerStrappedImg, forKey: "blowerStrappedImage")
                    managedObject.setValue(self.secBlowers[Blowers.blowerStrapped.rawValue].formTextValue, forKey: "blowerStrappedData")
                    managedObject.setValue(strOptBlowerValve, forKey: "blowerValveOption")
                    managedObject.setValue(dataBlowerValveImg, forKey: "blowerValveImage")
                    managedObject.setValue(self.secBlowers[Blowers.blowerValve.rawValue].formTextValue, forKey: "blowerValveData")
                    managedObject.setValue(strOptBlowerQuiet, forKey: "blowerQuietOption")
                    managedObject.setValue(dataBlowerQuietImg, forKey: "blowerQuietImage")
                    managedObject.setValue(self.secBlowers[Blowers.blowerQuiet.rawValue].formTextValue, forKey: "blowerQuietData")
                    
                    
                    
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
                        print("Data of InspectOtherPumpVC:: \(data)")
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
                        self.strImgOtherPumpMain = String(describing: data!)
                    } else if self.fetchIndexForUpload == 1 {
                        self.strImgOtherPump = String(describing: data!)
                    } else if self.fetchIndexForUpload == 2 {
                        self.strImgBlowerMain = String(describing: data!)
                    } else if self.fetchIndexForUpload == 3 {
                        self.strImgBlower = String(describing: data!)
                    }
                    
                    if self.fetchIndexForSubOtherPumpUpload == 1 {
                        self.strOtherPumpOperatingImg = String(describing: data!)
                    } else if self.fetchIndexForSubOtherPumpUpload == 2 {
                        self.strOtherPumpMaintainceImg = String(describing: data!)
                    } else if self.fetchIndexForSubOtherPumpUpload == 3 {
                        self.strOtherPumpRightSizeImg = String(describing: data!)
                    } else if self.fetchIndexForSubOtherPumpUpload == 4 {
                        self.strOtherPumpMountedImg = String(describing: data!)
                    } else if self.fetchIndexForSubOtherPumpUpload == 5 {
                        self.strOtherPumpVisibleLeakImg = String(describing: data!)
                    } else if self.fetchIndexForSubOtherPumpUpload == 6 {
                        self.strOtherPumpGasketsImg = String(describing: data!)
                    } else if self.fetchIndexForSubOtherPumpUpload == 7 {
                        self.strOtherPumpPlumbingImg = String(describing: data!)
                    } else if self.fetchIndexForSubOtherPumpUpload == 8 {
                        self.strOtherPumpEquipmentImg = String(describing: data!)
                    }
                    
                    if self.fetchIndexForSubBlowerUpload == 0 {
                        self.strBlowerRepairImg = String(describing: data!)
                    } else if self.fetchIndexForSubBlowerUpload == 1 {
                        self.strBlowerBondingImg = String(describing: data!)
                    } else if self.fetchIndexForSubBlowerUpload == 2 {
                        self.strBlowerAdequateSizeImg = String(describing: data!)
                    } else if self.fetchIndexForSubBlowerUpload == 3 {
                        self.strBlowerMountedImg = String(describing: data!)
                    } else if self.fetchIndexForSubBlowerUpload == 4 {
                        self.strBlowerStrappedImg = String(describing: data!)
                    } else if self.fetchIndexForSubBlowerUpload == 5 {
                        self.strBlowerValveImg = String(describing: data!)
                    } else if self.fetchIndexForSubBlowerUpload == 6 {
                        self.strBlowerQuietImg = String(describing: data!)
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
    
    func postInspectOtherPump() {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        
        let return_id = UserDefaults.standard.value(forKey: "returnKeyForInspection")
        
        let inspectOtherPumpDetails:  NSMutableDictionary = [
            "return_data_id"            :return_id!,
            "otherPumpMainImage"        : strImgOtherPumpMain,
            "otherPumpOption"           : strOtherPumpOption,
            "otherPumpImage"            : strImgOtherPump,
            "otherPumpData"             : self.secInspectOtherPump[InspectOtherPump.otherPump.rawValue].formTextValue,
            "blowersMainImage"          : strImgBlowerMain,
            "blowersOption"             : strBlowersOption,
            "blowersImage"              : strImgBlower,
            "blowersData"               : self.secInspectOtherPump[InspectOtherPump.blowers.rawValue].formTextValue,
            "otherPumpTypesData"        : self.secOtherPump[OtherPump.otherPumpTypes.rawValue].formTextValue,
            "otherPumpOperatingOption"  : strOptOtherPumpOperating,
            "otherPumpOperatingImage"   : strOtherPumpOperatingImg,
            "otherPumpOperatingData"    : self.secOtherPump[OtherPump.pumpOperating.rawValue].formTextValue,
            "otherPumpMaintainceOption" : strOptOtherPumpMaintaince,
            "otherPumpMaintainceImage"  : strOtherPumpMaintainceImg,
            "otherPumpMaintainceData"   : self.secOtherPump[OtherPump.pumpMaintenance.rawValue].formTextValue,
            "otherPumpRightSizeOption"  : strOptOtherPumpRightSize,
            "otherPumpRightSizeImage"   : strOtherPumpRightSizeImg,
            "otherPumpRightSizeData"    : self.secOtherPump[OtherPump.pumpRightSize.rawValue].formTextValue,
            "otherPumpMountedOption"    : strOptOtherPumpMounted,
            "otherPumpMountedImage"     : strOtherPumpMountedImg,
            "otherPumpMountedData"      : self.secOtherPump[OtherPump.pumpMounted.rawValue].formTextValue,
            "otherPumpVisibleLeakOption": strOptOtherPumpVisibleLeak,
            "otherPumpVisibleLeakImage" : strOtherPumpVisibleLeakImg,
            "otherPumpVisibleLeakData"  : self.secOtherPump[OtherPump.pumpVisibleLeak.rawValue].formTextValue,
            "otherPumpGasketsOption"    : strOptOtherPumpGaskets,
            "otherPumpGasketsImage"     : strOtherPumpGasketsImg,
            "otherPumpGasketsData"      : self.secOtherPump[OtherPump.pumpGaskets.rawValue].formTextValue,
            "otherPumpPlumbingOption"   : strOptOtherPumpPlumbing,
            "otherPumpPlumbingImage"    : strOtherPumpPlumbingImg,
            "otherPumpPlumbingData"     : self.secOtherPump[OtherPump.plumbingPumpPresent.rawValue].formTextValue,
            "otherPumpEquipmentOption"  : strOptOtherPumpEquipment,
            "otherPumpEquipmentImage"   : strOtherPumpEquipmentImg,
            "otherPumpEquipmentData"    : self.secOtherPump[OtherPump.equipmentRun.rawValue].formTextValue,
            "blowerRepairOption"        : strOptBlowerRepair,
            "blowerRepairImage"         : strBlowerRepairImg,
            "blowerRepairData"          : self.secBlowers[Blowers.blowerRepair.rawValue].formTextValue,
            "blowerBondingOption"       : strOptBlowerBonding,
            "blowerBondingImage"        : strBlowerBondingImg,
            "blowerBondingData"         : self.secBlowers[Blowers.blowerBonding.rawValue].formTextValue,
            "blowerAdequateSizeOption"  : strOptBlowerAdequateSize,
            "blowerAdequateSizeImage"   : strBlowerAdequateSizeImg,
            "blowerAdequateSizeData"    : self.secBlowers[Blowers.blowerAdequateSize.rawValue].formTextValue,
            "blowerMountedOption"       : strOptBlowerMounted,
            "blowerMountedImage"        : strBlowerMountedImg,
            "blowerMountedData"         : self.secBlowers[Blowers.blowerMounted.rawValue].formTextValue,
            "blowerStrappedOption"      : strOptBlowerStrapped,
            "blowerStrappedImage"       : strBlowerStrappedImg,
            "blowerStrappedData"        : self.secBlowers[Blowers.blowerStrapped.rawValue].formTextValue,
            "blowerValveOption"         : strOptBlowerValve,
            "blowerValveImage"          : strBlowerValveImg,
            "blowerValveData"           : self.secBlowers[Blowers.blowerValve.rawValue].formTextValue,
            "blowerQuietOption"         : strOptBlowerQuiet,
            "blowerQuietImage"          : strBlowerQuietImg,
            "blowerQuietData"           : self.secBlowers[Blowers.blowerQuiet.rawValue].formTextValue,
        ]
        
        print("inspectOtherPumpDetails :: \(inspectOtherPumpDetails)")
        //if sharedExtension.connectedToNetwork() {
        ApiManager.sharedInstanceAPI.PostInspectOtherPump(postId: 1, pumpDetails: inspectOtherPumpDetails, onSuccess: { json in
            DispatchQueue.main.async {
                print("InspectionOtherPumpDetails json :: \(String(describing: json))")
                DispatchQueue.main.async(execute: {() -> Void in
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectValves") as! InspectValvesVC
                        self.navigationController?.pushViewController(formVC, animated: true)
                    } else if UIDevice.current.userInterfaceIdiom == .pad {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectValves") as! InspectValvesVC
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

extension InspectOtherPumpVC: UploadCollectionProtocol {
    func didTapOnCellItem(_indexpath: IndexPath, _imgUrl: String, _videoUrl: String) {
        
    }
    
    func didUpdateCellIndex(_indexpath: Int) {
        
    }
}

extension InspectOtherPumpVC: OpalImagePickerControllerDelegate {
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
                                self.arrImgOtherPumpMain.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataImgOtherPumpMain = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 1 {
                                self.arrImgOtherPump.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataImgOtherPump = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 2 {
                                self.arrImgBlowersMain.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataImgBlowerMain = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 3 {
                                self.arrImgBlowers.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataImgBlower = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            }
                            
                            if self.fetchIndexForSubOtherPumpUpload == 1 {
                                self.arrImgOtherPumpOperating.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataOtherPumpOperatingImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubOtherPumpUpload == 2 {
                                self.arrImgOtherPumpMaintaince.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataOtherPumpMaintainceImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubOtherPumpUpload == 3 {
                                self.arrImgOtherPumpRightSize.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataOtherPumpRightSizeImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubOtherPumpUpload == 4 {
                                self.arrImgOtherPumpMounted.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataOtherPumpMountedImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubOtherPumpUpload == 5 {
                                self.arrImgOtherPumpVisibleLeak.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataOtherPumpVisibleLeakImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubOtherPumpUpload == 6 {
                                self.arrImgOtherPumpGaskets.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataOtherPumpGasketsImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubOtherPumpUpload == 7 {
                                self.arrImgOtherPumpPlumbing.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataOtherPumpPlumbingImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubOtherPumpUpload == 8 {
                                self.arrImgOtherPumpEquipment.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataOtherPumpEquipmentImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            }
                            
                            if self.fetchIndexForSubBlowerUpload == 0 {
                                self.arrImgBlowerRepair.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataBlowerRepairImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubBlowerUpload == 1 {
                                self.arrImgBlowerBonding.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataBlowerBondingImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubBlowerUpload == 2 {
                                self.arrImgBlowerAdequateSize.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataBlowerAdequateSizeImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubBlowerUpload == 3 {
                                self.arrImgBlowerMounted.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataBlowerMountedImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubBlowerUpload == 4 {
                                self.arrImgBlowerStrapped.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataBlowerStrappedImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubBlowerUpload == 5 {
                                self.arrImgBlowerValve.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataBlowerValveImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubBlowerUpload == 6 {
                                self.arrImgBlowerQuiet.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataBlowerQuietImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
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
                self.tblOtherPump.reloadData()
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

extension InspectOtherPumpVC: UIImagePickerControllerDelegate {
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
            self.arrImgOtherPumpMain.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataImgOtherPumpMain = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForUpload == 1 {
            self.arrImgOtherPump.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataImgOtherPump = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForUpload == 2 {
            self.arrImgBlowersMain.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataImgBlowerMain = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForUpload == 3 {
            self.arrImgBlowers.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataImgBlower = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        }
        
        if fetchIndexForSubOtherPumpUpload == 1 {
            self.arrImgOtherPumpOperating.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataOtherPumpOperatingImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubOtherPumpUpload == 2 {
            self.arrImgOtherPumpMaintaince.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataOtherPumpMaintainceImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubOtherPumpUpload == 3 {
            self.arrImgOtherPumpRightSize.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataOtherPumpRightSizeImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubOtherPumpUpload == 4 {
            self.arrImgOtherPumpMounted.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataOtherPumpMountedImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubOtherPumpUpload == 5 {
            self.arrImgOtherPumpVisibleLeak.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataOtherPumpVisibleLeakImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubOtherPumpUpload == 6 {
            self.arrImgOtherPumpGaskets.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataOtherPumpGasketsImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubOtherPumpUpload == 7 {
            self.arrImgOtherPumpPlumbing.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataOtherPumpPlumbingImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubOtherPumpUpload == 8 {
            self.arrImgOtherPumpEquipment.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataOtherPumpEquipmentImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        }
        
        if fetchIndexForSubBlowerUpload == 0 {
            self.arrImgBlowerRepair.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataBlowerRepairImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubBlowerUpload == 1 {
            self.arrImgBlowerBonding.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataBlowerBondingImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubBlowerUpload == 2 {
            self.arrImgBlowerAdequateSize.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataBlowerAdequateSizeImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubBlowerUpload == 3 {
            self.arrImgBlowerMounted.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataBlowerMountedImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubBlowerUpload == 4 {
            self.arrImgBlowerStrapped.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataBlowerStrappedImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubBlowerUpload == 5 {
            self.arrImgBlowerValve.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataBlowerValveImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubBlowerUpload == 6 {
            self.arrImgBlowerQuiet.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataBlowerQuietImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        }
        
        self.tblOtherPump.reloadData()
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
}

extension InspectOtherPumpVC: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        var cell = UITableViewCell()
        cell = (textView.superview?.superview as? UITableViewCell)!
            
        if let InspectionOtherPumpTableCell = cell as? InspectionOtherPumpTableCell {
            if textView == InspectionOtherPumpTableCell.txtOtherPumps {
                self.secInspectOtherPump[InspectOtherPump.otherPump.rawValue].formTextValue = (textView.text)!
           }
        } else if let InspectionOtherPumpBlowerTableCell = cell as? InspectionOtherPumpBlowerTableCell {
            if textView == InspectionOtherPumpBlowerTableCell.txtOtherPumpsBlower {
                self.secInspectOtherPump[InspectOtherPump.blowers.rawValue].formTextValue = (textView.text)!
            }
        }
        
        if let InspectionOtherPumpTypesTableCell = cell as? InspectionOtherPumpTypesTableCell {
            if textView == InspectionOtherPumpTypesTableCell.txtOtherPumpTypes {
                self.secOtherPump[OtherPump.otherPumpTypes.rawValue].formTextValue = (textView.text)!
            }
        } else if let InspectionOtherPumpOperatingTableCell = cell as? InspectionOtherPumpOperatingTableCell {
            if textView == InspectionOtherPumpOperatingTableCell.txtPumpOperating {
                self.secOtherPump[OtherPump.pumpOperating.rawValue].formTextValue = (textView.text)!
            }
        } else if let InspectionOtherPumpMaintainanceAccessTableCell = cell as? InspectionOtherPumpMaintainanceAccessTableCell {
            if textView == InspectionOtherPumpMaintainanceAccessTableCell.txtPumpMaintenance {
                self.secOtherPump[OtherPump.pumpMaintenance.rawValue].formTextValue = (textView.text)!
            }
        } else if let InspectionOtherPumpRightSizeTableCell = cell as? InspectionOtherPumpRightSizeTableCell {
            if textView == InspectionOtherPumpRightSizeTableCell.txtPumpRightSize {
                self.secOtherPump[OtherPump.pumpRightSize.rawValue].formTextValue = (textView.text)!
            }
        } else if let InspectionOtherPumpMountedTableCell = cell as? InspectionOtherPumpMountedTableCell {
            if textView == InspectionOtherPumpMountedTableCell.txtPumpMounted {
                self.secOtherPump[OtherPump.pumpMounted.rawValue].formTextValue = (textView.text)!
            }
        } else if let InspectionOtherPumpVisibleLeakTableCell = cell as? InspectionOtherPumpVisibleLeakTableCell {
            if textView == InspectionOtherPumpVisibleLeakTableCell.txtPumpVisibleLeak {
                self.secOtherPump[OtherPump.pumpVisibleLeak.rawValue].formTextValue = (textView.text)!
            }
        } else if let InspectionOtherPumpGasketsTableCell = cell as? InspectionOtherPumpGasketsTableCell {
            if textView == InspectionOtherPumpGasketsTableCell.txtPumpGaskets {
                self.secOtherPump[OtherPump.pumpGaskets.rawValue].formTextValue = (textView.text)!
            }
        } else if let InspectionOtherPumpPlumbingPresentTableCell = cell as? InspectionOtherPumpPlumbingPresentTableCell {
            if textView == InspectionOtherPumpPlumbingPresentTableCell.txtPlumbingPresent {
                self.secOtherPump[OtherPump.plumbingPumpPresent.rawValue].formTextValue = (textView.text)!
            }
        } else if let InspectionOtherPumpEquipmentRunTableCell = cell as? InspectionOtherPumpEquipmentRunTableCell {
            if textView == InspectionOtherPumpEquipmentRunTableCell.txtEquipmentRun {
                self.secOtherPump[OtherPump.equipmentRun.rawValue].formTextValue = (textView.text)!
            }
        }
        
        if let InspectionOtherPumpBlowerRepairTableCell = cell as? InspectionOtherPumpBlowerRepairTableCell {
           if textView == InspectionOtherPumpBlowerRepairTableCell.txtBlowerRepair {
                 self.secBlowers  [Blowers.blowerRepair.rawValue].formTextValue = (textView.text)!
           }
        } else if let InspectionOtherPumpBlowerBondingTableCell = cell as? InspectionOtherPumpBlowerBondingTableCell {
            if textView == InspectionOtherPumpBlowerBondingTableCell.txtBlowerBonding {
                self.secBlowers[Blowers.blowerBonding.rawValue].formTextValue = (textView.text)!
            }
        } else if let InspectionOtherPumpBlowerAdequateSizeTableCell = cell as? InspectionOtherPumpBlowerAdequateSizeTableCell {
            if textView == InspectionOtherPumpBlowerAdequateSizeTableCell.txtBlowerAdequateSize {
                self.secBlowers[Blowers.blowerAdequateSize.rawValue].formTextValue = (textView.text)!
            }
        } else if let InspectionOtherPumpBlowerMountedTableCell = cell as? InspectionOtherPumpBlowerMountedTableCell {
            if textView == InspectionOtherPumpBlowerMountedTableCell.txtBlowerMounted {
                self.secBlowers[Blowers.blowerMounted.rawValue].formTextValue = (textView.text)!
            }
        } else if let InspectionOtherPumpBlowerStrappedTableCell = cell as? InspectionOtherPumpBlowerStrappedTableCell {
            if textView == InspectionOtherPumpBlowerStrappedTableCell.txtBlowerStrapped {
                self.secBlowers[Blowers.blowerStrapped .rawValue].formTextValue = (textView.text)!
            }
        } else if let InspectionOtherPumpBlowerValveTableCell = cell as? InspectionOtherPumpBlowerValveTableCell {
            if textView == InspectionOtherPumpBlowerValveTableCell.txtBlowerValve {
                self.secBlowers[Blowers.blowerValve.rawValue].formTextValue = (textView.text)!
            }
        } else if let InspectionOtherPumpBlowerQuietTableCell = cell as? InspectionOtherPumpBlowerQuietTableCell {
            if textView == InspectionOtherPumpBlowerQuietTableCell.txtBlowerQuiet {
                self.secBlowers[Blowers.blowerQuiet.rawValue].formTextValue = (textView.text)!
            }
        }
            
    }
}

extension InspectOtherPumpVC: UITableViewDataSource, UITableViewDelegate {
    //MARK:- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 25 {
            return 9
        } else if tableView.tag == 35 {
            return 7
        } else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 25 {
            if indexPath.row == 0 {
                let otherPumpCell = tableView.dequeueReusableCell(withIdentifier: "InspectionOtherPumpTypesCell", for: indexPath) as! InspectionOtherPumpTypesTableCell
                
                otherPumpCell.txtOtherPumpTypes.delegate = self
                
                return otherPumpCell
            } else if indexPath.row == 1 {
                let otherPumpCell = tableView.dequeueReusableCell(withIdentifier: "InspectionOtherPumpOperatingCell", for: indexPath) as! InspectionOtherPumpOperatingTableCell
                
                otherPumpCell.btnUpload.addTarget(self, action: #selector(btnOtherPumpImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                otherPumpCell.collectionvw.arrItems = arrImgOtherPumpOperating
                otherPumpCell.collectionvw.delegateItemCollection = self
                otherPumpCell.collectionvw.reloadImageCollection()
                
                if arrImgOtherPumpOperating.count > 0 {
                    otherPumpCell.btnUpload.isHidden = true
                    otherPumpCell.collectionvw.isHidden = false
                } else {
                    otherPumpCell.btnUpload.isHidden = false
                    otherPumpCell.collectionvw.isHidden = true
                }
                
                otherPumpCell.delegateOtherOperatePump = self
                otherPumpCell.txtPumpOperating.delegate = self
                
                return otherPumpCell
            } else if indexPath.row == 2 {
                let otherPumpCell = tableView.dequeueReusableCell(withIdentifier: "InspectionOtherPumpMaintainanceAccessCell", for: indexPath) as! InspectionOtherPumpMaintainanceAccessTableCell
                
                otherPumpCell.btnUpload.addTarget(self, action: #selector(btnOtherPumpImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                otherPumpCell.collectionvw.arrItems = arrImgOtherPumpMaintaince
                otherPumpCell.collectionvw.delegateItemCollection = self
                otherPumpCell.collectionvw.reloadImageCollection()
                
                if arrImgOtherPumpMaintaince.count > 0 {
                    otherPumpCell.btnUpload.isHidden = true
                    otherPumpCell.collectionvw.isHidden = false
                } else {
                    otherPumpCell.btnUpload.isHidden = false
                    otherPumpCell.collectionvw.isHidden = true
                }
                
                otherPumpCell.delegateOtherPumpMaintain = self
                otherPumpCell.txtPumpMaintenance.delegate = self
                
                return otherPumpCell
            } else if indexPath.row == 3 {
                let otherPumpCell = tableView.dequeueReusableCell(withIdentifier: "InspectionOtherPumpRightSizeCell", for: indexPath) as! InspectionOtherPumpRightSizeTableCell
                
                otherPumpCell.btnUpload.addTarget(self, action: #selector(btnOtherPumpImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                otherPumpCell.collectionvw.arrItems = arrImgOtherPumpRightSize
                otherPumpCell.collectionvw.delegateItemCollection = self
                otherPumpCell.collectionvw.reloadImageCollection()
                
                if arrImgOtherPumpRightSize.count > 0 {
                    otherPumpCell.btnUpload.isHidden = true
                    otherPumpCell.collectionvw.isHidden = false
                } else {
                    otherPumpCell.btnUpload.isHidden = false
                    otherPumpCell.collectionvw.isHidden = true
                }
                
                otherPumpCell.delegateOtherPumpRightSize = self
                otherPumpCell.txtPumpRightSize.delegate = self
                
                return otherPumpCell
            } else if indexPath.row == 4 {
                let otherPumpCell = tableView.dequeueReusableCell(withIdentifier: "InspectionOtherPumpMountedCell", for: indexPath) as! InspectionOtherPumpMountedTableCell
                
                otherPumpCell.btnUpload.addTarget(self, action: #selector(btnOtherPumpImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                otherPumpCell.collectionvw.arrItems = arrImgOtherPumpMounted
                otherPumpCell.collectionvw.delegateItemCollection = self
                otherPumpCell.collectionvw.reloadImageCollection()
                
                if arrImgOtherPumpMounted.count > 0 {
                    otherPumpCell.btnUpload.isHidden = true
                    otherPumpCell.collectionvw.isHidden = false
                } else {
                    otherPumpCell.btnUpload.isHidden = false
                    otherPumpCell.collectionvw.isHidden = true
                }
                
                otherPumpCell.delegateOtherPumpMounted = self
                otherPumpCell.txtPumpMounted.delegate = self
                
                return otherPumpCell
            } else if indexPath.row == 5 {
                let otherPumpCell = tableView.dequeueReusableCell(withIdentifier: "InspectionOtherPumpVisibleLeakCell", for: indexPath) as! InspectionOtherPumpVisibleLeakTableCell
                
                otherPumpCell.btnUpload.addTarget(self, action: #selector(btnOtherPumpImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                otherPumpCell.collectionvw.arrItems = arrImgOtherPumpVisibleLeak
                otherPumpCell.collectionvw.delegateItemCollection = self
                otherPumpCell.collectionvw.reloadImageCollection()
                
                if arrImgOtherPumpVisibleLeak.count > 0 {
                    otherPumpCell.btnUpload.isHidden = true
                    otherPumpCell.collectionvw.isHidden = false
                } else {
                    otherPumpCell.btnUpload.isHidden = false
                    otherPumpCell.collectionvw.isHidden = true
                }
                
                otherPumpCell.delegateOtherPumpVisibleLeak = self
                otherPumpCell.txtPumpVisibleLeak.delegate = self
                
                return otherPumpCell
            } else if indexPath.row == 6 {
                let otherPumpCell = tableView.dequeueReusableCell(withIdentifier: "InspectionOtherPumpGasketsCell", for: indexPath) as! InspectionOtherPumpGasketsTableCell
                
                otherPumpCell.btnUpload.addTarget(self, action: #selector(btnOtherPumpImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                otherPumpCell.collectionvw.arrItems = arrImgOtherPumpGaskets
                otherPumpCell.collectionvw.delegateItemCollection = self
                otherPumpCell.collectionvw.reloadImageCollection()
                
                if arrImgOtherPumpGaskets.count > 0 {
                    otherPumpCell.btnUpload.isHidden = true
                    otherPumpCell.collectionvw.isHidden = false
                } else {
                    otherPumpCell.btnUpload.isHidden = false
                    otherPumpCell.collectionvw.isHidden = true
                }
                
                otherPumpCell.delegateOtherPumpGaskets = self
                otherPumpCell.txtPumpGaskets.delegate = self
                
                return otherPumpCell
            } else if indexPath.row == 7 {
                let otherPumpCell = tableView.dequeueReusableCell(withIdentifier: "InspectionOtherPumpPlumbingPresentCell", for: indexPath) as! InspectionOtherPumpPlumbingPresentTableCell
                
                otherPumpCell.btnUpload.addTarget(self, action: #selector(btnOtherPumpImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                otherPumpCell.collectionvw.arrItems = arrImgOtherPumpPlumbing
                otherPumpCell.collectionvw.delegateItemCollection = self
                otherPumpCell.collectionvw.reloadImageCollection()
                
                if arrImgOtherPumpPlumbing.count > 0 {
                    otherPumpCell.btnUpload.isHidden = true
                    otherPumpCell.collectionvw.isHidden = false
                } else {
                    otherPumpCell.btnUpload.isHidden = false
                    otherPumpCell.collectionvw.isHidden = true
                }
                
                otherPumpCell.delegateOtherPumpPlumbing = self
                otherPumpCell.txtPlumbingPresent.delegate = self
                
                return otherPumpCell
            } else { //if indexPath.row == 8 {
                let otherPumpCell = tableView.dequeueReusableCell(withIdentifier: "InspectionOtherPumpEquipmentRunCell", for: indexPath) as! InspectionOtherPumpEquipmentRunTableCell
                
                otherPumpCell.btnUpload.addTarget(self, action: #selector(btnOtherPumpImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                otherPumpCell.collectionvw.arrItems = arrImgOtherPumpEquipment
                otherPumpCell.collectionvw.delegateItemCollection = self
                otherPumpCell.collectionvw.reloadImageCollection()
                
                if arrImgOtherPumpEquipment.count > 0 {
                    otherPumpCell.btnUpload.isHidden = true
                    otherPumpCell.collectionvw.isHidden = false
                } else {
                    otherPumpCell.btnUpload.isHidden = false
                    otherPumpCell.collectionvw.isHidden = true
                }
                
                otherPumpCell.delegateOtherPumpEquipmentRun = self
                otherPumpCell.txtEquipmentRun.delegate = self
                
                return otherPumpCell
            }
         } else if tableView.tag == 35 {
             if indexPath.row == 0 {
                let blowerCell = tableView.dequeueReusableCell(withIdentifier: "InspectionOtherPumpBlowerRepairCell", for: indexPath) as! InspectionOtherPumpBlowerRepairTableCell
                
                blowerCell.btnUpload.addTarget(self, action: #selector(btnBlowerImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                blowerCell.collectionvw.arrItems = arrImgBlowerRepair
                blowerCell.collectionvw.delegateItemCollection = self
                blowerCell.collectionvw.reloadImageCollection()
                
                if arrImgBlowerRepair.count > 0 {
                    blowerCell.btnUpload.isHidden = true
                    blowerCell.collectionvw.isHidden = false
                } else {
                    blowerCell.btnUpload.isHidden = false
                    blowerCell.collectionvw.isHidden = true
                }
                
                blowerCell.delegateOtherPumpBlowerRepair = self
                blowerCell.txtBlowerRepair.delegate = self
                
                return blowerCell
            } else if indexPath.row == 1 {
                let blowerCell = tableView.dequeueReusableCell(withIdentifier: "InspectionOtherPumpBlowerBondingCell", for: indexPath) as! InspectionOtherPumpBlowerBondingTableCell
                
                blowerCell.btnUpload.addTarget(self, action: #selector(btnBlowerImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                blowerCell.collectionvw.arrItems = arrImgBlowerBonding
                blowerCell.collectionvw.delegateItemCollection = self
                blowerCell.collectionvw.reloadImageCollection()
                
                if arrImgOtherPump.count > 0 {
                    blowerCell.btnUpload.isHidden = true
                    blowerCell.collectionvw.isHidden = false
                } else {
                    blowerCell.btnUpload.isHidden = false
                    blowerCell.collectionvw.isHidden = true
                }
                
                blowerCell.delegateOtherPumpBlowerBonding = self
                blowerCell.txtBlowerBonding.delegate = self
                
                return blowerCell
            } else if indexPath.row == 2 {
                let blowerCell = tableView.dequeueReusableCell(withIdentifier: "InspectionOtherPumpBlowerAdequateSizeCell", for: indexPath) as! InspectionOtherPumpBlowerAdequateSizeTableCell
                
                blowerCell.btnUpload.addTarget(self, action: #selector(btnBlowerImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                blowerCell.collectionvw.arrItems = arrImgBlowerAdequateSize
                blowerCell.collectionvw.delegateItemCollection = self
                blowerCell.collectionvw.reloadImageCollection()
                
                if arrImgBlowerAdequateSize.count > 0 {
                    blowerCell.btnUpload.isHidden = true
                    blowerCell.collectionvw.isHidden = false
                } else {
                    blowerCell.btnUpload.isHidden = false
                    blowerCell.collectionvw.isHidden = true
                }
                
                blowerCell.delegateOtherPumpBlowerAdequate = self
                blowerCell.txtBlowerAdequateSize.delegate = self
                
                return blowerCell
            } else if indexPath.row == 3 {
                let blowerCell = tableView.dequeueReusableCell(withIdentifier: "InspectionOtherPumpBlowerMountedCell", for: indexPath) as! InspectionOtherPumpBlowerMountedTableCell
                
                blowerCell.btnUpload.addTarget(self, action: #selector(btnBlowerImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                blowerCell.collectionvw.arrItems = arrImgBlowerMounted
                blowerCell.collectionvw.delegateItemCollection = self
                blowerCell.collectionvw.reloadImageCollection()
                
                if arrImgBlowerMounted.count > 0 {
                    blowerCell.btnUpload.isHidden = true
                    blowerCell.collectionvw.isHidden = false
                } else {
                    blowerCell.btnUpload.isHidden = false
                    blowerCell.collectionvw.isHidden = true
                }
                
                blowerCell.delegateOtherPumpBlowerMounted = self
                blowerCell.txtBlowerMounted.delegate = self
                
                return blowerCell
            } else if indexPath.row == 4 {
                let blowerCell = tableView.dequeueReusableCell(withIdentifier: "InspectionOtherPumpBlowerStrappedCell", for: indexPath) as! InspectionOtherPumpBlowerStrappedTableCell
                
                blowerCell.btnUpload.addTarget(self, action: #selector(btnBlowerImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                blowerCell.collectionvw.arrItems = arrImgBlowerStrapped
                blowerCell.collectionvw.delegateItemCollection = self
                blowerCell.collectionvw.reloadImageCollection()
                
                if arrImgBlowerStrapped.count > 0 {
                    blowerCell.btnUpload.isHidden = true
                    blowerCell.collectionvw.isHidden = false
                } else {
                    blowerCell.btnUpload.isHidden = false
                    blowerCell.collectionvw.isHidden = true
                }
                
                blowerCell.delegateOtherPumpBlowerStrapped = self
                blowerCell.txtBlowerStrapped.delegate = self
                
                return blowerCell
            } else if indexPath.row == 5 {
                let blowerCell = tableView.dequeueReusableCell(withIdentifier: "InspectionOtherPumpBlowerValveCell", for: indexPath) as! InspectionOtherPumpBlowerValveTableCell
                
                blowerCell.btnUpload.addTarget(self, action: #selector(btnBlowerImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                blowerCell.collectionvw.arrItems = arrImgBlowerValve
                blowerCell.collectionvw.delegateItemCollection = self
                blowerCell.collectionvw.reloadImageCollection()
                
                if arrImgBlowerValve.count > 0 {
                    blowerCell.btnUpload.isHidden = true
                    blowerCell.collectionvw.isHidden = false
                } else {
                    blowerCell.btnUpload.isHidden = false
                    blowerCell.collectionvw.isHidden = true
                }
                
                blowerCell.delegateOtherPumpBlowerValve = self
                blowerCell.txtBlowerValve.delegate = self
                
                return blowerCell
             } else {//if indexPath.row == 6 {
                let blowerCell = tableView.dequeueReusableCell(withIdentifier: "InspectionOtherPumpBlowerQuietCell", for: indexPath) as! InspectionOtherPumpBlowerQuietTableCell
                
                blowerCell.btnUpload.addTarget(self, action: #selector(btnBlowerImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                blowerCell.collectionvw.arrItems = arrImgBlowerQuiet
                blowerCell.collectionvw.delegateItemCollection = self
                blowerCell.collectionvw.reloadImageCollection()
                
                if arrImgBlowerQuiet.count > 0 {
                    blowerCell.btnUpload.isHidden = true
                    blowerCell.collectionvw.isHidden = false
                } else {
                    blowerCell.btnUpload.isHidden = false
                    blowerCell.collectionvw.isHidden = true
                }
                
                blowerCell.delegateOtherPumpBlowerQuiet = self
                blowerCell.txtBlowerQuiet.delegate = self
                
                return blowerCell
            }
         } else {
            if indexPath.row == 0 {
                let cameraCell = tableView.dequeueReusableCell(withIdentifier: "CameraCell", for: indexPath) as! CameraTableCell
                
                cameraCell.lblHeader.text = "Other Pump (If Applicable)"
                
                cameraCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                cameraCell.collectionVw.arrItems = arrImgOtherPumpMain
                cameraCell.collectionVw.delegateItemCollection = self
                cameraCell.collectionVw.reloadImageCollection()
                
                if arrImgOtherPumpMain.count > 0 {
                    cameraCell.btnUpload.isHidden = true
                    cameraCell.collectionVw.isHidden = false
                } else {
                    cameraCell.btnUpload.isHidden = false
                    cameraCell.collectionVw.isHidden = true
                }
                
                return cameraCell
            } else if indexPath.row == 1 {
                let InspectionOtherPumpCell = tableView.dequeueReusableCell(withIdentifier: "InspectionOtherPumpCell", for: indexPath) as! InspectionOtherPumpTableCell
                
                InspectionOtherPumpCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                InspectionOtherPumpCell.collectionvw.arrItems = arrImgOtherPump
                InspectionOtherPumpCell.collectionvw.delegateItemCollection = self
                InspectionOtherPumpCell.collectionvw.reloadImageCollection()
                
                if arrImgOtherPump.count > 0 {
                    InspectionOtherPumpCell.btnUpload.isHidden = true
                    InspectionOtherPumpCell.collectionvw.isHidden = false
                } else {
                    InspectionOtherPumpCell.btnUpload.isHidden = false
                    InspectionOtherPumpCell.collectionvw.isHidden = true
                }
                
                InspectionOtherPumpCell.delegateOtherPump = self
                InspectionOtherPumpCell.txtOtherPumps.delegate = self
                
                if strOtherPumpOption == "Yes" {
                    //Declare the outlet in our custom class
                    let tblOtherPump = InspectionOtherPumpCell.viewWithTag(25) as! UITableView
                    
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        InspectionOtherPumpCell.tblOtherPumpHeightConstraint.constant = 2910
                    } else {
                        InspectionOtherPumpCell.tblOtherPumpHeightConstraint.constant = 2910
                    }
                    tblOtherPump.delegate = self
                    tblOtherPump.dataSource = self
                    tblOtherPump.reloadData()
                } else if strOtherPumpOption == "No" {
                      InspectionOtherPumpCell.tblOtherPumpHeightConstraint.constant = 0
                }
                
                return InspectionOtherPumpCell
            } else if indexPath.row == 2 {
                let cameraCell = tableView.dequeueReusableCell(withIdentifier: "CameraCell", for: indexPath) as! CameraTableCell
                                  
                cameraCell.lblHeader.text = "BLOWERS"
                
                cameraCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                cameraCell.collectionVw.arrItems = arrImgBlowersMain
                cameraCell.collectionVw.delegateItemCollection = self
                cameraCell.collectionVw.reloadImageCollection()
                
                if arrImgBlowersMain.count > 0 {
                    cameraCell.btnUpload.isHidden = true
                    cameraCell.collectionVw.isHidden = false
                } else {
                    cameraCell.btnUpload.isHidden = false
                    cameraCell.collectionVw.isHidden = true
                }
                
                return cameraCell
            } else if indexPath.row == 3 {
                let InspectionOtherPumpBlowerCell = tableView.dequeueReusableCell(withIdentifier: "InspectionOtherPumpBlowerCell", for: indexPath) as! InspectionOtherPumpBlowerTableCell
                
                InspectionOtherPumpBlowerCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                InspectionOtherPumpBlowerCell.collectionvw.arrItems = arrImgBlowers
                InspectionOtherPumpBlowerCell.collectionvw.delegateItemCollection = self
                InspectionOtherPumpBlowerCell.collectionvw.reloadImageCollection()
                
                if arrImgBlowers.count > 0 {
                    InspectionOtherPumpBlowerCell.btnUpload.isHidden = true
                    InspectionOtherPumpBlowerCell.collectionvw.isHidden = false
                } else {
                    InspectionOtherPumpBlowerCell.btnUpload.isHidden = false
                    InspectionOtherPumpBlowerCell.collectionvw.isHidden = true
                }
                
                InspectionOtherPumpBlowerCell.delegateOtherPumpBlower = self
                InspectionOtherPumpBlowerCell.txtOtherPumpsBlower.delegate = self
                
                if strBlowersOption == "Yes" {
                    //Declare the outlet in our custom class
                    let tblBlower = InspectionOtherPumpBlowerCell.viewWithTag(35) as! UITableView
                    
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        InspectionOtherPumpBlowerCell.tblOtherPumpBlowerHeightConstraint.constant = 340*7
                    } else {
                        InspectionOtherPumpBlowerCell.tblOtherPumpBlowerHeightConstraint.constant = 600*7
                    }
                    tblBlower.delegate = self
                    tblBlower.dataSource = self
                    tblBlower.reloadData()
                } else if strBlowersOption == "No" {
                    InspectionOtherPumpBlowerCell.tblOtherPumpBlowerHeightConstraint.constant = 0
                }
            
                return InspectionOtherPumpBlowerCell
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
                if indexPath.row == 0 {
                    return 185
                } else {
                    return 340
                }
            } else if tableView.tag == 35 {
                return 340
            } else {
                if indexPath.row == 0 {
                    return 185
                } else if indexPath.row == 1 {
                    if strOtherPumpOption == "Yes" {
                        return 340+2910//UITableView.automaticDimension//
                    } else {
                        return 340
                    }
                } else if indexPath.row == 2 {
                     return 185
                } else if indexPath.row == 3 {
                     if strBlowersOption == "Yes" {
                         return 340+(340*7)//UITableView.automaticDimension//
                     } else {
                         return 340
                     }
                } else {
                     return 105
                }
           }
       } else {         // .pad
            if tableView.tag == 25 {
                if indexPath.row == 0 {
                    return 320
                } else {
                    return 600
                }
            } else if tableView.tag == 35 {
                return 600
            } else {
                 if indexPath.row == 0 {
                     return 320
                 } else if indexPath.row == 1 {
                     if strOtherPumpOption == "Yes" {
                         return 615+2910//UITableView.automaticDimension//
                     } else {
                         return 615
                     }
                 } else if indexPath.row == 2 {
                      return 320
                 } else if indexPath.row == 3 {
                      if strBlowersOption == "Yes" {
                          return 615+(600*7)//UITableView.automaticDimension//
                      } else {
                          return 615
                      }
                 } else {
                      return 175
                 }
            }
        }
    }
}

extension InspectOtherPumpVC: OtherPumpCellProtocol, OtherPumpOperateCellProtocol, OtherPumpMaintainCellProtocol, OtherPumpRightSizeCellProtocol, OtherPumpMountedCellProtocol, OtherPumpVisibleLeakCellProtocol, OtherPumpGasketsCellProtocol, OtherPumpPlumbingCellProtocol, OtherPumpEquipmentRunCellProtocol, OtherPumpBlowerCellProtocol, OtherPumpBlowerRepairCellProtocol, OtherPumpBlowerBondingCellProtocol, OtherPumpBlowerAdequateCellProtocol, OtherPumpBlowerMountedCellProtocol, OtherPumpBlowerStrappedCellProtocol, OtherPumpBlowerValveCellProtocol, OtherPumpBlowerQuietCellProtocol {
    //MARK:- Other Pump Protocol
    func didTapOnCellOtherPump(_btnOtherPumpTag: Int) {
       if _btnOtherPumpTag == 0 {
           strOtherPumpOption = "Yes"
       } else if _btnOtherPumpTag == 1 {
           strOtherPumpOption = "No"
       }
       self.tblOtherPump.reloadData()
    }
    //MARK:- Sub Other Pump Protocol
    func didTapOnCellOtherPumpOperate(_btnOtherPumpTag: Int) {
       if _btnOtherPumpTag == 0 {
           strOptOtherPumpOperating = "Yes"
       } else if _btnOtherPumpTag == 1 {
           strOptOtherPumpOperating = "No"
       }
       self.tblOtherPump.reloadData()
    }
    
    func didTapOnCellOtherPumpMaintain(_btnOtherPumpTag: Int) {
       if _btnOtherPumpTag == 0 {
           strOptOtherPumpMaintaince = "Yes"
       } else if _btnOtherPumpTag == 1 {
           strOptOtherPumpMaintaince = "No"
       }
       self.tblOtherPump.reloadData()
    }
    
    func didTapOnCellOtherPumpRightSize(_btnOtherPumpTag: Int) {
       if _btnOtherPumpTag == 0 {
           strOptOtherPumpRightSize = "Yes"
       } else if _btnOtherPumpTag == 1 {
           strOptOtherPumpRightSize = "No"
       }
       self.tblOtherPump.reloadData()
    }
    
    func didTapOnCellOtherPumpMounted(_btnOtherPumpTag: Int) {
       if _btnOtherPumpTag == 0 {
           strOptOtherPumpMounted = "Yes"
       } else if _btnOtherPumpTag == 1 {
           strOptOtherPumpMounted = "No"
       }
       self.tblOtherPump.reloadData()
    }
    
    func didTapOnCellOtherPumpVisibleLeak(_btnOtherPumpTag: Int) {
       if _btnOtherPumpTag == 0 {
           strOptOtherPumpVisibleLeak = "Yes"
       } else if _btnOtherPumpTag == 1 {
           strOptOtherPumpVisibleLeak = "No"
       }
       self.tblOtherPump.reloadData()
    }
    
    func didTapOnCellOtherPumpGaskets(_btnOtherPumpTag: Int) {
       if _btnOtherPumpTag == 0 {
           strOptOtherPumpGaskets = "Yes"
       } else if _btnOtherPumpTag == 1 {
           strOptOtherPumpGaskets = "No"
       }
       self.tblOtherPump.reloadData()
    }
    
    func didTapOnCellOtherPumpPlumbing(_btnOtherPumpTag: Int) {
       if _btnOtherPumpTag == 0 {
           strOptOtherPumpPlumbing = "Yes"
       } else if _btnOtherPumpTag == 1 {
           strOptOtherPumpPlumbing = "No"
       }
       self.tblOtherPump.reloadData()
    }
    
    func didTapOnCellOtherPumpEquipmentRun(_btnOtherPumpTag: Int) {
       if _btnOtherPumpTag == 0 {
           strOptOtherPumpEquipment = "Yes"
       } else if _btnOtherPumpTag == 1 {
           strOptOtherPumpEquipment = "No"
       }
       self.tblOtherPump.reloadData()
    }
    
    //MARK:- Blower Pump Protocol
    func didTapOnCellOtherPumpBlower(_btnOtherPumpBlowerTag: Int) {
       if _btnOtherPumpBlowerTag == 0 {
           strBlowersOption = "Yes"
       } else if _btnOtherPumpBlowerTag == 1 {
           strBlowersOption = "No"
       }
       self.tblOtherPump.reloadData()
    }
    
    //MARK:- Sub Blower Pump Protocol
    func didTapOnCellOtherPumpBlowerRepair(_btnOtherPumpBlowerTag: Int) {
        if _btnOtherPumpBlowerTag == 0 {
            strOptBlowerRepair = "Yes"
        } else if _btnOtherPumpBlowerTag == 1 {
            strOptBlowerRepair = "No"
        }
        self.tblOtherPump.reloadData()
    }
    func didTapOnCellOtherPumpBlowerBonding(_btnOtherPumpBlowerTag: Int) {
       if _btnOtherPumpBlowerTag == 0 {
           strOptBlowerBonding = "Yes"
       } else if _btnOtherPumpBlowerTag == 1 {
           strOptBlowerBonding = "No"
       }
       self.tblOtherPump.reloadData()
    }
    
    func didTapOnCellOtherPumpBlowerAdequate(_btnOtherPumpBlowerTag: Int) {
       if _btnOtherPumpBlowerTag == 0 {
           strOptBlowerAdequateSize = "Yes"
       } else if _btnOtherPumpBlowerTag == 1 {
           strOptBlowerAdequateSize = "No"
       }
       self.tblOtherPump.reloadData()
    }
    
    func didTapOnCellOtherPumpBlowerMounted(_btnOtherPumpBlowerTag: Int) {
       if _btnOtherPumpBlowerTag == 0 {
           strOptBlowerMounted = "Yes"
       } else if _btnOtherPumpBlowerTag == 1 {
           strOptBlowerMounted = "No"
       }
       self.tblOtherPump.reloadData()
    }
    
    func didTapOnCellOtherPumpBlowerStrapped(_btnOtherPumpBlowerTag: Int) {
       if _btnOtherPumpBlowerTag == 0 {
           strOptBlowerStrapped = "Yes"
       } else if _btnOtherPumpBlowerTag == 1 {
           strOptBlowerStrapped = "No"
       }
       self.tblOtherPump.reloadData()
    }
    
    func didTapOnCellOtherPumpBlowerValve(_btnOtherPumpBlowerTag: Int) {
       if _btnOtherPumpBlowerTag == 0 {
           strOptBlowerValve = "Yes"
       } else if _btnOtherPumpBlowerTag == 1 {
           strOptBlowerValve = "No"
       }
       self.tblOtherPump.reloadData()
    }
    
    func didTapOnCellOtherPumpBlowerQuiet(_btnOtherPumpBlowerTag: Int) {
       if _btnOtherPumpBlowerTag == 0 {
           strOptBlowerQuiet = "Yes"
       } else if _btnOtherPumpBlowerTag == 1 {
           strOptBlowerQuiet = "No"
       }
       self.tblOtherPump.reloadData()
    }
    
}
