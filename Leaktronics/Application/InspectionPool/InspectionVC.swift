//
//  InspectionVC.swift
//  Leaktronics
//
//  Created by ivaninfotech on 4/14/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import CoreData
import DLRadioButton
import SVProgressHUD
import Alamofire
import Photos
import OpalImagePicker


class InspectionVC: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var tblInspect: UITableView!
    
    private var sectionIndex = -1
    private var selectedRowIndex = -1
    
    var secInspect = [formInspectionPoolData]()
    
    enum Inspect: Int {
        case WaterLevelHt = 2
        case MainDrain = 3
        case NearBy = 4
        case FloodRisk = 5
        case PoolLevel = 7
        case SpaLevel = 8
        case ConstructedSPA = 9
        case SurfaceMaterial = 10
        case Touch = 11
        case Struct = 13
    }
    
    var imagePicker = UIImagePickerController()
    var picker:UIImagePickerController? = UIImagePickerController()
    
    var fetchIndexForUpload = Int()
    
    //For Images
    var arrWaterFeatuesImg: [CollectionImageObject] = []
    var arrWaterConditionImg: [CollectionImageObject] = []
    var arrWaterLevelHeightImg: [CollectionImageObject] = []
    var arrDrainVisibleImg: [CollectionImageObject] = []
    var arrLowerPoolImg: [CollectionImageObject] = []
    var arrFloodRiskImg: [CollectionImageObject] = []
    var arrPoolSpaImg: [CollectionImageObject] = []
    var arrPoolLevelImg: [CollectionImageObject] = []
    var arrSpaLevelImg: [CollectionImageObject] = []
    var arrSpaConstructImg: [CollectionImageObject] = []
    var arrSpaMaterialImg: [CollectionImageObject] = []
    var arrSpaTouchImg: [CollectionImageObject] = []
    var arrSurfaceImg: [CollectionImageObject] = []
    var arrStructImg: [CollectionImageObject] = []
    
    
    //For Image Server path
    var strWaterFeatuesImg = String()
    var strWaterConditionImg = String()
    var strWaterLevelHeightImg = String()
    var strDrainVisibleImg = String()
    var strLowerPoolImg = String()
    var strFloodRiskImg = String()
    var strPoolSpaImg = String()
    var strPoolLevelImg = String()
    var strSpaLevelImg = String()
    var strSpaConstructImg = String()
    var strSpaMaterialImg = String()
    var strSpaTouchImg = String()
    var strSurfaceImg = String()
    var strStructImg = String()
    
    //For Image CoreData
    var dataWaterFeatuesImg = NSData()
    var dataWaterConditionImg = NSData()
    var dataWaterLevelHeightImg = NSData()
    var dataDrainVisibleImg = NSData()
    var dataLowerPoolImg = NSData()
    var dataFloodRiskImg = NSData()
    var dataPoolSpaImg = NSData()
    var dataPoolLevelImg = NSData()
    var dataSpaLevelImg = NSData()
    var dataSpaConstructImg = NSData()
    var dataSpaMaterialImg = NSData()
    var dataSpaTouchImg = NSData()
    var dataSurfaceImg = NSData()
    var dataStructImg = NSData()
    
    //For Optional Value
    var strWaterConditionOption = String()
    var strWaterLevelHtOption = String()
    var strDrainOption = String()
    var strNearByOption = String()
    var strRiskOption = String()
    var strPoolLevelOption = String()
    var strSpaLevelOption = String()
    var strConstructedSPAOption = String()
    var strSurfaceMaterialOption = String()
    var strTouchOption = String()
    var strSurfaceConditionOption = String()
    var strStructOption = String()
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.prepareFormInspectionData()
    }
    
    func prepareFormInspectionData() {
        for _ in 0..<14 {
            let obj = formInspectionPoolData()
            self.secInspect.append(obj)
        }
    }
    
//    @objc func deleteImage(_ sender: UIButton){
//        print("Button pressed 👍 ")
//
//        print(arrOfImages.count)
//        let deleteIndexPath = arrOfImages[sender.tag]
//        arrOfImages.remove(at: sender.tag)
//        print(deleteIndexPath)
//        print(self.arrOfImages.count)
//        if arrOfImages.count == 0 {
////            self.viewContainerForMoreUploadImage.isHidden = true
////            self.btnOutletUploadMoreImage.isHidden = true
////            self.btnOutletUploadImage.isEnabled = true
////            self.btnOutletUploadImage.isHidden = false
////            self.imgPostAds.alpha = 0
////            self.collectMorePostImg.isHidden = true
////            self.imgCamera.isHidden = false
//        }
//        self.tblInspect.reloadData()
//    }
    
    
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
        let indexOfCell = self.tblInspect.indexPath(for: cell)
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
        //self.postInspection()
        self.view.endEditing(true)
        if UIDevice.current.userInterfaceIdiom == .phone {
            let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
            let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectFittings") as! InspectFittingsVC
            self.navigationController?.pushViewController(formVC, animated: true)
        } else {
            let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
            let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectFittings") as! InspectFittingsVC
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
                    
                    managedObject.setValue(dataWaterFeatuesImg, forKey: "waterFeatuesImg")
                    managedObject.setValue(strWaterConditionOption, forKey: "waterConditionOption")
                    managedObject.setValue(dataWaterConditionImg, forKey: "waterConditionImg")
                    managedObject.setValue(strWaterLevelHtOption, forKey: "waterLevelHtOption")
                    managedObject.setValue(dataWaterLevelHeightImg, forKey: "waterLevelHeightImg")
                    managedObject.setValue(self.secInspect[Inspect.WaterLevelHt.rawValue].formTextValue, forKey: "waterLevelHtData")
                    managedObject.setValue(strDrainOption, forKey: "drainVisibleOption")
                    managedObject.setValue(dataDrainVisibleImg, forKey: "drainVisibleImg")
                    managedObject.setValue(self.secInspect[Inspect.MainDrain.rawValue].formTextValue, forKey: "mainDrainData")
                    managedObject.setValue(strNearByOption, forKey: "lowerPoolOption")
                    managedObject.setValue(dataLowerPoolImg, forKey: "lowerPoolImg")
                    managedObject.setValue(self.secInspect[Inspect.NearBy.rawValue].formTextValue, forKey: "nearByData")
                    managedObject.setValue(strRiskOption, forKey: "floodRiskOption")
                    managedObject.setValue(dataFloodRiskImg, forKey: "floodRiskImg")
                    managedObject.setValue(self.secInspect[Inspect.FloodRisk.rawValue].formTextValue, forKey: "floodRiskData")
                    managedObject.setValue(dataPoolSpaImg, forKey: "poolSpaImg")
                    managedObject.setValue(strPoolLevelOption, forKey: "poolLevelOption")
                    managedObject.setValue(dataPoolLevelImg, forKey: "poolLevelImg")
                    managedObject.setValue(self.secInspect[Inspect.PoolLevel.rawValue].formTextValue, forKey: "poolLevelData")
                    managedObject.setValue(strSpaLevelOption, forKey: "spaLevelOption")
                    managedObject.setValue(dataSpaLevelImg, forKey: "spaLevelImg")
                    managedObject.setValue(self.secInspect[Inspect.SpaLevel.rawValue].formTextValue, forKey: "spaLevelData")
                    managedObject.setValue(strConstructedSPAOption, forKey: "spaConstructOption")
                    managedObject.setValue(dataSpaConstructImg, forKey: "spaConstructImg")
                    managedObject.setValue(self.secInspect[Inspect.ConstructedSPA.rawValue].formTextValue, forKey: "constructedSPAData")
                    managedObject.setValue(strSurfaceMaterialOption, forKey: "spaMaterialOption")
                    managedObject.setValue(dataSpaMaterialImg, forKey: "spaMaterialImg")
                    managedObject.setValue(self.secInspect[Inspect.SurfaceMaterial.rawValue].formTextValue, forKey: "surfaceMaterialData")
                    managedObject.setValue(strTouchOption, forKey: "spaTouchOption")
                    managedObject.setValue(dataSpaTouchImg, forKey: "spaTouchImg")
                    managedObject.setValue(self.secInspect[Inspect.Touch.rawValue].formTextValue, forKey: "touchData")
                    managedObject.setValue(strSurfaceConditionOption, forKey: "surfaceOption")
                    managedObject.setValue(dataSurfaceImg, forKey: "surfaceImg")
                    managedObject.setValue(strStructOption, forKey: "structOption")
                    managedObject.setValue(dataStructImg, forKey: "structImg")
                    managedObject.setValue(self.secInspect[Inspect.Struct.rawValue].formTextValue, forKey: "structData")
                    
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
                        print("Data of InspectionVC:: \(data)")
                        print(NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true).last!);
                        //extract:
//                        if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: dataWaterFeatuesImg as Data) as? NSArray {
//                            //extract data..
//                            print(mySavedData)
//                        }
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
                        self.strWaterFeatuesImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 1 {
                        self.strWaterConditionImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 2 {
                        self.strWaterLevelHeightImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 3 {
                        self.strDrainVisibleImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 4 {
                        self.strLowerPoolImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 5 {
                        self.strFloodRiskImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 6 {
                        self.strPoolSpaImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 7 {
                        self.strPoolLevelImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 8 {
                        self.strSpaLevelImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 9 {
                        self.strSpaConstructImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 10 {
                        self.strSpaMaterialImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 11 {
                        self.strSpaTouchImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 12 {
                        self.strSurfaceImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 13 {
                        self.strStructImg = String(describing: data!)
                    }
                    
                    SVProgressHUD.dismiss()
                }
            case .failure(let encodingError):
                print("error:\(encodingError)")
                SVProgressHUD.dismiss()
            }
        })
    }
    
    func postInspection() {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        
        let return_id = UserDefaults.standard.value(forKey: "returnKeyForInspection")
        
        let inspectDetails:  NSMutableDictionary = [
            "return_data_id"        : return_id!,
            "waterFeatuesImg"       : strWaterFeatuesImg,
            "waterConditionOption"  : strWaterConditionOption,
            "waterConditionImg"     : strWaterConditionImg,
            "waterLevelHtOption"    : strWaterLevelHtOption,
            "waterLevelHeightImg"   : strWaterLevelHeightImg,
            "waterLevelHtData"      : self.secInspect[Inspect.WaterLevelHt.rawValue].formTextValue,
            "drainVisibleOption"    : strDrainOption,
            "drainVisibleImg"       : strDrainVisibleImg,
            "mainDrainData"         : self.secInspect[Inspect.MainDrain.rawValue].formTextValue,
            "lowerPoolOption"       : strNearByOption,
            "lowerPoolImg"          : strLowerPoolImg,
            "nearByData"            : self.secInspect[Inspect.NearBy.rawValue].formTextValue,
            "floodRiskOption"       : strRiskOption,
            "floodRiskImg"          : strFloodRiskImg,
            "floodRiskData"         : self.secInspect[Inspect.FloodRisk.rawValue].formTextValue,
            "poolSpaImg"            : strPoolSpaImg,
            "poolLevelOption"       : strPoolLevelOption,
            "poolLevelImg"          : strPoolLevelImg,
            "poolLevelData"         : self.secInspect[Inspect.PoolLevel.rawValue].formTextValue,
            "spaLevelOption"        : strSpaLevelOption,
            "spaLevelImg"           : strSpaLevelImg,
            "spaLevelData"          : self.secInspect[Inspect.SpaLevel.rawValue].formTextValue,
            "spaConstructOption"    : strConstructedSPAOption,
            "spaConstructImg"       : strSpaConstructImg,
            "constructedSPAData"    : self.secInspect[Inspect.ConstructedSPA.rawValue].formTextValue,
            "spaMaterialOption"     : strSurfaceMaterialOption,
            "spaMaterialImg"        : strSpaMaterialImg,
            "surfaceMaterialData"   : self.secInspect[Inspect.SurfaceMaterial.rawValue].formTextValue,
            "spaTouchOption"        : strTouchOption,
            "spaTouchImg"           : strSpaTouchImg,
            "touchData"             : self.secInspect[Inspect.Touch.rawValue].formTextValue,
            "surfaceOption"         : strSurfaceConditionOption,
            "surfaceImg"            : strSurfaceImg,
            "structOption"          : strStructOption,
            "structImg"             : strStructImg,
            "structData"            : self.secInspect[Inspect.Struct.rawValue].formTextValue,
        ]

        print("inspectDetails :: \(inspectDetails)")
        
        //if sharedExtension.connectedToNetwork() {
        ApiManager.sharedInstanceAPI.PostInspection(postId: 1, inspectDetails: inspectDetails, onSuccess: { json in
            DispatchQueue.main.async {
                print("InspectionDetails json :: \(String(describing: json))")
                DispatchQueue.main.async(execute: {() -> Void in
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectFittings") as! InspectFittingsVC
                        self.navigationController?.pushViewController(formVC, animated: true)
                    } else {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectFittings") as! InspectFittingsVC
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

extension InspectionVC: UploadCollectionProtocol {
    func didTapOnCellItem(_indexpath: IndexPath, _imgUrl: String, _videoUrl: String) {
        
    }
    
    func didUpdateCellIndex(_indexpath: Int) {
        
    }
}
extension InspectionVC: OpalImagePickerControllerDelegate {
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
                                self.arrWaterFeatuesImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataWaterFeatuesImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 1 {
                                self.arrWaterConditionImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataWaterConditionImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 2 {
                                self.arrWaterLevelHeightImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataWaterLevelHeightImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 3 {
                                self.arrDrainVisibleImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataDrainVisibleImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 4 {
                                self.arrLowerPoolImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataLowerPoolImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 5 {
                                self.arrFloodRiskImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataFloodRiskImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 6 {
                                self.arrPoolSpaImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataPoolSpaImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 7 {
                                self.arrPoolLevelImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataPoolLevelImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 8 {
                                self.arrSpaLevelImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSpaLevelImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 9 {
                                self.arrSpaConstructImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSpaConstructImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 10 {
                                self.arrSpaMaterialImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSpaMaterialImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 11 {
                                self.arrSpaTouchImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSpaTouchImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 12 {
                                self.arrSurfaceImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSurfaceImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 13 {
                                self.arrStructImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataStructImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
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
                self.tblInspect.reloadData()
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

extension InspectionVC: UIImagePickerControllerDelegate {
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
            self.arrWaterFeatuesImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataWaterFeatuesImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForUpload == 1 {
            self.arrWaterConditionImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataWaterConditionImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForUpload == 2 {
            self.arrWaterLevelHeightImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataWaterLevelHeightImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForUpload == 3 {
            self.arrDrainVisibleImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataDrainVisibleImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForUpload == 4 {
            self.arrLowerPoolImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataLowerPoolImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForUpload == 5 {
            self.arrFloodRiskImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataFloodRiskImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForUpload == 6 {
            self.arrPoolSpaImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataPoolSpaImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForUpload == 7 {
            self.arrPoolLevelImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataPoolLevelImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForUpload == 8 {
            self.arrSpaLevelImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSpaLevelImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForUpload == 9 {
            self.arrSpaConstructImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSpaConstructImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForUpload == 10 {
            self.arrSpaMaterialImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSpaMaterialImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForUpload == 11 {
            self.arrSpaTouchImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSpaTouchImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForUpload == 12 {
            self.arrSurfaceImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSurfaceImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForUpload == 13 {
            self.arrStructImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataStructImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        }
        self.tblInspect.reloadData()
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
}

extension InspectionVC: UITextViewDelegate {
    @objc func updateInspectTextViewValue() {
        let cell = self.tblInspect.cellForRow(at: IndexPath.init(row: self.selectedRowIndex, section: self.sectionIndex))
        guard let _cell = cell else { return  }
        
        if selectedRowIndex == 2 {
            if let addressTblCell = _cell as? WaterLevelHtTableCell {
                if let textView = addressTblCell.txtOther {
                    self.secInspect[self.selectedRowIndex].formTextValue = (textView.text)!
                }
            }
        } else if selectedRowIndex == 3 {
            if let addressTblCell = _cell as? MainDrainTableCell {
                if let textView = addressTblCell.txtOther {
                    self.secInspect[self.selectedRowIndex].formTextValue = (textView.text)!
                }
            }
        } else if selectedRowIndex == 4 {
            if let addressTblCell = _cell as? NearByTableCell {
                if let textView = addressTblCell.txtOther {
                    self.secInspect[self.selectedRowIndex].formTextValue = (textView.text)!
                }
            }
        } else if selectedRowIndex == 5 {
            if let addressTblCell = _cell as? RiskTableCell {
                if let textView = addressTblCell.txtOther {
                    self.secInspect[self.selectedRowIndex].formTextValue = (textView.text)!
                }
            }
        } else if selectedRowIndex == 7 {
            if let addressTblCell = _cell as? PoolLevelTableCell {
                if let textView = addressTblCell.txtOther {
                    self.secInspect[self.selectedRowIndex].formTextValue = (textView.text)!
                }
            }
        } else if selectedRowIndex == 8 {
            if let addressTblCell = _cell as? SpaLevelTableCell {
                if let textView = addressTblCell.txtOther {
                    self.secInspect[self.selectedRowIndex].formTextValue = (textView.text)!
                }
            }
        } else if selectedRowIndex == 9 {
            if let addressTblCell = _cell as? ConstructedSPATableCell {
                if let textView = addressTblCell.txtOther {
                    self.secInspect[self.selectedRowIndex].formTextValue = (textView.text)!
                }
            }
        } else if selectedRowIndex == 10 {
            if let addressTblCell = _cell as? SurfaceMaterialTableCell {
                if let textView = addressTblCell.txtOther {
                    self.secInspect[self.selectedRowIndex].formTextValue = (textView.text)!
                }
            }
        } else if selectedRowIndex == 11 {
            if let addressTblCell = _cell as? TouchTableCell {
                if let textView = addressTblCell.txtOther {
                    self.secInspect[self.selectedRowIndex].formTextValue = (textView.text)!
                }
            }
        } else if selectedRowIndex == 13 {
            if let addressTblCell = _cell as? StructuralTableCell {
                if let textView = addressTblCell.txtOther {
                    self.secInspect[self.selectedRowIndex].formTextValue = (textView.text)!
                }
            }
        }
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        let cell = (textView.superview?.superview as? UITableViewCell)!
        
        let indexpath = self.tblInspect.indexPath(for: cell)
        guard let _indexPath = indexpath else { return false }
        self.selectedRowIndex = _indexPath.row
        self.sectionIndex = _indexPath.section
        
        self.perform(#selector(InspectionVC.updateInspectTextViewValue), with: nil, afterDelay: 1)
        
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let cell = (textView.superview?.superview as? UITableViewCell)!
        
        let indexpath = self.tblInspect.indexPath(for: cell)
        guard let _indexPath = indexpath else { return false }
        self.selectedRowIndex = _indexPath.row
        self.sectionIndex = _indexPath.section
        
        self.perform(#selector(InspectionVC.updateInspectTextViewValue), with: nil, afterDelay: 1)
        
        return true
    }
}


extension InspectionVC: UITableViewDataSource, UITableViewDelegate {
    //MARK:- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cameraCell = tableView.dequeueReusableCell(withIdentifier: "CameraCell", for: indexPath) as! CameraTableCell
            
            cameraCell.lblHeader.text = "Pic of Pool, Spa, Waterfeature, etc."
            cameraCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

            cameraCell.collectionVw.arrItems = arrWaterFeatuesImg
            cameraCell.collectionVw.delegateItemCollection = self
            cameraCell.collectionVw.reloadImageCollection()
            
            if arrWaterFeatuesImg.count > 0 {
                cameraCell.btnUpload.isHidden = true
                cameraCell.collectionVw.isHidden = false
            } else {
                cameraCell.btnUpload.isHidden = false
                cameraCell.collectionVw.isHidden = true
            }
            
            return cameraCell
        } else if indexPath.row == 1 {
            let heightCell = tableView.dequeueReusableCell(withIdentifier: "WaterConditionCell", for: indexPath) as! WaterConditionTableCell
            
            heightCell.lblHeader.text = "What is the condition of the water?"
            
            heightCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            
            heightCell.collectionVw.arrItems = arrWaterConditionImg
            heightCell.collectionVw.delegateItemCollection = self
            heightCell.collectionVw.reloadImageCollection()
            
            if arrWaterConditionImg.count > 0 {
                heightCell.btnUpload.isHidden = true
                heightCell.collectionVw.isHidden = false
            } else {
                heightCell.btnUpload.isHidden = false
                heightCell.collectionVw.isHidden = true
            }
            
            heightCell.delegateWaterCondition = self
            
            return heightCell
        } else if indexPath.row == 2 {
            let levelCell = tableView.dequeueReusableCell(withIdentifier: "WaterLevelHtCell", for: indexPath) as! WaterLevelHtTableCell
            
            levelCell.lblHeader.text = "Is the water level at the proper height?"
            
            levelCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

            levelCell.collectionVw.arrItems = arrWaterLevelHeightImg
            levelCell.collectionVw.delegateItemCollection = self
            levelCell.collectionVw.reloadImageCollection()
            
            if arrWaterLevelHeightImg.count > 0 {
                levelCell.btnUpload.isHidden = true
                levelCell.collectionVw.isHidden = false
            } else {
                levelCell.btnUpload.isHidden = false
                levelCell.collectionVw.isHidden = true
            }
            
            levelCell.delegateWaterLevelHt = self
            levelCell.txtOther.delegate = self
            
            return levelCell
        } else if indexPath.row == 3 {
            let drainCell = tableView.dequeueReusableCell(withIdentifier: "MainDrainCell", for: indexPath) as! MainDrainTableCell
            
            drainCell.lblHeader.text = "Are main drains visible?"
            
            drainCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            
            drainCell.collectionVw.arrItems = arrDrainVisibleImg
            drainCell.collectionVw.delegateItemCollection = self
            drainCell.collectionVw.reloadImageCollection()
            
            if arrDrainVisibleImg.count > 0 {
                drainCell.btnUpload.isHidden = true
                drainCell.collectionVw.isHidden = false
            } else {
                drainCell.btnUpload.isHidden = false
                drainCell.collectionVw.isHidden = true
            }
            
            drainCell.delegateDrain = self
            drainCell.txtOther.delegate = self
            
            return drainCell
        } else if indexPath.row == 4 {
            let nearCell = tableView.dequeueReusableCell(withIdentifier: "NearByCell", for: indexPath) as! NearByTableCell
            
            nearCell.lblHeader.text = "Is the house or a nearby structure lower than the pool?"
            
            nearCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            
            nearCell.collectionVw.arrItems = arrLowerPoolImg
            nearCell.collectionVw.delegateItemCollection = self
            nearCell.collectionVw.reloadImageCollection()
            
            if arrLowerPoolImg.count > 0 {
                nearCell.btnUpload.isHidden = true
                nearCell.collectionVw.isHidden = false
            } else {
                nearCell.btnUpload.isHidden = false
                nearCell.collectionVw.isHidden = true
            }
            
            nearCell.delegateNearBy = self
            nearCell.txtOther.delegate = self
            
            return nearCell
        } else if indexPath.row == 5 {
            let optionCell = tableView.dequeueReusableCell(withIdentifier: "RiskCell", for: indexPath) as! RiskTableCell
            
            optionCell.lblHeader.text = "Do the surrounding structues have a risk of flooding?"
            
            optionCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            
            optionCell.collectionVw.arrItems = arrFloodRiskImg
            optionCell.collectionVw.delegateItemCollection = self
            optionCell.collectionVw.reloadImageCollection()
            
            if arrFloodRiskImg.count > 0 {
                optionCell.btnUpload.isHidden = true
                optionCell.collectionVw.isHidden = false
            } else {
                optionCell.btnUpload.isHidden = false
                optionCell.collectionVw.isHidden = true
            }
            
            optionCell.delegateRisk = self
            optionCell.txtOther.delegate = self
            
            return optionCell
        } else  if indexPath.row == 6 {
            let cameraCell = tableView.dequeueReusableCell(withIdentifier: "CameraCell", for: indexPath) as! CameraTableCell
            
            cameraCell.lblHeader.text = "The following relates to a pool spa combo. For a separate or portable spa, use the separate section titled portable spa."
            
            cameraCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            
            cameraCell.collectionVw.arrItems = arrPoolSpaImg
            cameraCell.collectionVw.delegateItemCollection = self
            cameraCell.collectionVw.reloadImageCollection()
            
            if arrPoolSpaImg.count > 0 {
                cameraCell.btnUpload.isHidden = true
                cameraCell.collectionVw.isHidden = false
            } else {
                cameraCell.btnUpload.isHidden = false
                cameraCell.collectionVw.isHidden = true
            }
            
            return cameraCell
        } else if indexPath.row == 7 {
            let optionCell = tableView.dequeueReusableCell(withIdentifier: "PoolLevelCell", for: indexPath) as! PoolLevelTableCell
            
            optionCell.lblHeader.text = "Is the pool level?"
            
            optionCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            
            optionCell.collectionVw.arrItems = arrPoolLevelImg
            optionCell.collectionVw.delegateItemCollection = self
            optionCell.collectionVw.reloadImageCollection()
            if arrPoolLevelImg.count > 0 {
                optionCell.btnUpload.isHidden = true
                optionCell.collectionVw.isHidden = false
            } else {
                optionCell.btnUpload.isHidden = false
                optionCell.collectionVw.isHidden = true
            }
            
            optionCell.delegatePoolLevel = self
            optionCell.txtOther.delegate = self
            
            return optionCell
        } else if indexPath.row == 8 {
            let optionCell = tableView.dequeueReusableCell(withIdentifier: "SpaLevelCell", for: indexPath) as! SpaLevelTableCell
            
            optionCell.lblHeader.text = "Is the SPA level?"
            
            optionCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            
            optionCell.collectionVw.arrItems = arrSpaLevelImg
            optionCell.collectionVw.delegateItemCollection = self
            optionCell.collectionVw.reloadImageCollection()
            
            if arrSpaLevelImg.count > 0 {
                optionCell.btnUpload.isHidden = true
                optionCell.collectionVw.isHidden = false
            } else {
                optionCell.btnUpload.isHidden = false
                optionCell.collectionVw.isHidden = true
            }
            
            optionCell.delegateSpaLevel = self
            optionCell.txtOther.delegate = self
            
            return optionCell
        } else if indexPath.row == 9 {
            let constructeCell = tableView.dequeueReusableCell(withIdentifier: "ConstructedSPACell", for: indexPath) as! ConstructedSPATableCell
            
            constructeCell.lblHeader.text = "What is the pool/SPA constructed of the?"
            
            constructeCell.lbl1.text = "Vinyl below ground"
            constructeCell.lbl2.text = "Vinyl above ground"
            constructeCell.lbl3.text = "Fiberglass"
            constructeCell.lbl4.text = "Concrete/Gunite below ground"
            constructeCell.lbl5.text = "Concrete/Gunite above ground"
            constructeCell.lbl6.text = "Stainless"
            constructeCell.lbl7.text = "Other, Describe"
            
            constructeCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            
            constructeCell.collectionVw.arrItems = arrSpaConstructImg
            constructeCell.collectionVw.delegateItemCollection = self
            constructeCell.collectionVw.reloadImageCollection()
            
            if arrSpaConstructImg.count > 0 {
                constructeCell.btnUpload.isHidden = true
                constructeCell.collectionVw.isHidden = false
            } else {
                constructeCell.btnUpload.isHidden = false
                constructeCell.collectionVw.isHidden = true
            }
            
            constructeCell.delegateConstructedSPA = self
            constructeCell.txtOther.delegate = self
            
            return constructeCell
        } else if indexPath.row == 10 {
            let materialCell = tableView.dequeueReusableCell(withIdentifier: "SurfaceMaterialCell", for: indexPath) as! SurfaceMaterialTableCell
            
            materialCell.lblHeader.text = "What is the pool/SPA Surface material made of the?"
            
            materialCell.lbl1.text = "Plaster"
            materialCell.lbl2.text = "Pebble finish"
            materialCell.lbl3.text = "Tile"
            materialCell.lbl4.text = "Fiberglass"
            materialCell.lbl5.text = "Vinyl"
            materialCell.lbl6.text = "Painted"
            materialCell.lbl7.text = "Other, Describe"
            
            materialCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            
            materialCell.collectionVw.arrItems = arrSpaMaterialImg
            materialCell.collectionVw.delegateItemCollection = self
            materialCell.collectionVw.reloadImageCollection()
            
            if arrSpaMaterialImg.count > 0 {
                materialCell.btnUpload.isHidden = true
                materialCell.collectionVw.isHidden = false
            } else {
                materialCell.btnUpload.isHidden = false
                materialCell.collectionVw.isHidden = true
            }
            
            materialCell.delegateSurfaceMaterial = self
            materialCell.txtOther.delegate = self
            
            return materialCell
        } else if indexPath.row == 11 {
            let touchCell = tableView.dequeueReusableCell(withIdentifier: "TouchCell", for: indexPath) as! TouchTableCell
            
            touchCell.lblHeader.text = "Is the surface of the pool/SPA rough to the touch?"
             
            touchCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            
            touchCell.collectionVw.arrItems = arrSpaTouchImg
            touchCell.collectionVw.delegateItemCollection = self
            touchCell.collectionVw.reloadImageCollection()
            
            if arrSpaTouchImg.count > 0 {
                touchCell.btnUpload.isHidden = true
                touchCell.collectionVw.isHidden = false
            } else {
                touchCell.btnUpload.isHidden = false
                touchCell.collectionVw.isHidden = true
            }
            
            touchCell.delegateTouch = self
            touchCell.txtOther.delegate = self
            
            return touchCell
        } else if indexPath.row == 12 {
            let conditionCell = tableView.dequeueReusableCell(withIdentifier: "SurfaceConditionCell", for: indexPath) as! SurfaceConditionTableCell
            
            conditionCell.lblHeader.text = "The Surface condition is:"

            conditionCell.lbl1.text = "Good"
            conditionCell.lbl2.text = "Rust Showing"
            conditionCell.lbl3.text = "Gunite Showing"
            conditionCell.lbl4.text = "Delaminated"
            conditionCell.lbl5.text = "Mottled"
            conditionCell.lbl6.text = "Vinyl bowed, Torn or Stretching"
            conditionCell.lbl7.text = "Painted Peelimg"
            conditionCell.lbl8.text = "Stained"
            conditionCell.lbl9.text = "Shrink Cracking"
            
            conditionCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            
            conditionCell.collectionVw.arrItems = arrSurfaceImg
            conditionCell.collectionVw.delegateItemCollection = self
            conditionCell.collectionVw.reloadImageCollection()
            
            if arrSurfaceImg.count > 0 {
                conditionCell.btnUpload.isHidden = true
                conditionCell.collectionVw.isHidden = false
            } else {
                conditionCell.btnUpload.isHidden = false
                conditionCell.collectionVw.isHidden = true
            }
            
            conditionCell.delegateSurfaceCondition = self
            
            return conditionCell
        } else if indexPath.row == 13 {
            let structCell = tableView.dequeueReusableCell(withIdentifier: "StructuralCell", for: indexPath) as! StructuralTableCell
            structCell.lblHeader.text = "Are there any structural cracks in bond beam or structure?"
            
            structCell.lblNotes.text = "Approximate linear footage of noted cracks"
            
            structCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            
            structCell.collectionVw.arrItems = arrStructImg
            structCell.collectionVw.delegateItemCollection = self
            structCell.collectionVw.reloadImageCollection()
            
            if arrStructImg.count > 0 {
                structCell.btnUpload.isHidden = true
                structCell.collectionVw.isHidden = false
            } else {
                structCell.btnUpload.isHidden = false
                structCell.collectionVw.isHidden = true
            }
            
            structCell.delegateStructural = self
            structCell.txtOther.delegate = self
            
            return structCell
        } else {//} if indexPath.row == 14 {
            let cellBtn = tableView.dequeueReusableCell(withIdentifier: "NextCell", for: indexPath) as! NextForm1TableCell
            
            cellBtn.btnNext.addTarget(self, action: #selector(btnNextDidTap), for: UIControl.Event.touchUpInside)
            return cellBtn
        }
    }
    
    //MARK:- UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .phone {
            if indexPath.row == 0 {
                return 185
            } else if indexPath.row == 1 {
                return 285
            } else if indexPath.row == 6 {
                return 185
            } else if indexPath.row == 9 {
                return 500
            } else if indexPath.row == 10 {
                return 500
            } else if indexPath.row == 12 {
                return 450
            } else if indexPath.row == 13 {
                return 410
            } else if indexPath.row == 14 {
                return 105
            } else {
                return 365
            }
        } else {        //.pad
            if indexPath.row == 0 {
                return 370
            } else if indexPath.row == 1 {
                return 576
            } else if indexPath.row == 6 {
                return 370
            } else if indexPath.row == 9 {
                return 760
            } else if indexPath.row == 10 {
                return 760
            } else if indexPath.row == 12 {
                return 620
            } else if indexPath.row == 13 {
                return 576
            } else if indexPath.row == 14 {
                return 175
            } else {
                return 600
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            // get a reference to our storyboard cell
            let headerView : UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "CustomHeaderCell")!
            
            let lblHeaderTitle = headerView.viewWithTag(10) as! UILabel
            
            lblHeaderTitle.textColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.2352941176, alpha: 1)
            
            lblHeaderTitle.text = "Inspection"  // set this however is appropriate for your app's model
            
            return headerView
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .phone {
            if section == 0 {
                return 45
            } else {
                return 1
            }
        } else {
            if section == 0 {
                return 75
            } else {
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
}

extension InspectionVC: WaterConditionCellProtocol, WaterLevelHtCellProtocol, DrainCellProtocol, NearByCellProtocol, RiskCellProtocol, PoolLevelCellProtocol, SpaLevelCellProtocol, ConstructedSPACellProtocol, SurfaceMaterialCellProtocol, TouchCellProtocol, SurfaceConditionCellProtocol, StructuralProtocol {
    func didTapOnCellWaterCondition(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
           strWaterConditionOption = "Clear"
        } else if _btnDescribeTag == 1 {
           strWaterConditionOption = "Cloudy"
        } else if _btnDescribeTag == 2 {
           strWaterConditionOption = "Murky"
        } else if _btnDescribeTag == 3 {
           strWaterConditionOption = "Green Algae"
        }
        self.tblInspect.reloadData()
    }
    
    func didTapOnCellWaterLevelHt(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
           strWaterLevelHtOption = "Yes"
        } else if _btnDescribeTag == 1 {
           strWaterLevelHtOption = "No"
        }
        self.tblInspect.reloadData()
    }
    
    func didTapOnCellDrain(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
           strDrainOption = "Yes"
        } else if _btnDescribeTag == 1 {
           strDrainOption = "No"
        }
        self.tblInspect.reloadData()
    }
    
    func didTapOnCellNearBy(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
           strNearByOption = "Yes"
        } else if _btnDescribeTag == 1 {
           strNearByOption = "No"
        }
        self.tblInspect.reloadData()
    }
    
    func didTapOnCellRisk(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
           strRiskOption = "Yes"
        } else if _btnDescribeTag == 1 {
           strRiskOption = "No"
        }
        self.tblInspect.reloadData()
    }
    
    func didTapOnCellPoolLevel(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
           strPoolLevelOption = "Yes"
        } else if _btnDescribeTag == 1 {
           strPoolLevelOption = "No"
        }
        self.tblInspect.reloadData()
    }
    
    func didTapOnCellSpaLevel(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
           strSpaLevelOption = "Yes"
        } else if _btnDescribeTag == 1 {
           strSpaLevelOption = "No"
        }
        self.tblInspect.reloadData()
    }
    
    func didTapOnCellConstructedSPA(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
           strConstructedSPAOption = "Vinyl below ground"
        } else if _btnDescribeTag == 1 {
           strConstructedSPAOption = "Vinyl above ground"
        } else if _btnDescribeTag == 2 {
           strConstructedSPAOption = "Fiberglass"
        } else if _btnDescribeTag == 3 {
           strConstructedSPAOption = "Concrete/Gunite below ground"
        } else if _btnDescribeTag == 4 {
           strConstructedSPAOption = "Concrete/Gunite above ground"
        } else if _btnDescribeTag == 5 {
           strConstructedSPAOption = "Stainless"
        } else if _btnDescribeTag == 6 {
           strConstructedSPAOption = "Other, Describe"
        }
        self.tblInspect.reloadData()
    }
    
    func didTapOnCellSurfaceMaterial(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
           strSurfaceMaterialOption = "Plaster"
        } else if _btnDescribeTag == 1 {
           strSurfaceMaterialOption = "Pebble finish"
        } else if _btnDescribeTag == 2 {
           strSurfaceMaterialOption = "Tile"
        } else if _btnDescribeTag == 3 {
           strSurfaceMaterialOption = "Fiberglass"
        } else if _btnDescribeTag == 4 {
           strSurfaceMaterialOption = "Vinyl"
        } else if _btnDescribeTag == 5 {
           strSurfaceMaterialOption = "Painted"
        } else if _btnDescribeTag == 6 {
           strSurfaceMaterialOption = "Other, Describe"
        }
        self.tblInspect.reloadData()
    }
    
    func didTapOnCellTouch(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
           strTouchOption = "Yes"
        } else if _btnDescribeTag == 1 {
           strTouchOption = "No"
        }
        self.tblInspect.reloadData()
    }
    
    func didTapOnCellSurfaceCondition(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
           strSurfaceConditionOption = "Good"
        } else if _btnDescribeTag == 1 {
           strSurfaceConditionOption = "Rust Showing"
        } else if _btnDescribeTag == 2 {
           strSurfaceConditionOption = "Gunite Showing"
        } else if _btnDescribeTag == 3 {
           strSurfaceConditionOption = "Delaminated"
        } else if _btnDescribeTag == 4 {
           strSurfaceConditionOption = "Mottled"
        } else if _btnDescribeTag == 5 {
           strSurfaceConditionOption = "Vinyl bowed, Torn or Stretching"
        } else if _btnDescribeTag == 6 {
           strSurfaceConditionOption = "Painted Peelimg"
        } else if _btnDescribeTag == 7 {
           strSurfaceConditionOption = "Stained"
        } else if _btnDescribeTag == 9 {
           strSurfaceConditionOption = "Shrink Cracking"
        }
        self.tblInspect.reloadData()
    }
    
    func didTapOnCellStructural(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
           strStructOption = "Yes"
        } else if _btnDescribeTag == 1 {
           strStructOption = "No"
        }
        self.tblInspect.reloadData()
    }
    
}
