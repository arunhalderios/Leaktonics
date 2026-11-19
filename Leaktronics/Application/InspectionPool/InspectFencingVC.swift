//
//  InspectFencingVC.swift
//  Leaktronics
//
//  Created by ivaninfotech on 5/8/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import CoreData
import DLRadioButton
import SVProgressHUD
import Alamofire
import Photos
import OpalImagePicker



class InspectFencingVC: UIViewController, UINavigationControllerDelegate, UploadCollectionProtocol {
    
    @IBOutlet weak var tblFence: UITableView!
    
    var secInspectFencing = [formInspectionPoolData]()
    var secCover = [formInspectionPoolData]()
    
    enum InspectFencing: Int {
        case perimeter = 2
        case height = 3
        case minimal = 4
        case defects = 6
        case latching = 7
        case gates = 8
        case mounted = 9
        case locking = 10
        case installed = 11
        case isolate = 12
        case cover = 14
    }
    
    enum Cover: Int {
        case material = 0
        case maintenance = 1
        case bonded = 2
        case lockout = 3
        case ran = 4
        case reel = 5
        case manual = 6
    }
    
    var imagePicker = UIImagePickerController()
    var picker:UIImagePickerController? = UIImagePickerController()


    //For Images
    var arrFenceMainImg: [CollectionImageObject] = []
    var arrFencePerimeterImg: [CollectionImageObject] = []
    var arrFenceHeightImg: [CollectionImageObject] = []
    var arrFenceMinimalImg: [CollectionImageObject] = []
    var arrFenceDefectsImg: [CollectionImageObject] = []
    var arrFenceLatchingImg: [CollectionImageObject] = []
    var arrFenceGatesImg: [CollectionImageObject] = []
    var arrFenceMountedImg: [CollectionImageObject] = []
    var arrFenceLockingImg: [CollectionImageObject] = []
    var arrFenceInstalledImg: [CollectionImageObject] = []
    var arrFenceIsolateImg: [CollectionImageObject] = []
    var arrCoverMainImg: [CollectionImageObject] = []
    
    
    var arrCoverMaterialImg: [CollectionImageObject] = []
    var arrCoverMaintenanceImg: [CollectionImageObject] = []
    var arrCoverBondedImg: [CollectionImageObject] = []
    var arrCoverLockoutImg: [CollectionImageObject] = []
    var arrCoverRanImg: [CollectionImageObject] = []
    var arrCoverReelImg: [CollectionImageObject] = []
    var arrCoverManualImg: [CollectionImageObject] = []

    var fetchIndexForUpload: Int = -1
    var fetchIndexForSubCoverUpload: Int = -1

    //For Image Server path
    var strFenceMainImg = String()
    
    var strFencePerimeterImg = String()
    var strFenceHeightImg = String()
    var strFenceMinimalImg = String()
    var strFenceDefectsImg = String()
    var strFenceLatchingImg = String()
    var strFenceGatesImg = String()
    var strFenceMountedImg = String()
    var strFenceLockingImg = String()
    var strFenceInstalledImg = String()
    var strFenceIsolateImg = String()
    
    var strCoverMainImg = String()
    var strCoverMaterialImg = String()
    var strCoverMaintenanceImg = String()
    var strCoverBondedImg = String()
    var strCoverLockoutImg = String()
    var strCoverRanImg = String()
    var strCoverReelImg = String()
    var strCoverManualImg = String()
    
    
    //For Image CoreData
    var dataFenceMainImg = NSData()
    
    var dataFencePerimeterImg = NSData()
    var dataFenceHeightImg = NSData()
    var dataFenceMinimalImg = NSData()
    var dataFenceDefectsImg = NSData()
    var dataFenceLatchingImg = NSData()
    var dataFenceGatesImg = NSData()
    var dataFenceMountedImg = NSData()
    var dataFenceLockingImg = NSData()
    var dataFenceInstalledImg = NSData()
    var dataFenceIsolateImg = NSData()
    
    var dataCoverMainImg = NSData()
    var dataCoverMaterialImg = NSData()
    var dataCoverMaintenanceImg = NSData()
    var dataCoverBondedImg = NSData()
    var dataCoverLockoutImg = NSData()
    var dataCoverRanImg = NSData()
    var dataCoverReelImg = NSData()
    var dataCoverManualImg = NSData()
    
    
    //For Optional Value
    var strFenceMainOpt = String()
    var strFencePerimeterOpt = String()
    var strFenceHeightOpt = String()
    var strFenceMinimalOpt = String()
    var strFenceDefectsOpt = String()
    var strFenceLatchingOpt = String()
    var strFenceGatesOpt = String()
    var strFenceMountedOpt = String()
    var strFenceLockingOpt = String()
    var strFenceInstalledOpt = String()
    var strFenceIsolateOpt = String()
    
    var strCoverMainOpt = String()
    var strCoverMaterialOpt = String()
    var strCoverMaintenanceOpt = String()
    var strCoverBondedOpt = String()
    var strCoverLockoutOpt = String()
    var strCoverRanOpt = String()
    var strCoverReelOpt = String()
    var strCoverManualOpt = String()
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.prepareFormCoverData()
    }
    
    func prepareFormCoverData() {
        for _ in 0..<16 {
            let obj = formInspectionPoolData()
            self.secInspectFencing.append(obj)
        }
        for _ in 0..<9 {
            let obj = formInspectionPoolData()
            self.secCover.append(obj)
        }
    }
    
    //MARK:- UploadCollectionProtocol
    func didTapOnCellItem(_indexpath: IndexPath, _imgUrl: String, _videoUrl: String) {
        
    }
    
    func didUpdateCellIndex(_indexpath: Int) {
        
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
        let indexOfCell = self.tblFence.indexPath(for: cell)
        print("Clicked Index : \(String(describing: indexOfCell?.row))")
        
        fetchIndexForUpload = (indexOfCell?.row)!
        fetchIndexForSubCoverUpload = -1
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
    
    @IBAction func btnCoverUpload(_ sender: Any) {
        print("Button pressed 👍 ")
        let btn = sender as! UIButton
        let cell = btn.superview?.superview?.superview as! UITableViewCell
        let tblWall = self.view.viewWithTag(25) as! UITableView
        let indexOfCell = tblWall.indexPath(for: cell)
        print("Clicked Index : \(String(describing: indexOfCell?.row))")
        fetchIndexForUpload = -1
        fetchIndexForSubCoverUpload = (indexOfCell?.row)!
        
        print("Upload Index : \(String(describing: fetchIndexForSubCoverUpload))")
        
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
        //self.postInspectFencing()
        if UIDevice.current.userInterfaceIdiom == .phone {
           let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
           let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectVisualLeak") as! InspectVisualLeakVC
           self.navigationController?.pushViewController(formVC, animated: true)
        } else if UIDevice.current.userInterfaceIdiom == .pad {
           let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
           let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectVisualLeak") as! InspectVisualLeakVC
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
                    
                    managedObject.setValue(dataFenceMainImg, forKey: "fenceMainImage")
                    managedObject.setValue(strFencePerimeterOpt, forKey: "fencePerimeterOption")
                    managedObject.setValue(dataFencePerimeterImg, forKey: "fencePerimeterImage")
                    managedObject.setValue(self.secInspectFencing[InspectFencing.perimeter.rawValue].formTextValue, forKey: "fencePerimeterData")
                    managedObject.setValue(strFenceHeightOpt, forKey: "fenceHeightOption")
                    managedObject.setValue(dataFenceHeightImg, forKey: "fenceHeightImage")
                    managedObject.setValue(self.secInspectFencing[InspectFencing.height.rawValue].formTextValue, forKey: "fenceHeightData")
                    managedObject.setValue(strFenceMinimalOpt, forKey: "fenceMinimalOption")
                    managedObject.setValue(dataFenceMinimalImg, forKey: "fenceMinimalImage")
                    managedObject.setValue(self.secInspectFencing[InspectFencing.minimal.rawValue].formTextValue, forKey: "fenceMinimalData")
                    managedObject.setValue(strFenceDefectsOpt, forKey: "fenceDefectsOption")
                    managedObject.setValue(dataFenceDefectsImg, forKey: "fenceDefectsImage")
                    managedObject.setValue(self.secInspectFencing[InspectFencing.defects.rawValue].formTextValue, forKey: "fenceDefectsData")
                    managedObject.setValue(strFenceLatchingOpt, forKey: "fenceLatchingOption")
                    managedObject.setValue(dataFenceLatchingImg, forKey: "fenceLatchingImage")
                    managedObject.setValue(self.secInspectFencing[InspectFencing.latching.rawValue].formTextValue, forKey: "fenceLatchingData")
                    managedObject.setValue(strFenceGatesOpt, forKey: "fenceGatesOption")
                    managedObject.setValue(dataFenceGatesImg, forKey: "fenceGatesImage")
                    managedObject.setValue(self.secInspectFencing[InspectFencing.gates.rawValue].formTextValue, forKey: "fenceGatesData")
                    managedObject.setValue(strFenceMountedOpt, forKey: "fenceMountedOption")
                    managedObject.setValue(dataFenceMountedImg, forKey: "fenceMountedImage")
                    managedObject.setValue(self.secInspectFencing[InspectFencing.mounted.rawValue].formTextValue, forKey: "fenceMountedData")
                    managedObject.setValue(strFenceInstalledOpt, forKey: "fenceInstalledOption")
                    managedObject.setValue(dataFenceInstalledImg, forKey: "fenceInstalledImage")
                    managedObject.setValue(self.secInspectFencing[InspectFencing.installed.rawValue].formTextValue, forKey: "fenceInstalledData")
                    managedObject.setValue(strFenceLockingOpt, forKey: "fenceLockingOption")
                    managedObject.setValue(dataFenceLockingImg, forKey: "fenceLockingImage")
                    managedObject.setValue( self.secInspectFencing[InspectFencing.locking.rawValue].formTextValue, forKey: "fenceLockingData")
                    managedObject.setValue(strFenceIsolateOpt, forKey: "fenceIsolateOption")
                    managedObject.setValue(dataFenceIsolateImg, forKey: "fenceIsolateImage")
                    managedObject.setValue(self.secInspectFencing[InspectFencing.isolate.rawValue].formTextValue, forKey: "fenceIsolateData")
                    managedObject.setValue(strCoverMainOpt, forKey: "coverMainOption")
                    managedObject.setValue(dataCoverMainImg, forKey: "coverMainImage")
                    managedObject.setValue(self.secInspectFencing[InspectFencing.cover.rawValue].formTextValue, forKey: "coverMainData")
                    managedObject.setValue(strCoverMaterialOpt, forKey: "coverMaterialOption")
                    managedObject.setValue(dataCoverMaterialImg, forKey: "coverMaterialImage")
                    managedObject.setValue(self.secCover[Cover.material.rawValue].formTextValue, forKey: "coverMaterialData")
                    managedObject.setValue(strCoverMaintenanceOpt, forKey: "coverMaintenanceOption")
                    managedObject.setValue(dataCoverMaintenanceImg, forKey: "coverMaintenanceImage")
                    managedObject.setValue(self.secCover[Cover.maintenance.rawValue].formTextValue, forKey: "coverMaintenanceData")
                    managedObject.setValue(strCoverBondedOpt, forKey: "coverBondedOption")
                    managedObject.setValue(dataCoverBondedImg, forKey: "coverBondedImage")
                    managedObject.setValue(self.secCover[Cover.bonded.rawValue].formTextValue, forKey: "coverBondedData")
                    managedObject.setValue(strCoverLockoutOpt, forKey: "coverLockoutOption")
                    managedObject.setValue(dataCoverLockoutImg, forKey: "coverLockoutImage")
                    managedObject.setValue(self.secCover[Cover.lockout.rawValue].formTextValue, forKey: "coverLockoutData")
                    managedObject.setValue(strCoverRanOpt, forKey: "coverRanOption")
                    managedObject.setValue(dataCoverRanImg, forKey: "coverRanImage")
                    managedObject.setValue(self.secCover[Cover.ran.rawValue].formTextValue, forKey: "coverRanData")
                    managedObject.setValue(strCoverReelOpt, forKey: "coverReelOption")
                    managedObject.setValue(dataCoverReelImg, forKey: "coverReelImage")
                    managedObject.setValue(self.secCover[Cover.reel.rawValue].formTextValue, forKey: "coverReelData")
                    managedObject.setValue(strCoverManualOpt, forKey: "coverManualOption")
                    managedObject.setValue(dataCoverManualImg, forKey: "coverManualImage")
                    managedObject.setValue(self.secCover[Cover.manual.rawValue].formTextValue, forKey: "coverManualData")
                    
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
                        print("Data of InspectFencingVC:: \(data)")
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
                        self.strFenceMainImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 2 {
                        self.strFencePerimeterImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 3 {
                        self.strFenceHeightImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 4 {
                        self.strFenceMinimalImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 6 {
                        self.strFenceDefectsImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 7 {
                        self.strFenceLatchingImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 8 {
                        self.strFenceGatesImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 9 {
                        self.strFenceMountedImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 10 {
                        self.strFenceLockingImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 11 {
                        self.strFenceInstalledImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 12 {
                        self.strFenceIsolateImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 14 {
                        self.strCoverMainImg = String(describing: data!)
                    }
                    
                    
                    if self.fetchIndexForSubCoverUpload == 0 {
                        self.strCoverMaterialImg = String(describing: data!)
                    } else if self.fetchIndexForSubCoverUpload == 1 {
                        self.strCoverMaintenanceImg = String(describing: data!)
                    } else if self.fetchIndexForSubCoverUpload == 2 {
                        self.strCoverBondedImg = String(describing: data!)
                    } else if self.fetchIndexForSubCoverUpload == 3 {
                        self.strCoverLockoutImg = String(describing: data!)
                    } else if self.fetchIndexForSubCoverUpload == 4 {
                        self.strCoverRanImg = String(describing: data!)
                    } else if self.fetchIndexForSubCoverUpload == 5 {
                        self.strCoverReelImg = String(describing: data!)
                    } else if self.fetchIndexForSubCoverUpload == 6 {
                        self.strCoverManualImg = String(describing: data!)
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
    
    func postInspectFencing() {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        
        let return_id = UserDefaults.standard.value(forKey: "returnKeyForInspection")
        
          let inspectFencingDetails: NSMutableDictionary = [
                    "return_data_id"        : return_id!,
                    "fenceMainImage"        : strFenceMainImg,
                    "fencePerimeterOption"  : strFencePerimeterOpt,
                    "fencePerimeterImage"   : strFencePerimeterImg,
                    "fencePerimeterData"    : self.secInspectFencing[InspectFencing.perimeter.rawValue].formTextValue,
                    "fenceHeightOption"     : strFenceHeightOpt,
                    "fenceHeightImage"      : strFenceHeightImg,
                    "fenceHeightData"       : self.secInspectFencing[InspectFencing.height.rawValue].formTextValue,
                    "fenceMinimalOption"    : strFenceMinimalOpt,
                    "fenceMinimalImage"     : strFenceMinimalImg,
                    "fenceMinimalData"      : self.secInspectFencing[InspectFencing.minimal.rawValue].formTextValue,
                    "fenceDefectsOption"    : strFenceDefectsOpt,
                    "fenceDefectsImage"     : strFenceDefectsImg,
                    "fenceDefectsData"      : self.secInspectFencing[InspectFencing.defects.rawValue].formTextValue,
                    "fenceLatchingOption"   : strFenceLatchingOpt,
                    "fenceLatchingImage"    : strFenceLatchingImg,
                    "fenceLatchingData"     : self.secInspectFencing[InspectFencing.latching.rawValue].formTextValue,
                    "fenceGatesOption"      : strFenceGatesOpt,
                    "fenceGatesImage"       : strFenceGatesImg,
                    "fenceGatesData"        : self.secInspectFencing[InspectFencing.gates.rawValue].formTextValue,
                    "fenceMountedOption"    : strFenceMountedOpt,
                    "fenceMountedImage"     : strFenceMountedImg,
                    "fenceMountedData"      : self.secInspectFencing[InspectFencing.mounted.rawValue].formTextValue,
                    "fenceInstalledOption"  : strFenceInstalledOpt,
                    "fenceInstalledImage"   : strFenceInstalledImg,
                    "fenceInstalledData"    : self.secInspectFencing[InspectFencing.installed.rawValue].formTextValue,
                    "fenceLockingOption"    : strFenceLockingOpt,
                    "fenceLockingImage"     : strFenceLockingImg,
                    "fenceLockingData"      : self.secInspectFencing[InspectFencing.locking.rawValue].formTextValue,
                    "fenceIsolateOption"    : strFenceIsolateOpt,
                    "fenceIsolateImage"     : strFenceIsolateImg,
                    "fenceIsolateData"      : self.secInspectFencing[InspectFencing.isolate.rawValue].formTextValue,
                    "coverMainOption"       : strCoverMainOpt,
                    "coverMainImage"        : strCoverMainImg,
                    "coverMainData"         : self.secInspectFencing[InspectFencing.cover.rawValue].formTextValue,
                    "coverMaterialOption"   : strCoverMaterialOpt,
                    "coverMaterialImage"    : strCoverMaterialImg,
                    "coverMaterialData"     : self.secCover[Cover.material.rawValue].formTextValue,
                    "coverMaintenanceOption": strCoverMaintenanceOpt,
                    "coverMaintenanceImage" : strCoverMaintenanceImg,
                    "coverMaintenanceData"  : self.secCover[Cover.maintenance.rawValue].formTextValue,
                    "coverBondedOption"     : strCoverBondedOpt,
                    "coverBondedImage"      : strCoverBondedImg,
                    "coverBondedData"       : self.secCover[Cover.bonded.rawValue].formTextValue,
                    "coverLockoutOption"    : strCoverLockoutOpt,
                    "coverLockoutImage"     : strCoverLockoutImg,
                    "coverLockoutData"      : self.secCover[Cover.lockout.rawValue].formTextValue,
                    "coverRanOption"        : strCoverRanOpt,
                    "coverRanImage"         : strCoverRanImg,
                    "coverRanData"          : self.secCover[Cover.ran.rawValue].formTextValue,
                    "coverReelOption"       : strCoverReelOpt,
                    "coverReelImage"        : strCoverReelImg,
                    "coverReelData"         : self.secCover[Cover.reel.rawValue].formTextValue,
                    "coverManualOption"     : strCoverManualOpt,
                    "coverManualImage"      : strCoverManualImg,
                    "coverManualData"       : self.secCover[Cover.manual.rawValue].formTextValue
                ]

        print("inspectFencingDetails :: \(inspectFencingDetails)")
        //if sharedExtension.connectedToNetwork() {
        ApiManager.sharedInstanceAPI.PostInspectFencing(postId: 1, fencingDetails: inspectFencingDetails, onSuccess: { json in
            DispatchQueue.main.async {
                print("inspectFencingDetails json :: \(String(describing: json))")
                DispatchQueue.main.async(execute: {() -> Void in
                    if UIDevice.current.userInterfaceIdiom == .phone {
                       let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
                       let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectVisualLeak") as! InspectVisualLeakVC
                       self.navigationController?.pushViewController(formVC, animated: true)
                    } else if UIDevice.current.userInterfaceIdiom == .pad {
                       let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
                       let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectVisualLeak") as! InspectVisualLeakVC
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

extension InspectFencingVC: OpalImagePickerControllerDelegate {
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
                                self.arrFenceMainImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.setPostImage(arrOfImages: images)
                                self.dataFenceMainImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForUpload == 2 {
                                self.arrFencePerimeterImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.setPostImage(arrOfImages: images)
                                self.dataFencePerimeterImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForUpload == 3 {
                                self.arrFenceHeightImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.setPostImage(arrOfImages: images)
                                self.dataFenceHeightImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForUpload == 4 {
                                self.arrFenceMinimalImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.setPostImage(arrOfImages: images)
                                self.dataFenceMinimalImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForUpload == 6 {
                                self.arrFenceDefectsImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.setPostImage(arrOfImages: images)
                                self.dataFenceDefectsImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForUpload == 7 {
                                self.arrFenceLatchingImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.setPostImage(arrOfImages: images)
                                self.dataFenceLatchingImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForUpload == 8 {
                               self.arrFenceGatesImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.setPostImage(arrOfImages: images)
                                self.dataFenceGatesImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForUpload == 9 {
                               self.arrFenceMountedImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.setPostImage(arrOfImages: images)
                                self.dataFenceMountedImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForUpload == 10 {
                               self.arrFenceLockingImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.setPostImage(arrOfImages: images)
                                self.dataFenceLockingImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForUpload == 11 {
                               self.arrFenceInstalledImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.setPostImage(arrOfImages: images)
                                self.dataFenceInstalledImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForUpload == 12 {
                               self.arrFenceIsolateImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.setPostImage(arrOfImages: images)
                                self.dataFenceIsolateImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForUpload == 14 {
                               self.arrCoverMainImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.setPostImage(arrOfImages: images)
                                self.dataCoverMainImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            }
                            
                            if self.fetchIndexForSubCoverUpload == 0 {
                                self.arrCoverMaterialImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.setPostImage(arrOfImages: images)
                                self.dataCoverMaterialImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForSubCoverUpload == 1 {
                                self.arrCoverMaintenanceImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.setPostImage(arrOfImages: images)
                                self.dataCoverMaintenanceImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForSubCoverUpload == 2 {
                                self.arrCoverBondedImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.setPostImage(arrOfImages: images)
                                self.dataCoverBondedImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForSubCoverUpload == 3 {
                                self.arrCoverLockoutImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.setPostImage(arrOfImages: images)
                                self.dataCoverLockoutImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForSubCoverUpload == 4 {
                                self.arrCoverRanImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.setPostImage(arrOfImages: images)
                                self.dataCoverRanImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForSubCoverUpload == 5 {
                                self.arrCoverReelImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.setPostImage(arrOfImages: images)
                                self.dataCoverReelImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                            } else if self.fetchIndexForSubCoverUpload == 6 {
                                self.arrCoverManualImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.setPostImage(arrOfImages: images)
                                self.dataCoverManualImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
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
                self.tblFence.reloadData()
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


extension InspectFencingVC: UIImagePickerControllerDelegate {
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
            self.arrFenceMainImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataFenceMainImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if self.fetchIndexForUpload == 2 {
            self.arrFencePerimeterImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataFencePerimeterImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if fetchIndexForUpload == 3 {
            self.arrFenceHeightImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataFenceHeightImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if fetchIndexForUpload == 4 {
            self.arrFenceMinimalImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataFenceMinimalImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if fetchIndexForUpload == 6 {
            self.arrFenceDefectsImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataFenceDefectsImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if fetchIndexForUpload == 7 {
            self.arrFenceLatchingImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)

            //self.setPostImage(arrOfImages: imageArr)
            self.dataFenceLatchingImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if fetchIndexForUpload == 8 {
            self.arrFenceGatesImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
           
            //self.setPostImage(arrOfImages: imageArr)
            self.dataFenceGatesImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if fetchIndexForUpload == 9 {
            self.arrFenceMountedImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataFenceMountedImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if fetchIndexForUpload == 10 {
            self.arrFenceLockingImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataFenceLockingImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if fetchIndexForUpload == 11 {
            self.arrFenceInstalledImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataFenceInstalledImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if fetchIndexForUpload == 12 {
            self.arrFenceIsolateImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)

            //self.setPostImage(arrOfImages: imageArr)
            self.dataFenceIsolateImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if self.fetchIndexForUpload == 14 {
            self.arrCoverMainImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataCoverMainImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        }
        
        if self.fetchIndexForSubCoverUpload == 0 {
            self.arrCoverMaterialImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataCoverMaterialImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if self.fetchIndexForSubCoverUpload == 1 {
            self.arrCoverMaintenanceImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataCoverMaintenanceImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if self.fetchIndexForSubCoverUpload == 2 {
            self.arrCoverBondedImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataCoverBondedImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if fetchIndexForSubCoverUpload == 3 {
            self.arrCoverLockoutImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataCoverLockoutImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if fetchIndexForSubCoverUpload == 4 {
            self.arrCoverRanImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataCoverRanImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if self.fetchIndexForSubCoverUpload == 5 {
            self.arrCoverReelImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataCoverReelImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        } else if fetchIndexForSubCoverUpload == 6 {
            self.arrCoverManualImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataCoverManualImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        }
        
        self.tblFence.reloadData()
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
}


extension InspectFencingVC: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        var cell = UITableViewCell()
        cell = (textView.superview?.superview as? UITableViewCell)!
        
        if let fenceCell = cell as? Fence0TableCell {
            if textView == fenceCell.txtOther {
                self.secInspectFencing[InspectFencing.perimeter.rawValue].formTextValue = (textView.text)!
           }
        } else if let fenceCell = cell as? Fence1TableCell {
            if textView == fenceCell.txtOther {
                self.secInspectFencing[InspectFencing.height.rawValue].formTextValue = (textView.text)!
            }
        } else if let fenceCell = cell as? Fence2TableCell {
            if textView == fenceCell.txtOther {
                self.secInspectFencing[InspectFencing.minimal.rawValue].formTextValue = (textView.text)!
            }
        } else if let fenceCell = cell as? Fence3TableCell {
            if textView == fenceCell.txtOther {
                self.secInspectFencing[InspectFencing.defects.rawValue].formTextValue = (textView.text)!
            }
        } else if let fenceCell = cell as? Fence4TableCell {
            if textView == fenceCell.txtOther {
                self.secInspectFencing[InspectFencing.latching.rawValue].formTextValue = (textView.text)!
            }
        } else if let fenceCell = cell as? Fence5TableCell {
            if textView == fenceCell.txtOther {
                self.secInspectFencing[InspectFencing.gates.rawValue].formTextValue = (textView.text)!
            }
        } else if let fenceCell = cell as? Fence6TableCell {
            if textView == fenceCell.txtOther {
                self.secInspectFencing[InspectFencing.mounted.rawValue].formTextValue = (textView.text)!
            }
        } else if let fenceCell = cell as? Fence7TableCell {
            if textView == fenceCell.txtOther {
                self.secInspectFencing[InspectFencing.locking.rawValue].formTextValue = (textView.text)!
            }
        } else if let fenceCell = cell as? Fence8TableCell {
            if textView == fenceCell.txtOther {
                self.secInspectFencing[InspectFencing.installed.rawValue].formTextValue = (textView.text)!
            }
        } else if let fenceCell = cell as? Fence9TableCell {
            if textView == fenceCell.txtOther {
                self.secInspectFencing[InspectFencing.isolate.rawValue].formTextValue = (textView.text)!
            }
        } else if let fenceCell = cell as? CoverMainTableCell {
            if textView == fenceCell.txtOther {
                self.secInspectFencing[InspectFencing.cover.rawValue].formTextValue = (textView.text)!
            }
        }
        
        if let coverCell = cell as? Cover0TableCell {
            if textView == coverCell.txtOther {
                self.secCover[Cover.material.rawValue].formTextValue = (textView.text)!
            }
        } else if let coverCell = cell as? Cover1TableCell {
            if textView == coverCell.txtOther {
                self.secCover[Cover.maintenance.rawValue].formTextValue = (textView.text)!
            }
        } else if let coverCell = cell as? Cover2TableCell {
            if textView == coverCell.txtOther {
                self.secCover[Cover.bonded.rawValue].formTextValue = (textView.text)!
            }
        } else if let coverCell = cell as? Cover3TableCell {
            if textView == coverCell.txtOther {
                self.secCover[Cover.lockout.rawValue].formTextValue = (textView.text)!
            }
        } else if let coverCell = cell as? Cover4TableCell {
            if textView == coverCell.txtOther {
                self.secCover[Cover.ran.rawValue].formTextValue = (textView.text)!
            }
        } else if let coverCell = cell as? Cover5TableCell {
            if textView == coverCell.txtOther {
                self.secCover[Cover.reel.rawValue].formTextValue = (textView.text)!
            }
        } else if let coverCell = cell as? Cover6TableCell {
            if textView == coverCell.txtOther {
                self.secCover[Cover.manual.rawValue].formTextValue = (textView.text)!
            }
        }
    }
}

extension InspectFencingVC: UITableViewDataSource, UITableViewDelegate {
    //MARK:- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 25 {
            return 8
        } else {
            return 16
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 25 {
            if indexPath.row == 0 {
                let coverCell = tableView.dequeueReusableCell(withIdentifier: "Cover0Cell", for: indexPath) as! Cover0TableCell
                
                coverCell.lblHeader.text = "Are there any tears in the material?"
                
                coverCell.btnUpload.addTarget(self, action: #selector(btnCoverUpload(_:)), for: UIControl.Event.touchUpInside)
                
                coverCell.collectionVw.arrItems = arrCoverMaterialImg
                coverCell.collectionVw.delegateItemCollection = self
                coverCell.collectionVw.reloadImageCollection()
                
                if arrCoverMaterialImg.count > 0 {
                    coverCell.btnUpload.isHidden = true
                    coverCell.collectionVw.isHidden = false
                } else {
                    coverCell.btnUpload.isHidden = false
                    coverCell.collectionVw.isHidden = true
                }
                
                coverCell.delegateCover0 = self
                coverCell.txtOther.delegate = self
                
                return coverCell
            } else if indexPath.row == 1 {
                let coverCell = tableView.dequeueReusableCell(withIdentifier: "Cover1Cell", for: indexPath) as! Cover1TableCell
                
                coverCell.lblHeader.text = "Automation: Is motor accessible for maintenance?"
                
                coverCell.btnUpload.addTarget(self, action: #selector(btnCoverUpload(_:)), for: UIControl.Event.touchUpInside)
                
                coverCell.collectionVw.arrItems = arrCoverMaintenanceImg
                coverCell.collectionVw.delegateItemCollection = self
                coverCell.collectionVw.reloadImageCollection()
                
                if arrCoverMaintenanceImg.count > 0 {
                    coverCell.btnUpload.isHidden = true
                    coverCell.collectionVw.isHidden = false
                } else {
                    coverCell.btnUpload.isHidden = false
                    coverCell.collectionVw.isHidden = true
                }
                
                coverCell.delegateCover1 = self
                coverCell.txtOther.delegate = self
                
                return coverCell
            } else if indexPath.row == 2 {
                let coverCell = tableView.dequeueReusableCell(withIdentifier: "Cover2Cell", for: indexPath) as! Cover2TableCell
                
                coverCell.lblHeader.text = "Automation: Is motor properly bonded?"
                
                coverCell.btnUpload.addTarget(self, action: #selector(btnCoverUpload(_:)), for: UIControl.Event.touchUpInside)
                
                coverCell.collectionVw.arrItems = arrCoverBondedImg
                coverCell.collectionVw.delegateItemCollection = self
                coverCell.collectionVw.reloadImageCollection()
                
                if arrCoverBondedImg.count > 0 {
                    coverCell.btnUpload.isHidden = true
                    coverCell.collectionVw.isHidden = false
                } else {
                    coverCell.btnUpload.isHidden = false
                    coverCell.collectionVw.isHidden = true
                }
                
                coverCell.delegateCover2 = self
                coverCell.txtOther.delegate = self
                
                return coverCell
            } else if indexPath.row == 3 {
                let coverCell = tableView.dequeueReusableCell(withIdentifier: "Cover3Cell", for: indexPath) as! Cover3TableCell
                
                coverCell.lblHeader.text = "Automation: Does cover switch have a lockout?"
                
                coverCell.btnUpload.addTarget(self, action: #selector(btnCoverUpload(_:)), for: UIControl.Event.touchUpInside)
                
                coverCell.collectionVw.arrItems = arrCoverLockoutImg
                coverCell.collectionVw.delegateItemCollection = self
                coverCell.collectionVw.reloadImageCollection()
                
                if arrCoverLockoutImg.count > 0 {
                    coverCell.btnUpload.isHidden = true
                    coverCell.collectionVw.isHidden = false
                } else {
                    coverCell.btnUpload.isHidden = false
                    coverCell.collectionVw.isHidden = true
                }
                
                coverCell.delegateCover3 = self
                coverCell.txtOther.delegate = self
                
                return coverCell
            } else if indexPath.row == 4 {
                let coverCell = tableView.dequeueReusableCell(withIdentifier: "Cover4Cell", for: indexPath) as! Cover4TableCell
                
                coverCell.lblHeader.text = "Ran automatic cover properly without any hang-ups?"
                
                coverCell.btnUpload.addTarget(self, action: #selector(btnCoverUpload(_:)), for: UIControl.Event.touchUpInside)
                
                coverCell.collectionVw.arrItems = arrCoverRanImg
                coverCell.collectionVw.delegateItemCollection = self
                coverCell.collectionVw.reloadImageCollection()
                
                if arrCoverRanImg.count > 0 {
                    coverCell.btnUpload.isHidden = true
                    coverCell.collectionVw.isHidden = false
                } else {
                    coverCell.btnUpload.isHidden = false
                    coverCell.collectionVw.isHidden = true
                }
                
                coverCell.delegateCover4 = self
                coverCell.txtOther.delegate = self
                
                return coverCell
            } else if indexPath.row == 5 {
                let coverCell = tableView.dequeueReusableCell(withIdentifier: "Cover5Cell", for: indexPath) as! Cover5TableCell
                
                coverCell.lblHeader.text = "Manual: Is cover reel present and in good condition?"
                
                coverCell.btnUpload.addTarget(self, action: #selector(btnCoverUpload(_:)), for: UIControl.Event.touchUpInside)
                
                coverCell.collectionVw.arrItems = arrCoverReelImg
                coverCell.collectionVw.delegateItemCollection = self
                coverCell.collectionVw.reloadImageCollection()
                
                if arrCoverReelImg.count > 0 {
                    coverCell.btnUpload.isHidden = true
                    coverCell.collectionVw.isHidden = false
                } else {
                    coverCell.btnUpload.isHidden = false
                    coverCell.collectionVw.isHidden = true
                }
                
                coverCell.delegateCover5 = self
                coverCell.txtOther.delegate = self
                
                return coverCell
            } else if indexPath.row == 6 {
                let coverCell = tableView.dequeueReusableCell(withIdentifier: "Cover6Cell", for: indexPath) as! Cover6TableCell
                
                coverCell.lblHeader.text = "Operated manual cover properly without any hang-ups?"
                
                coverCell.btnUpload.addTarget(self, action: #selector(btnCoverUpload(_:)), for: UIControl.Event.touchUpInside)
                
                coverCell.collectionVw.arrItems = arrCoverManualImg
                coverCell.collectionVw.delegateItemCollection = self
                coverCell.collectionVw.reloadImageCollection()
                
                if arrCoverManualImg.count > 0 {
                    coverCell.btnUpload.isHidden = true
                    coverCell.collectionVw.isHidden = false
                } else {
                    coverCell.btnUpload.isHidden = false
                    coverCell.collectionVw.isHidden = true
                }
                
                coverCell.delegateCover6 = self
                coverCell.txtOther.delegate = self
                
                return coverCell
            } else {
                let headerView : UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "CustomHeaderCell")!
                
                let lblHeaderTitle = headerView.viewWithTag(10) as! UILabel
                
                lblHeaderTitle.textColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.2352941176, alpha: 1)
                
                lblHeaderTitle.text = "List any safty issues with the cover:"  // set this however is appropriate for your app's model
                if UIDevice.current.userInterfaceIdiom == .phone {
                    lblHeaderTitle.font = UIFont.init(name: "Roboto-bold", size: 13.0)
                } else {
                    lblHeaderTitle.font = UIFont.init(name: "Roboto-bold", size: 24.0)
                }
                
                return headerView
            }
        } else {
            if indexPath.row == 0 {
                let cameraCell = tableView.dequeueReusableCell(withIdentifier: "CameraCell", for: indexPath) as! CameraTableCell
                
                cameraCell.lblHeader.text = "Fencing and child barriers"
                if UIDevice.current.userInterfaceIdiom == .phone {
                    cameraCell.lblHeader.font = UIFont.init(name: "Roboto-bold", size: 16.0)
                } else {
                    cameraCell.lblHeader.font = UIFont.init(name: "Roboto-bold", size: 24.0)
                }
                
                cameraCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                cameraCell.collectionVw.arrItems = arrFenceMainImg
                cameraCell.collectionVw.delegateItemCollection = self
                cameraCell.collectionVw.reloadImageCollection()
                
                if arrFenceMainImg.count > 0 {
                    cameraCell.btnUpload.isHidden = true
                    cameraCell.collectionVw.isHidden = false
                } else {
                    cameraCell.btnUpload.isHidden = false
                    cameraCell.collectionVw.isHidden = true
                }
                
                return cameraCell
            } else if indexPath.row == 1 {
                let headerView : UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "CustomHeaderCell")!
                
                let lblHeaderTitle = headerView.viewWithTag(10) as! UILabel
                
                lblHeaderTitle.textColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.2352941176, alpha: 1)
                
                lblHeaderTitle.text = "Due to accidents and injuries, inform custom that child proof barriers must be installed" // set this however is appropriate for your app's model
                if UIDevice.current.userInterfaceIdiom == .phone {
                    lblHeaderTitle.font = UIFont.init(name: "Roboto-bold", size: 13.0)
                } else {
                    lblHeaderTitle.font = UIFont.init(name: "Roboto-bold", size: 24.0)
                }
                lblHeaderTitle.numberOfLines = 2
                
                return headerView
            } else if indexPath.row == 2 {
                let fenceCell = tableView.dequeueReusableCell(withIdentifier: "Fence0Cell", for: indexPath) as! Fence0TableCell
                
                fenceCell.lblHeader.text = "Is perimeter fence present?"
                
                fenceCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                fenceCell.collectionVw.arrItems = arrFencePerimeterImg
                fenceCell.collectionVw.delegateItemCollection = self
                fenceCell.collectionVw.reloadImageCollection()
                
                if arrFencePerimeterImg.count > 0 {
                    fenceCell.btnUpload.isHidden = true
                    fenceCell.collectionVw.isHidden = false
                } else {
                    fenceCell.btnUpload.isHidden = false
                    fenceCell.collectionVw.isHidden = true
                }
                
                fenceCell.delegateFence0 = self
                fenceCell.txtOther.delegate = self
                
                return fenceCell
            } else if indexPath.row == 3 {
                let fenceCell = tableView.dequeueReusableCell(withIdentifier: "Fence1Cell", for: indexPath) as! Fence1TableCell
                
                fenceCell.lblHeader.text = "Is fence set to state and local height standards?"
                
                fenceCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                fenceCell.collectionVw.arrItems = arrFenceHeightImg
                fenceCell.collectionVw.delegateItemCollection = self
                fenceCell.collectionVw.reloadImageCollection()
                
                if arrFenceHeightImg.count > 0 {
                    fenceCell.btnUpload.isHidden = true
                    fenceCell.collectionVw.isHidden = false
                } else {
                    fenceCell.btnUpload.isHidden = false
                    fenceCell.collectionVw.isHidden = true
                }
                
                fenceCell.delegateFence1 = self
                fenceCell.txtOther.delegate =  self
                
                return fenceCell
            } else if indexPath.row == 4 {
                let fenceCell = tableView.dequeueReusableCell(withIdentifier: "Fence2Cell", for: indexPath) as! Fence2TableCell
                
                fenceCell.lblHeader.text = "Is there proper minimal spacing between slats? (Review federal, state and local standards?)"
                fenceCell.lblHeader.numberOfLines = 2
                
                fenceCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                fenceCell.collectionVw.arrItems = arrFenceMinimalImg
                fenceCell.collectionVw.delegateItemCollection = self
                fenceCell.collectionVw.reloadImageCollection()
                
                if arrFenceMinimalImg.count > 0 {
                    fenceCell.btnUpload.isHidden = true
                    fenceCell.collectionVw.isHidden = false
                } else {
                    fenceCell.btnUpload.isHidden = false
                    fenceCell.collectionVw.isHidden = true
                }
                
                fenceCell.delegateFence2 = self
                fenceCell.txtOther.delegate = self
                
                return fenceCell
            } else if indexPath.row == 5 {
                let headerView : UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "CustomHeaderCell")!
                
                let lblHeaderTitle = headerView.viewWithTag(10) as! UILabel
                
                lblHeaderTitle.textColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.2352941176, alpha: 1)
                
                lblHeaderTitle.text = "Always recommend child proof fencing"  // set this however is appropriate for your app's model
                if UIDevice.current.userInterfaceIdiom == .phone {
                    lblHeaderTitle.font = UIFont.init(name: "Roboto-bold", size: 16.0)
                } else {
                    lblHeaderTitle.font = UIFont.init(name: "Roboto-bold", size: 24.0)
                }
                
                return headerView
            } else if indexPath.row == 6 {
                let fenceCell = tableView.dequeueReusableCell(withIdentifier: "Fence3Cell", for: indexPath) as! Fence3TableCell
                
                fenceCell.lblHeader.text = "Is perimeter fence free of defects?"
                
                fenceCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                fenceCell.collectionVw.arrItems = arrFenceDefectsImg
                fenceCell.collectionVw.delegateItemCollection = self
                fenceCell.collectionVw.reloadImageCollection()
                
                if arrFenceDefectsImg.count > 0 {
                    fenceCell.btnUpload.isHidden = true
                    fenceCell.collectionVw.isHidden = false
                } else {
                    fenceCell.btnUpload.isHidden = false
                    fenceCell.collectionVw.isHidden = true
                }
                
                fenceCell.delegateFence3 = self
                fenceCell.txtOther.delegate = self
                
                return fenceCell
            } else if indexPath.row == 7 {
                let fenceCell = tableView.dequeueReusableCell(withIdentifier: "Fence4Cell", for: indexPath) as! Fence4TableCell
                
                fenceCell.lblHeader.text = "Are all gates self closing and self latching?"
                
                fenceCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                fenceCell.collectionVw.arrItems = arrFenceLatchingImg
                fenceCell.collectionVw.delegateItemCollection = self
                fenceCell.collectionVw.reloadImageCollection()
                
                if arrFenceLatchingImg.count > 0 {
                    fenceCell.btnUpload.isHidden = true
                    fenceCell.collectionVw.isHidden = false
                } else {
                    fenceCell.btnUpload.isHidden = false
                    fenceCell.collectionVw.isHidden = true
                }
                
                fenceCell.delegateFence4 = self
                fenceCell.txtOther.delegate = self
                
                return fenceCell
            } else if indexPath.row == 8 {
                let fenceCell = tableView.dequeueReusableCell(withIdentifier: "Fence5Cell", for: indexPath) as! Fence5TableCell
                
                fenceCell.lblHeader.text = "Are all gates free of defects?"
                
                fenceCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                fenceCell.collectionVw.arrItems = arrFenceGatesImg
                fenceCell.collectionVw.delegateItemCollection = self
                fenceCell.collectionVw.reloadImageCollection()
                
                if arrFenceGatesImg.count > 0 {
                    fenceCell.btnUpload.isHidden = true
                    fenceCell.collectionVw.isHidden = false
                } else {
                    fenceCell.btnUpload.isHidden = false
                    fenceCell.collectionVw.isHidden = true
                }
                
                fenceCell.delegateFence5 = self
                fenceCell.txtOther.delegate = self
                
                return fenceCell
            } else if indexPath.row == 9 {
                let fenceCell = tableView.dequeueReusableCell(withIdentifier: "Fence6Cell", for: indexPath) as! Fence6TableCell
                
                fenceCell.lblHeader.text = "Is a child proof barrier present and mounted properly? \n (Or signs of one formerly present)"
                
                fenceCell.lblHeader.numberOfLines = 2
                fenceCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                fenceCell.collectionVw.arrItems = arrFenceMountedImg
                fenceCell.collectionVw.delegateItemCollection = self
                fenceCell.collectionVw.reloadImageCollection()
                
                if arrFenceMountedImg.count > 0 {
                    fenceCell.btnUpload.isHidden = true
                    fenceCell.collectionVw.isHidden = false
                } else {
                    fenceCell.btnUpload.isHidden = false
                    fenceCell.collectionVw.isHidden = true
                }
                
                fenceCell.delegateFence6 = self
                fenceCell.txtOther.delegate = self
                
                return fenceCell
            } else if indexPath.row == 10 {
                let fenceCell = tableView.dequeueReusableCell(withIdentifier: "Fence7Cell", for: indexPath) as! Fence7TableCell
                
                fenceCell.lblHeader.text = "Does child proof barrier hva locking mechanisms? \n (This includes house/patio access)"
                
                fenceCell.lblHeader.numberOfLines = 2
                fenceCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                fenceCell.collectionVw.arrItems = arrFenceLockingImg
                fenceCell.collectionVw.delegateItemCollection = self
                fenceCell.collectionVw.reloadImageCollection()
                
                if arrFenceLockingImg.count > 0 {
                    fenceCell.btnUpload.isHidden = true
                    fenceCell.collectionVw.isHidden = false
                } else {
                    fenceCell.btnUpload.isHidden = false
                    fenceCell.collectionVw.isHidden = true
                }
                
                fenceCell.delegateFence7 = self
                fenceCell.txtOther.delegate = self
                
                return fenceCell
            } else if indexPath.row == 11 {
                let fenceCell = tableView.dequeueReusableCell(withIdentifier: "Fence8Cell", for: indexPath) as! Fence8TableCell
                
                fenceCell.lblHeader.text = "Is barrier is present but not installed, is it defect free?"
                
                fenceCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                fenceCell.collectionVw.arrItems = arrFenceInstalledImg
                fenceCell.collectionVw.delegateItemCollection = self
                fenceCell.collectionVw.reloadImageCollection()
                
                if arrFenceInstalledImg.count > 0 {
                    fenceCell.btnUpload.isHidden = true
                    fenceCell.collectionVw.isHidden = false
                } else {
                    fenceCell.btnUpload.isHidden = false
                    fenceCell.collectionVw.isHidden = true
                }
                
                fenceCell.delegateFence8 = self
                fenceCell.txtOther.delegate = self
                
                return fenceCell
            } else if indexPath.row == 12 {
                let fenceCell = tableView.dequeueReusableCell(withIdentifier: "Fence9Cell", for: indexPath) as! Fence9TableCell
                
                fenceCell.lblHeader.text = "Does barrier completely isolate pool and water features from house, yard or other entrances?"
                
                fenceCell.lblHeader.numberOfLines = 2
                fenceCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                fenceCell.collectionVw.arrItems = arrFenceIsolateImg
                fenceCell.collectionVw.delegateItemCollection = self
                fenceCell.collectionVw.reloadImageCollection()
                
                if arrFenceIsolateImg.count > 0 {
                    fenceCell.btnUpload.isHidden = true
                    fenceCell.collectionVw.isHidden = false
                } else {
                    fenceCell.btnUpload.isHidden = false
                    fenceCell.collectionVw.isHidden = true
                }
                
                fenceCell.delegateFence9 = self
                fenceCell.txtOther.delegate = self
                
                return fenceCell
            } else if indexPath.row == 13 {
                let headerView : UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "CustomHeaderCell")!
                
                let lblHeaderTitle = headerView.viewWithTag(10) as! UILabel
                
                lblHeaderTitle.textColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.2352941176, alpha: 1)
                
                lblHeaderTitle.text = "Covers"  // set this however is appropriate for your app's model
                if UIDevice.current.userInterfaceIdiom == .phone {
                    lblHeaderTitle.font = UIFont.init(name: "Roboto-bold", size: 16.0)
                } else {
                    lblHeaderTitle.font = UIFont.init(name: "Roboto-bold", size: 24.0)
                }
                
                return headerView
            } else if indexPath.row == 14 {
                let coverCell = tableView.dequeueReusableCell(withIdentifier: "CoverMainCell", for: indexPath) as! CoverMainTableCell
                
                coverCell.lblHeader.text = "Is a cover present for pool or spa?"
                if UIDevice.current.userInterfaceIdiom == .phone {
                    coverCell.lblHeader.font = UIFont.init(name: "Roboto-regular", size: 16.0)
                } else {
                    coverCell.lblHeader.font = UIFont.init(name: "Roboto-regular", size: 24.0)
                }
                
                coverCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                coverCell.collectionVw.arrItems = arrCoverMainImg
                coverCell.collectionVw.delegateItemCollection = self
                coverCell.collectionVw.reloadImageCollection()
                
                if arrCoverMainImg.count > 0 {
                    coverCell.btnUpload.isHidden = true
                    coverCell.collectionVw.isHidden = false
                } else {
                    coverCell.btnUpload.isHidden = false
                    coverCell.collectionVw.isHidden = true
                }
                
                if strCoverMainOpt == "Yes" {
                    coverCell.tblSubVw.delegate = self
                    coverCell.tblSubVw.dataSource = self
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        coverCell.tblHeightConstraint.constant = (355*7+45)
                    } else {
                        coverCell.tblHeightConstraint.constant = (600*7+95)
                    }
                    coverCell.tblSubVw.reloadData()
                } else {
                    coverCell.tblHeightConstraint.constant = 0
                }
                
                coverCell.delegateCoverMain = self
                coverCell.txtOther.delegate = self
                
                return coverCell
            } else {
                let cellBtn = tableView.dequeueReusableCell(withIdentifier: "NextCell", for: indexPath) as! NextForm1TableCell
                
                cellBtn.btnNext.addTarget(self, action: #selector(btnNextDidTap), for: UIControl.Event.touchUpInside)
                return cellBtn
            }
        }
    }

    //MARK:- UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .phone {
            if tableView.tag ==  25 {
                if indexPath.row == 7 {
                    return 45
                } else {
                    return 355
                }
            } else {
                if indexPath.row == 0 {
                    return 160
                } else if indexPath.row == 1 {
                    return 45
                } else if indexPath.row == 5 {
                    return 35
                } else if indexPath.row == 13 {
                    return 35
                } else if indexPath.row == 14 {
                    if strCoverMainOpt == "Yes" {
                        return (355*7+45)+355
                    } else {
                        return 355
                    }
                } else if indexPath.row == 15 {
                    return 105
                } else {
                    return 355
                }
            }
        } else {        //.pad
            if tableView.tag ==  25 {
                if indexPath.row == 7 {
                    return 125
                } else {
                    return 600
                }
            } else {
                if indexPath.row == 0 {
                    return 260
                } else if indexPath.row == 1 {
                    return 125
                } else if indexPath.row == 5 {
                    return 125
                } else if indexPath.row == 6 {
                    return 640
                } else if indexPath.row == 7 {
                    return 640
                } else if indexPath.row == 9 {
                    return 640
                } else if indexPath.row == 13 {
                    return 125
                } else if indexPath.row == 14 {
                    if strCoverMainOpt == "Yes" {
                        return (615*7+125)+615
                    } else {
                        return 615
                    }
                } else if indexPath.row == 15 {
                    return 175
                } else {
                    return 600
                }
            }
        }
    }
}

extension InspectFencingVC: Fence0Protocol, Fence1Protocol, Fence2Protocol, Fence3Protocol, Fence4Protocol, Fence5Protocol, Fence6Protocol, Fence7Protocol, Fence8Protocol, Fence9Protocol, CoverMainProtocol, Cover0Protocol, Cover1Protocol, Cover2Protocol, Cover3Protocol, Cover4Protocol, Cover5Protocol, Cover6Protocol {
    
    func didTapOnCellFence0(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strFencePerimeterOpt = "Yes"
        } else if _btnDescribeTag == 1 {
            strFencePerimeterOpt = "No"
        }
        self.tblFence.reloadData()
    }
    
    func didTapOnCellFence1(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strFenceHeightOpt = "Yes"
        } else if _btnDescribeTag == 1 {
            strFenceHeightOpt = "No"
        }
        self.tblFence.reloadData()
    }
    
    func didTapOnCellFence2(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strFenceMinimalOpt = "Yes"
        } else if _btnDescribeTag == 1 {
            strFenceMinimalOpt = "No"
        }
        self.tblFence.reloadData()
    }
    
    func didTapOnCellFence3(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strFenceDefectsOpt = "Yes"
        } else if _btnDescribeTag == 1 {
            strFenceDefectsOpt = "No"
        }
        self.tblFence.reloadData()
    }
    
    func didTapOnCellFence4(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strFenceLatchingOpt = "Yes"
        } else if _btnDescribeTag == 1 {
            strFenceLatchingOpt = "No"
        }
        self.tblFence.reloadData()
    }
    
    func didTapOnCellFence5(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strFenceGatesOpt = "Yes"
        } else if _btnDescribeTag == 1 {
            strFenceGatesOpt = "No"
        }
        self.tblFence.reloadData()
    }
    
    func didTapOnCellFence6(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strFenceMountedOpt = "Yes"
        } else if _btnDescribeTag == 1 {
            strFenceMountedOpt = "No"
        }
        self.tblFence.reloadData()
    }
    
    func didTapOnCellFence7(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strFenceLockingOpt = "Yes"
        } else if _btnDescribeTag == 1 {
            strFenceLockingOpt = "No"
        }
        self.tblFence.reloadData()
    }
    
    func didTapOnCellFence8(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strFenceInstalledOpt = "Yes"
        } else if _btnDescribeTag == 1 {
            strFenceInstalledOpt = "No"
        }
        self.tblFence.reloadData()
    }
    
    func didTapOnCellFence9(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strFenceIsolateOpt = "Yes"
        } else if _btnDescribeTag == 1 {
            strFenceIsolateOpt = "No"
        }
        self.tblFence.reloadData()
    }
    
    func didTapOnCellCoverMain(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strCoverMainOpt = "Yes"
        } else if _btnDescribeTag == 1 {
            strCoverMainOpt = "No"
        }
        self.tblFence.reloadData()
    }
    
    func didTapOnCellCover0(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strCoverMaterialOpt = "Yes"
        } else if _btnDescribeTag == 1 {
            strCoverMaterialOpt = "No"
        }
        self.tblFence.reloadData()
    }
    
    func didTapOnCellCover1(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strCoverMaintenanceOpt = "Yes"
        } else if _btnDescribeTag == 1 {
            strCoverMaintenanceOpt = "No"
        }
        self.tblFence.reloadData()
    }
    
    func didTapOnCellCover2(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strCoverBondedOpt = "Yes"
        } else if _btnDescribeTag == 1 {
            strCoverBondedOpt = "No"
        }
        self.tblFence.reloadData()
    }
    
    func didTapOnCellCover3(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strCoverLockoutOpt = "Yes"
        } else if _btnDescribeTag == 1 {
            strCoverLockoutOpt = "No"
        }
        self.tblFence.reloadData()
    }
    
    func didTapOnCellCover4(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strCoverRanOpt = "Yes"
        } else if _btnDescribeTag == 1 {
            strCoverRanOpt = "No"
        }
        self.tblFence.reloadData()
    }
    
    func didTapOnCellCover5(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strCoverReelOpt = "Yes"
        } else if _btnDescribeTag == 1 {
            strCoverReelOpt = "No"
        }
        self.tblFence.reloadData()
    }
    
    func didTapOnCellCover6(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strCoverManualOpt = "Yes"
        } else if _btnDescribeTag == 1 {
            strCoverManualOpt = "No"
        }
        self.tblFence.reloadData()
    }
}

