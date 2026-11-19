//
//  InspectFittingsVC.swift
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


class InspectFittingsVC: UIViewController, UINavigationControllerDelegate, UploadCollectionProtocol {
    
    @IBOutlet weak var tblFit: UITableView!
    
    private var sectionIndex = -1
    private var selectedRowIndex = -1
    
    var secFit = [formInspectionPoolData]()
    
    enum InspectFit: Int {
        case Physical = 1
        case ProperFlow = 2
        case Position = 3
        case CrackBeam = 5
        case CrackTile = 6
        case TileLevel = 7
        case CopingType = 8
        case CopingLevel = 9
    }
    
    var imagePicker = UIImagePickerController()
    var picker:UIImagePickerController? = UIImagePickerController()
    
    
    //For Images
    var arrPhysicalImg: [CollectionImageObject] = []
    var arrProperFlowImg: [CollectionImageObject] = []
    var arrPositionImg: [CollectionImageObject] = []
    var arrBeamTileImg: [CollectionImageObject] = []
    var arrCrackBeamImg: [CollectionImageObject] = []
    var arrCrackTileImg: [CollectionImageObject] = []
    var arrTileLevelImg: [CollectionImageObject] = []
    var arrCopingTypeImg: [CollectionImageObject] = []
    var arrCopingLevelImg: [CollectionImageObject] = []
    
    var fetchIndexForUpload = Int()
    
    //For Image Server path
    var strPhysicalImg = String()
    var strProperFlowImg = String()
    var strPositionImg = String()
    var strBeamTileImg = String()
    var strCrackBeamImg = String()
    var strCrackTileImg = String()
    var strTileLevelImg = String()
    var strCopingTypeImg = String()
    var strCopingLevelImg = String()
    
    //For Image CoreData
    var dataPhysicalImg = NSData()
    var dataProperFlowImg = NSData()
    var dataPositionImg = NSData()
    var dataBeamTileImg = NSData()
    var dataCrackBeamImg = NSData()
    var dataCrackTileImg = NSData()
    var dataTileLevelImg = NSData()
    var dataCopingTypeImg = NSData()
    var dataCopingLevelImg = NSData()
    
    //For Optional Value
    var strPhysicalOption = String()
    var strProperFlowOption = String()
    var strPositionOption = String()
    var strCrackBeamOption = String()
    var strCrackTileOption = String()
    var strTileLevelOption = String()
    var strCopingTypeOption = String()
    var strCopingLevelOption = String()
    
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.prepareFormInspectionFitData()
    }
    
    func prepareFormInspectionFitData() {
        for _ in 0..<10 {
            let obj = formInspectionPoolData()
            self.secFit.append(obj)
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
        let indexOfCell = self.tblFit.indexPath(for: cell)
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
                    
                    managedObject.setValue(strPhysicalOption, forKey: "physicalOption")
                    managedObject.setValue(dataPhysicalImg, forKey: "physicalImg")
                    managedObject.setValue(self.secFit[InspectFit.Physical.rawValue].formTextValue, forKey: "physicalData")
                    managedObject.setValue(strProperFlowOption, forKey: "properFlowOption")
                    managedObject.setValue(dataProperFlowImg, forKey: "properFlowImg")
                    managedObject.setValue(self.secFit[InspectFit.ProperFlow.rawValue].formTextValue, forKey: "properFlowData")
                    managedObject.setValue(strPositionOption, forKey: "positionOption")
                    managedObject.setValue(dataPositionImg, forKey: "positionImg")
                    managedObject.setValue(self.secFit[InspectFit.Position.rawValue].formTextValue, forKey: "positionData")
                    managedObject.setValue(dataBeamTileImg, forKey: "beamTileImg")
                    managedObject.setValue(strCrackBeamOption, forKey: "crackBeamOption")
                    managedObject.setValue(dataCrackBeamImg, forKey: "crackBeamImg")
                    managedObject.setValue(self.secFit[InspectFit.CrackBeam.rawValue].formTextValue, forKey: "crackBeamData")
                    managedObject.setValue(strCrackTileOption, forKey: "crackTileOption")
                    managedObject.setValue(dataCrackTileImg, forKey: "crackTileImg")
                    managedObject.setValue(self.secFit[InspectFit.CrackTile.rawValue].formTextValue, forKey: "crackTileData")
                    managedObject.setValue(strTileLevelOption, forKey: "tileLevelOption")
                    managedObject.setValue(dataTileLevelImg, forKey: "tileLevelImg")
                    managedObject.setValue(self.secFit[InspectFit.TileLevel.rawValue].formTextValue, forKey: "tileLevelData")
                    managedObject.setValue(strCopingTypeOption, forKey: "copingTypeOption")
                    managedObject.setValue(dataCopingTypeImg, forKey: "copingTypeImg")
                    managedObject.setValue(self.secFit[InspectFit.CopingType.rawValue].formTextValue, forKey: "copingTypeData")
                    managedObject.setValue(strCopingLevelOption, forKey: "copingLevelOption")
                    managedObject.setValue(dataCopingLevelImg, forKey: "copingLevelImg")
                    managedObject.setValue(self.secFit[InspectFit.CopingLevel.rawValue].formTextValue, forKey: "copingLevelData")
                    
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
                        print("Data of InspectFittingsVC:: \(data)")
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
        //self.postInspectFittings()
        if UIDevice.current.userInterfaceIdiom == .phone {
            let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
            let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectDeck") as! InspectDeckVC
            self.navigationController?.pushViewController(formVC, animated: true)
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
            let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectDeck") as! InspectDeckVC
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
                    if self.fetchIndexForUpload == 1 {
                        self.strPhysicalImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 2 {
                        self.strProperFlowImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 3 {
                        self.strPositionImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 4 {
                        self.strBeamTileImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 5 {
                        self.strCrackBeamImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 6 {
                        self.strCrackTileImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 7 {
                        self.strTileLevelImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 8 {
                        self.strCopingTypeImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 9 {
                        self.strCopingLevelImg = String(describing: data!)
                    }
                    
                    SVProgressHUD.dismiss()
                }
            case .failure(let encodingError):
                print("error:\(encodingError)")
                SVProgressHUD.dismiss()
            }
        })
    }
    
    func postInspectFittings() {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        
        let return_id = UserDefaults.standard.value(forKey: "returnKeyForInspection")
        
        let inspectFitDetails:  NSMutableDictionary = [
            "return_data_id"    : return_id!,
            "physicalOption"    : strPhysicalOption,
            "physicalImg"       : strPhysicalImg,
            "physicalData"      : self.secFit[InspectFit.Physical.rawValue].formTextValue,
            "properFlowOption"  : strProperFlowOption,
            "properFlowImg"     : strProperFlowImg,
            "properFlowData"    : self.secFit[InspectFit.ProperFlow.rawValue].formTextValue,
            "positionOption"    : strPositionOption,
            "positionImg"       : strPositionImg,
            "positionData"      : self.secFit[InspectFit.Position.rawValue].formTextValue,
            "beamTileImg"       : strBeamTileImg,
            "crackBeamOption"   : strCrackBeamOption,
            "crackBeamImg"      : strCrackBeamImg,
            "crackBeamData"     : self.secFit[InspectFit.CrackBeam.rawValue].formTextValue,
            "crackTileOption"   : strCrackTileOption,
            "crackTileImg"      : strCrackTileImg,
            "crackTileData"     : self.secFit[InspectFit.CrackTile.rawValue].formTextValue,
            "tileLevelOption"   : strTileLevelOption,
            "tileLevelImg"      : strTileLevelImg,
            "tileLevelData"     : self.secFit[InspectFit.TileLevel.rawValue].formTextValue,
            "copingTypeOption"  : strCopingTypeOption,
            "copingTypeImg"     : strCopingTypeImg,
            "copingTypeData"    : self.secFit[InspectFit.CopingType.rawValue].formTextValue,
            "copingLevelOption" : strCopingLevelOption,
            "copingLevelImg"    : strCopingLevelImg,
            "copingLevelData"   : self.secFit[InspectFit.CopingLevel.rawValue].formTextValue
        ]

        print("inspectFitDetails :: \(inspectFitDetails)")
        //if sharedExtension.connectedToNetwork() {
        ApiManager.sharedInstanceAPI.PostInspectFittings(postId: 1, fittingsDetails: inspectFitDetails, onSuccess: { json in
            DispatchQueue.main.async {
                print("InspectionFittingsDetails json :: \(String(describing: json))")
                DispatchQueue.main.async(execute: {() -> Void in
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectDeck") as! InspectDeckVC
                        self.navigationController?.pushViewController(formVC, animated: true)
                    } else if UIDevice.current.userInterfaceIdiom == .pad {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectDeck") as! InspectDeckVC
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

extension InspectFittingsVC: OpalImagePickerControllerDelegate {
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
                            if self.fetchIndexForUpload == 1 {
                                self.arrPhysicalImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataPhysicalImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 2 {
                                self.arrProperFlowImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataProperFlowImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 3 {
                                self.arrPositionImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataPositionImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 4 {
                                self.arrBeamTileImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataBeamTileImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 5 {
                                self.arrCrackBeamImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataCrackBeamImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 6 {
                                self.arrCrackTileImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataCrackTileImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 7 {
                                self.arrTileLevelImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataTileLevelImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 8 {
                                self.arrCopingTypeImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataCopingTypeImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 9 {
                                self.arrCopingLevelImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataCopingLevelImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
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
                self.tblFit.reloadData()
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


extension InspectFittingsVC: UIImagePickerControllerDelegate {
    // MARK:: UIImagePickerControllerDelegate
    //For xcode 10
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let possibleImage = info[.originalImage] as? UIImage
            else {
                fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
                //return
            }
        
        if fetchIndexForUpload == 1 {
            self.arrPhysicalImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)

            self.dataPhysicalImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 2 {
            self.arrProperFlowImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)

            self.dataProperFlowImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 3 {
            self.arrPositionImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)

            self.dataPositionImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 4 {
            self.arrBeamTileImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)

            self.dataBeamTileImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 5 {
            self.arrCrackBeamImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)

            self.dataCrackBeamImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 6 {
            self.arrCrackTileImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)

            self.dataCrackTileImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 7 {
            self.arrTileLevelImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)

            self.dataTileLevelImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 8 {
            self.arrCopingTypeImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)

            self.dataCopingTypeImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 9 {
            self.arrCopingLevelImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)

            self.dataCopingLevelImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        }
        self.tblFit.reloadData()
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
}

extension InspectFittingsVC: UITextViewDelegate {
    @objc func updateInspectTextViewValue() {
        let cell = self.tblFit.cellForRow(at: IndexPath.init(row: self.selectedRowIndex, section: self.sectionIndex))
        guard let _cell = cell else { return  }
        
        print(selectedRowIndex)
        if selectedRowIndex == 1 {
            if let addressTblCell = _cell as? PhysicalTableCell {
                if let textView = addressTblCell.txtOther {
                    self.secFit[self.selectedRowIndex].formTextValue = (textView.text)!
                }
            }
        } else if selectedRowIndex == 2 {
            if let addressTblCell = _cell as? ProperFlowTableCell {
                if let textView = addressTblCell.txtOther {
                    self.secFit[self.selectedRowIndex].formTextValue = (textView.text)!
                }
            }
        } else if selectedRowIndex == 3 {
            if let addressTblCell = _cell as? PositionTableCell {
                if let textView = addressTblCell.txtOther {
                    self.secFit[self.selectedRowIndex].formTextValue = (textView.text)!
                }
            }
        } else if selectedRowIndex == 5 {
            if let addressTblCell = _cell as? CrackBeamTableCell {
                if let textView = addressTblCell.txtOther {
                    self.secFit[self.selectedRowIndex].formTextValue = (textView.text)!
                }
            }
        } else if selectedRowIndex == 6 {
            if let addressTblCell = _cell as? CrackTileTableCell {
                if let textView = addressTblCell.txtOther {
                    self.secFit[self.selectedRowIndex].formTextValue = (textView.text)!
                }
            }
        } else if selectedRowIndex == 7 {
            if let addressTblCell = _cell as? TileLevelTableCell {
                if let textView = addressTblCell.txtOther {
                    self.secFit[self.selectedRowIndex].formTextValue = (textView.text)!
                }
            }
        } else if selectedRowIndex == 8 {
            if let addressTblCell = _cell as? CopingTypeTableCell {
                if let textView = addressTblCell.txtOther {
                    self.secFit[self.selectedRowIndex].formTextValue = (textView.text)!
                }
            }
        } else if selectedRowIndex == 9 {
            if let addressTblCell = _cell as? CopingLevelTableCell {
                if let textView = addressTblCell.txtOther {
                    self.secFit[self.selectedRowIndex].formTextValue = (textView.text)!
                }
            }
        }
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        let cell = (textView.superview?.superview as? UITableViewCell)!
        
        let indexpath = self.tblFit.indexPath(for: cell)
        guard let _indexPath = indexpath else { return false }
        self.selectedRowIndex = _indexPath.row
        self.sectionIndex = _indexPath.section
        
        self.perform(#selector(InspectFittingsVC.updateInspectTextViewValue), with: nil, afterDelay: 1)
        
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let cell = (textView.superview?.superview as? UITableViewCell)!
        
        let indexpath = self.tblFit.indexPath(for: cell)
        guard let _indexPath = indexpath else { return false }
        self.selectedRowIndex = _indexPath.row
        self.sectionIndex = _indexPath.section
        
        self.perform(#selector(InspectFittingsVC.updateInspectTextViewValue), with: nil, afterDelay: 1)
        
        return true
    }
}

extension InspectFittingsVC: UITableViewDataSource, UITableViewDelegate {
    //MARK:- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let headerView : UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "CustomHeaderCell")!
            
            let lblHeaderTitle = headerView.viewWithTag(10) as! UILabel
            
            lblHeaderTitle.textColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.2352941176, alpha: 1)
            
            lblHeaderTitle.text = "Fittings"  // set this however is appropriate for your app's model
            
            return headerView
        } else if indexPath.row == 1 {
            let optionCell = tableView.dequeueReusableCell(withIdentifier: "PhysicalCell", for: indexPath) as! PhysicalTableCell
            
            optionCell.lblHeader.text = "Are pool/SPA return fittings present and in good physical and operating condition?"
            optionCell.lblHeader.numberOfLines = 2
            
            optionCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            
            optionCell.collectionVw.arrItems = arrPhysicalImg
            optionCell.collectionVw.delegateItemCollection = self
            optionCell.collectionVw.reloadImageCollection()
            if arrPhysicalImg.count > 0 {
                optionCell.btnUpload.isHidden = true
                optionCell.collectionVw.isHidden = false
            } else {
                optionCell.btnUpload.isHidden = false
                optionCell.collectionVw.isHidden = true
            }
            
            optionCell.delegatePhysical = self
            optionCell.txtOther.delegate = self
            
            return optionCell
        } else  if indexPath.row == 2 {
            let optionCell = tableView.dequeueReusableCell(withIdentifier: "ProperFlowCell", for: indexPath) as! ProperFlowTableCell
            
            optionCell.lblHeader.text = "Can returns handle proper flow?"
            
            optionCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            
            optionCell.collectionVw.arrItems = arrProperFlowImg
            optionCell.collectionVw.delegateItemCollection = self
            optionCell.collectionVw.reloadImageCollection()
            if arrProperFlowImg.count > 0 {
               optionCell.btnUpload.isHidden = true
               optionCell.collectionVw.isHidden = false
            } else {
               optionCell.btnUpload.isHidden = false
               optionCell.collectionVw.isHidden = true
            }
            
            optionCell.delegateProperFlow = self
            optionCell.txtOther.delegate = self
            
            return optionCell
        } else if indexPath.row == 3 {
            let optionCell = tableView.dequeueReusableCell(withIdentifier: "PositionCell", for: indexPath) as! PositionTableCell
            
            optionCell.lblHeader.text = "Are returns positioned properly?"
            
            optionCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                       
            optionCell.collectionVw.arrItems = arrPositionImg
            optionCell.collectionVw.delegateItemCollection = self
            optionCell.collectionVw.reloadImageCollection()
            
            if arrPositionImg.count > 0 {
               optionCell.btnUpload.isHidden = true
               optionCell.collectionVw.isHidden = false
            } else {
               optionCell.btnUpload.isHidden = false
               optionCell.collectionVw.isHidden = true
            }
            
            optionCell.delegatePosition = self
            optionCell.txtOther.delegate = self
            
            return optionCell
        } else if indexPath.row == 4 {
            let cameraCell = tableView.dequeueReusableCell(withIdentifier: "CameraCell", for: indexPath) as! CameraTableCell
            
            cameraCell.lblHeader.text = "Beam - Tile - Coping"
            cameraCell.lblHeader.font = UIFont(name:"Roboto-bold", size:24)
            
            cameraCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

            cameraCell.collectionVw.arrItems = arrBeamTileImg
            cameraCell.collectionVw.delegateItemCollection = self
            cameraCell.collectionVw.reloadImageCollection()
            
            if arrBeamTileImg.count > 0 {
                cameraCell.btnUpload.isHidden = true
                cameraCell.collectionVw.isHidden = false
            } else {
                cameraCell.btnUpload.isHidden = false
                cameraCell.collectionVw.isHidden = true
            }
            
            return cameraCell
        } else if indexPath.row == 5 {
            let optionCell = tableView.dequeueReusableCell(withIdentifier: "CrackBeamCell", for: indexPath) as! CrackBeamTableCell
            
            optionCell.lblHeader.text = "Is bond beam solid, Are there any bond beam cracks?"
            
            optionCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            
            optionCell.collectionVw.arrItems = arrCrackBeamImg
            optionCell.collectionVw.delegateItemCollection = self
            optionCell.collectionVw.reloadImageCollection()

            if arrCrackBeamImg.count > 0 {
                optionCell.btnUpload.isHidden = true
                optionCell.collectionVw.isHidden = false
            } else {
                optionCell.btnUpload.isHidden = false
                optionCell.collectionVw.isHidden = true
            }
            
            optionCell.delegateCrackBeam = self
            optionCell.txtOther.delegate = self
            
            return optionCell
        } else if indexPath.row == 6 {
            let optionCell = tableView.dequeueReusableCell(withIdentifier: "CrackTileCell", for: indexPath) as! CrackTileTableCell
            
            optionCell.lblHeader.text = "Is there any loose or cracking tile?"

            optionCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

            optionCell.collectionVw.arrItems = arrCrackTileImg
            optionCell.collectionVw.delegateItemCollection = self
            optionCell.collectionVw.reloadImageCollection()
            if arrCrackTileImg.count > 0 {
                optionCell.btnUpload.isHidden = true
                optionCell.collectionVw.isHidden = false
            } else {
                optionCell.btnUpload.isHidden = false
                optionCell.collectionVw.isHidden = true
            }
            
            optionCell.delegateCrackTile = self
            optionCell.txtOther.delegate = self
            
            return optionCell
        } else if indexPath.row == 7 {
            let optionCell = tableView.dequeueReusableCell(withIdentifier: "TileLevelCell", for: indexPath) as! TileLevelTableCell
            
            optionCell.lblHeader.text = "Is the tile level?"
            
            optionCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            
            optionCell.collectionVw.arrItems = arrTileLevelImg
            optionCell.collectionVw.delegateItemCollection = self
            optionCell.collectionVw.reloadImageCollection()
            
            if arrTileLevelImg.count > 0 {
                optionCell.btnUpload.isHidden = true
                optionCell.collectionVw.isHidden = false
            } else {
                optionCell.btnUpload.isHidden = false
                optionCell.collectionVw.isHidden = true
            }
            
            optionCell.delegateTileLevel = self
            optionCell.txtOther.delegate = self
            
            return optionCell
        } else if indexPath.row == 8 {
            let optionCell = tableView.dequeueReusableCell(withIdentifier: "CopingTypeCell", for: indexPath) as! CopingTypeTableCell
            
            optionCell.lblHeader.text = "What is the coping type?"
            
            optionCell.lbl1.text = "Brick"
            optionCell.lbl2.text = "Stone"
            optionCell.lbl3.text = "No Coping"
            optionCell.lbl4.text = "Other, Describe"
            
            optionCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            
            optionCell.collectionVw.arrItems = arrCopingTypeImg
            optionCell.collectionVw.delegateItemCollection = self
            optionCell.collectionVw.reloadImageCollection()
            
            if arrCopingTypeImg.count > 0 {
                optionCell.btnUpload.isHidden = true
                optionCell.collectionVw.isHidden = false
            } else {
                optionCell.btnUpload.isHidden = false
                optionCell.collectionVw.isHidden = true
            }
            
            optionCell.delegateCopingType = self
            optionCell.txtOther.delegate = self
            
            return optionCell
        } else if indexPath.row == 9 {
            let optionCell = tableView.dequeueReusableCell(withIdentifier: "CopingLevelCell", for: indexPath) as! CopingLevelTableCell
            optionCell.lblHeader.text = "Is the coping level?"

            optionCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            
            optionCell.collectionVw.arrItems = arrCopingLevelImg
            optionCell.collectionVw.delegateItemCollection = self
            optionCell.collectionVw.reloadImageCollection()
            
            if arrCopingLevelImg.count > 0 {
                optionCell.btnUpload.isHidden = true
                optionCell.collectionVw.isHidden = false
            } else {
                optionCell.btnUpload.isHidden = false
                optionCell.collectionVw.isHidden = true
            }
            
            optionCell.delegateCopingLevel = self
            optionCell.txtOther.delegate = self
            
            return optionCell
        } else {//if indexPath.row == 10 {
            let cellBtn = tableView.dequeueReusableCell(withIdentifier: "NextCell", for: indexPath) as! NextForm1TableCell
            
            cellBtn.btnNext.addTarget(self, action: #selector(btnNextDidTap), for: UIControl.Event.touchUpInside)
            return cellBtn
        }
    }

    //MARK:- UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .phone {
            if indexPath.row == 0 {
                return 45
            } else if indexPath.row == 4 {
                return 185
            } else if indexPath.row == 8 {
                return 395
            } else if indexPath.row == 9 {
                return 355
            } else if indexPath.row == 10 {
                return 105
            } else {
                return 340
            }
        } else {        // .pad
            if indexPath.row == 0 {
                return 75
            } else if indexPath.row == 4 {
                return 370
            } else if indexPath.row == 8 {
                return 710
            } else if indexPath.row == 9 {
                return 600
            } else if indexPath.row == 10 {
                return 175
            } else {
                return 600
            }
        }
    }
}

extension InspectFittingsVC: PhysicalCellProtocol, ProperFlowCellProtocol, PositionCellProtocol, CrackBeamCellProtocol, CrackTileCellProtocol, TileLevelCellProtocol, CopingTypeCellProtocol, CopingLevelCellProtocol {
    func didTapOnCellPhysical(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
           strPhysicalOption = "Yes"
        } else if _btnDescribeTag == 1 {
           strPhysicalOption = "No"
        }
        self.tblFit.reloadData()
    }
    
    func didTapOnCellProperFlow(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
           strProperFlowOption = "Yes"
        } else if _btnDescribeTag == 1 {
           strProperFlowOption = "No"
        }
        self.tblFit.reloadData()
    }
    
    func didTapOnCellPosition(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
           strPositionOption = "Yes"
        } else if _btnDescribeTag == 1 {
           strPositionOption = "No"
        }
        self.tblFit.reloadData()
    }
    
    func didTapOnCellCrackBeam(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
           strCrackBeamOption = "Yes"
        } else if _btnDescribeTag == 1 {
           strCrackBeamOption = "No"
        }
        self.tblFit.reloadData()
    }
    
    func didTapOnCellCrackTile(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
           strCrackTileOption = "Yes"
        } else if _btnDescribeTag == 1 {
           strCrackTileOption = "No"
        }
        self.tblFit.reloadData()
    }
    
    func didTapOnCellTileLevel(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
           strTileLevelOption = "Yes"
        } else if _btnDescribeTag == 1 {
           strTileLevelOption = "No"
        }
        self.tblFit.reloadData()
    }
    
    func didTapOnCellCopingType(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
           strCopingTypeOption = "Brick"
        } else if _btnDescribeTag == 1 {
           strCopingTypeOption = "Stone"
        } else if _btnDescribeTag == 2 {
           strCopingTypeOption = "No Coping"
        } else if _btnDescribeTag == 3 {
           strCopingTypeOption = "Other, Describe"
        }
        self.tblFit.reloadData()
    }
    
    func didTapOnCellCopingLevel(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
           strCopingLevelOption = "Yes"
        } else if _btnDescribeTag == 1 {
           strCopingLevelOption = "No"
        }
        self.tblFit.reloadData()
    }
}
