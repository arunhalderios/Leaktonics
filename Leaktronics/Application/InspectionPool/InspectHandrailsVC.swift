//
//  InspectHandrailsVC.swift
//  Leaktronics
//
//  Created by ivaninfotech on 4/30/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import CoreData
import DLRadioButton 
import SVProgressHUD
import Alamofire
import Photos
import OpalImagePicker


class InspectHandrailsVC: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var tblHandrails: UITableView!
    
    var secHandrails = [formInspectionPoolData]()
    var secSubRaised = [formInspectionPoolData]()
    
    enum Handrails: Int {
        case entrance = 1
        case deepEnd = 2
        case grabRails = 3
        case raisedWall = 4
        case grabEdge = 5
    }
    
    enum SubRaisedWall: Int {
        case subRaisedWall = 0
    }
    
    var imagePicker = UIImagePickerController()
    var picker:UIImagePickerController? = UIImagePickerController()
    
    
    //For Images
    var arrHandrailsImg: [CollectionImageObject] = []
    var arrEntranceImg: [CollectionImageObject] = []
    var arrDeepEndImg: [CollectionImageObject] = []
    var arrGrabRailsImg: [CollectionImageObject] = []
    var arrRaisedWallImg: [CollectionImageObject] = []
    var arrSubRaisedWallImg: [CollectionImageObject] = []
    var arrGrabEdgeImg: [CollectionImageObject] = []
    
    var fetchIndexForUpload: Int = -1
    var fetchIndexForSubRaisedWallUpload: Int = -1
    
    
    //For Image Server path
    var strHandrailsImg = String()
    var strEntranceImg = String()
    var strDeepEndImg = String()
    var strGrabRailsImg = String()
    var strRaisedWallImg = String()
    var strSubRaisedWallImg = String()
    var strGrabEdgeImg = String()
    
    //For Image CoreData
    var dataHandrailsImg = NSData()
    var dataEntranceImg = NSData()
    var dataDeepEndImg = NSData()
    var dataGrabRailsImg = NSData()
    var dataRaisedWallImg = NSData()
    var dataSubRaisedWallImg = NSData()
    var dataGrabEdgeImg = NSData()
    
    //For Optional Value
//    var strHandrailsOption = String()
    var strEntranceOption = String()
    var strDeepEndOption = String()
    var strGrabRailsOption = String()
    var strRaisedWallOption = String()
    var strSubRaisedWallOption = String()
    var strGrabEdgeOption = String()
    
    //For TextView
//    var strSubRaisedTxt = String()
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.prepareFormHandrailsData()
    }
    
    func prepareFormHandrailsData() {
        for _ in 0..<6 {
            let obj = formInspectionPoolData()
            self.secHandrails.append(obj)
        }
        
        for _ in 0..<1 {
            let obj = formInspectionPoolData()
            self.secSubRaised.append(obj)
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
    
    @objc func btnClickedUpload(_ sender: Any) {
        print("Button pressed 👍 ")
        let btn = sender as! UIButton
        let cell = btn.superview?.superview?.superview as! UITableViewCell
        let indexOfCell = self.tblHandrails.indexPath(for: cell)
        print("Clicked Index : \(String(describing: indexOfCell?.row))")
        fetchIndexForSubRaisedWallUpload = -1
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
    
    @objc func btnImgUpload(_ sender: Any) {
        print("Button pressed 👍 ")
        let btn = sender as! UIButton
        let cell = btn.superview?.superview?.superview as! UITableViewCell
        let tblWall = self.view.viewWithTag(25) as! UITableView
        let indexOfCell = tblWall.indexPath(for: cell)
        print("Clicked Index : \(String(describing: indexOfCell?.row))")
        fetchIndexForUpload = -1
        fetchIndexForSubRaisedWallUpload = (indexOfCell?.row)!
        
        print("Upload Index : \(String(describing: fetchIndexForSubRaisedWallUpload))")
        
        self.actionSheetPopUpForGalleryOpen()
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
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
                    
                    managedObject.setValue(dataHandrailsImg, forKey: "handrailsImg")
                    managedObject.setValue(strEntranceOption, forKey: "entranceOption")
                    managedObject.setValue(dataEntranceImg, forKey: "entranceImg")
                    managedObject.setValue(self.secHandrails[Handrails.entrance.rawValue].formTextValue, forKey: "entranceData")
                    managedObject.setValue(strDeepEndOption, forKey: "deepEndOption")
                    managedObject.setValue(dataDeepEndImg, forKey: "deepEndImg")
                    managedObject.setValue(self.secHandrails[Handrails.deepEnd.rawValue].formTextValue, forKey: "deepEndData")
                    managedObject.setValue(strGrabRailsOption, forKey: "grabRailsOption")
                    managedObject.setValue(dataGrabRailsImg, forKey: "grabRailsImg")
                    managedObject.setValue(self.secHandrails[Handrails.grabRails.rawValue].formTextValue, forKey: "grabRailsData")
                    managedObject.setValue(strRaisedWallOption, forKey: "raisedWallOption")
                    managedObject.setValue(dataRaisedWallImg, forKey: "raisedWallImg")
                    managedObject.setValue(self.secHandrails[Handrails.raisedWall.rawValue].formTextValue, forKey: "raisedWallData")
                    managedObject.setValue(strSubRaisedWallOption, forKey: "subRaisedWallOption")
                    managedObject.setValue(dataSubRaisedWallImg, forKey: "subRaisedWallImg")
                    managedObject.setValue(self.secSubRaised[SubRaisedWall.subRaisedWall.rawValue].formTextValue, forKey: "subRaisedWallData")
                    managedObject.setValue(strGrabEdgeOption, forKey: "grabEdgeOption")
                    managedObject.setValue(dataGrabEdgeImg, forKey: "grabEdgeImg")
                    managedObject.setValue(self.secHandrails[Handrails.grabEdge.rawValue].formTextValue, forKey: "grabEdgeData")
                    
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
                        print("Data of InspectHandrailsVC:: \(data)")
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

    //MARK:- ObjectiveC Function
    @objc func btnNextDidTap() {
        self.updateCoreData()
        self.view.endEditing(true)
        //self.postInspectHandrails()
        if UIDevice.current.userInterfaceIdiom == .phone {
            let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
            let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectEdge") as! InspectEdgeVC
            self.navigationController?.pushViewController(formVC, animated: true)
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
            let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectEdge") as! InspectEdgeVC
            self.navigationController?.pushViewController(formVC, animated: true)
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
                        self.strHandrailsImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 1 {
                        self.strEntranceImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 2 {
                        self.strDeepEndImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 3 {
                        self.strGrabRailsImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 4 {
                        self.strRaisedWallImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 5 {
                        self.strGrabEdgeImg = String(describing: data!)
                    }
                    
                    if self.fetchIndexForSubRaisedWallUpload == 0 {
                        self.strSubRaisedWallImg = String(describing: data!)
                    }

                    SVProgressHUD.dismiss()
                }
            case .failure(let encodingError):
                print("error:\(encodingError)")
                SVProgressHUD.dismiss()
            }
        })
    }
    
    func postInspectHandrails() {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        
        let return_id = UserDefaults.standard.value(forKey: "returnKeyForInspection")
        
        
        let inspectHandrailsDetails:  NSMutableDictionary = [
            "return_data_id"        : return_id!,
            "handrailsImg"          : strHandrailsImg,
            "entranceOption"        : strEntranceOption,
            "entranceImg"           : strEntranceImg,
            "entranceData"          : self.secHandrails[Handrails.entrance.rawValue].formTextValue,
            "deepEndOption"         : strDeepEndOption,
            "deepEndImg"            : strDeepEndImg,
            "deepEndData"           : self.secHandrails[Handrails.deepEnd.rawValue].formTextValue,
            "grabRailsOption"       : strGrabRailsOption,
            "grabRailsImg"          : strGrabRailsImg,
            "grabRailsData"         : self.secHandrails[Handrails.grabRails.rawValue].formTextValue,
            "raisedWallOption"      : strRaisedWallOption,
            "raisedWallImg"         : strRaisedWallImg,
            "raisedWallData"        : self.secHandrails[Handrails.raisedWall.rawValue].formTextValue,
            "subRaisedWallOption"   :strSubRaisedWallOption,
            "subRaisedWallImg"      : strSubRaisedWallImg,
            "subRaisedWallData"     : self.secSubRaised[SubRaisedWall.subRaisedWall.rawValue].formTextValue,
            "grabEdgeOption"        : strGrabEdgeOption,
            "grabEdgeImg"           : strGrabEdgeImg,
            "grabEdgeData"          : self.secHandrails[Handrails.grabEdge.rawValue].formTextValue
        ]
        
        print("inspectHandrailsDetails :: \(inspectHandrailsDetails)")
        //if sharedExtension.connectedToNetwork() {
        ApiManager.sharedInstanceAPI.PostInspectHandrails(postId: 1, handrailsDetails: inspectHandrailsDetails, onSuccess: { json in
            DispatchQueue.main.async {
                print("InspectionHandrailsDetails json :: \(String(describing: json))")
                DispatchQueue.main.async(execute: {() -> Void in
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectEdge") as! InspectEdgeVC
                        self.navigationController?.pushViewController(formVC, animated: true)
                    } else if UIDevice.current.userInterfaceIdiom == .pad {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectEdge") as! InspectEdgeVC
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

extension InspectHandrailsVC: UploadCollectionProtocol {
    func didTapOnCellItem(_indexpath: IndexPath, _imgUrl: String, _videoUrl: String) {
    }
    
    func didUpdateCellIndex(_indexpath: Int) {
    }
}

extension InspectHandrailsVC: OpalImagePickerControllerDelegate {
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
                                self.arrHandrailsImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataHandrailsImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 1 {
                                self.arrEntranceImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataEntranceImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 2 {
                                self.arrDeepEndImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataDeepEndImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 3 {
                                self.arrGrabRailsImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataGrabRailsImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 4 {
                                self.arrRaisedWallImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataRaisedWallImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 5 {
                                self.arrGrabEdgeImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataGrabEdgeImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            }
                            if self.fetchIndexForSubRaisedWallUpload == 0 {
                                self.arrSubRaisedWallImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSubRaisedWallImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
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
                self.tblHandrails.reloadData()
              
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

extension InspectHandrailsVC: UIImagePickerControllerDelegate {
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
            self.arrHandrailsImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataHandrailsImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 1 {
            self.arrEntranceImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataEntranceImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 2 {
            self.arrDeepEndImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataDeepEndImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 3 {
            self.arrGrabRailsImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataGrabRailsImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 4 {
            self.arrRaisedWallImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataRaisedWallImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 5 {
            self.arrGrabEdgeImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataGrabEdgeImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        }
        if fetchIndexForSubRaisedWallUpload == 0 {
           self.arrSubRaisedWallImg.append(CollectionImageObject.init(imgCollect: possibleImage))
           var imageArr = [UIImage]()
           imageArr.append(possibleImage)

           self.dataSubRaisedWallImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
           //self.setPostImage(arrOfImages: imageArr)
       }
        self.tblHandrails.reloadData()
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
}

extension InspectHandrailsVC: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        var cell = UITableViewCell()
        cell = (textView.superview?.superview as? UITableViewCell)!
        
        if let addressTblCell = cell as? HandEntranceTableCell {
            if let textView = addressTblCell.txtOther {
                self.secHandrails[Handrails.entrance.rawValue].formTextValue = (textView.text)!
            }
        } else if let addressTblCell = cell as? HandDeepEndTableCell {
            if let textView = addressTblCell.txtOther {
                self.secHandrails[Handrails.deepEnd.rawValue].formTextValue = (textView.text)!
            }
        } else if let addressTblCell = cell as? HandGrabRailsTableCell {
            if let textView = addressTblCell.txtOther {
                self.secHandrails[Handrails.grabRails.rawValue].formTextValue = (textView.text)!
            }
        } else if let addressTblCell = cell as? HandrailsTableCell {
            if let textView = addressTblCell.txtOther {
                self.secHandrails[Handrails.raisedWall.rawValue].formTextValue = (textView.text)!
            }
        } else if let addressTblCell = cell as? HandGrabEdgeTableCell {
            if let textView = addressTblCell.txtOther {
                self.secHandrails[Handrails.grabEdge.rawValue].formTextValue = (textView.text)!
            }
        }
        
        if let addressTblCell = cell as? SubRaisedWallTableCell {
            if let textView = addressTblCell.txtOther {
                self.secSubRaised[SubRaisedWall.subRaisedWall.rawValue].formTextValue = (textView.text)!
            }
        }
    }
}

extension InspectHandrailsVC: UITableViewDataSource, UITableViewDelegate {
    //MARK:- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 25 {
            return 1
        } else {
            return 8
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 25 {
            let optionCell = tableView.dequeueReusableCell(withIdentifier: "SubRaisedWallCell", for: indexPath) as! SubRaisedWallTableCell
            
            optionCell.lblHeader.text = "Does the raised wall have a handrail or handgrabs?"
            
            optionCell.btnUpload.addTarget(self, action: #selector(btnImgUpload(_:)), for: UIControl.Event.touchUpInside)
            
            optionCell.collectionVw.arrItems = arrSubRaisedWallImg
            optionCell.collectionVw.delegateItemCollection = self
            optionCell.collectionVw.reloadImageCollection()
            
            if arrSubRaisedWallImg.count > 0 {
                optionCell.btnUpload.isHidden = true
                optionCell.collectionVw.isHidden = false
            } else {
                optionCell.btnUpload.isHidden = false
                optionCell.collectionVw.isHidden = true
            }
            
            optionCell.delegateSubRaisedWall = self
            optionCell.txtOther.delegate = self
            
            return optionCell
        } else {
            if indexPath.row == 0 {
                let cameraCell = tableView.dequeueReusableCell(withIdentifier: "CameraCell", for: indexPath) as! CameraTableCell
                
                cameraCell.lblHeader.text = "Handrails / Ladders"
                if UIDevice.current.userInterfaceIdiom == .phone {
                    cameraCell.lblHeader.font = UIFont(name:"Roboto-bold", size:16)
                } else {
                    cameraCell.lblHeader.font = UIFont(name:"Roboto-bold", size:24)
                }
                
                cameraCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

                cameraCell.collectionVw.arrItems = arrHandrailsImg
                cameraCell.collectionVw.delegateItemCollection = self
                cameraCell.collectionVw.reloadImageCollection()
                
                if arrHandrailsImg.count > 0 {
                    cameraCell.btnUpload.isHidden = true
                    cameraCell.collectionVw.isHidden = false
                } else {
                    cameraCell.btnUpload.isHidden = false
                    cameraCell.collectionVw.isHidden = true
                }
                
                return cameraCell
            } else if indexPath.row == 1 {
                let optionCell = tableView.dequeueReusableCell(withIdentifier: "HandEntranceCell", for: indexPath) as! HandEntranceTableCell
                
                optionCell.lblHeader.text = "Does the pool/SPA have entrance/exit handrails?"
                
                optionCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                optionCell.collectionVw.arrItems = arrEntranceImg
                optionCell.collectionVw.delegateItemCollection = self
                optionCell.collectionVw.reloadImageCollection()
                
                if arrEntranceImg.count > 0 {
                    optionCell.btnUpload.isHidden = true
                    optionCell.collectionVw.isHidden = false
                } else {
                    optionCell.btnUpload.isHidden = false
                    optionCell.collectionVw.isHidden = true
                }
                
                optionCell.delegateHandEntrance = self
                optionCell.txtOther.delegate = self
                
                return optionCell
            } else if indexPath.row == 2 {
                let optionCell = tableView.dequeueReusableCell(withIdentifier: "HandDeepEndCell", for: indexPath) as! HandDeepEndTableCell
                
                optionCell.lblHeader.text = "Does the pool/SPA have a ladder at the deep end?"
                
                optionCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                optionCell.collectionVw.arrItems = arrDeepEndImg
                optionCell.collectionVw.delegateItemCollection = self
                optionCell.collectionVw.reloadImageCollection()
                if arrDeepEndImg.count > 0 {
                    optionCell.btnUpload.isHidden = true
                    optionCell.collectionVw.isHidden = false
                } else {
                    optionCell.btnUpload.isHidden = false
                    optionCell.collectionVw.isHidden = true
                }
                
                optionCell.delegateHandDeepEnd = self
                optionCell.txtOther.delegate = self
                
                return optionCell
            } else if indexPath.row == 3 {
                let optionCell = tableView.dequeueReusableCell(withIdentifier: "HandGrabRailsCell", for: indexPath) as! HandGrabRailsTableCell
                
                optionCell.lblHeader.text = "Does the pool/SPA have inset steps at the deep with proper grab rails?"
                optionCell.lblHeader.numberOfLines = 2
                
                optionCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                optionCell.collectionVw.arrItems = arrGrabRailsImg
                optionCell.collectionVw.delegateItemCollection = self
                optionCell.collectionVw.reloadImageCollection()
                
                if arrGrabRailsImg.count > 0 {
                    optionCell.btnUpload.isHidden = true
                    optionCell.collectionVw.isHidden = false
                } else {
                    optionCell.btnUpload.isHidden = false
                    optionCell.collectionVw.isHidden = true
                }
                
                optionCell.delegateHandGrabRails = self
                optionCell.txtOther.delegate = self
                
                return optionCell
            } else if indexPath.row == 4 {
                let raisedCell = tableView.dequeueReusableCell(withIdentifier: "HandrailsCell", for: indexPath) as! HandrailsTableCell
                
                raisedCell.lblHeader.text = "Is there a raised wall in the pool/SPA?"

                raisedCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                raisedCell.collectionVw.arrItems = arrRaisedWallImg
                raisedCell.collectionVw.delegateItemCollection = self
                raisedCell.collectionVw.reloadImageCollection()
                
                if arrRaisedWallImg.count > 0 {
                    raisedCell.btnUpload.isHidden = true
                    raisedCell.collectionVw.isHidden = false
                } else {
                    raisedCell.btnUpload.isHidden = false
                    raisedCell.collectionVw.isHidden = true
                }
                
                if strRaisedWallOption == "Yes" {
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        raisedCell.tblHeightConstraint.constant = 355
                    } else {
                        raisedCell.tblHeightConstraint.constant = 600
                    }
                    raisedCell.tblSubVw.delegate = self
                    raisedCell.tblSubVw.dataSource = self
                    raisedCell.tblSubVw.reloadData()
                } else if strRaisedWallOption == "No" {
                    raisedCell.tblHeightConstraint.constant = 0
                }
                
                raisedCell.delegateHandrails = self
                raisedCell.txtOther.delegate = self
                
                return raisedCell
            } else if indexPath.row == 5 {
                let optionCell = tableView.dequeueReusableCell(withIdentifier: "HandGrabEdgeCell", for: indexPath) as! HandGrabEdgeTableCell
                
                optionCell.lblHeader.text = "Does the pool/SPA have grab along the edge?"
                
                optionCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                optionCell.collectionVw.arrItems = arrGrabEdgeImg
                optionCell.collectionVw.delegateItemCollection = self
                optionCell.collectionVw.reloadImageCollection()
                
                if arrGrabEdgeImg.count > 0 {
                    optionCell.btnUpload.isHidden = true
                    optionCell.collectionVw.isHidden = false
                } else {
                    optionCell.btnUpload.isHidden = false
                    optionCell.collectionVw.isHidden = true
                }
                
                optionCell.delegateHandGrabEdge = self
                optionCell.txtOther.delegate = self
                
                return optionCell
            } else if indexPath.row == 6 {
                let headerView : UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "CustomHeaderCell")!
                
                let lblHeaderTitle = headerView.viewWithTag(10) as! UILabel
                
                lblHeaderTitle.textColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.2352941176, alpha: 1)
                
                lblHeaderTitle.text = "Be sure to verify state and local regulations regarding handrail requirements"  // set this however is appropriate for your app's model
                 if UIDevice.current.userInterfaceIdiom == .phone {
                    lblHeaderTitle.font = UIFont.init(name: "Roboto", size: 13)
                 } else {
                    lblHeaderTitle.font = UIFont.init(name: "Roboto", size: 24)
                }
                lblHeaderTitle.numberOfLines = 2
                
                return headerView
            } else {//if indexPath.row == 7 {
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
                return 345
            } else {
                if indexPath.row == 0 {
                    return 185
                } else if indexPath.row == 4 {
                    if strRaisedWallOption == "Yes" {
                         return 345+355//UITableView.automaticDimension//
                    } else {
                        return 355
                    }
                } else if indexPath.row == 6 {
                    return 55
                } else if indexPath.row == 7 {
                    return 105
                } else {
                    return 340
                }
            }
        } else {            //.pad
            if tableView.tag == 25 {
                return 525
            } else {
                if indexPath.row == 0 {
                    return 320
                } else if indexPath.row == 4 {
                    if strRaisedWallOption == "Yes" {
                         return 600+600//UITableView.automaticDimension//
                    } else {
                        return 600
                    }
                } else if indexPath.row == 5 {
                    return 600
                } else if indexPath.row == 6 {
                    return 75
                } else if indexPath.row == 7 {
                    return 175
                } else {
                    return 600
                }
            }
        }
    }
}

extension InspectHandrailsVC: HandEntranceCellProtocol, HandDeepEndCellProtocol, HandGrabRailsCellProtocol, HandrailsCellProtocol, SubRaisedWallCellProtocol, HandGrabEdgeCellProtocol {
    
    func didTapOnCellHandEntrance(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
           strEntranceOption = "Yes"
        } else if _btnDescribeTag == 1 {
           strEntranceOption = "No"
        }
        self.tblHandrails.reloadData()
    }
    
    func didTapOnCellHandDeepEnd(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
           strDeepEndOption = "Yes"
        } else if _btnDescribeTag == 1 {
           strDeepEndOption = "No"
        }
        self.tblHandrails.reloadData()
    }
    
    func didTapOnCellHandGrabRails(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
           strGrabRailsOption = "Yes"
        } else if _btnDescribeTag == 1 {
           strGrabRailsOption = "No"
        }
        self.tblHandrails.reloadData()
    }
    
    func didTapOnCellHandrails(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
           strRaisedWallOption = "Yes"
        } else if _btnDescribeTag == 1 {
           strRaisedWallOption = "No"
        }
        self.tblHandrails.reloadData()
    }
    
    func didTapOnCellSubRaisedWall(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
           strSubRaisedWallOption = "Yes"
        } else if _btnDescribeTag == 1 {
           strSubRaisedWallOption = "No"
        }
        self.tblHandrails.reloadData()
    }
    
//    func didTapTextView(_txtValue: String) {
//        strSubRaisedTxt = _txtValue
//    }
    
    func didTapOnCellHandGrabEdge(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
           strGrabEdgeOption = "Yes"
        } else if _btnDescribeTag == 1 {
           strGrabEdgeOption = "No"
        }
        self.tblHandrails.reloadData()
    }
}



class formInspectionLadderData {
    var formTextValue = ""
}
