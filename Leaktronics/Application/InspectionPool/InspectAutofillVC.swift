//
//  InspectAutofillVC.swift
//  Leaktronics
//
//  Created by Abhishek Mullick on 06/05/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import CoreData
import DLRadioButton
import SVProgressHUD
import Alamofire
import Photos
import OpalImagePicker

class InspectAutofillVC: UIViewController, UINavigationControllerDelegate, UploadCollectionProtocol {
    
    @IBOutlet weak var tblAutofill: UITableView!
    
    var secAutoFill = [formInspectionPoolData]()
    var secAuto = [formInspectionPoolData]()
    var secOverFlow = [formInspectionPoolData]()
    
    enum AutoFill: Int {
        case autoFill = 0
        case overflow = 1
    }
    
    enum Auto: Int {
        case auto1 = 1
        case auto2 = 2
        case auto3 = 3
        case auto4 = 4
        case auto5 = 5
        case auto6 = 6
        case auto7 = 7
        case auto8 = 8
    }
    
    enum OverFlow: Int {
        case overflow0 = 0
        case overflow1 = 1
    }
    
    var fetchIndexForUpload: Int = -1
    var fetchIndexForSubFlowUpload: Int = -1
    var fetchIndexForSubAutoUpload: Int = -1
    
    
    var imagePicker = UIImagePickerController()
    var picker:UIImagePickerController? = UIImagePickerController()
    
    
    //For Images
    var arrMainAutofillImg: [CollectionImageObject] = []
    var arrMainOverFlowImg: [CollectionImageObject] = []
    var arrOverFlowImg: [CollectionImageObject] = []
    
    var arrImgOverFlow0: [CollectionImageObject] = []
    var arrImgOverFlow1: [CollectionImageObject] = []
    
    
    var arrImgAuto1: [CollectionImageObject] = []
    var arrImgAuto2: [CollectionImageObject] = []
    var arrImgAuto3: [CollectionImageObject] = []
    var arrImgAuto4: [CollectionImageObject] = []
    var arrImgAuto5: [CollectionImageObject] = []
    var arrImgAuto6: [CollectionImageObject] = []
    var arrImgAuto7: [CollectionImageObject] = []
    var arrImgAuto8: [CollectionImageObject] = []
    
    
    //For Image Server path
    var strMainAutofillImg = String()
    var strMainOverFlowImg = String()
    var strOverFlowImg = String()
    
    var strImgOverFlow0 = String()
    var strImgOverFlow1 = String()
    
    
    var strImgAuto1 = String()
    var strImgAuto2 = String()
    var strImgAuto3 = String()
    var strImgAuto4 = String()
    var strImgAuto5 = String()
    var strImgAuto6 = String()
    var strImgAuto7 = String()
    var strImgAuto8 = String()
    
    
    //For Image CoreData
    var dataMainAutofillImg = NSData()
    var dataMainOverFlowImg = NSData()
    var dataOverFlowImg = NSData()
    
    var dataImgOverFlow0 = NSData()
    var dataImgOverFlow1 = NSData()
    
    var dataImgAuto1 = NSData()
    var dataImgAuto2 = NSData()
    var dataImgAuto3 = NSData()
    var dataImgAuto4 = NSData()
    var dataImgAuto5 = NSData()
    var dataImgAuto6 = NSData()
    var dataImgAuto7 = NSData()
    var dataImgAuto8 = NSData()
    
    
    //For Optional Value
    var strOverflowOption = String()
    var strOverFlowOpt0 = String()
    var strOverFlowOpt1 = String()
    
    var strAutofillOption = String()
    var strAutoWaterOpt0 = String()
    var strAutofillOpt1 = String()
    var strAutofillOpt2 = String()
    var strAutofillOpt3 = String()
    var strAutofillOpt4 = String()
    var strAutofillOpt5 = String()
    var strAutofillOpt6 = String()
    var strAutofillOpt7 = String()
    var strAutofillOpt8 = String()
    
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.prepareFormInspectionAutoFillData()
    }
    
    func prepareFormInspectionAutoFillData() {
        for _ in 0..<11 {
            let obj = formInspectionPoolData()
            self.secAutoFill.append(obj)
        }
        for _ in 0..<9 {
            let obj = formInspectionPoolData()
            self.secAuto.append(obj)
        }
        for _ in 0..<9 {
            let obj = formInspectionPoolData()
            self.secOverFlow.append(obj)
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
        let indexOfCell = self.tblAutofill.indexPath(for: cell)
        print("Clicked Index : \(String(describing: indexOfCell?.row))")

        fetchIndexForUpload = (indexOfCell?.row)!
        fetchIndexForSubAutoUpload = -1
        fetchIndexForSubFlowUpload = -1
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
    
    @IBAction func btnAutoFillUpload(_ sender: Any) {
        print("Button pressed 👍 ")
        let btn = sender as! UIButton
        let cell = btn.superview?.superview?.superview as! UITableViewCell
        let tblAuto = self.view.viewWithTag(35) as! UITableView
        let indexOfCell = tblAuto.indexPath(for: cell)
        print("Clicked Index : \(String(describing: indexOfCell?.row))")
        fetchIndexForUpload = -1
        fetchIndexForSubAutoUpload = (indexOfCell?.row)!
        
        print("Upload Index : \(String(describing: fetchIndexForSubAutoUpload))")
        
        self.actionSheetPopUpForGalleryOpen()
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnOverFlowUpload(_ sender: Any) {
        print("Button pressed 👍 ")
        let btn = sender as! UIButton
        let cell = btn.superview?.superview?.superview as! UITableViewCell
        let tblFlow = self.view.viewWithTag(25) as! UITableView
        let indexOfCell = tblFlow.indexPath(for: cell)
        print("Clicked Index : \(String(describing: indexOfCell?.row))")
        fetchIndexForUpload = -1
        fetchIndexForSubFlowUpload = (indexOfCell?.row)!
        
        print("Upload Index : \(String(describing: fetchIndexForSubFlowUpload))")
        
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
        //self.postInspectAutoFill()
        if UIDevice.current.userInterfaceIdiom == .phone {
            let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
            let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectPortableSpa") as! InspectPortableSpaVC
            self.navigationController?.pushViewController(formVC, animated: true)
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
            let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectPortableSpa") as! InspectPortableSpaVC
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
                    
                    managedObject.setValue(dataMainAutofillImg, forKey: "mainAutofillImg")
                    managedObject.setValue(strAutofillOption, forKey: "autofillOption")
                    managedObject.setValue(dataMainOverFlowImg, forKey: "mainOverFlowImg")
                    managedObject.setValue(strOverflowOption, forKey: "overFlowOption")
                    managedObject.setValue(dataOverFlowImg, forKey: "overFlowImg")
                    managedObject.setValue(self.secAutoFill[AutoFill.overflow.rawValue].formTextValue, forKey: "overFlowData")
                    managedObject.setValue(strAutoWaterOpt0, forKey: "autoWaterOption0")
                    managedObject.setValue(strAutofillOpt1, forKey: "autofillOption1")
                    managedObject.setValue(dataImgAuto1, forKey: "autofillImage1")
                    managedObject.setValue(self.secAuto[Auto.auto1.rawValue].formTextValue, forKey: "autofill1Data")
                    managedObject.setValue(strAutofillOpt2, forKey: "autofillOption2")
                    managedObject.setValue(dataImgAuto2, forKey: "autofillImage2")
                    managedObject.setValue(self.secAuto[Auto.auto2.rawValue].formTextValue, forKey: "autofill2Data")
                    managedObject.setValue(strAutofillOpt3, forKey: "autofillOption3")
                    managedObject.setValue(dataImgAuto3, forKey: "autofillImage3")
                    managedObject.setValue(self.secAuto[Auto.auto3.rawValue].formTextValue, forKey: "autofill3Data")
                    managedObject.setValue(strAutofillOpt4, forKey: "autofillOption4")
                    managedObject.setValue(dataImgAuto4, forKey: "autofillImage4")
                    managedObject.setValue(self.secAuto[Auto.auto4.rawValue].formTextValue, forKey: "autofill4Data")
                    managedObject.setValue(strAutofillOpt5, forKey: "autofillOption5")
                    managedObject.setValue(dataImgAuto5, forKey: "autofillImage5")
                    managedObject.setValue(self.secAuto[Auto.auto5.rawValue].formTextValue, forKey: "autofill5Data")
                    managedObject.setValue(strAutofillOpt6, forKey: "autofillOption6")
                    managedObject.setValue(dataImgAuto6, forKey: "autofillImage6")
                    managedObject.setValue(self.secAuto[Auto.auto6.rawValue].formTextValue, forKey: "autofill6Data")
                    managedObject.setValue(strAutofillOpt7, forKey: "autofillOption7")
                    managedObject.setValue(dataImgAuto7, forKey: "autofillImage7")
                    managedObject.setValue(self.secAuto[Auto.auto7.rawValue].formTextValue, forKey: "autofill7Data")
                    managedObject.setValue(strAutofillOpt8, forKey: "autofillOption8")
                    managedObject.setValue(dataImgAuto8, forKey: "autofillImage8")
                    managedObject.setValue(self.secAuto[Auto.auto8.rawValue].formTextValue, forKey: "autofill8Data")
                    managedObject.setValue(strOverFlowOpt0, forKey: "overFlowOption0")
                    managedObject.setValue(dataImgOverFlow0, forKey: "overFlowImage0")
                    managedObject.setValue(self.secOverFlow[OverFlow.overflow0.rawValue].formTextValue, forKey: "overFlow0Data")
                    managedObject.setValue(strOverFlowOpt1, forKey: "overFlowOption1")
                    managedObject.setValue(dataImgOverFlow1, forKey: "overFlowImage1")
                    managedObject.setValue(self.secOverFlow[OverFlow.overflow1.rawValue].formTextValue, forKey: "overFlow1Data")
                                    
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
                        print("Data of InspectAutofillVC:: \(data)")
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
                        self.strMainAutofillImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 2 {
                        self.strMainOverFlowImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 3 {
                        self.strOverFlowImg = String(describing: data!)
                    }
                    
                    if self.fetchIndexForSubFlowUpload == 0 {
                        self.strImgOverFlow0 = String(describing: data!)
                    } else if self.fetchIndexForSubFlowUpload == 1 {
                        self.strImgOverFlow1 = String(describing: data!)
                    }
                    
                    if self.fetchIndexForSubAutoUpload == 1 {
                        self.strImgAuto1 = String(describing: data!)
                    } else if self.fetchIndexForSubAutoUpload == 2 {
                        self.strImgAuto2 = String(describing: data!)
                    } else if self.fetchIndexForSubAutoUpload == 3 {
                        self.strImgAuto3 = String(describing: data!)
                    } else if self.fetchIndexForSubAutoUpload == 4 {
                        self.strImgAuto4 = String(describing: data!)
                    } else if self.fetchIndexForSubAutoUpload == 5 {
                        self.strImgAuto5 = String(describing: data!)
                    } else if self.fetchIndexForSubAutoUpload == 6 {
                        self.strImgAuto6 = String(describing: data!)
                    } else if self.fetchIndexForSubAutoUpload == 7 {
                        self.strImgAuto7 = String(describing: data!)
                    } else if self.fetchIndexForSubAutoUpload == 8 {
                        self.strImgAuto8 = String(describing: data!)
                    }

                    SVProgressHUD.dismiss()
                }
            case .failure(let encodingError):
                print("error:\(encodingError)")
                SVProgressHUD.dismiss()
            }
        })
    }
    
    func postInspectAutoFill() {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        
        let return_id = UserDefaults.standard.value(forKey: "returnKeyForInspection")
        
        let inspectAutoFillDetails:  NSMutableDictionary = [
            "return_data_id"    : return_id!,
            "mainAutofillImg"   : strMainAutofillImg,
            "autofillOption"    : strAutofillOption,
            "mainOverFlowImg"   : strMainOverFlowImg,
            "overFlowOption"    : strOverflowOption,
            "overFlowImg"       : strOverFlowImg,
            "overFlowData"      : self.secAutoFill[AutoFill.overflow.rawValue].formTextValue,
            "autoWaterOption0"  : strAutoWaterOpt0,
            "autofillOption1"   : strAutofillOpt1,
            "autofillImage1"    : strImgAuto1,
            "autofill1Data"     : self.secAuto[Auto.auto1.rawValue].formTextValue,
            "autofillOption2"   : strAutofillOpt2,
            "autofillImage2"    : strImgAuto2,
            "autofill2Data"     : self.secAuto[Auto.auto2.rawValue].formTextValue,
            "autofillOption3"   : strAutofillOpt3,
            "autofillImage3"    : strImgAuto3,
            "autofill3Data"     : self.secAuto[Auto.auto3.rawValue].formTextValue,
            "autofillOption4"   : strAutofillOpt4,
            "autofillImage4"    : strImgAuto4,
            "autofill4Data"     : self.secAuto[Auto.auto4.rawValue].formTextValue,
            "autofillOption5"   : strAutofillOpt5,
            "autofillImage5"    : strImgAuto5,
            "autofill5Data"     : self.secAuto[Auto.auto5.rawValue].formTextValue,
            "autofillOption6"   : strAutofillOpt6,
            "autofillImage6"    : strImgAuto6,
            "autofill6Data"     : self.secAuto[Auto.auto6.rawValue].formTextValue,
            "autofillOption7"   : strAutofillOpt7,
            "autofillImage7"    : strImgAuto7,
            "autofill7Data"     : self.secAuto[Auto.auto7.rawValue].formTextValue,
            "autofillOption8"   : strAutofillOpt8,
            "autofillImage8"    : strImgAuto8,
            "autofill8Data"     : self.secAuto[Auto.auto8.rawValue].formTextValue,
            "overFlowOption0"   : strOverFlowOpt0,
            "overFlowImage0"    : strImgOverFlow0,
            "overFlow0Data"     : self.secOverFlow[OverFlow.overflow0.rawValue].formTextValue,
            "overFlowOption1"   : strOverFlowOpt1,
            "overFlowImage1"    : strImgOverFlow1,
            "overFlow1Data"     : self.secOverFlow[OverFlow.overflow1.rawValue].formTextValue,
        ]
        
        print("inspectAutoFillDetails :: \(inspectAutoFillDetails)")
//        //if sharedExtension.connectedToNetwork() {
        ApiManager.sharedInstanceAPI.PostInspectAutofill(postId: 1, autofillDetails: inspectAutoFillDetails, onSuccess: { json in
            DispatchQueue.main.async {
                print("InspectionAutoFillDetails json :: \(String(describing: json))")
                DispatchQueue.main.async(execute: {() -> Void in
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectPortableSpa") as! InspectPortableSpaVC
                        self.navigationController?.pushViewController(formVC, animated: true)
                    } else if UIDevice.current.userInterfaceIdiom == .pad {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectPortableSpa") as! InspectPortableSpaVC
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

extension InspectAutofillVC: OpalImagePickerControllerDelegate {
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
                                self.arrMainAutofillImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataMainAutofillImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 2 {
                                self.arrMainOverFlowImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataMainOverFlowImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 3 {
                                self.arrOverFlowImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataOverFlowImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            }
                            
                            if self.fetchIndexForSubAutoUpload == 1 {
                                self.arrImgAuto1.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataImgAuto1 = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubAutoUpload == 2 {
                                self.arrImgAuto2.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataImgAuto2 = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubAutoUpload == 3 {
                                self.arrImgAuto3.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataImgAuto3 = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubAutoUpload == 4 {
                                self.arrImgAuto4.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataImgAuto4 = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubAutoUpload == 5 {
                                self.arrImgAuto5.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataImgAuto5 = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubAutoUpload == 6 {
                                self.arrImgAuto6.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataImgAuto6 = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubAutoUpload == 7 {
                                self.arrImgAuto7.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataImgAuto7 = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubAutoUpload == 8 {
                                self.arrImgAuto8.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataImgAuto8 = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            }
                            
                            if self.fetchIndexForSubFlowUpload == 0 {
                                self.arrImgOverFlow0.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataImgOverFlow0 = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubFlowUpload == 1 {
                                self.arrImgOverFlow1.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataImgOverFlow1 = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
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
                self.tblAutofill.reloadData()
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

extension InspectAutofillVC: UIImagePickerControllerDelegate {
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
            self.arrMainAutofillImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)

            self.dataMainAutofillImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 2 {
            self.arrMainOverFlowImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)

            self.dataMainOverFlowImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 3 {
            self.arrOverFlowImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)

            self.dataOverFlowImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        }
        

        if self.fetchIndexForSubAutoUpload == 1 {
            self.arrImgAuto1.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)

            self.dataImgAuto1 = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForSubAutoUpload == 2 {
            self.arrImgAuto2.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)

            self.dataImgAuto2 = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForSubAutoUpload == 3 {
            self.arrImgAuto3.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)

            self.dataImgAuto3 = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForSubAutoUpload == 4 {
            self.arrImgAuto4.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)

            self.dataImgAuto4 = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForSubAutoUpload == 5 {
            self.arrImgAuto5.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)

            self.dataImgAuto5 = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForSubAutoUpload == 6 {
            self.arrImgAuto6.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)

            self.dataImgAuto6 = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForSubAutoUpload == 7 {
            self.arrImgAuto7.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)

            self.dataImgAuto7 = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForSubAutoUpload == 8 {
            self.arrImgAuto8.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)

            self.dataImgAuto8 = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        }
        
        if self.fetchIndexForSubFlowUpload == 0 {
            self.arrImgOverFlow0.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)

            self.dataImgOverFlow0 = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForSubFlowUpload == 1 {
            self.arrImgOverFlow1.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)

            self.dataImgOverFlow1 = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        }
        self.tblAutofill.reloadData()
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
}

extension InspectAutofillVC: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        var cell = UITableViewCell()
        cell = (textView.superview?.superview as? UITableViewCell)!
        
        if let InspectionOverflowTableCell = cell as? InspectionOverflowTableCell {
            if textView == InspectionOverflowTableCell.txtOverflow {
                self.secAutoFill[AutoFill.overflow.rawValue].formTextValue = (textView.text)!
            }
        }
        
        if let autoCell = cell as? AutofillAboveWaterlineTableCell {
            if textView == autoCell.txtAutofillWaterline {
                self.secAuto[Auto.auto1.rawValue].formTextValue = (textView.text)!
            }
        } else if let autoCell = cell as? AutofillLeakFreeTableCell {
            if textView == autoCell.txtAutofillLeakFree {
                self.secAuto[Auto.auto2.rawValue].formTextValue = (textView.text)!
            }
        } else if let autoCell = cell as? AutofillProperShutoutTableCell {
            if textView == autoCell.txtAutofillShutout {
                self.secAuto[Auto.auto3.rawValue].formTextValue = (textView.text)!
            }
        } else if let autoCell = cell as? AutofillBackflowTableCell {
            if textView == autoCell.txtAutofillBackflow {
                self.secAuto[Auto.auto4.rawValue].formTextValue = (textView.text)!
            }
        } else if let autoCell = cell as? AutofillMaintainanceAccessibleTableCell {
            if textView == autoCell.txtAutofillMaintenance {
                self.secAuto[Auto.auto5.rawValue].formTextValue = (textView.text)!
            }
        } else if let autoCell = cell as? AutofillExposedPlumbingLeakTableCell {
            if textView == autoCell.txtAutofillExposedLeak {
                self.secAuto[Auto.auto6.rawValue].formTextValue = (textView.text)!
            }
        } else if let autoCell = cell as? AutofillOverflowMountedTableCell {
            if textView == autoCell.txtAutofillMounted {
                self.secAuto[Auto.auto7.rawValue].formTextValue = (textView.text)!
            }
        } else if let autoCell = cell as? AutofillValveAdjustmentTableCell {
            if textView == autoCell.txtAutofillValveAdjust {
                self.secAuto[Auto.auto8.rawValue].formTextValue = (textView.text)!
            }
        }
        if let autoCell = cell as? OverflowPlumbedProperlyTableCell {
            if textView == autoCell.txtOverflowPlumbed {
                self.secOverFlow[OverFlow.overflow0.rawValue].formTextValue = (textView.text)!
            }
        } else if let autoCell = cell as? OverflowMountedHeightTableCell {
            if textView == autoCell.txtOverflowMountedHeight {
                self.secOverFlow[OverFlow.overflow1.rawValue].formTextValue = (textView.text)!
            }
        }
    }
}

extension InspectAutofillVC: UITableViewDataSource, UITableViewDelegate {
    //MARK:- UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 25 {
            return 2
        } else if tableView.tag == 35 {
            return 9
        } else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 35 {
            if indexPath.row == 0 {
                let autoFillCell = tableView.dequeueReusableCell(withIdentifier: "AutofillModeCell", for: indexPath) as! AutofillModeTableCell
                
                autoFillCell.delegateAutoMode = self
                
                return autoFillCell
            } else if indexPath.row == 1 {
                let autoFillCell = tableView.dequeueReusableCell(withIdentifier: "AutofillAboveWaterlineCell", for: indexPath) as! AutofillAboveWaterlineTableCell
                
                autoFillCell.btnUpload.addTarget(self, action: #selector(btnAutoFillUpload(_:)), for: UIControl.Event.touchUpInside)
                
                autoFillCell.delegateAutoWater = self
                
                autoFillCell.collectionvw.arrItems = arrImgAuto1
                autoFillCell.collectionvw.delegateItemCollection = self
                autoFillCell.collectionvw.reloadImageCollection()
                
                if arrImgAuto1.count > 0 {
                    autoFillCell.btnUpload.isHidden = true
                    autoFillCell.collectionvw.isHidden = false
                } else {
                    autoFillCell.btnUpload.isHidden = false
                    autoFillCell.collectionvw.isHidden = true
                }
                
                autoFillCell.delegateAutoWater = self
                autoFillCell.txtAutofillWaterline.delegate = self
                
                return autoFillCell
            } else if indexPath.row == 2 {
                let autoFillCell = tableView.dequeueReusableCell(withIdentifier: "AutofillLeakFreeCell", for: indexPath) as! AutofillLeakFreeTableCell

                autoFillCell.btnUpload.addTarget(self, action: #selector(btnAutoFillUpload(_:)), for: UIControl.Event.touchUpInside)
                
                autoFillCell.delegateAutoLeak = self
                
                autoFillCell.collectionvw.arrItems = arrImgAuto2
                autoFillCell.collectionvw.delegateItemCollection = self
                autoFillCell.collectionvw.reloadImageCollection()
                
                if arrImgAuto2.count > 0 {
                    autoFillCell.btnUpload.isHidden = true
                    autoFillCell.collectionvw.isHidden = false
                } else {
                    autoFillCell.btnUpload.isHidden = false
                    autoFillCell.collectionvw.isHidden = true
                }
                
                autoFillCell.delegateAutoLeak = self
                autoFillCell.txtAutofillLeakFree.delegate = self
                
                return autoFillCell
            } else if indexPath.row == 3 {
                let autoFillCell = tableView.dequeueReusableCell(withIdentifier: "AutofillProperShutoutCell", for: indexPath) as! AutofillProperShutoutTableCell

                 autoFillCell.btnUpload.addTarget(self, action: #selector(btnAutoFillUpload(_:)), for: UIControl.Event.touchUpInside)
                 
                 autoFillCell.delegateAutoShutOut = self
                 
                 autoFillCell.collectionvw.arrItems = arrImgAuto3
                 autoFillCell.collectionvw.delegateItemCollection = self
                 autoFillCell.collectionvw.reloadImageCollection()
                 
                 if arrImgAuto3.count > 0 {
                     autoFillCell.btnUpload.isHidden = true
                     autoFillCell.collectionvw.isHidden = false
                 } else {
                     autoFillCell.btnUpload.isHidden = false
                     autoFillCell.collectionvw.isHidden = true
                 }

                 autoFillCell.delegateAutoShutOut = self
                 autoFillCell.txtAutofillShutout.delegate = self
                 
                return autoFillCell
            } else if indexPath.row == 4 {
                let autoFillCell = tableView.dequeueReusableCell(withIdentifier: "AutofillBackflowCell", for: indexPath) as! AutofillBackflowTableCell

                autoFillCell.btnUpload.addTarget(self, action: #selector(btnAutoFillUpload(_:)), for: UIControl.Event.touchUpInside)
                
                autoFillCell.delegateAutoBack = self
                
                autoFillCell.collectionvw.arrItems = arrImgAuto4
                autoFillCell.collectionvw.delegateItemCollection = self
                autoFillCell.collectionvw.reloadImageCollection()
                
                if arrImgAuto4.count > 0 {
                    autoFillCell.btnUpload.isHidden = true
                    autoFillCell.collectionvw.isHidden = false
                } else {
                    autoFillCell.btnUpload.isHidden = false
                    autoFillCell.collectionvw.isHidden = true
                }
                
                autoFillCell.delegateAutoBack = self
                autoFillCell.txtAutofillBackflow.delegate = self
                
                return autoFillCell
            } else if indexPath.row == 5 {
                let autoFillCell = tableView.dequeueReusableCell(withIdentifier: "AutofillMaintainanceAccessibleCell", for: indexPath) as! AutofillMaintainanceAccessibleTableCell
                
                autoFillCell.btnUpload.addTarget(self, action: #selector(btnAutoFillUpload(_:)), for: UIControl.Event.touchUpInside)
                
                autoFillCell.delegateAutoMainAccess = self
                
                autoFillCell.collectionvw.arrItems = arrImgAuto5
                autoFillCell.collectionvw.delegateItemCollection = self
                autoFillCell.collectionvw.reloadImageCollection()
                
                if arrImgAuto5.count > 0 {
                    autoFillCell.btnUpload.isHidden = true
                    autoFillCell.collectionvw.isHidden = false
                } else {
                    autoFillCell.btnUpload.isHidden = false
                    autoFillCell.collectionvw.isHidden = true
                }
                
                autoFillCell.delegateAutoMainAccess = self
                autoFillCell.txtAutofillMaintenance.delegate = self
                
                return autoFillCell
            } else if indexPath.row == 6 {
                let autoFillCell = tableView.dequeueReusableCell(withIdentifier: "AutofillExposedPlumbingLeakCell", for: indexPath) as! AutofillExposedPlumbingLeakTableCell
                
                autoFillCell.btnUpload.addTarget(self, action: #selector(btnAutoFillUpload(_:)), for: UIControl.Event.touchUpInside)
                
                autoFillCell.delegateAutoExposed = self
                
                autoFillCell.collectionvw.arrItems = arrImgAuto6
                autoFillCell.collectionvw.delegateItemCollection = self
                autoFillCell.collectionvw.reloadImageCollection()
                
                if arrImgAuto6.count > 0 {
                    autoFillCell.btnUpload.isHidden = true
                    autoFillCell.collectionvw.isHidden = false
                } else {
                    autoFillCell.btnUpload.isHidden = false
                    autoFillCell.collectionvw.isHidden = true
                }
                
                autoFillCell.delegateAutoExposed = self
                autoFillCell.txtAutofillExposedLeak.delegate = self
                
                return autoFillCell
            } else if indexPath.row == 7 {
                let autoFillCell = tableView.dequeueReusableCell(withIdentifier: "AutofillOverflowMountedCell", for: indexPath) as! AutofillOverflowMountedTableCell
                
                autoFillCell.btnUpload.addTarget(self, action: #selector(btnAutoFillUpload(_:)), for: UIControl.Event.touchUpInside)
                
                autoFillCell.delegateAutoMounted = self
                
                autoFillCell.collectionvw.arrItems = arrImgAuto7
                autoFillCell.collectionvw.delegateItemCollection = self
                autoFillCell.collectionvw.reloadImageCollection()
                
                if arrImgAuto7.count > 0 {
                    autoFillCell.btnUpload.isHidden = true
                    autoFillCell.collectionvw.isHidden = false
                } else {
                    autoFillCell.btnUpload.isHidden = false
                    autoFillCell.collectionvw.isHidden = true
                }
                
                autoFillCell.delegateAutoMounted = self
                autoFillCell.txtAutofillMounted.delegate = self
                
                return autoFillCell
            } else {//} if indexPath.row == 8 {
                let autoFillCell = tableView.dequeueReusableCell(withIdentifier: "AutofillValveAdjustmentCell", for: indexPath) as! AutofillValveAdjustmentTableCell
                
                autoFillCell.btnUpload.addTarget(self, action: #selector(btnAutoFillUpload(_:)), for: UIControl.Event.touchUpInside)
                
                autoFillCell.delegateAutoValve = self
                
                autoFillCell.collectionvw.arrItems = arrImgAuto8
                autoFillCell.collectionvw.delegateItemCollection = self
                autoFillCell.collectionvw.reloadImageCollection()
                
                if arrImgAuto8.count > 0 {
                    autoFillCell.btnUpload.isHidden = true
                    autoFillCell.collectionvw.isHidden = false
                } else {
                    autoFillCell.btnUpload.isHidden = false
                    autoFillCell.collectionvw.isHidden = true
                }
                
                autoFillCell.delegateAutoValve = self
                autoFillCell.txtAutofillValveAdjust.delegate = self
                
                return autoFillCell
            }
        } else if tableView.tag == 25 {
            if indexPath.row == 0 {
                let flowCell = tableView.dequeueReusableCell(withIdentifier: "OverflowPlumbedProperlyCell", for: indexPath) as! OverflowPlumbedProperlyTableCell
                
                flowCell.btnUpload.addTarget(self, action: #selector(btnOverFlowUpload(_:)), for: UIControl.Event.touchUpInside)
                
                flowCell.delegateOverflowPlumbed = self
                
                flowCell.collectionvw.arrItems = arrImgOverFlow0
                flowCell.collectionvw.delegateItemCollection = self
                flowCell.collectionvw.reloadImageCollection()
                
                if arrImgOverFlow0.count > 0 {
                    flowCell.btnUpload.isHidden = true
                    flowCell.collectionvw.isHidden = false
                } else {
                    flowCell.btnUpload.isHidden = false
                    flowCell.collectionvw.isHidden = true
                }
                
                flowCell.delegateOverflowPlumbed = self
                flowCell.txtOverflowPlumbed.delegate = self
                
                return flowCell
            } else {// if indexPath.row == 1 {
                let flowCell = tableView.dequeueReusableCell(withIdentifier: "OverflowMountedHeightCell", for: indexPath) as! OverflowMountedHeightTableCell
                
                flowCell.btnUpload.addTarget(self, action: #selector(btnOverFlowUpload), for: UIControl.Event.touchUpInside)
                
                flowCell.delegateOverflowHeight = self
                
                flowCell.collectionvw.arrItems = arrImgOverFlow1
                flowCell.collectionvw.delegateItemCollection = self
                flowCell.collectionvw.reloadImageCollection()
                
                if arrImgOverFlow1.count > 0 {
                    flowCell.btnUpload.isHidden = true
                    flowCell.collectionvw.isHidden = false
                } else {
                    flowCell.btnUpload.isHidden = false
                    flowCell.collectionvw.isHidden = true
                }
                
                flowCell.delegateOverflowHeight = self
                flowCell.txtOverflowMountedHeight.delegate = self
                
                return flowCell
            }
        } else {
            if indexPath.row == 0 {
                let cameraCell = tableView.dequeueReusableCell(withIdentifier: "CameraCell", for: indexPath) as! CameraTableCell
                          
                cameraCell.lblHeader.text = "Autofill"
                
                cameraCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

                cameraCell.collectionVw.arrItems = arrMainAutofillImg
                cameraCell.collectionVw.delegateItemCollection = self
                cameraCell.collectionVw.reloadImageCollection()
                
                if arrMainAutofillImg.count > 0 {
                    cameraCell.btnUpload.isHidden = true
                    cameraCell.collectionVw.isHidden = false
                } else {
                    cameraCell.btnUpload.isHidden = false
                    cameraCell.collectionVw.isHidden = true
                }
                
               return cameraCell
            } else if indexPath.row == 1 {
                let InspectAutofillCell = tableView.dequeueReusableCell(withIdentifier: "InspectionAutofillCell", for: indexPath) as! InspectionAutofillTableCell
                
                if strAutofillOption == "Yes" {
                    //Declare the outlet in our custom class
                    let tblAutofill = InspectAutofillCell.viewWithTag(35) as! UITableView
                    
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        InspectAutofillCell.tblAutofillHeightConstraint.constant = (355*8+345)
                    } else {
                        InspectAutofillCell.tblAutofillHeightConstraint.constant = (600*8+585)
                    }
                    tblAutofill.delegate = self
                    tblAutofill.dataSource = self
                    tblAutofill.reloadData()
                } else if strAutofillOption == "No" {
                    InspectAutofillCell.tblAutofillHeightConstraint.constant = 0
                }
                
                InspectAutofillCell.delegateAutofill = self
                
                return InspectAutofillCell
            } else if indexPath.row == 2 {
                let cameraCell = tableView.dequeueReusableCell(withIdentifier: "CameraCell", for: indexPath) as! CameraTableCell
                
                cameraCell.lblHeader.text = "OVERFLOW"
                
                cameraCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

                cameraCell.collectionVw.arrItems = arrMainOverFlowImg
                cameraCell.collectionVw.delegateItemCollection = self
                cameraCell.collectionVw.reloadImageCollection()
                
                if arrMainOverFlowImg.count > 0 {
                    cameraCell.btnUpload.isHidden = true
                    cameraCell.collectionVw.isHidden = false
                } else {
                    cameraCell.btnUpload.isHidden = false
                    cameraCell.collectionVw.isHidden = true
                }
                
                return cameraCell
            } else if indexPath.row == 3 {
                let InspectionOverflowCell = tableView.dequeueReusableCell(withIdentifier: "InspectionOverflowCell", for: indexPath) as! InspectionOverflowTableCell
                
                InspectionOverflowCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

                InspectionOverflowCell.collectionvw.arrItems = arrOverFlowImg
                InspectionOverflowCell.collectionvw.delegateItemCollection = self
                InspectionOverflowCell.collectionvw.reloadImageCollection()
                
                if arrOverFlowImg.count > 0 {
                    InspectionOverflowCell.btnUpload.isHidden = true
                    InspectionOverflowCell.collectionvw.isHidden = false
                } else {
                    InspectionOverflowCell.btnUpload.isHidden = false
                    InspectionOverflowCell.collectionvw.isHidden = true
                }
                
                InspectionOverflowCell.delegateOverflow = self
                InspectionOverflowCell.txtOverflow.delegate = self
                
                if strOverflowOption == "Yes" {
                    //Declare the outlet in our custom class
                    let tblOverFlow = InspectionOverflowCell.viewWithTag(25) as! UITableView
                    
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        InspectionOverflowCell.tblOverflowHeightConstraint.constant = 355+345
                    } else {
                        InspectionOverflowCell.tblOverflowHeightConstraint.constant = (600+585)
                    }
                    tblOverFlow.delegate = self
                    tblOverFlow.dataSource = self
                    tblOverFlow.reloadData()
                } else if strOverflowOption == "No" {
                    InspectionOverflowCell.tblOverflowHeightConstraint.constant = 0
                }
                
                return InspectionOverflowCell
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
            } else if tableView.tag == 35 {
                if indexPath.row == 0 {
                    return 140
                } else if indexPath.row == 8 {
                    return 335
                } else {
                    return 330
                }
            } else {
                if indexPath.row == 0 {
                    return 185
                } else if indexPath.row == 1 {
                    if strAutofillOption == "Yes" {
                        return (330*7+335)+140//UITableView.automaticDimension//
                    } else {
                        return 140
                    }
                } else if indexPath.row == 2 {
                    return 185
                } else if indexPath.row == 3 {
                     if strOverflowOption == "Yes" {
                        return 335+340+380//UITableView.automaticDimension//
                     } else {
                        return 380
                    }
                } else {
                    return 105
               }
            }
        } else {        //.pad
            if tableView.tag == 25 {
                return 600
            } else if tableView.tag == 35 {
                if indexPath.row == 0 {
                    return 200
                } else if indexPath.row == 8 {
                    return 600
                } else {
                    return 600
                }
            } else {
                if indexPath.row == 0 {
                    return 320
                } else if indexPath.row == 1 {
                    if strAutofillOption == "Yes" {
                        return (600*8+200)+200//UITableView.automaticDimension//
                    } else {
                        return 200
                    }
                } else if indexPath.row == 2 {
                    return 320
                } else if indexPath.row == 3 {
                     if strOverflowOption == "Yes" {
                        return (600+600)+600//UITableView.automaticDimension//
                     } else {
                        return 600
                    }
                } else {
                    return 175
               }
            }
        }
    }
}



extension InspectAutofillVC: AutofillCellProtocol, AutoModeCellProtocol, AutoWaterCellProtocol, AutoLeakCellProtocol, AutoShutOutCellProtocol, AutoBackCellProtocol, AutoMainAccessCellProtocol, AutoExposedCellProtocol, AutoMountedCellProtocol, AutoValveCellProtocol, OverflowCellProtocol, OverflowPlumbedCellProtocol, OverflowHeightCellProtocol {
    
    func didTapOnCellAutofill(_btnAutofillTag: Int){
        if _btnAutofillTag == 0 {
           strAutofillOption = "Yes"
        } else if _btnAutofillTag == 1 {
           strAutofillOption = "No"
        }
        self.tblAutofill.reloadData()
    }
    
    func didTapOnCellAutoMode(_btnAutofillTag: Int) {
        if _btnAutofillTag == 0 {
           strAutoWaterOpt0 = "Maual"
        } else if _btnAutofillTag == 1 {
           strAutoWaterOpt0 = "Auto"
        }
        self.tblAutofill.reloadData()
    }
    
    func didTapOnCellAutoWater(_btnAutofillTag: Int) {
        if _btnAutofillTag == 0 {
           strAutofillOpt1 = "Yes"
        } else if _btnAutofillTag == 1 {
           strAutofillOpt1 = "No"
        }
        self.tblAutofill.reloadData()
    }
    
    func didTapOnCellAutoLeak(_btnAutofillTag: Int) {
        if _btnAutofillTag == 0 {
           strAutofillOpt2 = "Yes"
        } else if _btnAutofillTag == 1 {
           strAutofillOpt2 = "No"
        }
        self.tblAutofill.reloadData()
    }
    
    func didTapOnCellAutoShutOut(_btnAutofillTag: Int) {
        if _btnAutofillTag == 0 {
           strAutofillOpt3 = "Yes"
        } else if _btnAutofillTag == 1 {
           strAutofillOpt3 = "No"
        }
        self.tblAutofill.reloadData()
    }
    
    func didTapOnCellAutoBack(_btnAutofillTag: Int) {
        if _btnAutofillTag == 0 {
           strAutofillOpt4 = "Yes"
        } else if _btnAutofillTag == 1 {
           strAutofillOpt4 = "No"
        }
        self.tblAutofill.reloadData()
    }
    
    func didTapOnCellAutoMainAccess(_btnAutofillTag: Int) {
        if _btnAutofillTag == 0 {
           strAutofillOpt5 = "Yes"
        } else if _btnAutofillTag == 1 {
           strAutofillOpt5 = "No"
        }
        self.tblAutofill.reloadData()
    }
    
    func didTapOnCellAutoExposed(_btnAutofillTag: Int) {
        if _btnAutofillTag == 0 {
           strAutofillOpt6 = "Yes"
        } else if _btnAutofillTag == 1 {
           strAutofillOpt6 = "No"
        }
        self.tblAutofill.reloadData()
    }
    
    func didTapOnCellAutoMounted(_btnAutofillTag: Int) {
        if _btnAutofillTag == 0 {
           strAutofillOpt7 = "Yes"
        } else if _btnAutofillTag == 1 {
           strAutofillOpt7 = "No"
        }
        self.tblAutofill.reloadData()
    }
    
    func didTapOnCellAutoValve(_btnAutofillTag: Int) {
        if _btnAutofillTag == 0 {
           strAutofillOpt8 = "Yes"
        } else if _btnAutofillTag == 1 {
           strAutofillOpt8 = "No"
        }
        self.tblAutofill.reloadData()
    }
    
    func didTapOnCellOverflowPlumbed(_btnOverflowTag: Int) {
        if _btnOverflowTag == 0 {
           strOverFlowOpt0 = "Yes"
        } else if _btnOverflowTag == 1 {
           strOverFlowOpt0 = "No"
        }
        self.tblAutofill.reloadData()
    }
    
    func didTapOnCellOverflowHeight(_btnOverflowTag: Int) {
        if _btnOverflowTag == 0 {
           strOverFlowOpt1 = "Yes"
        } else if _btnOverflowTag == 1 {
           strOverFlowOpt1 = "No"
        }
        self.tblAutofill.reloadData()
    }
    
    
    func didTapOnCellOverflow(_btnOverflowTag: Int){
        if _btnOverflowTag == 0 {
           strOverflowOption = "Yes"
        } else if _btnOverflowTag == 1 {
           strOverflowOption = "No"
        }
        self.tblAutofill.reloadData()
    }
}
