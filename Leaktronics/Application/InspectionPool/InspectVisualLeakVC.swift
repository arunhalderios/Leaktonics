//
//  InspectVisualLeakVC.swift
//  Leaktronics
//
//  Created by ivaninfotech on 5/26/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import CoreData
import DLRadioButton
import SVProgressHUD
import Alamofire
import Photos
import OpalImagePicker


class InspectVisualLeakVC: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var tblVisualLeak: UITableView!
    //MARK:- Variable Declaration
    var secInspectVisualLeak = [formInspectionPoolData]()
    var height = CGFloat()
    
    private var sectionIndex = -1
    private var selectedRowIndex = -1
    
    enum VisualLeakInspect: Int {
        case equipmentArea = 0
        case structuralCracks = 8
        case bondBeam = 9
        case surgeTankPool = 11
        case scumGuttersPool = 12
        case returns = 14
        case skimmer = 15
        case skimmerSeam = 16
        case mainDrain = 17
        case niches = 18
        case sideSuction = 19
        case cleanerLines = 20
        case skimmerPorts = 21
        case equalizer = 22
        case structuralCracksValue = 23
        case explain = 24
        case spaJets = 25
        case spaFill = 26
        case suction = 27
        case surgeTankValue = 29
        case scumGuttersValue = 30
        case autoFill = 32
        case arroundFittings = 33
        case notedCracks = 34
        case other = 35
    }
    
    
    //For Images
    var arrEquipmentAreaImg: [CollectionImageObject] = []
    var arrBackWashImg: [CollectionImageObject] = []
    var arrWaterFeatureImg: [CollectionImageObject] = []
    var arrSolarSystemImg: [CollectionImageObject] = []
    var arrCatchBasinImg: [CollectionImageObject] = []
    var arrSlotDrainImg: [CollectionImageObject] = []
    var arrVinylImg: [CollectionImageObject] = []
    var arrNoticeableImg: [CollectionImageObject] = []
    var arrStructuralCracksImg: [CollectionImageObject] = []
    var arrBondBeamImg: [CollectionImageObject] = []
    var arrSurgeTankPoolImg: [CollectionImageObject] = []
    var arrScumGuttersImg: [CollectionImageObject] = []
    
    
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
    var strVinylImg = String()
    var strNoticeableImg = String()
    var strStructuralCracksImg = String()
    var strBondBeamImg = String()
    var strSurgeTankPoolImg = String()
    var strScumGuttersImg = String()
    
    
    //For Image CoreData
    var dataEqueImg = NSData()
    var dataBackWashImg = NSData()
    var dataWaterFeatureImg = NSData()
    var dataSolarImg = NSData()
    var dataBasinImg = NSData()
    var dataDrainImg = NSData()
    var dataVinylImg = NSData()
    var dataNoticeableImg = NSData()
    var dataStructuralCracksImg = NSData()
    var dataBondBeamImg = NSData()
    var dataSurgeTankPoolImg = NSData()
    var dataScumGuttersImg = NSData()
    
    
    //For Optional Values
    var strEquaiAreaOption = String()
    var strBackwashOption = String()
    var strWaterFeatureOption = String()
    var strSolarOption = String()
    var strBasinOption = String()
    var strDrainOption = String()
    var strVinylOption = String()
    var strNoticeableOption = String()
    var strStructuralCracksOption = String()
    var strBondBeamOption = String()
    var strSurgeTankPoolOption = String()
    var strScumGuttersOption = String()
    var strCommercialBondBeamOpt = String()
    var strCommercialInnerBondBeamOpt = String()
    
    
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.prepareFormVisualData()
    }
    
    func prepareFormVisualData() {
        for _ in 0..<36 {
            let obj = formInspectionPoolData()
            self.secInspectVisualLeak.append(obj)
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
            if let popoverController = alert.popoverPresentationController {
                popoverController.sourceView = self.view
                popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                popoverController.permittedArrowDirections = UIPopoverArrowDirection.up
            }
            self.present(alert, animated: true, completion: nil)
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
        self.updateCoreData()
        self.view.endEditing(true)
        //self.postInspectVisualLeak()
        if UIDevice.current.userInterfaceIdiom == .phone {
            let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
            let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectPlumbingStatistic") as! InspectPlumbingStatisticVC
            self.navigationController?.pushViewController(formVC, animated: true)
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
            let formVC = storyBoard.instantiateViewController(withIdentifier: "PlumbingStatistic") as! PlumbingStatisticVC
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
                    
                    
                    managedObject.setValue(dataEqueImg, forKey: "visualEquipmentImage")
                    managedObject.setValue(strEquaiAreaOption, forKey: "visualEquipmentOption")
                    managedObject.setValue(self.secInspectVisualLeak[VisualLeakInspect.equipmentArea.rawValue].formTextValue, forKey: "visualEquipmentData")
                    managedObject.setValue(dataBackWashImg, forKey: "visualBackwashImage")
                    managedObject.setValue(strBackwashOption, forKey: "visualBackwashOption")
                    managedObject.setValue(dataWaterFeatureImg, forKey: "visualArroundWaterFeatureImage")
                    managedObject.setValue(strWaterFeatureOption, forKey: "visualArroundWaterFeatureOption")
                    managedObject.setValue(dataSolarImg, forKey: "visualSolarImage")
                    managedObject.setValue(strSolarOption, forKey: "visualSolarOption")
                    managedObject.setValue(dataBasinImg, forKey: "visualBasinImage")
                    managedObject.setValue(strBasinOption, forKey: "visualBasinOption")
                    managedObject.setValue(dataDrainImg, forKey: "visualSlotDrainImage")
                    managedObject.setValue(strDrainOption, forKey: "visualSlotDrainOption")
                    managedObject.setValue(dataVinylImg, forKey: "visualVinylImage")
                    managedObject.setValue(strVinylOption, forKey: "visualVinylOption")
                    managedObject.setValue(dataNoticeableImg, forKey: "visualNoticeableImage")
                    managedObject.setValue(strNoticeableOption, forKey: "visualNoticeableOption")
                    managedObject.setValue(dataStructuralCracksImg, forKey: "visualStructuralCracksImage")
                    managedObject.setValue(strStructuralCracksOption, forKey: "visualStructuralCracksOption")
                    managedObject.setValue(self.secInspectVisualLeak[VisualLeakInspect.structuralCracks.rawValue].formTextValue, forKey: "visualStructuralCracksData")
                    managedObject.setValue(dataBondBeamImg, forKey: "visualBondBeamImage")
                    managedObject.setValue(strBondBeamOption, forKey: "visualBondBeamOption")
                    managedObject.setValue(self.secInspectVisualLeak[VisualLeakInspect.bondBeam.rawValue].formTextValue, forKey: "visualBondBeamData")
                    managedObject.setValue(dataSurgeTankPoolImg, forKey: "visualSurgeTankImage")
                    managedObject.setValue(strSurgeTankPoolOption, forKey: "visualSurgeTankOption")
                    managedObject.setValue(self.secInspectVisualLeak[VisualLeakInspect.surgeTankPool.rawValue].formTextValue, forKey: "visualSurgeTankData")
                    managedObject.setValue(dataScumGuttersImg, forKey: "visualScumGuttersImage")
                    managedObject.setValue(strScumGuttersOption, forKey: "visualScumGuttersOption")
                    managedObject.setValue(self.secInspectVisualLeak[VisualLeakInspect.scumGuttersPool.rawValue].formTextValue, forKey: "visualScumGuttersData")
                    managedObject.setValue(self.secInspectVisualLeak[VisualLeakInspect.returns.rawValue].formTextValue, forKey: "visualReturnsData")
                    managedObject.setValue(self.secInspectVisualLeak[VisualLeakInspect.skimmer.rawValue].formTextValue, forKey: "visualSkimmersData")
                    managedObject.setValue(self.secInspectVisualLeak[VisualLeakInspect.skimmerSeam.rawValue].formTextValue, forKey: "visualSkimmerSeamData")
                    managedObject.setValue(self.secInspectVisualLeak[VisualLeakInspect.mainDrain.rawValue].formTextValue, forKey: "visualMainDrainData")
                    managedObject.setValue(self.secInspectVisualLeak[VisualLeakInspect.niches.rawValue].formTextValue, forKey: "visualNichesData")
                    managedObject.setValue(self.secInspectVisualLeak[VisualLeakInspect.sideSuction.rawValue].formTextValue, forKey: "visualSideSuctionData")
                    managedObject.setValue(self.secInspectVisualLeak[VisualLeakInspect.cleanerLines.rawValue].formTextValue, forKey: "visualCleanerLinesData")
                    managedObject.setValue(self.secInspectVisualLeak[VisualLeakInspect.skimmerPorts.rawValue].formTextValue, forKey: "visualSkimmerPortsData")
                    managedObject.setValue(self.secInspectVisualLeak[VisualLeakInspect.equalizer.rawValue].formTextValue, forKey: "visualEqualizerData")
                    managedObject.setValue(self.secInspectVisualLeak[VisualLeakInspect.structuralCracksValue.rawValue].formTextValue, forKey: "visualStructuralCracksValueData")
                    managedObject.setValue(self.secInspectVisualLeak[VisualLeakInspect.explain.rawValue].formTextValue, forKey: "visualExplainData")
                    managedObject.setValue(self.secInspectVisualLeak[VisualLeakInspect.spaJets.rawValue].formTextValue, forKey: "visualSpaJetsData")
                    managedObject.setValue(self.secInspectVisualLeak[VisualLeakInspect.spaFill.rawValue].formTextValue, forKey: "visualSpaFillData")
                    managedObject.setValue(self.secInspectVisualLeak[VisualLeakInspect.suction.rawValue].formTextValue, forKey: "visualSuctionData")
                    managedObject.setValue(self.secInspectVisualLeak[VisualLeakInspect.surgeTankValue.rawValue].formTextValue, forKey: "visualSurgeTankValueData")
                    managedObject.setValue(self.secInspectVisualLeak[VisualLeakInspect.scumGuttersValue.rawValue].formTextValue, forKey: "visualScumGuttersValueData")
                    managedObject.setValue(self.secInspectVisualLeak[VisualLeakInspect.autoFill.rawValue].formTextValue, forKey: "visualAutoFillData")
                    managedObject.setValue(self.secInspectVisualLeak[VisualLeakInspect.arroundFittings.rawValue].formTextValue, forKey: "visualArroundFittingsData")
                    managedObject.setValue(self.secInspectVisualLeak[VisualLeakInspect.notedCracks.rawValue].formTextValue, forKey: "visualNotedCracksData")
                    managedObject.setValue(self.secInspectVisualLeak[VisualLeakInspect.other.rawValue].formTextValue, forKey: "visualOtherData")

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
                    //print("Data of PoolDetectContact:: \(data)")
                    if (data.value(forKey: "nameInspect") as! String) == userName {
//                        print("equipAreaOption::",data.value(forKey: "equipAreaOption") as Any)
//                        print("backWashOption::",data.value(forKey: "backWashOption") as Any)
//                        print("waterFeatureOption::",data.value(forKey: "waterFeatureOption") as Any)
//                        print("solarSystemOption::",data.value(forKey: "solarSystemOption") as Any)
//                        print("catchBasinOption::",data.value(forKey: "catchBasinOption") as Any)
//                        print("slotDrainOption::",data.value(forKey: "slotDrainOption") as Any)
                    }
                }
            } catch {
                print("Failed")
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    /*//MARK:: Function Api Calling
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
                    } else if self.fetchIndexForUpload == 6 {
                        self.strVinylImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 7 {
                        self.strNoticeableImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 8 {
                        self.strStructuralCracksImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 9 {
                        self.strBondBeamImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 11 {
                        self.strSurgeTankPoolImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 12 {
                        self.strScumGuttersImg = String(describing: data!)
                    }
                     SVProgressHUD.dismiss()
                }
            case .failure(let encodingError):
                    print("error:\(encodingError)")
                    SVProgressHUD.dismiss()
                }
            })
    }
    
    func postInspectVisualLeak() {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        
        let return_id = UserDefaults.standard.value(forKey: "returnKeyForInspection")
        
        let inspectVisualDetails: NSMutableDictionary = [
            "return_data_id"            : return_id!,
            "equipmentImage"            : strEqueImg,
            "equipmentOption"           : strEquaiAreaOption,
            "equipmentData"             : self.secInspectVisualLeak[VisualLeakInspect.equipmentArea.rawValue].formTextValue,
            "backwashImage"             : strBackWashImg,
            "backwashOption"            : strBackwashOption,
            "arroundWaterFeatureImage"  : strWaterFeatureImg,
            "arroundWaterFeatureOption" : strWaterFeatureOption,
            "solarImage"                : strSolarImg,
            "solarOption"               : strSolarOption,
            "basinImage"                : strBasinImg,
            "basinOption"               : strBasinOption,
            "slotDrainImage"            : strDrainImg,
            "slotDrainOption"           : strDrainOption,
            "vinylImage"                : strVinylImg,
            "vinylOption"               : strVinylOption,
            "noticeableImage"           : strNoticeableImg,
            "noticeableOption"          : strNoticeableOption,
            "structuralCracksImage"     : strStructuralCracksImg,
            "structuralCracksOption"    : strStructuralCracksOption,
            "structuralCracksData"      : self.secInspectVisualLeak[VisualLeakInspect.structuralCracks.rawValue].formTextValue,
            "bondBeamImage"             : strBondBeamImg,
            "bondBeamOption"            : strBondBeamOption,
            "bondBeamData"              : self.secInspectVisualLeak[VisualLeakInspect.bondBeam.rawValue].formTextValue,
            "surgeTankImage"            : strSurgeTankPoolImg,
            "surgeTankOption"           : strSurgeTankPoolOption,
            "surgeTankData"             : self.secInspectVisualLeak[VisualLeakInspect.surgeTankPool.rawValue].formTextValue,
            "scumGuttersImage"          : strScumGuttersImg,
            "scumGuttersOption"         : strScumGuttersOption,
            "scumGuttersData"           : self.secInspectVisualLeak[VisualLeakInspect.scumGuttersPool.rawValue].formTextValue,
            "returnsData"               : self.secInspectVisualLeak[VisualLeakInspect.returns.rawValue].formTextValue,
            "skimmersData"              : self.secInspectVisualLeak[VisualLeakInspect.skimmer.rawValue].formTextValue,
            "skimmerSeamData"           : self.secInspectVisualLeak[VisualLeakInspect.skimmerSeam.rawValue].formTextValue,
            "mainDrainData"             : self.secInspectVisualLeak[VisualLeakInspect.mainDrain.rawValue].formTextValue,
            "nichesData"                : self.secInspectVisualLeak[VisualLeakInspect.niches.rawValue].formTextValue,
            "sideSuctionData"           : self.secInspectVisualLeak[VisualLeakInspect.sideSuction.rawValue].formTextValue,
            "cleanerLinesData"          : self.secInspectVisualLeak[VisualLeakInspect.cleanerLines.rawValue].formTextValue,
            "skimmerPortsData"          : self.secInspectVisualLeak[VisualLeakInspect.skimmerPorts.rawValue].formTextValue,
            "equalizerData"             : self.secInspectVisualLeak[VisualLeakInspect.equalizer.rawValue].formTextValue,
            "structuralCracksValueData" : self.secInspectVisualLeak[VisualLeakInspect.structuralCracksValue.rawValue].formTextValue,
            "explainData"               : self.secInspectVisualLeak[VisualLeakInspect.explain.rawValue].formTextValue,
            "spaJetsData"               : self.secInspectVisualLeak[VisualLeakInspect.spaJets.rawValue].formTextValue,
            "spaFillData"               : self.secInspectVisualLeak[VisualLeakInspect.spaFill.rawValue].formTextValue,
            "suctionData"               : self.secInspectVisualLeak[VisualLeakInspect.suction.rawValue].formTextValue,
            "surgeTankValueData"        : self.secInspectVisualLeak[VisualLeakInspect.surgeTankValue.rawValue].formTextValue,
            "scumGuttersValueData"      : self.secInspectVisualLeak[VisualLeakInspect.scumGuttersValue.rawValue].formTextValue,
            "autoFillData"              : self.secInspectVisualLeak[VisualLeakInspect.autoFill.rawValue].formTextValue,
            "arroundFittingsData"       : self.secInspectVisualLeak[VisualLeakInspect.arroundFittings.rawValue].formTextValue,
            "notedCracksData"           : self.secInspectVisualLeak[VisualLeakInspect.notedCracks.rawValue].formTextValue,
            "otherData"                 : self.secInspectVisualLeak[VisualLeakInspect.other.rawValue].formTextValue,
        ]

        print("inspectVisualDetails :: \(inspectVisualDetails)")
        //if sharedExtension.connectedToNetwork() {
        ApiManager.sharedInstanceAPI.PostInspectVisualLeak(postId: 1, visualDetails: inspectVisualDetails, onSuccess: { json in
            DispatchQueue.main.async {
                print("InspectionVisualLeakDetails json :: \(String(describing: json))")
                DispatchQueue.main.async(execute: {() -> Void in
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectPlumbingStatistic") as! InspectPlumbingStatisticVC
                        self.navigationController?.pushViewController(formVC, animated: true)
                    } else if UIDevice.current.userInterfaceIdiom == .pad {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "PlumbingStatistic") as! PlumbingStatisticVC
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


extension InspectVisualLeakVC: OpalImagePickerControllerDelegate {
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
                            } else if self.fetchIndexForUpload == 6 {
                                self.arrVinylImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.setPostImage(arrOfImages: images)
                                self.dataVinylImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForUpload == 7 {
                                self.arrNoticeableImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.setPostImage(arrOfImages: images)
                                self.dataNoticeableImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForUpload == 8 {
                                self.arrStructuralCracksImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.setPostImage(arrOfImages: images)
                                self.dataStructuralCracksImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForUpload == 9 {
                                self.arrBondBeamImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.setPostImage(arrOfImages: images)
                                self.dataBondBeamImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForUpload == 11 {
                                self.arrSurgeTankPoolImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.setPostImage(arrOfImages: images)
                                self.dataSurgeTankPoolImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForUpload == 12 {
                                self.arrScumGuttersImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.setPostImage(arrOfImages: images)
                                self.dataScumGuttersImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
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


extension InspectVisualLeakVC: UIImagePickerControllerDelegate {
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
        } else if fetchIndexForUpload == 6 {
            self.arrVinylImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataVinylImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        }else if fetchIndexForUpload == 7 {
            self.arrNoticeableImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataNoticeableImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if fetchIndexForUpload == 8 {
            self.arrStructuralCracksImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataStructuralCracksImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if fetchIndexForUpload == 9 {
            self.arrBondBeamImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataBondBeamImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if fetchIndexForUpload == 11 {
            self.arrSurgeTankPoolImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataSurgeTankPoolImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if fetchIndexForUpload == 12 {
            self.arrScumGuttersImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataScumGuttersImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
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


extension InspectVisualLeakVC: UITableViewDataSource, UITableViewDelegate {
    //MARK:- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 37
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cellArea = tableView.dequeueReusableCell(withIdentifier: "EquipmentAreaCell", for: indexPath) as! EquipmentAreaCell
            
            cellArea.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            
//            cellArea.collectionVw.arrItems = arrEquipmentAreaImg
//            cellArea.collectionVw.delegateItemCollection = self
//            cellArea.collectionVw.reloadImageCollection()
            
            if arrEquipmentAreaImg.count > 0 {
                cellArea.btnUpload.isHidden = true
                cellArea.collectionVw.isHidden = false
            } else {
                cellArea.btnUpload.isHidden = false
                cellArea.collectionVw.isHidden = true
            }
            
            cellArea.vwWhereDescription.text = self.secInspectVisualLeak[indexPath.row].formTextValue
            cellArea.vwWhereDescription.delegate = self
            cellArea.delegateEquiArea = self
            
            return cellArea
        } else if indexPath.row == 1 {
            let cellImg = tableView.dequeueReusableCell(withIdentifier: "BackWashImgCell", for: indexPath) as! BackWashImgTableCell
            
            cellImg.lblOptionalImg.text = "Back wash"
            cellImg.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            
            cellImg.collectionVw.arrItems = arrBackWashImg
            cellImg.collectionVw.delegateItemCollection = self
            cellImg.collectionVw.reloadImageCollection()
            
            if arrBackWashImg.count > 0 {
                cellImg.btnUpload.isHidden = true
                cellImg.collectionVw.isHidden = false
            } else {
                cellImg.btnUpload.isHidden = false
                cellImg.collectionVw.isHidden = true
            }
            
            cellImg.delegateBackWash = self
            
            return cellImg
        } else if indexPath.row == 2 {
            let cellImg = tableView.dequeueReusableCell(withIdentifier: "AroundWaterImgCell", for: indexPath) as! AroundWaterImgTableCell
            
            cellImg.lblOptionalImg.text = "Around water feature"
            
            cellImg.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            
            cellImg.collectionVw.arrItems = arrWaterFeatureImg
            cellImg.collectionVw.delegateItemCollection = self
            cellImg.collectionVw.reloadImageCollection()
            if arrWaterFeatureImg.count > 0 {
                cellImg.btnUpload.isHidden = true
                cellImg.collectionVw.isHidden = false
            } else {
                cellImg.btnUpload.isHidden = false
                cellImg.collectionVw.isHidden = true
            }
            
            cellImg.delegateAroundWater = self
            
            return cellImg
        } else if indexPath.row == 3 {
            let cellImg = tableView.dequeueReusableCell(withIdentifier: "SolarSystemImgCell", for: indexPath) as! SolarSystemImgTableCell
            
            cellImg.lblOptionalImg.text = "Solar System"
            
            cellImg.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
            cellImg.collectionVw.arrItems = arrSolarSystemImg
            cellImg.collectionVw.delegateItemCollection = self
            cellImg.collectionVw.reloadImageCollection()
            
            if arrSolarSystemImg.count > 0 {
                cellImg.btnUpload.isHidden = true
                cellImg.collectionVw.isHidden = false
            } else {
                cellImg.btnUpload.isHidden = false
                cellImg.collectionVw.isHidden = true
            }
            
            cellImg.delegateSolarSystem = self
            
            return cellImg
        } else if indexPath.row == 4 {
            let cellImg = tableView.dequeueReusableCell(withIdentifier: "CatchBasinImgCell", for: indexPath) as! CatchBasinImgTableCell
            
            cellImg.lblOptionalImg.text = "Catch Basin (if applicable)"
            
            cellImg.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            
            cellImg.collectionVw.arrItems = arrCatchBasinImg
            cellImg.collectionVw.delegateItemCollection = self
            cellImg.collectionVw.reloadImageCollection()
            
            if arrCatchBasinImg.count > 0 {
                cellImg.btnUpload.isHidden = true
                cellImg.collectionVw.isHidden = false
            } else {
                cellImg.btnUpload.isHidden = false
                cellImg.collectionVw.isHidden = true
            }
            
            cellImg.delegateCatchBasin = self
            
            return cellImg
        } else if indexPath.row == 5 {
            let cellImg = tableView.dequeueReusableCell(withIdentifier: "SlotDrainsImgCell", for: indexPath) as! SlotDrainsImgTableCell
            
            cellImg.lblOptionalImg.text = "Slot Drains (if applicable)"
            
            cellImg.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
            cellImg.collectionVw.arrItems = arrSlotDrainImg
            cellImg.collectionVw.delegateItemCollection = self
            cellImg.collectionVw.reloadImageCollection()
            
            if arrSlotDrainImg.count > 0 {
                cellImg.btnUpload.isHidden = true
                cellImg.collectionVw.isHidden = false
            } else {
                cellImg.btnUpload.isHidden = false
                cellImg.collectionVw.isHidden = true
            }
            
            cellImg.delegateSlotDrains = self
            
            return cellImg
        } else if indexPath.row == 6 {
            let cellImg = tableView.dequeueReusableCell(withIdentifier: "VinylImgCell", for: indexPath) as! VinylImgTableCell
            
            cellImg.lblOptionalImg.text = "If Vinyl, is Vinyl stretched"
            
            cellImg.lblOptional1.text = "Yes"
            cellImg.lblOptional2.text = "No"
            
            cellImg.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            
            cellImg.collectionVw.arrItems = arrVinylImg
            cellImg.collectionVw.delegateItemCollection = self
            cellImg.collectionVw.reloadImageCollection()
            
            if arrVinylImg.count > 0 {
                cellImg.btnUpload.isHidden = true
                cellImg.collectionVw.isHidden = false
            } else {
                cellImg.btnUpload.isHidden = false
                cellImg.collectionVw.isHidden = true
            }
            
            cellImg.delegateVinyl = self
            
            return cellImg
        } else if indexPath.row == 7 {
            let cellImg = tableView.dequeueReusableCell(withIdentifier: "NoticeableImgCell", for: indexPath) as! NoticeableImgTableCell
            
            cellImg.lblOptionalImg.text = "Any Noticeable Tears in Vinyl"
            
            cellImg.lblOptional1.text = "Yes"
            cellImg.lblOptional2.text = "No"
            
            cellImg.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
            cellImg.collectionVw.arrItems = arrNoticeableImg
            cellImg.collectionVw.delegateItemCollection = self
            cellImg.collectionVw.reloadImageCollection()
            
            if arrNoticeableImg.count > 0 {
                cellImg.btnUpload.isHidden = true
                cellImg.collectionVw.isHidden = false
            } else {
                cellImg.btnUpload.isHidden = false
                cellImg.collectionVw.isHidden = true
            }
            
            cellImg.delegateNoticeable = self
            
            return cellImg
        } else if indexPath.row == 8 {
            let visualCell = tableView.dequeueReusableCell(withIdentifier: "StructuralCracksCell", for: indexPath) as! StructuralCracksTableCell
            
            visualCell.lblHeader.text = "Structural cracks in pool"
            visualCell.lblNote.text = "Approximate amount of linear feet"
            visualCell.lblOptional1.text = "Yes"
            visualCell.lblOptional2.text = "No visible structural cracks in pool"
            
            visualCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            
            visualCell.collectionVw.arrItems = arrStructuralCracksImg
            visualCell.collectionVw.delegateItemCollection = self
            visualCell.collectionVw.reloadImageCollection()
            
            if arrStructuralCracksImg.count > 0 {
                visualCell.btnUpload.isHidden = true
                visualCell.collectionVw.isHidden = false
            } else {
                visualCell.btnUpload.isHidden = false
                visualCell.collectionVw.isHidden = true
            }
            
            visualCell.vwWhereDescription.text = self.secInspectVisualLeak[indexPath.row].formTextValue
            visualCell.delegateStructuralCracks = self
            visualCell.vwWhereDescription.delegate = self
            
            return visualCell
        } else if indexPath.row == 9 {
            let visualCell = tableView.dequeueReusableCell(withIdentifier: "BondBeamCell", for: indexPath) as! BondBeamTableCell
            
            visualCell.lblHeader.text = "Bond beam"
            visualCell.lblNote.text = "Was cracked at area(s)"
            visualCell.lblOptional1.text = "Yes"
            visualCell.lblOptional2.text = "Was solid and not cracked"
            
            visualCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            visualCell.collectionVw.arrItems = arrBondBeamImg
            visualCell.collectionVw.delegateItemCollection = self
            visualCell.collectionVw.reloadImageCollection()
            
            if arrBondBeamImg.count > 0 {
                visualCell.btnUpload.isHidden = true
                visualCell.collectionVw.isHidden = false
            } else {
                visualCell.btnUpload.isHidden = false
                visualCell.collectionVw.isHidden = true
            }
            
            visualCell.vwWhereDescription.text = self.secInspectVisualLeak[indexPath.row].formTextValue
            visualCell.delegateBondBeam = self
            visualCell.vwWhereDescription.delegate = self
            
            return visualCell
        } else if indexPath.row == 10 {
            let headerView : UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "CustomHeaderCell")!
            
            let lblHeaderTitle = headerView.viewWithTag(10) as! UILabel
            lblHeaderTitle.textColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.2352941176, alpha: 1)
            lblHeaderTitle.numberOfLines = 2
            if UIDevice.current.userInterfaceIdiom == .phone {
                lblHeaderTitle.font = UIFont.init(name: "Roboto-bold", size: 13.0)
            } else {
                lblHeaderTitle.font = UIFont.init(name: "Roboto-bold", size: 24.0)
            }
            // set this however is appropriate for your app's model
            lblHeaderTitle.text = "For Commercial Pools:"

            return headerView
        } else if indexPath.row == 11 {
            let visualCell = tableView.dequeueReusableCell(withIdentifier: "SurgeTankPoolCell", for: indexPath) as! SurgeTankPoolTableCell
            
            visualCell.lblHeader.text = "Does the pool have a surge tank"
            
            visualCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            
            visualCell.collectionVw.arrItems = arrSurgeTankPoolImg
            visualCell.collectionVw.delegateItemCollection = self
            visualCell.collectionVw.reloadImageCollection()
            
            if arrSurgeTankPoolImg.count > 0 {
                visualCell.btnUpload.isHidden = true
                visualCell.collectionVw.isHidden = false
            } else {
                visualCell.btnUpload.isHidden = false
                visualCell.collectionVw.isHidden = true
            }
            
            visualCell.txtOther.text = self.secInspectVisualLeak[indexPath.row].formTextValue
            visualCell.txtOther.delegate = self
            visualCell.delegateSurgeTankPool = self
            
            return visualCell
        } else if indexPath.row == 12 {
            let visualCell = tableView.dequeueReusableCell(withIdentifier: "ScumGuttersCell", for: indexPath) as! ScumGuttersTableCell
            
            visualCell.lblHeader.text = "Does the pool have scum gutters"
            
            visualCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            
            visualCell.collectionVw.arrItems = arrScumGuttersImg
            visualCell.collectionVw.delegateItemCollection = self
            visualCell.collectionVw.reloadImageCollection()
            
            if arrScumGuttersImg.count > 0 {
                visualCell.btnUpload.isHidden = true
                visualCell.collectionVw.isHidden = false
            } else {
                visualCell.btnUpload.isHidden = false
                visualCell.collectionVw.isHidden = true
            }
            
            visualCell.txtOther.text = self.secInspectVisualLeak[indexPath.row].formTextValue
            visualCell.txtOther.delegate = self
            visualCell.delegateScumGutters = self
            
            return visualCell
        } else if indexPath.row == 13 {
            let headerView : UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "CustomHeaderCell")!
            
            let lblHeaderTitle = headerView.viewWithTag(10) as! UILabel
            lblHeaderTitle.textColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.2352941176, alpha: 1)
            lblHeaderTitle.numberOfLines = 2
            if UIDevice.current.userInterfaceIdiom == .phone {
                lblHeaderTitle.font = UIFont.init(name: "Roboto-bold", size: 13.0)
            } else {
                lblHeaderTitle.font = UIFont.init(name: "Roboto-bold", size: 24.0)
            }
            // set this however is appropriate for your app's model
            lblHeaderTitle.text = "Hydrophoned and/or dye tested around:"
            
            return headerView
        } else if indexPath.row == 14 {
            let cellData = tableView.dequeueReusableCell(withIdentifier: "ReturnsCell", for: indexPath) as! ReturnsValueTableCell
            
            cellData.lblTag.text = "Returns"
            
            cellData.txtData.text = self.secInspectVisualLeak[indexPath.row].formTextValue
            cellData.txtData.delegate = self
            
            return cellData
        } else if indexPath.row == 15 {
            let cellData = tableView.dequeueReusableCell(withIdentifier: "SkimmerValueCell", for: indexPath) as! SkimmerValueTableCell
            
            cellData.lblTag.text = "Skimmer"
            
            cellData.txtData.text = self.secInspectVisualLeak[indexPath.row].formTextValue
            cellData.txtData.delegate = self
            
            return cellData
        } else if indexPath.row == 16 {
            let cellData = tableView.dequeueReusableCell(withIdentifier: "SkimmerSeamValueCell", for: indexPath) as! SkimmerSeamValueTableCell
            
            cellData.lblTag.text = "Skimmer seam"
            
            cellData.txtData.text = self.secInspectVisualLeak[indexPath.row].formTextValue
            cellData.txtData.delegate = self
            
            return cellData
        } else if indexPath.row == 17 {
            let cellData = tableView.dequeueReusableCell(withIdentifier: "MainDrainValueCell", for: indexPath) as! MainDrainValueTableCell
            
            cellData.lblTag.text = "Main drain"
            
            cellData.txtData.text = self.secInspectVisualLeak[indexPath.row].formTextValue
            cellData.txtData.delegate = self
            
            return cellData
        } else if indexPath.row == 18 {
            let cellData = tableView.dequeueReusableCell(withIdentifier: "NichesValueCell", for: indexPath) as! NichesValueTableCell
            
            cellData.lblTag.text = "All light Niches and conducts"
            
            cellData.txtData.text = self.secInspectVisualLeak[indexPath.row].formTextValue
            cellData.txtData.delegate = self
            
            return cellData
        } else if indexPath.row == 19 {
            let cellData = tableView.dequeueReusableCell(withIdentifier: "SideSuctionValueCell", for: indexPath) as! SideSuctionValueTableCell
            
            cellData.lblTag.text = "Side suction"
            
            cellData.txtData.text = self.secInspectVisualLeak[indexPath.row].formTextValue
            cellData.txtData.delegate = self
            
            return cellData
        } else if indexPath.row == 20 {
            let cellData = tableView.dequeueReusableCell(withIdentifier: "CleanerLinesValueCell", for: indexPath) as! CleanerLinesValueTableCell
            
            cellData.lblTag.text = "Cleaner lines"
            
            cellData.txtData.text = self.secInspectVisualLeak[indexPath.row].formTextValue
            cellData.txtData.delegate = self
            
            return cellData
        } else if indexPath.row == 21 {
            let cellData = tableView.dequeueReusableCell(withIdentifier: "SkimmerPortsValueCell", for: indexPath) as! SkimmerPortsValueTableCell
            
            cellData.lblTag.text = "Skimmer ports"
            
            cellData.txtData.text = self.secInspectVisualLeak[indexPath.row].formTextValue
            cellData.txtData.delegate = self
            
            return cellData
        } else if indexPath.row == 22 {
            let cellData = tableView.dequeueReusableCell(withIdentifier: "EqualizerValueCell", for: indexPath) as! EqualizerValueTableCell
            
            cellData.lblTag.text = "Front to Equalizer or Main Drain"
            
            cellData.txtData.text = self.secInspectVisualLeak[indexPath.row].formTextValue
            cellData.txtData.delegate = self
            
            return cellData
        } else if indexPath.row == 23 {
            let cellData = tableView.dequeueReusableCell(withIdentifier: "StructuralCracksValueCell", for: indexPath) as! StructuralCracksValueTableCell
            
            cellData.lblTag.text = "Structural Cracks"
            
            cellData.txtData.text = self.secInspectVisualLeak[indexPath.row].formTextValue
            cellData.txtData.delegate = self
            
            return cellData
        } else if indexPath.row == 24 {
            let cellData = tableView.dequeueReusableCell(withIdentifier: "ExplainValueCell", for: indexPath) as! ExplainValueTableCell
            
            cellData.lblTag.text = "If present explain where"
            
            cellData.txtData.text = self.secInspectVisualLeak[indexPath.row].formTextValue
            cellData.txtData.delegate = self
            
            return cellData
        } else if indexPath.row == 25 {
            let cellData = tableView.dequeueReusableCell(withIdentifier: "SpaJetsValueCell", for: indexPath) as! SpaJetsValueTableCell
            
            cellData.lblTag.text = "Spa jets"
            
            cellData.txtData.text = self.secInspectVisualLeak[indexPath.row].formTextValue
            cellData.txtData.delegate = self
            
            return cellData
        } else if indexPath.row == 26 {
            let cellData = tableView.dequeueReusableCell(withIdentifier: "SpaFillValueCell", for: indexPath) as! SpaFillValueTableCell
            
            cellData.lblTag.text = "Spa Fill"
            
            cellData.txtData.text = self.secInspectVisualLeak[indexPath.row].formTextValue
            cellData.txtData.delegate = self
            
            return cellData
        } else if indexPath.row == 27 {
            let cellData = tableView.dequeueReusableCell(withIdentifier: "SuctionsValueCell", for: indexPath) as! SuctionsValueTableCell
            
            cellData.lblTag.text = "Suctions"
            
            cellData.txtData.text = self.secInspectVisualLeak[indexPath.row].formTextValue
            cellData.txtData.delegate = self
            
            return cellData
        } else if indexPath.row == 28 {
            let headerView : UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "CustomHeaderCell")!
            
            let lblHeaderTitle = headerView.viewWithTag(10) as! UILabel
            lblHeaderTitle.textColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.2352941176, alpha: 1)
            lblHeaderTitle.numberOfLines = 2
            if UIDevice.current.userInterfaceIdiom == .phone {
                lblHeaderTitle.font = UIFont.init(name: "Roboto-bold", size: 13.0)
            } else {
                lblHeaderTitle.font = UIFont.init(name: "Roboto-bold", size: 24.0)
            }
            // set this however is appropriate for your app's model
            lblHeaderTitle.text = "If Commercial"
            
            return headerView
        } else if indexPath.row == 29 {
            let cellData = tableView.dequeueReusableCell(withIdentifier: "SurgeTankValueCell", for: indexPath) as! SurgeTankValueTableCell
            
            cellData.lblTag.text = "Surge Tank"
            
            cellData.txtData.text = self.secInspectVisualLeak[indexPath.row].formTextValue
            cellData.txtData.delegate = self
            
            return cellData
        } else if indexPath.row == 30 {
            let cellData = tableView.dequeueReusableCell(withIdentifier: "ScumGuttersValueCell", for: indexPath) as! ScumGuttersValueTableCell
            
            cellData.lblTag.text = "Scum Gutters"
            
            cellData.txtData.text = self.secInspectVisualLeak[indexPath.row].formTextValue
            cellData.txtData.delegate = self
            
            return cellData
        } else if indexPath.row == 31 {
            let cellData = tableView.dequeueReusableCell(withIdentifier: "CommercialBondBeamCell", for: indexPath) as! CommercialBondBeamTableCell
            
            cellData.lblTag.text = "Bond Beam"
        
            if strCommercialBondBeamOpt == "Yes" {
                self.height = 160+100
            } else{
                self.height = 160
            }
            
            cellData.delegateBondBeam = self
            cellData.delegateInnerBondBeam = self
           
            
            return cellData
        } else if indexPath.row == 32 {
            let cellData = tableView.dequeueReusableCell(withIdentifier: "AutofillValueCell", for: indexPath) as! AutofillValueTableCell
            
            cellData.lblTag.text = "Autofill"
            
            cellData.txtData.text = self.secInspectVisualLeak[indexPath.row].formTextValue
            cellData.txtData.delegate = self
            
            return cellData
        } else if indexPath.row == 33 {
            let cellData = tableView.dequeueReusableCell(withIdentifier: "ArroundFitValueCell", for: indexPath) as! ArroundFitValueTableCell
            
            cellData.lblTag.text = "Autofill"
            
            cellData.txtData.text = self.secInspectVisualLeak[indexPath.row].formTextValue
            cellData.txtData.delegate = self
            
            return cellData
        } else if indexPath.row == 34 {
            let cellData = tableView.dequeueReusableCell(withIdentifier: "NotedCracksValueCell", for: indexPath) as! NotedCracksValueTableCell
            
            cellData.lblTag.text = "At noted cracks"
            
            cellData.txtData.text = self.secInspectVisualLeak[indexPath.row].formTextValue
            cellData.txtData.delegate = self
            
            return cellData
        } else if indexPath.row == 35 {
            let cellData = tableView.dequeueReusableCell(withIdentifier: "DescribeValueCell", for: indexPath) as! DescribeValueTableCell
            
            cellData.lblTag.text = "Other: "
            
            cellData.txtData.text = self.secInspectVisualLeak[indexPath.row].formTextValue
            cellData.txtData.delegate = self
            
            return cellData
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
            if UIDevice.current.userInterfaceIdiom == .phone {
                lblHeaderTitle.font = UIFont.init(name: "Roboto-bold", size: 13.0)
            } else {
                lblHeaderTitle.font = UIFont.init(name: "Roboto-bold", size: 24.0)
            }
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
            } else if indexPath.row == 1 {
                return 260
            } else if indexPath.row == 2 {
                return 260
            } else if indexPath.row == 3 {
                return 260
            } else if indexPath.row == 4 {
                return 260
            } else if indexPath.row == 5 {
                return 260
            } else if indexPath.row == 6 {
                return 260
            } else if indexPath.row == 7 {
                return 260
            } else if indexPath.row == 8 {
                return 450
            } else if indexPath.row == 9 {
                return 450
            } else if indexPath.row == 10 {
                return 85
            } else if indexPath.row == 11 {
                return 345
            } else if indexPath.row == 12 {
                return 345
            } else if indexPath.row == 13 {
                return 85
            } else if indexPath.row == 28 {
                return 85
            } else if indexPath.row == 31 {
                if strCommercialBondBeamOpt == "Yes" {
                    return 120+65
                } else {
                    return 120
                }
            } else {
                return 105
            }
        } else {        //UIDevice.current.userInterfaceIdiom == .pad {
            if indexPath.row == 0 {
                return 780
            } else if indexPath.row == 1 {
                return 420
            } else if indexPath.row == 2 {
                return 420
            } else if indexPath.row == 3 {
                return 420
            } else if indexPath.row == 4 {
                return 420
            } else if indexPath.row == 5 {
                return 420
            } else if indexPath.row == 6 {
                return 420
            } else if indexPath.row == 7 {
                return 420
            } else if indexPath.row == 8 {
                return 784
            } else if indexPath.row == 9 {
                return 784
            } else if indexPath.row == 10 {
                return 85
            } else if indexPath.row == 11 {
                return 600
            } else if indexPath.row == 12 {
                return 600
            } else if indexPath.row == 13 {
                return 85
            } else if indexPath.row == 14 {
                return 170
            } else if indexPath.row == 15 {
                return 170
            } else if indexPath.row == 28 {
                return 85
            } else if indexPath.row == 31 {
                if strCommercialBondBeamOpt == "Yes" {
                    return 160+100
                } else {
                    return 160
                }
            } else if indexPath.row == 36 {
                return 175
            } else {
                return 170
            }
        }
    }
}

extension InspectVisualLeakVC: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        var cell = UITableViewCell()
        cell = (textView.superview?.superview as? UITableViewCell)!
                    
        if let equiCell = cell as? EquipmentAreaCell {
            if textView == equiCell.vwWhereDescription {
                self.secInspectVisualLeak[VisualLeakInspect.equipmentArea.rawValue].formTextValue = (textView.text)!
           }
        } else if let optionalCell = cell as? StructuralCracksTableCell {
            if textView == optionalCell.vwWhereDescription {
                self.secInspectVisualLeak[VisualLeakInspect.structuralCracks.rawValue].formTextValue = (textView.text)!
           }
        } else if let optionalCell = cell as? BondBeamTableCell {
            if textView == optionalCell.vwWhereDescription {
                self.secInspectVisualLeak[VisualLeakInspect.bondBeam.rawValue].formTextValue = (textView.text)!
           }
        } else if let optionalCell = cell as? SurgeTankPoolTableCell {
            if textView == optionalCell.txtOther {
                self.secInspectVisualLeak[VisualLeakInspect.surgeTankPool.rawValue].formTextValue = (textView.text)!
           }
        } else if let optionalCell = cell as? ScumGuttersTableCell {
            if textView == optionalCell.txtOther {
                self.secInspectVisualLeak[VisualLeakInspect.scumGuttersPool.rawValue].formTextValue = (textView.text)!
           }
        }
    }
}

extension InspectVisualLeakVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        var cell = UITableViewCell()
        cell = (textField.superview?.superview as? UITableViewCell)!
        
        if let optionalCell = cell as? ReturnsValueTableCell {
            if textField == optionalCell.txtData {
                self.secInspectVisualLeak[VisualLeakInspect.returns.rawValue].formTextValue = (textField.text)!
           }
        } else if let optionalCell = cell as? SkimmerValueTableCell {
            if textField == optionalCell.txtData {
                self.secInspectVisualLeak[VisualLeakInspect.skimmer.rawValue].formTextValue = (textField.text)!
           }
        } else if let optionalCell = cell as? SkimmerSeamValueTableCell {
            if textField == optionalCell.txtData {
                self.secInspectVisualLeak[VisualLeakInspect.skimmerSeam.rawValue].formTextValue = (textField.text)!
           }
        } else if let optionalCell = cell as? MainDrainValueTableCell {
            if textField == optionalCell.txtData {
                self.secInspectVisualLeak[VisualLeakInspect.mainDrain.rawValue].formTextValue = (textField.text)!
           }
        } else if let optionalCell = cell as? NichesValueTableCell {
            if textField == optionalCell.txtData {
                self.secInspectVisualLeak[VisualLeakInspect.niches.rawValue].formTextValue = (textField.text)!
           }
        } else if let optionalCell = cell as? SideSuctionValueTableCell {
            if textField == optionalCell.txtData {
                self.secInspectVisualLeak[VisualLeakInspect.sideSuction.rawValue].formTextValue = (textField.text)!
           }
        } else if let optionalCell = cell as? CleanerLinesValueTableCell {
            if textField == optionalCell.txtData {
                self.secInspectVisualLeak[VisualLeakInspect.cleanerLines.rawValue].formTextValue = (textField.text)!
           }
        } else if let optionalCell = cell as? SkimmerPortsValueTableCell {
            if textField == optionalCell.txtData {
                self.secInspectVisualLeak[VisualLeakInspect.skimmerPorts.rawValue].formTextValue = (textField.text)!
           }
        } else if let optionalCell = cell as? EqualizerValueTableCell {
            if textField == optionalCell.txtData {
                self.secInspectVisualLeak[VisualLeakInspect.equalizer.rawValue].formTextValue = (textField.text)!
           }
        } else if let optionalCell = cell as? StructuralCracksValueTableCell {
            if textField == optionalCell.txtData {
                self.secInspectVisualLeak[VisualLeakInspect.structuralCracksValue.rawValue].formTextValue = (textField.text)!
           }
        } else if let optionalCell = cell as? ExplainValueTableCell {
            if textField == optionalCell.txtData {
                self.secInspectVisualLeak[VisualLeakInspect.explain.rawValue].formTextValue = (textField.text)!
           }
        } else if let optionalCell = cell as? SpaJetsValueTableCell {
            if textField == optionalCell.txtData {
                self.secInspectVisualLeak[VisualLeakInspect.spaJets.rawValue].formTextValue = (textField.text)!
           }
        } else if let optionalCell = cell as? SpaFillValueTableCell {
            if textField == optionalCell.txtData {
                self.secInspectVisualLeak[VisualLeakInspect.spaFill.rawValue].formTextValue = (textField.text)!
           }
        } else if let optionalCell = cell as? SuctionsValueTableCell {
            if textField == optionalCell.txtData {
                self.secInspectVisualLeak[VisualLeakInspect.suction.rawValue].formTextValue = (textField.text)!
           }
        } else if let optionalCell = cell as? SurgeTankValueTableCell {
            if textField == optionalCell.txtData {
                self.secInspectVisualLeak[VisualLeakInspect.surgeTankValue.rawValue].formTextValue = (textField.text)!
           }
        } else if let optionalCell = cell as? ScumGuttersValueTableCell {
            if textField == optionalCell.txtData {
                self.secInspectVisualLeak[VisualLeakInspect.scumGuttersValue.rawValue].formTextValue = (textField.text)!
           }
        } else if let optionalCell = cell as? AutofillValueTableCell {
            if textField == optionalCell.txtData {
                self.secInspectVisualLeak[VisualLeakInspect.autoFill.rawValue].formTextValue = (textField.text)!
           }
        } else if let optionalCell = cell as? ArroundFitValueTableCell {
            if textField == optionalCell.txtData {
                self.secInspectVisualLeak[VisualLeakInspect.arroundFittings.rawValue].formTextValue = (textField.text)!
           }
        } else if let optionalCell = cell as? NotedCracksValueTableCell {
            if textField == optionalCell.txtData {
                self.secInspectVisualLeak[VisualLeakInspect.notedCracks.rawValue].formTextValue = (textField.text)!
           }
        } else if let optionalCell = cell as? DescribeValueTableCell {
            if textField == optionalCell.txtData {
                self.secInspectVisualLeak[VisualLeakInspect.other.rawValue].formTextValue = (textField.text)!
           }
        }
    }
}

extension InspectVisualLeakVC: UploadCollectionProtocol {
    //MARK:- UploadCollectionProtocol
    func didTapOnCellItem(_indexpath: IndexPath, _imgUrl: String, _videoUrl: String) {
        
    }
    
    func didUpdateCellIndex(_indexpath: Int) {
        
    }
}

extension InspectVisualLeakVC: EquipmentAreaCellProtocol, BackWashCellProtocol, AroundWaterCellProtocol, SolarSystemCellProtocol, CatchBasinCellProtocol, SlotDrainsCellProtocol, VinylCellProtocol, NoticeableCellProtocol, StructuralCracksCellProtocol, BondBeamCellProtocol, SurgeTankPoolProtocol, ScumGuttersProtocol,CommercialBondBeanProtocol,CommercialInnerBondBeamProtocol {
    
    //MARK:: EquipmentAreaCell
    func didTapOnCellEquipmentArea(_btnEquipmentAreaTag: Int) {
        if _btnEquipmentAreaTag == 0 {
            strEquaiAreaOption = "Noted leak(s)"
        } else if _btnEquipmentAreaTag == 1 {
            strEquaiAreaOption = "No leaks noted"
        }
        self.tblVisualLeak.reloadData()
    }
    
    func didTapOnCellBackWash(_btnBackWashTag: Int) {
        if _btnBackWashTag == 0 {
            strBackwashOption = "Leaking"
        } else if _btnBackWashTag == 1 {
            strBackwashOption = "Not Leaking"
        }
        self.tblVisualLeak.reloadData()
    }
    
    func didTapOnCellAroundWater(_btnAroundWaterTag: Int) {
        if _btnAroundWaterTag == 0 {
            strWaterFeatureOption = "Leaking"
        } else if _btnAroundWaterTag == 1 {
            strWaterFeatureOption = "Not Leaking"
        }
        self.tblVisualLeak.reloadData()
    }
    
    func didTapOnCellSolarSystem(_btnSolarSystemTag: Int) {
        if _btnSolarSystemTag == 0 {
            strSolarOption = "Leaking"
        } else if _btnSolarSystemTag == 1 {
            strSolarOption = "Not Leaking"
        }
        self.tblVisualLeak.reloadData()
    }
    
    func didTapOnCellCatchBasin(_btnCatchBasinTag: Int) {
        if _btnCatchBasinTag == 0 {
            strBasinOption = "Leaking"
        } else if _btnCatchBasinTag == 1 {
            strBasinOption = "Not Leaking"
        }
        self.tblVisualLeak.reloadData()
    }
    
    func didTapOnCellSlotDrains(_btnSlotDrainsTag: Int) {
        if _btnSlotDrainsTag == 0 {
            strDrainOption = "Leaking"
        } else if _btnSlotDrainsTag == 1 {
            strDrainOption = "Not Leaking"
        }
        self.tblVisualLeak.reloadData()
    }
    
    func didTapOnCellVinyl(_btnVinylTag: Int) {
        if _btnVinylTag == 0 {
            strVinylOption = "Yes"
        } else if _btnVinylTag == 1 {
            strVinylOption = "No"
        }
        self.tblVisualLeak.reloadData()
    }
    
    func didTapOnCellNoticeable(_btnNoticeableTag: Int) {
        if _btnNoticeableTag == 0 {
            strNoticeableOption = "Yes"
        } else if _btnNoticeableTag == 1 {
            strNoticeableOption = "No"
        }
        self.tblVisualLeak.reloadData()
    }
    
    func didTapOnCellStructuralCracks(_btnStructuralCracksTag: Int) {
        if _btnStructuralCracksTag == 0 {
            strStructuralCracksOption = "Yes"
        } else if _btnStructuralCracksTag == 1 {
            strStructuralCracksOption = "No visible structural cracks in pool"
        }
        self.tblVisualLeak.reloadData()
    }
    
    func didTapOnCellBondBeam(_btnBondBeamTag: Int) {
        if _btnBondBeamTag == 0 {
            strBondBeamOption = "Yes"
        } else if _btnBondBeamTag == 1 {
            strBondBeamOption = "Was solid and not cracked"
        }
        self.tblVisualLeak.reloadData()
    }
    
    func didTapOnCellSurgeTankPool(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strSurgeTankPoolOption = "Yes"
        } else if _btnDescribeTag == 1 {
            strSurgeTankPoolOption = "Was solid and not cracked"
        }
        self.tblVisualLeak.reloadData()
    }
    
    func didTapOnCellScumGutters(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strScumGuttersOption = "Yes"
        } else if _btnDescribeTag == 1 {
            strScumGuttersOption = "Was solid and not cracked"
        }
        self.tblVisualLeak.reloadData()
    }
    
    func didTapOnCellBondBeam(_btnDescribeTag: Int){
        if _btnDescribeTag == 0 {
            strCommercialBondBeamOpt = "Yes"
        } else if _btnDescribeTag == 1 {
            strCommercialBondBeamOpt = "No"
        }
        self.tblVisualLeak.reloadData()
    }
    
    func didTapOnCellInnerBondBeam(_btnDescribeTag: Int){
        if _btnDescribeTag == 0 {
            strCommercialInnerBondBeamOpt = "Pool"
        } else if _btnDescribeTag == 1 {
            strCommercialInnerBondBeamOpt = "Spa"
        }
    }
}
