//
//  InspectSelfCleaningVC.swift
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

class InspectSelfCleaningVC: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var tblSelfCleaning: UITableView!
    
    var secInspectSelfClean = [formInspectionPoolData]()
    var secSelfClean = [formInspectionPoolData]()
    var secBoosterPump = [formInspectionPoolData]()
    
    enum InspectSelfClean: Int {
        case selfClean = 1
        case boosterPump = 3
    }
    
    enum SelfClean: Int {
        case pumpOperating = 0
        case cleanMaintaince = 1
        case adequateSize = 2
        case cleanMounted = 3
        case cleanVisibleLeak = 4
        case cleanGaskets = 5
        case cleanVisibleAdequateSize = 6
        case cleanRunQuietly = 7
    }
    
    enum BoosterPump: Int {
        case boosterPumpOperation = 0
        case boosterMaintaince = 1
        case boosterAdequateSize = 2
        case boosterMounted = 3
        case boosterVisibleLeak = 4
        case boosterGaskets = 5
        case boosterVisibleAdequateSize = 6
        case boosterPumpRun = 7
    }
    
    
    var fetchIndexForUpload: Int = -1
    var fetchIndexForSubCleanUpload: Int = -1
    var fetchIndexForSubBoosterUpload: Int = -1
    
    var imagePicker = UIImagePickerController()
    var picker:UIImagePickerController? = UIImagePickerController()
    
    //For Images
    var arrImgSelfCleanMain: [CollectionImageObject] = []
    var arrImgSelfClean: [CollectionImageObject] = []
    var arrImgBoosterMain: [CollectionImageObject] = []
    var arrImgBooster: [CollectionImageObject] = []
    
    var arrImgCleanOperating: [CollectionImageObject] = []
    var arrImgCleanMaintaince: [CollectionImageObject] = []
    var arrImgCleanAdequateSize: [CollectionImageObject] = []
    var arrImgCleanMounted: [CollectionImageObject] = []
    var arrImgCleanVisibleLeak: [CollectionImageObject] = []
    var arrImgCleanGaskets: [CollectionImageObject] = []
    var arrImgCleanVisibleAdequate: [CollectionImageObject] = []
    var arrImgCleanRunQuietly: [CollectionImageObject] = []
    
    
    var arrImgBoosterPumpOperating: [CollectionImageObject] = []
    var arrImgBoosterMaintaince: [CollectionImageObject] = []
    var arrImgBoosterAdequateSize: [CollectionImageObject] = []
    var arrImgBoosterMounted: [CollectionImageObject] = []
    var arrImgBoosterVisibleLeak: [CollectionImageObject] = []
    var arrImgBoosterGaskets: [CollectionImageObject] = []
    var arrImgBoosterVisibleAdequateSize: [CollectionImageObject] = []
    var arrImgBoosterRunQuietly: [CollectionImageObject] = []
    
    //For Image Server path
    var strImgSelfCleanMain = String()
    var strImgSelfClean = String()
    var strImgBoosterMain = String()
    var strImgBooster = String()
    
    var strCleanOperatingImg = String()
    var strCleanMaintainceImg = String()
    var strCleanAdequateSizeImg = String()
    var strCleanMountedImg = String()
    var strCleanVisibleLeakImg = String()
    var strCleanGasketsImg = String()
    var strCleanVisibleAdequateImg = String()
    var strCleanRunQuietlyImg = String()
    
    var strBoosterPumpOperatingImg = String()
    var strBoosterMaintainceImg = String()
    var strBoosterAdequateSizeImg = String()
    var strBoosterMountedImg = String()
    var strBoosterVisibleLeakImg = String()
    var strBoosterGasketsImg = String()
    var strBoosterVisibleAdequateSizeImg = String()
    var strBoosterRunQuietlyImg = String()
    
    
    //For Image CoreData
    var dataImgSelfCleanMain = NSData()
    var dataImgSelfClean = NSData()
    var dataImgBoosterMain = NSData()
    var dataImgBooster = NSData()
    
    var dataCleanOperatingImg = NSData()
    var dataCleanMaintainceImg = NSData()
    var dataCleanAdequateSizeImg = NSData()
    var dataCleanMountedImg = NSData()
    var dataCleanVisibleLeakImg = NSData()
    var dataCleanGasketsImg = NSData()
    var dataCleanVisibleAdequateImg = NSData()
    var dataCleanRunQuietlyImg = NSData()
    
    var dataBoosterPumpOperatingImg = NSData()
    var dataBoosterMaintainceImg = NSData()
    var dataBoosterAdequateSizeImg = NSData()
    var dataBoosterMountedImg = NSData()
    var dataBoosterVisibleLeakImg = NSData()
    var dataBoosterGasketsImg = NSData()
    var dataBoosterVisibleAdequateSizeImg = NSData()
    var dataBoosterRunQuietlyImg = NSData()
    
    
    //For Optional Values
    var strSelfCleanOption = String()
    var strBoosterPumpOption = String()
    
    var strOptCleanOperating = String()
    var strOptCleanMaintaince = String()
    var strOptCleanAdequateSize = String()
    var strOptCleanMounted = String()
    var strOptCleanVisibleLeak = String()
    var strOptCleanGaskets = String()
    var strOptCleanVisibleAdequate = String()
    var strOptCleanRunQuietly = String()
    
    var strOptBoosterPumpOperating = String()
    var strOptBoosterMaintaince = String()
    var strOptBoosterAdequateSize = String()
    var strOptBoosterMounted = String()
    var strOptBoosterVisibleLeak = String()
    var strOptBoosterGaskets = String()
    var strOptBoosterVisibleAdequateSize = String()
    var strOptBoosterRunQuietly = String()
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.prepareFormSelfCleanData()
    }
    
    func prepareFormSelfCleanData() {
        for _ in 0..<5 {
            let obj = formInspectionPoolData()
            self.secInspectSelfClean.append(obj)
        }
        for _ in 0..<9 {
            let obj = formInspectionPoolData()
            self.secSelfClean.append(obj)
        }
        for _ in 0..<9 {
            let obj = formInspectionPoolData()
            self.secBoosterPump.append(obj)
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
        let indexOfCell = self.tblSelfCleaning.indexPath(for: cell)
        print("Clicked Index : \(String(describing: indexOfCell?.row))")
        
        fetchIndexForSubCleanUpload = -1
        fetchIndexForSubBoosterUpload = -1
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
        let tblSubSwim = self.view.viewWithTag(25) as! UITableView
        let indexOfCell = tblSubSwim.indexPath(for: cell)
        print("Clicked Index : \(String(describing: indexOfCell?.row))")
        fetchIndexForUpload = -1
        fetchIndexForSubCleanUpload = (indexOfCell?.row)!
        
        print("Upload Index : \(String(describing: fetchIndexForSubCleanUpload))")
        
        self.actionSheetPopUpForGalleryOpen()
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc func btnBoosterImgUpload(_ sender: Any) {
        print("Button pressed 👍 ")
        let btn = sender as! UIButton
        let cell = btn.superview?.superview?.superview as! UITableViewCell
        let tblSubSwim = self.view.viewWithTag(35) as! UITableView
        let indexOfCell = tblSubSwim.indexPath(for: cell)
        print("Clicked Index : \(String(describing: indexOfCell?.row))")
        fetchIndexForUpload = -1
        fetchIndexForSubBoosterUpload = (indexOfCell?.row)!
        
        print("Upload Index : \(String(describing: fetchIndexForSubBoosterUpload))")
        
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
        //self.postInspectSelfCleaning()
        if UIDevice.current.userInterfaceIdiom == .phone {
            let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
            let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectOtherPump") as! InspectOtherPumpVC
            self.navigationController?.pushViewController(formVC, animated: true)
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
            let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectOtherPump") as! InspectOtherPumpVC
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
                    
                    managedObject.setValue(dataImgSelfCleanMain, forKey: "selfCleanMainImage")
                    managedObject.setValue(strSelfCleanOption, forKey: "selfCleanOption")
                    managedObject.setValue(dataImgSelfClean, forKey: "selfCleanImage")
                    managedObject.setValue(self.secInspectSelfClean[InspectSelfClean.selfClean.rawValue].formTextValue, forKey: "selfCleanData")
                    managedObject.setValue(dataImgBoosterMain, forKey: "boosterPumpMainImage")
                    managedObject.setValue(strBoosterPumpOption, forKey: "boosterPumpOption")
                    managedObject.setValue(dataImgBoosterMain, forKey: "boosterPumpImage")
                    managedObject.setValue(self.secInspectSelfClean[InspectSelfClean.boosterPump.rawValue].formTextValue, forKey: "boosterPumpData")
                    managedObject.setValue(strOptCleanOperating, forKey: "selfCleanOperatingOption")
                    managedObject.setValue(dataCleanOperatingImg, forKey: "selfCleanOperatingImage")
                    managedObject.setValue(self.secSelfClean[SelfClean.pumpOperating.rawValue].formTextValue, forKey: "selfCleanOperatingData")
                    managedObject.setValue(strOptCleanMaintaince, forKey: "selfCleanMaintainceOption")
                    managedObject.setValue(dataCleanMaintainceImg, forKey: "selfCleanMaintainceImage")
                    managedObject.setValue(self.secSelfClean[SelfClean.cleanMaintaince.rawValue].formTextValue, forKey: "selfCleanMaintainceData")
                    managedObject.setValue(strOptCleanAdequateSize, forKey: "selfCleanAdequateSizeOption")
                    managedObject.setValue(dataCleanAdequateSizeImg, forKey: "selfCleanAdequateSizeImage")
                    managedObject.setValue(self.secSelfClean[SelfClean.adequateSize.rawValue].formTextValue, forKey: "selfCleanAdequateSizeData")
                    managedObject.setValue(strOptCleanMounted, forKey: "selfCleanMountedOption")
                    managedObject.setValue(dataCleanMountedImg, forKey: "selfCleanMountedImage")
                    managedObject.setValue(self.secSelfClean[SelfClean.cleanMounted.rawValue].formTextValue, forKey: "selfCleanMountedData")
                    managedObject.setValue(strOptCleanVisibleLeak, forKey: "selfCleanVisibleLeakOption")
                    managedObject.setValue(dataCleanVisibleLeakImg, forKey: "selfCleanVisibleLeakImage")
                    managedObject.setValue(self.secSelfClean[SelfClean.cleanVisibleLeak.rawValue].formTextValue, forKey: "selfCleanVisibleLeakData")
                    managedObject.setValue(strOptCleanGaskets, forKey: "selfCleanGasketsOption")
                    managedObject.setValue(dataCleanGasketsImg, forKey: "selfCleanGasketsImage")
                    managedObject.setValue(self.secSelfClean[SelfClean.cleanGaskets.rawValue].formTextValue, forKey: "selfCleanGasketsData")
                    managedObject.setValue(strOptCleanVisibleAdequate, forKey: "selfCleanVisibleAdequateOption")
                    managedObject.setValue(dataCleanVisibleAdequateImg, forKey: "selfCleanVisibleAdequateImage")
                    managedObject.setValue(self.secSelfClean[SelfClean.cleanVisibleAdequateSize.rawValue].formTextValue, forKey: "selfCleanVisibleAdequateData")
                    managedObject.setValue(strOptCleanRunQuietly, forKey: "selfCleanRunQuietlyOption")
                    managedObject.setValue(dataCleanRunQuietlyImg, forKey: "selfCleanRunQuietlyImage")
                    managedObject.setValue(self.secSelfClean[SelfClean.cleanRunQuietly.rawValue].formTextValue, forKey: "selfCleanRunQuietlyData")
                    managedObject.setValue(strOptBoosterPumpOperating, forKey: "boosterPumpOperatingOption")
                    managedObject.setValue(dataBoosterPumpOperatingImg, forKey: "boosterPumpOperatingImage")
                    managedObject.setValue(self.secBoosterPump[BoosterPump.boosterPumpOperation.rawValue].formTextValue, forKey: "boosterPumpOperatingData")
                    managedObject.setValue(strOptBoosterMaintaince, forKey: "boosterMaintainceOption")
                    managedObject.setValue(dataBoosterMaintainceImg, forKey: "boosterMaintainceImage")
                    managedObject.setValue(self.secBoosterPump[BoosterPump.boosterMaintaince.rawValue].formTextValue, forKey: "boosterMaintainceData")
                    managedObject.setValue(strOptBoosterAdequateSize, forKey: "boosterAdequateSizeOption")
                    managedObject.setValue(dataBoosterAdequateSizeImg, forKey: "boosterAdequateSizeImage")
                    managedObject.setValue(self.secBoosterPump[BoosterPump.boosterAdequateSize.rawValue].formTextValue, forKey: "boosterAdequateSizeData")
                    managedObject.setValue(strOptBoosterMounted, forKey: "boosterMountedOption")
                    managedObject.setValue(dataBoosterMountedImg, forKey: "boosterMountedImage")
                    managedObject.setValue(self.secBoosterPump[BoosterPump.boosterMounted.rawValue].formTextValue, forKey: "boosterMountedData")
                    managedObject.setValue(strOptBoosterVisibleLeak, forKey: "boosterVisibleLeakOption")
                    managedObject.setValue(dataBoosterVisibleLeakImg, forKey: "boosterVisibleLeakImage")
                    managedObject.setValue(self.secBoosterPump[BoosterPump.boosterVisibleLeak.rawValue].formTextValue, forKey: "boosterVisibleLeakData")
                    managedObject.setValue(strOptBoosterGaskets, forKey: "boosterGasketsOption")
                    managedObject.setValue(dataBoosterGasketsImg, forKey: "boosterGasketsImage")
                    managedObject.setValue(self.secBoosterPump[BoosterPump.boosterGaskets.rawValue].formTextValue, forKey: "boosterGasketsData")
                    managedObject.setValue(strOptBoosterVisibleAdequateSize, forKey: "boosterVisibleAdequateSizeOption")
                    managedObject.setValue(dataBoosterVisibleAdequateSizeImg, forKey: "boosterVisibleAdequateSizeImage")
                    managedObject.setValue(self.secBoosterPump[BoosterPump.boosterVisibleAdequateSize.rawValue].formTextValue, forKey: "boosterVisibleAdequateSizeData")
                    managedObject.setValue(strOptBoosterRunQuietly, forKey: "boosterRunQuietlyOption")
                    managedObject.setValue(dataBoosterRunQuietlyImg, forKey: "boosterRunQuietlyImage")
                    managedObject.setValue(self.secBoosterPump[BoosterPump.boosterPumpRun.rawValue].formTextValue, forKey: "boosterRunQuietlyData")
                    
                    
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
                        print("Data of InspectSelfCleaningVC:: \(data)")
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
                        self.strImgSelfCleanMain = String(describing: data!)
                    } else if self.fetchIndexForUpload == 1 {
                        self.strImgSelfClean = String(describing: data!)
                    } else if self.fetchIndexForUpload == 2 {
                        self.strImgBoosterMain = String(describing: data!)
                    } else if self.fetchIndexForUpload == 3 {
                        self.strImgBooster = String(describing: data!)
                    }
                    
                    if self.fetchIndexForSubCleanUpload == 0 {
                        self.strCleanOperatingImg = String(describing: data!)
                    } else if self.fetchIndexForSubCleanUpload == 1 {
                        self.strCleanMaintainceImg = String(describing: data!)
                    } else if self.fetchIndexForSubCleanUpload == 2 {
                        self.strCleanAdequateSizeImg = String(describing: data!)
                    } else if self.fetchIndexForSubCleanUpload == 3 {
                        self.strCleanMountedImg = String(describing: data!)
                    } else if self.fetchIndexForSubCleanUpload == 4 {
                        self.strCleanVisibleLeakImg = String(describing: data!)
                    } else if self.fetchIndexForSubCleanUpload == 5 {
                        self.strCleanGasketsImg = String(describing: data!)
                    } else if self.fetchIndexForSubCleanUpload == 6 {
                        self.strCleanVisibleAdequateImg = String(describing: data!)
                    } else if self.fetchIndexForSubCleanUpload == 7 {
                        self.strCleanRunQuietlyImg = String(describing: data!)
                    }
                    
                    if self.fetchIndexForSubBoosterUpload == 0 {
                        self.strBoosterPumpOperatingImg = String(describing: data!)
                    } else if self.fetchIndexForSubBoosterUpload == 1 {
                        self.strBoosterMaintainceImg = String(describing: data!)
                    } else if self.fetchIndexForSubBoosterUpload == 2 {
                        self.strBoosterAdequateSizeImg = String(describing: data!)
                    } else if self.fetchIndexForSubBoosterUpload == 3 {
                        self.strBoosterMountedImg = String(describing: data!)
                    } else if self.fetchIndexForSubBoosterUpload == 4 {
                        self.strBoosterVisibleLeakImg = String(describing: data!)
                    } else if self.fetchIndexForSubBoosterUpload == 5 {
                        self.strBoosterGasketsImg = String(describing: data!)
                    } else if self.fetchIndexForSubBoosterUpload == 6 {
                        self.strBoosterVisibleAdequateSizeImg = String(describing: data!)
                    } else if self.fetchIndexForSubBoosterUpload == 7 {
                        self.strBoosterRunQuietlyImg = String(describing: data!)
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
    
    func postInspectSelfCleaning() {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        
        let return_id = UserDefaults.standard.value(forKey: "returnKeyForInspection")
        
        let inspectSelfCleanDetails:  NSMutableDictionary = [
            "return_data_id"                    : return_id!,
            "selfCleanMainImage"                : strImgSelfCleanMain,
            "selfCleanOption"                   : strSelfCleanOption,
            "selfCleanImage"                    : strImgSelfClean,
            "selfCleanData"                     : self.secInspectSelfClean[InspectSelfClean.selfClean.rawValue].formTextValue,
            "boosterPumpMainImage"              : strImgBoosterMain,
            "boosterPumpOption"                 : strBoosterPumpOption,
            "boosterPumpImage"                  : strImgBooster,
            "boosterPumpData"                   : self.secInspectSelfClean[InspectSelfClean.boosterPump.rawValue].formTextValue,
            "selfCleanOperatingOption"          : strOptCleanOperating,
            "selfCleanOperatingImage"           : strCleanOperatingImg,
            "selfCleanOperatingData"            : self.secSelfClean[SelfClean.pumpOperating.rawValue].formTextValue,
            "selfCleanMaintainceOption"         : strOptCleanMaintaince,
            "selfCleanMaintainceImage"          : strCleanMaintainceImg,
            "selfCleanMaintainceData"           : self.secSelfClean[SelfClean.cleanMaintaince.rawValue].formTextValue,
            "selfCleanAdequateSizeOption"       : strOptCleanAdequateSize,
            "selfCleanAdequateSizeImage"        : strCleanAdequateSizeImg,
            "selfCleanAdequateSizeData"         : self.secSelfClean[SelfClean.adequateSize.rawValue].formTextValue,
            "selfCleanMountedOption"            : strOptCleanMounted,
            "selfCleanMountedImage"             : strCleanMountedImg,
            "selfCleanMountedData"              : self.secSelfClean[SelfClean.cleanMounted.rawValue].formTextValue,
            "selfCleanVisibleLeakOption"        : strOptCleanVisibleLeak,
            "selfCleanVisibleLeakImage"         : strCleanVisibleLeakImg,
            "selfCleanVisibleLeakData"          : self.secSelfClean[SelfClean.cleanVisibleLeak.rawValue].formTextValue,
            "selfCleanGasketsOption"            : strOptCleanGaskets,
            "selfCleanGasketsImage"             : strCleanGasketsImg,
            "selfCleanGasketsData"              : self.secSelfClean[SelfClean.cleanGaskets.rawValue].formTextValue,
            "selfCleanVisibleAdequateOption"    : strOptCleanVisibleAdequate,
            "selfCleanVisibleAdequateImage"     : strCleanVisibleAdequateImg,
            "selfCleanVisibleAdequateData"      : self.secSelfClean[SelfClean.cleanVisibleAdequateSize.rawValue].formTextValue,
            "selfCleanRunQuietlyOption"         : strOptCleanRunQuietly,
            "selfCleanRunQuietlyImage"          : strCleanRunQuietlyImg,
            "selfCleanRunQuietlyData"           : self.secSelfClean[SelfClean.cleanRunQuietly.rawValue].formTextValue,
            "boosterPumpOperatingOption"        : strOptBoosterPumpOperating,
            "boosterPumpOperatingImage"         : strBoosterPumpOperatingImg,
            "boosterPumpOperatingData"          : self.secBoosterPump[BoosterPump.boosterPumpOperation.rawValue].formTextValue,
            "boosterMaintainceOption"           : strOptBoosterMaintaince,
            "boosterMaintainceImage"            : strBoosterMaintainceImg,
            "boosterMaintainceData"             : self.secBoosterPump[BoosterPump.boosterMaintaince.rawValue].formTextValue,
            "boosterAdequateSizeOption"         : strOptBoosterAdequateSize,
            "boosterAdequateSizeImage"          : strBoosterAdequateSizeImg,
            "boosterAdequateSizeData"           : self.secBoosterPump[BoosterPump.boosterAdequateSize.rawValue].formTextValue,
            "boosterMountedOption"              : strOptBoosterMounted,
            "boosterMountedImage"               : strBoosterMountedImg,
            "boosterMountedData"                : self.secBoosterPump[BoosterPump.boosterMounted.rawValue].formTextValue,
            "boosterVisibleLeakOption"          : strOptBoosterVisibleLeak,
            "boosterVisibleLeakImage"           : strBoosterVisibleLeakImg,
            "boosterVisibleLeakData"            : self.secBoosterPump[BoosterPump.boosterVisibleLeak.rawValue].formTextValue,
            "boosterGasketsOption"              : strOptBoosterGaskets,
            "boosterGasketsImage"               : strBoosterGasketsImg,
            "boosterGasketsData"                : self.secBoosterPump[BoosterPump.boosterGaskets.rawValue].formTextValue,
            "boosterVisibleAdequateSizeOption"  : strOptBoosterVisibleAdequateSize,
            "boosterVisibleAdequateSizeImage"   : strBoosterVisibleAdequateSizeImg,
            "boosterVisibleAdequateSizeData"    : self.secBoosterPump[BoosterPump.boosterVisibleAdequateSize.rawValue].formTextValue,
            "boosterRunQuietlyOption"           : strOptBoosterRunQuietly,
            "boosterRunQuietlyImage"            : strBoosterRunQuietlyImg,
            "boosterRunQuietlyData"             : self.secBoosterPump[BoosterPump.boosterPumpRun.rawValue].formTextValue
        ]
        
        print("inspectSelfCleanDetails :: \(inspectSelfCleanDetails)")
        //if sharedExtension.connectedToNetwork() {
        ApiManager.sharedInstanceAPI.PostInspectSelfCleaning(postId: 1, cleaningDetails: inspectSelfCleanDetails, onSuccess: { json in
            DispatchQueue.main.async {
                print("InspectionSelfCleaningDetails json :: \(String(describing: json))")
                DispatchQueue.main.async(execute: {() -> Void in
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectOtherPump") as! InspectOtherPumpVC
                        self.navigationController?.pushViewController(formVC, animated: true)
                    } else if UIDevice.current.userInterfaceIdiom == .pad {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectOtherPump") as! InspectOtherPumpVC
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
extension InspectSelfCleaningVC: UploadCollectionProtocol {
     func didTapOnCellItem(_indexpath: IndexPath, _imgUrl: String, _videoUrl: String) {
        
     }
    
     func didUpdateCellIndex(_indexpath: Int) {
        
     }
}

extension InspectSelfCleaningVC: OpalImagePickerControllerDelegate {
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
                                self.arrImgSelfCleanMain.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataImgSelfCleanMain = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 1 {
                                self.arrImgSelfClean.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataImgSelfClean = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 2 {
                                self.arrImgBoosterMain.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataImgBoosterMain = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 3 {
                                self.arrImgBooster.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataImgBooster = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            }
                            
                            if self.fetchIndexForSubCleanUpload == 0 {
                                self.arrImgCleanOperating.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataCleanOperatingImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubCleanUpload == 1 {
                                self.arrImgCleanMaintaince.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataCleanMaintainceImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubCleanUpload == 2 {
                                self.arrImgCleanAdequateSize.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataCleanAdequateSizeImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubCleanUpload == 3 {
                                self.arrImgCleanMounted.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataCleanMountedImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubCleanUpload == 4 {
                                self.arrImgCleanVisibleLeak.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataCleanVisibleLeakImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubCleanUpload == 5 {
                                self.arrImgCleanGaskets.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataCleanGasketsImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubCleanUpload == 6 {
                                self.arrImgCleanVisibleAdequate.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataCleanVisibleAdequateImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubCleanUpload == 7 {
                                self.arrImgCleanRunQuietly.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataCleanRunQuietlyImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            }
                            
                            if self.fetchIndexForSubBoosterUpload == 0 {
                                self.arrImgBoosterPumpOperating.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataBoosterPumpOperatingImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubBoosterUpload == 1 {
                                self.arrImgBoosterMaintaince.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataBoosterMaintainceImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubBoosterUpload == 2 {
                                self.arrImgBoosterAdequateSize.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataBoosterAdequateSizeImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubBoosterUpload == 3 {
                                self.arrImgBoosterMounted.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataBoosterMountedImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubBoosterUpload == 4 {
                                self.arrImgBoosterVisibleLeak.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataBoosterVisibleLeakImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubBoosterUpload == 5 {
                                self.arrImgBoosterGaskets.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataBoosterGasketsImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubBoosterUpload == 6 {
                                self.arrImgBoosterVisibleAdequateSize.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataBoosterVisibleAdequateSizeImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubBoosterUpload == 7 {
                                self.arrImgBoosterRunQuietly.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataBoosterRunQuietlyImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
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
                self.tblSelfCleaning.reloadData()
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

extension InspectSelfCleaningVC: UIImagePickerControllerDelegate {
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
            self.arrImgSelfCleanMain.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataImgSelfCleanMain = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForUpload == 1 {
            self.arrImgSelfClean.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataImgSelfClean = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForUpload == 2 {
            self.arrImgBoosterMain.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataImgBoosterMain = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForUpload == 3 {
            self.arrImgBoosterMain.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataImgBooster = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        }
        
        if fetchIndexForSubCleanUpload == 0 {
            self.arrImgCleanOperating.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataCleanOperatingImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubCleanUpload == 1 {
            self.arrImgCleanMaintaince.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataCleanMaintainceImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubCleanUpload == 2 {
            self.arrImgCleanAdequateSize.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataCleanAdequateSizeImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubCleanUpload == 3 {
            self.arrImgCleanMounted.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataCleanMountedImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubCleanUpload == 4 {
            self.arrImgCleanVisibleLeak.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataCleanVisibleLeakImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubCleanUpload == 5 {
            self.arrImgCleanGaskets.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataCleanGasketsImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubCleanUpload == 6 {
            self.arrImgCleanVisibleAdequate.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataCleanVisibleAdequateImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubCleanUpload == 7 {
            self.arrImgCleanRunQuietly.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataCleanRunQuietlyImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        }
        
        if fetchIndexForSubBoosterUpload == 0 {
            self.arrImgBoosterPumpOperating.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataBoosterPumpOperatingImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubBoosterUpload == 1 {
            self.arrImgBoosterMaintaince.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataBoosterMaintainceImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubBoosterUpload == 2 {
            self.arrImgBoosterAdequateSize.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataBoosterAdequateSizeImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubBoosterUpload == 3 {
            self.arrImgBoosterMounted.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataBoosterMountedImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubBoosterUpload == 4 {
            self.arrImgBoosterVisibleLeak.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataBoosterVisibleLeakImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubBoosterUpload == 5 {
            self.arrImgBoosterGaskets.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataBoosterGasketsImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubBoosterUpload == 6 {
            self.arrImgBoosterVisibleAdequateSize.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataBoosterVisibleAdequateSizeImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubBoosterUpload == 7 {
            self.arrImgBoosterRunQuietly.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataBoosterRunQuietlyImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        }
        
        
        self.tblSelfCleaning.reloadData()
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
}

extension InspectSelfCleaningVC: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        var cell = UITableViewCell()
        cell = (textView.superview?.superview as? UITableViewCell)!
            
        if let InspectionSelfCleaningTableCell = cell as? InspectionSelfCleaningTableCell {
            if textView == InspectionSelfCleaningTableCell.txtSelfClean {
                self.secInspectSelfClean[InspectSelfClean.selfClean.rawValue].formTextValue = (textView.text)!
           }
        } else if let InspectionBoosterPumpTableCell = cell as? InspectionBoosterPumpTableCell {
            if textView == InspectionBoosterPumpTableCell.txtBoosterPump {
                self.secInspectSelfClean[InspectSelfClean.boosterPump.rawValue].formTextValue = (textView.text)!
           }
        }
        
        if let SelfCleanPumpOperatingTableCell = cell as? SelfCleanPumpOperatingTableCell {
            if textView == SelfCleanPumpOperatingTableCell.txtPumpOperating {
                self.secSelfClean[SelfClean.pumpOperating.rawValue].formTextValue = (textView.text)!
            }
        } else if let SelfCleanMaintaianceAccessTableCell = cell as? SelfCleanMaintaianceAccessTableCell {
            if textView == SelfCleanMaintaianceAccessTableCell.txtCleanMaintenance {
                self.secSelfClean[SelfClean.cleanMaintaince.rawValue].formTextValue = (textView.text)!
            }
        } else if let SelfCleanAdequateSizeTableCell = cell as? SelfCleanAdequateSizeTableCell {
            if textView == SelfCleanAdequateSizeTableCell.txtAdequateSize {
                self.secSelfClean[SelfClean.adequateSize.rawValue].formTextValue = (textView.text)!
            }
        } else if let SelfCleanMountedTableCell = cell as? SelfCleanMountedTableCell {
            if textView == SelfCleanMountedTableCell.txtCleanMounted {
                self.secSelfClean[SelfClean.cleanMounted.rawValue].formTextValue = (textView.text)!
            }
        } else if let SelfCleanVisibleLeakTableCell = cell as? SelfCleanVisibleLeakTableCell {
            if textView == SelfCleanVisibleLeakTableCell.txtCleanVisibleLeak {
                self.secSelfClean[SelfClean.cleanVisibleLeak.rawValue].formTextValue = (textView.text)!
            }
        } else if let SelfCleanGasketsTableCell = cell as? SelfCleanGasketsTableCell {
            if textView == SelfCleanGasketsTableCell.txtCleanGaskets {
                self.secSelfClean[SelfClean.cleanGaskets.rawValue].formTextValue = (textView.text)!
            }
        } else if let SelfCleanVisibleAdequateSizeTableCell = cell as? SelfCleanVisibleAdequateSizeTableCell {
            if textView == SelfCleanVisibleAdequateSizeTableCell.txtCleanVisibleAdequateSize {
                self.secSelfClean[SelfClean.cleanVisibleAdequateSize.rawValue].formTextValue = (textView.text)!
            }
        } else if let SelfCleanRunQuietlyTableCell = cell as? SelfCleanRunQuietlyTableCell {
            if textView == SelfCleanRunQuietlyTableCell.txtCleanRunQuietly {
                self.secSelfClean[SelfClean.cleanRunQuietly.rawValue].formTextValue = (textView.text)!
            }
        }  else if let BoosterPumpOperatingTableCell = cell as? BoosterPumpOperatingTableCell {
            if textView == BoosterPumpOperatingTableCell.txtBoosterPumpOperation {
                self.secBoosterPump[BoosterPump.boosterPumpOperation.rawValue].formTextValue = (textView.text)!
            }
        } else if let BoosterPumpMaintaianceAccessTableCell = cell as? BoosterPumpMaintaianceAccessTableCell {
            if textView == BoosterPumpMaintaianceAccessTableCell.txtBoosterMaintenance {
                self.secBoosterPump[BoosterPump.boosterMaintaince.rawValue].formTextValue = (textView.text)!
            }
        } else if let BoosterPumpAdequateSizeTableCell = cell as? BoosterPumpAdequateSizeTableCell {
            if textView == BoosterPumpAdequateSizeTableCell.txtBoosterAdequateSize {
                self.secBoosterPump[BoosterPump.boosterAdequateSize.rawValue].formTextValue = (textView.text)!
            }
        } else if let BoosterPumpMountedTableCell = cell as? BoosterPumpMountedTableCell {
            if textView == BoosterPumpMountedTableCell.txtBoosterMounted {
                self.secBoosterPump[BoosterPump.boosterMounted.rawValue].formTextValue = (textView.text)!
            }
        } else if let BoosterPumpVisibleLeakTableCell = cell as? BoosterPumpVisibleLeakTableCell {
            if textView == BoosterPumpVisibleLeakTableCell.txtBoosterVisibleLeak {
                self.secBoosterPump[BoosterPump.boosterVisibleLeak .rawValue].formTextValue = (textView.text)!
            }
        } else if let BoosterPumpGasketsTableCell = cell as? BoosterPumpGasketsTableCell {
            if textView == BoosterPumpGasketsTableCell.txtBoosterGaskets {
                self.secBoosterPump[BoosterPump.boosterGaskets.rawValue].formTextValue = (textView.text)!
            }
        } else if let BoosterPumpVisibleAdequateSizeTableCell = cell as? BoosterPumpVisibleAdequateSizeTableCell {
            if textView == BoosterPumpVisibleAdequateSizeTableCell.txtBoosterVisibleAdequateSize {
                self.secBoosterPump[BoosterPump.boosterVisibleAdequateSize.rawValue].formTextValue = (textView.text)!
            }
        } else if let BoosterPumpRunQuietlyTableCell = cell as? BoosterPumpRunQuietlyTableCell {
            if textView == BoosterPumpRunQuietlyTableCell.txtBoosterPumpRun {
                self.secBoosterPump[BoosterPump.boosterPumpRun.rawValue].formTextValue = (textView.text)!
            }
        }
    }
}

extension InspectSelfCleaningVC: UITableViewDataSource, UITableViewDelegate {
    //MARK:- UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 25 {
            return 8
        } else if tableView.tag == 35 {
            return 8
        } else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 25 {
            if indexPath.row == 0 {
                let subSelfCleanCell = tableView.dequeueReusableCell(withIdentifier: "SelfCleanPumpOperatingCell", for: indexPath) as! SelfCleanPumpOperatingTableCell
                
                subSelfCleanCell.btnUpload.addTarget(self, action: #selector(btnSelfCleanImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                subSelfCleanCell.collectionvw.arrItems = arrImgCleanOperating
                subSelfCleanCell.collectionvw.delegateItemCollection = self
                subSelfCleanCell.collectionvw.reloadImageCollection()
                
                if arrImgCleanOperating.count > 0 {
                    subSelfCleanCell.btnUpload.isHidden = true
                    subSelfCleanCell.collectionvw.isHidden = false
                } else {
                    subSelfCleanCell.btnUpload.isHidden = false
                    subSelfCleanCell.collectionvw.isHidden = true
                }
                
                subSelfCleanCell.delegateSelfCleanOperate = self
                subSelfCleanCell.txtPumpOperating.delegate = self
                
                return subSelfCleanCell
            } else if indexPath.row == 1 {
                let subSelfCleanCell = tableView.dequeueReusableCell(withIdentifier: "SelfCleanMaintaianceAccessCell", for: indexPath) as! SelfCleanMaintaianceAccessTableCell
                
                subSelfCleanCell.btnUpload.addTarget(self, action: #selector(btnSelfCleanImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                subSelfCleanCell.collectionvw.arrItems = arrImgCleanMaintaince
                subSelfCleanCell.collectionvw.delegateItemCollection = self
                subSelfCleanCell.collectionvw.reloadImageCollection()
                
                if arrImgCleanMaintaince.count > 0 {
                    subSelfCleanCell.btnUpload.isHidden = true
                    subSelfCleanCell.collectionvw.isHidden = false
                } else {
                    subSelfCleanCell.btnUpload.isHidden = false
                    subSelfCleanCell.collectionvw.isHidden = true
                }
                
                subSelfCleanCell.delegateSelfCleanMaintain =  self
                subSelfCleanCell.txtCleanMaintenance.delegate = self
                
                return subSelfCleanCell
            } else if indexPath.row == 2 {
                let subSelfCleanCell = tableView.dequeueReusableCell(withIdentifier: "SelfCleanAdequateSizeCell", for: indexPath) as! SelfCleanAdequateSizeTableCell
                
                subSelfCleanCell.btnUpload.addTarget(self, action: #selector(btnSelfCleanImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                subSelfCleanCell.collectionvw.arrItems = arrImgCleanAdequateSize
                subSelfCleanCell.collectionvw.delegateItemCollection = self
                subSelfCleanCell.collectionvw.reloadImageCollection()
                
                if arrImgCleanAdequateSize.count > 0 {
                    subSelfCleanCell.btnUpload.isHidden = true
                    subSelfCleanCell.collectionvw.isHidden = false
                } else {
                    subSelfCleanCell.btnUpload.isHidden = false
                    subSelfCleanCell.collectionvw.isHidden = true
                }
                
                subSelfCleanCell.delegateSelfCleanAdequateSize = self
                subSelfCleanCell.txtAdequateSize.delegate = self
                
                return subSelfCleanCell
            } else if indexPath.row == 3 {
                let subSelfCleanCell = tableView.dequeueReusableCell(withIdentifier: "SelfCleanMountedCell", for: indexPath) as! SelfCleanMountedTableCell
                
                subSelfCleanCell.btnUpload.addTarget(self, action: #selector(btnSelfCleanImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                subSelfCleanCell.collectionvw.arrItems = arrImgCleanMounted
                subSelfCleanCell.collectionvw.delegateItemCollection = self
                subSelfCleanCell.collectionvw.reloadImageCollection()
                
                if arrImgCleanMounted.count > 0 {
                    subSelfCleanCell.btnUpload.isHidden = true
                    subSelfCleanCell.collectionvw.isHidden = false
                } else {
                    subSelfCleanCell.btnUpload.isHidden = false
                    subSelfCleanCell.collectionvw.isHidden = true
                }
                
                subSelfCleanCell.delegateSelfCleanMounted = self
                subSelfCleanCell.txtCleanMounted.delegate = self
                
                return subSelfCleanCell
            } else if indexPath.row == 4 {
                let subSelfCleanCell = tableView.dequeueReusableCell(withIdentifier: "SelfCleanVisibleLeakCell", for: indexPath) as! SelfCleanVisibleLeakTableCell
                
                subSelfCleanCell.btnUpload.addTarget(self, action: #selector(btnSelfCleanImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                subSelfCleanCell.collectionvw.arrItems = arrImgCleanVisibleLeak
                subSelfCleanCell.collectionvw.delegateItemCollection = self
                subSelfCleanCell.collectionvw.reloadImageCollection()
                
                if arrImgCleanVisibleLeak.count > 0 {
                    subSelfCleanCell.btnUpload.isHidden = true
                    subSelfCleanCell.collectionvw.isHidden = false
                } else {
                    subSelfCleanCell.btnUpload.isHidden = false
                    subSelfCleanCell.collectionvw.isHidden = true
                }
                
                subSelfCleanCell.delegateSelfCleanVisibleLeak = self
                subSelfCleanCell.txtCleanVisibleLeak.delegate = self
                
                return subSelfCleanCell
            } else if indexPath.row == 5 {
                let subSelfCleanCell = tableView.dequeueReusableCell(withIdentifier: "SelfCleanGasketsCell", for: indexPath) as! SelfCleanGasketsTableCell
                
                subSelfCleanCell.btnUpload.addTarget(self, action: #selector(btnSelfCleanImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                subSelfCleanCell.collectionvw.arrItems = arrImgCleanGaskets
                subSelfCleanCell.collectionvw.delegateItemCollection = self
                subSelfCleanCell.collectionvw.reloadImageCollection()
                
                if arrImgCleanGaskets.count > 0 {
                    subSelfCleanCell.btnUpload.isHidden = true
                    subSelfCleanCell.collectionvw.isHidden = false
                } else {
                    subSelfCleanCell.btnUpload.isHidden = false
                    subSelfCleanCell.collectionvw.isHidden = true
                }
                
                subSelfCleanCell.delegateSelfCleanGaskets = self
                subSelfCleanCell.txtCleanGaskets.delegate = self
                
                return subSelfCleanCell
            } else if indexPath.row == 6 {
                let subSelfCleanCell = tableView.dequeueReusableCell(withIdentifier: "SelfCleanVisibleAdequateSizeCell", for: indexPath) as! SelfCleanVisibleAdequateSizeTableCell
                
                subSelfCleanCell.btnUpload.addTarget(self, action: #selector(btnSelfCleanImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                subSelfCleanCell.collectionvw.arrItems = arrImgCleanVisibleAdequate
                subSelfCleanCell.collectionvw.delegateItemCollection = self
                subSelfCleanCell.collectionvw.reloadImageCollection()
                
                if arrImgCleanVisibleAdequate.count > 0 {
                    subSelfCleanCell.btnUpload.isHidden = true
                    subSelfCleanCell.collectionvw.isHidden = false
                } else {
                    subSelfCleanCell.btnUpload.isHidden = false
                    subSelfCleanCell.collectionvw.isHidden = true
                }
                
                subSelfCleanCell.delegateSelfCleanVisibleAdequateSize = self
                subSelfCleanCell.txtCleanVisibleAdequateSize.delegate = self
                
                return subSelfCleanCell
            } else {//if indexPath.row == 7 {
                let subSelfCleanCell = tableView.dequeueReusableCell(withIdentifier: "SelfCleanRunQuietlyCell", for: indexPath) as! SelfCleanRunQuietlyTableCell
                
                subSelfCleanCell.btnUpload.addTarget(self, action: #selector(btnSelfCleanImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                subSelfCleanCell.collectionvw.arrItems = arrImgCleanRunQuietly
                subSelfCleanCell.collectionvw.delegateItemCollection = self
                subSelfCleanCell.collectionvw.reloadImageCollection()
                
                if arrImgCleanRunQuietly.count > 0 {
                    subSelfCleanCell.btnUpload.isHidden = true
                    subSelfCleanCell.collectionvw.isHidden = false
                } else {
                    subSelfCleanCell.btnUpload.isHidden = false
                    subSelfCleanCell.collectionvw.isHidden = true
                }
                
                subSelfCleanCell.delegateSelfCleanRunQuietly = self
                subSelfCleanCell.txtCleanRunQuietly.delegate = self
                
                return subSelfCleanCell
            }
        } else if tableView.tag == 35 {
            if indexPath.row == 0 {
                let subBoosterCell = tableView.dequeueReusableCell(withIdentifier: "BoosterPumpOperatingCell", for: indexPath) as! BoosterPumpOperatingTableCell
                
                subBoosterCell.btnUpload.addTarget(self, action: #selector(btnBoosterImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                subBoosterCell.collectionvw.arrItems = arrImgBoosterPumpOperating
                subBoosterCell.collectionvw.delegateItemCollection = self
                subBoosterCell.collectionvw.reloadImageCollection()
                
                if arrImgBoosterPumpOperating.count > 0 {
                    subBoosterCell.btnUpload.isHidden = true
                    subBoosterCell.collectionvw.isHidden = false
                } else {
                    subBoosterCell.btnUpload.isHidden = false
                    subBoosterCell.collectionvw.isHidden = true
                }
                
                subBoosterCell.delegateBoosterOperate = self
                subBoosterCell.txtBoosterPumpOperation.delegate = self
                
                return subBoosterCell
            } else if indexPath.row == 1 {
                let subBoosterCell = tableView.dequeueReusableCell(withIdentifier: "BoosterPumpMaintaianceAccessCell", for: indexPath) as! BoosterPumpMaintaianceAccessTableCell
                
                subBoosterCell.btnUpload.addTarget(self, action: #selector(btnBoosterImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                subBoosterCell.collectionvw.arrItems = arrImgBoosterMaintaince
                subBoosterCell.collectionvw.delegateItemCollection = self
                subBoosterCell.collectionvw.reloadImageCollection()
                
                if arrImgBoosterMaintaince.count > 0 {
                    subBoosterCell.btnUpload.isHidden = true
                    subBoosterCell.collectionvw.isHidden = false
                } else {
                    subBoosterCell.btnUpload.isHidden = false
                    subBoosterCell.collectionvw.isHidden = true
                }
                
                subBoosterCell.delegateBoosterMaintain = self
                subBoosterCell.txtBoosterMaintenance.delegate = self
                
                return subBoosterCell
            } else if indexPath.row == 2 {
                let subBoosterCell = tableView.dequeueReusableCell(withIdentifier: "BoosterPumpAdequateSizeCell", for: indexPath) as! BoosterPumpAdequateSizeTableCell
                
                subBoosterCell.btnUpload.addTarget(self, action: #selector(btnBoosterImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                subBoosterCell.collectionvw.arrItems = arrImgBoosterAdequateSize
                subBoosterCell.collectionvw.delegateItemCollection = self
                subBoosterCell.collectionvw.reloadImageCollection()
                
                if arrImgBoosterAdequateSize.count > 0 {
                    subBoosterCell.btnUpload.isHidden = true
                    subBoosterCell.collectionvw.isHidden = false
                } else {
                    subBoosterCell.btnUpload.isHidden = false
                    subBoosterCell.collectionvw.isHidden = true
                }
                
                subBoosterCell.delegateBoosterAdequateSize = self
                subBoosterCell.txtBoosterAdequateSize.delegate = self
                
                return subBoosterCell
            } else if indexPath.row == 3 {
                let subBoosterCell = tableView.dequeueReusableCell(withIdentifier: "BoosterPumpMountedCell", for: indexPath) as! BoosterPumpMountedTableCell
                
                subBoosterCell.btnUpload.addTarget(self, action: #selector(btnBoosterImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                subBoosterCell.collectionvw.arrItems = arrImgBoosterMounted
                subBoosterCell.collectionvw.delegateItemCollection = self
                subBoosterCell.collectionvw.reloadImageCollection()
                
                if arrImgBoosterMounted.count > 0 {
                    subBoosterCell.btnUpload.isHidden = true
                    subBoosterCell.collectionvw.isHidden = false
                } else {
                    subBoosterCell.btnUpload.isHidden = false
                    subBoosterCell.collectionvw.isHidden = true
                }
                
                subBoosterCell.delegateBoosterMounted = self
                subBoosterCell.txtBoosterMounted.delegate = self
                
                return subBoosterCell
            } else if indexPath.row == 4 {
                let subBoosterCell = tableView.dequeueReusableCell(withIdentifier: "BoosterPumpVisibleLeakCell", for: indexPath) as! BoosterPumpVisibleLeakTableCell
                
                subBoosterCell.btnUpload.addTarget(self, action: #selector(btnBoosterImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                subBoosterCell.collectionvw.arrItems = arrImgBoosterVisibleLeak
                subBoosterCell.collectionvw.delegateItemCollection = self
                subBoosterCell.collectionvw.reloadImageCollection()
                
                if arrImgBoosterVisibleLeak.count > 0 {
                    subBoosterCell.btnUpload.isHidden = true
                    subBoosterCell.collectionvw.isHidden = false
                } else {
                    subBoosterCell.btnUpload.isHidden = false
                    subBoosterCell.collectionvw.isHidden = true
                }
                
                subBoosterCell.delegateBoosterVisibleLeak = self
                subBoosterCell.txtBoosterVisibleLeak.delegate = self
                
                return subBoosterCell
            } else if indexPath.row == 5 {
                let subBoosterCell = tableView.dequeueReusableCell(withIdentifier: "BoosterPumpGasketsCell", for: indexPath) as! BoosterPumpGasketsTableCell
                
                subBoosterCell.btnUpload.addTarget(self, action: #selector(btnBoosterImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                subBoosterCell.collectionvw.arrItems = arrImgBoosterGaskets
                subBoosterCell.collectionvw.delegateItemCollection = self
                subBoosterCell.collectionvw.reloadImageCollection()
                
                if arrImgBoosterGaskets.count > 0 {
                    subBoosterCell.btnUpload.isHidden = true
                    subBoosterCell.collectionvw.isHidden = false
                } else {
                    subBoosterCell.btnUpload.isHidden = false
                    subBoosterCell.collectionvw.isHidden = true
                }
                
                subBoosterCell.delegateBoosterGaskets = self
                subBoosterCell.txtBoosterGaskets.delegate = self
                
                return subBoosterCell
            } else if indexPath.row == 6 {
                let subBoosterCell = tableView.dequeueReusableCell(withIdentifier: "BoosterPumpVisibleAdequateSizeCell", for: indexPath) as! BoosterPumpVisibleAdequateSizeTableCell
                
                subBoosterCell.btnUpload.addTarget(self, action: #selector(btnBoosterImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                subBoosterCell.collectionvw.arrItems = arrImgBoosterVisibleAdequateSize
                subBoosterCell.collectionvw.delegateItemCollection = self
                subBoosterCell.collectionvw.reloadImageCollection()
                
                if arrImgBoosterVisibleAdequateSize.count > 0 {
                    subBoosterCell.btnUpload.isHidden = true
                    subBoosterCell.collectionvw.isHidden = false
                } else {
                    subBoosterCell.btnUpload.isHidden = false
                    subBoosterCell.collectionvw.isHidden = true
                }
                
                subBoosterCell.delegateBoosterVisibleAdequateSize =  self
                subBoosterCell.txtBoosterVisibleAdequateSize.delegate = self
                
                return subBoosterCell
            } else {//} if indexPath.row == 7 {
                let subBoosterCell = tableView.dequeueReusableCell(withIdentifier: "BoosterPumpRunQuietlyCell", for: indexPath) as! BoosterPumpRunQuietlyTableCell
                
                subBoosterCell.btnUpload.addTarget(self, action: #selector(btnBoosterImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                subBoosterCell.collectionvw.arrItems = arrImgBoosterRunQuietly
                subBoosterCell.collectionvw.delegateItemCollection = self
                subBoosterCell.collectionvw.reloadImageCollection()
                
                if arrImgBoosterRunQuietly.count > 0 {
                    subBoosterCell.btnUpload.isHidden = true
                    subBoosterCell.collectionvw.isHidden = false
                } else {
                    subBoosterCell.btnUpload.isHidden = false
                    subBoosterCell.collectionvw.isHidden = true
                }
                
                subBoosterCell.delegateBoosterRunQuietly =  self
                subBoosterCell.txtBoosterPumpRun.delegate = self
                
                return subBoosterCell
            }
        } else {
            if indexPath.row == 0 {
                let cameraCell = tableView.dequeueReusableCell(withIdentifier: "CameraCell", for: indexPath) as! CameraTableCell
                
                cameraCell.lblHeader.text = "SELF CLEANING PUMP"
                
                cameraCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                cameraCell.collectionVw.arrItems = arrImgSelfCleanMain
                cameraCell.collectionVw.delegateItemCollection = self
                cameraCell.collectionVw.reloadImageCollection()
                
                if arrImgSelfCleanMain.count > 0 {
                    cameraCell.btnUpload.isHidden = true
                    cameraCell.collectionVw.isHidden = false
                } else {
                    cameraCell.btnUpload.isHidden = false
                    cameraCell.collectionVw.isHidden = true
                }
                
                return cameraCell
            } else if indexPath.row == 1 {
                let InspectionSelfCleaningCell = tableView.dequeueReusableCell(withIdentifier: "InspectionSelfCleaningCell", for: indexPath) as! InspectionSelfCleaningTableCell
                
                InspectionSelfCleaningCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                InspectionSelfCleaningCell.collectionvw.arrItems = arrImgSelfClean
                InspectionSelfCleaningCell.collectionvw.delegateItemCollection = self
                InspectionSelfCleaningCell.collectionvw.reloadImageCollection()
                
                if arrImgSelfClean.count > 0 {
                    InspectionSelfCleaningCell.btnUpload.isHidden = true
                    InspectionSelfCleaningCell.collectionvw.isHidden = false
                } else {
                    InspectionSelfCleaningCell.btnUpload.isHidden = false
                    InspectionSelfCleaningCell.collectionvw.isHidden = true
                }
                
                if strSelfCleanOption == "Yes" {
                    //Declare the outlet in our custom class
                    let tblSelfCleaning = InspectionSelfCleaningCell.viewWithTag(25) as! UITableView
                    
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        InspectionSelfCleaningCell.tblSelfCleanHeightConstraint.constant = 350*7+345
                    } else {
                        InspectionSelfCleaningCell.tblSelfCleanHeightConstraint.constant = 600*7+585
                    }
                    tblSelfCleaning.delegate = self
                    tblSelfCleaning.dataSource = self
                    tblSelfCleaning.reloadData()
                } else if strSelfCleanOption == "No" {
                    InspectionSelfCleaningCell.tblSelfCleanHeightConstraint.constant = 0
                }
                
                InspectionSelfCleaningCell.delegateSelfCleanPump = self
                InspectionSelfCleaningCell.txtSelfClean.delegate = self
                
                return InspectionSelfCleaningCell
            } else if indexPath.row == 2 {
                let cameraCell = tableView.dequeueReusableCell(withIdentifier: "CameraCell", for: indexPath) as! CameraTableCell
                
                cameraCell.lblHeader.text = "BOOSTER PUMP FOR PRESSURE SIDE CLEANER"
                
                cameraCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                cameraCell.collectionVw.arrItems = arrImgBoosterMain
                cameraCell.collectionVw.delegateItemCollection = self
                cameraCell.collectionVw.reloadImageCollection()
                
                if arrImgBoosterMain.count > 0 {
                    cameraCell.btnUpload.isHidden = true
                    cameraCell.collectionVw.isHidden = false
                } else {
                    cameraCell.btnUpload.isHidden = false
                    cameraCell.collectionVw.isHidden = true
                }
                
                return cameraCell
            } else if indexPath.row == 3 {
                let InspectionBoosterPumpCell = tableView.dequeueReusableCell(withIdentifier: "InspectionBoosterPumpCell", for: indexPath) as! InspectionBoosterPumpTableCell
                
                InspectionBoosterPumpCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                InspectionBoosterPumpCell.collectionvw.arrItems = arrImgBooster
                InspectionBoosterPumpCell.collectionvw.delegateItemCollection = self
                InspectionBoosterPumpCell.collectionvw.reloadImageCollection()
                
                if arrImgBooster.count > 0 {
                    InspectionBoosterPumpCell.btnUpload.isHidden = true
                    InspectionBoosterPumpCell.collectionvw.isHidden = false
                } else {
                    InspectionBoosterPumpCell.btnUpload.isHidden = false
                    InspectionBoosterPumpCell.collectionvw.isHidden = true
                }
                
                if strBoosterPumpOption == "Yes" {
                    //Declare the outlet in our custom class
                    let tblBooster = InspectionBoosterPumpCell.viewWithTag(35) as! UITableView
                    
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        InspectionBoosterPumpCell.tblBoosterPumpHeightConstraint.constant = 350*7+345
                    } else {
                        InspectionBoosterPumpCell.tblBoosterPumpHeightConstraint.constant = 600*7+585
                    }
                    tblBooster.delegate = self
                    tblBooster.dataSource = self
                    tblBooster.reloadData()
                } else if strBoosterPumpOption == "No" {
                    InspectionBoosterPumpCell.tblBoosterPumpHeightConstraint.constant = 0
                }
                
                InspectionBoosterPumpCell.delegateBoosterPump = self
                InspectionBoosterPumpCell.txtBoosterPump.delegate = self
                
                return InspectionBoosterPumpCell
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
                if indexPath.row == 7 {
                    return 340
                } else {
                    return 340
                }
            } else if tableView.tag == 35 {
                if indexPath.row == 7 {
                    return 340
                } else {
                    return 345
                }
            } else {
                if indexPath.row == 0 {
                    return 185
                } else if indexPath.row == 1 {
                    if strSelfCleanOption == "Yes" {
                        return (340*7+345)+340//UITableView.automaticDimension//
                    } else {
                        return 340
                    }
                } else if indexPath.row == 2 {
                    return 185
                } else if indexPath.row == 3 {
                    if strBoosterPumpOption == "Yes" {
                        return (340*7+345)+340//UITableView.automaticDimension//
                    } else {
                        return 340
                    }
                } else {
                    return 105
                }
            }
        } else {        //.pad
            if tableView.tag == 25 {
                if indexPath.row == 7 {
                    return 585
                } else {
                    return 600
                }
            } else if tableView.tag == 35 {
                if indexPath.row == 7 {
                    return 585
                } else {
                    return 600
                }
            } else {
                if indexPath.row == 0 {
                    return 185
                } else if indexPath.row == 1 {
                    if strSelfCleanOption == "Yes" {
                        return (600*7+585)+615//UITableView.automaticDimension//
                    } else {
                        return 615
                    }
                } else if indexPath.row == 2 {
                    return 185
                } else if indexPath.row == 3 {
                    if strBoosterPumpOption == "Yes" {
                        return (600*7+585)+615//UITableView.automaticDimension//
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

extension InspectSelfCleaningVC: SelfCleanPumpCellProtocol, SelfCleanOperateCellProtocol, SelfCleanMaintainCellProtocol, SelfCleanAdequateSizeCellProtocol, SelfCleanMountedCellProtocol, SelfCleanVisibleLeakCellProtocol, SelfCleanGasketsCellProtocol, SelfCleanVisibleAdequateSizeCellProtocol, SelfCleanRunQuietlyCellProtocol, BoosterPumpCellProtocol, BoosterOperateCellProtocol, BoosterMaintainCellProtocol, BoosterAdequateSizeCellProtocol, BoosterMountedCellProtocol, BoosterVisibleLeakCellProtocol, BoosterGasketsCellProtocol, BoosterVisibleAdequateSizeCellProtocol, BoosterRunQuietlyCellProtocol {
    //MARK:- Self Clean Protocol
    func didTapOnCellSelfClean(_btnSelfCleanTag: Int) {
       if _btnSelfCleanTag == 0 {
           strSelfCleanOption = "Yes"
       }  else if _btnSelfCleanTag == 1 {
           strSelfCleanOption = "No"
       }
       self.tblSelfCleaning.reloadData()
    }
    
    func didTapOnCellSelfCleanOperate(_btnSelfCleanTag: Int) {
        if _btnSelfCleanTag == 0 {
            strOptCleanOperating = "Yes"
        }  else if _btnSelfCleanTag == 1 {
            strOptCleanOperating = "No"
        }
        self.tblSelfCleaning.reloadData()
    }
    
    func didTapOnCellSelfCleanMaintain(_btnSelfCleanTag: Int) {
        if _btnSelfCleanTag == 0 {
            strOptCleanMaintaince = "Yes"
        }  else if _btnSelfCleanTag == 1 {
            strOptCleanMaintaince = "No"
        }
        self.tblSelfCleaning.reloadData()
    }
    
    func didTapOnCellSelfCleanAdequateSize(_btnSelfCleanTag: Int) {
        if _btnSelfCleanTag == 0 {
            strOptCleanAdequateSize = "Yes"
        }  else if _btnSelfCleanTag == 1 {
            strOptCleanAdequateSize = "No"
        }
        self.tblSelfCleaning.reloadData()
    }
    
    func didTapOnCellSelfCleanMounted(_btnSelfCleanTag: Int) {
        if _btnSelfCleanTag == 0 {
            strOptCleanMounted = "Yes"
        }  else if _btnSelfCleanTag == 1 {
            strOptCleanMounted = "No"
        }
        self.tblSelfCleaning.reloadData()
    }
    
    func didTapOnCellSelfCleanVisibleLeak(_btnSelfCleanTag: Int) {
        if _btnSelfCleanTag == 0 {
            strOptCleanVisibleLeak = "Yes"
        }  else if _btnSelfCleanTag == 1 {
            strOptCleanVisibleLeak = "No"
        }
        self.tblSelfCleaning.reloadData()
    }
    
    func didTapOnCellSelfCleanGaskets(_btnSelfCleanTag: Int) {
        if _btnSelfCleanTag == 0 {
            strOptCleanGaskets = "Yes"
        }  else if _btnSelfCleanTag == 1 {
            strOptCleanGaskets = "No"
        }
        self.tblSelfCleaning.reloadData()
    }
    
    func didTapOnCellSelfCleanVisibleAdequateSize(_btnSelfCleanTag: Int) {
        if _btnSelfCleanTag == 0 {
            strOptCleanVisibleAdequate = "Yes"
        }  else if _btnSelfCleanTag == 1 {
            strOptCleanVisibleAdequate = "No"
        }
        self.tblSelfCleaning.reloadData()
    }
    
    func didTapOnCellSelfCleanRunQuietly(_btnSelfCleanTag: Int) {
        if _btnSelfCleanTag == 0 {
            strOptCleanRunQuietly = "Yes"
        }  else if _btnSelfCleanTag == 1 {
            strOptCleanRunQuietly = "No"
        }
        self.tblSelfCleaning.reloadData()
    }
    
    //MARK:- Booster Pump Protocol
    func didTapOnCellBoosterPump(_btnBoosterPumpTag: Int) {
       if _btnBoosterPumpTag == 0 {
           strBoosterPumpOption = "Yes"
       }  else if _btnBoosterPumpTag == 1 {
           strBoosterPumpOption = "No"
       }
       self.tblSelfCleaning.reloadData()
    }
    
    func didTapOnCellBoosterOperate(_btnBoosterPumpTag: Int) {
        if _btnBoosterPumpTag == 0 {
            strOptBoosterPumpOperating = "Yes"
        }  else if _btnBoosterPumpTag == 1 {
            strOptBoosterPumpOperating = "No"
        }
        self.tblSelfCleaning.reloadData()
    }
    
    func didTapOnCellBoosterMaintain(_btnBoosterPumpTag: Int) {
        if _btnBoosterPumpTag == 0 {
            strOptBoosterMaintaince = "Yes"
        }  else if _btnBoosterPumpTag == 1 {
            strOptBoosterMaintaince = "No"
        }
        self.tblSelfCleaning.reloadData()
    }
    
    func didTapOnCellBoosterAdequateSize(_btnBoosterPumpTag: Int) {
        if _btnBoosterPumpTag == 0 {
            strOptBoosterAdequateSize = "Yes"
        }  else if _btnBoosterPumpTag == 1 {
            strOptBoosterAdequateSize = "No"
        }
        self.tblSelfCleaning.reloadData()
    }
    
    func didTapOnCellBoosterMounted(_btnBoosterPumpTag: Int) {
        if _btnBoosterPumpTag == 0 {
            strOptBoosterMounted = "Yes"
        }  else if _btnBoosterPumpTag == 1 {
            strOptBoosterMounted = "No"
        }
        self.tblSelfCleaning.reloadData()
    }
    
    func didTapOnCellBoosterVisibleLeak(_btnBoosterPumpTag: Int) {
        if _btnBoosterPumpTag == 0 {
            strOptBoosterVisibleLeak = "Yes"
        }  else if _btnBoosterPumpTag == 1 {
            strOptBoosterVisibleLeak = "No"
        }
        self.tblSelfCleaning.reloadData()
    }
    
    func didTapOnCellBoosterGaskets(_btnBoosterPumpTag: Int) {
        if _btnBoosterPumpTag == 0 {
            strOptBoosterGaskets = "Yes"
        }  else if _btnBoosterPumpTag == 1 {
            strOptBoosterGaskets = "No"
        }
        self.tblSelfCleaning.reloadData()
    }
    
    func didTapOnCellBoosterVisibleAdequateSize(_btnBoosterPumpTag: Int) {
        if _btnBoosterPumpTag == 0 {
            strOptBoosterVisibleAdequateSize = "Yes"
        }  else if _btnBoosterPumpTag == 1 {
            strOptBoosterVisibleAdequateSize = "No"
        }
        self.tblSelfCleaning.reloadData()
    }
    
    func didTapOnCellBoosterRunQuietly(_btnBoosterPumpTag: Int) {
        if _btnBoosterPumpTag == 0 {
            strOptBoosterRunQuietly = "Yes"
        }  else if _btnBoosterPumpTag == 1 {
            strOptBoosterRunQuietly = "No"
        }
        self.tblSelfCleaning.reloadData()
    }
}
