//
//  InspectValvesVC.swift
//  Leaktronics
//
//  Created by ivaninfotech on 5/7/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import CoreData
import DLRadioButton
import SVProgressHUD
import Alamofire
import Photos
import OpalImagePicker

class InspectValvesVC: UIViewController, UINavigationControllerDelegate, UploadCollectionProtocol {
    
    @IBOutlet weak var tblValves: UITableView!
    
    var imagePicker = UIImagePickerController()
    var picker:UIImagePickerController? = UIImagePickerController()

    var secInspectValves = [formInspectionPoolData]()
    var secFeeder = [formInspectionPoolData]()
    
    enum InspectValves: Int {
        case proper = 1
        case handles = 2
        case springs = 3
        case replaced = 4
        case appear = 5
        case automated = 6
        case feed = 8
    }
    
    enum Feeder: Int {
        case mounted = 0
        case working = 1
        case visibleLeaks = 2
    }
    
    //For Images
    var arrValvesMainImg: [CollectionImageObject] = []
    var arrValProperImg: [CollectionImageObject] = []
    var arrValHandlesImg: [CollectionImageObject] = []
    var arrValSpringsImg: [CollectionImageObject] = []
    var arrValReplacedImg: [CollectionImageObject] = []
    var arrValAppearImg: [CollectionImageObject] = []
    var arrValAutomatedImg: [CollectionImageObject] = []
    
    var arrFeederMainImg: [CollectionImageObject] = []
    var arrFeederImg: [CollectionImageObject] = []
    
    var arrFeedMountedImg: [CollectionImageObject] = []
    var arrFeedWorkingImg: [CollectionImageObject] = []
    var arrFeedVisibleLeaksImg: [CollectionImageObject] = []

    var fetchIndexForUpload: Int = -1
    var fetchIndexForSubFeederUpload: Int = -1


    //For Image Server path
    var strValMainImg = String()
    var strValProperImg = String()
    var strValHandlesImg = String()
    var strValSpringsImg = String()
    var strValReplacedImg = String()
    var strValAppearImg = String()
    var strValAutomatedImg = String()
    
    var strFeedMainImg = String()
    var strFeedImg = String()
    var strFeedMountedImg = String()
    var strFeedWorkingImg = String()
    var strFeedVisibleLeaksImg = String()
    
    
    //For Image CoreData
    var dataValMainImg = NSData()
    var dataValProperImg = NSData()
    var dataValHandlesImg = NSData()
    var dataValSpringsImg = NSData()
    var dataValReplacedImg = NSData()
    var dataValAppearImg = NSData()
    var dataValAutomatedImg = NSData()
    
    var dataFeedMainImg = NSData()
    var dataFeedImg = NSData()
    var dataFeedMountedImg = NSData()
    var dataFeedWorkingImg = NSData()
    var dataFeedVisibleLeaksImg = NSData()
    
    
    //For Optional Values
    var strValProperOption = String()
    var strValHandlesOption = String()
    var strValSpringsOption = String()
    var strValReplacedOption = String()
    var strValAppearOption = String()
    var strValAutomatedOption = String()
    
    var strFeedOption = String()
    var strFeedMountedOption = String()
    var strFeedWorkingOption = String()
    var strFeedVisibleLeaksOption = String()
    
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.prepareFormValvesData()
    }
    
    func prepareFormValvesData() {
           for _ in 0..<9 {
               let obj = formInspectionPoolData()
               self.secInspectValves.append(obj)
           }
           for _ in 0..<3 {
              let obj = formInspectionPoolData()
              self.secFeeder.append(obj)
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
        let indexOfCell = self.tblValves.indexPath(for: cell)
        print("Clicked Index : \(String(describing: indexOfCell?.row))")
        
        fetchIndexForSubFeederUpload = -1
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
    
    @objc func btnFeederImgUpload(_ sender: Any) {
        print("Button pressed 👍 ")
        let btn = sender as! UIButton
        let cell = btn.superview?.superview?.superview as! UITableViewCell
        let tblWall = self.view.viewWithTag(25) as! UITableView
        let indexOfCell = tblWall.indexPath(for: cell)
        print("Clicked Index : \(String(describing: indexOfCell?.row))")
        fetchIndexForUpload = -1
        fetchIndexForSubFeederUpload = (indexOfCell?.row)!
        
        print("Upload Index : \(String(describing: fetchIndexForSubFeederUpload))")
        
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
        //self.postInspectValves()
        if UIDevice.current.userInterfaceIdiom == .phone {
            let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
            let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectSaltSystem") as! InspectSaltSystemVC
            self.navigationController?.pushViewController(formVC, animated: true)
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
            let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectSaltSystem") as! InspectSaltSystemVC
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
                    
                    managedObject.setValue(dataValMainImg, forKey: "valvesMainImage")
                    managedObject.setValue(strValProperOption, forKey: "valvesProperOption")
                    managedObject.setValue(dataValProperImg, forKey: "valvesProperImage")
                    managedObject.setValue(self.secInspectValves[InspectValves.proper.rawValue].formTextValue, forKey: "valvesProperData")
                    managedObject.setValue(strValHandlesOption, forKey: "valvesHandlesOption")
                    managedObject.setValue(dataValHandlesImg, forKey: "valvesHandlesImage")
                    managedObject.setValue(self.secInspectValves[InspectValves.handles.rawValue].formTextValue, forKey: "valvesHandlesData")
                    managedObject.setValue(strValSpringsOption, forKey: "valvesSpringsOption")
                    managedObject.setValue(dataValSpringsImg, forKey: "valvesSpringsImage")
                    managedObject.setValue(self.secInspectValves[InspectValves.springs.rawValue].formTextValue, forKey: "valvesSpringsData")
                    managedObject.setValue(strValReplacedOption, forKey: "valvesReplacedOption")
                    managedObject.setValue(dataValReplacedImg, forKey: "valvesReplacedImage")
                    managedObject.setValue(self.secInspectValves[InspectValves.replaced.rawValue].formTextValue, forKey: "valvesReplacedData")
                    managedObject.setValue(strValAppearOption, forKey: "valvesAppearOption")
                    managedObject.setValue(dataValAppearImg, forKey: "valvesAppearImage")
                    managedObject.setValue(self.secInspectValves[InspectValves.appear.rawValue].formTextValue, forKey: "valvesAppearData")
                    managedObject.setValue(strValAutomatedOption, forKey: "valvesAutomatedOption")
                    managedObject.setValue(dataValAutomatedImg, forKey: "valvesAutomatedImage")
                    managedObject.setValue(self.secInspectValves[InspectValves.automated.rawValue].formTextValue, forKey: "valvesAutomatedData")
                    managedObject.setValue(dataFeedMainImg, forKey: "feedMainImage")
                    managedObject.setValue(strFeedOption, forKey: "feedOption")
                    managedObject.setValue(dataFeedImg, forKey: "feedImage")
                    managedObject.setValue(self.secInspectValves[InspectValves.feed.rawValue].formTextValue, forKey: "feedData")
                    managedObject.setValue(strFeedMountedOption, forKey: "feedMountedOption")
                    managedObject.setValue(dataFeedMountedImg, forKey: "feedMountedImage")
                    managedObject.setValue(self.secFeeder[Feeder.mounted.rawValue].formTextValue, forKey: "feedMountedData")
                    managedObject.setValue(strFeedWorkingOption, forKey: "feedWorkingOption")
                    managedObject.setValue(dataFeedWorkingImg, forKey: "feedWorkingImage")
                    managedObject.setValue(self.secFeeder[Feeder.working.rawValue].formTextValue, forKey: "feedWorkingData")
                    managedObject.setValue(strFeedVisibleLeaksOption, forKey: "feedVisibleLeaksOption")
                    managedObject.setValue(dataFeedVisibleLeaksImg, forKey: "feedVisibleLeaksImage")
                    managedObject.setValue(self.secFeeder[Feeder.visibleLeaks.rawValue].formTextValue, forKey: "feedVisibleLeaksData")
                    
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
                        print("Data of InspectValvesVC:: \(data)")
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
                        self.strValMainImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 1 {
                        self.strValProperImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 2 {
                        self.strValHandlesImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 3 {
                        self.strValSpringsImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 4 {
                        self.strValReplacedImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 5 {
                        self.strValAppearImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 6 {
                        self.strValAutomatedImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 7 {
                        self.strFeedMainImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 8 {
                        self.strFeedImg = String(describing: data!)
                    }
                    
                    if self.fetchIndexForSubFeederUpload == 0 {
                        self.strFeedMountedImg = String(describing: data!)
                    } else if self.fetchIndexForSubFeederUpload == 1 {
                        self.strFeedWorkingImg = String(describing: data!)
                    } else if self.fetchIndexForSubFeederUpload == 2 {
                        self.strFeedVisibleLeaksImg = String(describing: data!)
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
    
    func postInspectValves() {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        
        let return_id = UserDefaults.standard.value(forKey: "returnKeyForInspection")
        
        let inspectValvesDetails: NSMutableDictionary = [
            "return_data_id"        : return_id!,
            "valvesMainImage"       : strValMainImg,
            "valvesProperOption"    : strValProperOption,
            "valvesProperImage"     : strValProperImg,
            "valvesProperData"      : self.secInspectValves[InspectValves.proper.rawValue].formTextValue,
            "valvesHandlesOption"   : strValHandlesOption,
            "valvesHandlesImage"    : strValHandlesImg,
            "valvesHandlesData"     : self.secInspectValves[InspectValves.handles.rawValue].formTextValue,
            "valvesSpringsOption"   : strValSpringsOption,
            "valvesSpringsImage"    : strValSpringsImg,
            "valvesSpringsData"     : self.secInspectValves[InspectValves.springs.rawValue].formTextValue,
            "valvesReplacedOption"  : strValReplacedOption,
            "valvesReplacedImage"   : strValReplacedImg,
            "valvesReplacedData"    : self.secInspectValves[InspectValves.replaced.rawValue].formTextValue,
            "valvesAppearOption"    : strValAppearOption,
            "valvesAppearImage"     : strValAppearImg,
            "valvesAppearData"      : self.secInspectValves[InspectValves.appear.rawValue].formTextValue,
            "valvesAutomatedOption" : strValAutomatedOption,
            "valvesAutomatedImage"  : strValAutomatedImg,
            "valvesAutomatedData"   : self.secInspectValves[InspectValves.automated.rawValue].formTextValue,
            "feedMainImage"         : strFeedMainImg,
            "feedOption"            : strFeedOption,
            "feedImage"             : strFeedImg,
            "feedData"              : self.secInspectValves[InspectValves.feed.rawValue].formTextValue,
            "feedMountedOption"     : strFeedMountedOption,
            "feedMountedImage"      : strFeedMountedImg,
            "feedMountedData"       : self.secFeeder[Feeder.mounted.rawValue].formTextValue,
            "feedWorkingOption"     : strFeedWorkingOption,
            "feedWorkingImage"      : strFeedWorkingImg,
            "feedWorkingData"       : self.secFeeder[Feeder.working.rawValue].formTextValue,
            "feedVisibleLeaksOption": strFeedVisibleLeaksOption,
            "feedVisibleLeaksImage" : strFeedVisibleLeaksImg,
            "feedVisibleLeaksData"  : self.secFeeder[Feeder.visibleLeaks.rawValue].formTextValue
        ]
        
        print("inspectValvesDetails :: \(inspectValvesDetails)")
        //if sharedExtension.connectedToNetwork() {
        ApiManager.sharedInstanceAPI.PostInspectValves(postId: 1, valvesDetails: inspectValvesDetails, onSuccess: { json in
            DispatchQueue.main.async {
                print("InspectionValvesDetails json :: \(String(describing: json))")
                DispatchQueue.main.async(execute: {() -> Void in
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectSaltSystem") as! InspectSaltSystemVC
                        self.navigationController?.pushViewController(formVC, animated: true)
                    } else if UIDevice.current.userInterfaceIdiom == .pad {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectSaltSystem") as! InspectSaltSystemVC
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

extension InspectValvesVC: OpalImagePickerControllerDelegate {
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
                                self.arrValvesMainImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataValMainImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 1 {
                                self.arrValProperImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataValProperImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 2 {
                                self.arrValHandlesImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataValHandlesImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 3 {
                                self.arrValSpringsImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataValSpringsImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 4 {
                                self.arrValReplacedImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataValReplacedImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 5 {
                                self.arrValAppearImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataValAppearImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 6 {
                                self.arrValAutomatedImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataValAutomatedImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 7 {
                                self.arrFeederMainImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataFeedMainImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 8 {
                                self.arrFeederImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataFeedImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            }
                            
                            if self.fetchIndexForSubFeederUpload == 0 {
                                self.arrFeedMountedImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataFeedMountedImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubFeederUpload == 1 {
                                self.arrFeedWorkingImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataFeedWorkingImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubFeederUpload == 2 {
                                self.arrFeedVisibleLeaksImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataFeedVisibleLeaksImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
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
                self.tblValves.reloadData()
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


extension InspectValvesVC: UIImagePickerControllerDelegate {
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
            self.arrValvesMainImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataValMainImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 1 {
            self.arrValProperImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataValProperImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 2 {
            self.arrValHandlesImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataValHandlesImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 3 {
            self.arrValSpringsImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataValSpringsImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 4 {
            self.arrValReplacedImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataValReplacedImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 5 {
            self.arrValAppearImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)

           self.dataValAppearImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 6 {
            self.arrValAutomatedImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataValAutomatedImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 7 {
            self.arrFeederMainImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataFeedMainImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 8 {
            self.arrFeederImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataFeedImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        }
        
        if self.fetchIndexForSubFeederUpload == 0 {
            self.arrFeedMountedImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataFeedMountedImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForSubFeederUpload == 1 {
            self.arrFeedWorkingImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataFeedWorkingImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForSubFeederUpload == 2 {
            self.arrFeedVisibleLeaksImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataFeedVisibleLeaksImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        }
        
        self.tblValves.reloadData()
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
}

extension InspectValvesVC: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        var cell = UITableViewCell()
        cell = (textView.superview?.superview as? UITableViewCell)!
        
        if let ValvesMainTableCell = cell as? ValvesMainTableCell {
            if textView == ValvesMainTableCell.txtOther {
                self.secInspectValves[InspectValves.proper.rawValue].formTextValue = (textView.text)!
            }
        } else if let valvesCell = cell as? Val2TableCell {
            if textView == valvesCell.txtOther {
                self.secInspectValves[InspectValves.handles.rawValue].formTextValue = (textView.text)!
            }
        } else if let valvesCell = cell as? Val3TableCell {
            if textView == valvesCell.txtOther {
                self.secInspectValves[InspectValves.springs.rawValue].formTextValue = (textView.text)!
            }
        } else if let valvesCell = cell as? Val4TableCell {
            if textView == valvesCell.txtOther {
                self.secInspectValves[InspectValves.replaced.rawValue].formTextValue = (textView.text)!
            }
        } else if let valvesCell = cell as? Val5TableCell {
            if textView == valvesCell.txtOther {
                self.secInspectValves[InspectValves.appear.rawValue].formTextValue = (textView.text)!
            }
        } else if let valvesCell = cell as? Val6TableCell {
            if textView == valvesCell.txtOther {
                self.secInspectValves[InspectValves.automated.rawValue].formTextValue = (textView.text)!
            }
        } else if let FeederMainTableCell = cell as? FeederMainTableCell {
            if textView == FeederMainTableCell.txtOther {
                self.secInspectValves[InspectValves.feed.rawValue].formTextValue = (textView.text)!
            }
        }
        
        if let feederCell = cell as? Feeder0TableCell {
            if textView == feederCell.txtOther {
                self.secFeeder[Feeder.mounted.rawValue].formTextValue = (textView.text)!
            }
        } else if let feederCell = cell as? Feeder1TableCell {
            if textView == feederCell.txtOther {
                self.secFeeder[Feeder.working.rawValue].formTextValue = (textView.text)!
            }
        } else if let feederCell = cell as? Feeder2TableCell {
            if textView == feederCell.txtOther {
                self.secFeeder[Feeder.visibleLeaks.rawValue].formTextValue = (textView.text)!
            }
        }
    }
}

extension InspectValvesVC: UITableViewDataSource, UITableViewDelegate {
    //MARK:- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 25 {
            return 3
        } else {
            return 10
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 25 {
            if indexPath.row == 0 {
                let feederCell = tableView.dequeueReusableCell(withIdentifier: "Feeder0Cell", for: indexPath) as! Feeder0TableCell
                
                feederCell.lblHeader.text = "Is table feeder mounted properly?"
                
                feederCell.btnUpload.addTarget(self, action: #selector(btnFeederImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                feederCell.collectionVw.arrItems = arrFeedMountedImg
                feederCell.collectionVw.delegateItemCollection = self
                feederCell.collectionVw.reloadImageCollection()
                
                if arrFeedMountedImg.count > 0 {
                    feederCell.btnUpload.isHidden = true
                    feederCell.collectionVw.isHidden = false
                } else {
                    feederCell.btnUpload.isHidden = false
                    feederCell.collectionVw.isHidden = true
                }
                
                feederCell.delegateFeeder0 = self
                feederCell.txtOther.delegate = self
                
                return feederCell
            } else if indexPath.row == 1 {
                let feederCell = tableView.dequeueReusableCell(withIdentifier: "Feeder1Cell", for: indexPath) as! Feeder1TableCell
                
                feederCell.lblHeader.text = "Is table feeder working properly?"
                
                feederCell.btnUpload.addTarget(self, action: #selector(btnFeederImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                feederCell.collectionVw.arrItems = arrFeedWorkingImg
                feederCell.collectionVw.delegateItemCollection = self
                feederCell.collectionVw.reloadImageCollection()
                
                if arrFeedWorkingImg.count > 0 {
                    feederCell.btnUpload.isHidden = true
                    feederCell.collectionVw.isHidden = false
                } else {
                    feederCell.btnUpload.isHidden = false
                    feederCell.collectionVw.isHidden = true
                }
                
                feederCell.delegateFeeder1 = self
                feederCell.txtOther.delegate = self
                
                return feederCell
            } else { //if indexPath.row == 2 {
                let feederCell = tableView.dequeueReusableCell(withIdentifier: "Feeder2Cell", for: indexPath) as! Feeder2TableCell
                
                feederCell.lblHeader.text = "Are there any visible leaks at tablet feeder?"
                
                feederCell.btnUpload.addTarget(self, action: #selector(btnFeederImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                feederCell.collectionVw.arrItems = arrFeedVisibleLeaksImg
                feederCell.collectionVw.delegateItemCollection = self
                feederCell.collectionVw.reloadImageCollection()
                
                if arrFeedVisibleLeaksImg.count > 0 {
                    feederCell.btnUpload.isHidden = true
                    feederCell.collectionVw.isHidden = false
                } else {
                    feederCell.btnUpload.isHidden = false
                    feederCell.collectionVw.isHidden = true
                }
                
                feederCell.delegateFeeder2 = self
                feederCell.txtOther.delegate = self
                
                return feederCell
            }
        } else {
            if indexPath.row == 0 {
                let cameraCell = tableView.dequeueReusableCell(withIdentifier: "CameraCell", for: indexPath) as! CameraTableCell
                
                cameraCell.lblHeader.text = "Valves"
                if UIDevice.current.userInterfaceIdiom == .phone {
                    cameraCell.lblHeader.font = UIFont.init(name: "Roboto-bold", size: 16.0)
                } else {
                    cameraCell.lblHeader.font = UIFont.init(name: "Roboto-bold", size: 24.0)
                }
                
                cameraCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                cameraCell.collectionVw.arrItems = arrValvesMainImg
                cameraCell.collectionVw.delegateItemCollection = self
                cameraCell.collectionVw.reloadImageCollection()
                
                if arrValvesMainImg.count > 0 {
                    cameraCell.btnUpload.isHidden = true
                    cameraCell.collectionVw.isHidden = false
                } else {
                    cameraCell.btnUpload.isHidden = false
                    cameraCell.collectionVw.isHidden = true
                }
                
                return cameraCell
            } else if indexPath.row == 1 {
                let valCell = tableView.dequeueReusableCell(withIdentifier: "ValvesMainCell", for: indexPath) as! ValvesMainTableCell
                
                valCell.lblHeader.text = "Does valves open, close and function properly?"

                valCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                valCell.collectionVw.arrItems = arrValProperImg
                valCell.collectionVw.delegateItemCollection = self
                valCell.collectionVw.reloadImageCollection()
                
                if arrValProperImg.count > 0 {
                    valCell.btnUpload.isHidden = true
                    valCell.collectionVw.isHidden = false
                } else {
                    valCell.btnUpload.isHidden = false
                    valCell.collectionVw.isHidden = true
                }
                
                valCell.delegateValvesMain = self
                valCell.txtOther.delegate = self
                
                return valCell
            } else if indexPath.row == 2 {
                let valCell = tableView.dequeueReusableCell(withIdentifier: "Val2Cell", for: indexPath) as! Val2TableCell
                
                valCell.lblHeader.text = "Are valve handles present and unbroken?"
                
                valCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

                valCell.collectionVw.arrItems = arrValHandlesImg
                valCell.collectionVw.delegateItemCollection = self
                valCell.collectionVw.reloadImageCollection()
                
                if arrValHandlesImg.count > 0 {
                    valCell.btnUpload.isHidden = true
                    valCell.collectionVw.isHidden = false
                } else {
                    valCell.btnUpload.isHidden = false
                    valCell.collectionVw.isHidden = true
                }
                
                valCell.delegateVal2 = self
                valCell.txtOther.delegate = self
                
                return valCell
            } else if indexPath.row == 3 {
                let valCell = tableView.dequeueReusableCell(withIdentifier: "Val3Cell", for: indexPath) as! Val3TableCell
                
                valCell.lblHeader.text = "Are internal springs of check valves in good condition?"
                
                valCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

                valCell.collectionVw.arrItems = arrValSpringsImg
                valCell.collectionVw.delegateItemCollection = self
                valCell.collectionVw.reloadImageCollection()
                
                if arrValSpringsImg.count > 0 {
                    valCell.btnUpload.isHidden = true
                    valCell.collectionVw.isHidden = false
                } else {
                    valCell.btnUpload.isHidden = false
                    valCell.collectionVw.isHidden = true
                }
                
                valCell.delegateVal3 = self
                valCell.txtOther.delegate = self
                
                return valCell
            } else if indexPath.row == 4 {
                let valCell = tableView.dequeueReusableCell(withIdentifier: "Val4Cell", for: indexPath) as! Val4TableCell
                
                valCell.lblHeader.text = "Have springs been replaced recently?"
                
                valCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

                valCell.collectionVw.arrItems = arrValReplacedImg
                valCell.collectionVw.delegateItemCollection = self
                valCell.collectionVw.reloadImageCollection()
                
                if arrValReplacedImg.count > 0 {
                    valCell.btnUpload.isHidden = true
                    valCell.collectionVw.isHidden = false
                } else {
                    valCell.btnUpload.isHidden = false
                    valCell.collectionVw.isHidden = true
                }
                
                valCell.delegateVal4 = self
                valCell.txtOther.delegate = self
                
                return valCell
            } else if indexPath.row == 5 {
                let valCell = tableView.dequeueReusableCell(withIdentifier: "Val5Cell", for: indexPath) as! Val5TableCell
                
                valCell.lblHeader.text = "Do valves appear to be closing properly?"
                
                valCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

                valCell.collectionVw.arrItems = arrValAppearImg
                valCell.collectionVw.delegateItemCollection = self
                valCell.collectionVw.reloadImageCollection()
                
                if arrValAppearImg.count > 0 {
                    valCell.btnUpload.isHidden = true
                    valCell.collectionVw.isHidden = false
                } else {
                    valCell.btnUpload.isHidden = false
                    valCell.collectionVw.isHidden = true
                }
                
                valCell.delegateVal5 = self
                valCell.txtOther.delegate = self
                
                return valCell
            } else if indexPath.row == 6 {
                let valCell = tableView.dequeueReusableCell(withIdentifier: "Val6Cell", for: indexPath) as! Val6TableCell
                
                valCell.lblHeader.text = "Are all automated valves working properly?"
                
                valCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

                valCell.collectionVw.arrItems = arrValAutomatedImg
                valCell.collectionVw.delegateItemCollection = self
                valCell.collectionVw.reloadImageCollection()
                
                if arrValAutomatedImg.count > 0 {
                    valCell.btnUpload.isHidden = true
                    valCell.collectionVw.isHidden = false
                } else {
                    valCell.btnUpload.isHidden = false
                    valCell.collectionVw.isHidden = true
                }
                
                valCell.delegateVal6 = self
                valCell.txtOther.delegate = self
                
                return valCell
            } else if indexPath.row == 7 {
                let cameraCell = tableView.dequeueReusableCell(withIdentifier: "CameraCell", for: indexPath) as! CameraTableCell
                
                cameraCell.lblHeader.text = "Tablet Feeder"
                if UIDevice.current.userInterfaceIdiom == .phone {
                    cameraCell.lblHeader.font = UIFont.init(name: "Roboto-bold", size: 16.0)
                } else {
                    cameraCell.lblHeader.font = UIFont.init(name: "Roboto-bold", size: 24.0)
                 }
                cameraCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                cameraCell.collectionVw.arrItems = arrFeederMainImg
                cameraCell.collectionVw.delegateItemCollection = self
                cameraCell.collectionVw.reloadImageCollection()
                
                if arrFeederMainImg.count > 0 {
                    cameraCell.btnUpload.isHidden = true
                    cameraCell.collectionVw.isHidden = false
                } else {
                    cameraCell.btnUpload.isHidden = false
                    cameraCell.collectionVw.isHidden = true
                }
                
                return cameraCell
            } else if indexPath.row == 8 {
                let feedCell = tableView.dequeueReusableCell(withIdentifier: "FeederMainCell", for: indexPath) as! FeederMainTableCell
                
                feedCell.lblHeader.text = "Is a tablet feeder present?"
                
                feedCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

                feedCell.collectionVw.arrItems = arrFeederImg
                feedCell.collectionVw.delegateItemCollection = self
                feedCell.collectionVw.reloadImageCollection()
                
                if arrFeederImg.count > 0 {
                    feedCell.btnUpload.isHidden = true
                    feedCell.collectionVw.isHidden = false
                } else {
                    feedCell.btnUpload.isHidden = false
                    feedCell.collectionVw.isHidden = true
                }
                
                if strFeedOption == "Yes" {
                    feedCell.tblSubVw.delegate = self
                    feedCell.tblSubVw.dataSource = self
                    
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        feedCell.tblHeightConstraint.constant = (335*4+325)
                    } else {
                        feedCell.tblHeightConstraint.constant = (600*4+585)
                    }
                    feedCell.tblSubVw.reloadData()
                } else {
                    feedCell.tblHeightConstraint.constant = 0
                }
                
                feedCell.delegateFeederMain = self
                feedCell.txtOther.delegate = self
                
                return feedCell
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
                if indexPath.row == 4 {
                    return 340
                } else {
                    return 350
                }
            } else {
                if indexPath.row == 0 {
                    return 185
                } else if indexPath.row == 7 {
                    return 185
                } else if indexPath.row == 8 {
                    if strFeedOption == "Yes" {
                        return (345*3)+355
                    } else {
                        return 355
                    }
                } else if indexPath.row == 9 {
                    return 105
                } else {
                    return 355
                }
            }
        } else { // .pad
            if tableView.tag == 25 {
                if indexPath.row == 4 {
                    return 585
                } else {
                    return 600
                }
            } else {
                if indexPath.row == 0 {
                    return 320
                } else if indexPath.row == 7 {
                    return 320
                } else if indexPath.row == 8 {
                    if strFeedOption == "Yes" {
                        return (600*2+585)+615
                    } else {
                        return 615
                    }
                } else if indexPath.row == 9 {
                    return 175
                } else {
                    return 600
                }
            }
        }
    }
}

extension InspectValvesVC: ValvesMainProtocol, Val2Protocol, Val3Protocol, Val4Protocol, Val5Protocol, Val6Protocol, FeederMainProtocol, Feeder0Protocol, Feeder1Protocol, Feeder2Protocol {
    func didTapOnCellValvesMain(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strValProperOption = "Yes"
        } else if _btnDescribeTag == 1 {
            strValProperOption = "No"
        }
        self.tblValves.reloadData()
    }
    
    func didTapOnCellVal2(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strValHandlesOption = "Yes"
        } else if _btnDescribeTag == 1 {
            strValHandlesOption = "No"
        }
        self.tblValves.reloadData()
    }
    
    func didTapOnCellVal3(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strValSpringsOption = "Yes"
        } else if _btnDescribeTag == 1 {
            strValSpringsOption = "No"
        }
        self.tblValves.reloadData()
    }
    
    func didTapOnCellVal4(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strValReplacedOption = "Yes"
        } else if _btnDescribeTag == 1 {
            strValReplacedOption = "No"
        }
        self.tblValves.reloadData()
    }
    
    func didTapOnCellVal5(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strValAppearOption = "Yes"
        } else if _btnDescribeTag == 1 {
            strValAppearOption = "No"
        }
        self.tblValves.reloadData()
    }
    
    func didTapOnCellVal6(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strValAutomatedOption = "Yes"
        } else if _btnDescribeTag == 1 {
            strValAutomatedOption = "No"
        }
        self.tblValves.reloadData()
    }
    
    func didTapOnCellFeederMain(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strFeedOption = "Yes"
        } else if _btnDescribeTag == 1 {
            strFeedOption = "No"
        }
        self.tblValves.reloadData()
    }
    
    func didTapOnCellFeeder0(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strFeedMountedOption = "Yes"
        } else if _btnDescribeTag == 1 {
            strFeedMountedOption = "No"
        }
        self.tblValves.reloadData()
    }
    
    func didTapOnCellFeeder1(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strFeedWorkingOption = "Yes"
        } else if _btnDescribeTag == 1 {
            strFeedWorkingOption = "No"
        }
        self.tblValves.reloadData()
    }
    
    func didTapOnCellFeeder2(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strFeedVisibleLeaksOption = "Yes"
        } else if _btnDescribeTag == 1 {
            strFeedVisibleLeaksOption = "No"
        }
        self.tblValves.reloadData()
    }
}
