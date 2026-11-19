//
//  InspectionLightVC.swift
//  Leaktronics
//
//  Created by Abhishek Mullick on 08/05/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import CoreData
import DLRadioButton
import SVProgressHUD
import Alamofire
import Photos
import OpalImagePicker


class InspectLightVC: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var tblLight: UITableView!
    
    var secInspectLight = [formInspectionPoolData]()
    var secLight = [formInspectionPoolData]()
    
    enum InspectLight: Int {
        case lightWorking = 1
        case lowVoltage = 2
        case fiberLightning = 3
        case fiberWorking = 4
        case multiSynch = 5
        case spaLight = 6
        case basinLight = 7
        case freeWater = 8
        case lightMounted = 9
        case properGFI = 10
        case GFITripped = 11
        case poolSafety = 13
        case exposeWiring = 14
        case disconnectedAccessories = 15
        case equipmentBond = 16
        case electricalProperGFI = 17
        case electricalGFITripped = 18
        case wireHiring = 19
        case electricalBoxMounted = 20
     }
      
    enum ClockTime: Int {
        case saltSystemMaintain = 0
        case saltPower = 1
        case saltSystemWorking = 2
        case saltVisibleLeak = 3
        case saltCalcification = 4
    }
    
    var fetchIndexForUpload: Int = -1
    
    var imagePicker = UIImagePickerController()
    var picker:UIImagePickerController? = UIImagePickerController()
    
    var otherPumpOption = String()
    var otherPumpText = String()
    
    
    //For Images
    var arrLightMainImg: [CollectionImageObject] = []
    var arrLightWorkingImg: [CollectionImageObject] = []
    var arrLowVoltageImg: [CollectionImageObject] = []
    var arrFiberOpticImg: [CollectionImageObject] = []
    var arrFiberWorkingImg: [CollectionImageObject] = []
    var arrMultiLightSynchImg: [CollectionImageObject] = []
    var arrSpaLightImg: [CollectionImageObject] = []
    var arrBasinLightImg: [CollectionImageObject] = []
    var arrFreeWaterImg: [CollectionImageObject] = []
    var arrLightMountedImg: [CollectionImageObject] = []
    var arrProperGFIImg: [CollectionImageObject] = []
    var arrGFITrippedImg: [CollectionImageObject] = []
    var arrSafetyAroundImg: [CollectionImageObject] = []
    var arrExposedWiringImg: [CollectionImageObject] = []
    var arrAccessoriesImg: [CollectionImageObject] = []
    var arrEquipmentBondImg: [CollectionImageObject] = []
    var arrElectProperGFIImg: [CollectionImageObject] = []
    var arrElectricalGFITImg: [CollectionImageObject] = []
    var arrWireHangingImg: [CollectionImageObject] = []
    var arrBoxesMountedImg: [CollectionImageObject] = []
    
    
    //For Image Server path
    var strImgLightMain = String()
    var strImgLightWorking = String()
    var strImgLowVoltage = String()
    var strImgFiberOptic = String()
    var strImgFiberWorking = String()
    var strImgMultiLightSynch = String()
    var strImgSpaLight = String()
    var strImgBasinLight = String()
    var strImgFreeWater = String()
    var strImgLightMounted = String()
    var strImgProperGFI = String()
    var strImgGFITripped = String()
    var strImgSafetyAround = String()
    var strImgExposedWiring = String()
    var strImgAccessories = String()
    var strImgEquipmentBond = String()
    var strImgElectProperGFI = String()
    var strImgElectricalGFIT = String()
    var strImgWireHanging = String()
    var strImgBoxesMounted = String()
    
    
    //For Image CoreData
    var dataTimeMainImg = NSData()
    var dataImgLightMain = NSData()
    var dataImgLightWorking = NSData()
    var dataImgLowVoltage = NSData()
    var dataImgFiberOptic = NSData()
    var dataImgFiberWorking = NSData()
    var dataImgMultiLightSynch = NSData()
    var dataImgSpaLight = NSData()
    var dataImgBasinLight = NSData()
    var dataImgFreeWater = NSData()
    var dataImgLightMounted = NSData()
    var dataImgProperGFI = NSData()
    var dataImgGFITripped = NSData()
    var dataImgSafetyAround = NSData()
    var dataImgExposedWiring = NSData()
    var dataImgAccessories = NSData()
    var dataImgEquipmentBond = NSData()
    var dataImgElectProperGFI = NSData()
    var dataImgElectricalGFIT = NSData()
    var dataImgWireHanging = NSData()
    var dataImgBoxesMounted = NSData()
    
    
    //For Optional Value
    var strOptLightWorking = String()
    var strOptLowVoltage = String()
    var strOptFiberOptic = String()
    var strOptFiberWorking = String()
    var strOptMultiLightSynch = String()
    var strOptSpaLight = String()
    var strOptBasinLight = String()
    var strOptFreeWater = String()
    var strOptLightMounted = String()
    var strOptProperGFI = String()
    var strOptGFITripped = String()
    var strOptSafetyAround = String()
    var strOptExposedWiring = String()
    var strOptAccessories = String()
    var strOptEquipmentBond = String()
    var strOptElectProperGFI = String()
    var strOptElectricalGFIT = String()
    var strOptWireHanging = String()
    var strOptBoxesMounted = String()
     
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.prepareFormLightData()
    }
    
    func prepareFormLightData() {
        for _ in 0..<21 {
            let obj = formInspectionPoolData()
            self.secInspectLight.append(obj)
        }
        for _ in 0..<5 {
            let obj = formInspectionPoolData()
            self.secLight.append(obj)
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
        let indexOfCell = self.tblLight.indexPath(for: cell)
        print("Clicked Index : \(String(describing: indexOfCell?.row))")
        
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
    
    //MARK:- ObjectiveC Function
    @objc func btnNextDidTap() {
        self.updateCoreData()
        self.view.endEditing(true)
        //self.postInspectLight()
        if UIDevice.current.userInterfaceIdiom == .phone {
           let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
           let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectFencing") as! InspectFencingVC
           self.navigationController?.pushViewController(formVC, animated: true)
        } else if UIDevice.current.userInterfaceIdiom == .pad {
           let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
           let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectFencing") as! InspectFencingVC
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
                    
                    managedObject.setValue(dataImgLightMain, forKey: "lightMainImage")
                    managedObject.setValue(strOptLightWorking, forKey: "lightWorkingOption")
                    managedObject.setValue(dataImgLightWorking, forKey: "lightWorkingImage")
                    managedObject.setValue(self.secInspectLight[InspectLight.lightWorking.rawValue].formTextValue, forKey: "lightWorkingData")
                    managedObject.setValue(strOptLowVoltage, forKey: "lowVoltageOption")
                    managedObject.setValue(dataImgLowVoltage, forKey: "lowVoltageImage")
                    managedObject.setValue(self.secInspectLight[InspectLight.lowVoltage.rawValue].formTextValue, forKey: "lowVoltageData")
                    managedObject.setValue(strOptFiberOptic, forKey: "fiberOpticOption")
                    managedObject.setValue(dataImgFiberOptic, forKey: "fiberOpticImage")
                    managedObject.setValue(self.secInspectLight[InspectLight.fiberLightning.rawValue].formTextValue, forKey: "fiberOpticData")
                    managedObject.setValue(strOptFiberWorking, forKey: "fiberWorkingOption")
                    managedObject.setValue(dataImgFiberWorking, forKey: "fiberWorkingImage")
                    managedObject.setValue(self.secInspectLight[InspectLight.fiberWorking.rawValue].formTextValue, forKey: "fiberWorkingData")
                    managedObject.setValue(strOptMultiLightSynch, forKey: "multiSynchOption")
                    managedObject.setValue(dataImgMultiLightSynch, forKey: "multiSynchImage")
                    managedObject.setValue(self.secInspectLight[InspectLight.multiSynch.rawValue].formTextValue, forKey: "multiSynchData")
                    managedObject.setValue(strOptSpaLight, forKey: "spaLightOption")
                    managedObject.setValue(dataImgSpaLight, forKey: "spaLightImage")
                    managedObject.setValue(self.secInspectLight[InspectLight.spaLight.rawValue].formTextValue, forKey: "spaLightData")
                    managedObject.setValue(strOptBasinLight, forKey: "basinLightOption")
                    managedObject.setValue(dataImgBasinLight, forKey: "basinLightImage")
                    managedObject.setValue(self.secInspectLight[InspectLight.basinLight.rawValue].formTextValue, forKey: "basinLightData")
                    managedObject.setValue(strOptFreeWater, forKey: "freeWaterOption")
                    managedObject.setValue(dataImgFreeWater, forKey: "freeWaterImage")
                    managedObject.setValue(self.secInspectLight[InspectLight.freeWater.rawValue].formTextValue, forKey: "freeWaterData")
                    managedObject.setValue(strOptLightMounted, forKey: "lightMountedOption")
                    managedObject.setValue(dataImgLightMounted, forKey: "lightMountedImage")
                    managedObject.setValue(self.secInspectLight[InspectLight.lightMounted.rawValue].formTextValue, forKey: "lightMountedData")
                    managedObject.setValue(strOptProperGFI, forKey: "lightProperGFIOption")
                    managedObject.setValue(dataImgProperGFI, forKey: "lightProperGFIImage")
                    managedObject.setValue(self.secInspectLight[InspectLight.properGFI.rawValue].formTextValue, forKey: "lightProperGFIData")
                    managedObject.setValue(strOptGFITripped, forKey: "trippedOption")
                    managedObject.setValue(dataImgGFITripped, forKey: "trippedImage")
                    managedObject.setValue(self.secInspectLight[InspectLight.GFITripped.rawValue].formTextValue, forKey: "trippedData")
                    managedObject.setValue(strOptSafetyAround, forKey: "poolSafetyOption")
                    managedObject.setValue(dataImgSafetyAround, forKey: "poolSafetyImage")
                    managedObject.setValue(self.secInspectLight[InspectLight.poolSafety.rawValue].formTextValue, forKey: "poolSafetyData")
                    managedObject.setValue(strOptExposedWiring, forKey: "exposeWiringOption")
                    managedObject.setValue(dataImgExposedWiring, forKey: "exposeWiringImage")
                    managedObject.setValue(self.secInspectLight[InspectLight.exposeWiring.rawValue].formTextValue, forKey: "exposeWiringData")
                    managedObject.setValue(strOptAccessories, forKey: "disconnectedAccessoriesOption")
                    managedObject.setValue(dataImgAccessories, forKey: "disconnectedAccessoriesImage")
                    managedObject.setValue(self.secInspectLight[InspectLight.disconnectedAccessories.rawValue].formTextValue, forKey: "disconnectedAccessoriesData")
                    managedObject.setValue(strOptEquipmentBond, forKey: "equipmentBondOption")
                    managedObject.setValue(dataImgEquipmentBond, forKey: "equipmentBondImage")
                    managedObject.setValue(self.secInspectLight[InspectLight.equipmentBond.rawValue].formTextValue, forKey: "equipmentBondData")
                    managedObject.setValue(strOptElectProperGFI, forKey: "electricalProperGFIOption")
                    managedObject.setValue(dataImgElectProperGFI, forKey: "electricalProperGFIImage")
                    managedObject.setValue(self.secInspectLight[InspectLight.electricalProperGFI.rawValue].formTextValue, forKey: "electricalProperGFIData")
                    managedObject.setValue(strOptElectricalGFIT, forKey: "electricalGFITrippedOption")
                    managedObject.setValue(dataImgElectricalGFIT, forKey: "electricalGFITrippedImage")
                    managedObject.setValue(self.secInspectLight[InspectLight.electricalGFITripped.rawValue].formTextValue, forKey: "electricalGFITrippedData")
                    managedObject.setValue(strOptWireHanging, forKey: "wireHiringOption")
                    managedObject.setValue(dataImgWireHanging, forKey: "wireHiringImage")
                    managedObject.setValue(self.secInspectLight[InspectLight.wireHiring.rawValue].formTextValue, forKey: "wireHiringData")
                    managedObject.setValue(strOptBoxesMounted, forKey: "boxMountedOption")
                    managedObject.setValue(dataImgBoxesMounted, forKey: "boxMountedImage")
                    managedObject.setValue(self.secInspectLight[InspectLight.electricalBoxMounted.rawValue].formTextValue, forKey: "boxMountedData")
                    
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
                        print("Data of InspectLightVC:: \(data)")
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
                        self.strImgLightMain = String(describing: data!)
                    } else if self.fetchIndexForUpload == 1 {
                        self.strImgLightWorking = String(describing: data!)
                    } else if self.fetchIndexForUpload == 2 {
                        self.strImgLowVoltage = String(describing: data!)
                    } else if self.fetchIndexForUpload == 3 {
                        self.strImgFiberOptic = String(describing: data!)
                    } else if self.fetchIndexForUpload == 4 {
                        self.strImgFiberWorking = String(describing: data!)
                    } else if self.fetchIndexForUpload == 5 {
                        self.strImgMultiLightSynch = String(describing: data!)
                    } else if self.fetchIndexForUpload == 6 {
                        self.strImgSpaLight = String(describing: data!)
                    } else if self.fetchIndexForUpload == 7 {
                        self.strImgBasinLight = String(describing: data!)
                    } else if self.fetchIndexForUpload == 8 {
                        self.strImgFreeWater = String(describing: data!)
                    } else if self.fetchIndexForUpload == 9 {
                        self.strImgLightMounted = String(describing: data!)
                    } else if self.fetchIndexForUpload == 10 {
                        self.strImgProperGFI = String(describing: data!)
                    } else if self.fetchIndexForUpload == 11 {
                        self.strImgGFITripped = String(describing: data!)
                    } else if self.fetchIndexForUpload == 13 {
                        self.strImgSafetyAround = String(describing: data!)
                    } else if self.fetchIndexForUpload == 14 {
                        self.strImgExposedWiring = String(describing: data!)
                    } else if self.fetchIndexForUpload == 15 {
                        self.strImgAccessories = String(describing: data!)
                    } else if self.fetchIndexForUpload == 16 {
                        self.strImgEquipmentBond = String(describing: data!)
                    } else if self.fetchIndexForUpload == 17 {
                        self.strImgElectProperGFI = String(describing: data!)
                    } else if self.fetchIndexForUpload == 18 {
                        self.strImgElectricalGFIT = String(describing: data!)
                    } else if self.fetchIndexForUpload == 19 {
                        self.strImgWireHanging = String(describing: data!)
                    } else if self.fetchIndexForUpload == 20 {
                        self.strImgBoxesMounted = String(describing: data!)
                    }
                    
                    SVProgressHUD.dismiss()
                }
            case .failure(let encodingError):
                print("error:\(encodingError)")
                SVProgressHUD.dismiss()
            }
        })
    }
    
    func postInspectLight() {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        
        let return_id = UserDefaults.standard.value(forKey: "returnKeyForInspection")
        
         let inspectLightDetails: NSMutableDictionary = [
            "return_data_id"                : return_id!,
            "lightMainImage"                : strImgLightMain,
            "lightWorkingOption"            : strOptLightWorking,
            "lightWorkingImage"             : strImgLightWorking,
            "lightWorkingData"              : self.secInspectLight[InspectLight.lightWorking.rawValue].formTextValue,
            "lowVoltageOption"              : strOptLowVoltage,
            "lowVoltageImage"               : strImgLowVoltage,
            "lowVoltageData"                : self.secInspectLight[InspectLight.lowVoltage.rawValue].formTextValue,
            "fiberOpticOption"              : strOptFiberOptic,
            "fiberOpticImage"               : strImgFiberOptic,
            "fiberOpticData"                : self.secInspectLight[InspectLight.fiberLightning.rawValue].formTextValue,
            "fiberWorkingOption"            : strOptFiberWorking,
            "fiberWorkingImage"             : strImgFiberWorking,
            "fiberWorkingData"              : self.secInspectLight[InspectLight.fiberWorking.rawValue].formTextValue,
            "multiSynchOption"              : strOptMultiLightSynch,
            "multiSynchImage"               : strImgMultiLightSynch,
            "multiSynchData"                : self.secInspectLight[InspectLight.multiSynch.rawValue].formTextValue,
            "spaLightOption"                : strOptSpaLight,
            "spaLightImage"                 : strImgSpaLight,
            "spaLightData"                  : self.secInspectLight[InspectLight.spaLight.rawValue].formTextValue,
            "basinLightOption"              : strOptBasinLight,
            "basinLightImage"               : strImgBasinLight,
            "basinLightData"                : self.secInspectLight[InspectLight.basinLight.rawValue].formTextValue,
            "freeWaterOption"               : strOptFreeWater,
            "freeWaterImage"                : strImgFreeWater,
            "freeWaterData"                 : self.secInspectLight[InspectLight.freeWater.rawValue].formTextValue,
            "lightMountedOption"            : strOptLightMounted,
            "lightMountedImage"             : strImgLightMounted,
            "lightMountedData"              : self.secInspectLight[InspectLight.lightMounted.rawValue].formTextValue,
            "lightProperGFIOption"          : strOptProperGFI,
            "lightProperGFIImage"           : strImgProperGFI,
            "lightProperGFIData"            : self.secInspectLight[InspectLight.properGFI.rawValue].formTextValue,
            "trippedOption"                 : strOptGFITripped,
            "trippedImage"                  : strImgGFITripped,
            "trippedData"                   : self.secInspectLight[InspectLight.GFITripped.rawValue].formTextValue,
            "poolSafetyOption"              : strOptSafetyAround,
            "poolSafetyImage"               : strImgSafetyAround,
            "poolSafetyData"                : self.secInspectLight[InspectLight.poolSafety.rawValue].formTextValue,
            "exposeWiringOption"            : strOptExposedWiring,
            "exposeWiringImage"             : strImgExposedWiring,
            "exposeWiringData"              : self.secInspectLight[InspectLight.exposeWiring.rawValue].formTextValue,
            "disconnectedAccessoriesOption" : strOptAccessories,
            "disconnectedAccessoriesImage"  : strImgAccessories,
            "disconnectedAccessoriesData"   : self.secInspectLight[InspectLight.disconnectedAccessories.rawValue].formTextValue,
            "equipmentBondOption"           : strOptEquipmentBond,
            "equipmentBondImage"            : strImgEquipmentBond,
            "equipmentBondData"             : self.secInspectLight[InspectLight.equipmentBond.rawValue].formTextValue,
            "electricalProperGFIOption"     : strOptElectProperGFI,
            "electricalProperGFIImage"      : strImgElectProperGFI,
            "electricalProperGFIData"       : self.secInspectLight[InspectLight.electricalProperGFI.rawValue].formTextValue,
            "electricalGFITrippedOption"    : strOptElectricalGFIT,
            "electricalGFITrippedImage"     : strImgElectricalGFIT,
            "electricalGFITrippedData"      : self.secInspectLight[InspectLight.electricalGFITripped.rawValue].formTextValue,
            "wireHiringOption"              : strOptWireHanging,
            "wireHiringImage"               : strImgWireHanging,
            "wireHiringData"                : self.secInspectLight[InspectLight.wireHiring.rawValue].formTextValue,
            "boxMountedOption"              : strOptBoxesMounted,
            "boxMountedImage"               : strImgBoxesMounted,
            "boxMountedData"                : self.secInspectLight[InspectLight.electricalBoxMounted.rawValue].formTextValue
        ]

        print("inspectLightDetails :: \(inspectLightDetails)")
        //if sharedExtension.connectedToNetwork() {
        ApiManager.sharedInstanceAPI.PostInspectLight(postId: 1, lightDetails: inspectLightDetails, onSuccess: { json in
            DispatchQueue.main.async {
                print("InspectionFittingsDetails json :: \(String(describing: json))")
                DispatchQueue.main.async(execute: {() -> Void in
                    if UIDevice.current.userInterfaceIdiom == .phone {
                       let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
                       let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectFencing") as! InspectFencingVC
                       self.navigationController?.pushViewController(formVC, animated: true)
                    } else if UIDevice.current.userInterfaceIdiom == .pad {
                       let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
                       let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectFencing") as! InspectFencingVC
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

extension InspectLightVC: UploadCollectionProtocol {
    func didTapOnCellItem(_indexpath: IndexPath, _imgUrl: String, _videoUrl: String) {
        
    }
    
    func didUpdateCellIndex(_indexpath: Int) {
        
    }
}


extension InspectLightVC: OpalImagePickerControllerDelegate {
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
                                self.arrLightMainImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.setPostImage(arrOfImages: images)
                                self.dataImgLightMain = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForUpload == 1 {
                                self.arrLightWorkingImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.setPostImage(arrOfImages: images)
                                self.dataImgLightWorking = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForUpload == 2 {
                                self.arrLowVoltageImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                 //self.setPostImage(arrOfImages: images)
                                 self.dataImgLowVoltage = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForUpload == 3 {
                                self.arrFiberOpticImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                 //self.setPostImage(arrOfImages: images)
                                 self.dataImgFiberOptic = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForUpload == 4 {
                                self.arrFiberWorkingImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                 //self.setPostImage(arrOfImages: images)
                                 self.dataImgFiberWorking = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForUpload == 5 {
                                self.arrMultiLightSynchImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                 //self.setPostImage(arrOfImages: images)
                                 self.dataImgMultiLightSynch = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForUpload == 6 {
                                self.arrSpaLightImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                 //self.setPostImage(arrOfImages: images)
                                 self.dataImgSpaLight = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForUpload == 7 {
                                self.arrBasinLightImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                 //self.setPostImage(arrOfImages: images)
                                 self.dataImgBasinLight = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForUpload == 8 {
                                self.arrFreeWaterImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                 //self.setPostImage(arrOfImages: images)
                                 self.dataImgFreeWater = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForUpload == 9 {
                                self.arrLightMountedImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                 //self.setPostImage(arrOfImages: images)
                                 self.dataImgLightMounted = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForUpload == 10 {
                                self.arrProperGFIImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                 //self.setPostImage(arrOfImages: images)
                                 self.dataImgProperGFI = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForUpload == 11 {
                                self.arrGFITrippedImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                 //self.setPostImage(arrOfImages: images)
                                 self.dataImgGFITripped = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForUpload == 13 {
                                self.arrSafetyAroundImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                 //self.setPostImage(arrOfImages: images)
                                 self.dataImgSafetyAround = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForUpload == 14 {
                                self.arrExposedWiringImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                 //self.setPostImage(arrOfImages: images)
                                 self.dataImgExposedWiring = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForUpload == 15 {
                                self.arrAccessoriesImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                 //self.setPostImage(arrOfImages: images)
                                 self.dataImgAccessories = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForUpload == 16 {
                                self.arrEquipmentBondImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                 //self.setPostImage(arrOfImages: images)
                                 self.dataImgEquipmentBond = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForUpload == 17 {
                                self.arrElectProperGFIImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                 //self.setPostImage(arrOfImages: images)
                                 self.dataImgElectProperGFI = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForUpload == 18 {
                                self.arrElectricalGFITImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                 //self.setPostImage(arrOfImages: images)
                                 self.dataImgElectricalGFIT = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForUpload == 19 {
                                self.arrWireHangingImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                 //self.setPostImage(arrOfImages: images)
                                 self.dataImgWireHanging = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForUpload == 20 {
                                self.arrBoxesMountedImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                 //self.setPostImage(arrOfImages: images)
                                 self.dataImgBoxesMounted = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
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
                self.tblLight.reloadData()
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

extension InspectLightVC: UIImagePickerControllerDelegate {
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
            self.arrLightMainImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataImgLightMain = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if self.fetchIndexForUpload == 1 {
            self.arrLightWorkingImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataImgLightWorking = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if self.fetchIndexForUpload == 2 {
            self.arrLowVoltageImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataImgLowVoltage = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if self.fetchIndexForUpload == 3 {
            self.arrFiberOpticImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataImgFiberOptic = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if self.fetchIndexForUpload == 4 {
            self.arrFiberWorkingImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataImgFiberWorking = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if self.fetchIndexForUpload == 5 {
            self.arrMultiLightSynchImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataImgMultiLightSynch = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if self.fetchIndexForUpload == 6 {
            self.arrSpaLightImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataImgSpaLight = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if self.fetchIndexForUpload == 7 {
            self.arrBasinLightImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataImgBasinLight = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if self.fetchIndexForUpload == 8 {
            self.arrFreeWaterImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataImgFreeWater = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if self.fetchIndexForUpload == 9 {
            self.arrLightMountedImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataImgLightMounted = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if self.fetchIndexForUpload == 10 {
            self.arrProperGFIImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataImgProperGFI = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if self.fetchIndexForUpload == 11 {
            self.arrGFITrippedImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataImgGFITripped = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if self.fetchIndexForUpload == 13 {
            self.arrSafetyAroundImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataImgSafetyAround = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if self.fetchIndexForUpload == 14 {
            self.arrExposedWiringImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataImgExposedWiring = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if self.fetchIndexForUpload == 15 {
            self.arrAccessoriesImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataImgAccessories = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if self.fetchIndexForUpload == 16 {
            self.arrEquipmentBondImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataImgEquipmentBond = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if self.fetchIndexForUpload == 17 {
            self.arrElectProperGFIImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataImgElectProperGFI = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if self.fetchIndexForUpload == 18 {
            self.arrElectricalGFITImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataImgElectricalGFIT = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if self.fetchIndexForUpload == 19 {
            self.arrWireHangingImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataImgWireHanging = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if self.fetchIndexForUpload == 20 {
            self.arrBoxesMountedImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataImgBoxesMounted = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        }
        
        self.tblLight.reloadData()
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
}

extension InspectLightVC: UITextViewDelegate {
   func textViewDidEndEditing(_ textView: UITextView) {
        var cell = UITableViewCell()
        cell = (textView.superview?.superview as? UITableViewCell)!
        
        if let InspectionPoolLightWorkingTableCell = cell as? InspectionPoolLightWorkingTableCell {
            if textView == InspectionPoolLightWorkingTableCell.txtLightWork {
                self.secInspectLight[InspectLight.lightWorking.rawValue].formTextValue = (textView.text)!
           }
        } else if let InspectionLowVoltageTableCell = cell as? InspectionLowVoltageTableCell {
            if textView == InspectionLowVoltageTableCell.txtLowVoltage {
                self.secInspectLight[InspectLight.lowVoltage.rawValue].formTextValue = (textView.text)!
            }
        } else if let InspectionFiberOpticLightingTableCell = cell as? InspectionFiberOpticLightingTableCell {
            if textView == InspectionFiberOpticLightingTableCell.txtFiberLightning {
                self.secInspectLight[InspectLight.fiberLightning.rawValue].formTextValue = (textView.text)!
            }
        } else if let InspectionFiberOpticWorkingTableCell = cell as? InspectionFiberOpticWorkingTableCell {
            if textView == InspectionFiberOpticWorkingTableCell.txtFiberWorking {
                self.secInspectLight[InspectLight.fiberWorking.rawValue].formTextValue = (textView.text)!
            }
        } else if let InspectionMultiLightSynchTableCell = cell as? InspectionMultiLightSynchTableCell {
            if textView == InspectionMultiLightSynchTableCell.txtMultiSynch {
                self.secInspectLight[InspectLight.multiSynch.rawValue].formTextValue = (textView.text)!
            }
        } else if let InspectionSpaLightWorkingTableCell = cell as? InspectionSpaLightWorkingTableCell {
            if textView == InspectionSpaLightWorkingTableCell.txtSpaLight {
                self.secInspectLight[InspectLight.spaLight.rawValue].formTextValue = (textView.text)!
            }
        } else if let InspectionBasinLightWorkingTableCell = cell as? InspectionBasinLightWorkingTableCell {
            if textView == InspectionBasinLightWorkingTableCell.txtBasinLight {
                self.secInspectLight[InspectLight.basinLight.rawValue].formTextValue = (textView.text)!
            }
        } else if let InspectionLightFreeWaterTableCell = cell as? InspectionLightFreeWaterTableCell {
            if textView == InspectionLightFreeWaterTableCell.txtFreeWater {
                self.secInspectLight[InspectLight.freeWater.rawValue].formTextValue = (textView.text)!
            }
        } else if let InspectionAllLightMountedTableCell = cell as? InspectionAllLightMountedTableCell {
            if textView == InspectionAllLightMountedTableCell.txtLightMounted {
                self.secInspectLight[InspectLight.lightMounted.rawValue].formTextValue = (textView.text)!
            }
        } else if let InspectionProperGFITableCell = cell as? InspectionProperGFITableCell {
            if textView == InspectionProperGFITableCell.txtProperGFI {
                self.secInspectLight[InspectLight.properGFI.rawValue].formTextValue = (textView.text)!
            }
        } else if let InspectionGFITrippedTableCell = cell as? InspectionGFITrippedTableCell {
            if textView == InspectionGFITrippedTableCell.txtGFITripped {
                self.secInspectLight[InspectLight.GFITripped.rawValue].formTextValue = (textView.text)!
            }
        } else if let InspectionElectricalSafetyAroundPoolTableCell = cell as? InspectionElectricalSafetyAroundPoolTableCell {
            if textView == InspectionElectricalSafetyAroundPoolTableCell.txtPoolSafety {
                self.secInspectLight[InspectLight.poolSafety.rawValue].formTextValue = (textView.text)!
            }
        } else if let InspectionElectricalExposedWiringTableCell = cell as? InspectionElectricalExposedWiringTableCell {
            if textView == InspectionElectricalExposedWiringTableCell.txtExposeWiring {
                self.secInspectLight[InspectLight.exposeWiring.rawValue].formTextValue = (textView.text)!
            }
        } else if let InspectionDisconnectedAccessoriesTableCell = cell as? InspectionDisconnectedAccessoriesTableCell {
            if textView == InspectionDisconnectedAccessoriesTableCell.txtDisconnectedAccessories {
                self.secInspectLight[InspectLight.disconnectedAccessories.rawValue].formTextValue = (textView.text)!
            }
        } else if let InspectionElectricalEquipmentBondTableCell = cell as? InspectionElectricalEquipmentBondTableCell {
            if textView == InspectionElectricalEquipmentBondTableCell.txtEquipmentBond {
                self.secInspectLight[InspectLight.equipmentBond.rawValue].formTextValue = (textView.text)!
            }
        } else if let InspectionElectricalProperGFITableCell = cell as? InspectionElectricalProperGFITableCell {
            if textView == InspectionElectricalProperGFITableCell.txtProperGFI {
                self.secInspectLight[InspectLight.electricalProperGFI.rawValue].formTextValue = (textView.text)!
            }
        } else if let InspectionElectricalGFITrippedTableCell = cell as? InspectionElectricalGFITrippedTableCell {
            if textView == InspectionElectricalGFITrippedTableCell.txtGFITripped {
                self.secInspectLight[InspectLight.electricalGFITripped.rawValue].formTextValue = (textView.text)!
            }
        } else if let InspectionElectricalWireHangingTableCell = cell as? InspectionElectricalWireHangingTableCell {
            if textView == InspectionElectricalWireHangingTableCell.txtWireHiring {
                self.secInspectLight[InspectLight.wireHiring.rawValue].formTextValue = (textView.text)!
            }
        } else if let InspectionElectricalBoxesMountedTableCell = cell as? InspectionElectricalBoxesMountedTableCell {
            if textView == InspectionElectricalBoxesMountedTableCell.txtBoxMounted {
                self.secInspectLight[InspectLight.electricalBoxMounted.rawValue].formTextValue = (textView.text)!
            }
        }
    }
}

extension InspectLightVC: UITableViewDataSource, UITableViewDelegate {
    //MARK:- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 22
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cameraCell = tableView.dequeueReusableCell(withIdentifier: "CameraCell", for: indexPath) as! CameraTableCell
            
            cameraCell.lblHeader.text = "Lights"
            if UIDevice.current.userInterfaceIdiom == .phone {
                cameraCell.lblHeader.font = UIFont.init(name: "Roboto-bold", size: 16.0)
            } else {
                cameraCell.lblHeader.font = UIFont.init(name: "Roboto-bold", size: 24.0)
            }
            cameraCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

            cameraCell.collectionVw.arrItems = arrLightMainImg
            cameraCell.collectionVw.delegateItemCollection = self
            cameraCell.collectionVw.reloadImageCollection()
            
            if arrLightMainImg.count > 0 {
                cameraCell.btnUpload.isHidden = true
                cameraCell.collectionVw.isHidden = false
            } else {
                cameraCell.btnUpload.isHidden = false
                cameraCell.collectionVw.isHidden = true
            }
            
            return cameraCell
        } else if indexPath.row == 1 {
            let lightWorkingCell = tableView.dequeueReusableCell(withIdentifier: "InspectionPoolLightWorkingCell", for: indexPath) as! InspectionPoolLightWorkingTableCell
            
            lightWorkingCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

            lightWorkingCell.collectionvw.arrItems = arrLightWorkingImg
            lightWorkingCell.collectionvw.delegateItemCollection = self
            lightWorkingCell.collectionvw.reloadImageCollection()
            
            if arrLightWorkingImg.count > 0 {
                lightWorkingCell.btnUpload.isHidden = true
                lightWorkingCell.collectionvw.isHidden = false
            } else {
                lightWorkingCell.btnUpload.isHidden = false
                lightWorkingCell.collectionvw.isHidden = true
            }
            
            lightWorkingCell.delegateLightWorking = self
            lightWorkingCell.txtLightWork.delegate = self
            
            return lightWorkingCell
        } else if indexPath.row == 2 {
            let lowVoltageCell = tableView.dequeueReusableCell(withIdentifier: "InspectionLowVoltageCell", for: indexPath) as! InspectionLowVoltageTableCell
            
            lowVoltageCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

            lowVoltageCell.collectionvw.arrItems = arrLowVoltageImg
            lowVoltageCell.collectionvw.delegateItemCollection = self
            lowVoltageCell.collectionvw.reloadImageCollection()
            
            if arrLowVoltageImg.count > 0 {
                lowVoltageCell.btnUpload.isHidden = true
                lowVoltageCell.collectionvw.isHidden = false
            } else {
                lowVoltageCell.btnUpload.isHidden = false
                lowVoltageCell.collectionvw.isHidden = true
            }
            
            lowVoltageCell.delegateLightLowVoltage = self
            lowVoltageCell.txtLowVoltage.delegate = self
            
            return lowVoltageCell
        } else if indexPath.row == 3 {
            let fiberOpticCell = tableView.dequeueReusableCell(withIdentifier: "InspectionFiberOpticLightingCell", for: indexPath) as! InspectionFiberOpticLightingTableCell
            
            fiberOpticCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

            fiberOpticCell.collectionvw.arrItems = arrFiberOpticImg
            fiberOpticCell.collectionvw.delegateItemCollection = self
            fiberOpticCell.collectionvw.reloadImageCollection()
            
            if arrFiberOpticImg.count > 0 {
                fiberOpticCell.btnUpload.isHidden = true
                fiberOpticCell.collectionvw.isHidden = false
            } else {
                fiberOpticCell.btnUpload.isHidden = false
                fiberOpticCell.collectionvw.isHidden = true
            }
            
            fiberOpticCell.delegateLightFiberOptic = self
            fiberOpticCell.txtFiberLightning.delegate = self
            
            return fiberOpticCell
        } else if indexPath.row == 4 {
            let fiberOpticWorkingCell = tableView.dequeueReusableCell(withIdentifier: "InspectionFiberOpticWorkingCell", for: indexPath) as! InspectionFiberOpticWorkingTableCell
            
            fiberOpticWorkingCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

            fiberOpticWorkingCell.collectionvw.arrItems = arrFiberWorkingImg
            fiberOpticWorkingCell.collectionvw.delegateItemCollection = self
            fiberOpticWorkingCell.collectionvw.reloadImageCollection()
            
            if arrFiberWorkingImg.count > 0 {
                fiberOpticWorkingCell.btnUpload.isHidden = true
                fiberOpticWorkingCell.collectionvw.isHidden = false
            } else {
                fiberOpticWorkingCell.btnUpload.isHidden = false
                fiberOpticWorkingCell.collectionvw.isHidden = true
            }
            
            fiberOpticWorkingCell.delegateLightFiberOpticWorking = self
            fiberOpticWorkingCell.txtFiberWorking.delegate = self
            
            return fiberOpticWorkingCell
        } else if indexPath.row == 5 {
            let multiLightSynchCell = tableView.dequeueReusableCell(withIdentifier: "InspectionMultiLightSynchCell", for: indexPath) as! InspectionMultiLightSynchTableCell
            
            multiLightSynchCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

            multiLightSynchCell.collectionvw.arrItems = arrMultiLightSynchImg
            multiLightSynchCell.collectionvw.delegateItemCollection = self
            multiLightSynchCell.collectionvw.reloadImageCollection()
            
            if arrMultiLightSynchImg.count > 0 {
                multiLightSynchCell.btnUpload.isHidden = true
                multiLightSynchCell.collectionvw.isHidden = false
            } else {
                multiLightSynchCell.btnUpload.isHidden = false
                multiLightSynchCell.collectionvw.isHidden = true
            }
            
            multiLightSynchCell.delegateMultiLightSynch = self
            multiLightSynchCell.txtMultiSynch.delegate = self
            
            return multiLightSynchCell
        } else if indexPath.row == 6 {
            let spaLightCell = tableView.dequeueReusableCell(withIdentifier: "InspectionSpaLightWorkingCell", for: indexPath) as! InspectionSpaLightWorkingTableCell
            
            spaLightCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

            spaLightCell.collectionvw.arrItems = arrSpaLightImg
            spaLightCell.collectionvw.delegateItemCollection = self
            spaLightCell.collectionvw.reloadImageCollection()
            
            if arrSpaLightImg.count > 0 {
                spaLightCell.btnUpload.isHidden = true
                spaLightCell.collectionvw.isHidden = false
            } else {
                spaLightCell.btnUpload.isHidden = false
                spaLightCell.collectionvw.isHidden = true
            }
            
            spaLightCell.delegateSpaLightWorking = self
            spaLightCell.txtSpaLight.delegate = self
            
            return spaLightCell
        } else if indexPath.row == 7 {
            let basinLightCell = tableView.dequeueReusableCell(withIdentifier: "InspectionBasinLightWorkingCell", for: indexPath) as! InspectionBasinLightWorkingTableCell
            
            basinLightCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

            basinLightCell.collectionvw.arrItems = arrBasinLightImg
            basinLightCell.collectionvw.delegateItemCollection = self
            basinLightCell.collectionvw.reloadImageCollection()
            
            if arrBasinLightImg.count > 0 {
                basinLightCell.btnUpload.isHidden = true
                basinLightCell.collectionvw.isHidden = false
            } else {
                basinLightCell.btnUpload.isHidden = false
                basinLightCell.collectionvw.isHidden = true
            }
            
            basinLightCell.delegateBasinLight = self
            basinLightCell.txtBasinLight.delegate = self
            
            return basinLightCell
        } else if indexPath.row == 8 {
            let freeWaterCell = tableView.dequeueReusableCell(withIdentifier: "InspectionLightFreeWaterCell", for: indexPath) as! InspectionLightFreeWaterTableCell
            
            freeWaterCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

            freeWaterCell.collectionvw.arrItems = arrFreeWaterImg
            freeWaterCell.collectionvw.delegateItemCollection = self
            freeWaterCell.collectionvw.reloadImageCollection()
            
            if arrFreeWaterImg.count > 0 {
                freeWaterCell.btnUpload.isHidden = true
                freeWaterCell.collectionvw.isHidden = false
            } else {
                freeWaterCell.btnUpload.isHidden = false
                freeWaterCell.collectionvw.isHidden = true
            }
            
            freeWaterCell.delegateLightFreeWater = self
            freeWaterCell.txtFreeWater.delegate = self
            
            return freeWaterCell
        } else if indexPath.row == 9 {
            let lightMountedCell = tableView.dequeueReusableCell(withIdentifier: "InspectionAllLightMountedCell", for: indexPath) as! InspectionAllLightMountedTableCell
            
            lightMountedCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

            lightMountedCell.collectionvw.arrItems = arrLightMountedImg
            lightMountedCell.collectionvw.delegateItemCollection = self
            lightMountedCell.collectionvw.reloadImageCollection()
            
            if arrLightMountedImg.count > 0 {
                lightMountedCell.btnUpload.isHidden = true
                lightMountedCell.collectionvw.isHidden = false
            } else {
                lightMountedCell.btnUpload.isHidden = false
                lightMountedCell.collectionvw.isHidden = true
            }
            
            lightMountedCell.delegateLightMounted = self
            lightMountedCell.txtLightMounted.delegate = self
            
            return lightMountedCell
        } else if indexPath.row == 10 {
            let properGFICell = tableView.dequeueReusableCell(withIdentifier: "InspectionProperGFICell", for: indexPath) as! InspectionProperGFITableCell
            
            properGFICell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

            properGFICell.collectionvw.arrItems = arrProperGFIImg
            properGFICell.collectionvw.delegateItemCollection = self
            properGFICell.collectionvw.reloadImageCollection()
            
            if arrProperGFIImg.count > 0 {
                properGFICell.btnUpload.isHidden = true
                properGFICell.collectionvw.isHidden = false
            } else {
                properGFICell.btnUpload.isHidden = false
                properGFICell.collectionvw.isHidden = true
            }
            
            properGFICell.delegateProperGFI = self
            properGFICell.txtProperGFI.delegate = self
            
            return properGFICell
        } else if indexPath.row == 11 {
            let trippedCell = tableView.dequeueReusableCell(withIdentifier: "InspectionGFITrippedCell", for: indexPath) as! InspectionGFITrippedTableCell
            
            trippedCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

            trippedCell.collectionvw.arrItems = arrGFITrippedImg
            trippedCell.collectionvw.delegateItemCollection = self
            trippedCell.collectionvw.reloadImageCollection()
            
            if arrGFITrippedImg.count > 0 {
                trippedCell.btnUpload.isHidden = true
                trippedCell.collectionvw.isHidden = false
            } else {
                trippedCell.btnUpload.isHidden = false
                trippedCell.collectionvw.isHidden = true
            }
            
            trippedCell.delegateGFITripped = self
            trippedCell.txtGFITripped.delegate = self
            
            return trippedCell
        } else if indexPath.row == 12 {
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as! HeaderTableCell
            
            headerCell.lblHeaderText.text = "Electrical Safety"
            if UIDevice.current.userInterfaceIdiom == .phone {
                headerCell.lblHeaderText.font = UIFont.init(name: "Roboto-bold", size: 16.0)
            } else {
                headerCell.lblHeaderText.font = UIFont.init(name: "Roboto-bold", size: 24.0)
            }
            
            return headerCell
        } else if indexPath.row == 13 {
            let safetyAroundCell = tableView.dequeueReusableCell(withIdentifier: "InspectionElectricalSafetyAroundPoolCell", for: indexPath) as! InspectionElectricalSafetyAroundPoolTableCell
            
            safetyAroundCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

            safetyAroundCell.collectionvw.arrItems = arrSafetyAroundImg
            safetyAroundCell.collectionvw.delegateItemCollection = self
            safetyAroundCell.collectionvw.reloadImageCollection()
            
            if arrSafetyAroundImg.count > 0 {
                safetyAroundCell.btnUpload.isHidden = true
                safetyAroundCell.collectionvw.isHidden = false
            } else {
                safetyAroundCell.btnUpload.isHidden = false
                safetyAroundCell.collectionvw.isHidden = true
            }
            
            safetyAroundCell.delegateElectricalSafety = self
            safetyAroundCell.txtPoolSafety.delegate = self
            
            return safetyAroundCell
        } else if indexPath.row == 14 {
            let exposedWiringCell = tableView.dequeueReusableCell(withIdentifier: "InspectionElectricalExposedWiringCell", for: indexPath) as! InspectionElectricalExposedWiringTableCell
            
            exposedWiringCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

            exposedWiringCell.collectionvw.arrItems = arrExposedWiringImg
            exposedWiringCell.collectionvw.delegateItemCollection = self
            exposedWiringCell.collectionvw.reloadImageCollection()
            
            if arrExposedWiringImg.count > 0 {
                exposedWiringCell.btnUpload.isHidden = true
                exposedWiringCell.collectionvw.isHidden = false
            } else {
                exposedWiringCell.btnUpload.isHidden = false
                exposedWiringCell.collectionvw.isHidden = true
            }
            
            exposedWiringCell.delegateElectricalExposed = self
            exposedWiringCell.txtExposeWiring.delegate = self
            
            return exposedWiringCell
        } else if indexPath.row == 15 {
            let accessoriesCell = tableView.dequeueReusableCell(withIdentifier: "InspectionDisconnectedAccessoriesCell", for: indexPath) as! InspectionDisconnectedAccessoriesTableCell
            
            accessoriesCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

            accessoriesCell.collectionvw.arrItems = arrAccessoriesImg
            accessoriesCell.collectionvw.delegateItemCollection = self
            accessoriesCell.collectionvw.reloadImageCollection()
            
            if arrAccessoriesImg.count > 0 {
                accessoriesCell.btnUpload.isHidden = true
                accessoriesCell.collectionvw.isHidden = false
            } else {
                accessoriesCell.btnUpload.isHidden = false
                accessoriesCell.collectionvw.isHidden = true
            }
            
            accessoriesCell.delegateDisconnectedAccessories = self
            accessoriesCell.txtDisconnectedAccessories.delegate = self
            
            return accessoriesCell
        } else if indexPath.row == 16 {
            let equipmentBondCell = tableView.dequeueReusableCell(withIdentifier: "InspectionElectricalEquipmentBondCell", for: indexPath) as! InspectionElectricalEquipmentBondTableCell
            
            equipmentBondCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

            equipmentBondCell.collectionvw.arrItems = arrEquipmentBondImg
            equipmentBondCell.collectionvw.delegateItemCollection = self
            equipmentBondCell.collectionvw.reloadImageCollection()
            
            if arrEquipmentBondImg.count > 0 {
                equipmentBondCell.btnUpload.isHidden = true
                equipmentBondCell.collectionvw.isHidden = false
            } else {
                equipmentBondCell.btnUpload.isHidden = false
                equipmentBondCell.collectionvw.isHidden = true
            }
            
            equipmentBondCell.delegateElectricalEquipment = self
            equipmentBondCell.txtEquipmentBond.delegate = self
            
            return equipmentBondCell
        } else if indexPath.row == 17 {
            let eProperGFICell = tableView.dequeueReusableCell(withIdentifier: "InspectionElectricalProperGFICell", for: indexPath) as! InspectionElectricalProperGFITableCell
            
            eProperGFICell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

            eProperGFICell.collectionvw.arrItems = arrElectProperGFIImg
            eProperGFICell.collectionvw.delegateItemCollection = self
            eProperGFICell.collectionvw.reloadImageCollection()
            
            if arrElectProperGFIImg.count > 0 {
                eProperGFICell.btnUpload.isHidden = true
                eProperGFICell.collectionvw.isHidden = false
            } else {
                eProperGFICell.btnUpload.isHidden = false
                eProperGFICell.collectionvw.isHidden = true
            }
            
            eProperGFICell.delegateElectricalProperGFI = self
            eProperGFICell.txtProperGFI.delegate = self
            
            return eProperGFICell
        } else if indexPath.row == 18 {
            let eTrippedCell = tableView.dequeueReusableCell(withIdentifier: "InspectionElectricalGFITrippedCell", for: indexPath) as! InspectionElectricalGFITrippedTableCell
            
            eTrippedCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

            eTrippedCell.collectionvw.arrItems = arrElectricalGFITImg
            eTrippedCell.collectionvw.delegateItemCollection = self
            eTrippedCell.collectionvw.reloadImageCollection()
            
            if arrElectricalGFITImg.count > 0 {
                eTrippedCell.btnUpload.isHidden = true
                eTrippedCell.collectionvw.isHidden = false
            } else {
                eTrippedCell.btnUpload.isHidden = false
                eTrippedCell.collectionvw.isHidden = true
            }
            
            eTrippedCell.delegateElectricalGFITripped = self
            eTrippedCell.txtGFITripped.delegate = self
            
            return eTrippedCell
        } else if indexPath.row == 19 {
            let hangingCell = tableView.dequeueReusableCell(withIdentifier: "InspectionElectricalWireHangingCell", for: indexPath) as! InspectionElectricalWireHangingTableCell
            
            hangingCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

            hangingCell.collectionvw.arrItems = arrWireHangingImg
            hangingCell.collectionvw.delegateItemCollection = self
            hangingCell.collectionvw.reloadImageCollection()
            
            if arrWireHangingImg.count > 0 {
                hangingCell.btnUpload.isHidden = true
                hangingCell.collectionvw.isHidden = false
            } else {
                hangingCell.btnUpload.isHidden = false
                hangingCell.collectionvw.isHidden = true
            }
            
            hangingCell.delegateElectricalWireHanging = self
            hangingCell.txtWireHiring.delegate = self
            
            return hangingCell
        } else if indexPath.row == 20 {
            let boxesMountedCell = tableView.dequeueReusableCell(withIdentifier: "InspectionElectricalBoxesMountedCell", for: indexPath) as! InspectionElectricalBoxesMountedTableCell
            
            boxesMountedCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

            boxesMountedCell.collectionvw.arrItems = arrBoxesMountedImg
            boxesMountedCell.collectionvw.delegateItemCollection = self
            boxesMountedCell.collectionvw.reloadImageCollection()
            
            if arrBoxesMountedImg.count > 0 {
                boxesMountedCell.btnUpload.isHidden = true
                boxesMountedCell.collectionvw.isHidden = false
            } else {
                boxesMountedCell.btnUpload.isHidden = false
                boxesMountedCell.collectionvw.isHidden = true
            }
            
            boxesMountedCell.delegateElectricalBoxesMounted = self
            boxesMountedCell.txtBoxMounted.delegate = self
            
            return boxesMountedCell
        }  else {
            let cellBtn = tableView.dequeueReusableCell(withIdentifier: "NextCell", for: indexPath) as! NextForm1TableCell
            
            cellBtn.btnNext.addTarget(self, action: #selector(btnNextDidTap), for: UIControl.Event.touchUpInside)
            return cellBtn
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .phone {
            if indexPath.row == 0 {
                return 185
            } else if indexPath.row == 7 {
                return 377
            } else if indexPath.row == 12 {
                return 145
            } else if indexPath.row == 21 {
                return 105
            } else {
                return 340
            }
        } else {        //.pad
            if indexPath.row == 0 {
                return 320
            } else  if indexPath.row == 5 {
                return 640
            } else if indexPath.row == 7 {
                return 640
            } else if indexPath.row == 12 {
                return 200
            } else if indexPath.row == 21 {
                return 175
            } else {
                return 600
            }
        }
    }
}


extension InspectLightVC: LightWorkingProtocol, LightLowVoltageProtocol, LightFiberOpticProtocol, LightFiberOpticWorkingProtocol, MultiLightSynchProtocol, SpaLightWorkingProtocol, BasinLightProtocol, LightFreeWaterProtocol, LightMountedProtocol, ProperGFIProtocol, GFITrippedProtocol, ElectricalSafetyProtocol, ElectricalExposedProtocol, DisconnectedAccessoriesProtocol, ElectricalEquipmentProtocol, ElectricalProperGFIProtocol, ElectricalGFITrippedProtocol, ElectricalWireHangingProtocol, ElectricalBoxesMountedProtocol {
    func didTapOnCellLightWorking(_btnLightTag: Int) {
        if _btnLightTag == 0 {
            strOptLightWorking = "Yes"
        } else if _btnLightTag == 1 {
            strOptLightWorking = "No"
        }
        self.tblLight.reloadData()
    }
    
    func didTapOnCellLightLowVoltage(_btnLightTag: Int) {
        if _btnLightTag == 0 {
            strOptLowVoltage = "Yes"
        } else if _btnLightTag == 1 {
            strOptLowVoltage = "No"
        }
        self.tblLight.reloadData()
    }
    
    func didTapOnCellLightFiberOptic(_btnLightTag: Int) {
        if _btnLightTag == 0 {
            strOptFiberOptic = "Yes"
        } else if _btnLightTag == 1 {
            strOptFiberOptic = "No"
        }
        self.tblLight.reloadData()
    }
    
    func didTapOnCellLightFiberOpticWorking(_btnLightTag: Int) {
        if _btnLightTag == 0 {
            strOptFiberWorking = "Yes"
        } else if _btnLightTag == 1 {
            strOptFiberWorking = "No"
        }
        self.tblLight.reloadData()
    }
    
    func didTapOnCellMultiLightSynch(_btnLightTag: Int) {
        if _btnLightTag == 0 {
            strOptMultiLightSynch = "Yes"
        } else if _btnLightTag == 1 {
            strOptMultiLightSynch = "No"
        }
        self.tblLight.reloadData()
    }
    
    func didTapOnCellSpaLightWorking(_btnLightTag: Int) {
        if _btnLightTag == 0 {
            strOptSpaLight = "Yes"
        } else if _btnLightTag == 1 {
            strOptSpaLight = "No"
        }
        self.tblLight.reloadData()
    }
    
    func didTapOnCellBasinLight(_btnLightTag: Int) {
        if _btnLightTag == 0 {
            strOptBasinLight = "Yes"
        } else if _btnLightTag == 1 {
            strOptBasinLight = "No"
        }
        self.tblLight.reloadData()
    }
    
    func didTapOnCellLightFreeWater(_btnLightTag: Int) {
        if _btnLightTag == 0 {
            strOptFreeWater = "Yes"
        } else if _btnLightTag == 1 {
            strOptFreeWater = "No"
        }
        self.tblLight.reloadData()
    }
    
    func didTapOnCellLightMounted(_btnLightTag: Int) {
        if _btnLightTag == 0 {
            strOptLightMounted = "Yes"
        } else if _btnLightTag == 1 {
            strOptLightMounted = "No"
        }
        self.tblLight.reloadData()
    }
    
    func didTapOnCellProperGFI(_btnLightTag: Int) {
        if _btnLightTag == 0 {
            strOptProperGFI = "Yes"
        } else if _btnLightTag == 1 {
            strOptProperGFI = "No"
        }
        self.tblLight.reloadData()
    }
    
    func didTapOnCellGFITripped(_btnLightTag: Int) {
        if _btnLightTag == 0 {
            strOptGFITripped = "Yes"
        } else if _btnLightTag == 1 {
            strOptGFITripped = "No"
        }
        self.tblLight.reloadData()
    }
    
    func didTapOnCellElectricalSafety(_btnLightTag: Int) {
        if _btnLightTag == 0 {
            strOptSafetyAround = "Yes"
        } else if _btnLightTag == 1 {
            strOptSafetyAround = "No"
        }
        self.tblLight.reloadData()
    }
    
    func didTapOnCellElectricalExposed(_btnLightTag: Int) {
        if _btnLightTag == 0 {
            strOptExposedWiring = "Yes"
        } else if _btnLightTag == 1 {
            strOptExposedWiring = "No"
        }
        self.tblLight.reloadData()
    }
    
    func didTapOnCellDisconnectedAccessories(_btnLightTag: Int) {
        if _btnLightTag == 0 {
            strOptAccessories = "Yes"
        } else if _btnLightTag == 1 {
            strOptAccessories = "No"
        }
        self.tblLight.reloadData()
    }
    
    func didTapOnCellElectricalEquipment(_btnLightTag: Int) {
        if _btnLightTag == 0 {
            strOptEquipmentBond = "Yes"
        } else if _btnLightTag == 1 {
            strOptEquipmentBond = "No"
        }
        self.tblLight.reloadData()
    }
    
    func didTapOnCellElectricalProperGFI(_btnLightTag: Int) {
        if _btnLightTag == 0 {
            strOptElectProperGFI = "Yes"
        } else if _btnLightTag == 1 {
            strOptElectProperGFI = "No"
        }
        self.tblLight.reloadData()
    }
    
    func didTapOnCellElectricalGFITripped(_btnLightTag: Int) {
        if _btnLightTag == 0 {
            strOptElectricalGFIT = "Yes"
        } else if _btnLightTag == 1 {
            strOptElectricalGFIT = "No"
        }
        self.tblLight.reloadData()
    }
    
    func didTapOnCellElectricalWireHanging(_btnLightTag: Int) {
        if _btnLightTag == 0 {
            strOptWireHanging = "Yes"
        } else if _btnLightTag == 1 {
            strOptWireHanging = "No"
        }
        self.tblLight.reloadData()
    }
    
    func didTapOnCellElectricalBoxesMounted(_btnLightTag: Int) {
        if _btnLightTag == 0 {
            strOptBoxesMounted = "Yes"
        } else if _btnLightTag == 1 {
            strOptBoxesMounted = "No"
        }
        self.tblLight.reloadData()
    }
    
    
}
