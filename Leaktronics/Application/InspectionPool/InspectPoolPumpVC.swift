//
//  InspectPoolPumpVC.swift
//  Leaktronics
//
//  Created by Abhishek Mullick on 07/05/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import CoreData
import DLRadioButton
import SVProgressHUD
import Alamofire
import Photos
import OpalImagePicker


class InspectPoolPumpVC: UIViewController,UINavigationControllerDelegate, UploadCollectionProtocol {

    @IBOutlet weak var tblPoolPump: UITableView!
    
    var secPump = [formInspectionPoolData]()
    var secSpaJetPump = [formInspectionPoolData]()
    
    enum Pump: Int {
        case poolFiltration = 0
        case poolMaintainance = 1
        case poolAdequate = 2
        case poolMounted = 3
        case poolVisibleLeak = 4
        case poolGaskets = 5
        case poolVisibleAdequateSize = 6
        case poolEquipmentRun = 7
        case spaJets = 8
    }
    
    enum SpaJetPump: Int {
       case pumpOperating = 0
       case maintaianceAccess = 1
       case adequateSize = 2
       case mounted = 3
       case visibleLeak = 4
       case gaskets = 5
       case visibleAdequateSize = 6
       case runQuietly = 7
    }
    
    var fetchIndexForUpload: Int = -1
    var fetchIndexForSubPumpUpload: Int = -1
    
    var imagePicker = UIImagePickerController()
    var picker:UIImagePickerController? = UIImagePickerController()
    
    
    var poolFiltrationOption = String()
    var poolFiltrationText = String()
    var poolMaintainanceOption = String()
    var poolMaintainanceText = String()
    var poolAdequateSizeOption = String()
    var poolAdequateSizeText = String()
    var poolMountedOption = String()
    var poolMountedText = String()
    var poolVisibleLeakOption = String()
    var poolVisibleLeakText = String()
    var poolGasketskOption = String()
    var poolGasketsText = String()
    var poolVisibleAdequateSizeOption = String()
    var poolVisibleAdequateSizeText = String()
    var poolEquipmentRunOption = String()
    var poolEquipmentRunText = String()

    var strSpaJetsOption = String()
    var SpaJetsText = String()
    
    //For Images
    var arrPumpMainImg: [CollectionImageObject] = []
    var arrPumpFiltrationImg: [CollectionImageObject] = []
    var arrPumpMaintainanceImg: [CollectionImageObject] = []
    var arrPumpAdequateImg: [CollectionImageObject] = []
    var arrPumpMountedImg: [CollectionImageObject] = []
    var arrPumpLeakImg: [CollectionImageObject] = []
    var arrPumpGasketsImg: [CollectionImageObject] = []
    var arrPumpSizeImg: [CollectionImageObject] = []
    var arrPumpEquipmentImg: [CollectionImageObject] = []
    
    var arrSpaJetsMainImg: [CollectionImageObject] = []
    var arrSpaJetsImg: [CollectionImageObject] = []

    var arrImgSpaJets0: [CollectionImageObject] = []
    var arrImgSpaJets1: [CollectionImageObject] = []
    var arrImgSpaJets2: [CollectionImageObject] = []
    var arrImgSpaJets3: [CollectionImageObject] = []
    var arrImgSpaJets4: [CollectionImageObject] = []
    var arrImgSpaJets5: [CollectionImageObject] = []
    var arrImgSpaJets6: [CollectionImageObject] = []
    var arrImgSpaJets7: [CollectionImageObject] = []
    
    //For Image Server path
    var strPumpMainImg = String()
    var strPumpFiltrationImg = String()
    var strPumpMaintainanceImg = String()
    var strPumpAdequateImg = String()
    var strPumpMountedImg = String()
    var strPumpLeakImg = String()
    var strPumpGasketsImg = String()
    var strPumpSizeImg = String()
    var strPumpEquipmentImg = String()
    
    var strSpaJetsMainImg = String()
    var strSpaJetsImg = String()
    var strSpaJetsImg0 = String()
    var strSpaJetsImg1 = String()
    var strSpaJetsImg2 = String()
    var strSpaJetsImg3 = String()
    var strSpaJetsImg4 = String()
    var strSpaJetsImg5 = String()
    var strSpaJetsImg6 = String()
    var strSpaJetsImg7 = String()
    
    
    //For Image CoreData
    var dataPumpMainImg = NSData()
    var dataPumpFiltrationImg = NSData()
    var dataPumpMaintainanceImg = NSData()
    var dataPumpAdequateImg = NSData()
    var dataPumpMountedImg = NSData()
    var dataPumpLeakImg = NSData()
    var dataPumpGasketsImg = NSData()
    var dataPumpSizeImg = NSData()
    var dataPumpEquipmentImg = NSData()
    
    var dataSpaJetsMainImg = NSData()
    var dataSpaJetsImg = NSData()
    var dataSpaJetsImg0 = NSData()
    var dataSpaJetsImg1 = NSData()
    var dataSpaJetsImg2 = NSData()
    var dataSpaJetsImg3 = NSData()
    var dataSpaJetsImg4 = NSData()
    var dataSpaJetsImg5 = NSData()
    var dataSpaJetsImg6 = NSData()
    var dataSpaJetsImg7 = NSData()
    
    
    
    //For Options
    var strPumpFiltrationOpt = String()
    var strPumpMaintainanceOpt = String()
    var strPumpAdequateOpt = String()
    var strPumpMountedOpt = String()
    var strPumpLeakOpt = String()
    var strPumpGasketsOpt = String()
    var strPumpSizeOpt = String()
    var strPumpEquipmentOpt = String()
    
    var strSpaJetsOpt = String()
    var strOptSpaJets0 = String()
    var strOptSpaJets1 = String()
    var strOptSpaJets2 = String()
    var strOptSpaJets3 = String()
    var strOptSpaJets4 = String()
    var strOptSpaJets5 = String()
    var strOptSpaJets6 = String()
    var strOptSpaJets7 = String()
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.prepareFormPoolPumpData()
    }
    
    func prepareFormPoolPumpData() {
          for _ in 0..<9 {
              let obj = formInspectionPoolData()
              self.secPump.append(obj)
          }
         for _ in 0..<8 {
             let obj = formInspectionPoolData()
             self.secSpaJetPump.append(obj)
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
        let indexOfCell = self.tblPoolPump.indexPath(for: cell)
        print("Clicked Index : \(String(describing: indexOfCell?.row))")
        
        fetchIndexForSubPumpUpload = -1
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
    
    @objc func btnPumpImgUpload(_ sender: Any) {
        print("Button pressed 👍 ")
        let btn = sender as! UIButton
        let cell = btn.superview?.superview?.superview as! UITableViewCell
        let tblPump = self.view.viewWithTag(25) as! UITableView
        let indexOfCell = tblPump.indexPath(for: cell)
        print("Clicked Index : \(String(describing: indexOfCell?.row))")
        fetchIndexForUpload = -1
        fetchIndexForSubPumpUpload = (indexOfCell?.row)!
        
        print("Upload Index : \(String(describing: fetchIndexForSubPumpUpload))")
        
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
        //self.postInspectPoolPump()
        if UIDevice.current.userInterfaceIdiom == .phone {
            let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
            let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectSwimJetSystem") as! InspectSwimJetSystemVC
            self.navigationController?.pushViewController(formVC, animated: true)
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
            let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectSwimJetSystem") as! InspectSwimJetSystemVC
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
                    
                    managedObject.setValue(dataPumpMainImg, forKey: "pumpMainImage")
                    managedObject.setValue(poolFiltrationOption, forKey: "pumpFiltrationOption")
                    managedObject.setValue(dataPumpFiltrationImg, forKey: "pumpFiltrationImage")
                    managedObject.setValue(self.secPump[Pump.poolFiltration.rawValue].formTextValue, forKey: "pumpFiltrationData")
                    managedObject.setValue(poolMaintainanceOption, forKey: "pumpMaintainanceOption")
                    managedObject.setValue(dataPumpMaintainanceImg, forKey: "pumpMaintainanceImage")
                    managedObject.setValue(self.secPump[Pump.poolMaintainance.rawValue].formTextValue, forKey: "pumpMaintainanceData")
                    managedObject.setValue(poolAdequateSizeOption, forKey: "pumpAdequateOption")
                    managedObject.setValue(dataPumpAdequateImg, forKey: "pumpAdequateImage")
                    managedObject.setValue(self.secPump[Pump.poolAdequate.rawValue].formTextValue, forKey: "pumpAdequateData")
                    managedObject.setValue(poolMountedOption, forKey: "pumpMountedOption")
                    managedObject.setValue(dataPumpMountedImg, forKey: "pumpMountedImage")
                    managedObject.setValue(self.secPump[Pump.poolMounted.rawValue].formTextValue, forKey: "pumpMountedData")
                    managedObject.setValue(poolVisibleLeakOption, forKey: "pumpLeakption")
                    managedObject.setValue(dataPumpLeakImg, forKey: "pumpLeakImage")
                    managedObject.setValue(self.secPump[Pump.poolVisibleLeak.rawValue].formTextValue, forKey: "pumpLeakData")
                    managedObject.setValue(poolGasketskOption, forKey: "pumpGasketsOption")
                    managedObject.setValue(dataPumpGasketsImg, forKey: "pumpGasketsImage")
                    managedObject.setValue(self.secPump[Pump.poolGaskets.rawValue].formTextValue, forKey: "pumpGasketsData")
                    managedObject.setValue(poolVisibleAdequateSizeOption, forKey: "pumpSizeOption")
                    managedObject.setValue(dataPumpSizeImg, forKey: "pumpSizeImage")
                    managedObject.setValue(self.secPump[Pump.poolVisibleAdequateSize.rawValue].formTextValue, forKey: "pumpSizeData")
                    managedObject.setValue(poolEquipmentRunOption, forKey: "pumpEquipmentOption")
                    managedObject.setValue(dataPumpEquipmentImg, forKey: "pumpEquipmentImage")
                    managedObject.setValue(self.secPump[Pump.poolEquipmentRun.rawValue].formTextValue, forKey: "pumpEquipmentData")
                    managedObject.setValue(dataSpaJetsMainImg, forKey: "spaJetsMainImage")
                    managedObject.setValue(strSpaJetsOption, forKey: "spaJetsOption")
                    managedObject.setValue(dataSpaJetsImg, forKey: "spaJetsImage")
                    managedObject.setValue(self.secPump[Pump.spaJets.rawValue].formTextValue, forKey: "spaJetsMainData")
                    managedObject.setValue(strOptSpaJets0, forKey: "pumpOperatingOption")
                    managedObject.setValue(dataSpaJetsImg0, forKey: "pumpOperatingImage")
                    managedObject.setValue(self.secSpaJetPump[SpaJetPump.pumpOperating.rawValue].formTextValue, forKey: "pumpOperatingData")
                    managedObject.setValue(strOptSpaJets1, forKey: "maintaianceAccessOption")
                    managedObject.setValue(dataSpaJetsImg1, forKey: "maintaianceAccessImage")
                    managedObject.setValue(self.secSpaJetPump[SpaJetPump.maintaianceAccess.rawValue].formTextValue, forKey: "maintaianceAccessData")
                    managedObject.setValue(strOptSpaJets2, forKey: "adequateSizeOption")
                    managedObject.setValue(dataSpaJetsImg2, forKey: "adequateSizeImage")
                    managedObject.setValue(self.secSpaJetPump[SpaJetPump.adequateSize.rawValue].formTextValue, forKey: "adequateSizeData")
                    managedObject.setValue(strOptSpaJets3, forKey: "mountedOption")
                    managedObject.setValue(dataSpaJetsImg3, forKey: "mountedImage")
                    managedObject.setValue(self.secSpaJetPump[SpaJetPump.mounted.rawValue].formTextValue, forKey: "mountedData")
                    managedObject.setValue(strOptSpaJets4, forKey: "visibleLeakOption")
                    managedObject.setValue(dataSpaJetsImg4, forKey: "visibleLeakImage")
                    managedObject.setValue(self.secSpaJetPump[SpaJetPump.visibleLeak.rawValue].formTextValue, forKey: "visibleLeakData")
                    managedObject.setValue(strOptSpaJets5, forKey: "gasketsOption")
                    managedObject.setValue(dataSpaJetsImg5, forKey: "gasketsImage")
                    managedObject.setValue(self.secSpaJetPump[SpaJetPump.gaskets.rawValue].formTextValue, forKey: "gasketsData")
                    managedObject.setValue(strOptSpaJets6, forKey: "visibleAdequateSizeOption")
                    managedObject.setValue(dataSpaJetsImg6, forKey: "visibleAdequateSizeImage")
                    managedObject.setValue(self.secSpaJetPump[SpaJetPump.visibleAdequateSize.rawValue].formTextValue, forKey: "visibleAdequateSizeData")
                    managedObject.setValue(strOptSpaJets7, forKey: "runQuietlyOption")
                    managedObject.setValue(dataSpaJetsImg7, forKey: "runQuietlyImage")
                    managedObject.setValue(self.secSpaJetPump[SpaJetPump.runQuietly.rawValue].formTextValue, forKey: "runQuietlyData")
                    
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
                        print("Data of QuestionnaireForm1VC:: \(data)")
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
                        self.strPumpMainImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 1 {
                        self.strPumpFiltrationImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 2 {
                        self.strPumpMaintainanceImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 3 {
                        self.strPumpAdequateImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 4 {
                        self.strPumpMountedImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 5 {
                        self.strPumpLeakImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 6 {
                        self.strPumpGasketsImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 7 {
                        self.strPumpSizeImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 8 {
                        self.strPumpEquipmentImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 9 {
                        self.strSpaJetsMainImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 10 {
                        self.strSpaJetsImg = String(describing: data!)
                    }
                    
                    if self.fetchIndexForSubPumpUpload == 0 {
                        self.strSpaJetsImg0 = String(describing: data!)
                    } else if self.fetchIndexForSubPumpUpload == 1 {
                        self.strSpaJetsImg1 = String(describing: data!)
                    } else if self.fetchIndexForSubPumpUpload == 2 {
                        self.strSpaJetsImg2 = String(describing: data!)
                    } else if self.fetchIndexForSubPumpUpload == 3 {
                        self.strSpaJetsImg3 = String(describing: data!)
                    } else if self.fetchIndexForSubPumpUpload == 4 {
                        self.strSpaJetsImg4 = String(describing: data!)
                    } else if self.fetchIndexForSubPumpUpload == 5 {
                        self.strSpaJetsImg5 = String(describing: data!)
                    } else if self.fetchIndexForSubPumpUpload == 6 {
                        self.strSpaJetsImg6 = String(describing: data!)
                    } else if self.fetchIndexForSubPumpUpload == 7 {
                        self.strSpaJetsImg7 = String(describing: data!)
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
    
    func postInspectPoolPump() {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        
        let return_id = UserDefaults.standard.value(forKey: "returnKeyForInspection")
        
        let inspectPumpDetails:  NSMutableDictionary = [
            "return_data_id"            : return_id!,
            "pumpMainImage"             : strPumpMainImg,
            "pumpFiltrationOption"      : poolFiltrationOption,
            "pumpFiltrationImage"       : strPumpFiltrationImg,
            "pumpFiltrationData"        : self.secPump[Pump.poolFiltration.rawValue].formTextValue,
            "pumpMaintainanceOption"    : poolMaintainanceOption,
            "pumpMaintainanceImage"     : strPumpMaintainanceImg,
            "pumpMaintainanceData"      : self.secPump[Pump.poolMaintainance.rawValue].formTextValue,
            "pumpAdequateOption"        : poolAdequateSizeOption,
            "pumpAdequateImage"         : strPumpAdequateImg,
            "pumpAdequateData"          : self.secPump[Pump.poolAdequate.rawValue].formTextValue,
            "pumpMountedOption"         : poolMountedOption,
            "pumpMountedImage"          : strPumpMountedImg,
            "pumpMountedData"           : self.secPump[Pump.poolMounted.rawValue].formTextValue,
            "pumpLeakption"             : poolVisibleLeakOption,
            "pumpLeakImage"             : strPumpLeakImg,
            "pumpLeakData"              : self.secPump[Pump.poolVisibleLeak.rawValue].formTextValue,
            "pumpGasketsOption"         : poolGasketskOption,
            "pumpGasketsImage"          : strPumpGasketsImg,
            "pumpGasketsData"           : self.secPump[Pump.poolGaskets.rawValue].formTextValue,
            "pumpSizeOption"            : poolVisibleAdequateSizeOption,
            "pumpSizeImage"             : strPumpSizeImg,
            "pumpSizeData"              : self.secPump[Pump.poolVisibleAdequateSize.rawValue].formTextValue,
            "pumpEquipmentOption"       : poolEquipmentRunOption,
            "pumpEquipmentImage"        : strPumpEquipmentImg,
            "pumpEquipmentData"         : self.secPump[Pump.poolEquipmentRun.rawValue].formTextValue,
            "spaJetsMainImage"          : strSpaJetsMainImg,
            "spaJetsOption"             : strSpaJetsOption,
            "spaJetsImage"              : strSpaJetsImg,
            "spaJetsMainData"           : self.secPump[Pump.spaJets.rawValue].formTextValue,
            "pumpOperatingOption"       : strOptSpaJets0,
            "pumpOperatingImage"        : strSpaJetsImg0,
            "pumpOperatingData"         : self.secSpaJetPump[SpaJetPump.pumpOperating.rawValue].formTextValue,
            "maintaianceAccessOption"   : strOptSpaJets1,
            "maintaianceAccessImage"    : strSpaJetsImg1,
            "maintaianceAccessData"     : self.secSpaJetPump[SpaJetPump.maintaianceAccess.rawValue].formTextValue,
            "adequateSizeOption"        : strOptSpaJets2,
            "adequateSizeImage"         : strSpaJetsImg2,
            "adequateSizeData"          : self.secSpaJetPump[SpaJetPump.adequateSize.rawValue].formTextValue,
            "mountedOption"             : strOptSpaJets3,
            "mountedImage"              : strSpaJetsImg3,
            "mountedData"               : self.secSpaJetPump[SpaJetPump.mounted.rawValue].formTextValue,
            "visibleLeakOption"         : strOptSpaJets4,
            "visibleLeakImage"          : strSpaJetsImg4,
            "visibleLeakData"           : self.secSpaJetPump[SpaJetPump.visibleLeak.rawValue].formTextValue,
            "gasketsOption"             : strOptSpaJets5,
            "gasketsImage"              : strSpaJetsImg5,
            "gasketsData"               : self.secSpaJetPump[SpaJetPump.gaskets.rawValue].formTextValue,
            "visibleAdequateSizeOption" : strOptSpaJets6,
            "visibleAdequateSizeImage"  : strSpaJetsImg6,
            "visibleAdequateSizeData"   : self.secSpaJetPump[SpaJetPump.visibleAdequateSize.rawValue].formTextValue,
            "runQuietlyOption"          : strOptSpaJets7,
            "runQuietlyImage"           : strSpaJetsImg7,
            "runQuietlyData"            : self.secSpaJetPump[SpaJetPump.runQuietly.rawValue].formTextValue
        ]
        
        print("inspectPumpDetails :: \(inspectPumpDetails)")
        //if sharedExtension.connectedToNetwork() {
        ApiManager.sharedInstanceAPI.PostInspectPoolPump(postId: 1, pumpDetails: inspectPumpDetails, onSuccess: { json in
            DispatchQueue.main.async {
                print("InspectionPoolPumpDetails json :: \(String(describing: json))")
                DispatchQueue.main.async(execute: {() -> Void in
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectSwimJetSystem") as! InspectSwimJetSystemVC
                        self.navigationController?.pushViewController(formVC, animated: true)
                    } else if UIDevice.current.userInterfaceIdiom == .pad {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectSwimJetSystem") as! InspectSwimJetSystemVC
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

extension InspectPoolPumpVC: OpalImagePickerControllerDelegate {
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
                                self.arrPumpMainImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataPumpMainImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 1 {
                                self.arrPumpFiltrationImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataPumpFiltrationImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 2 {
                                self.arrPumpMaintainanceImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataPumpMaintainanceImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 3 {
                                self.arrPumpAdequateImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataPumpAdequateImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 4 {
                                self.arrPumpMountedImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataPumpMountedImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 5 {
                                self.arrPumpLeakImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataPumpLeakImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 6 {
                                self.arrPumpGasketsImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataPumpGasketsImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 7 {
                                self.arrPumpSizeImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataPumpSizeImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 8 {
                                self.arrPumpEquipmentImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataPumpEquipmentImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 9 {
                                self.arrSpaJetsMainImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSpaJetsMainImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 10 {
                                self.arrSpaJetsImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSpaJetsImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            }
                            
                            
                            if self.fetchIndexForSubPumpUpload == 0 {
                                self.arrImgSpaJets0.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSpaJetsImg0 = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubPumpUpload == 1 {
                                self.arrImgSpaJets1.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSpaJetsImg1 = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubPumpUpload == 2 {
                                self.arrImgSpaJets2.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSpaJetsImg2 = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubPumpUpload == 3 {
                                self.arrImgSpaJets3.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSpaJetsImg3 = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubPumpUpload == 4 {
                                self.arrImgSpaJets4.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSpaJetsImg4 = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubPumpUpload == 5 {
                                self.arrImgSpaJets5.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSpaJetsImg5 = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubPumpUpload == 6 {
                                self.arrImgSpaJets6.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSpaJetsImg6 = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubPumpUpload == 7 {
                                self.arrImgSpaJets7.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSpaJetsImg7 = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
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
                self.tblPoolPump.reloadData()
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

extension InspectPoolPumpVC: UIImagePickerControllerDelegate {
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
            self.arrPumpMainImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataPumpMainImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForUpload == 1 {
            self.arrPumpFiltrationImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataPumpFiltrationImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForUpload == 2 {
            self.arrPumpMaintainanceImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataPumpMaintainanceImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForUpload == 3 {
            self.arrPumpAdequateImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataPumpAdequateImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForUpload == 4 {
            self.arrPumpMountedImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataPumpMountedImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForUpload == 5 {
            self.arrPumpLeakImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataPumpLeakImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForUpload == 6 {
            self.arrPumpGasketsImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataPumpGasketsImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForUpload == 7 {
            self.arrPumpSizeImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataPumpSizeImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForUpload == 8 {
            self.arrPumpEquipmentImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataPumpEquipmentImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForUpload == 9 {
            self.arrSpaJetsMainImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSpaJetsMainImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForUpload == 10 {
            self.arrSpaJetsImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSpaJetsImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        }
        
        
        if fetchIndexForSubPumpUpload == 0 {
            self.arrImgSpaJets0.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSpaJetsImg0 = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubPumpUpload == 1 {
            self.arrImgSpaJets1.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSpaJetsImg1 = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubPumpUpload == 2 {
            self.arrImgSpaJets2.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSpaJetsImg2 = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubPumpUpload == 3 {
            self.arrImgSpaJets3.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSpaJetsImg3 = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubPumpUpload == 4 {
            self.arrImgSpaJets4.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSpaJetsImg4 = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubPumpUpload == 5 {
            self.arrImgSpaJets5.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSpaJetsImg5 = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubPumpUpload == 6 {
            self.arrImgSpaJets6.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSpaJetsImg6 = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubPumpUpload == 7 {
            self.arrImgSpaJets7.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSpaJetsImg7 = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        }
        
        self.tblPoolPump.reloadData()
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
}

extension InspectPoolPumpVC: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        var cell = UITableViewCell()
        cell = (textView.superview?.superview as? UITableViewCell)!
        
        if let InspectionPoolFiltrationPumpTableCell = cell as? InspectionPoolFiltrationPumpTableCell {
            if textView == InspectionPoolFiltrationPumpTableCell.txtPoolPump {
                self.secPump[Pump.poolFiltration.rawValue].formTextValue = (textView.text)!
           }
        } else if let InspectionPoolPumpMaintainanceTableCell = cell as? InspectionPoolPumpMaintainanceTableCell {
            if textView == InspectionPoolPumpMaintainanceTableCell.txtPoolPumpMaintainance {
                self.secPump[Pump.poolMaintainance.rawValue].formTextValue = (textView.text)!
            }
        } else if let InspectionPoolPumpAdequateSizeTableCell = cell as? InspectionPoolPumpAdequateSizeTableCell {
            if textView == InspectionPoolPumpAdequateSizeTableCell.txtPoolPumpAdequateSize {
                self.secPump[Pump.poolAdequate.rawValue].formTextValue = (textView.text)!
            }
        } else if let InspectionPoolPumpMountedTableCell = cell as? InspectionPoolPumpMountedTableCell {
            if textView == InspectionPoolPumpMountedTableCell.txtPoolPumpMounted {
                self.secPump[Pump.poolMounted.rawValue].formTextValue = (textView.text)!
            }
        } else if let InspectionPoolPumpVisibleLeakTableCell = cell as? InspectionPoolPumpVisibleLeakTableCell {
            if textView == InspectionPoolPumpVisibleLeakTableCell.txtPoolPumpVisibleLeak {
                self.secPump[Pump.poolVisibleLeak.rawValue].formTextValue = (textView.text)!
            }
        } else if let InspectionPoolPumpGasketsTableCell = cell as? InspectionPoolPumpGasketsTableCell {
            if textView == InspectionPoolPumpGasketsTableCell.txtPoolPumpGaskets {
                self.secPump[Pump.poolGaskets.rawValue].formTextValue = (textView.text)!
            }
        } else if let InspectionPoolPumpVisibleAdequateSizeTableCell = cell as? InspectionPoolPumpVisibleAdequateSizeTableCell {
            if textView == InspectionPoolPumpVisibleAdequateSizeTableCell.txtPoolPumpVisibleAdequateSize {
                self.secPump[Pump.poolVisibleAdequateSize.rawValue].formTextValue = (textView.text)!
            }
        } else if let InspectionPoolPumpEquipmentRunTableCell = cell as? InspectionPoolPumpEquipmentRunTableCell {
            if textView == InspectionPoolPumpEquipmentRunTableCell.txtPoolPumpEquipmentRun {
                self.secPump[Pump.poolEquipmentRun.rawValue].formTextValue = (textView.text)!
            }
        } else if let InspectionSpaJetsPumpTableCell = cell as? InspectionSpaJetsPumpTableCell {
            if textView == InspectionSpaJetsPumpTableCell.txtSpaJets {
                self.secPump[Pump.spaJets.rawValue].formTextValue = (textView.text)!
           }
        } else if let SpaJetPumpOperatingTableCell = cell as? SpaJetPumpOperatingTableCell {
            if textView == SpaJetPumpOperatingTableCell.txtSpaPumpOperating {
                self.secSpaJetPump[SpaJetPump.pumpOperating.rawValue].formTextValue = (textView.text)!
            }
        } else if let SpaJetMaintaianceAccessTableCell = cell as? SpaJetMaintaianceAccessTableCell {
            if textView == SpaJetMaintaianceAccessTableCell.txtSpaJetMaintenance {
                self.secSpaJetPump[SpaJetPump.maintaianceAccess.rawValue].formTextValue = (textView.text)!
            }
        } else if let SpaJetAdequateSizeTableCell = cell as? SpaJetAdequateSizeTableCell {
            if textView == SpaJetAdequateSizeTableCell.txtSpaAdequateSize {
                self.secSpaJetPump[SpaJetPump.adequateSize.rawValue].formTextValue = (textView.text)!
            }
        } else if let SpaJetMountedTableCell = cell as? SpaJetMountedTableCell {
            if textView == SpaJetMountedTableCell.txtSpaMounted {
                self.secSpaJetPump[SpaJetPump.mounted.rawValue].formTextValue = (textView.text)!
            }
        } else if let SpaJetVisibleLeakTableCell = cell as? SpaJetVisibleLeakTableCell {
            if textView == SpaJetVisibleLeakTableCell.txtSpaVisibleLeak {
                self.secSpaJetPump[SpaJetPump.visibleLeak.rawValue].formTextValue = (textView.text)!
            }
        } else if let SpaJetGasketsTableCell = cell as? SpaJetGasketsTableCell {
            if textView == SpaJetGasketsTableCell.txtSpaGaskets {
                self.secSpaJetPump[SpaJetPump.gaskets.rawValue].formTextValue = (textView.text)!
            }
        } else if let SpaJetVisibleAdequateSizeTableCell = cell as? SpaJetVisibleAdequateSizeTableCell {
            if textView == SpaJetVisibleAdequateSizeTableCell.txtVisibleAdequateSize {
                self.secSpaJetPump[SpaJetPump.visibleAdequateSize.rawValue].formTextValue = (textView.text)!
            }
        } else if let SpaJetRunQuietlyTableCell = cell as? SpaJetRunQuietlyTableCell {
            if textView == SpaJetRunQuietlyTableCell.txtSpaRunQuietly {
                self.secSpaJetPump[SpaJetPump.runQuietly.rawValue].formTextValue = (textView.text)!
            }
        }
    }
}

extension InspectPoolPumpVC: UITableViewDataSource, UITableViewDelegate {
    //MARK:- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 25 {
            return 8
        } else {
            return 12
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 25 {
            if indexPath.row == 0 {
                let SpaJetCell = tableView.dequeueReusableCell(withIdentifier: "SpaJetPumpOperatingCell", for: indexPath) as! SpaJetPumpOperatingTableCell
                
                SpaJetCell.btnUpload.addTarget(self, action: #selector(btnPumpImgUpload(_:)), for: UIControl.Event.touchUpInside)

                SpaJetCell.collectionvw.arrItems = arrImgSpaJets0
                SpaJetCell.collectionvw.delegateItemCollection = self
                SpaJetCell.collectionvw.reloadImageCollection()

                if arrImgSpaJets0.count > 0 {
                    SpaJetCell.btnUpload.isHidden = true
                    SpaJetCell.collectionvw.isHidden = false
                } else {
                    SpaJetCell.btnUpload.isHidden = false
                    SpaJetCell.collectionvw.isHidden = true
                }

                SpaJetCell.delegateSpaJetsPump = self
                SpaJetCell.txtSpaPumpOperating.delegate = self
                
                return SpaJetCell
            } else if indexPath.row == 1 {
                let SpaJetCell = tableView.dequeueReusableCell(withIdentifier: "SpaJetMaintaianceAccessCell", for: indexPath) as! SpaJetMaintaianceAccessTableCell
                
                SpaJetCell.btnUpload.addTarget(self, action: #selector(btnPumpImgUpload(_:)), for: UIControl.Event.touchUpInside)

                SpaJetCell.collectionvw.arrItems = arrImgSpaJets1
                SpaJetCell.collectionvw.delegateItemCollection = self
                SpaJetCell.collectionvw.reloadImageCollection()

                if arrImgSpaJets1.count > 0 {
                    SpaJetCell.btnUpload.isHidden = true
                    SpaJetCell.collectionvw.isHidden = false
                } else {
                    SpaJetCell.btnUpload.isHidden = false
                    SpaJetCell.collectionvw.isHidden = true
                }

                SpaJetCell.delegateMainAccess = self
                SpaJetCell.txtSpaJetMaintenance.delegate = self
                
                return SpaJetCell
            } else if indexPath.row == 2 {
                let SpaJetCell = tableView.dequeueReusableCell(withIdentifier: "SpaJetAdequateSizeCell", for: indexPath) as! SpaJetAdequateSizeTableCell
                
                SpaJetCell.btnUpload.addTarget(self, action: #selector(btnPumpImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                SpaJetCell.collectionvw.arrItems = arrImgSpaJets2
                SpaJetCell.collectionvw.delegateItemCollection = self
                SpaJetCell.collectionvw.reloadImageCollection()
                
                if arrImgSpaJets2.count > 0 {
                    SpaJetCell.btnUpload.isHidden = true
                    SpaJetCell.collectionvw.isHidden = false
                } else {
                    SpaJetCell.btnUpload.isHidden = false
                    SpaJetCell.collectionvw.isHidden = true
                }
                
                SpaJetCell.delegateAdequate = self
                SpaJetCell.txtSpaAdequateSize.delegate = self
                
                return SpaJetCell
            } else if indexPath.row == 3 {
                let SpaJetCell = tableView.dequeueReusableCell(withIdentifier: "SpaJetMountedCell", for: indexPath) as! SpaJetMountedTableCell
                
                SpaJetCell.btnUpload.addTarget(self, action: #selector(btnPumpImgUpload(_:)), for: UIControl.Event.touchUpInside)

                SpaJetCell.collectionvw.arrItems = arrImgSpaJets3
                SpaJetCell.collectionvw.delegateItemCollection = self
                SpaJetCell.collectionvw.reloadImageCollection()

                if arrImgSpaJets3.count > 0 {
                    SpaJetCell.btnUpload.isHidden = true
                    SpaJetCell.collectionvw.isHidden = false
                } else {
                    SpaJetCell.btnUpload.isHidden = false
                    SpaJetCell.collectionvw.isHidden = true
                }

                SpaJetCell.delegateMounted = self
                SpaJetCell.txtSpaMounted.delegate = self
                
                return SpaJetCell
            } else if indexPath.row == 4 {
                let SpaJetCell = tableView.dequeueReusableCell(withIdentifier: "SpaJetVisibleLeakCell", for: indexPath) as! SpaJetVisibleLeakTableCell
                
                SpaJetCell.btnUpload.addTarget(self, action: #selector(btnPumpImgUpload(_:)), for: UIControl.Event.touchUpInside)

                SpaJetCell.collectionvw.arrItems = arrImgSpaJets4
                SpaJetCell.collectionvw.delegateItemCollection = self
                SpaJetCell.collectionvw.reloadImageCollection()

                if arrImgSpaJets4.count > 0 {
                    SpaJetCell.btnUpload.isHidden = true
                    SpaJetCell.collectionvw.isHidden = false
                } else {
                    SpaJetCell.btnUpload.isHidden = false
                    SpaJetCell.collectionvw.isHidden = true
                }

                SpaJetCell.delegateLeak = self
                SpaJetCell.txtSpaVisibleLeak.delegate = self
                
                return SpaJetCell
            } else if indexPath.row == 5 {
                let SpaJetCell = tableView.dequeueReusableCell(withIdentifier: "SpaJetGasketsCell", for: indexPath) as! SpaJetGasketsTableCell
                
                SpaJetCell.btnUpload.addTarget(self, action: #selector(btnPumpImgUpload(_:)), for: UIControl.Event.touchUpInside)

                SpaJetCell.collectionvw.arrItems = arrImgSpaJets5
                SpaJetCell.collectionvw.delegateItemCollection = self
                SpaJetCell.collectionvw.reloadImageCollection()

                if arrImgSpaJets5.count > 0 {
                    SpaJetCell.btnUpload.isHidden = true
                    SpaJetCell.collectionvw.isHidden = false
                } else {
                    SpaJetCell.btnUpload.isHidden = false
                    SpaJetCell.collectionvw.isHidden = true
                }

                SpaJetCell.delegateGaskets = self
                SpaJetCell.txtSpaGaskets.delegate = self
                
                return SpaJetCell
            } else if indexPath.row == 6 {
                let SpaJetCell = tableView.dequeueReusableCell(withIdentifier: "SpaJetVisibleAdequateSizeCell", for: indexPath) as! SpaJetVisibleAdequateSizeTableCell
                
                SpaJetCell.btnUpload.addTarget(self, action: #selector(btnPumpImgUpload(_:)), for: UIControl.Event.touchUpInside)

                SpaJetCell.collectionvw.arrItems = arrImgSpaJets6
                SpaJetCell.collectionvw.delegateItemCollection = self
                SpaJetCell.collectionvw.reloadImageCollection()

                if arrImgSpaJets6.count > 0 {
                    SpaJetCell.btnUpload.isHidden = true
                    SpaJetCell.collectionvw.isHidden = false
                } else {
                    SpaJetCell.btnUpload.isHidden = false
                    SpaJetCell.collectionvw.isHidden = true
                }

                SpaJetCell.delegateSize = self
                SpaJetCell.txtVisibleAdequateSize.delegate = self
                
                return SpaJetCell
            } else {//if indexPath.row == 7 {
                let SpaJetCell = tableView.dequeueReusableCell(withIdentifier: "SpaJetRunQuietlyCell", for: indexPath) as! SpaJetRunQuietlyTableCell
                
                SpaJetCell.btnUpload.addTarget(self, action: #selector(btnPumpImgUpload(_:)), for: UIControl.Event.touchUpInside)

                SpaJetCell.collectionvw.arrItems = arrImgSpaJets7
                SpaJetCell.collectionvw.delegateItemCollection = self
                SpaJetCell.collectionvw.reloadImageCollection()

                if arrImgSpaJets7.count > 0 {
                    SpaJetCell.btnUpload.isHidden = true
                    SpaJetCell.collectionvw.isHidden = false
                } else {
                    SpaJetCell.btnUpload.isHidden = false
                    SpaJetCell.collectionvw.isHidden = true
                }

                SpaJetCell.delegateRunQuietly = self
                SpaJetCell.txtSpaRunQuietly.delegate = self
                
                return SpaJetCell
              }
         } else {
            if indexPath.row == 0 {
                let cameraCell = tableView.dequeueReusableCell(withIdentifier: "CameraCell", for: indexPath) as! CameraTableCell
                
                cameraCell.lblHeader.text = "POOL PUMP"
                
                cameraCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                cameraCell.collectionVw.arrItems = arrPumpMainImg
                cameraCell.collectionVw.delegateItemCollection = self
                cameraCell.collectionVw.reloadImageCollection()

                if arrPumpMainImg.count > 0 {
                    cameraCell.btnUpload.isHidden = true
                    cameraCell.collectionVw.isHidden = false
                } else {
                    cameraCell.btnUpload.isHidden = false
                    cameraCell.collectionVw.isHidden = true
                }
                
                return cameraCell
            } else if indexPath.row == 1 {
                let InspectionPoolFiltrationPumpCell = tableView.dequeueReusableCell(withIdentifier: "InspectionPoolFiltrationPumpCell", for: indexPath) as! InspectionPoolFiltrationPumpTableCell
                
                InspectionPoolFiltrationPumpCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                InspectionPoolFiltrationPumpCell.collectionvw.arrItems = arrPumpFiltrationImg
                InspectionPoolFiltrationPumpCell.collectionvw.delegateItemCollection = self
                InspectionPoolFiltrationPumpCell.collectionvw.reloadImageCollection()
                
                if arrPumpFiltrationImg.count > 0 {
                    InspectionPoolFiltrationPumpCell.btnUpload.isHidden = true
                    InspectionPoolFiltrationPumpCell.collectionvw.isHidden = false
                } else {
                    InspectionPoolFiltrationPumpCell.btnUpload.isHidden = false
                    InspectionPoolFiltrationPumpCell.collectionvw.isHidden = true
                }
                
                InspectionPoolFiltrationPumpCell.delegatePoolFiltrationPump = self
                InspectionPoolFiltrationPumpCell.txtPoolPump.delegate = self
                
                return InspectionPoolFiltrationPumpCell
            } else if indexPath.row == 2 {
                let InspectionPoolPumpMaintainanceCell = tableView.dequeueReusableCell(withIdentifier: "InspectionPoolPumpMaintainanceCell", for: indexPath) as! InspectionPoolPumpMaintainanceTableCell
                
                InspectionPoolPumpMaintainanceCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                InspectionPoolPumpMaintainanceCell.collectionvw.arrItems = arrPumpMaintainanceImg
                InspectionPoolPumpMaintainanceCell.collectionvw.delegateItemCollection = self
                InspectionPoolPumpMaintainanceCell.collectionvw.reloadImageCollection()
                
                if arrPumpMaintainanceImg.count > 0 {
                    InspectionPoolPumpMaintainanceCell.btnUpload.isHidden = true
                    InspectionPoolPumpMaintainanceCell.collectionvw.isHidden = false
                } else {
                    InspectionPoolPumpMaintainanceCell.btnUpload.isHidden = false
                    InspectionPoolPumpMaintainanceCell.collectionvw.isHidden = true
                }
                
                InspectionPoolPumpMaintainanceCell.delegatePoolMaintainancePump = self
                InspectionPoolPumpMaintainanceCell.txtPoolPumpMaintainance.delegate = self
                
                return InspectionPoolPumpMaintainanceCell
            } else if indexPath.row == 3 {
                let InspectionPoolPumpAdequateSizeCell = tableView.dequeueReusableCell(withIdentifier: "InspectionPoolPumpAdequateSizeCell", for: indexPath) as! InspectionPoolPumpAdequateSizeTableCell
                
                InspectionPoolPumpAdequateSizeCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                InspectionPoolPumpAdequateSizeCell.collectionvw.arrItems = arrPumpAdequateImg
                InspectionPoolPumpAdequateSizeCell.collectionvw.delegateItemCollection = self
                InspectionPoolPumpAdequateSizeCell.collectionvw.reloadImageCollection()
                
                if arrPumpAdequateImg.count > 0 {
                    InspectionPoolPumpAdequateSizeCell.btnUpload.isHidden = true
                    InspectionPoolPumpAdequateSizeCell.collectionvw.isHidden = false
                } else {
                    InspectionPoolPumpAdequateSizeCell.btnUpload.isHidden = false
                    InspectionPoolPumpAdequateSizeCell.collectionvw.isHidden = true
                }
                
                InspectionPoolPumpAdequateSizeCell.delegatePoolPumpAdequateSize = self
                InspectionPoolPumpAdequateSizeCell.txtPoolPumpAdequateSize.delegate = self
                
                return InspectionPoolPumpAdequateSizeCell
            } else if indexPath.row == 4 {
                let InspectionPoolPumpMountedCell = tableView.dequeueReusableCell(withIdentifier: "InspectionPoolPumpMountedCell", for: indexPath) as! InspectionPoolPumpMountedTableCell
                
                InspectionPoolPumpMountedCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                InspectionPoolPumpMountedCell.collectionvw.arrItems = arrPumpMountedImg
                InspectionPoolPumpMountedCell.collectionvw.delegateItemCollection = self
                InspectionPoolPumpMountedCell.collectionvw.reloadImageCollection()
                
                if arrPumpMountedImg.count > 0 {
                    InspectionPoolPumpMountedCell.btnUpload.isHidden = true
                    InspectionPoolPumpMountedCell.collectionvw.isHidden = false
                } else {
                    InspectionPoolPumpMountedCell.btnUpload.isHidden = false
                    InspectionPoolPumpMountedCell.collectionvw.isHidden = true
                }
                
                InspectionPoolPumpMountedCell.delegatePoolPumpMounted = self
                InspectionPoolPumpMountedCell.txtPoolPumpMounted.delegate = self
                
                
                return InspectionPoolPumpMountedCell
            } else if indexPath.row == 5 {
                let InspectionPoolPumpVisibleLeakCell = tableView.dequeueReusableCell(withIdentifier: "InspectionPoolPumpVisibleLeakCell", for: indexPath) as! InspectionPoolPumpVisibleLeakTableCell
                
                InspectionPoolPumpVisibleLeakCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                InspectionPoolPumpVisibleLeakCell.collectionvw.arrItems = arrPumpLeakImg
                InspectionPoolPumpVisibleLeakCell.collectionvw.delegateItemCollection = self
                InspectionPoolPumpVisibleLeakCell.collectionvw.reloadImageCollection()
                
                if arrPumpLeakImg.count > 0 {
                    InspectionPoolPumpVisibleLeakCell.btnUpload.isHidden = true
                    InspectionPoolPumpVisibleLeakCell.collectionvw.isHidden = false
                } else {
                    InspectionPoolPumpVisibleLeakCell.btnUpload.isHidden = false
                    InspectionPoolPumpVisibleLeakCell.collectionvw.isHidden = true
                }
                
                InspectionPoolPumpVisibleLeakCell.delegatePoolPumpVisibleLeak = self
                InspectionPoolPumpVisibleLeakCell.txtPoolPumpVisibleLeak.delegate = self
                
                return InspectionPoolPumpVisibleLeakCell
            } else if indexPath.row == 6 {
                let InspectionPoolPumpGasketsCell = tableView.dequeueReusableCell(withIdentifier: "InspectionPoolPumpGasketsCell", for: indexPath) as! InspectionPoolPumpGasketsTableCell
                
                InspectionPoolPumpGasketsCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                InspectionPoolPumpGasketsCell.collectionvw.arrItems = arrPumpGasketsImg
                InspectionPoolPumpGasketsCell.collectionvw.delegateItemCollection = self
                InspectionPoolPumpGasketsCell.collectionvw.reloadImageCollection()
                
                if arrPumpGasketsImg.count > 0 {
                    InspectionPoolPumpGasketsCell.btnUpload.isHidden = true
                    InspectionPoolPumpGasketsCell.collectionvw.isHidden = false
                } else {
                    InspectionPoolPumpGasketsCell.btnUpload.isHidden = false
                    InspectionPoolPumpGasketsCell.collectionvw.isHidden = true
                }
                
                InspectionPoolPumpGasketsCell.delegatePoolPumpGaskets = self
                InspectionPoolPumpGasketsCell.txtPoolPumpGaskets.delegate = self
                
                return InspectionPoolPumpGasketsCell
            } else if indexPath.row == 7 {
                let InspectionPoolPumpVisibleAdequateSizeCell = tableView.dequeueReusableCell(withIdentifier: "InspectionPoolPumpVisibleAdequateSizeCell", for: indexPath) as! InspectionPoolPumpVisibleAdequateSizeTableCell
                
                InspectionPoolPumpVisibleAdequateSizeCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                InspectionPoolPumpVisibleAdequateSizeCell.collectionvw.arrItems = arrPumpSizeImg
                InspectionPoolPumpVisibleAdequateSizeCell.collectionvw.delegateItemCollection = self
                InspectionPoolPumpVisibleAdequateSizeCell.collectionvw.reloadImageCollection()
                
                if arrPumpSizeImg.count > 0 {
                    InspectionPoolPumpVisibleAdequateSizeCell.btnUpload.isHidden = true
                    InspectionPoolPumpVisibleAdequateSizeCell.collectionvw.isHidden = false
                } else {
                    InspectionPoolPumpVisibleAdequateSizeCell.btnUpload.isHidden = false
                    InspectionPoolPumpVisibleAdequateSizeCell.collectionvw.isHidden = true
                }
                
                InspectionPoolPumpVisibleAdequateSizeCell.delegatePoolPumpVisibleAdequateSize = self
                InspectionPoolPumpVisibleAdequateSizeCell.txtPoolPumpVisibleAdequateSize.delegate = self
                
                return InspectionPoolPumpVisibleAdequateSizeCell
            } else if indexPath.row == 8 {
                let InspectionPoolPumpEquipmentRunCell = tableView.dequeueReusableCell(withIdentifier: "InspectionPoolPumpEquipmentRunCell", for: indexPath) as! InspectionPoolPumpEquipmentRunTableCell
                
                InspectionPoolPumpEquipmentRunCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                InspectionPoolPumpEquipmentRunCell.collectionvw.arrItems = arrPumpEquipmentImg
                InspectionPoolPumpEquipmentRunCell.collectionvw.delegateItemCollection = self
                InspectionPoolPumpEquipmentRunCell.collectionvw.reloadImageCollection()
                
                if arrPumpEquipmentImg.count > 0 {
                    InspectionPoolPumpEquipmentRunCell.btnUpload.isHidden = true
                    InspectionPoolPumpEquipmentRunCell.collectionvw.isHidden = false
                } else {
                    InspectionPoolPumpEquipmentRunCell.btnUpload.isHidden = false
                    InspectionPoolPumpEquipmentRunCell.collectionvw.isHidden = true
                }
                
                InspectionPoolPumpEquipmentRunCell.delegatePoolPumpEquipmentRun = self
                InspectionPoolPumpEquipmentRunCell.txtPoolPumpEquipmentRun.delegate = self
                
                return InspectionPoolPumpEquipmentRunCell
            } else if indexPath.row == 9 {
                let cameraCell = tableView.dequeueReusableCell(withIdentifier: "CameraCell", for: indexPath) as! CameraTableCell
                
                cameraCell.lblHeader.text = "SpaJets JET PUMP"
                
                cameraCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                cameraCell.collectionVw.arrItems = arrSpaJetsMainImg
                cameraCell.collectionVw.delegateItemCollection = self
                cameraCell.collectionVw.reloadImageCollection()
                
                if arrSpaJetsMainImg.count > 0 {
                    cameraCell.btnUpload.isHidden = true
                    cameraCell.collectionVw.isHidden = false
                } else {
                    cameraCell.btnUpload.isHidden = false
                    cameraCell.collectionVw.isHidden = true
                }
                
                return cameraCell
            } else if indexPath.row == 10 {
                let InspectionSpaJetsPumpCell = tableView.dequeueReusableCell(withIdentifier: "InspectionSpaJetsPumpCell", for: indexPath) as! InspectionSpaJetsPumpTableCell
                
                InspectionSpaJetsPumpCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                InspectionSpaJetsPumpCell.collectionvw.arrItems = arrSpaJetsImg
                InspectionSpaJetsPumpCell.collectionvw.delegateItemCollection = self
                InspectionSpaJetsPumpCell.collectionvw.reloadImageCollection()
                
                if arrSpaJetsImg.count > 0 {
                    InspectionSpaJetsPumpCell.btnUpload.isHidden = true
                    InspectionSpaJetsPumpCell.collectionvw.isHidden = false
                } else {
                    InspectionSpaJetsPumpCell.btnUpload.isHidden = false
                    InspectionSpaJetsPumpCell.collectionvw.isHidden = true
                }
                
                InspectionSpaJetsPumpCell.delegateSpaJets = self
                InspectionSpaJetsPumpCell.txtSpaJets.delegate = self
                
                if strSpaJetsOption == "Yes" {
                    //Declare the outlet in our custom class
                    let tblSpaJets = InspectionSpaJetsPumpCell.viewWithTag(25) as! UITableView
                    
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        InspectionSpaJetsPumpCell.tblSpaJetsHeightConstraint.constant = 350*7+345
                    } else {
                        InspectionSpaJetsPumpCell.tblSpaJetsHeightConstraint.constant = 600*7+585
                    }
                    tblSpaJets.delegate = self
                    tblSpaJets.dataSource = self
                    tblSpaJets.reloadData()
                } else if strSpaJetsOption == "No" {
                   InspectionSpaJetsPumpCell.tblSpaJetsHeightConstraint.constant = 0
                }
                
                return InspectionSpaJetsPumpCell
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
                if indexPath.row == 7 {
                    return 340
                } else {
                    return 340
                }
            } else {
                if indexPath.row == 0 {
                    return 185
                } else if indexPath.row == 9 {
                     return 185
                } else if indexPath.row == 10 {
                     if strSpaJetsOption == "Yes" {
                         return (340*7+340)+340//UITableView.automaticDimension//
                     } else {
                         return 340
                     }
                } else if indexPath.row == 11 {
                     return 105
                } else {
                    return 340
                }
            }
        } else {        //.pad
            if tableView.tag == 25 {
                if indexPath.row == 7 {
                    return 585
                } else {
                    return 600
                }
            } else {
                if indexPath.row == 0 {
                    return 320
                } else if indexPath.row == 9 {
                     return 320
                } else if indexPath.row == 10 {
                     if strSpaJetsOption == "Yes" {
                         return (600*7+585)+600//UITableView.automaticDimension//
                     } else {
                         return 600
                     }
                } else if indexPath.row == 11 {
                     return 175
                } else {
                    return 600
                }
            }
        }
    }
}


extension InspectPoolPumpVC: PoolFiltrationPumpCellProtocol, PoolMaintainancePumpCellProtocol, PoolPumpAdequateSizeCellProtocol, PoolPumpMountedCellProtocol, PoolPumpVisibleLeakCellProtocol, PoolPumpGasketsCellProtocol, PoolPumpVisibleAdequateSizeCellProtocol, PoolPumpEquipmentRunCellProtocol, SpaJetsCellProtocol, SpaJetsPumpCellProtocol, SpaJetsMainAccessCellProtocol, SpaJetsAdequateCellProtocol, SpaJetsMountedCellProtocol, SpaJetsLeakCellProtocol, SpaJetsGasketsCellProtocol, SpaJetsSizeCellProtocol, SpaJetsRunQuietlyCellProtocol {
   
    //MARK:- Pool Pump Protocol
    func didTapOnCellPoolPumpFiltration(_btnPoolPumpFiltrationTag: Int) {
        if _btnPoolPumpFiltrationTag == 0 {
            poolFiltrationOption = "Yes"
        } else if _btnPoolPumpFiltrationTag == 1 {
            poolFiltrationOption = "No"
        }
        self.tblPoolPump.reloadData()
    }
    
    func didTapOnCellPoolMaintainance(_btnPoolPumpMaintainanceTag: Int) {
        if _btnPoolPumpMaintainanceTag == 0 {
            poolMaintainanceOption = "Yes"
        } else if _btnPoolPumpMaintainanceTag == 1 {
            poolMaintainanceOption = "No"
        }
        self.tblPoolPump.reloadData()
    }
    
    func didTapOnCellPoolAdequateSize(_btnPoolPumpAdequateSizeTag: Int) {
        if _btnPoolPumpAdequateSizeTag == 0 {
            poolAdequateSizeOption = "Yes"
        } else if _btnPoolPumpAdequateSizeTag == 1 {
            poolAdequateSizeOption = "No"
        }
        self.tblPoolPump.reloadData()
    }
    
    func didTapOnCellPoolMounted(_btnPoolPumpMountedTag: Int) {
        if _btnPoolPumpMountedTag == 0 {
            poolMountedOption = "Yes"
        } else if _btnPoolPumpMountedTag == 1 {
            poolMountedOption = "No"
        }
        self.tblPoolPump.reloadData()
    }
    
    func didTapOnCellPoolVisibleLeak(_btnPoolPumpVisibleLeakTag: Int){
        if _btnPoolPumpVisibleLeakTag == 0 {
            poolVisibleLeakOption = "Yes"
        } else if _btnPoolPumpVisibleLeakTag == 1 {
            poolVisibleLeakOption = "No"
        }
        self.tblPoolPump.reloadData()
    }
    
    func didTapOnCellPoolGaskets(_btnPoolPumpGasketsTag: Int){
        if _btnPoolPumpGasketsTag == 0 {
            poolGasketskOption = "Yes"
        } else if _btnPoolPumpGasketsTag == 1 {
            poolGasketskOption = "No"
        }
        self.tblPoolPump.reloadData()
    }
    
    func didTapOnCellPoolVisibleAdequateSize(_btnPoolPumpVisibleAdequateSizeTag: Int) {
        if _btnPoolPumpVisibleAdequateSizeTag == 0 {
            poolVisibleAdequateSizeOption = "Yes"
        } else if _btnPoolPumpVisibleAdequateSizeTag == 1 {
            poolVisibleAdequateSizeOption = "No"
        }
        self.tblPoolPump.reloadData()
    }
    
    func didTapOnCellPoolEquipmentRun(_btnPoolPumpEquipmentRunTag: Int) {
        if _btnPoolPumpEquipmentRunTag == 0 {
            poolEquipmentRunOption = "Yes"
        } else if _btnPoolPumpEquipmentRunTag == 1 {
            poolEquipmentRunOption = "No"
        }
        self.tblPoolPump.reloadData()
    }
    
    //MARK:- SpaJets Jets Protocol
    func didTapOnCellSpaJets(_btnSpaJetsTag: Int) {
        if _btnSpaJetsTag == 0 {
            strSpaJetsOption = "Yes"
        } else if _btnSpaJetsTag == 1 {
            strSpaJetsOption = "No"
        }
        self.tblPoolPump.reloadData()
    }
    
    
    func didTapOnCellSpaJetsPump(_btnSpaJetsTag: Int) {
        if _btnSpaJetsTag == 0 {
            strOptSpaJets0 = "Yes"
        } else if _btnSpaJetsTag == 1 {
            strOptSpaJets0 = "No"
        }
        self.tblPoolPump.reloadData()
    }
    
    func didTapOnCellSpaJetsMainAccess(_btnSpaJetsTag: Int) {
        if _btnSpaJetsTag == 0 {
            strOptSpaJets1 = "Yes"
        } else if _btnSpaJetsTag == 1 {
            strOptSpaJets1 = "No"
        }
        self.tblPoolPump.reloadData()
    }
    
    func didTapOnCellSpaJetsAdequate(_btnSpaJetsTag: Int) {
        if _btnSpaJetsTag == 0 {
            strOptSpaJets2 = "Yes"
        } else if _btnSpaJetsTag == 1 {
            strOptSpaJets2 = "No"
        }
        self.tblPoolPump.reloadData()
    }
    
    func didTapOnCellSpaJetsMounted(_btnSpaJetsTag: Int) {
        if _btnSpaJetsTag == 0 {
            strOptSpaJets3 = "Yes"
        } else if _btnSpaJetsTag == 1 {
            strOptSpaJets3 = "No"
        }
        self.tblPoolPump.reloadData()
    }
    
    func didTapOnCellSpaJetsLeak(_btnSpaJetsTag: Int) {
        if _btnSpaJetsTag == 0 {
            strOptSpaJets4 = "Yes"
        } else if _btnSpaJetsTag == 1 {
            strOptSpaJets4 = "No"
        }
        self.tblPoolPump.reloadData()
    }
    
    func didTapOnCellSpaJetsGaskets(_btnSpaJetsTag: Int) {
        if _btnSpaJetsTag == 0 {
            strOptSpaJets5 = "Yes"
        } else if _btnSpaJetsTag == 1 {
            strOptSpaJets5 = "No"
        }
        self.tblPoolPump.reloadData()
    }
    
    func didTapOnCellSpaJetsSize(_btnSpaJetsTag: Int) {
        if _btnSpaJetsTag == 0 {
            strOptSpaJets6 = "Yes"
        } else if _btnSpaJetsTag == 1 {
            strOptSpaJets6 = "No"
        }
        self.tblPoolPump.reloadData()
    }
    
    func didTapOnCellSpaJetsRunQuietly(_btnSpaJetsTag: Int) {
        if _btnSpaJetsTag == 0 {
            strOptSpaJets7 = "Yes"
        } else if _btnSpaJetsTag == 1 {
            strOptSpaJets7 = "No"
        }
        self.tblPoolPump.reloadData()
    }
}
