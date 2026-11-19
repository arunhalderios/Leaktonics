//
//  InspectSwimJetSystemVC.swift
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


class InspectSwimJetSystemVC: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var tblSwimJets: UITableView!
    
    var secInspectSwimJet = [formInspectionPoolData]()
    var secSwimJet = [formInspectionPoolData]()
    var secWaterFeature = [formInspectionPoolData]()
    
    enum InspectSwimJet: Int {
        case swimJetSystem = 1
        case waterFeature = 3
    }
    
    enum SwimJetSystem: Int {
        case pumpOperating = 0
        case swimJetMaintaince = 1
        case swimAdequateSize = 3
        case swimMounted = 4
        case swimVisibleLeak = 5
        case swimGaskets = 6
        case swimVisibleAdequateSize = 7
        case swimRunQuietly = 8
    }
    
    enum WaterFeature: Int {
        case swimJetWaterFeature = 0
        case swimWaterOperating = 1
        case swimWaterMaintenance = 2
        case swimWaterAdequateSize = 3
        case swimWaterMounted = 4
        case swimWaterVisibleLeak = 5
        case swimWaterGaskets = 6
        case swimWaterVisibleAdequateSize = 7
        case swimFeatureRunQuietly = 8
    }
    
    var fetchIndexForUpload: Int = -1
    var fetchIndexForSubSwimUpload: Int = -1
    var fetchIndexForSubWaterUpload: Int = -1
    
    var imagePicker = UIImagePickerController()
    var picker:UIImagePickerController? = UIImagePickerController()
    
    
    //For Images
    var arrImgSwimJetMain: [CollectionImageObject] = []
    var arrImgSwimJet: [CollectionImageObject] = []
    var arrImgWaterMain: [CollectionImageObject] = []
    var arrImgWater: [CollectionImageObject] = []
    
    var arrImgPumpOperating: [CollectionImageObject] = []
    var arrImgMaintaince: [CollectionImageObject] = []
    var arrImgSwimAdequateSize: [CollectionImageObject] = []
    var arrImgSwimMounted: [CollectionImageObject] = []
    var arrImgSwimVisibleLeak: [CollectionImageObject] = []
    var arrImgSwimGaskets: [CollectionImageObject] = []
    var arrImgSwimVisibleAdequate: [CollectionImageObject] = []
    var arrImgSwimRunQuietly: [CollectionImageObject] = []
    
    var arrImgWaterOperating: [CollectionImageObject] = []
    var arrImgWaterMaintaince: [CollectionImageObject] = []
    var arrImgWaterAdequateSize: [CollectionImageObject] = []
    var arrImgWaterMounted: [CollectionImageObject] = []
    var arrImgWaterVisibleLeak: [CollectionImageObject] = []
    var arrImgWaterGaskets: [CollectionImageObject] = []
    var arrImgWaterVisibleAdequate: [CollectionImageObject] = []
    var arrImgWaterRunQuietly: [CollectionImageObject] = []
    
    //For Image Server path
    var strImgSwimJetMain = String()
    var strImgSwimJet = String()
    var strImgWaterMain = String()
    var strImgWater = String()
    
    var strSwimPumpOperatingImg = String()
    var strSwimMaintainceImg = String()
    var strSwimAdequateSizeImg = String()
    var strSwimMountedImg = String()
    var strSwimVisibleLeakImg = String()
    var strSwimGasketsImg = String()
    var strSwimVisibleAdequateImg = String()
    var strSwimRunQuietlyImg = String()
    
    var strWaterOperatingImg = String()
    var strWaterMaintainceImg = String()
    var strWaterAdequateSizeImg = String()
    var strWaterMountedImg = String()
    var strWaterVisibleLeakImg = String()
    var strWaterGasketsImg = String()
    var strWaterVisibleAdequateImg = String()
    var strWaterRunQuietlyImg = String()
    
    
    //For Image CoreData
    var dataImgSwimJetMain = NSData()
    var dataImgSwimJet = NSData()
    var dataImgWaterMain = NSData()
    var dataImgWater = NSData()
    
    var dataSwimPumpOperatingImg = NSData()
    var dataSwimMaintainceImg = NSData()
    var dataSwimAdequateSizeImg = NSData()
    var dataSwimMountedImg = NSData()
    var dataSwimVisibleLeakImg = NSData()
    var dataSwimGasketsImg = NSData()
    var dataSwimVisibleAdequateImg = NSData()
    var dataSwimRunQuietlyImg = NSData()
    
    var dataWaterOperatingImg = NSData()
    var dataWaterMaintainceImg = NSData()
    var dataWaterAdequateSizeImg = NSData()
    var dataWaterMountedImg = NSData()
    var dataWaterVisibleLeakImg = NSData()
    var dataWaterGasketsImg = NSData()
    var dataWaterVisibleAdequateImg = NSData()
    var dataWaterRunQuietlyImg = NSData()
    
    
    //For Optional Values
    var strSwimJetSystemOption = String()
    var strWaterFeatureOption = String()
    
    var strOptPumpOperating = String()
    var strOptMaintaince = String()
    var strOptAdequateSize = String()
    var strOptMounted = String()
    var strOptVisibleLeak = String()
    var strOptGaskets = String()
    var strOptVisibleAdequate = String()
    var strOptRunQuietly = String()
    
    var strOptWaterOperating = String()
    var strOptWaterMaintaince = String()
    var strOptWaterAdequateSize = String()
    var strOptWaterMounted = String()
    var strOptWaterVisibleLeak = String()
    var strOptWaterGaskets = String()
    var strOptWaterVisibleAdequate = String()
    var strOptWaterRunQuietly = String()
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.prepareFormSwimJetsData()
    }
    
    func prepareFormSwimJetsData() {
        for _ in 0..<5 {
            let obj = formInspectionPoolData()
            self.secInspectSwimJet.append(obj)
        }
        for _ in 0..<9 {
            let obj = formInspectionPoolData()
            self.secSwimJet.append(obj)
        }
        for _ in 0..<9 {
            let obj = formInspectionPoolData()
            self.secWaterFeature.append(obj)
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
        let indexOfCell = self.tblSwimJets.indexPath(for: cell)
        print("Clicked Index : \(String(describing: indexOfCell?.row))")
        
        fetchIndexForSubSwimUpload = -1
        fetchIndexForSubWaterUpload = -1
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
    
    @objc func btnSwimImgUpload(_ sender: Any) {
        print("Button pressed 👍 ")
        let btn = sender as! UIButton
        let cell = btn.superview?.superview?.superview as! UITableViewCell
        let tblSubSwim = self.view.viewWithTag(25) as! UITableView
        let indexOfCell = tblSubSwim.indexPath(for: cell)
        print("Clicked Index : \(String(describing: indexOfCell?.row))")
        fetchIndexForUpload = -1
        fetchIndexForSubSwimUpload = (indexOfCell?.row)!
        
        print("Upload Index : \(String(describing: fetchIndexForSubSwimUpload))")
        
        self.actionSheetPopUpForGalleryOpen()
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc func btnWaterImgUpload(_ sender: Any) {
        print("Button pressed 👍 ")
        let btn = sender as! UIButton
        let cell = btn.superview?.superview?.superview as! UITableViewCell
        let tblSubSwim = self.view.viewWithTag(35) as! UITableView
        let indexOfCell = tblSubSwim.indexPath(for: cell)
        print("Clicked Index : \(String(describing: indexOfCell?.row))")
        fetchIndexForUpload = -1
        fetchIndexForSubWaterUpload = (indexOfCell?.row)!
        
        print("Upload Index : \(String(describing: fetchIndexForSubWaterUpload))")
        
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
        //self.postInspectSwimJetSystem()
        if UIDevice.current.userInterfaceIdiom == .phone {
            let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
            let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectSelfCleaning") as! InspectSelfCleaningVC
            self.navigationController?.pushViewController(formVC, animated: true)
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
            let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectSwimJetSystem") as! InspectSwimJetSystemVC
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
                    
                    managedObject.setValue(dataImgSwimJetMain, forKey: "swimJetsMainImage")
                    managedObject.setValue(strSwimJetSystemOption, forKey: "swimJetsOption")
                    managedObject.setValue(dataImgSwimJet, forKey: "swimJetsImage")
                    managedObject.setValue(self.secInspectSwimJet[InspectSwimJet.swimJetSystem.rawValue].formTextValue, forKey: "swimJetsData")
                    managedObject.setValue(dataImgWaterMain, forKey: "waterFeatureMainImage")
                    managedObject.setValue(strWaterFeatureOption, forKey: "waterFeatureOption")
                    managedObject.setValue(dataImgWater, forKey: "waterFeatureImage")
                    managedObject.setValue(self.secInspectSwimJet[InspectSwimJet.waterFeature.rawValue].formTextValue, forKey: "waterFeatureData")
                    managedObject.setValue(strOptPumpOperating, forKey: "swimPumpOperatingOption")
                    managedObject.setValue(dataSwimPumpOperatingImg, forKey: "swimPumpOperatingImage")
                    managedObject.setValue(self.secSwimJet[SwimJetSystem.pumpOperating.rawValue].formTextValue, forKey: "swimPumpOperatingData")
                    managedObject.setValue(strOptMaintaince, forKey: "swimMaintainceOption")
                    managedObject.setValue(dataSwimMaintainceImg, forKey: "swimMaintainceImage")
                    managedObject.setValue(self.secSwimJet[SwimJetSystem.swimJetMaintaince.rawValue].formTextValue, forKey: "swimMaintainceData")
                    managedObject.setValue(strOptAdequateSize, forKey: "swimAdequateSizeOption")
                    managedObject.setValue(dataSwimAdequateSizeImg, forKey: "swimAdequateSizeImage")
                    managedObject.setValue(self.secSwimJet[SwimJetSystem.swimAdequateSize.rawValue].formTextValue, forKey: "swimAdequateSizeData")
                    managedObject.setValue(strOptMounted, forKey: "swimMountedOption")
                    managedObject.setValue(dataSwimMountedImg, forKey: "swimMountedImage")
                    managedObject.setValue(self.secSwimJet[SwimJetSystem.swimMounted.rawValue].formTextValue, forKey: "swimMountedData")
                    managedObject.setValue(strOptVisibleLeak, forKey: "swimVisibleLeakOption")
                    managedObject.setValue(dataSwimVisibleLeakImg, forKey: "swimVisibleLeakImage")
                    managedObject.setValue(self.secSwimJet[SwimJetSystem.swimVisibleLeak.rawValue].formTextValue, forKey: "swimVisibleLeakData")
                    managedObject.setValue(strOptGaskets, forKey: "swimGasketsdOption")
                    managedObject.setValue(dataSwimGasketsImg, forKey: "swimGasketsImage")
                    managedObject.setValue(self.secSwimJet[SwimJetSystem.swimGaskets.rawValue].formTextValue, forKey: "swimGasketsData")
                    managedObject.setValue(strOptVisibleAdequate, forKey: "swimVisibleAdequateOption")
                    managedObject.setValue(dataSwimVisibleAdequateImg, forKey: "swimVisibleAdequateImage")
                    managedObject.setValue(self.secSwimJet[SwimJetSystem.swimVisibleAdequateSize.rawValue].formTextValue, forKey: "swimVisibleAdequateData")
                    managedObject.setValue(strOptRunQuietly, forKey: "swimRunQuietlyOption")
                    managedObject.setValue(dataSwimRunQuietlyImg, forKey: "swimRunQuietlyImage")
                    managedObject.setValue(self.secSwimJet[SwimJetSystem.swimRunQuietly.rawValue].formTextValue, forKey: "swimRunQuietlyData")
                    managedObject.setValue(strOptWaterOperating, forKey: "waterOperatingOption")
                    managedObject.setValue(dataWaterOperatingImg, forKey: "waterOperatingImage")
                    managedObject.setValue(self.secWaterFeature[WaterFeature.swimWaterOperating.rawValue].formTextValue, forKey: "waterOperatingData")
                    managedObject.setValue(strOptWaterMaintaince, forKey: "waterMaintainceOption")
                    managedObject.setValue(dataWaterMaintainceImg, forKey: "waterMaintainceImage")
                    managedObject.setValue(self.secWaterFeature[WaterFeature.swimWaterMaintenance.rawValue].formTextValue, forKey: "waterMaintainceData")
                    managedObject.setValue(strOptWaterAdequateSize, forKey: "waterAdequateSizeOption")
                    managedObject.setValue(dataWaterAdequateSizeImg, forKey: "waterAdequateSizeImage")
                    managedObject.setValue(self.secWaterFeature[WaterFeature.swimWaterAdequateSize.rawValue].formTextValue, forKey: "waterAdequateSizeData")
                    managedObject.setValue(strOptWaterMounted, forKey: "waterMountedOption")
                    managedObject.setValue(dataWaterMountedImg, forKey: "waterMountedImage")
                    managedObject.setValue(self.secWaterFeature[WaterFeature.swimWaterMounted.rawValue].formTextValue, forKey: "waterMountedData")
                    managedObject.setValue(strOptWaterVisibleLeak, forKey: "waterVisibleLeakOption")
                    managedObject.setValue(dataWaterVisibleLeakImg, forKey: "waterVisibleLeakImage")
                    managedObject.setValue(self.secWaterFeature[WaterFeature.swimWaterVisibleLeak.rawValue].formTextValue, forKey: "waterVisibleLeakData")
                    managedObject.setValue(strOptWaterGaskets, forKey: "waterGasketsOption")
                    managedObject.setValue(dataWaterGasketsImg, forKey: "waterGasketsImage")
                    managedObject.setValue(self.secWaterFeature[WaterFeature.swimWaterGaskets.rawValue].formTextValue, forKey: "waterGasketsData")
                    managedObject.setValue(strOptWaterVisibleAdequate, forKey: "waterVisibleAdequateOption")
                    managedObject.setValue(dataSwimVisibleAdequateImg, forKey: "waterVisibleAdequateImage")
                    managedObject.setValue(self.secWaterFeature[WaterFeature.swimWaterVisibleAdequateSize.rawValue].formTextValue, forKey: "waterVisibleAdequateData")
                    managedObject.setValue(strOptWaterRunQuietly, forKey: "waterRunQuietlyOption")
                    managedObject.setValue(dataWaterRunQuietlyImg, forKey: "waterRunQuietlyImage")
                    managedObject.setValue(self.secWaterFeature[WaterFeature.swimFeatureRunQuietly.rawValue].formTextValue, forKey: "waterRunQuietlyData")
                    
                    
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
                        print("Data of InspectSwimJetSystemVC:: \(data)")
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
                        self.strImgSwimJetMain = String(describing: data!)
                    } else if self.fetchIndexForUpload == 1 {
                        self.strImgSwimJet = String(describing: data!)
                    } else if self.fetchIndexForUpload == 2 {
                        self.strImgWaterMain = String(describing: data!)
                    } else if self.fetchIndexForUpload == 3 {
                        self.strImgWater = String(describing: data!)
                    }
                    
                    if self.fetchIndexForSubSwimUpload == 0 {
                        self.strSwimPumpOperatingImg = String(describing: data!)
                    } else if self.fetchIndexForSubSwimUpload == 1 {
                        self.strSwimMaintainceImg = String(describing: data!)
                    } else if self.fetchIndexForSubSwimUpload == 2 {
                        self.strSwimAdequateSizeImg = String(describing: data!)
                    } else if self.fetchIndexForSubSwimUpload == 3 {
                        self.strSwimMountedImg = String(describing: data!)
                    } else if self.fetchIndexForSubSwimUpload == 4 {
                        self.strSwimVisibleLeakImg = String(describing: data!)
                    } else if self.fetchIndexForSubSwimUpload == 5 {
                        self.strSwimGasketsImg = String(describing: data!)
                    } else if self.fetchIndexForSubSwimUpload == 6 {
                        self.strSwimVisibleAdequateImg = String(describing: data!)
                    } else if self.fetchIndexForSubSwimUpload == 7 {
                        self.strSwimRunQuietlyImg = String(describing: data!)
                    }
                    
                    if self.fetchIndexForSubWaterUpload == 0 {
                        self.strWaterOperatingImg = String(describing: data!)
                    } else if self.fetchIndexForSubWaterUpload == 1 {
                        self.strWaterMaintainceImg = String(describing: data!)
                    } else if self.fetchIndexForSubWaterUpload == 2 {
                        self.strWaterAdequateSizeImg = String(describing: data!)
                    } else if self.fetchIndexForSubWaterUpload == 3 {
                        self.strWaterMountedImg = String(describing: data!)
                    } else if self.fetchIndexForSubWaterUpload == 4 {
                        self.strWaterVisibleLeakImg = String(describing: data!)
                    } else if self.fetchIndexForSubWaterUpload == 5 {
                        self.strWaterGasketsImg = String(describing: data!)
                    } else if self.fetchIndexForSubWaterUpload == 6 {
                        self.strWaterVisibleAdequateImg = String(describing: data!)
                    } else if self.fetchIndexForSubWaterUpload == 7 {
                        self.strWaterRunQuietlyImg = String(describing: data!)
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
    
    func postInspectSwimJetSystem() {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        
        let return_id = UserDefaults.standard.value(forKey: "returnKeyForInspection")
        
        let inspectSwimJetDetails:  NSMutableDictionary = [
            "return_data_id"            : return_id!,
            "swimJetsMainImage"         : strImgSwimJetMain,
            "swimJetsOption"            : strSwimJetSystemOption,
            "swimJetsImage"             : strImgSwimJet,
            "swimJetsData"              : self.secInspectSwimJet[InspectSwimJet.swimJetSystem.rawValue].formTextValue,
            "waterFeatureMainImage"     : strImgWaterMain,
            "waterFeatureOption"        : strWaterFeatureOption,
            "waterFeatureImage"         : strImgWater,
            "waterFeatureData"          : self.secInspectSwimJet[InspectSwimJet.waterFeature.rawValue].formTextValue,
            "swimPumpOperatingOption"   : strOptPumpOperating,
            "swimPumpOperatingImage"    : strSwimPumpOperatingImg,
            "swimPumpOperatingData"     : self.secSwimJet[SwimJetSystem.pumpOperating.rawValue].formTextValue,
            "swimMaintainceOption"      : strOptMaintaince,
            "swimMaintainceImage"       : strSwimMaintainceImg,
            "swimMaintainceData"        : self.secSwimJet[SwimJetSystem.swimJetMaintaince.rawValue].formTextValue,
            "swimAdequateSizeOption"    : strOptAdequateSize,
            "swimAdequateSizeImage"     : strSwimAdequateSizeImg,
            "swimAdequateSizeData"      : self.secSwimJet[SwimJetSystem.swimAdequateSize.rawValue].formTextValue,
            "swimMountedOption"         : strOptMounted,
            "swimMountedImage"          : strSwimMountedImg,
            "swimMountedData"           : self.secSwimJet[SwimJetSystem.swimMounted.rawValue].formTextValue,
            "swimVisibleLeakOption"     : strOptVisibleLeak,
            "swimVisibleLeakImage"      : strSwimVisibleLeakImg,
            "swimVisibleLeakData"       : self.secSwimJet[SwimJetSystem.swimVisibleLeak.rawValue].formTextValue,
            "swimGasketsdOption"        : strOptGaskets,
            "swimGasketsImage"          : strSwimGasketsImg,
            "swimGasketsData"           : self.secSwimJet[SwimJetSystem.swimGaskets.rawValue].formTextValue,
            "swimVisibleAdequateOption" : strOptVisibleAdequate,
            "swimVisibleAdequateImage"  : strSwimVisibleAdequateImg,
            "swimVisibleAdequateData"   : self.secSwimJet[SwimJetSystem.swimVisibleAdequateSize.rawValue].formTextValue,
            "swimRunQuietlyOption"      : strOptRunQuietly,
            "swimRunQuietlyImage"       : strSwimRunQuietlyImg,
            "swimRunQuietlyData"        : self.secSwimJet[SwimJetSystem.swimRunQuietly.rawValue].formTextValue,
            "waterOperatingOption"      : strOptWaterOperating,
            "waterOperatingImage"       : strWaterOperatingImg,
            "waterOperatingData"        : self.secWaterFeature[WaterFeature.swimWaterOperating.rawValue].formTextValue,
            "waterMaintainceOption"     : strOptWaterMaintaince,
            "waterMaintainceImage"      : strWaterMaintainceImg,
            "waterMaintainceData"       : self.secWaterFeature[WaterFeature.swimWaterMaintenance.rawValue].formTextValue,
            "waterAdequateSizeOption"   : strOptWaterAdequateSize,
            "waterAdequateSizeImage"    : strWaterAdequateSizeImg,
            "waterAdequateSizeData"     : self.secWaterFeature[WaterFeature.swimWaterAdequateSize.rawValue].formTextValue,
            "waterMountedOption"        : strOptWaterMounted,
            "waterMountedImage"         : strWaterMountedImg,
            "waterMountedData"          : self.secWaterFeature[WaterFeature.swimWaterMounted.rawValue].formTextValue,
            "waterVisibleLeakOption"    : strOptWaterVisibleLeak,
            "waterVisibleLeakImage"     : strWaterVisibleLeakImg,
            "waterVisibleLeakData"      : self.secWaterFeature[WaterFeature.swimWaterVisibleLeak.rawValue].formTextValue,
            "waterGasketsOption"        : strOptWaterGaskets,
            "waterGasketsImage"         : strWaterGasketsImg,
            "waterGasketsData"          : self.secWaterFeature[WaterFeature.swimWaterGaskets.rawValue].formTextValue,
            "waterVisibleAdequateOption": strOptWaterVisibleAdequate,
            "waterVisibleAdequateImage" : strWaterVisibleAdequateImg,
            "waterVisibleAdequateData"  : self.secWaterFeature[WaterFeature.swimWaterVisibleAdequateSize.rawValue].formTextValue,
            "waterRunQuietlyOption"     : strOptWaterRunQuietly,
            "waterRunQuietlyImage"      : strWaterRunQuietlyImg,
            "waterRunQuietlyData"       : self.secWaterFeature[WaterFeature.swimFeatureRunQuietly.rawValue].formTextValue
        ]
        
        print("inspectSwimJetDetails :: \(inspectSwimJetDetails)")
        //if sharedExtension.connectedToNetwork() {
        ApiManager.sharedInstanceAPI.PostInspectSwimJetSystem(postId: 1, swimDetails: inspectSwimJetDetails, onSuccess: { json in
            DispatchQueue.main.async {
                print("InspectionSwimJetsDetails json :: \(String(describing: json))")
                DispatchQueue.main.async(execute: {() -> Void in
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectSelfCleaning") as! InspectSelfCleaningVC
                        self.navigationController?.pushViewController(formVC, animated: true)
                    } else if UIDevice.current.userInterfaceIdiom == .pad {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectSwimJetSystem") as! InspectSwimJetSystemVC
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

extension InspectSwimJetSystemVC: UploadCollectionProtocol {
    func didTapOnCellItem(_indexpath: IndexPath, _imgUrl: String, _videoUrl: String) {
        
    }
    
    func didUpdateCellIndex(_indexpath: Int) {
        
    }
}

extension InspectSwimJetSystemVC: OpalImagePickerControllerDelegate {
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
                                self.arrImgSwimJetMain.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataImgSwimJetMain = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 1 {
                                self.arrImgSwimJet.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataImgSwimJet = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 2 {
                                self.arrImgWaterMain.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataImgWaterMain = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 3 {
                                self.arrImgWater.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataImgWater = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            }
                            
                            if self.fetchIndexForSubSwimUpload == 0 {
                                self.arrImgPumpOperating.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSwimPumpOperatingImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubSwimUpload == 1 {
                                self.arrImgMaintaince.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSwimMaintainceImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubSwimUpload == 2 {
                                self.arrImgSwimAdequateSize.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSwimAdequateSizeImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubSwimUpload == 3 {
                                self.arrImgSwimMounted.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSwimMountedImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubSwimUpload == 4 {
                                self.arrImgSwimVisibleLeak.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSwimVisibleLeakImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubSwimUpload == 5 {
                                self.arrImgSwimGaskets.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSwimGasketsImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubSwimUpload == 6 {
                                self.arrImgSwimVisibleAdequate.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSwimVisibleAdequateImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubSwimUpload == 7 {
                                self.arrImgSwimRunQuietly.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSwimRunQuietlyImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            }
                            
                            if self.fetchIndexForSubWaterUpload == 0 {
                                self.arrImgWaterOperating.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataWaterOperatingImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubWaterUpload == 1 {
                                self.arrImgWaterMaintaince.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataWaterMaintainceImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubWaterUpload == 2 {
                                self.arrImgWaterAdequateSize.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataWaterAdequateSizeImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubWaterUpload == 3 {
                                self.arrImgWaterMounted.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataWaterMountedImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubWaterUpload == 4 {
                                self.arrImgWaterVisibleLeak.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataWaterVisibleLeakImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubWaterUpload == 5 {
                                self.arrImgWaterGaskets.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataWaterGasketsImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubWaterUpload == 6 {
                                self.arrImgWaterVisibleAdequate.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataWaterVisibleAdequateImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubWaterUpload == 7 {
                                self.arrImgWaterRunQuietly.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataWaterRunQuietlyImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
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
                self.tblSwimJets.reloadData()
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

extension InspectSwimJetSystemVC: UIImagePickerControllerDelegate {
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
            self.arrImgSwimJetMain.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataImgSwimJetMain = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForUpload == 1 {
            self.arrImgSwimJet.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataImgSwimJet = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForUpload == 2 {
            self.arrImgWaterMain.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataImgWaterMain = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForUpload == 3 {
            self.arrImgWater.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataImgWater = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        }
        
        if fetchIndexForSubSwimUpload == 0 {
            self.arrImgPumpOperating.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSwimPumpOperatingImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubSwimUpload == 1 {
            self.arrImgMaintaince.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSwimMaintainceImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubSwimUpload == 2 {
            self.arrImgSwimAdequateSize.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSwimAdequateSizeImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubSwimUpload == 3 {
            self.arrImgSwimMounted.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSwimMountedImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubSwimUpload == 4 {
            self.arrImgSwimVisibleLeak.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSwimVisibleLeakImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubSwimUpload == 5 {
            self.arrImgSwimGaskets.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSwimGasketsImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubSwimUpload == 6 {
            self.arrImgSwimVisibleAdequate.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSwimVisibleAdequateImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubSwimUpload == 7 {
            self.arrImgSwimRunQuietly.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSwimRunQuietlyImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        }
        
        if fetchIndexForSubWaterUpload == 0 {
            self.arrImgWaterOperating.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataWaterOperatingImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubWaterUpload == 1 {
            self.arrImgWaterMaintaince.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataWaterMaintainceImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubWaterUpload == 2 {
            self.arrImgWaterAdequateSize.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataWaterAdequateSizeImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubWaterUpload == 3 {
            self.arrImgWaterMounted.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataWaterMountedImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubWaterUpload == 4 {
            self.arrImgWaterVisibleLeak.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataWaterVisibleLeakImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubWaterUpload == 5 {
            self.arrImgWaterGaskets.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataWaterGasketsImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubWaterUpload == 6 {
            self.arrImgWaterVisibleAdequate.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataWaterVisibleAdequateImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubWaterUpload == 7 {
            self.arrImgWaterRunQuietly.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataWaterRunQuietlyImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        }
        
        self.tblSwimJets.reloadData()
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
}

extension InspectSwimJetSystemVC: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        var cell = UITableViewCell()
        cell = (textView.superview?.superview as? UITableViewCell)!
        
        if let InspectionSwimJetsPumpTableCell = cell as? InspectionSwimJetsPumpTableCell {
            if textView == InspectionSwimJetsPumpTableCell.txtSwimJets {
                self.secInspectSwimJet[InspectSwimJet.swimJetSystem.rawValue].formTextValue = (textView.text)!
           }
        } else if let InspectionJetsWaterFeaturePumpTableCell = cell as? InspectionJetsWaterFeaturePumpTableCell {
            if textView == InspectionJetsWaterFeaturePumpTableCell.txtJetsWaterFeature {
                self.secInspectSwimJet[InspectSwimJet.waterFeature.rawValue].formTextValue = (textView.text)!
            }
        }
        
        if let SwimJetsPumpOperatingTableCell = cell as? SwimJetsPumpOperatingTableCell {
            if textView == SwimJetsPumpOperatingTableCell.txtSwimJetOperating {
                self.secSwimJet[SwimJetSystem.pumpOperating.rawValue].formTextValue = (textView.text)!
           }
        } else if let SwimJetsMaintaianceAccessTableCell = cell as? SwimJetsMaintaianceAccessTableCell {
            if textView == SwimJetsMaintaianceAccessTableCell.txtSwimJetMaintenance {
                self.secSwimJet[SwimJetSystem.swimJetMaintaince.rawValue].formTextValue = (textView.text)!
            }
        } else if let SwimJetsAdequateSizeTableCell = cell as? SwimJetsAdequateSizeTableCell {
            if textView == SwimJetsAdequateSizeTableCell.txtSwimAdequateSize {
                self.secSwimJet[SwimJetSystem.swimAdequateSize.rawValue].formTextValue = (textView.text)!
            }
        } else if let SwimJetsMountedTableCell = cell as? SwimJetsMountedTableCell {
            if textView == SwimJetsMountedTableCell.txtSwimMounted {
                self.secSwimJet[SwimJetSystem.swimMounted.rawValue].formTextValue = (textView.text)!
            }
        } else if let SwimJetsVisibleLeakTableCell = cell as? SwimJetsVisibleLeakTableCell {
            if textView == SwimJetsVisibleLeakTableCell.txtSwimVisibleLeak {
                self.secSwimJet[SwimJetSystem.swimVisibleLeak.rawValue].formTextValue = (textView.text)!
            }
        } else if let SwimJetsGasketsTableCell = cell as? SwimJetsGasketsTableCell {
            if textView == SwimJetsGasketsTableCell.txtSwimGaskets {
                self.secSwimJet[SwimJetSystem.swimGaskets.rawValue].formTextValue = (textView.text)!
            }
        } else if let SwimJetsVisibleAdequateSizeTableCell = cell as? SwimJetsVisibleAdequateSizeTableCell {
            if textView == SwimJetsVisibleAdequateSizeTableCell.txtSwimVisibleAdequateSize {
                self.secSwimJet[SwimJetSystem.swimVisibleAdequateSize.rawValue].formTextValue = (textView.text)!
            }
        } else if let SwimJetsRunQuietlyTableCell = cell as? SwimJetsRunQuietlyTableCell {
            if textView == SwimJetsRunQuietlyTableCell.txtSwimRunQuietly {
                self.secSwimJet[SwimJetSystem.swimRunQuietly.rawValue].formTextValue = (textView.text)!
            }
        }
        
        if let SwimJetsWaterFeatureOperatingTableCell = cell as? SwimJetsWaterFeatureOperatingTableCell {
            if textView == SwimJetsWaterFeatureOperatingTableCell.txtSwimWaterOperating {
                self.secWaterFeature[WaterFeature.swimWaterOperating.rawValue].formTextValue = (textView.text)!
            }
        } else if let SwimJetsWaterFeatureMaintaianceAccessTableCell = cell as? SwimJetsWaterFeatureMaintaianceAccessTableCell {
            if textView == SwimJetsWaterFeatureMaintaianceAccessTableCell.txtSwimWaterMaintenance {
                self.secWaterFeature[WaterFeature.swimWaterMaintenance.rawValue].formTextValue = (textView.text)!
            }
        } else if let SwimJetsWaterFeatureAdequateSizeTableCell = cell as? SwimJetsWaterFeatureAdequateSizeTableCell {
            if textView == SwimJetsWaterFeatureAdequateSizeTableCell.txtSwimAdequateSize {
                self.secWaterFeature[WaterFeature.swimWaterAdequateSize.rawValue].formTextValue = (textView.text)!
            }
        } else if let SwimJetsWaterFeatureMountedTableCell = cell as? SwimJetsWaterFeatureMountedTableCell {
            if textView == SwimJetsWaterFeatureMountedTableCell.txtSwimMounted {
                self.secWaterFeature[WaterFeature.swimWaterMounted.rawValue].formTextValue = (textView.text)!
            }
        } else if let SwimJetsWaterFeatureVisibleLeakTableCell = cell as? SwimJetsWaterFeatureVisibleLeakTableCell {
            if textView == SwimJetsWaterFeatureVisibleLeakTableCell.txtSwimWaterVisibleLeak {
                self.secWaterFeature[WaterFeature.swimWaterVisibleLeak.rawValue].formTextValue = (textView.text)!
            }
        } else if let SwimJetsWaterFeatureGasketsTableCell = cell as? SwimJetsWaterFeatureGasketsTableCell {
            if textView == SwimJetsWaterFeatureGasketsTableCell.txtSwimGaskets {
                self.secWaterFeature[WaterFeature.swimWaterGaskets.rawValue].formTextValue = (textView.text)!
            }
        } else if let SwimJetsWaterFeatureVisibleAdequateSizeTableCell = cell as? SwimJetsWaterFeatureVisibleAdequateSizeTableCell {
            if textView == SwimJetsWaterFeatureVisibleAdequateSizeTableCell.txtSwimVisibleAdequateSize {
                self.secWaterFeature[WaterFeature.swimWaterVisibleAdequateSize.rawValue].formTextValue = (textView.text)!
            }
        } else if let SwimJetsWaterFeatureRunQuietlyTableCell = cell as? SwimJetsWaterFeatureRunQuietlyTableCell {
            if textView == SwimJetsWaterFeatureRunQuietlyTableCell.txtSwimFeatureRun {
                self.secWaterFeature[WaterFeature.swimFeatureRunQuietly.rawValue].formTextValue = (textView.text)!
            }
        }
    }
}

extension InspectSwimJetSystemVC: UITableViewDataSource, UITableViewDelegate {
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
                let swimSubCell = tableView.dequeueReusableCell(withIdentifier: "SwimJetsPumpOperatingCell", for: indexPath) as! SwimJetsPumpOperatingTableCell
                
                swimSubCell.btnUpload.addTarget(self, action: #selector(btnSwimImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                swimSubCell.collectionvw.arrItems = arrImgPumpOperating
                swimSubCell.collectionvw.delegateItemCollection = self
                swimSubCell.collectionvw.reloadImageCollection()
                
                if arrImgPumpOperating.count > 0 {
                    swimSubCell.btnUpload.isHidden = true
                    swimSubCell.collectionvw.isHidden = false
                } else {
                    swimSubCell.btnUpload.isHidden = false
                    swimSubCell.collectionvw.isHidden = true
                }
                
                swimSubCell.delegateSwimJetsOperate = self
                swimSubCell.txtSwimJetOperating.delegate = self
                
                return swimSubCell
            } else if indexPath.row == 1 {
                let swimSubCell = tableView.dequeueReusableCell(withIdentifier: "SwimJetsMaintaianceAccessCell", for: indexPath) as! SwimJetsMaintaianceAccessTableCell
                
                swimSubCell.btnUpload.addTarget(self, action: #selector(btnSwimImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                swimSubCell.collectionvw.arrItems = arrImgMaintaince
                swimSubCell.collectionvw.delegateItemCollection = self
                swimSubCell.collectionvw.reloadImageCollection()
                
                if arrImgMaintaince.count > 0 {
                    swimSubCell.btnUpload.isHidden = true
                    swimSubCell.collectionvw.isHidden = false
                } else {
                    swimSubCell.btnUpload.isHidden = false
                    swimSubCell.collectionvw.isHidden = true
                }

                swimSubCell.delegateSwimJetsMaintaiance = self
                swimSubCell.txtSwimJetMaintenance.delegate = self
                
                return swimSubCell
            } else if indexPath.row == 2 {
                let swimSubCell = tableView.dequeueReusableCell(withIdentifier: "SwimJetsAdequateSizeCell", for: indexPath) as! SwimJetsAdequateSizeTableCell
                
                swimSubCell.btnUpload.addTarget(self, action: #selector(btnSwimImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                swimSubCell.collectionvw.arrItems = arrImgSwimAdequateSize
                swimSubCell.collectionvw.delegateItemCollection = self
                swimSubCell.collectionvw.reloadImageCollection()
                
                if arrImgSwimAdequateSize.count > 0 {
                    swimSubCell.btnUpload.isHidden = true
                    swimSubCell.collectionvw.isHidden = false
                } else {
                    swimSubCell.btnUpload.isHidden = false
                    swimSubCell.collectionvw.isHidden = true
                }

                swimSubCell.delegateSwimJetsAdequate = self
                swimSubCell.txtSwimAdequateSize.delegate = self
                
                return swimSubCell
            } else if indexPath.row == 3 {
                let swimSubCell = tableView.dequeueReusableCell(withIdentifier: "SwimJetsMountedCell", for: indexPath) as! SwimJetsMountedTableCell
                 
                swimSubCell.btnUpload.addTarget(self, action: #selector(btnSwimImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                swimSubCell.collectionvw.arrItems = arrImgSwimMounted
                swimSubCell.collectionvw.delegateItemCollection = self
                swimSubCell.collectionvw.reloadImageCollection()
                
                if arrImgSwimMounted.count > 0 {
                    swimSubCell.btnUpload.isHidden = true
                    swimSubCell.collectionvw.isHidden = false
                } else {
                    swimSubCell.btnUpload.isHidden = false
                    swimSubCell.collectionvw.isHidden = true
                }

                swimSubCell.delegateSwimJetsMounted = self
                swimSubCell.txtSwimMounted.delegate = self
                
                return swimSubCell
            } else if indexPath.row == 4 {
                let swimSubCell = tableView.dequeueReusableCell(withIdentifier: "SwimJetsVisibleLeakCell", for: indexPath) as! SwimJetsVisibleLeakTableCell
                
                swimSubCell.btnUpload.addTarget(self, action: #selector(btnSwimImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                swimSubCell.collectionvw.arrItems = arrImgSwimVisibleLeak
                swimSubCell.collectionvw.delegateItemCollection = self
                swimSubCell.collectionvw.reloadImageCollection()
                
                if arrImgSwimVisibleLeak.count > 0 {
                    swimSubCell.btnUpload.isHidden = true
                    swimSubCell.collectionvw.isHidden = false
                } else {
                    swimSubCell.btnUpload.isHidden = false
                    swimSubCell.collectionvw.isHidden = true
                }

                swimSubCell.delegateSwimJetsLeak = self
                swimSubCell.txtSwimVisibleLeak.delegate = self
                
                return swimSubCell
            } else if indexPath.row == 5 {
                let swimSubCell = tableView.dequeueReusableCell(withIdentifier: "SwimJetsGasketsCell", for: indexPath) as! SwimJetsGasketsTableCell
                 
                swimSubCell.btnUpload.addTarget(self, action: #selector(btnSwimImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                swimSubCell.collectionvw.arrItems = arrImgSwimGaskets
                swimSubCell.collectionvw.delegateItemCollection = self
                swimSubCell.collectionvw.reloadImageCollection()
                
                if arrImgSwimGaskets.count > 0 {
                    swimSubCell.btnUpload.isHidden = true
                    swimSubCell.collectionvw.isHidden = false
                } else {
                    swimSubCell.btnUpload.isHidden = false
                    swimSubCell.collectionvw.isHidden = true
                }

                swimSubCell.delegateSwimJetsGaskets = self
                swimSubCell.txtSwimGaskets.delegate = self
                
                return swimSubCell
            } else if indexPath.row == 6 {
                let swimSubCell = tableView.dequeueReusableCell(withIdentifier: "SwimJetsVisibleAdequateSizeCell", for: indexPath) as! SwimJetsVisibleAdequateSizeTableCell
                 
                swimSubCell.btnUpload.addTarget(self, action: #selector(btnSwimImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                swimSubCell.collectionvw.arrItems = arrImgSwimVisibleAdequate
                swimSubCell.collectionvw.delegateItemCollection = self
                swimSubCell.collectionvw.reloadImageCollection()
                
                if arrImgSwimVisibleAdequate.count > 0 {
                    swimSubCell.btnUpload.isHidden = true
                    swimSubCell.collectionvw.isHidden = false
                } else {
                    swimSubCell.btnUpload.isHidden = false
                    swimSubCell.collectionvw.isHidden = true
                }

                swimSubCell.delegateSwimJetsVisibleAdequate = self
                swimSubCell.txtSwimVisibleAdequateSize.delegate = self
                
                return swimSubCell
            } else {//if indexPath.row == 7 {
                let swimSubCell = tableView.dequeueReusableCell(withIdentifier: "SwimJetsRunQuietlyCell", for: indexPath) as! SwimJetsRunQuietlyTableCell
                 
                swimSubCell.btnUpload.addTarget(self, action: #selector(btnSwimImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                swimSubCell.collectionvw.arrItems = arrImgSwimRunQuietly
                swimSubCell.collectionvw.delegateItemCollection = self
                swimSubCell.collectionvw.reloadImageCollection()
                
                if arrImgSwimRunQuietly.count > 0 {
                    swimSubCell.btnUpload.isHidden = true
                    swimSubCell.collectionvw.isHidden = false
                } else {
                    swimSubCell.btnUpload.isHidden = false
                    swimSubCell.collectionvw.isHidden = true
                }

                swimSubCell.delegateSwimJetsRunQuietly = self
                swimSubCell.txtSwimRunQuietly.delegate = self
                
                return swimSubCell
            }
        } else if tableView.tag == 35 {
            if indexPath.row == 0 {
                let waterFeatureCell = tableView.dequeueReusableCell(withIdentifier: "SwimJetsWaterFeatureOperatingCell", for: indexPath) as! SwimJetsWaterFeatureOperatingTableCell
                
                waterFeatureCell.btnUpload.addTarget(self, action: #selector(btnWaterImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                waterFeatureCell.collectionvw.arrItems = arrImgWaterOperating
                waterFeatureCell.collectionvw.delegateItemCollection = self
                waterFeatureCell.collectionvw.reloadImageCollection()
                
                if arrImgWaterOperating.count > 0 {
                    waterFeatureCell.btnUpload.isHidden = true
                    waterFeatureCell.collectionvw.isHidden = false
                } else {
                    waterFeatureCell.btnUpload.isHidden = false
                    waterFeatureCell.collectionvw.isHidden = true
                }
                
                waterFeatureCell.delegateSwimJetsWaterFeatureOperate = self
                waterFeatureCell.txtSwimWaterOperating.delegate = self
                
                return waterFeatureCell
            } else if indexPath.row == 1 {
                let waterFeatureCell = tableView.dequeueReusableCell(withIdentifier: "SwimJetsWaterFeatureMaintaianceAccessCell", for: indexPath) as! SwimJetsWaterFeatureMaintaianceAccessTableCell
                
                waterFeatureCell.btnUpload.addTarget(self, action: #selector(btnWaterImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                waterFeatureCell.collectionvw.arrItems = arrImgWaterMaintaince
                waterFeatureCell.collectionvw.delegateItemCollection = self
                waterFeatureCell.collectionvw.reloadImageCollection()
                
                if arrImgWaterMaintaince.count > 0 {
                    waterFeatureCell.btnUpload.isHidden = true
                    waterFeatureCell.collectionvw.isHidden = false
                } else {
                    waterFeatureCell.btnUpload.isHidden = false
                    waterFeatureCell.collectionvw.isHidden = true
                }
                
                waterFeatureCell.delegateSwimJetsWaterFeatureMaintain = self
                waterFeatureCell.txtSwimWaterMaintenance.delegate = self
                
                return waterFeatureCell
            } else if indexPath.row == 2 {
                let waterFeatureCell = tableView.dequeueReusableCell(withIdentifier: "SwimJetsWaterFeatureAdequateSizeCell", for: indexPath) as! SwimJetsWaterFeatureAdequateSizeTableCell
                
                waterFeatureCell.btnUpload.addTarget(self, action: #selector(btnWaterImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                waterFeatureCell.collectionvw.arrItems = arrImgWaterAdequateSize
                waterFeatureCell.collectionvw.delegateItemCollection = self
                waterFeatureCell.collectionvw.reloadImageCollection()
                
                if arrImgWaterAdequateSize.count > 0 {
                    waterFeatureCell.btnUpload.isHidden = true
                    waterFeatureCell.collectionvw.isHidden = false
                } else {
                    waterFeatureCell.btnUpload.isHidden = false
                    waterFeatureCell.collectionvw.isHidden = true
                }
                
                waterFeatureCell.delegateSwimJetsAdequateSize = self
                waterFeatureCell.txtSwimAdequateSize.delegate = self
                
                return waterFeatureCell
            } else if indexPath.row == 3 {
                let waterFeatureCell = tableView.dequeueReusableCell(withIdentifier: "SwimJetsWaterFeatureMountedCell", for: indexPath) as! SwimJetsWaterFeatureMountedTableCell
                
                waterFeatureCell.btnUpload.addTarget(self, action: #selector(btnWaterImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                waterFeatureCell.collectionvw.arrItems = arrImgWaterMounted
                waterFeatureCell.collectionvw.delegateItemCollection = self
                waterFeatureCell.collectionvw.reloadImageCollection()
                
                if arrImgWaterMounted.count > 0 {
                    waterFeatureCell.btnUpload.isHidden = true
                    waterFeatureCell.collectionvw.isHidden = false
                } else {
                    waterFeatureCell.btnUpload.isHidden = false
                    waterFeatureCell.collectionvw.isHidden = true
                }
                
                waterFeatureCell.delegateSwimJetsMounted = self
                waterFeatureCell.txtSwimMounted.delegate = self
                
                return waterFeatureCell
            } else if indexPath.row == 4 {
                let waterFeatureCell = tableView.dequeueReusableCell(withIdentifier: "SwimJetsWaterFeatureVisibleLeakCell", for: indexPath) as! SwimJetsWaterFeatureVisibleLeakTableCell
                
                waterFeatureCell.btnUpload.addTarget(self, action: #selector(btnWaterImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                waterFeatureCell.collectionvw.arrItems = arrImgWaterVisibleLeak
                waterFeatureCell.collectionvw.delegateItemCollection = self
                waterFeatureCell.collectionvw.reloadImageCollection()
                
                if arrImgWaterVisibleLeak.count > 0 {
                    waterFeatureCell.btnUpload.isHidden = true
                    waterFeatureCell.collectionvw.isHidden = false
                } else {
                    waterFeatureCell.btnUpload.isHidden = false
                    waterFeatureCell.collectionvw.isHidden = true
                }
                
                waterFeatureCell.delegateSwimJetsLeak = self
                waterFeatureCell.txtSwimWaterVisibleLeak.delegate = self
                
                return waterFeatureCell
            } else if indexPath.row == 5 {
                let waterFeatureCell = tableView.dequeueReusableCell(withIdentifier: "SwimJetsWaterFeatureGasketsCell", for: indexPath) as! SwimJetsWaterFeatureGasketsTableCell
                
                waterFeatureCell.btnUpload.addTarget(self, action: #selector(btnWaterImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                waterFeatureCell.collectionvw.arrItems = arrImgWaterGaskets
                waterFeatureCell.collectionvw.delegateItemCollection = self
                waterFeatureCell.collectionvw.reloadImageCollection()
                
                if arrImgWaterGaskets.count > 0 {
                    waterFeatureCell.btnUpload.isHidden = true
                    waterFeatureCell.collectionvw.isHidden = false
                } else {
                    waterFeatureCell.btnUpload.isHidden = false
                    waterFeatureCell.collectionvw.isHidden = true
                }
                
                waterFeatureCell.delegateSwimJetsGaskets = self
                waterFeatureCell.txtSwimGaskets.delegate = self
                
                return waterFeatureCell
            } else if indexPath.row == 6 {
                let waterFeatureCell = tableView.dequeueReusableCell(withIdentifier: "SwimJetsWaterFeatureVisibleAdequateSizeCell", for: indexPath) as! SwimJetsWaterFeatureVisibleAdequateSizeTableCell
                
                waterFeatureCell.btnUpload.addTarget(self, action: #selector(btnWaterImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                waterFeatureCell.collectionvw.arrItems = arrImgWaterVisibleAdequate
                waterFeatureCell.collectionvw.delegateItemCollection = self
                waterFeatureCell.collectionvw.reloadImageCollection()
                
                if arrImgWaterVisibleAdequate.count > 0 {
                    waterFeatureCell.btnUpload.isHidden = true
                    waterFeatureCell.collectionvw.isHidden = false
                } else {
                    waterFeatureCell.btnUpload.isHidden = false
                    waterFeatureCell.collectionvw.isHidden = true
                }
                
                waterFeatureCell.delegateSwimJetsVisibleAdequateSize = self
                waterFeatureCell.txtSwimVisibleAdequateSize.delegate = self
                
                return waterFeatureCell
            } else {//if indexPath.row == 7 {
                let waterFeatureCell = tableView.dequeueReusableCell(withIdentifier: "SwimJetsWaterFeatureRunQuietlyCell", for: indexPath) as! SwimJetsWaterFeatureRunQuietlyTableCell
                
                waterFeatureCell.btnUpload.addTarget(self, action: #selector(btnWaterImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                waterFeatureCell.collectionvw.arrItems = arrImgWaterRunQuietly
                waterFeatureCell.collectionvw.delegateItemCollection = self
                waterFeatureCell.collectionvw.reloadImageCollection()
                
                if arrImgWaterRunQuietly.count > 0 {
                    waterFeatureCell.btnUpload.isHidden = true
                    waterFeatureCell.collectionvw.isHidden = false
                } else {
                    waterFeatureCell.btnUpload.isHidden = false
                    waterFeatureCell.collectionvw.isHidden = true
                }
                
                waterFeatureCell.delegateSwimJetsRunQuietly = self
                waterFeatureCell.txtSwimFeatureRun.delegate = self
                
                return waterFeatureCell
            }
        } else {
            if indexPath.row == 0 {
                let cameraCell = tableView.dequeueReusableCell(withIdentifier: "CameraCell", for: indexPath) as! CameraTableCell
                
                cameraCell.lblHeader.text = "Swim jet System Pump"
                
                cameraCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                cameraCell.collectionVw.arrItems = arrImgSwimJetMain
                cameraCell.collectionVw.delegateItemCollection = self
                cameraCell.collectionVw.reloadImageCollection()
                
                if arrImgSwimJetMain.count > 0 {
                    cameraCell.btnUpload.isHidden = true
                    cameraCell.collectionVw.isHidden = false
                } else {
                    cameraCell.btnUpload.isHidden = false
                    cameraCell.collectionVw.isHidden = true
                }
                
                return cameraCell
            } else if indexPath.row == 1 {
                let InspectionSwimJetsPumpCell = tableView.dequeueReusableCell(withIdentifier: "InspectionSwimJetsPumpCell", for: indexPath) as! InspectionSwimJetsPumpTableCell
                
                InspectionSwimJetsPumpCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                InspectionSwimJetsPumpCell.collectionvw.arrItems = arrImgSwimJet
                InspectionSwimJetsPumpCell.collectionvw.delegateItemCollection = self
                InspectionSwimJetsPumpCell.collectionvw.reloadImageCollection()
                
                if arrImgSwimJet.count > 0 {
                    InspectionSwimJetsPumpCell.btnUpload.isHidden = true
                    InspectionSwimJetsPumpCell.collectionvw.isHidden = false
                } else {
                    InspectionSwimJetsPumpCell.btnUpload.isHidden = false
                    InspectionSwimJetsPumpCell.collectionvw.isHidden = true
                }
                
                InspectionSwimJetsPumpCell.delegateSwimJetsPump = self
                InspectionSwimJetsPumpCell.txtSwimJets.delegate = self
                
                if strSwimJetSystemOption == "Yes" {
                    //Declare the outlet in our custom class
                    let tblSwimJetSystem = InspectionSwimJetsPumpCell.viewWithTag(25) as! UITableView
                    
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        InspectionSwimJetsPumpCell.tblSwimJetsHeightConstraint.constant = 350*7+345
                    } else {
                        InspectionSwimJetsPumpCell.tblSwimJetsHeightConstraint.constant = 600*7+585
                    }
                    tblSwimJetSystem.delegate = self
                    tblSwimJetSystem.dataSource = self
                    tblSwimJetSystem.reloadData()
                } else if strSwimJetSystemOption == "No" {
                    InspectionSwimJetsPumpCell.tblSwimJetsHeightConstraint.constant = 0
                }
                
                return InspectionSwimJetsPumpCell
            } else if indexPath.row == 2 {
                let cameraCell = tableView.dequeueReusableCell(withIdentifier: "CameraCell", for: indexPath) as! CameraTableCell
                
                cameraCell.lblHeader.text = "Water Feature pump"
                
                cameraCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                cameraCell.collectionVw.arrItems = arrImgWaterMain
                cameraCell.collectionVw.delegateItemCollection = self
                cameraCell.collectionVw.reloadImageCollection()
                
                if arrImgWaterMain.count > 0 {
                    cameraCell.btnUpload.isHidden = true
                    cameraCell.collectionVw.isHidden = false
                } else {
                    cameraCell.btnUpload.isHidden = false
                    cameraCell.collectionVw.isHidden = true
                }
                
                return cameraCell
            } else if indexPath.row == 3 {
                let InspectionJetsWaterFeaturePumpCell = tableView.dequeueReusableCell(withIdentifier: "InspectionJetsWaterFeaturePumpCell", for: indexPath) as! InspectionJetsWaterFeaturePumpTableCell
                
                InspectionJetsWaterFeaturePumpCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                InspectionJetsWaterFeaturePumpCell.collectionvw.arrItems = arrImgWater
                InspectionJetsWaterFeaturePumpCell.collectionvw.delegateItemCollection = self
                InspectionJetsWaterFeaturePumpCell.collectionvw.reloadImageCollection()
                
                if arrImgWater.count > 0 {
                    InspectionJetsWaterFeaturePumpCell.btnUpload.isHidden = true
                    InspectionJetsWaterFeaturePumpCell.collectionvw.isHidden = false
                } else {
                    InspectionJetsWaterFeaturePumpCell.btnUpload.isHidden = false
                    InspectionJetsWaterFeaturePumpCell.collectionvw.isHidden = true
                }
                
                InspectionJetsWaterFeaturePumpCell.delegateJetsWaterFeature = self
                InspectionJetsWaterFeaturePumpCell.txtJetsWaterFeature.delegate = self
                
                if strWaterFeatureOption == "Yes" {
                    //Declare the outlet in our custom class
                    let tblSwimJetWaterFeature = InspectionJetsWaterFeaturePumpCell.viewWithTag(35) as! UITableView
                    
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        InspectionJetsWaterFeaturePumpCell.tblJetsWaterFeatureHeightConstraint.constant = 350*7+345
                    } else {
                        InspectionJetsWaterFeaturePumpCell.tblJetsWaterFeatureHeightConstraint.constant = 600*7+585
                    }
                    tblSwimJetWaterFeature.delegate = self
                    tblSwimJetWaterFeature.dataSource = self
                    tblSwimJetWaterFeature.reloadData()
                } else if strWaterFeatureOption == "No" {
                    InspectionJetsWaterFeaturePumpCell.tblJetsWaterFeatureHeightConstraint.constant = 0
                }
                
                return InspectionJetsWaterFeaturePumpCell
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
                    return 340
                }
            } else {
                if indexPath.row == 0 {
                    return 185
                } else if indexPath.row == 1 {
                    if strSwimJetSystemOption == "Yes" {
                        return (340*7+345)+325//UITableView.automaticDimension//
                    } else {
                        return 340
                    }
                } else if indexPath.row == 2 {
                    return 185
                } else if indexPath.row == 3 {
                      if strWaterFeatureOption == "Yes" {
                         return (340*7+345)+325//UITableView.automaticDimension//
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
                    return 320
                } else if indexPath.row == 1 {
                    if strSwimJetSystemOption == "Yes" {
                        return (600*7+585)+615//UITableView.automaticDimension//
                    } else {
                        return 615
                    }
                } else if indexPath.row == 2 {
                    return 320
                } else if indexPath.row == 3 {
                      if strWaterFeatureOption == "Yes" {
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

extension InspectSwimJetSystemVC: SwimJetsPumpCellProtocol, SwimJetsOperatingCellProtocol, SwimJetsMaintaianceCellProtocol, SwimJetsAdequateCellProtocol, SwimJetsMountedCellProtocol, SwimJetsLeakCellProtocol, SwimJetsGasketsCellProtocol, SwimJetsVisibleAdequateCellProtocol, SwimJetsRunQuietlyCellProtocol, SwimJetsWaterFeatureCellProtocol, SwimJetsWaterFeatureOperateCellProtocol, SwimJetsWaterFeatureMaintaianceCellProtocol, SwimJetsWaterFeatureAdequateSizeCellProtocol, SwimJetsWaterFeatureMountedCellProtocol, SwimJetsWaterFeatureLeakCellProtocol, SwimJetsWaterGasketsCellProtocol, SwimJetsWaterVisibleAdequateSizeCellProtocol, SwimJetsWaterRunQuietlyCellProtocol {
    
    //MARK:- Sub Swim Jets Protocol
    func didTapOnCellSwimJetsOperating(_btnSwimJetsTag: Int) {
        if _btnSwimJetsTag == 0 {
            strOptPumpOperating = "Yes"
        } else if _btnSwimJetsTag == 1 {
            strOptPumpOperating = "No"
        }
        self.tblSwimJets.reloadData()
    }
    
    func didTapOnCellSwimJetsMaintaiance(_btnSwimJetsTag: Int) {
        if _btnSwimJetsTag == 0 {
            strOptMaintaince = "Yes"
        } else if _btnSwimJetsTag == 1 {
            strOptMaintaince = "No"
        }
        self.tblSwimJets.reloadData()
    }
    
    func didTapOnCellSwimJetsAdequate(_btnSwimJetsTag: Int) {
        if _btnSwimJetsTag == 0 {
            strOptAdequateSize = "Yes"
        } else if _btnSwimJetsTag == 1 {
            strOptAdequateSize = "No"
        }
        self.tblSwimJets.reloadData()
    }
    
    func didTapOnCellSwimJetsMounted(_btnSwimJetsTag: Int) {
        if _btnSwimJetsTag == 0 {
            strOptMounted = "Yes"
        } else if _btnSwimJetsTag == 1 {
            strOptMounted = "No"
        }
        self.tblSwimJets.reloadData()
    }
    
    func didTapOnCellSwimJetsLeak(_btnSwimJetsTag: Int) {
        if _btnSwimJetsTag == 0 {
            strOptVisibleLeak = "Yes"
        } else if _btnSwimJetsTag == 1 {
            strOptVisibleLeak = "No"
        }
        self.tblSwimJets.reloadData()
    }
    
    func didTapOnCellSwimJetsGaskets(_btnSwimJetsTag: Int) {
        if _btnSwimJetsTag == 0 {
            strOptGaskets = "Yes"
        } else if _btnSwimJetsTag == 1 {
            strOptGaskets = "No"
        }
        self.tblSwimJets.reloadData()
    }
    
    func didTapOnCellSwimJetsVisibleAdequate(_btnSwimJetsTag: Int) {
        if _btnSwimJetsTag == 0 {
            strOptVisibleAdequate = "Yes"
        } else if _btnSwimJetsTag == 1 {
            strOptVisibleAdequate = "No"
        }
        self.tblSwimJets.reloadData()
    }
    
    func didTapOnCellSwimJetsRunQuietly(_btnSwimJetsTag: Int) {
        if _btnSwimJetsTag == 0 {
            strOptRunQuietly = "Yes"
        } else if _btnSwimJetsTag == 1 {
            strOptRunQuietly = "No"
        }
        self.tblSwimJets.reloadData()
    }
    
    //MARK:- Swim Jets Protocol
    func didTapOnCellSwimJets(_btnSwimJetsTag: Int){
       if _btnSwimJetsTag == 0 {
           strSwimJetSystemOption = "Yes"
       } else if _btnSwimJetsTag == 1 {
           strSwimJetSystemOption = "No"
       }
       self.tblSwimJets.reloadData()
    }
    
    //MARK:- Swim Jets Water Feature Protocol
    func didTapOnCellSwimJetsWaterFeature(_btnSwimJetsWaterFeatureTag: Int){
       if _btnSwimJetsWaterFeatureTag == 0 {
           strWaterFeatureOption = "Yes"
       } else if _btnSwimJetsWaterFeatureTag == 1 {
           strWaterFeatureOption = "No"
       }
       self.tblSwimJets.reloadData()
    }
    
    //MARK:- Sub Water Feature Protocol
    func didTapOnCellSwimJetsWaterFeatureOperate(_btnSwimJetsTag: Int) {
        if _btnSwimJetsTag == 0 {
            strOptWaterOperating = "Yes"
        } else if _btnSwimJetsTag == 1 {
            strOptWaterOperating = "No"
        }
        self.tblSwimJets.reloadData()
    }
    
    func didTapOnCellSwimJetsWaterFeatureMaintaiance(_btnSwimJetsTag: Int) {
        if _btnSwimJetsTag == 0 {
            strOptWaterMaintaince = "Yes"
        } else if _btnSwimJetsTag == 1 {
            strOptWaterMaintaince = "No"
        }
        self.tblSwimJets.reloadData()
    }
    
    func didTapOnCellSwimJetsWaterFeatureAdequateSize(_btnSwimJetsTag: Int) {
        if _btnSwimJetsTag == 0 {
            strOptWaterAdequateSize = "Yes"
        } else if _btnSwimJetsTag == 1 {
            strOptWaterAdequateSize = "No"
        }
        self.tblSwimJets.reloadData()
    }
    
    func didTapOnCellSwimJetsWaterFeatureMounted(_btnSwimJetsTag: Int) {
        if _btnSwimJetsTag == 0 {
            strOptWaterMounted = "Yes"
        } else if _btnSwimJetsTag == 1 {
            strOptWaterMounted = "No"
        }
        self.tblSwimJets.reloadData()
    }
    
    func didTapOnCellSwimJetsWaterFeatureLeak(_btnSwimJetsTag: Int) {
        if _btnSwimJetsTag == 0 {
            strOptWaterVisibleLeak = "Yes"
        } else if _btnSwimJetsTag == 1 {
            strOptWaterVisibleLeak = "No"
        }
        self.tblSwimJets.reloadData()
    }
    
    func didTapOnCellSwimJetsWaterGaskets(_btnSwimJetsTag: Int) {
        if _btnSwimJetsTag == 0 {
            strOptWaterGaskets = "Yes"
        } else if _btnSwimJetsTag == 1 {
            strOptWaterGaskets = "No"
        }
        self.tblSwimJets.reloadData()
    }
    
    func didTapOnCellSwimJetsWaterVisibleAdequateSize(_btnSwimJetsTag: Int) {
        if _btnSwimJetsTag == 0 {
            strOptWaterVisibleAdequate = "Yes"
        } else if _btnSwimJetsTag == 1 {
            strOptWaterVisibleAdequate = "No"
        }
        self.tblSwimJets.reloadData()
    }
    
    func didTapOnCellSwimJetsWaterRunQuietly(_btnSwimJetsTag: Int) {
        if _btnSwimJetsTag == 0 {
            strOptWaterRunQuietly = "Yes"
        } else if _btnSwimJetsTag == 1 {
            strOptWaterRunQuietly = "No"
        }
        self.tblSwimJets.reloadData()
    }
}
