//
//  InspectDeckVC.swift
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


class InspectDeckVC: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var tblDeck: UITableView!
    
    private var sectionIndex = -1
    private var selectedRowIndex = -1
    
    var secDeck = [formInspectionPoolData]()
    
    enum InspectDeck: Int {
        case DeckMaterial = 1
        case DeckControl = 2
        case DeckSeal = 3
        case DeckLift = 4
        case DeckHazards = 5
        case DeckLevel = 6
        case DeckSlope = 7
        case DeckDrainage = 8
        case DeckHandrails = 9
        case DeckDeepDrop = 10
    }
    
    var fetchIndexForUpload = Int()
    
    var imagePicker = UIImagePickerController()
    var picker:UIImagePickerController? = UIImagePickerController()
    
    //For Images
    var arrDeckCondiMainImg: [CollectionImageObject] = []
    var arrDeckMaterialImg: [CollectionImageObject] = []
    var arrDeckControlImg: [CollectionImageObject] = []
    var arrDeckSealImg: [CollectionImageObject] = []
    var arrDeckLiftImg: [CollectionImageObject] = []
    var arrDeckHazardsImg: [CollectionImageObject] = []
    var arrDeckLevelImg: [CollectionImageObject] = []
    var arrDeckSlopeImg: [CollectionImageObject] = []
    var arrDeckDrainageImg: [CollectionImageObject] = []
    var arrDeckHandrailsImg: [CollectionImageObject] = []
    var arrDeckDeepDropImg: [CollectionImageObject] = []
    
    //For Image Server path
    var strDeckCondiMainImg = String()
    var strDeckMaterialImg = String()
    var strDeckControlImg = String()
    var strDeckSealImg = String()
    var strDeckLiftImg = String()
    var strDeckHazardsImg = String()
    var strDeckLevelImg = String()
    var strDeckSlopeImg = String()
    var strDeckDrainageImg = String()
    var strDeckHandrailsImg = String()
    var strDeckDeepDropImg = String()
    
    //For Image CoreData
    var dataDeckCondiMainImg = NSData()
    var dataDeckMaterialImg = NSData()
    var dataDeckControlImg = NSData()
    var dataDeckSealImg = NSData()
    var dataDeckLiftImg = NSData()
    var dataDeckHazardsImg = NSData()
    var dataDeckLevelImg = NSData()
    var dataDeckSlopeImg = NSData()
    var dataDeckDrainageImg = NSData()
    var dataDeckHandrailsImg = NSData()
    var dataDeckDeepDropImg = NSData()
    
    //For Optional Value
    var strDeckMaterialOption = String()
    var strDeckControlOption = String()
    var strDeckSealOption = String()
    var strDeckLiftOption = String()
    var strDeckHazardsOption = String()
    var strDeckLevelOption = String()
    var strDeckSlopeOption = String()
    var strDeckDrainageOption = String()
    var strDeckHandrailsOption = String()
    var strDeckDeepDropOption = String()
    
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.prepareFormInspectionDeckData()
    }
        
    func prepareFormInspectionDeckData() {
        for _ in 0..<11 {
            let obj = formInspectionPoolData()
            self.secDeck.append(obj)
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
        let indexOfCell = self.tblDeck.indexPath(for: cell)
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
                    
                    
                    managedObject.setValue(dataDeckCondiMainImg, forKey: "deckCondiMainImg")
                    managedObject.setValue(strDeckMaterialOption, forKey: "deckMaterialOption")
                    managedObject.setValue(dataDeckMaterialImg, forKey: "deckMaterialImg")
                    managedObject.setValue(self.secDeck[InspectDeck.DeckMaterial.rawValue].formTextValue, forKey: "deckMaterialData")
                    managedObject.setValue(strDeckControlOption, forKey: "deckControlOption")
                    managedObject.setValue(dataDeckControlImg, forKey: "deckControlImg")
                    managedObject.setValue(self.secDeck[InspectDeck.DeckControl.rawValue].formTextValue, forKey: "deckControlData")
                    managedObject.setValue(strDeckSealOption, forKey: "deckSealOption")
                    managedObject.setValue(dataDeckSealImg, forKey: "deckSealImg")
                    managedObject.setValue(self.secDeck[InspectDeck.DeckSeal.rawValue].formTextValue, forKey: "deckSealData")
                    managedObject.setValue(strDeckLiftOption, forKey: "deckLiftOption")
                    managedObject.setValue(dataDeckLiftImg, forKey: "deckLiftImg")
                    managedObject.setValue(self.secDeck[InspectDeck.DeckLift.rawValue].formTextValue, forKey: "deckLiftData")
                    managedObject.setValue(strDeckHazardsOption, forKey: "deckHazardsOption")
                    managedObject.setValue(dataDeckHazardsImg, forKey: "deckHazardsImg")
                    managedObject.setValue(self.secDeck[InspectDeck.DeckHazards.rawValue].formTextValue, forKey: "deckHazardsData")
                    managedObject.setValue(strDeckLevelOption, forKey: "deckLevelOption")
                    managedObject.setValue(dataDeckLevelImg, forKey: "deckLevelImg")
                    managedObject.setValue(self.secDeck[InspectDeck.DeckLevel.rawValue].formTextValue, forKey: "deckLevelData")
                    managedObject.setValue(strDeckSlopeOption, forKey: "deckSlopeOption")
                    managedObject.setValue(dataDeckSlopeImg, forKey: "deckSlopeImg")
                    managedObject.setValue(self.secDeck[InspectDeck.DeckSlope.rawValue].formTextValue, forKey: "deckSlopeData")
                    managedObject.setValue(strDeckDrainageOption, forKey: "deckDrainageOption")
                    managedObject.setValue(dataDeckDrainageImg, forKey: "deckDrainageImg")
                    managedObject.setValue(self.secDeck[InspectDeck.DeckDrainage.rawValue].formTextValue, forKey: "deckDrainageData")
                    managedObject.setValue(strDeckHandrailsOption, forKey: "deckHandrailsOption")
                    managedObject.setValue(dataDeckHandrailsImg, forKey: "deckHandrailsImg")
                    managedObject.setValue(self.secDeck[InspectDeck.DeckHandrails.rawValue].formTextValue, forKey: "deckHandrailsData")
                    managedObject.setValue(strDeckDeepDropOption, forKey: "deckDeepDropOption")
                    managedObject.setValue(dataDeckDeepDropImg, forKey: "deckDeepDropImg")
                    managedObject.setValue(self.secDeck[InspectDeck.DeckDeepDrop.rawValue].formTextValue, forKey: "deckDeepDropData")
                    
                    
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
                        print("Data of InspectDeckVC:: \(data)")
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
        //self.postInspectDeck()
        if UIDevice.current.userInterfaceIdiom == .phone {
            let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
            let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectHandrails") as! InspectHandrailsVC
            self.navigationController?.pushViewController(formVC, animated: true)
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
            let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectHandrails") as! InspectHandrailsVC
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
                        self.strDeckCondiMainImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 1 {
                        self.strDeckMaterialImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 2 {
                        self.strDeckControlImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 3 {
                        self.strDeckSealImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 4 {
                        self.strDeckLiftImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 5 {
                        self.strDeckHazardsImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 6 {
                        self.strDeckLevelImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 7 {
                        self.strDeckSlopeImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 8 {
                        self.strDeckDrainageImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 9 {
                        self.strDeckHandrailsImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 10 {
                        self.strDeckDeepDropImg = String(describing: data!)
                    }
                    
                    SVProgressHUD.dismiss()
                }
            case .failure(let encodingError):
                    print("error:\(encodingError)")
                    SVProgressHUD.dismiss()
                }
            })
    }
    
    func postInspectDeck() {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        
        let return_id = UserDefaults.standard.value(forKey: "returnKeyForInspection")
        
        let inspectDeckDetails:  NSMutableDictionary = [
            "return_data_id"        : return_id!,
            "deckCondiMainImg"      : strDeckCondiMainImg,
            "deckMaterialOption"    : strDeckMaterialOption,
            "deckMaterialImg"       : strDeckMaterialImg,
            "deckMaterialData"      : self.secDeck[InspectDeck.DeckMaterial.rawValue].formTextValue,
            "deckControlOption"     : strDeckControlOption,
            "deckControlImg"        : strDeckControlImg,
            "deckControlData"       : self.secDeck[InspectDeck.DeckControl.rawValue].formTextValue,
            "deckSealOption"        : strDeckSealOption,
            "deckSealImg"           : strDeckSealImg,
            "deckSealData"          : self.secDeck[InspectDeck.DeckSeal.rawValue].formTextValue,
            "deckLiftOption"        : strDeckLiftOption,
            "deckLiftImg"           : strDeckLiftImg,
            "deckLiftData"          : self.secDeck[InspectDeck.DeckLift.rawValue].formTextValue,
            "deckHazardsOption"     : strDeckHazardsOption,
            "deckHazardsImg"        : strDeckHazardsImg,
            "deckHazardsData"       : self.secDeck[InspectDeck.DeckHazards.rawValue].formTextValue,
            "deckLevelOption"       : strDeckLevelOption,
            "deckLevelImg"          : strDeckLevelImg,
            "deckLevelData"         : self.secDeck[InspectDeck.DeckLevel.rawValue].formTextValue,
            "deckSlopeOption"       : strDeckSlopeOption,
            "deckSlopeImg"          : strDeckSlopeImg,
            "deckSlopeData"         : self.secDeck[InspectDeck.DeckSlope.rawValue].formTextValue,
            "deckDrainageOption"    : strDeckDrainageOption,
            "deckDrainageImg"       : strDeckDrainageImg,
            "deckDrainageData"      : self.secDeck[InspectDeck.DeckDrainage.rawValue].formTextValue,
            "deckHandrailsOption"   : strDeckHandrailsOption,
            "deckHandrailsImg"      : strDeckHandrailsImg,
            "deckHandrailsData"     : self.secDeck[InspectDeck.DeckHandrails.rawValue].formTextValue,
            "deckDeepDropOption"    : strDeckDeepDropOption,
            "deckDeepDropImg"       : strDeckDeepDropImg,
            "deckDeepDropData"      : self.secDeck[InspectDeck.DeckDeepDrop.rawValue].formTextValue
        ]
        
        print("inspectDeckDetails :: \(inspectDeckDetails)")
        //if sharedExtension.connectedToNetwork() {
        ApiManager.sharedInstanceAPI.PostInspectDeck(postId: 1, deckDetails: inspectDeckDetails, onSuccess: { json in
            DispatchQueue.main.async {
                print("InspectionDeckDetails json :: \(String(describing: json))")
                DispatchQueue.main.async(execute: {() -> Void in
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectHandrails") as! InspectHandrailsVC
                        self.navigationController?.pushViewController(formVC, animated: true)
                    } else if UIDevice.current.userInterfaceIdiom == .pad {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectHandrails") as! InspectHandrailsVC
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

extension InspectDeckVC: UploadCollectionProtocol {//MARK:- UploadCollectionProtocol
    func didTapOnCellItem(_indexpath: IndexPath, _imgUrl: String, _videoUrl: String) {
        
    }
    
    func didUpdateCellIndex(_indexpath: Int) {
        
    }
}

extension InspectDeckVC: UITextViewDelegate {
    @objc func updateInspectTextViewValue() {
        let cell = self.tblDeck.cellForRow(at: IndexPath.init(row: self.selectedRowIndex, section: self.sectionIndex))
        guard let _cell = cell else { return  }
        
        if selectedRowIndex == 1 {
            if let addressTblCell = _cell as? DeckMaterialTableCell {
                if let textView = addressTblCell.txtOther {
                    self.secDeck[self.selectedRowIndex].formTextValue = (textView.text)!
                }
            }
        } else if selectedRowIndex == 2 {
            if let addressTblCell = _cell as? DeckControlTableCell {
                if let textView = addressTblCell.txtOther {
                    self.secDeck[self.selectedRowIndex].formTextValue = (textView.text)!
                }
            }
        } else if selectedRowIndex == 3 {
            if let addressTblCell = _cell as? DeckSealTableCell {
                if let textView = addressTblCell.txtOther {
                    self.secDeck[self.selectedRowIndex].formTextValue = (textView.text)!
                }
            }
        } else if selectedRowIndex == 4 {
            if let addressTblCell = _cell as? DeckLiftTableCell {
                if let textView = addressTblCell.txtOther {
                    self.secDeck[self.selectedRowIndex].formTextValue = (textView.text)!
                }
            }
        } else if selectedRowIndex == 5 {
            if let addressTblCell = _cell as? DeckHazardsTableCell {
                if let textView = addressTblCell.txtOther {
                    self.secDeck[self.selectedRowIndex].formTextValue = (textView.text)!
                }
            }
        } else if selectedRowIndex == 6 {
            if let addressTblCell = _cell as? DeckLevelTableCell {
                if let textView = addressTblCell.txtOther {
                    self.secDeck[self.selectedRowIndex].formTextValue = (textView.text)!
                }
            }
        } else if selectedRowIndex == 7 {
            if let addressTblCell = _cell as? DeckSlopeTableCell {
                if let textView = addressTblCell.txtOther {
                    self.secDeck[self.selectedRowIndex].formTextValue = (textView.text)!
                }
            }
        } else if selectedRowIndex == 8 {
            if let addressTblCell = _cell as? DeckDrainageTableCell {
                if let textView = addressTblCell.txtOther {
                    self.secDeck[self.selectedRowIndex].formTextValue = (textView.text)!
                }
            }
        } else if selectedRowIndex == 9 {
            if let addressTblCell = _cell as? DeckHandrailsTableCell {
                if let textView = addressTblCell.txtOther {
                    self.secDeck[self.selectedRowIndex].formTextValue = (textView.text)!
                }
            }
        } else if selectedRowIndex == 10 {
            if let addressTblCell = _cell as? DeckDeepDropTableCell {
                if let textView = addressTblCell.txtOther {
                    self.secDeck[self.selectedRowIndex].formTextValue = (textView.text)!
                }
            }
        }
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        let cell = (textView.superview?.superview as? UITableViewCell)!
        
        let indexpath = self.tblDeck.indexPath(for: cell)
        guard let _indexPath = indexpath else { return false }
        self.selectedRowIndex = _indexPath.row
        self.sectionIndex = _indexPath.section
        
        self.perform(#selector(InspectDeckVC.updateInspectTextViewValue), with: nil, afterDelay: 1)
        
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let cell = (textView.superview?.superview as? UITableViewCell)!
        
        let indexpath = self.tblDeck.indexPath(for: cell)
        guard let _indexPath = indexpath else { return false }
        self.selectedRowIndex = _indexPath.row
        self.sectionIndex = _indexPath.section
        
        self.perform(#selector(InspectDeckVC.updateInspectTextViewValue), with: nil, afterDelay: 1)
        
        return true
    }
}

extension InspectDeckVC: OpalImagePickerControllerDelegate {
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
                                self.arrDeckCondiMainImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataDeckCondiMainImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 1 {
                                self.arrDeckMaterialImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataDeckMaterialImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 2 {
                                self.arrDeckControlImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataDeckControlImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 3 {
                                self.arrDeckSealImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataDeckSealImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 4 {
                                self.arrDeckLiftImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataDeckLiftImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 5 {
                                self.arrDeckHazardsImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataDeckHazardsImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 6 {
                                self.arrDeckLevelImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataDeckLevelImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 7 {
                                self.arrDeckSlopeImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataDeckSlopeImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 8 {
                                self.arrDeckDrainageImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataDeckDrainageImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 9 {
                                self.arrDeckHandrailsImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataDeckHandrailsImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 10 {
                                self.arrDeckDeepDropImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataDeckDeepDropImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
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
                self.tblDeck.reloadData()
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


extension InspectDeckVC: UIImagePickerControllerDelegate {
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
            self.arrDeckCondiMainImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)

            self.dataDeckCondiMainImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 1 {
            self.arrDeckMaterialImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)

            self.dataDeckMaterialImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 2 {
            self.arrDeckControlImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataDeckControlImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 3 {
            self.arrDeckSealImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataDeckSealImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 4 {
            self.arrDeckLiftImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)

            self.dataDeckLiftImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 5 {
            self.arrDeckHazardsImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataDeckHazardsImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 6 {
            self.arrDeckLevelImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataDeckLevelImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 7 {
            self.arrDeckSlopeImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataDeckSlopeImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 8 {
            self.arrDeckDrainageImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)

            self.dataDeckDrainageImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 9 {
            self.arrDeckHandrailsImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)

            self.dataDeckHandrailsImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForUpload == 10 {
            self.arrDeckDeepDropImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)

            self.dataDeckDeepDropImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        }
        
        self.tblDeck.reloadData()
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
}



extension InspectDeckVC: UITableViewDataSource, UITableViewDelegate {
    //MARK:- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cameraCell = tableView.dequeueReusableCell(withIdentifier: "CameraCell", for: indexPath) as! CameraTableCell
            
            cameraCell.lblHeader.text = "Deck Conditions"
            if UIDevice.current.userInterfaceIdiom == .phone {
                cameraCell.lblHeader.font = UIFont(name:"Roboto-bold", size:16)
            } else {
                cameraCell.lblHeader.font = UIFont(name:"Roboto-bold", size:24)
            }
            
            cameraCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

            cameraCell.collectionVw.arrItems = arrDeckCondiMainImg
            cameraCell.collectionVw.delegateItemCollection = self
            cameraCell.collectionVw.reloadImageCollection()
            
            if arrDeckCondiMainImg.count > 0 {
                cameraCell.btnUpload.isHidden = true
                cameraCell.collectionVw.isHidden = false
            } else {
                cameraCell.btnUpload.isHidden = false
                cameraCell.collectionVw.isHidden = true
            }
            
            return cameraCell
        } else if indexPath.row == 1 {
            let optionCell = tableView.dequeueReusableCell(withIdentifier: "DeckMaterialCell", for: indexPath) as! DeckMaterialTableCell
            
            optionCell.lblHeader.text = "What is the decking material constructed of?"
            
            optionCell.lbl1.text = "Concrete"
            optionCell.lbl2.text = "Pavers"
            optionCell.lbl3.text = "Store"
            optionCell.lbl4.text = "Wood"
            optionCell.lbl5.text = "Landscape"
            optionCell.lbl6.text = "Other, Describe"
            
            optionCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            
            optionCell.collectionVw.arrItems = arrDeckMaterialImg
            optionCell.collectionVw.delegateItemCollection = self
            optionCell.collectionVw.reloadImageCollection()
            
            if arrDeckMaterialImg.count > 0 {
                optionCell.btnUpload.isHidden = true
                optionCell.collectionVw.isHidden = false
            } else {
                optionCell.btnUpload.isHidden = false
                optionCell.collectionVw.isHidden = true
            }
            
            optionCell.delegateDeckMaterial = self
            optionCell.txtOther.delegate = self
            
            return optionCell
        } else if indexPath.row == 2 {
            let optionCell = tableView.dequeueReusableCell(withIdentifier: "DeckControlCell", for: indexPath) as! DeckControlTableCell
            
            optionCell.lblHeader.text = "Does the deck have proper control/expansion joints?"

            optionCell.lbl1.text = "Yes"
            optionCell.lbl2.text = "No"
            optionCell.lbl3.text = "Not Applicable"

            optionCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            
            optionCell.collectionVw.arrItems = arrDeckControlImg
            optionCell.collectionVw.delegateItemCollection = self
            optionCell.collectionVw.reloadImageCollection()
            
            if arrDeckControlImg.count > 0 {
                optionCell.btnUpload.isHidden = true
                optionCell.collectionVw.isHidden = false
            } else {
                optionCell.btnUpload.isHidden = false
                optionCell.collectionVw.isHidden = true
            }
            
            optionCell.delegateDeckControl = self
            optionCell.txtOther.delegate = self
            
            return optionCell
        } else if indexPath.row == 3 {
            let optionCell = tableView.dequeueReusableCell(withIdentifier: "DeckSealCell", for: indexPath) as! DeckSealTableCell
            
            optionCell.lblHeader.text = "Do the joints have Deck-O-Seal or are they sealed properly?"

            optionCell.lbl1.text = "Yes"
            optionCell.lbl2.text = "No"
            optionCell.lbl3.text = "Not Applicable"

            optionCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            
            optionCell.collectionVw.arrItems = arrDeckSealImg
            optionCell.collectionVw.delegateItemCollection = self
            optionCell.collectionVw.reloadImageCollection()
            
            if arrDeckSealImg.count > 0 {
                optionCell.btnUpload.isHidden = true
                optionCell.collectionVw.isHidden = false
            } else {
                optionCell.btnUpload.isHidden = false
                optionCell.collectionVw.isHidden = true
            }
            
            optionCell.delegateDeckSeal = self
            optionCell.txtOther.delegate = self
            
            return optionCell
        } else if indexPath.row == 4 {
            let optionCell = tableView.dequeueReusableCell(withIdentifier: "DeckLiftCell", for: indexPath) as! DeckLiftTableCell
            
            optionCell.lblHeader.text = "Does the deck have settling or lifting?"
            
            optionCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            
            optionCell.collectionVw.arrItems = arrDeckLiftImg
            optionCell.collectionVw.delegateItemCollection = self
            optionCell.collectionVw.reloadImageCollection()
            
            if arrDeckLiftImg.count > 0 {
                optionCell.btnUpload.isHidden = true
                optionCell.collectionVw.isHidden = false
            } else {
                optionCell.btnUpload.isHidden = false
                optionCell.collectionVw.isHidden = true
            }
            
            optionCell.delegateDeckLift = self
            optionCell.txtOther.delegate = self
            
            return optionCell
        } else if indexPath.row == 5 {
            let optionCell = tableView.dequeueReusableCell(withIdentifier: "DeckHazardsCell", for: indexPath) as! DeckHazardsTableCell
            
            optionCell.lblHeader.text = "Does the deck have any tripping hazards?"
            
            optionCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            
            optionCell.collectionVw.arrItems = arrDeckHazardsImg
            optionCell.collectionVw.delegateItemCollection = self
            optionCell.collectionVw.reloadImageCollection()
            
            if arrDeckHazardsImg.count > 0 {
                optionCell.btnUpload.isHidden = true
                optionCell.collectionVw.isHidden = false
            } else {
                optionCell.btnUpload.isHidden = false
                optionCell.collectionVw.isHidden = true
            }
            
            optionCell.delegateDeckHazards = self
            optionCell.txtOther.delegate = self
            
            return optionCell
        } else if indexPath.row == 6 {
            let optionCell = tableView.dequeueReusableCell(withIdentifier: "DeckLevelCell", for: indexPath) as! DeckLevelTableCell
            
            optionCell.lblHeader.text = "Is the deck level?"
            
            optionCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                        
            optionCell.collectionVw.arrItems = arrDeckLevelImg
            optionCell.collectionVw.delegateItemCollection = self
            optionCell.collectionVw.reloadImageCollection()
            
            if arrDeckLevelImg.count > 0 {
                optionCell.btnUpload.isHidden = true
                optionCell.collectionVw.isHidden = false
            } else {
                optionCell.btnUpload.isHidden = false
                optionCell.collectionVw.isHidden = true
            }
            
            optionCell.delegateDeckLevel = self
            optionCell.txtOther.delegate = self
            
            return optionCell
        } else if indexPath.row == 7 {
            let optionCell = tableView.dequeueReusableCell(withIdentifier: "DeckSlopeCell", for: indexPath) as! DeckSlopeTableCell
            
            optionCell.lblHeader.text = "Does the deck slope toward the pool or SPA?"
            
            optionCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            
            optionCell.collectionVw.arrItems = arrDeckSlopeImg
            optionCell.collectionVw.delegateItemCollection = self
            optionCell.collectionVw.reloadImageCollection()

            if arrDeckSlopeImg.count > 0 {
                optionCell.btnUpload.isHidden = true
                optionCell.collectionVw.isHidden = false
            } else {
                optionCell.btnUpload.isHidden = false
                optionCell.collectionVw.isHidden = true
            }
            
            optionCell.delegateDeckSlope = self
            optionCell.txtOther.delegate = self
            
            return optionCell
        } else if indexPath.row == 8 {
            let optionCell = tableView.dequeueReusableCell(withIdentifier: "DeckDrainageCell", for: indexPath) as! DeckDrainageTableCell
            
            optionCell.lblHeader.text = "Does the deck have proper drainage?"
            
            optionCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

            optionCell.collectionVw.arrItems = arrDeckDrainageImg
            optionCell.collectionVw.delegateItemCollection = self
            optionCell.collectionVw.reloadImageCollection()
            
            if arrDeckDrainageImg.count > 0 {
                optionCell.btnUpload.isHidden = true
                optionCell.collectionVw.isHidden = false
            } else {
                optionCell.btnUpload.isHidden = false
                optionCell.collectionVw.isHidden = true
            }
            
            optionCell.delegateDeckDrainage = self
            optionCell.txtOther.delegate = self
            
            return optionCell
        } else if indexPath.row == 9 {
            let optionCell = tableView.dequeueReusableCell(withIdentifier: "DeckHandrailsCell", for: indexPath) as! DeckHandrailsTableCell
            
            optionCell.lblHeader.text = "Does the deck have proper handrails?"
            
            optionCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            
            optionCell.collectionVw.arrItems = arrDeckHandrailsImg
            optionCell.collectionVw.delegateItemCollection = self
            optionCell.collectionVw.reloadImageCollection()
            
            if arrDeckHandrailsImg.count > 0 {
                optionCell.btnUpload.isHidden = true
                optionCell.collectionVw.isHidden = false
            } else {
                optionCell.btnUpload.isHidden = false
                optionCell.collectionVw.isHidden = true
            }
            
            optionCell.delegateDeckHandrails = self
            optionCell.txtOther.delegate = self
            
            return optionCell
        } else if indexPath.row == 10 {
            let optionCell = tableView.dequeueReusableCell(withIdentifier: "DeckDeepDropCell", for: indexPath) as! DeckDeepDropTableCell
            
            optionCell.lblHeader.text = "Does the deck have any deep drop off's or falling hazards?"
            
            optionCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
            
            optionCell.collectionVw.arrItems = arrDeckDeepDropImg
            optionCell.collectionVw.delegateItemCollection = self
            optionCell.collectionVw.reloadImageCollection()
            
            if arrDeckDeepDropImg.count > 0 {
                optionCell.btnUpload.isHidden = true
                optionCell.collectionVw.isHidden = false
            } else {
                optionCell.btnUpload.isHidden = false
                optionCell.collectionVw.isHidden = true
            }
            
            optionCell.delegateDeckDeepDrop = self
            optionCell.txtOther.delegate = self
            
            return optionCell
        } else { // if indexPath.row == 11 {
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
                return 460
            } else if indexPath.row == 2 {
                return 400
            } else if indexPath.row == 3 {
                return 400
            } else if indexPath.row == 10 {
                return 350
            } else if indexPath.row == 11 {
                return 105
            } else {
                return 340
            }
        } else { // .pad
            if indexPath.row == 0 {
                return 320
            } else if indexPath.row == 1 {
                return 750
            } else if indexPath.row == 2 {
                return 640
            } else if indexPath.row == 3 {
                return 640
            } else if indexPath.row == 10 {
                return 600
            } else if indexPath.row == 11 {
                return 175
            } else {
                return 600
            }
        }
    }
}


extension InspectDeckVC: DeckMaterialCellProtocol, DeckControlCellProtocol, DeckSealCellProtocol, DeckLiftCellProtocol, DeckHazardsCellProtocol, DeckLevelCellProtocol, DeckSlopeCellProtocol, DeckDrainageCellProtocol, DeckHandrailsCellProtocol, DeckDeepDropCellProtocol {
    
    func didTapOnCellDeckMaterial(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
           strDeckMaterialOption = "Concrete"
        } else if _btnDescribeTag == 1 {
           strDeckMaterialOption = "Pavers"
        } else if _btnDescribeTag == 2 {
           strDeckMaterialOption = "Store"
        } else if _btnDescribeTag == 3 {
           strDeckMaterialOption = "Wood"
        } else if _btnDescribeTag == 4 {
           strDeckMaterialOption = "Landscape"
        } else if _btnDescribeTag == 5 {
           strDeckMaterialOption = "Other, Describe"
        }
        self.tblDeck.reloadData()
    }
    
    func didTapOnCellDeckControl(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
           strDeckControlOption = "Yes"
        } else if _btnDescribeTag == 1 {
           strDeckControlOption = "No"
        } else if _btnDescribeTag == 2 {
            strDeckControlOption = "Not Applicable"
        }
        self.tblDeck.reloadData()
    }
    
    func didTapOnCellDeckSeal(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
           strDeckSealOption = "Yes"
        } else if _btnDescribeTag == 1 {
           strDeckSealOption = "No"
        } else if _btnDescribeTag == 2 {
            strDeckSealOption = "Not Applicable"
        }
        self.tblDeck.reloadData()
    }
    
    func didTapOnCellDeckLift(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
           strDeckLiftOption = "Yes"
        } else if _btnDescribeTag == 1 {
           strDeckLiftOption = "No"
        }
        self.tblDeck.reloadData()
    }
    
    func didTapOnCellDeckHazards(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
           strDeckHazardsOption = "Yes"
        } else if _btnDescribeTag == 1 {
           strDeckHazardsOption = "No"
        }
        self.tblDeck.reloadData()
    }
    
    func didTapOnCellDeckLevel(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
           strDeckLevelOption = "Yes"
        } else if _btnDescribeTag == 1 {
           strDeckLevelOption = "No"
        }
        self.tblDeck.reloadData()
    }
    
    func didTapOnCellDeckSlope(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
           strDeckSlopeOption = "Yes"
        } else if _btnDescribeTag == 1 {
           strDeckSlopeOption = "No"
        }
        self.tblDeck.reloadData()
    }
    
    func didTapOnCellDeckDrainage(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
           strDeckDrainageOption = "Yes"
        } else if _btnDescribeTag == 1 {
           strDeckDrainageOption = "No"
        }
        self.tblDeck.reloadData()
    }
    
    func didTapOnCellDeckHandrails(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
           strDeckHandrailsOption = "Yes"
        } else if _btnDescribeTag == 1 {
           strDeckHandrailsOption = "No"
        }
        self.tblDeck.reloadData()
    }
    
    func didTapOnCellDeckDeepDrop(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
           strDeckDeepDropOption = "Yes"
        } else if _btnDescribeTag == 1 {
           strDeckDeepDropOption = "No"
        }
        self.tblDeck.reloadData()
    }
    
}
