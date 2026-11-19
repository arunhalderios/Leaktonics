//
//  InspectPortableSpaVC.swift
//  Leaktronics
//
//  Created by ivaninfotech on 5/6/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import CoreData
import DLRadioButton
import SVProgressHUD
import Alamofire
import Photos
import OpalImagePicker

class InspectPortableSpaVC: UIViewController, UINavigationControllerDelegate, UploadCollectionProtocol {
    
    @IBOutlet weak var tblSPA: UITableView!
    
    var secPortable = [formInspectionPoolData]()
    var secSPA = [formInspectionPoolData]()
    var secOverFlow = [formInspectionPoolData]()
    
    enum Portable: Int {
        case mainSpa = 1
        case equipRoom = 5
        case equipClear = 6
        case equipElement = 7
        case equipUV = 8
    }
    
    enum SPA: Int {
        case spa0 = 0
        case spa1 = 1
        case spa2 = 2
        case spa3 = 3
        case spa4 = 4
        case spa5 = 5
        case spa6 = 6
        case spa7 = 7
        case spa8 = 8
        case spa9 = 9
    }
    
    var imagePicker = UIImagePickerController()
    var picker:UIImagePickerController? = UIImagePickerController()


    //For Images
    var arrPortableSpaImg: [CollectionImageObject] = []
    var arrMainSpaImg: [CollectionImageObject] = []
    var arrEquipmentImg: [CollectionImageObject] = []
    var arrEquipRoomImg: [CollectionImageObject] = []
    var arrEquipClearImg: [CollectionImageObject] = []
    var arrEquipElementImg: [CollectionImageObject] = []
    var arrEquipUVImg: [CollectionImageObject] = []

    var arrSpa0Img: [CollectionImageObject] = []
    var arrSpa1Img: [CollectionImageObject] = []
    var arrSpa2Img: [CollectionImageObject] = []
    var arrSpa3Img: [CollectionImageObject] = []
    var arrSpa4Img: [CollectionImageObject] = []
    var arrSpa5Img: [CollectionImageObject] = []
    var arrSpa6Img: [CollectionImageObject] = []
    var arrSpa7Img: [CollectionImageObject] = []
    var arrSpa8Img: [CollectionImageObject] = []
    var arrSpa9Img: [CollectionImageObject] = []
    
    var fetchIndexForUpload: Int = -1
    var fetchIndexForSubSpaUpload: Int = -1
    
    //For Image Server path
    var strPortableSpaImg = String()
    var strMainSpaImg = String()
    var strEquipmentImg = String()
    var strEquipRoomImg = String()
    var strEquipClearImg = String()
    var strEquipElementImg = String()
    var strEquipUVImg = String()
    
    var strSpa0Img = String()
    var strSpa1Img = String()
    var strSpa2Img = String()
    var strSpa3Img = String()
    var strSpa4Img = String()
    var strSpa5Img = String()
    var strSpa6Img = String()
    var strSpa7Img = String()
    var strSpa8Img = String()
    var strSpa9Img = String()
    
    //For Image CoreData
    var dataPortableSpaImg = NSData()
    var dataMainSpaImg = NSData()
    var dataEquipmentImg = NSData()
    var dataEquipRoomImg = NSData()
    var dataEquipClearImg = NSData()
    var dataEquipElementImg = NSData()
    var dataEquipUVImg = NSData()
    
    var dataSpa0Img = NSData()
    var dataSpa1Img = NSData()
    var dataSpa2Img = NSData()
    var dataSpa3Img = NSData()
    var dataSpa4Img = NSData()
    var dataSpa5Img = NSData()
    var dataSpa6Img = NSData()
    var dataSpa7Img = NSData()
    var dataSpa8Img = NSData()
    var dataSpa9Img = NSData()
    
    //For Options
    var strMainSpaOpt = String()
    var strEquipmentOpt = String()
    var strEquipRoomOpt = String()
    var strEquipClearOpt = String()
    var strEquipElementOpt = String()
    var strEquipUVOpt = String()
    
    var strSpa0Opt = String()
    var strSpa1Opt = String()
    var strSpa2Opt = String()
    var strSpa3Opt = String()
    var strSpa4Opt = String()
    var strSpa5Opt = String()
    var strSpa6Opt = String()
    var strSpa7Opt = String()
    var strSpa8Opt = String()
    var strSpa9Opt = String()
    
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.prepareFormInspectionSpaData()
    }
    
    func prepareFormInspectionSpaData() {
        for _ in 0..<9 {
            let obj = formInspectionPoolData()
            self.secPortable.append(obj)
        }
        for _ in 0..<10 {
            let obj = formInspectionPoolData()
            self.secSPA.append(obj)
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
        let indexOfCell = self.tblSPA.indexPath(for: cell)
        print("Clicked Index : \(String(describing: indexOfCell?.row))")
        
        fetchIndexForSubSpaUpload = -1
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
    
    @objc func btnSpaImgUpload(_ sender: Any) {
        print("Button pressed 👍 ")
        let btn = sender as! UIButton
        let cell = btn.superview?.superview?.superview as! UITableViewCell
        let tblWall = self.view.viewWithTag(25) as! UITableView
        let indexOfCell = tblWall.indexPath(for: cell)
        print("Clicked Index : \(String(describing: indexOfCell?.row))")
        fetchIndexForUpload = -1
        fetchIndexForSubSpaUpload = (indexOfCell?.row)!
        
        print("Upload Index : \(String(describing: fetchIndexForSubSpaUpload))")
        
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
        //self.postInspectPoolSpa()
        if UIDevice.current.userInterfaceIdiom == .phone {
            let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
            let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectSolar") as! InspectSolarVC
            self.navigationController?.pushViewController(formVC, animated: true)
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
            let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectSolar") as! InspectSolarVC
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
                    
                    managedObject.setValue(dataPortableSpaImg, forKey: "portableSpaImage")
                    managedObject.setValue(strMainSpaOpt, forKey: "mainSpaOption")
                    managedObject.setValue(dataMainSpaImg, forKey: "mainSpaImage")
                    managedObject.setValue(self.secPortable[Portable.mainSpa.rawValue].formTextValue, forKey: "mainSpaData")
                    managedObject.setValue(dataEquipmentImg, forKey: "equipmentImage")
                    managedObject.setValue(strEquipRoomOpt, forKey: "equipRoomOption")
                    managedObject.setValue(dataEquipRoomImg, forKey: "equipRoomImage")
                    managedObject.setValue( self.secPortable[Portable.equipRoom.rawValue].formTextValue, forKey: "equipRoomData")
                    managedObject.setValue(strEquipClearOpt, forKey: "equipClearOption")
                    managedObject.setValue(dataEquipClearImg, forKey: "equipClearImage")
                    managedObject.setValue(self.secPortable[Portable.equipClear.rawValue].formTextValue, forKey: "equipClearData")
                    managedObject.setValue(strEquipElementOpt, forKey: "equipElementOption")
                    managedObject.setValue(dataEquipElementImg, forKey: "equipElementImage")
                    managedObject.setValue(self.secPortable[Portable.equipElement.rawValue].formTextValue, forKey: "equipElementData")
                    managedObject.setValue(strEquipUVOpt, forKey: "equipUVOption")
                    managedObject.setValue(dataEquipUVImg, forKey: "equipUVImage")
                    managedObject.setValue(self.secPortable[Portable.equipUV.rawValue].formTextValue, forKey: "equipUVData")
                    managedObject.setValue(strSpa0Opt, forKey: "spa0Option")
                    managedObject.setValue(dataSpa0Img, forKey: "spa0Image")
                    managedObject.setValue(self.secSPA[SPA.spa0.rawValue].formTextValue, forKey: "spa0Data")
                    managedObject.setValue(strSpa1Opt, forKey: "spa1Option")
                    managedObject.setValue(dataSpa1Img, forKey: "spa1Image")
                    managedObject.setValue(self.secSPA[SPA.spa1.rawValue].formTextValue, forKey: "spa1Data")
                    managedObject.setValue(strSpa2Opt, forKey: "spa2Option")
                    managedObject.setValue(dataSpa2Img, forKey: "spa2Image")
                    managedObject.setValue(self.secSPA[SPA.spa2.rawValue].formTextValue, forKey: "spa2Data")
                    managedObject.setValue(strSpa3Opt, forKey: "spa3Option")
                    managedObject.setValue(dataSpa3Img, forKey: "spa3Image")
                    managedObject.setValue(self.secSPA[SPA.spa3.rawValue].formTextValue, forKey: "spa3Data")
                    managedObject.setValue(strSpa4Opt, forKey: "spa4Option")
                    managedObject.setValue(dataSpa4Img, forKey: "spa4Image")
                    managedObject.setValue(self.secSPA[SPA.spa4.rawValue].formTextValue, forKey: "spa4Data")
                    managedObject.setValue(strSpa5Opt, forKey: "spa5Option")
                    managedObject.setValue(dataSpa5Img, forKey: "spa5Image")
                    managedObject.setValue(self.secSPA[SPA.spa5.rawValue].formTextValue, forKey: "spa5Data")
                    managedObject.setValue(strSpa6Opt, forKey: "spa6Option")
                    managedObject.setValue(dataSpa6Img, forKey: "spa6Image")
                    managedObject.setValue(self.secSPA[SPA.spa6.rawValue].formTextValue, forKey: "spa6Data")
                    managedObject.setValue(strSpa7Opt, forKey: "spa7Option")
                    managedObject.setValue(dataSpa7Img, forKey: "spa7Image")
                    managedObject.setValue(self.secSPA[SPA.spa7.rawValue].formTextValue, forKey: "spa7Data")
                    managedObject.setValue(strSpa8Opt, forKey: "spa8Option")
                    managedObject.setValue(dataSpa8Img, forKey: "spa8Image")
                    managedObject.setValue(self.secSPA[SPA.spa8.rawValue].formTextValue, forKey: "spa8Data")
                    managedObject.setValue(strSpa9Opt, forKey: "spa9Option")
                    managedObject.setValue(dataSpa9Img, forKey: "spa9Image")
                    managedObject.setValue(self.secSPA[SPA.spa9.rawValue].formTextValue, forKey: "spa9Data")
                    
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
                        print("Data of InspectPortableSpaVC:: \(data)")
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
                        self.strPortableSpaImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 1 {
                        self.strMainSpaImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 3 {
                        self.strEquipmentImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 5 {
                        self.strEquipRoomImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 6 {
                        self.strEquipClearImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 7 {
                        self.strEquipElementImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 8 {
                        self.strEquipUVImg = String(describing: data!)
                    }
                    if self.fetchIndexForSubSpaUpload == 0 {
                        self.strSpa0Img = String(describing: data!)
                    } else if self.fetchIndexForSubSpaUpload == 1 {
                        self.strSpa1Img = String(describing: data!)
                    } else if self.fetchIndexForSubSpaUpload == 2 {
                        self.strSpa2Img = String(describing: data!)
                    } else if self.fetchIndexForSubSpaUpload == 3 {
                        self.strSpa3Img = String(describing: data!)
                    } else if self.fetchIndexForSubSpaUpload == 4 {
                        self.strSpa4Img = String(describing: data!)
                    } else if self.fetchIndexForSubSpaUpload == 5 {
                        self.strSpa5Img = String(describing: data!)
                    } else if self.fetchIndexForSubSpaUpload == 6 {
                        self.strSpa6Img = String(describing: data!)
                    } else if self.fetchIndexForSubSpaUpload == 7 {
                        self.strSpa7Img = String(describing: data!)
                    } else if self.fetchIndexForSubSpaUpload == 8 {
                        self.strSpa8Img = String(describing: data!)
                    } else if self.fetchIndexForSubSpaUpload == 9 {
                        self.strSpa9Img = String(describing: data!)
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
    
    func postInspectPoolSpa() {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        
        let return_id = UserDefaults.standard.value(forKey: "returnKeyForInspection")
        
        let inspectSpaDetails:  NSMutableDictionary = [
            "return_data_id"    : return_id!,
            "portableSpaImage"  : strPortableSpaImg,
            "mainSpaOption"     : strMainSpaOpt,
            "mainSpaImage"      : strMainSpaImg,
            "mainSpaData"       : self.secPortable[Portable.mainSpa.rawValue].formTextValue,
            "equipmentImage"    : strEquipmentImg,
            "equipRoomOption"   : strEquipRoomOpt,
            "equipRoomImage"    : strEquipRoomImg,
            "equipRoomData"     : self.secPortable[Portable.equipRoom.rawValue].formTextValue,
            "equipClearOption"  : strEquipClearOpt,
            "equipClearImage"   : strEquipClearImg,
            "equipClearData"    : self.secPortable[Portable.equipClear.rawValue].formTextValue,
            "equipElementOption": strEquipElementOpt,
            "equipElementImage" : strEquipElementImg,
            "equipElementData"  : self.secPortable[Portable.equipElement.rawValue].formTextValue,
            "equipUVOption"     : strEquipUVOpt,
            "equipUVImage"      : strEquipUVImg,
            "equipUVData"       : self.secPortable[Portable.equipUV.rawValue].formTextValue,
            "spa0Option"        : strSpa0Opt,
            "spa0Image"         : strSpa0Img,
            "spa0Data"          : self.secSPA[SPA.spa0.rawValue].formTextValue,
            "spa1Option"        : strSpa1Opt,
            "spa1Image"         : strSpa1Img,
            "spa1Data"          : self.secSPA[SPA.spa1.rawValue].formTextValue,
            "spa2Option"        : strSpa2Opt,
            "spa2Image"         : strSpa2Img,
            "spa2Data"          : self.secSPA[SPA.spa2.rawValue].formTextValue,
            "spa3Option"        : strSpa3Opt,
            "spa3Image"         : strSpa3Img,
            "spa4Option"        : strSpa4Opt,
            "spa4Image"         : strSpa4Img,
            "spa4Data"          : self.secSPA[SPA.spa4.rawValue].formTextValue,
            "spa5Option"        : strSpa5Opt,
            "spa5Image"         : strSpa5Img,
            "spa5Data"          : self.secSPA[SPA.spa5.rawValue].formTextValue,
            "spa6Option"        : strSpa6Opt,
            "spa6Image"         : strSpa6Img,
            "spa6Data"          : self.secSPA[SPA.spa6.rawValue].formTextValue,
            "spa7Option"        : strSpa7Opt,
            "spa7Image"         : strSpa7Img,
            "spa7Data"          : self.secSPA[SPA.spa7.rawValue].formTextValue,
            "spa8Option"        : strSpa8Opt,
            "spa8Image"         : strSpa8Img,
            "spa8Data"          : self.secSPA[SPA.spa8.rawValue].formTextValue,
            "spa9Option"        : strSpa9Opt,
            "spa9Image"         : strSpa9Img,
            "spa9Data"          : self.secSPA[SPA.spa9.rawValue].formTextValue,
        ]
        
        print("inspectSpaDetails :: \(inspectSpaDetails)")
        //if sharedExtension.connectedToNetwork() {
        ApiManager.sharedInstanceAPI.PostInspectPortableSpa(postId: 1, spaDetails: inspectSpaDetails, onSuccess: { json in
            DispatchQueue.main.async {
                print("InspectionSPADetails json :: \(String(describing: json))")
                DispatchQueue.main.async(execute: {() -> Void in
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectSolar") as! InspectSolarVC
                        self.navigationController?.pushViewController(formVC, animated: true)
                    } else if UIDevice.current.userInterfaceIdiom == .pad {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectSolar") as! InspectSolarVC
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

extension InspectPortableSpaVC: OpalImagePickerControllerDelegate {
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
                                self.arrPortableSpaImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 1 {
                                self.arrMainSpaImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataMainSpaImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 3 {
                                self.arrEquipmentImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataEquipmentImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 5 {
                                self.arrEquipRoomImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataEquipRoomImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 6 {
                                self.arrEquipClearImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataEquipClearImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 7 {
                                self.arrEquipElementImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataEquipElementImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 8 {
                                self.arrEquipUVImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataEquipUVImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            }
                            
                            if self.fetchIndexForSubSpaUpload == 0 {
                                self.arrSpa0Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSpa0Img = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubSpaUpload == 1 {
                                self.arrSpa1Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSpa1Img = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubSpaUpload == 2 {
                                self.arrSpa2Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSpa2Img = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubSpaUpload == 3 {
                                self.arrSpa3Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSpa3Img = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubSpaUpload == 4 {
                                self.arrSpa4Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSpa4Img = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubSpaUpload == 5 {
                                self.arrSpa5Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSpa5Img = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubSpaUpload == 6 {
                                self.arrSpa6Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSpa6Img = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubSpaUpload == 7 {
                                self.arrSpa7Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSpa7Img = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubSpaUpload == 8 {
                                self.arrSpa8Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSpa8Img = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubSpaUpload == 9 {
                                self.arrSpa9Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSpa9Img = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
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
                self.tblSPA.reloadData()
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


extension InspectPortableSpaVC: UIImagePickerControllerDelegate {
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
            self.arrPortableSpaImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 1 {
            self.arrMainSpaImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataMainSpaImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 3 {
            self.arrEquipmentImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataEquipmentImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 5 {
            self.arrEquipRoomImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataEquipRoomImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 6 {
            self.arrEquipClearImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)

           self.dataEquipClearImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 7 {
            self.arrEquipElementImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataEquipElementImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 8 {
            self.arrEquipUVImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataEquipUVImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        }
        
        if self.fetchIndexForSubSpaUpload == 0 {
            self.arrSpa0Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSpa0Img = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForSubSpaUpload == 1 {
            self.arrSpa1Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSpa1Img = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForSubSpaUpload == 2 {
            self.arrSpa2Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSpa2Img = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForSubSpaUpload == 3 {
            self.arrSpa3Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSpa3Img = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForSubSpaUpload == 4 {
            self.arrSpa4Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSpa4Img = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForSubSpaUpload == 5 {
            self.arrSpa5Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSpa5Img = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForSubSpaUpload == 6 {
            self.arrSpa6Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSpa6Img = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForSubSpaUpload == 7 {
            self.arrSpa7Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSpa7Img = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForSubSpaUpload == 8 {
            self.arrSpa8Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSpa8Img = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForSubSpaUpload == 9 {
            self.arrSpa9Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSpa9Img = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        }
        
        self.tblSPA.reloadData()
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
}

extension InspectPortableSpaVC: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        var cell = UITableViewCell()
        cell = (textView.superview?.superview as? UITableViewCell)!
        
        if let portableTblCell = cell as? PortableSpaTableCell {
            if let textView = portableTblCell.txtOther {
                self.secPortable[Portable.mainSpa.rawValue].formTextValue = (textView.text)!
            }
        } else if let portableTblCell = cell as? EquipRoomTableCell {
            if let textView = portableTblCell.txtOther {
                self.secPortable[Portable.equipRoom.rawValue].formTextValue = (textView.text)!
            }
        } else if let portableTblCell = cell as? EquipClearTableCell {
            if let textView = portableTblCell.txtOther {
                self.secPortable[Portable.equipClear.rawValue].formTextValue = (textView.text)!
            }
        } else if let portableTblCell = cell as? EquipElementTableCell {
            if let textView = portableTblCell.txtOther {
                self.secPortable[Portable.equipElement.rawValue].formTextValue = (textView.text)!
            }
        } else if let portableTblCell = cell as? EquipUvTableCell {
            if let textView = portableTblCell.txtOther {
                self.secPortable[Portable.equipUV.rawValue].formTextValue = (textView.text)!
            }
        }
        
        if let spaTblCell = cell as? Spa0TableCell {
            if let textView = spaTblCell.txtOther {
                self.secSPA[SPA.spa0.rawValue].formTextValue = (textView.text)!
            }
        } else if let spaTblCell = cell as? Spa1TableCell {
            if let textView = spaTblCell.txtOther {
                self.secSPA[SPA.spa1.rawValue].formTextValue = (textView.text)!
            }
        } else if let spaTblCell = cell as? Spa2TableCell {
            if let textView = spaTblCell.txtOther {
                self.secSPA[SPA.spa2.rawValue].formTextValue = (textView.text)!
            }
        } else if let spaTblCell = cell as? Spa4TableCell {
            if let textView = spaTblCell.txtOther {
                self.secSPA[SPA.spa4.rawValue].formTextValue = (textView.text)!
            }
        } else if let spaTblCell = cell as? Spa5TableCell {
            if let textView = spaTblCell.txtOther {
                self.secSPA[SPA.spa5.rawValue].formTextValue = (textView.text)!
            }
        } else if let spaTblCell = cell as? Spa6TableCell {
            if let textView = spaTblCell.txtOther {
                self.secSPA[SPA.spa6.rawValue].formTextValue = (textView.text)!
            }
        } else if let spaTblCell = cell as? Spa7TableCell {
            if let textView = spaTblCell.txtOther {
                self.secSPA[SPA.spa7.rawValue].formTextValue = (textView.text)!
            }
        } else if let spaTblCell = cell as? Spa8TableCell {
            if let textView = spaTblCell.txtOther {
                self.secSPA[SPA.spa8.rawValue].formTextValue = (textView.text)!
            }
        } else if let spaTblCell = cell as? Spa9TableCell {
            if let textView = spaTblCell.txtOther {
                self.secSPA[SPA.spa9.rawValue].formTextValue = (textView.text)!
            }
        }
    }
}

extension InspectPortableSpaVC: UITableViewDataSource, UITableViewDelegate {
    //MARK:- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 25 {
            return 10
        } else {
            return 10
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 25 {
            if indexPath.row == 0 {
                let spaCell = tableView.dequeueReusableCell(withIdentifier: "Spa0Cell", for: indexPath) as! Spa0TableCell
                
                spaCell.lblHeader.text = "Is all equipment functioning properly?"

                spaCell.btnUpload.addTarget(self, action: #selector(btnSpaImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                spaCell.collectionVw.arrItems = arrSpa0Img
                spaCell.collectionVw.delegateItemCollection = self
                spaCell.collectionVw.reloadImageCollection()
                
                if arrSpa0Img.count > 0 {
                    spaCell.btnUpload.isHidden = true
                    spaCell.collectionVw.isHidden = false
                } else {
                    spaCell.btnUpload.isHidden = false
                    spaCell.collectionVw.isHidden = true
                }
                
                spaCell.delegateSpa0 = self
                spaCell.txtOther.delegate = self
                
                return spaCell
            } else if indexPath.row == 1 {
                let spaCell = tableView.dequeueReusableCell(withIdentifier: "Spa1Cell", for: indexPath) as! Spa1TableCell
                
                spaCell.lblHeader.text = "Is the water level at the proper height?"
                
                spaCell.btnUpload.addTarget(self, action: #selector(btnSpaImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                spaCell.collectionVw.arrItems = arrSpa1Img
                spaCell.collectionVw.delegateItemCollection = self
                spaCell.collectionVw.reloadImageCollection()
                
                if arrSpa1Img.count > 0 {
                    spaCell.btnUpload.isHidden = true
                    spaCell.collectionVw.isHidden = false
                } else {
                    spaCell.btnUpload.isHidden = false
                    spaCell.collectionVw.isHidden = true
                }
                
                spaCell.delegateSpa1 = self
                spaCell.txtOther.delegate = self
                
                return spaCell
            } else if indexPath.row == 2 {
                let spaCell = tableView.dequeueReusableCell(withIdentifier: "Spa2Cell", for: indexPath) as! Spa2TableCell
                
                spaCell.lblHeader.text = "Is the main drain visible and VGB compliant?"
                
                spaCell.btnUpload.addTarget(self, action: #selector(btnSpaImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                spaCell.collectionVw.arrItems = arrSpa2Img
                spaCell.collectionVw.delegateItemCollection = self
                spaCell.collectionVw.reloadImageCollection()
                
                if arrSpa2Img.count > 0 {
                    spaCell.btnUpload.isHidden = true
                    spaCell.collectionVw.isHidden = false
                } else {
                    spaCell.btnUpload.isHidden = false
                    spaCell.collectionVw.isHidden = true
                }
                
                spaCell.delegateSpa2 = self
                spaCell.txtOther.delegate = self
                
                return spaCell
            } else if indexPath.row == 3 {
                let spaCell = tableView.dequeueReusableCell(withIdentifier: "Spa3Cell", for: indexPath) as! Spa3TableCell
                
                spaCell.lblHeader.text = "What is the condition of the water?"
                
                spaCell.lbl1.text = "Clear"
                spaCell.lbl2.text = "Cloudy"
                spaCell.lbl3.text = "Murky"
                spaCell.lbl4.text = "Green Algae"
                
                spaCell.btnUpload.addTarget(self, action: #selector(btnSpaImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                spaCell.collectionVw.arrItems = arrSpa3Img
                spaCell.collectionVw.delegateItemCollection = self
                spaCell.collectionVw.reloadImageCollection()
                
                if arrSpa3Img.count > 0 {
                    spaCell.btnUpload.isHidden = true
                    spaCell.collectionVw.isHidden = false
                } else {
                    spaCell.btnUpload.isHidden = false
                    spaCell.collectionVw.isHidden = true
                }
                
                spaCell.delegateSpa3 = self
                
                return spaCell
            } else if indexPath.row == 4 {
                let spaCell = tableView.dequeueReusableCell(withIdentifier: "Spa4Cell", for: indexPath) as! Spa4TableCell
                
                spaCell.lblHeader.text = "What is the Spa constructed of?"
                
                spaCell.lbl1.text = "Fiberglass"
                spaCell.lbl2.text = "Acrylic"
                spaCell.lbl3.text = "Stainless"
                spaCell.lbl4.text = "Other"
                
                
                spaCell.btnUpload.addTarget(self, action: #selector(btnSpaImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                spaCell.collectionVw.arrItems = arrSpa4Img
                spaCell.collectionVw.delegateItemCollection = self
                spaCell.collectionVw.reloadImageCollection()
                
                if arrSpa4Img.count > 0 {
                    spaCell.btnUpload.isHidden = true
                    spaCell.collectionVw.isHidden = false
                } else {
                    spaCell.btnUpload.isHidden = false
                    spaCell.collectionVw.isHidden = true
                }
                
                spaCell.delegateSpa4 = self
                
                return spaCell
            } else if indexPath.row == 5 {
                let spaCell = tableView.dequeueReusableCell(withIdentifier: "Spa5Cell", for: indexPath) as! Spa5TableCell
                
                spaCell.lblHeader.text = "Is the surface of the spa rough to the touch?"
                
                spaCell.btnUpload.addTarget(self, action: #selector(btnSpaImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                spaCell.collectionVw.arrItems = arrSpa5Img
                spaCell.collectionVw.delegateItemCollection = self
                spaCell.collectionVw.reloadImageCollection()
                
                if arrSpa5Img.count > 0 {
                    spaCell.btnUpload.isHidden = true
                    spaCell.collectionVw.isHidden = false
                } else {
                    spaCell.btnUpload.isHidden = false
                    spaCell.collectionVw.isHidden = true
                }
                
                spaCell.delegateSpa5 = self
                spaCell.txtOther.delegate = self
                
                return spaCell
            } else if indexPath.row == 6 {
                let spaCell = tableView.dequeueReusableCell(withIdentifier: "Spa6Cell", for: indexPath) as! Spa6TableCell
                
                spaCell.lblHeader.text = "The surface condition is:"
                
                spaCell.lbl1.text = "Good"
                spaCell.lbl2.text = "Warped"
                spaCell.lbl3.text = "Flaking/chipping/peeling"
                
                spaCell.btnUpload.addTarget(self, action: #selector(btnSpaImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                spaCell.collectionVw.arrItems = arrSpa6Img
                spaCell.collectionVw.delegateItemCollection = self
                spaCell.collectionVw.reloadImageCollection()
                
                if arrSpa6Img.count > 0 {
                    spaCell.btnUpload.isHidden = true
                    spaCell.collectionVw.isHidden = false
                } else {
                    spaCell.btnUpload.isHidden = false
                    spaCell.collectionVw.isHidden = true
                }
                
                spaCell.delegateSpa6 = self
                spaCell.txtOther.delegate = self
                
                return spaCell
            } else if indexPath.row == 7 {
                let spaCell = tableView.dequeueReusableCell(withIdentifier: "Spa7Cell", for: indexPath) as! Spa7TableCell
                
                spaCell.lblHeader.text = "Is spa properly grounded and bonded?"
                
                spaCell.btnUpload.addTarget(self, action: #selector(btnSpaImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                spaCell.collectionVw.arrItems = arrSpa7Img
                spaCell.collectionVw.delegateItemCollection = self
                spaCell.collectionVw.reloadImageCollection()
                
                if arrSpa7Img.count > 0 {
                    spaCell.btnUpload.isHidden = true
                    spaCell.collectionVw.isHidden = false
                } else {
                    spaCell.btnUpload.isHidden = false
                    spaCell.collectionVw.isHidden = true
                }
                
                spaCell.delegateSpa7 = self
                spaCell.txtOther.delegate = self
                
                return spaCell
            } else if indexPath.row == 8 {
                let spaCell = tableView.dequeueReusableCell(withIdentifier: "Spa8Cell", for: indexPath) as! Spa8TableCell
                
                spaCell.lblHeader.text = "Is wiring covered and in good condition?"

                spaCell.btnUpload.addTarget(self, action: #selector(btnSpaImgUpload(_:)), for: UIControl.Event.touchUpInside)

                spaCell.collectionVw.arrItems = arrSpa8Img
                spaCell.collectionVw.delegateItemCollection = self
                spaCell.collectionVw.reloadImageCollection()

                if arrSpa8Img.count > 0 {
                  spaCell.btnUpload.isHidden = true
                  spaCell.collectionVw.isHidden = false
                } else {
                  spaCell.btnUpload.isHidden = false
                  spaCell.collectionVw.isHidden = true
                }
                
                spaCell.delegateSpa8 = self
                spaCell.txtOther.delegate = self
                
                return spaCell
            } else {
                let spaCell = tableView.dequeueReusableCell(withIdentifier: "Spa9Cell", for: indexPath) as! Spa9TableCell
                
                spaCell.lblHeader.text = "Does spa have a childproo barrier and locking cover?"

                spaCell.btnUpload.addTarget(self, action: #selector(btnSpaImgUpload(_:)), for: UIControl.Event.touchUpInside)

                spaCell.collectionVw.arrItems = arrSpa9Img
                spaCell.collectionVw.delegateItemCollection = self
                spaCell.collectionVw.reloadImageCollection()

                if arrSpa9Img.count > 0 {
                  spaCell.btnUpload.isHidden = true
                  spaCell.collectionVw.isHidden = false
                } else {
                  spaCell.btnUpload.isHidden = false
                  spaCell.collectionVw.isHidden = true
                }
                
                spaCell.delegateSpa9 = self
                spaCell.txtOther.delegate = self
                
                return spaCell
            }
        } else {
            if indexPath.row == 0 {
                let cameraCell = tableView.dequeueReusableCell(withIdentifier: "CameraCell", for: indexPath) as! CameraTableCell
                
                cameraCell.lblHeader.text = "Portable SPA"
                
                if UIDevice.current.userInterfaceIdiom == .phone {
                    cameraCell.lblHeader.font = UIFont.init(name: "Roboto-bold", size: 16.0)
                } else {
                    cameraCell.lblHeader.font = UIFont.init(name: "Roboto-bold", size: 24.0)
                }
                
                cameraCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

                cameraCell.collectionVw.arrItems = arrPortableSpaImg
                cameraCell.collectionVw.delegateItemCollection = self
                cameraCell.collectionVw.reloadImageCollection()
                
                if arrPortableSpaImg.count > 0 {
                    cameraCell.btnUpload.isHidden = true
                    cameraCell.collectionVw.isHidden = false
                } else {
                    cameraCell.btnUpload.isHidden = false
                    cameraCell.collectionVw.isHidden = true
                }
                
                return cameraCell
            } else if indexPath.row == 1 {
                let spaCell = tableView.dequeueReusableCell(withIdentifier: "PortableSpaCell", for: indexPath) as! PortableSpaTableCell
                
                spaCell.lblHeader.text = "Is there a portable spa?"
                
                spaCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                spaCell.collectionVw.arrItems = arrMainSpaImg
                spaCell.collectionVw.delegateItemCollection = self
                spaCell.collectionVw.reloadImageCollection()
                
                if arrMainSpaImg.count > 0 {
                    spaCell.btnUpload.isHidden = true
                    spaCell.collectionVw.isHidden = false
                } else {
                    spaCell.btnUpload.isHidden = false
                    spaCell.collectionVw.isHidden = true
                }
                
                if strMainSpaOpt == "Yes" {
                    spaCell.tblSubVw.delegate = self
                    spaCell.tblSubVw.dataSource = self
                    
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        spaCell.tblHeightConstraint.constant = 345*8+412+335//(355*8+412+365)
                    } else {
                        spaCell.tblHeightConstraint.constant = 600*8+600+600
                    }
                    spaCell.tblSubVw.reloadData()
                } else {
                    spaCell.tblHeightConstraint.constant = 0
                }
                
                spaCell.delegateSpa = self
                spaCell.txtOther.delegate = self
                
                return spaCell
            } else if indexPath.row == 2 {
                let headerView : UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "CustomHeaderCell")!
                
                let lblHeaderTitle = headerView.viewWithTag(10) as! UILabel
                lblHeaderTitle.textColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.2352941176, alpha: 1)
                
                if UIDevice.current.userInterfaceIdiom == .phone {
                    lblHeaderTitle.font = UIFont.init(name: "Roboto", size: 13.0)
                } else {
                    lblHeaderTitle.font = UIFont.init(name: "Roboto", size: 24.0)
                }
                
                
                // set this however is appropriate for your app's model
                lblHeaderTitle.text = "Always recommend child proof barrier"

                return headerView
            } else if indexPath.row == 3 {
                let cameraCell = tableView.dequeueReusableCell(withIdentifier: "CameraCell", for: indexPath) as! CameraTableCell
                
                cameraCell.lblHeader.text = "Equipment area of pool/SPA"
                if UIDevice.current.userInterfaceIdiom == .phone {
                    cameraCell.lblHeader.font = UIFont.init(name: "Roboto", size: 16.0)
                } else {
                    cameraCell.lblHeader.font = UIFont.init(name: "Roboto", size: 24.0)
                }

                cameraCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

                cameraCell.collectionVw.arrItems = arrEquipmentImg
                cameraCell.collectionVw.delegateItemCollection = self
                cameraCell.collectionVw.reloadImageCollection()
                
                if arrEquipmentImg.count > 0 {
                    cameraCell.btnUpload.isHidden = true
                    cameraCell.collectionVw.isHidden = false
                } else {
                    cameraCell.btnUpload.isHidden = false
                    cameraCell.collectionVw.isHidden = true
                }
                
                return cameraCell
            } else if indexPath.row == 4 {
                let headerView : UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "CustomHeaderCell")!
                
                let lblHeaderTitle = headerView.viewWithTag(10) as! UILabel
                lblHeaderTitle.textColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.2352941176, alpha: 1)
                lblHeaderTitle.numberOfLines = 2
                
                if UIDevice.current.userInterfaceIdiom == .phone {
                   lblHeaderTitle.font = UIFont.init(name: "Roboto", size: 13.0)
                } else {
                   lblHeaderTitle.font = UIFont.init(name: "Roboto", size: 24.0)
                }
                // set this however is appropriate for your app's model
                lblHeaderTitle.text = "Ran all features, accessories, pumps, blowers, automation, etc. and the following were noted below:"

                return headerView
            } else if indexPath.row == 5 {
                let equipCell = tableView.dequeueReusableCell(withIdentifier: "EquipRoomCell", for: indexPath) as! EquipRoomTableCell
                
                equipCell.lblHeader.text = "Does equipment area provide room for easy access?"
                
                equipCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                equipCell.collectionVw.arrItems = arrEquipRoomImg
                equipCell.collectionVw.delegateItemCollection = self
                equipCell.collectionVw.reloadImageCollection()
                if arrEquipRoomImg.count > 0 {
                    equipCell.btnUpload.isHidden = true
                    equipCell.collectionVw.isHidden = false
                } else {
                    equipCell.btnUpload.isHidden = false
                    equipCell.collectionVw.isHidden = true
                }
                
                equipCell.delegateEquipRoom = self
                equipCell.txtOther.delegate = self
                
                return equipCell
            } else if indexPath.row == 6 {
                let equipCell = tableView.dequeueReusableCell(withIdentifier: "EquipClearCell", for: indexPath) as! EquipClearTableCell
                            
                equipCell.lblHeader.text = "Is equipment area clear of debris and clutter?"
                
                equipCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                equipCell.collectionVw.arrItems = arrEquipClearImg
                equipCell.collectionVw.delegateItemCollection = self
                equipCell.collectionVw.reloadImageCollection()
                if arrEquipClearImg.count > 0 {
                    equipCell.btnUpload.isHidden = true
                    equipCell.collectionVw.isHidden = false
                } else {
                    equipCell.btnUpload.isHidden = false
                    equipCell.collectionVw.isHidden = true
                }
                
                equipCell.delegateEquipClear = self
                equipCell.txtOther.delegate = self
                
                return equipCell
            } else if indexPath.row == 7 {
                let equipCell = tableView.dequeueReusableCell(withIdentifier: "EquipElementCell", for: indexPath) as! EquipElementTableCell
                            
                equipCell.lblHeader.text = "Is equipment protect/covered from the elements?"
                
                equipCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

                equipCell.collectionVw.arrItems = arrEquipElementImg
                equipCell.collectionVw.delegateItemCollection = self
                equipCell.collectionVw.reloadImageCollection()
                if arrEquipElementImg.count > 0 {
                    equipCell.btnUpload.isHidden = true
                    equipCell.collectionVw.isHidden = false
                } else {
                    equipCell.btnUpload.isHidden = false
                    equipCell.collectionVw.isHidden = true
                }
                
                equipCell.delegateEquipElement = self
                equipCell.txtOther.delegate = self
                
                return equipCell
             } else if indexPath.row == 8 {
                let equipCell = tableView.dequeueReusableCell(withIdentifier: "EquipUvCell", for: indexPath) as! EquipUvTableCell
                
                equipCell.lblHeader.text = "Is the plumbing paint for UV protection?"
                
                equipCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                equipCell.collectionVw.arrItems = arrEquipUVImg
                equipCell.collectionVw.delegateItemCollection = self
                equipCell.collectionVw.reloadImageCollection()
                if arrEquipUVImg.count > 0 {
                    equipCell.btnUpload.isHidden = true
                    equipCell.collectionVw.isHidden = false
                } else {
                    equipCell.btnUpload.isHidden = false
                    equipCell.collectionVw.isHidden = true
                }
                
                equipCell.delegateEquipUv = self
                equipCell.txtOther.delegate = self
                
                return equipCell
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
                if indexPath.row == 3 {
                   return 300
                } else if indexPath.row == 4 {
                   return 445
                }
               else if indexPath.row == 6 {
                    return 385
                } else if indexPath.row == 9 {
                    return 335
                } else {//if indexPath.row == 1 {
                    return 345
                }
            } else {
                if indexPath.row == 0 {
                    return 185
                } else if indexPath.row == 1 {
                    if strMainSpaOpt == "Yes" {
                        return (345*8+412+335)+355
                    } else {
                        return 335
                    }
                } else if indexPath.row == 2 {
                    return 65
                } else if indexPath.row == 3 {
                    return 185
                } else if indexPath.row == 4 {
                    return 85
                } else if indexPath.row == 8 {
                    return 375
                } else if indexPath.row == 9 {
                    return 105
                } else {
                    return 355
                }
            }
        } else {            //.pad
            if tableView.tag == 25 {
               if indexPath.row == 3 {
                    return 530
               } else if indexPath.row == 4 {
                    return 710
               } else {
                    return 600
                }
            } else {
                if indexPath.row == 0 {
                    return 320
                } else if indexPath.row == 1 {
                    if strMainSpaOpt == "Yes" {
                        return (600*8+600+600)+615
                    } else {
                        return 615
                    }
                } else if indexPath.row == 2 {
                    return 85
                } else if indexPath.row == 3 {
                    return 530
                } else if indexPath.row == 4 {
                    return 710
                } else if indexPath.row == 6 {
                    return 600
                } else if indexPath.row == 8 {
                    return 600
                } else if indexPath.row == 9 {
                    return 175
                } else {
                    return 600
                }
            }
        }
    }
}

extension InspectPortableSpaVC: PortableSpaProtocol, Spa0Protocol, Spa1Protocol, Spa2Protocol, Spa3Protocol, Spa4Protocol, Spa5Protocol, Spa6Protocol, Spa7Protocol, Spa8Protocol, Spa9Protocol, EquipRoomProtocol, EquipClearProtocol, EquipElementProtocol, EquipUvProtocol {
    
    func didTapOnCellPortableSpa(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strMainSpaOpt = "Yes"
        } else if _btnDescribeTag == 1 {
            strMainSpaOpt = "No"
        }
        self.tblSPA.reloadData()
    }
    
    func didTapOnCellSpa0(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strSpa0Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strSpa0Opt = "No"
        }
        self.tblSPA.reloadData()
    }
    
    func didTapOnCellSpa1(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strSpa1Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strSpa1Opt = "No"
        }
        self.tblSPA.reloadData()
    }
    
    func didTapOnCellSpa2(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strSpa2Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strSpa2Opt = "No"
        }
        self.tblSPA.reloadData()
    }
    
    func didTapOnCellSpa3(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strSpa3Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strSpa3Opt = "No"
        }
        self.tblSPA.reloadData()
    }
    
    func didTapOnCellSpa4(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strSpa4Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strSpa4Opt = "No"
        }
        self.tblSPA.reloadData()
    }
    
    func didTapOnCellSpa5(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strSpa5Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strSpa5Opt = "No"
        }
        self.tblSPA.reloadData()
    }
    
    func didTapOnCellSpa6(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strSpa6Opt = "Good"
        } else if _btnDescribeTag == 1 {
            strSpa6Opt = "Warped"
        } else if _btnDescribeTag == 2 {
            strSpa6Opt = "Flaking/chipping/peeling"
        }
        self.tblSPA.reloadData()
    }
    
    func didTapOnCellSpa7(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strSpa7Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strSpa7Opt = "No"
        }
        self.tblSPA.reloadData()
    }
    
    func didTapOnCellSpa8(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strSpa8Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strSpa8Opt = "No"
        }
        self.tblSPA.reloadData()
    }
    
    func didTapOnCellSpa9(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strSpa9Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strSpa9Opt = "No"
        }
        self.tblSPA.reloadData()
    }
    
    func didTapOnCellEquipRoom(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strEquipRoomOpt = "Yes"
        } else if _btnDescribeTag == 1 {
            strEquipRoomOpt = "No"
        }
        self.tblSPA.reloadData()
    }
    
    func didTapOnCellEquipClear(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strEquipClearOpt = "Yes"
        } else if _btnDescribeTag == 1 {
            strEquipClearOpt = "No"
        }
        self.tblSPA.reloadData()
    }
    
    func didTapOnCellEquipElement(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strEquipElementOpt = "Yes"
        } else if _btnDescribeTag == 1 {
            strEquipElementOpt = "No"
        }
        self.tblSPA.reloadData()
    }
    
    func didTapOnCellEquipUv(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strEquipUVOpt = "Yes"
        } else if _btnDescribeTag == 1 {
            strEquipUVOpt = "No"
        }
        self.tblSPA.reloadData()
    }
    
}
