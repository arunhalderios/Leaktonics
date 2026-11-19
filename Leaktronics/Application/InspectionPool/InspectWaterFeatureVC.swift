//
//  InspectWaterFeatureVC.swift
//  Leaktronics
//
//  Created by Abhishek Mullick on 05/05/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import CoreData
import DLRadioButton
import SVProgressHUD
import Alamofire
import Photos
import OpalImagePicker

class InspectWaterFeatureVC: UIViewController, UINavigationControllerDelegate, UploadCollectionProtocol {

    @IBOutlet weak var tblInspectionWaterFeature: UITableView!
    
    var secWaterFeature = [formInspectionPoolData]()
    var secSubFeature = [formInspectionPoolData]()
    
    var fetchIndexForUpload: Int = -1
    var fetchIndexForSubFeatureUpload: Int = -1
    
    var imagePicker = UIImagePickerController()
    var picker:UIImagePickerController? = UIImagePickerController()
    
    var mainDrainImageButtonIndex: Int = -1
    
    //For Images
    var arrMainWaterFeatureImg: [CollectionImageObject] = []
    var arrWaterFeatureImg: [CollectionImageObject] = []
    var arrMainDivingImg: [CollectionImageObject] = []
    var arrDivingPresentImg: [CollectionImageObject] = []
    var arrSidesPresentImg: [CollectionImageObject] = []
    var arrMainDrainImg: [CollectionImageObject] = []
    var arrPoolImg: [CollectionImageObject] = []
    var arrSpaImg: [CollectionImageObject] = []
    var arrBasinWaterImg: [CollectionImageObject] = []
    var arrFeatureImg: [CollectionImageObject] = []
    var arrDrainWaterImg: [CollectionImageObject] = []
    var arrSplitImg: [CollectionImageObject] = []
    var arrCoverVGBImg: [CollectionImageObject] = []
    var arrCoverMountedImg: [CollectionImageObject] = []
    
    var arrOperateImg: [CollectionImageObject] = []
    var arrPostHazardImg: [CollectionImageObject] = []
    var arrSwimmerImg: [CollectionImageObject] = []
    var arrBasinCrackImg: [CollectionImageObject] = []
    
    
    //For Image CoreData
    var dataMainWaterFeatureImg = NSData()
    var dataWaterFeatureImg = NSData()
    var dataMainDivingImg = NSData()
    var dataDivingPresentImg = NSData()
    var dataSidesPresentImg = NSData()
    var dataMainDrainImg = NSData()
    var dataPoolDrainImg = NSData()
    var dataSpaDrainImg = NSData()
    var dataBasinWaterImg = NSData()
    var dataFeatureImg = NSData()
    var dataDrainWaterImg = NSData()
    var dataSplitImg = NSData()
    var dataCoverVGBImg = NSData()
    var dataCoverMountedImg = NSData()
    
    var dataOperateImg = NSData()
    var dataPostHazardImg = NSData()
    var dataSwimmerImg = NSData()
    var dataBasinCrackImg = NSData()
    
    //For Image Paths
    var strMainWaterFeatureImg = String()
    var strWaterFeatureImg = String()
    var strMainDivingImg = String()
    var strDivingPresentImg = String()
    var strSidesPresentImg = String()
    var strMainDrainImg = String()
    var strPoolDrainImg = String()
    var strSpaDrainImg = String()
    var strBasinWaterImg = String()
    var strFeatureImg = String()
    var strDrainWaterImg = String()
    var strSplitImg = String()
    var strCoverVGBImg = String()
    var strCoverMountedImg = String()
    
    var strOperateImg = String()
    var strPostHazardImg = String()
    var strSwimmerImg = String()
    var strBasinCrackImg = String()
    
    
    //For Optional Value
    var strWaterFeatureOption = String()
    var strDivingBoardsOption = String()
    var strSlidesPresentOption = String()
    var strMainDrainOption = String()
    
    var strSplitDrainOption = String()
    var strVGBCoverOption = String()
    var strCoverMountedOption = String()
    
    var strSubWaterOperateOption = String()
    var strSubWaterHazardOption = String()
    var strSubWaterSwimmerOption = String()
    var strSubWaterBasinCrackOption = String()
    var spaSubOption = String()
    var poolSubOption = String()
    
    enum Water: Int {
        case waterPresent = 0
        case mainDrains = 7
        case split = 8
        case coverVGB = 9
        case coverMounted = 10
    }
    
    enum SubFeature: Int {
        case operate = 0
        case hazard = 1
        case swimmer = 2
        case basinCrack = 3
    }
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.prepareFormData()
    }
    
    func prepareFormData() {
        for _ in 0..<11 {
            let obj = formInspectionPoolData()
            self.secWaterFeature.append(obj)
        }
        
        for _ in 0..<4 {
            let obj = formInspectionPoolData()
            self.secSubFeature.append(obj)
        }
    }
    
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
        let indexOfCell = self.tblInspectionWaterFeature.indexPath(for: cell)
        print("Clicked Index : \(String(describing: indexOfCell?.row))")
        
        self.mainDrainImageButtonIndex = -1
        fetchIndexForSubFeatureUpload = -1
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
    
    @objc func btnFeatureImgUpload(_ sender: Any) {
        print("Button pressed 👍 ")
        let btn = sender as! UIButton
        let cell = btn.superview?.superview?.superview as! UITableViewCell
        let tblWall = self.view.viewWithTag(25) as! UITableView
        let indexOfCell = tblWall.indexPath(for: cell)
        print("Clicked Index : \(String(describing: indexOfCell?.row))")
        
        self.mainDrainImageButtonIndex = -1
        fetchIndexForUpload = -1
        fetchIndexForSubFeatureUpload = (indexOfCell?.row)!
        
        print("Upload Index : \(String(describing: fetchIndexForSubFeatureUpload))")
        
        self.actionSheetPopUpForGalleryOpen()
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc func btnMainDrainInsideUpload(_ sender: Any) {
        print("Button pressed 👍 ")
        let btn = sender as! UIButton
        print(btn.tag)
        
        self.mainDrainImageButtonIndex = btn.tag
        
        self.actionSheetPopUpForGalleryOpen()
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    //MARK:- UploadCollectionProtocol
    func didTapOnCellItem(_indexpath: IndexPath, _imgUrl: String, _videoUrl: String) {
        
    }
    
    func didUpdateCellIndex(_indexpath: Int) {
        
    }
    
    //MARK:- ObjectiveC Function
    @objc func btnNextDidTap() {
        self.updateCoreData()
        self.view.endEditing(true)
        //self.postInspectWaterFeature()
        if UIDevice.current.userInterfaceIdiom == .phone {
            let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
            let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectSideSuction") as! InspectSideSuctionVC
            self.navigationController?.pushViewController(formVC, animated: true)
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
            let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectSideSuction") as! InspectSideSuctionVC
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
                    
                    managedObject.setValue(dataMainWaterFeatureImg, forKey: "mainWaterFeatureImage")
                    managedObject.setValue(strWaterFeatureOption, forKey: "waterFeaturePresentOption")
                    managedObject.setValue(dataWaterFeatureImg, forKey: "waterFeaturePresentImage")
                    managedObject.setValue(self.secWaterFeature[Water.waterPresent.rawValue].formTextValue, forKey: "waterFeaturePresentData")
                    managedObject.setValue(dataMainDivingImg, forKey: "mainDivingImage")
                    managedObject.setValue(strDivingBoardsOption, forKey: "divingPresentOption")
                    managedObject.setValue(dataDivingPresentImg, forKey: "divingPresentImage")
                    managedObject.setValue(strSlidesPresentOption, forKey: "slidesPresentOption")
                    managedObject.setValue(dataSidesPresentImg, forKey: "slidesPresentImage")
                    managedObject.setValue(dataMainDrainImg, forKey: "mainDrainImage")
                    managedObject.setValue(strMainDrainOption, forKey: "mainDrainOption")
                    managedObject.setValue(dataPoolDrainImg, forKey: "poolImage")
                    managedObject.setValue(poolSubOption, forKey: "poolSubOption")
                    managedObject.setValue(dataSpaDrainImg, forKey: "spaImage")
                    managedObject.setValue(spaSubOption, forKey: "spaSubOption")
                    managedObject.setValue(dataBasinWaterImg, forKey: "basinImage")
                    managedObject.setValue(dataFeatureImg, forKey: "featureImage")
                    managedObject.setValue(self.secWaterFeature[Water.mainDrains.rawValue].formTextValue, forKey: "featureMainDrainData")
                    managedObject.setValue(dataDrainWaterImg, forKey: "drainWaterImage")
                    managedObject.setValue(strSplitDrainOption, forKey: "splitDrainOption")
                    managedObject.setValue(dataSplitImg, forKey: "splitDrainImage")
                    managedObject.setValue(self.secWaterFeature[Water.split.rawValue].formTextValue, forKey: "splitDrainData")
                    managedObject.setValue(strVGBCoverOption, forKey: "coverVGBOption")
                    managedObject.setValue(dataCoverVGBImg, forKey: "coverVGBImage")
                    managedObject.setValue(self.secWaterFeature[Water.coverVGB.rawValue].formTextValue, forKey: "coverVGBData")
                    managedObject.setValue(strCoverMountedOption, forKey: "coverMountedOption")
                    managedObject.setValue(dataCoverMountedImg, forKey: "coverMountedImage")
                    managedObject.setValue(self.secWaterFeature[Water.coverMounted.rawValue].formTextValue, forKey: "coverMountedData")
                    managedObject.setValue(strSubWaterOperateOption, forKey: "subWaterOperateOption")
                    managedObject.setValue(dataOperateImg, forKey: "subWaterOperateImage")
                    managedObject.setValue(self.secSubFeature[SubFeature.operate.rawValue].formTextValue, forKey: "subWaterOperateData")
                    managedObject.setValue(strSubWaterHazardOption, forKey: "subWaterHazardOption")
                    managedObject.setValue(dataPostHazardImg, forKey: "subWaterHazardImage")
                    managedObject.setValue(self.secSubFeature[SubFeature.hazard.rawValue].formTextValue, forKey: "subWaterHazardData")
                    managedObject.setValue(strSubWaterSwimmerOption, forKey: "subWaterSwimmerOption")
                    managedObject.setValue(dataSwimmerImg, forKey: "subWaterSwimmerImage")
                    managedObject.setValue(self.secSubFeature[SubFeature.swimmer.rawValue].formTextValue, forKey: "subWaterSwimmerData")
                    managedObject.setValue(strSubWaterBasinCrackOption, forKey: "subWaterBasinCrackOption")
                    managedObject.setValue(dataBasinCrackImg, forKey: "subWaterBasinCrackImage")
                    managedObject.setValue(self.secSubFeature[SubFeature.basinCrack.rawValue].formTextValue, forKey: "subWaterBasinCrackData")
                    
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
                        print("Data of InspectEdgeVC:: \(data)")
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
                        self.strMainWaterFeatureImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 1 {
                        self.strWaterFeatureImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 2 {
                        self.strMainDivingImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 4 {
                        self.strDivingPresentImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 6 {
                        self.strSidesPresentImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 8 {
                        self.strSplitImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 9 {
                        self.strCoverVGBImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 10 {
                        self.strCoverMountedImg = String(describing: data!)
                    }
                    
                    if self.fetchIndexForSubFeatureUpload == 0 {
                        self.strOperateImg = String(describing: data!)
                    } else if self.fetchIndexForSubFeatureUpload == 1 {
                        self.strPostHazardImg = String(describing: data!)
                    } else if self.fetchIndexForSubFeatureUpload == 2 {
                        self.strSwimmerImg = String(describing: data!)
                    } else if self.fetchIndexForSubFeatureUpload == 3 {
                        self.strBasinCrackImg = String(describing: data!)
                    }
                    
                    if self.self.mainDrainImageButtonIndex == 0 {
                        self.strPoolDrainImg = String(describing: data!)
                    } else if self.self.mainDrainImageButtonIndex == 1 {
                        self.strSpaDrainImg = String(describing: data!)
                    } else if self.self.mainDrainImageButtonIndex == 2 {
                        self.strBasinWaterImg = String(describing: data!)
                    } else if self.self.mainDrainImageButtonIndex == 3 {
                        self.strFeatureImg = String(describing: data!)
                    } else if self.self.mainDrainImageButtonIndex == 4 {
                        self.strDrainWaterImg = String(describing: data!)
                    }
                    SVProgressHUD.dismiss()
                }
            case .failure(let encodingError):
                print("error:\(encodingError)")
                SVProgressHUD.dismiss()
            }
        })
    }
    
    func postInspectWaterFeature() {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        
        let return_id = UserDefaults.standard.value(forKey: "returnKeyForInspection")
        
        let inspectWaterDetails:  NSMutableDictionary = [
             "return_data_id"            : return_id!,
             "mainWaterFeatureImage"     : strMainWaterFeatureImg,
             "waterFeaturePresentOption" : strWaterFeatureOption,
             "waterFeaturePresentImage"  : strWaterFeatureImg,
             "waterFeaturePresentData"   : self.secWaterFeature[Water.waterPresent.rawValue].formTextValue,
             "mainDivingImage"           : strMainDivingImg,
             "divingPresentOption"       : strDivingBoardsOption,
             "divingPresentImage"        : strDivingPresentImg,
             "slidesPresentOption"       : strSlidesPresentOption,
             "slidesPresentImage"        : strSidesPresentImg,
             "mainDrainImage"            : strMainDrainImg,
             "mainDrainOption"           : strMainDrainOption,
             "poolImage"                 : strPoolDrainImg,
             "poolSubData"               : poolSubOption,
             "spaImage"                  : strSpaDrainImg,
             "spaSubData"                : spaSubOption,
             "basinImage"                : strBasinWaterImg,
             "featureImage"              : strFeatureImg,
             "featureMainDrainData"      : self.secWaterFeature[Water.mainDrains.rawValue].formTextValue,
             "drainWaterImage"           : strDrainWaterImg,
             "splitDrainOption"          : strSplitDrainOption,
             "splitDrainImage"           : strSplitImg,
             "splitDrainData"            : self.secWaterFeature[Water.split.rawValue].formTextValue,
             "coverVGBOption"            : strVGBCoverOption,
             "coverVGBImage"             : strCoverVGBImg,
             "coverVGBData"              : self.secWaterFeature[Water.coverVGB.rawValue].formTextValue,
             "coverMountedOption"        : strCoverMountedOption,
             "coverMountedImage"         : strCoverMountedImg,
             "coverMountedData"          : self.secWaterFeature[Water.coverMounted.rawValue].formTextValue,
             "subWaterOperateOption"     : strSubWaterOperateOption,
             "subWaterOperateImage"      : strOperateImg,
             "subWaterOperateData"       : self.secSubFeature[SubFeature.operate.rawValue].formTextValue,
             "subWaterHazardOption"      : strSubWaterHazardOption,
             "subWaterHazardImage"       : strPostHazardImg,
             "subWaterHazardData"        : self.secSubFeature[SubFeature.hazard.rawValue].formTextValue,
             "subWaterSwimmerOption"     : strSubWaterSwimmerOption,
             "subWaterSwimmerImage"      : strSwimmerImg,
             "subWaterSwimmerData"       : self.secSubFeature[SubFeature.swimmer.rawValue].formTextValue,
             "subWaterBasinCrackOption"  : strSubWaterBasinCrackOption,
             "subWaterBasinCrackImage"   : strBasinCrackImg,
             "subWaterBasinCrackData"    : self.secSubFeature[SubFeature.basinCrack.rawValue].formTextValue,
         ]

        print("inspectWaterDetails :: \(inspectWaterDetails)")
        //if sharedExtension.connectedToNetwork() {
        ApiManager.sharedInstanceAPI.PostInspectWaterFeature(postId: 1, waterFeatureDetails: inspectWaterDetails, onSuccess: { json in
            DispatchQueue.main.async {
                print("inspectWaterDetails json :: \(String(describing: json))")
                DispatchQueue.main.async(execute: {() -> Void in
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectSideSuction") as! InspectSideSuctionVC
                        self.navigationController?.pushViewController(formVC, animated: true)
                    } else if UIDevice.current.userInterfaceIdiom == .pad {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectSideSuction") as! InspectSideSuctionVC
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

extension InspectWaterFeatureVC: OpalImagePickerControllerDelegate {
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
                                self.arrMainWaterFeatureImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataMainWaterFeatureImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 1 {
                                self.arrWaterFeatureImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataWaterFeatureImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 2 {
                                self.arrMainDivingImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataMainDivingImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 4 {
                                self.arrDivingPresentImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataDivingPresentImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 6 {
                                self.arrSidesPresentImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSidesPresentImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 7 {
                                self.arrMainDrainImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataMainDrainImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 8 {
                                self.arrSplitImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSplitImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 9 {
                                self.arrCoverVGBImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataCoverVGBImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 10 {
                                self.arrCoverMountedImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataCoverMountedImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            }
                            if self.fetchIndexForSubFeatureUpload == 0 {
                                self.arrOperateImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataOperateImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                ////self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubFeatureUpload == 1 {
                                self.arrPostHazardImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataPostHazardImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubFeatureUpload == 2 {
                                self.arrSwimmerImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSwimmerImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubFeatureUpload == 3 {
                                self.arrBasinCrackImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataBasinCrackImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            }
                            if  self.mainDrainImageButtonIndex == 0 {
                                self.arrPoolImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataPoolDrainImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.mainDrainImageButtonIndex == 1 {                                                            self.arrSpaImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSpaDrainImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.mainDrainImageButtonIndex == 2 {                                                            self.arrBasinWaterImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataBasinWaterImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.self.mainDrainImageButtonIndex == 3 {                                                            self.arrFeatureImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataFeatureImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.mainDrainImageButtonIndex == 4 {                                                            self.arrDrainWaterImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataDrainWaterImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
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
                self.tblInspectionWaterFeature.reloadData()
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

extension InspectWaterFeatureVC: UIImagePickerControllerDelegate {
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
            self.arrMainWaterFeatureImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataMainWaterFeatureImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForUpload == 1 {
            self.arrWaterFeatureImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataWaterFeatureImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForUpload == 2 {
            self.arrMainDivingImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataMainDivingImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForUpload == 4 {
            self.arrDivingPresentImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataDivingPresentImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForUpload == 6 {
            self.arrSidesPresentImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSidesPresentImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForUpload == 7 {
            self.arrMainDrainImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataMainDrainImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForUpload == 8 {
            self.arrSplitImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSplitImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForUpload == 9 {
            self.arrCoverVGBImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataCoverVGBImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForUpload == 10 {
            self.arrCoverMountedImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataCoverMountedImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        }
        
        if  self.mainDrainImageButtonIndex == 0 {
            self.arrPoolImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataPoolDrainImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.mainDrainImageButtonIndex == 1 {
            self.arrSpaImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSpaDrainImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.mainDrainImageButtonIndex == 2 {
            self.arrBasinWaterImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataBasinWaterImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.self.mainDrainImageButtonIndex == 3 {
            self.arrFeatureImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataFeatureImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.mainDrainImageButtonIndex == 4 {
            self.arrDrainWaterImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataDrainWaterImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        }
        
        if self.fetchIndexForSubFeatureUpload == 0 {
            self.arrOperateImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataOperateImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForSubFeatureUpload == 1 {
            self.arrPostHazardImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataPostHazardImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForSubFeatureUpload == 2 {
            self.arrSwimmerImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSwimmerImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForSubFeatureUpload == 3 {
            self.arrBasinCrackImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataBasinCrackImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        }
        
        self.tblInspectionWaterFeature.reloadData()
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
}



extension InspectWaterFeatureVC: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        var cell = UITableViewCell()
        cell = (textView.superview?.superview as? UITableViewCell)!
        
        if let InspectWaterFeatureTableCell = cell as? InspectWaterFeatureTableCell {
            if textView == InspectWaterFeatureTableCell.txtInspectWaterFeature {
                self.secWaterFeature[Water.waterPresent.rawValue].formTextValue = (textView.text)!
           }
        } else if let headerCell = cell as? MainDrainsHeaderTableCell {
            if textView == headerCell.txtMainDrain {
                self.secWaterFeature[Water.mainDrains.rawValue].formTextValue = (textView.text)!
           }
        } else if let splitCell = cell as? SplitDrainTableCell {
            if textView == splitCell.txtOther {
                self.secWaterFeature[Water.split.rawValue].formTextValue = (textView.text)!
           }
        } else if let coverCell = cell as? VGBCoverTableCell {
            if textView == coverCell.txtOther {
                self.secWaterFeature[Water.coverVGB.rawValue].formTextValue = (textView.text)!
           }
        } else if let coverCell = cell as? CoverMountedTableCell {
            if textView == coverCell.txtOther {
                self.secWaterFeature[Water.coverMounted.rawValue].formTextValue = (textView.text)!
           }
        }
        
        if let subWaterFeatureCell = cell as? WaterFeatureOperateTableCell {
            if textView == subWaterFeatureCell.txtWaterOperate {
                self.secSubFeature[SubFeature.operate.rawValue].formTextValue = (textView.text)!
           }
        } else if let subWaterFeatureCell = cell as? WaterFeatureHazardTableCell {
            if textView == subWaterFeatureCell.txtHazard {
                self.secSubFeature[SubFeature.hazard.rawValue].formTextValue = (textView.text)!
           }
        } else if let subWaterFeatureCell = cell as? WaterFeatureSwimmerAccessibleTableCell {
            if textView == subWaterFeatureCell.txtSwimmer {
                self.secSubFeature[SubFeature.swimmer.rawValue].formTextValue = (textView.text)!
           }
        } else if let subWaterFeatureCell = cell as? WaterFeatureBasinCrackTableCell {
            if textView == subWaterFeatureCell.txtBasinCrack {
                self.secSubFeature[SubFeature.basinCrack.rawValue].formTextValue = (textView.text)!
           }
        }
    }
}


extension InspectWaterFeatureVC: UITableViewDataSource, UITableViewDelegate {
    //MARK:- UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 25 {
            return 4
        } else {
            return 12
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 25 {
            if indexPath.row == 0 {
                let waterFeatureOperateCell = tableView.dequeueReusableCell(withIdentifier: "WaterFeatureOperateCell", for: indexPath) as! WaterFeatureOperateTableCell
                
                waterFeatureOperateCell.btnUpload.addTarget(self, action: #selector(btnFeatureImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                waterFeatureOperateCell.collectionvw.arrItems = arrOperateImg
                waterFeatureOperateCell.collectionvw.delegateItemCollection = self
                waterFeatureOperateCell.collectionvw.reloadImageCollection()

                if arrOperateImg.count > 0 {
                    waterFeatureOperateCell.btnUpload.isHidden = true
                    waterFeatureOperateCell.collectionvw.isHidden = false
                } else {
                    waterFeatureOperateCell.btnUpload.isHidden = false
                    waterFeatureOperateCell.collectionvw.isHidden = true
                }
                
                waterFeatureOperateCell.delegateWaterOperate = self
                waterFeatureOperateCell.txtWaterOperate.delegate = self
                
                return waterFeatureOperateCell
            } else if indexPath.row == 1 {
                let waterFeaturePostHazardCell = tableView.dequeueReusableCell(withIdentifier: "WaterFeatureHazardCell", for: indexPath) as! WaterFeatureHazardTableCell
                
                waterFeaturePostHazardCell.btnUpload.addTarget(self, action: #selector(btnFeatureImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                waterFeaturePostHazardCell.collectionvw.arrItems = arrPostHazardImg
                waterFeaturePostHazardCell.collectionvw.delegateItemCollection = self
                waterFeaturePostHazardCell.collectionvw.reloadImageCollection()

                if arrPostHazardImg.count > 0 {
                   waterFeaturePostHazardCell.btnUpload.isHidden = true
                   waterFeaturePostHazardCell.collectionvw.isHidden = false
                } else {
                   waterFeaturePostHazardCell.btnUpload.isHidden = false
                   waterFeaturePostHazardCell.collectionvw.isHidden = true
                }
                
                waterFeaturePostHazardCell.delegateWaterHazard = self
                waterFeaturePostHazardCell.txtHazard.delegate = self
                
                return waterFeaturePostHazardCell
            } else if indexPath.row == 2 {
                 let waterFeatureSwimmerAccessibleCell = tableView.dequeueReusableCell(withIdentifier: "WaterFeatureSwimmerAccessibleCell", for: indexPath) as! WaterFeatureSwimmerAccessibleTableCell
                
                waterFeatureSwimmerAccessibleCell.btnUpload.addTarget(self, action: #selector(btnFeatureImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                waterFeatureSwimmerAccessibleCell.collectionvw.arrItems = arrSwimmerImg
                waterFeatureSwimmerAccessibleCell.collectionvw.delegateItemCollection = self
                waterFeatureSwimmerAccessibleCell.collectionvw.reloadImageCollection()

                if arrSwimmerImg.count > 0 {
                    waterFeatureSwimmerAccessibleCell.btnUpload.isHidden = true
                    waterFeatureSwimmerAccessibleCell.collectionvw.isHidden = false
                } else {
                    waterFeatureSwimmerAccessibleCell.btnUpload.isHidden = false
                    waterFeatureSwimmerAccessibleCell.collectionvw.isHidden = true
                }
                
                waterFeatureSwimmerAccessibleCell.delegateWaterSwimmer = self
                waterFeatureSwimmerAccessibleCell.txtSwimmer.delegate = self
                
                return waterFeatureSwimmerAccessibleCell
            } else {//} if indexPath.row == 3 {
                let waterFeatureBasinCrackCell = tableView.dequeueReusableCell(withIdentifier: "WaterFeatureBasinCrackCell", for: indexPath) as! WaterFeatureBasinCrackTableCell
                
                waterFeatureBasinCrackCell.btnUpload.addTarget(self, action: #selector(btnFeatureImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                waterFeatureBasinCrackCell.collectionvw.arrItems = arrBasinCrackImg
                waterFeatureBasinCrackCell.collectionvw.delegateItemCollection = self
                waterFeatureBasinCrackCell.collectionvw.reloadImageCollection()

                if arrBasinCrackImg.count > 0 {
                    waterFeatureBasinCrackCell.btnUpload.isHidden = true
                    waterFeatureBasinCrackCell.collectionvw.isHidden = false
                } else {
                    waterFeatureBasinCrackCell.btnUpload.isHidden = false
                    waterFeatureBasinCrackCell.collectionvw.isHidden = true
                }

                waterFeatureBasinCrackCell.delegateWaterBasinCrack = self
                waterFeatureBasinCrackCell.txtBasinCrack.delegate = self
                
                return waterFeatureBasinCrackCell
            }
         } else {
            if indexPath.row == 0 {
                let cameraCell = tableView.dequeueReusableCell(withIdentifier: "CameraCell", for: indexPath) as! CameraTableCell
                
                cameraCell.lblHeader.text = "Water Features"
               cameraCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
               cameraCell.collectionVw.arrItems = arrMainWaterFeatureImg
               cameraCell.collectionVw.delegateItemCollection = self
               cameraCell.collectionVw.reloadImageCollection()
               
               if arrMainWaterFeatureImg.count > 0 {
                   cameraCell.btnUpload.isHidden = true
                   cameraCell.collectionVw.isHidden = false
               } else {
                   cameraCell.btnUpload.isHidden = false
                   cameraCell.collectionVw.isHidden = true
               }
               
               return cameraCell
            } else if indexPath.row == 1 {
                let inspectWaterFeatureCell = tableView.dequeueReusableCell(withIdentifier: "InspectWaterFeatureCell", for: indexPath) as! InspectWaterFeatureTableCell
                
                inspectWaterFeatureCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

                inspectWaterFeatureCell.collectionVw.arrItems = arrWaterFeatureImg
                inspectWaterFeatureCell.collectionVw.delegateItemCollection = self
                inspectWaterFeatureCell.collectionVw.reloadImageCollection()
                
                if arrWaterFeatureImg.count > 0 {
                    inspectWaterFeatureCell.btnUpload.isHidden = true
                    inspectWaterFeatureCell.collectionVw.isHidden = false
                } else {
                    inspectWaterFeatureCell.btnUpload.isHidden = false
                    inspectWaterFeatureCell.collectionVw.isHidden = true
                }
                
                inspectWaterFeatureCell.delegateWaterFeature = self
                inspectWaterFeatureCell.txtInspectWaterFeature.delegate = self
                
                if strWaterFeatureOption == "Yes" {
                    //Declare the outlet in our custom class
                    let tblRaised = inspectWaterFeatureCell.viewWithTag(25) as! UITableView
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        inspectWaterFeatureCell.tblHeightConstraint.constant = 2440
                    } else {
                        inspectWaterFeatureCell.tblHeightConstraint.constant = 600*4
                    }
                    tblRaised.delegate = self
                    tblRaised.dataSource = self
                    tblRaised.reloadData()
                } else if strWaterFeatureOption == "No" {
                    inspectWaterFeatureCell.tblHeightConstraint.constant = 0
                }
                
                return inspectWaterFeatureCell
            } else if indexPath.row == 2 {
                let cameraCell = tableView.dequeueReusableCell(withIdentifier: "CameraCell", for: indexPath) as! CameraTableCell
                           
               //Declare the outlet in our custom class
               //let collectionViewProject = cameraCell.viewWithTag(10) as! UICollectionView
               
               cameraCell.lblHeader.text = "Diving Boards and Slides"
                
               cameraCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

               cameraCell.collectionVw.arrItems = arrMainDivingImg
               cameraCell.collectionVw.delegateItemCollection = self
               cameraCell.collectionVw.reloadImageCollection()
               
               if arrMainDivingImg.count > 0 {
                   cameraCell.btnUpload.isHidden = true
                   cameraCell.collectionVw.isHidden = false
               } else {
                   cameraCell.btnUpload.isHidden = false
                   cameraCell.collectionVw.isHidden = true
               }
               
               return cameraCell
            } else if indexPath.row == 3 {
                let customHeaderCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as! HeaderTableCell
                
                customHeaderCell.lblHeaderText.text = "***IMPORTANT:  Due to accidents and injuries - always recommend removal of all diving boards and slides."
                
                return customHeaderCell
            } else if indexPath.row == 4 {
                let divingBoardsCell = tableView.dequeueReusableCell(withIdentifier: "DivingBoardsCell", for: indexPath) as! DivingBoardsTableCell

                divingBoardsCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

                divingBoardsCell.collectionvw.arrItems = arrDivingPresentImg
                divingBoardsCell.collectionvw.delegateItemCollection = self
                divingBoardsCell.collectionvw.reloadImageCollection()
                
                if arrDivingPresentImg.count > 0 {
                    divingBoardsCell.btnUpload.isHidden = true
                    divingBoardsCell.collectionvw.isHidden = false
                } else {
                    divingBoardsCell.btnUpload.isHidden = false
                    divingBoardsCell.collectionvw.isHidden = true
                }
                
                divingBoardsCell.delegateDivingBoards = self
                
                return divingBoardsCell
            } else if indexPath.row == 5 {
                let customHeaderCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as! HeaderTableCell
                
                customHeaderCell.lblHeaderText.text = "SLIDES  ***Due to accidents and injuries - always recommend removal of all diving boards and slides."
                
                return customHeaderCell
            } else if indexPath.row == 6 {
                let slidesCell = tableView.dequeueReusableCell(withIdentifier: "SlidesCell", for: indexPath) as! SlidesTableCell
                
                slidesCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

                slidesCell.collectionvw.arrItems = arrSidesPresentImg
                slidesCell.collectionvw.delegateItemCollection = self
                slidesCell.collectionvw.reloadImageCollection()
                
                if arrSidesPresentImg.count > 0 {
                    slidesCell.btnUpload.isHidden = true
                    slidesCell.collectionvw.isHidden = false
                } else {
                    slidesCell.btnUpload.isHidden = false
                    slidesCell.collectionvw.isHidden = true
                }
                
                slidesCell.delegateSlides = self
                
                return slidesCell
            } else if indexPath.row == 7 {
                let mainDrainsHeaderCell = tableView.dequeueReusableCell(withIdentifier: "MainDrainsHeaderCell", for: indexPath) as! MainDrainsHeaderTableCell
                
                //For Main Drain
                mainDrainsHeaderCell.btnMainDrainUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

                mainDrainsHeaderCell.mainDrainCollectionvw.arrItems = arrMainDrainImg
                mainDrainsHeaderCell.mainDrainCollectionvw.delegateItemCollection = self
                mainDrainsHeaderCell.mainDrainCollectionvw.reloadImageCollection()
                
                if arrMainDrainImg.count > 0 {
                    mainDrainsHeaderCell.btnMainDrainUpload.isHidden = true
                    mainDrainsHeaderCell.mainDrainCollectionvw.isHidden = false
                } else {
                    mainDrainsHeaderCell.btnMainDrainUpload.isHidden = false
                    mainDrainsHeaderCell.mainDrainCollectionvw.isHidden = true
                }
                
                //Pool
                mainDrainsHeaderCell.btnPoolUpload.addTarget(self, action: #selector(btnMainDrainInsideUpload(_:)), for: UIControl.Event.touchUpInside)

                mainDrainsHeaderCell.poolCollectionvw.arrItems = arrPoolImg
                mainDrainsHeaderCell.poolCollectionvw.delegateItemCollection = self
                mainDrainsHeaderCell.poolCollectionvw.reloadImageCollection()
               
                if arrPoolImg.count > 0 {
                   mainDrainsHeaderCell.btnPoolUpload.isHidden = true
                   mainDrainsHeaderCell.poolCollectionvw.isHidden = false
                } else {
                   mainDrainsHeaderCell.btnPoolUpload.isHidden = false
                   mainDrainsHeaderCell.poolCollectionvw.isHidden = true
                }
                
                //Spa
                mainDrainsHeaderCell.btnSpaUpload.addTarget(self, action: #selector(btnMainDrainInsideUpload(_:)), for: UIControl.Event.touchUpInside)

                mainDrainsHeaderCell.spaCollectionvw.arrItems = arrSpaImg
                mainDrainsHeaderCell.spaCollectionvw.delegateItemCollection = self
                mainDrainsHeaderCell.spaCollectionvw.reloadImageCollection()
              
                if arrSpaImg.count > 0 {
                    mainDrainsHeaderCell.btnSpaUpload.isHidden = true
                    mainDrainsHeaderCell.spaCollectionvw.isHidden = false
                } else {
                    mainDrainsHeaderCell.btnSpaUpload.isHidden = false
                    mainDrainsHeaderCell.spaCollectionvw.isHidden = true
                }
                
                //For Basin
                mainDrainsHeaderCell.btnBasinUpload.addTarget(self, action: #selector(btnMainDrainInsideUpload(_:)), for: UIControl.Event.touchUpInside)

                mainDrainsHeaderCell.basinCollectionvw.arrItems = arrBasinWaterImg
                mainDrainsHeaderCell.basinCollectionvw.delegateItemCollection = self
                mainDrainsHeaderCell.basinCollectionvw.reloadImageCollection()
                
                if arrBasinWaterImg.count > 0 {
                    mainDrainsHeaderCell.btnBasinUpload.isHidden = true
                    mainDrainsHeaderCell.basinCollectionvw.isHidden = false
                } else {
                    mainDrainsHeaderCell.btnBasinUpload.isHidden = false
                    mainDrainsHeaderCell.basinCollectionvw.isHidden = true
                }
                
                //For Water feature
                mainDrainsHeaderCell.btnFeatureUpload.addTarget(self, action: #selector(btnMainDrainInsideUpload(_:)), for: UIControl.Event.touchUpInside)

                mainDrainsHeaderCell.featureCollectionvw.arrItems = arrFeatureImg
                mainDrainsHeaderCell.featureCollectionvw.delegateItemCollection = self
                mainDrainsHeaderCell.featureCollectionvw.reloadImageCollection()
                
                if arrFeatureImg.count > 0 {
                    mainDrainsHeaderCell.btnFeatureUpload.isHidden = true
                    mainDrainsHeaderCell.featureCollectionvw.isHidden = false
                } else {
                    mainDrainsHeaderCell.btnFeatureUpload.isHidden = false
                    mainDrainsHeaderCell.featureCollectionvw.isHidden = true
                }
                
                //For Drain
                mainDrainsHeaderCell.btnDrainUpload.addTarget(self, action: #selector(btnMainDrainInsideUpload(_:)), for: UIControl.Event.touchUpInside)

                mainDrainsHeaderCell.drainCollectionvw.arrItems = arrDrainWaterImg
                mainDrainsHeaderCell.drainCollectionvw.delegateItemCollection = self
                mainDrainsHeaderCell.drainCollectionvw.reloadImageCollection()
                
                if arrDrainWaterImg.count > 0 {
                    mainDrainsHeaderCell.btnDrainUpload.isHidden = true
                    mainDrainsHeaderCell.drainCollectionvw.isHidden = false
                } else {
                    mainDrainsHeaderCell.btnDrainUpload.isHidden = false
                    mainDrainsHeaderCell.drainCollectionvw.isHidden = true
                }
                
                if strMainDrainOption == "Pool" {
                    mainDrainsHeaderCell.option1SubHeightConstraint.constant = 410
                    mainDrainsHeaderCell.option2SubHeightConstraint.constant = 0
                    mainDrainsHeaderCell.option1SubView.isHidden = false
                    mainDrainsHeaderCell.option2SubView.isHidden = true
                    mainDrainsHeaderCell.btnPoolUpload.isUserInteractionEnabled = true
                    mainDrainsHeaderCell.btnSpaUpload.isUserInteractionEnabled = false
                    mainDrainsHeaderCell.btnBasinUpload.isUserInteractionEnabled = false
                    mainDrainsHeaderCell.btnFeatureUpload.isUserInteractionEnabled = false
                } else if strMainDrainOption == "Spa" {
                    mainDrainsHeaderCell.option2SubHeightConstraint.constant = 440
                    mainDrainsHeaderCell.option1SubHeightConstraint.constant = 0
                    mainDrainsHeaderCell.option1SubView.isHidden = true
                    mainDrainsHeaderCell.option2SubView.isHidden = false
                    mainDrainsHeaderCell.btnPoolUpload.isUserInteractionEnabled = false
                    mainDrainsHeaderCell.btnSpaUpload.isUserInteractionEnabled = true
                    mainDrainsHeaderCell.btnBasinUpload.isUserInteractionEnabled = false
                    mainDrainsHeaderCell.btnFeatureUpload.isUserInteractionEnabled = false
                }  else if strMainDrainOption == "Catch Basin" {
                    mainDrainsHeaderCell.option1SubHeightConstraint.constant = 0
                    mainDrainsHeaderCell.option2SubHeightConstraint.constant = 0
                    mainDrainsHeaderCell.option1SubView.isHidden = true
                    mainDrainsHeaderCell.option2SubView.isHidden = true
                    mainDrainsHeaderCell.btnPoolUpload.isUserInteractionEnabled = false
                    mainDrainsHeaderCell.btnSpaUpload.isUserInteractionEnabled = false
                    mainDrainsHeaderCell.btnBasinUpload.isUserInteractionEnabled = true
                    mainDrainsHeaderCell.btnFeatureUpload.isUserInteractionEnabled = false
                } else if strMainDrainOption == "Water Features" {
                    mainDrainsHeaderCell.option1SubHeightConstraint.constant = 0
                    mainDrainsHeaderCell.option2SubHeightConstraint.constant = 0
                    mainDrainsHeaderCell.option1SubView.isHidden = true
                    mainDrainsHeaderCell.option2SubView.isHidden = true
                    mainDrainsHeaderCell.btnPoolUpload.isUserInteractionEnabled = false
                    mainDrainsHeaderCell.btnSpaUpload.isUserInteractionEnabled = false
                    mainDrainsHeaderCell.btnBasinUpload.isUserInteractionEnabled = true
                    mainDrainsHeaderCell.btnFeatureUpload.isUserInteractionEnabled = true
                } else  {
                    mainDrainsHeaderCell.option1SubHeightConstraint.constant = 0
                    mainDrainsHeaderCell.option2SubHeightConstraint.constant = 0
                    mainDrainsHeaderCell.option1SubView.isHidden = true
                    mainDrainsHeaderCell.option2SubView.isHidden = true
                    mainDrainsHeaderCell.btnPoolUpload.isUserInteractionEnabled = false
                    mainDrainsHeaderCell.btnSpaUpload.isUserInteractionEnabled = false
                    mainDrainsHeaderCell.btnBasinUpload.isUserInteractionEnabled = false
                    mainDrainsHeaderCell.btnFeatureUpload.isUserInteractionEnabled = false
                }
                
                mainDrainsHeaderCell.delegatePoolSubOption = self
                mainDrainsHeaderCell.delegateSpaSubOption = self
                mainDrainsHeaderCell.delegateMainDrainOption = self
                
                return mainDrainsHeaderCell
            } else if indexPath.row == 8 {
                let splitCell = tableView.dequeueReusableCell(withIdentifier: "SplitDrainCell", for: indexPath) as! SplitDrainTableCell
                
                splitCell.lblHeader.text = "Are all split drains a minimum of 36 inches apart and/or on different planes?"
                
                splitCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

                splitCell.collectionVw.arrItems = arrSplitImg
                splitCell.collectionVw.delegateItemCollection = self
                splitCell.collectionVw.reloadImageCollection()
                
                if arrSplitImg.count > 0 {
                    splitCell.btnUpload.isHidden = true
                    splitCell.collectionVw.isHidden = false
                } else {
                    splitCell.btnUpload.isHidden = false
                    splitCell.collectionVw.isHidden = true
                }
                
                splitCell.delegateSplitDrain = self
                splitCell.txtOther.delegate = self
                
                return splitCell
            } else if indexPath.row == 9 {
                let splitCell = tableView.dequeueReusableCell(withIdentifier: "VGBCoverCell", for: indexPath) as! VGBCoverTableCell
                
                splitCell.lblHeader.text = "Do all drains have VGB compliant covers?"
                
                splitCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

                splitCell.collectionVw.arrItems = arrCoverVGBImg
                splitCell.collectionVw.delegateItemCollection = self
                splitCell.collectionVw.reloadImageCollection()
                
                if arrCoverVGBImg.count > 0 {
                    splitCell.btnUpload.isHidden = true
                    splitCell.collectionVw.isHidden = false
                } else {
                    splitCell.btnUpload.isHidden = false
                    splitCell.collectionVw.isHidden = true
                }
                
                splitCell.delegateVGBCover = self
                splitCell.txtOther.delegate = self
                
                return splitCell
            } else if indexPath.row == 10 {
                let splitCell = tableView.dequeueReusableCell(withIdentifier: "CoverMountedCell", for: indexPath) as! CoverMountedTableCell
                
                splitCell.lblHeader.text = "Are all covers mounted securely and properly?"
                
                splitCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

                splitCell.collectionVw.arrItems = arrCoverMountedImg
                splitCell.collectionVw.delegateItemCollection = self
                splitCell.collectionVw.reloadImageCollection()
                
                if arrCoverMountedImg.count > 0 {
                    splitCell.btnUpload.isHidden = true
                    splitCell.collectionVw.isHidden = false
                } else {
                    splitCell.btnUpload.isHidden = false
                    splitCell.collectionVw.isHidden = true
                }
                
                splitCell.delegateCoverMounted = self
                splitCell.txtOther.delegate = self
                
                return splitCell
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
            if tableView.tag == 25 {
                    return 340
            } else {
                if indexPath.row == 0 {
                    return 185
                } else if indexPath.row == 1 {
                    if strWaterFeatureOption == "Yes" {
                        return 345+(340*4)//UITableView.automaticDimension//
                    } else {
                        return 345
                    }
                }  else if indexPath.row == 2 {
                    return 185
                } else if indexPath.row == 3 {
                    return 65
                } else if indexPath.row == 4 {
                    return 420
                } else if indexPath.row == 5 {
                    return 65
                } else if indexPath.row == 6 {
                    return 225
                } else if indexPath.row == 7 {
                    if strMainDrainOption == "Pool" || strMainDrainOption == "Spa" {
                        return 1167
                    } else {
                        return 960
                    }
                } else if indexPath.row == 11 {
                    return 105
                } else if indexPath.row == 10 {
                    return 345
                } else {
                    return 355
                }
            }
        } else {            //.pad
            if tableView.tag == 25 {
                    return 600
            } else {
                if indexPath.row == 0 {
                    return 320
                } else if indexPath.row == 1 {
                    if strWaterFeatureOption == "Yes" {
                        return 615+(600*4)//UITableView.automaticDimension//
                    } else {
                        return 615
                    }
                }  else if indexPath.row == 2 {
                    return 320
                } else if indexPath.row == 3 {
                    return 65
                } else if indexPath.row == 4 {
                    return 420
                } else if indexPath.row == 5 {
                    return 65
                } else if indexPath.row == 6 {
                    return 420
                } else if indexPath.row == 7 {
                    if strMainDrainOption == "Pool" {
                        return 1950
                    } else if  strMainDrainOption == "Spa"  {
                        return 1950
                    } else {
                        return 1550
                    }
                } else if indexPath.row == 11 {
                    return 175
                } else if indexPath.row == 10 {
                    return 600
                } else {
                    return 600
                }
            }
        }
    }
}

extension InspectWaterFeatureVC: WaterFeatureCellProtocol, DivingBoardsCellProtocol, SlidesCellProtocol, SplitDrainProtocol, VGBCoverProtocol, CoverMountedProtocol, WaterOperateCellProtocol, WaterHazardCellProtocol, WaterSwimmerCellProtocol, WaterBasinCrackCellProtocol,PoolSubOptionCellProtocol,SpaSubOptionCellProtocol,MainDrainOptionCellProtocol {
    
    //MARK:- Water Feature
    func didTapOnCellWaterFeature(_btnWaterPresentTag: Int) {
        if _btnWaterPresentTag == 0 {
            strWaterFeatureOption = "Yes"
        } else if _btnWaterPresentTag == 1 {
            strWaterFeatureOption = "No"
        }
        self.tblInspectionWaterFeature.reloadData()
    }
    
    func didTapOnCellDivingBoards(_btnDivingBoardTag: Int) {
        if _btnDivingBoardTag == 0 {
            strDivingBoardsOption = "Yes"
        } else if _btnDivingBoardTag == 1 {
            strDivingBoardsOption = "No"
        }
        //self.tblInspectionWaterFeature.reloadData()
    }
    
    func didTapOnCellSlides(_btnSlidesTag: Int) {
        if _btnSlidesTag == 0 {
            strSlidesPresentOption = "Yes"
        } else if _btnSlidesTag == 1 {
            strSlidesPresentOption = "No"
        }
        //self.tblInspectionWaterFeature.reloadData()
    }
    
    func didTapOnCellSplitDrain(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strSplitDrainOption = "Yes"
        } else if _btnDescribeTag == 1 {
            strSplitDrainOption = "No"
        }
        //self.tblInspectionWaterFeature.reloadData()
    }
    
    func didTapOnCellVGBCover(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strVGBCoverOption = "Yes"
        } else if _btnDescribeTag == 1 {
            strVGBCoverOption = "No"
        }
        //self.tblInspectionWaterFeature.reloadData()
    }
    
    func didTapOnCellCoverMounted(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strCoverMountedOption = "Yes"
        } else if _btnDescribeTag == 1 {
            strCoverMountedOption = "No"
        }
        //self.tblInspectionWaterFeature.reloadData()
    }
    
    
    //MARK:- Sub Water Feature
    func didTapOnCellWaterOperate(_btnWaterOperateTag: Int) {
       if _btnWaterOperateTag == 0 {
           strSubWaterOperateOption = "Yes"
       } else if _btnWaterOperateTag == 1 {
           strSubWaterOperateOption = "No"
       }
       //self.tblInspectionWaterFeature.reloadData()
    }
    
    func didTapOnCellWaterHazard(_btnWaterHazardTag: Int) {
        if _btnWaterHazardTag == 0 {
            strSubWaterHazardOption = "Yes"
        } else if _btnWaterHazardTag == 1 {
            strSubWaterHazardOption = "No"
        }
        //self.tblInspectionWaterFeature.reloadData()
    }
    
    func didTapOnCellWaterSwimmer(_btnWaterSwimmerTag: Int) {
        if _btnWaterSwimmerTag == 0 {
            strSubWaterSwimmerOption = "Yes"
        } else if _btnWaterSwimmerTag == 1 {
            strSubWaterSwimmerOption = "No"
        }
        //self.tblInspectionWaterFeature.reloadData()
    }
    
    func didTapOnCellWaterBasinCrack(_btnWaterBasinCrackTag: Int) {
        if _btnWaterBasinCrackTag == 0 {
            strSubWaterBasinCrackOption = "Yes"
        } else if _btnWaterBasinCrackTag == 1 {
            strSubWaterBasinCrackOption = "No"
        }
       // self.tblInspectionWaterFeature.reloadData()
    }
     
    func didTapOnCellPoolSubOption(_btnPoolSubOptionTag: Int) {
        if _btnPoolSubOptionTag == 0 {
            poolSubOption = "Single"
        } else if _btnPoolSubOptionTag == 1 {
            poolSubOption = "Split / Dual"
        } else if _btnPoolSubOptionTag == 2 {
            poolSubOption = "Direct Suction"
        } else {
            poolSubOption = "Tied to skimmer"
        }
         //self.tblInspectionWaterFeature.reloadData()
    }
    
    func didTapOnCellSpaSubOption(_btnSpaSubOptionTag: Int) {
        if _btnSpaSubOptionTag == 0 {
            spaSubOption = "Single"
        } else if _btnSpaSubOptionTag == 1 {
            spaSubOption = "Split / Dual"
        } else if _btnSpaSubOptionTag == 2 {
            spaSubOption = "Direct suction to filtration pump"
        } else if _btnSpaSubOptionTag == 3 {
            spaSubOption = "Tied to skimmer"
        } else {
            spaSubOption = "Tied to jet pump"
        }
        //self.tblInspectionWaterFeature.reloadData()
    }
    
    func didTapOnCellMainDrainOption(_btnMainDrainOptionTag: Int) {
        if _btnMainDrainOptionTag == 0 {
            strMainDrainOption = "Pool"
        } else if _btnMainDrainOptionTag == 1 {
            strMainDrainOption = "Spa"
        } else if _btnMainDrainOptionTag == 2 {
            strMainDrainOption = "Catch Basin"
        } else {
            strMainDrainOption = "Water Features"
        }
        self.tblInspectionWaterFeature.reloadData()
    }
}
