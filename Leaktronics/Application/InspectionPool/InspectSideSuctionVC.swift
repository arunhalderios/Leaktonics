//
//  InspectSideSuctionVC.swift
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


class InspectSideSuctionVC: UIViewController, UINavigationControllerDelegate, UploadCollectionProtocol {
    
    @IBOutlet weak var tblSideSuction: UITableView!
    
    var secSideSuction = [formInspectionPoolData]()
    var secSubSuction = [formInspectionPoolData]()
    var secSubSkimmer = [formInspectionPoolData]()
    
    enum SideSuction: Int {
       case suctionPresent = 1
       case skimmerPresent = 3
    }
    enum SubSuction: Int {
        case suctionInches = 0
        case suctionVGBComplaint = 1
        case suctionMounted = 2
    }
    
    enum SubSkimmer: Int {
        case skimmerOperating = 0
        case skimmerRepair = 1
        case skimmerHeight = 2
        case skimmerWeirDoor = 3
        case skimmerDoorWorking = 4
        case skimmerBasement = 5
        case skimmerBasementCondition = 6
        case skimmerProperDiverter = 7
        case skimmerCondition = 8
        case skimmerCrack = 9
        case skimmerSuctionWorking = 10
        case skimmerEqualizer = 11
        case skimmerEqualizerVGB = 12
        case skimmerMainDrain = 13
    }
    
    var fetchIndexForUpload: Int = -1
    var fetchIndexForSubSuctionUpload: Int = -1
    var fetchIndexForSubSkimUpload: Int = -1
    
    
    var imagePicker = UIImagePickerController()
    var picker:UIImagePickerController? = UIImagePickerController()
    
    
    //For Images
    var arrMainSuctionImg: [CollectionImageObject] = []
    var arrMainSkimmerImg: [CollectionImageObject] = []
    
    var arrSuctionInchesImg: [CollectionImageObject] = []
    var arrSuctionComplaintImg: [CollectionImageObject] = []
    var arrSuctionMountedImg: [CollectionImageObject] = []
    
    var arrSkimOperateImg: [CollectionImageObject] = []
    var arrSkimRepairImg: [CollectionImageObject] = []
    var arrSkimProperHtImg: [CollectionImageObject] = []
    var arrSkimWeirDoorImg: [CollectionImageObject] = []
    var arrSkimDoorWorkImg: [CollectionImageObject] = []
    var arrSkimBasementImg: [CollectionImageObject] = []
    var arrSkimConditionImg: [CollectionImageObject] = []
    var arrSkimDiverImg: [CollectionImageObject] = []
    var arrSkimSeamImg: [CollectionImageObject] = []
    var arrSkimCrackImg: [CollectionImageObject] = []
    var arrSkimSuctionWorkImg: [CollectionImageObject] = []
    var arrSkimEqualizerImg: [CollectionImageObject] = []
    var arrSkimEqualVGBImg: [CollectionImageObject] = []
    var arrSkimDrainImg: [CollectionImageObject] = []
    
    
    //For Image Server path
    var strMainSuctionImg = String()
    var strMainSkimmerImg = String()
    
    var strSuctionInchesImg = String()
    var strSuctionComplaintImg = String()
    var strSuctionMountedImg = String()
    
    var strSkimOperateImg = String()
    var strSkimRepairImg = String()
    var strSkimProperHtImg = String()
    var strSkimWeirDoorImg = String()
    var strSkimDoorWorkImg = String()
    var strSkimBasementImg = String()
    var strSkimConditionImg = String()
    var strSkimDiverImg = String()
    var strSkimSeamImg = String()
    var strSkimCrackImg = String()
    var strSkimSuctionWorkImg = String()
    var strSkimEqualizerImg = String()
    var strSkimEqualVGBImg = String()
    var strSkimDrainImg = String()
    
    
    //For Image CoreData
    var dataMainSuctionImg = NSData()
    var dataMainSkimmerImg = NSData()
    
    var dataSuctionInchesImg = NSData()
    var dataSuctionComplaintImg = NSData()
    var dataSuctionMountedImg = NSData()
    
    var dataSkimOperateImg = NSData()
    var dataSkimRepairImg = NSData()
    var dataSkimProperHtImg = NSData()
    var dataSkimWeirDoorImg = NSData()
    var dataSkimDoorWorkImg = NSData()
    var dataSkimBasementImg = NSData()
    var dataSkimConditionImg = NSData()
    var dataSkimDiverImg = NSData()
    var dataSkimSeamImg = NSData()
    var dataSkimCrackImg = NSData()
    var dataSkimSuctionWorkImg = NSData()
    var dataSkimEqualizerImg = NSData()
    var dataSkimEqualVGBImg = NSData()
    var dataSkimDrainImg = NSData()
    
    
    //For Optional Value
    var strSideSuctionPresentOption = String()
    var strSkimmerPresentOption = String()
    
    var strSuctionInchesOpt = String()
    var strSuctionComplaintOpt = String()
    var strSuctionMountedOpt = String()
    
    var strSkimOperateOpt = String()
    var strSkimRepairOpt = String()
    var strSkimProperHtOpt = String()
    var strSkimWeirDoorOpt = String()
    var strSkimDoorWorkOpt = String()
    var strSkimBasementOpt = String()
    var strSkimConditionOpt = String()
    var strSkimDiverOpt = String()
    var strSkimSeamOpt = String()
    var strSkimCrackOpt = String()
    var strSkimSuctionWorkOpt = String()
    var strSkimEqualizerOpt = String()
    var strSkimEqualVGBOpt = String()
    var strSkimDrainOpt = String()
    
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.prepareFormInspectSideSuctionData()
    }
    
    func prepareFormInspectSideSuctionData() {
        for _ in 0..<5 {
            let obj = formInspectionPoolData()
            self.secSideSuction.append(obj)
        }
        for _ in 0..<3 {
            let obj = formInspectionPoolData()
            self.secSubSuction.append(obj)
        }
        for _ in 0..<14 {
            let obj = formInspectionPoolData()
            self.secSubSkimmer.append(obj)
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
        if (UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
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
        let indexOfCell = self.tblSideSuction.indexPath(for: cell)
        print("Clicked Index : \(String(describing: indexOfCell?.row))")

        fetchIndexForUpload = (indexOfCell?.row)!
        fetchIndexForSubSuctionUpload = -1
        fetchIndexForSubSkimUpload = -1
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
    
    @IBAction func btnSuctionUpload(_ sender: Any) {
        print("Button pressed 👍 ")
        let btn = sender as! UIButton
        let cell = btn.superview?.superview?.superview as! UITableViewCell
        let tblWall = self.view.viewWithTag(25) as! UITableView
        let indexOfCell = tblWall.indexPath(for: cell)
        print("Clicked Index : \(String(describing: indexOfCell?.row))")
        fetchIndexForUpload = -1
        fetchIndexForSubSuctionUpload = (indexOfCell?.row)!
        
        print("Upload Index : \(String(describing: fetchIndexForSubSuctionUpload))")
        
        self.actionSheetPopUpForGalleryOpen()
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnSkimUpload(_ sender: Any) {
        print("Button pressed 👍 ")
        let btn = sender as! UIButton
        let cell = btn.superview?.superview?.superview as! UITableViewCell
        let tblWall = self.view.viewWithTag(35) as! UITableView
        let indexOfCell = tblWall.indexPath(for: cell)
        print("Clicked Index : \(String(describing: indexOfCell?.row))")
        fetchIndexForUpload = -1
        fetchIndexForSubSkimUpload = (indexOfCell?.row)!
        
        print("Upload Index : \(String(describing: fetchIndexForSubSkimUpload))")
        
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
                    
                    managedObject.setValue(dataMainSuctionImg, forKey: "mainSuctionImage")
                    managedObject.setValue(strSideSuctionPresentOption, forKey: "mainSuctionOption")
                    managedObject.setValue(self.secSideSuction[SideSuction.suctionPresent.rawValue].formTextValue, forKey: "mainSuctionData")
                    managedObject.setValue(dataMainSkimmerImg, forKey: "mainSkimmerImage")
                    managedObject.setValue(strSkimmerPresentOption, forKey: "mainSkimmerOption")
                    managedObject.setValue(self.secSideSuction[SideSuction.skimmerPresent.rawValue].formTextValue, forKey: "mainSkimmerData")
                    managedObject.setValue(dataSuctionInchesImg, forKey: "suctionInchesImage")
                    managedObject.setValue(strSuctionInchesOpt, forKey: "suctionInchesOption")
                    managedObject.setValue(self.secSubSuction[SubSuction.suctionInches.rawValue].formTextValue, forKey: "suctionInchesData")
                    managedObject.setValue(dataSuctionComplaintImg, forKey: "suctionVGBComplaintImage")
                    managedObject.setValue(strSuctionComplaintOpt, forKey: "suctionVGBComplaintOption")
                    managedObject.setValue(self.secSubSuction[SubSuction.suctionVGBComplaint.rawValue].formTextValue, forKey: "suctionVGBComplaintData")
                    managedObject.setValue(dataSuctionMountedImg, forKey: "suctionMountedImage")
                    managedObject.setValue(strSuctionMountedOpt, forKey: "suctionMountedOption")
                    managedObject.setValue(self.secSubSuction[SubSuction.suctionMounted.rawValue].formTextValue, forKey: "suctionMountedData")
                    managedObject.setValue(dataSkimOperateImg, forKey: "skimmerOperateImage")
                    managedObject.setValue(strSkimOperateOpt, forKey: "skimmerOperateOption")
                    managedObject.setValue(self.secSubSkimmer[SubSkimmer.skimmerOperating.rawValue].formTextValue, forKey: "skimmerOperateData")
                    managedObject.setValue(dataSkimRepairImg, forKey: "skimmerRepairImage")
                    managedObject.setValue(strSkimRepairOpt, forKey: "skimmerRepairOption")
                    managedObject.setValue(self.secSubSkimmer[SubSkimmer.skimmerRepair.rawValue].formTextValue, forKey: "skimmerRepairData")
                    managedObject.setValue(dataSkimProperHtImg, forKey: "skimmerProperHtImage")
                    managedObject.setValue(strSkimProperHtOpt, forKey: "skimmerProperHtOption")
                    managedObject.setValue(self.secSubSkimmer[SubSkimmer.skimmerHeight.rawValue].formTextValue, forKey: "skimmerProperHtData")
                    managedObject.setValue(dataSkimWeirDoorImg, forKey: "skimmerWeirDoorImage")
                    managedObject.setValue(strSkimWeirDoorOpt, forKey: "skimmerWeirDoorOption")
                    managedObject.setValue(self.secSubSkimmer[SubSkimmer.skimmerWeirDoor.rawValue].formTextValue, forKey: "skimmerWeirDoorData")
                    managedObject.setValue(dataSkimDoorWorkImg, forKey: "skimmerDoorWorkImage")
                    managedObject.setValue(strSkimDoorWorkOpt, forKey: "skimmerDoorWorkOption")
                    managedObject.setValue(self.secSubSkimmer[SubSkimmer.skimmerDoorWorking.rawValue].formTextValue, forKey: "skimmerDoorWorkData")
                    managedObject.setValue(dataSkimBasementImg, forKey: "skimmerBasementImage")
                    managedObject.setValue(strSkimBasementOpt, forKey: "skimmerBasementOption")
                    managedObject.setValue(self.secSubSkimmer[SubSkimmer.skimmerBasement.rawValue].formTextValue, forKey: "skimmerBasementData")
                    managedObject.setValue(dataSkimConditionImg, forKey: "skimmerConditionImage")
                    managedObject.setValue(strSkimConditionOpt, forKey: "skimmerConditionOption")
                    managedObject.setValue(self.secSubSkimmer[SubSkimmer.skimmerBasementCondition.rawValue].formTextValue, forKey: "skimmerConditionData")
                    managedObject.setValue(dataSkimDiverImg, forKey: "skimmerDiverImage")
                    managedObject.setValue(strSkimDiverOpt, forKey: "skimmerDiverOption")
                    managedObject.setValue(self.secSubSkimmer[SubSkimmer.skimmerProperDiverter.rawValue].formTextValue, forKey: "skimmerDiverData")
                    managedObject.setValue(dataSkimSeamImg, forKey: "skimmerSeamImage")
                    managedObject.setValue(strSkimSeamOpt, forKey: "skimmerSeamOption")
                    managedObject.setValue(self.secSubSkimmer[SubSkimmer.skimmerCondition.rawValue].formTextValue, forKey: "skimmerSeamData")
                    managedObject.setValue(dataSkimCrackImg, forKey: "skimmerCrackImage")
                    managedObject.setValue(strSkimCrackOpt, forKey: "skimmerCrackOption")
                    managedObject.setValue(self.secSubSkimmer[SubSkimmer.skimmerCrack.rawValue].formTextValue, forKey: "skimmerCrackData")
                    managedObject.setValue(dataSkimSuctionWorkImg, forKey: "skimmerSuctionWorkImage")
                    managedObject.setValue(strSkimSuctionWorkOpt, forKey: "skimmerSuctionWorkOption")
                    managedObject.setValue(self.secSubSkimmer[SubSkimmer.skimmerSuctionWorking.rawValue].formTextValue, forKey: "skimmerSuctionWorkData")
                    managedObject.setValue(dataSkimEqualizerImg, forKey: "skimmerEqualizerImage")
                    managedObject.setValue(strSkimEqualizerOpt, forKey: "skimmerEqualizerOption")
                    managedObject.setValue(self.secSubSkimmer[SubSkimmer.skimmerEqualizer.rawValue].formTextValue, forKey: "skimmerEqualizerData")
                    managedObject.setValue(dataSkimEqualVGBImg, forKey: "skimmerEqualizerVGBImage")
                    managedObject.setValue(strSkimEqualVGBOpt, forKey: "skimmerEqualizerVGBOption")
                    managedObject.setValue(self.secSubSkimmer[SubSkimmer.skimmerEqualizerVGB.rawValue].formTextValue, forKey: "skimmerEqualizerVGBData")
                    managedObject.setValue(dataSkimDrainImg, forKey: "skimmerMainDrainImage")
                    managedObject.setValue(strSkimDrainOpt, forKey: "skimmerMainDrainOption")
                    managedObject.setValue(self.secSubSkimmer[SubSkimmer.skimmerMainDrain.rawValue].formTextValue, forKey: "skimmerMainDrainData")
                    
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
                        print("Data of InspectSideSuctionVC:: \(data)")
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
        //self.postInspectSideSuction()
        if UIDevice.current.userInterfaceIdiom == .phone {
            let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
            let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectAutofill") as! InspectAutofillVC
            self.navigationController?.pushViewController(formVC, animated: true)
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
            let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectAutofill") as! InspectAutofillVC
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
                        self.strMainSuctionImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 3 {
                        self.strMainSkimmerImg = String(describing: data!)
                    }
                    
                    if self.fetchIndexForSubSuctionUpload == 0 {
                        self.strSuctionInchesImg = String(describing: data!)
                    } else if self.fetchIndexForSubSuctionUpload == 1 {
                        self.strSuctionComplaintImg = String(describing: data!)
                    } else if self.fetchIndexForSubSuctionUpload == 2 {
                        self.strSuctionMountedImg = String(describing: data!)
                    }
                    
                    if self.fetchIndexForSubSkimUpload == 0 {
                        self.strSkimOperateImg = String(describing: data!)
                    } else if self.fetchIndexForSubSkimUpload == 1 {
                        self.strSkimRepairImg = String(describing: data!)
                    } else if self.fetchIndexForSubSkimUpload == 2 {
                        self.strSkimProperHtImg = String(describing: data!)
                    } else if self.fetchIndexForSubSkimUpload == 3 {
                        self.strSkimWeirDoorImg = String(describing: data!)
                    } else if self.fetchIndexForSubSkimUpload == 4 {
                        self.strSkimDoorWorkImg = String(describing: data!)
                    } else if self.fetchIndexForSubSkimUpload == 5 {
                        self.strSkimBasementImg = String(describing: data!)
                    } else if self.fetchIndexForSubSkimUpload == 6 {
                        self.strSkimConditionImg = String(describing: data!)
                    } else if self.fetchIndexForSubSkimUpload == 7 {
                        self.strSkimDiverImg = String(describing: data!)
                    } else if self.fetchIndexForSubSkimUpload == 8 {
                        self.strSkimSeamImg = String(describing: data!)
                    } else if self.fetchIndexForSubSkimUpload == 9 {
                        self.strSkimCrackImg = String(describing: data!)
                    } else if self.fetchIndexForSubSkimUpload == 10 {
                        self.strSkimSuctionWorkImg = String(describing: data!)
                    } else if self.fetchIndexForSubSkimUpload == 11 {
                        self.strSkimEqualizerImg = String(describing: data!)
                    } else if self.fetchIndexForSubSkimUpload == 12 {
                        self.strSkimEqualVGBImg = String(describing: data!)
                    } else if self.fetchIndexForSubSkimUpload == 13 {
                        self.strSkimDrainImg = String(describing: data!)
                    }

                    SVProgressHUD.dismiss()
                }
            case .failure(let encodingError):
                print("error:\(encodingError)")
                SVProgressHUD.dismiss()
            }
        })
    }
    
    func postInspectSideSuction() {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        
        let return_id = UserDefaults.standard.value(forKey: "returnKeyForInspection")
        
        let inspectSideSuctionDetails:  NSMutableDictionary = [
            "return_data_id"            : return_id!,
            "mainSuctionImage"          : strMainSuctionImg,
            "mainSuctionOption"         : strSideSuctionPresentOption,
            "mainSuctionData"           : self.secSideSuction[SideSuction.suctionPresent.rawValue].formTextValue,
            "mainSkimmerImage"          : strMainSkimmerImg,
            "mainSkimmerOption"         : strSkimmerPresentOption,
            "mainSkimmerData"           : self.secSideSuction[SideSuction.skimmerPresent.rawValue].formTextValue,
            "suctionInchesImage"        : strSuctionInchesImg,
            "suctionInchesOption"       : strSuctionInchesOpt,
            "suctionInchesData"         : self.secSubSuction[SubSuction.suctionInches.rawValue].formTextValue,
            "suctionVGBComplaintImage"  : strSuctionComplaintImg,
            "suctionVGBComplaintOption" : strSuctionComplaintOpt,
            "suctionVGBComplaintData"   : self.secSubSuction[SubSuction.suctionVGBComplaint.rawValue].formTextValue,
            "suctionMountedImage"       : strSuctionMountedImg,
            "suctionMountedOption"      : strSuctionMountedOpt,
            "suctionMountedData"        : self.secSubSuction[SubSuction.suctionMounted.rawValue].formTextValue,
            "skimmerOperateImage"       : strSkimOperateImg,
            "skimmerOperateOption"      : strSkimOperateOpt,
            "skimmerOperateData"        : self.secSubSkimmer[SubSkimmer.skimmerOperating.rawValue].formTextValue,
            "skimmerRepairImage"        : strSkimRepairImg,
            "skimmerRepairOption"       : strSkimRepairOpt,
            "skimmerRepairData"         : self.secSubSkimmer[SubSkimmer.skimmerRepair.rawValue].formTextValue,
            "skimmerProperHtImage"      : strSkimProperHtImg,
            "skimmerProperHtOption"     : strSkimProperHtOpt,
            "skimmerProperHtData"       : self.secSubSkimmer[SubSkimmer.skimmerHeight.rawValue].formTextValue,
            "skimmerWeirDoorImage"      : strSkimWeirDoorImg,
            "skimmerWeirDoorOption"     : strSkimWeirDoorOpt,
            "skimmerWeirDoorData"       : self.secSubSkimmer[SubSkimmer.skimmerWeirDoor.rawValue].formTextValue,
            "skimmerDoorWorkImage"      : strSkimDoorWorkImg,
            "skimmerDoorWorkOption"     : strSkimDoorWorkOpt,
            "skimmerDoorWorkData"       : self.secSubSkimmer[SubSkimmer.skimmerDoorWorking.rawValue].formTextValue,
            "skimmerBasementImage"      : strSkimBasementImg,
            "skimmerBasementOption"     : strSkimBasementOpt,
            "skimmerBasementData"       : self.secSubSkimmer[SubSkimmer.skimmerBasement.rawValue].formTextValue,
            "skimmerConditionImage"     : strSkimConditionImg,
            "skimmerConditionOption"    : strSkimConditionOpt,
            "skimmerConditionData"      : self.secSubSkimmer[SubSkimmer.skimmerBasementCondition.rawValue].formTextValue,
            "skimmerDiverImage"         : strSkimDiverImg,
            "skimmerDiverOption"        : strSkimDiverOpt,
            "skimmerDiverData"          : self.secSubSkimmer[SubSkimmer.skimmerProperDiverter.rawValue].formTextValue,
            "skimmerSeamImage"          : strSkimSeamImg,
            "skimmerSeamOption"         : strSkimSeamOpt,
            "skimmerSeamData"           : self.secSubSkimmer[SubSkimmer.skimmerCondition.rawValue].formTextValue,
            "skimmerCrackImage"         : strSkimCrackImg,
            "skimmerCrackOption"        : strSkimCrackOpt,
            "skimmerCrackData"          : self.secSubSkimmer[SubSkimmer.skimmerCrack.rawValue].formTextValue,
            "skimmerSuctionWorkImage"   : strSkimSuctionWorkImg,
            "skimmerSuctionWorkOption"  : strSkimSuctionWorkOpt,
            "skimmerSuctionWorkData"    : self.secSubSkimmer[SubSkimmer.skimmerSuctionWorking.rawValue].formTextValue,
            "skimmerEqualizerImage"     : strSkimEqualizerImg,
            "skimmerEqualizerOption"    : strSkimEqualizerOpt,
            "skimmerEqualizerData"      : self.secSubSkimmer[SubSkimmer.skimmerEqualizer.rawValue].formTextValue,
            "skimmerEqualizerVGBImage"  : strSkimEqualVGBImg,
            "skimmerEqualizerVGBOption" : strSkimEqualVGBOpt,
            "skimmerEqualizerVGBData"   : self.secSubSkimmer[SubSkimmer.skimmerEqualizerVGB.rawValue].formTextValue,
            "skimmerMainDrainImage"     : strSkimDrainImg,
            "skimmerMainDrainOption"    : strSkimDrainOpt,
            "skimmerMainDrainData"      : self.secSubSkimmer[SubSkimmer.skimmerMainDrain.rawValue].formTextValue,
        ]

        print("inspectSideSuctionDetails :: \(inspectSideSuctionDetails)")
        //if sharedExtension.connectedToNetwork() {
        ApiManager.sharedInstanceAPI.PostInspectSideSuction(postId: 1, sideSuctionDetails: inspectSideSuctionDetails, onSuccess: { json in
            DispatchQueue.main.async {
                print("InspectionSideSuctionDetails json :: \(String(describing: json))")
                DispatchQueue.main.async(execute: {() -> Void in
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectAutofill") as! InspectAutofillVC
                        self.navigationController?.pushViewController(formVC, animated: true)
                    } else if UIDevice.current.userInterfaceIdiom == .pad {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectAutofill") as! InspectAutofillVC
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

extension InspectSideSuctionVC: OpalImagePickerControllerDelegate {
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
                                self.arrMainSuctionImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataMainSuctionImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 3 {
                                self.arrMainSkimmerImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataMainSkimmerImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            }
                            
                            if self.fetchIndexForSubSuctionUpload == 0 {
                                self.arrSuctionInchesImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSuctionInchesImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubSuctionUpload == 1 {
                                self.arrSuctionComplaintImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSuctionComplaintImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubSuctionUpload == 2 {
                                self.arrSuctionMountedImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSuctionMountedImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            }
                            
                            if self.fetchIndexForSubSkimUpload == 0 {
                                self.arrSkimOperateImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSkimOperateImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubSkimUpload == 1 {
                                self.arrSkimRepairImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSkimRepairImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubSkimUpload == 2 {
                                self.arrSkimProperHtImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSkimProperHtImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubSkimUpload == 3 {
                                self.arrSkimWeirDoorImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSkimWeirDoorImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubSkimUpload == 4 {
                                self.arrSkimDoorWorkImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSkimDoorWorkImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubSkimUpload == 5 {
                                self.arrSkimBasementImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSkimBasementImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubSkimUpload == 6 {
                                self.arrSkimConditionImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSkimConditionImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubSkimUpload == 7 {
                                self.arrSkimDiverImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSkimDiverImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubSkimUpload == 8 {
                                self.arrSkimSeamImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSkimSeamImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubSkimUpload == 9 {
                                self.arrSkimCrackImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSkimCrackImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubSkimUpload == 10 {
                                self.arrSkimSuctionWorkImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSkimSuctionWorkImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubSkimUpload == 11 {
                                self.arrSkimEqualizerImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSkimEqualizerImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubSkimUpload == 12 {
                                self.arrSkimEqualVGBImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSkimEqualVGBImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubSkimUpload == 13 {
                                self.arrSkimDrainImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSkimDrainImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
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
                self.tblSideSuction.reloadData()
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

extension InspectSideSuctionVC: UIImagePickerControllerDelegate {
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
            self.arrMainSuctionImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataMainSuctionImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 1 {
            self.arrMainSkimmerImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataMainSkimmerImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        }
        
        if fetchIndexForSubSuctionUpload == 0 {
            self.arrSuctionInchesImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSuctionInchesImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubSuctionUpload == 1 {
            self.arrSuctionComplaintImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSuctionComplaintImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubSuctionUpload == 2 {
            self.arrSuctionMountedImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSuctionMountedImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        }
        
        if fetchIndexForSubSkimUpload == 0 {
            self.arrSkimOperateImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSkimOperateImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubSkimUpload == 1 {
            self.arrSkimRepairImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSkimRepairImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubSkimUpload == 2 {
            self.arrSkimProperHtImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSkimProperHtImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubSkimUpload == 3 {
            self.arrSkimWeirDoorImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSkimWeirDoorImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubSkimUpload == 4 {
            self.arrSkimDoorWorkImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSkimDoorWorkImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubSkimUpload == 5 {
            self.arrSkimBasementImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSkimBasementImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubSkimUpload == 6 {
            self.arrSkimConditionImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSkimConditionImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubSkimUpload == 7 {
            self.arrSkimDiverImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSkimDiverImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubSkimUpload == 8 {
            self.arrSkimSeamImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSkimSeamImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubSkimUpload == 9 {
            self.arrSkimCrackImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSkimCrackImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubSkimUpload == 10 {
            self.arrSkimSuctionWorkImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSkimSuctionWorkImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubSkimUpload == 11 {
            self.arrSkimEqualizerImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSkimEqualizerImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubSkimUpload == 12 {
            self.arrSkimEqualVGBImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSkimEqualVGBImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubSkimUpload == 13 {
            self.arrSkimDrainImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSkimDrainImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        }
        
        self.tblSideSuction.reloadData()
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
}



extension InspectSideSuctionVC: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        var cell = UITableViewCell()
        cell = (textView.superview?.superview as? UITableViewCell)!
        
        if let InspectSideSuctionTableCell = cell as? InspectSideSuctionTableCell {
            if textView == InspectSideSuctionTableCell.txtSideSuction {
                self.secSideSuction[SideSuction.suctionPresent.rawValue].formTextValue = (textView.text)!
            }
        } else if let InspectSkimmerTableCell = cell as? InspectSkimmerTableCell {
            if textView == InspectSkimmerTableCell.txtSkimmer {
                self.secSideSuction[SideSuction.skimmerPresent.rawValue].formTextValue = (textView.text)!
            }
        }
        
        if let SideSuctionInchesTableCell = cell as? SideSuctionInchesTableCell {
            if textView == SideSuctionInchesTableCell.txtSuctionInches {                                   self.secSubSuction[SubSuction.suctionInches.rawValue].formTextValue = (textView.text)!
                
            }
        } else if let SideSuctionVGBComplaintTableCell = cell as? SideSuctionVGBComplaintTableCell {
            if textView == SideSuctionVGBComplaintTableCell.txtSuctionVGBComplaint {                                   self.secSubSuction[SubSuction.suctionVGBComplaint.rawValue].formTextValue = (textView.text)!
                
            }
        } else if let SideSuctionMountedProperlyTableCell = cell as? SideSuctionMountedProperlyTableCell {
            if textView == SideSuctionMountedProperlyTableCell.txtSuctionMounted {                                   self.secSubSuction[SubSuction.suctionMounted.rawValue].formTextValue = (textView.text)!
                
            }
        }
        
        if let SkimmerOperatingTableCell = cell as? SkimmerOperatingTableCell {
            if textView == SkimmerOperatingTableCell.txtSkimmerOperating {
                self.secSubSkimmer[SubSkimmer.skimmerOperating.rawValue].formTextValue = (textView.text)!
            }
        } else if let SkimmerPreviousRepairTableCell = cell as? SkimmerPreviousRepairTableCell {
            if textView == SkimmerPreviousRepairTableCell.txtSkimmerRepair {
                self.secSubSkimmer[SubSkimmer.skimmerRepair.rawValue].formTextValue = (textView.text)!
            }
        } else if let SkimmerProperHeightTableCell = cell as? SkimmerProperHeightTableCell {
            if textView == SkimmerProperHeightTableCell.txtSkimmerHeight {
                self.secSubSkimmer[SubSkimmer.skimmerHeight.rawValue].formTextValue = (textView.text)!
            }
        } else if let SkimmerWeirDoorTableCell = cell as? SkimmerWeirDoorTableCell {
            if textView == SkimmerWeirDoorTableCell.txtSkimmerWeirDoor {
                self.secSubSkimmer[SubSkimmer.skimmerWeirDoor.rawValue].formTextValue = (textView.text)!
            }
        } else if let SkimmerWeirDoorWorkingTableCell = cell as? SkimmerWeirDoorWorkingTableCell {
            if textView == SkimmerWeirDoorWorkingTableCell.txtSkimmerDoorWorking {
                self.secSubSkimmer[SubSkimmer.skimmerDoorWorking.rawValue].formTextValue = (textView.text)!
            }
        } else if let SkimmerBasementTableCell = cell as? SkimmerBasementTableCell {
            if textView == SkimmerBasementTableCell.txtSkimmerBasement {
                self.secSubSkimmer[SubSkimmer.skimmerBasement.rawValue].formTextValue = (textView.text)!
            }
        } else if let SkimmerBasementConditionTableCell = cell as? SkimmerBasementConditionTableCell {
            if textView == SkimmerBasementConditionTableCell.txtSkimmerBasementCondition {
                self.secSubSkimmer[SubSkimmer.skimmerBasementCondition.rawValue].formTextValue = (textView.text)!
            }
        } else if let SkimmerProperDiverterTableCell = cell as? SkimmerProperDiverterTableCell {
            if textView == SkimmerProperDiverterTableCell.txtSkimmerProperDiverter {
                self.secSubSkimmer[SubSkimmer.skimmerProperDiverter.rawValue].formTextValue = (textView.text)!
            }
        } else if let SkimmerSeamConditionTableCell = cell as? SkimmerSeamConditionTableCell {
            if textView == SkimmerSeamConditionTableCell.txtSkimmerCondition {
                self.secSubSkimmer[SubSkimmer.skimmerCondition.rawValue].formTextValue = (textView.text)!
            }
        } else if let SkimmerCrackTableCell = cell as? SkimmerCrackTableCell {
            if textView == SkimmerCrackTableCell.txtSkimmerCrack {
                self.secSubSkimmer[SubSkimmer.skimmerCrack.rawValue].formTextValue = (textView.text)!
            }
        } else if let SkimmerSuctionWorkingTableCell = cell as? SkimmerSuctionWorkingTableCell {
            if textView == SkimmerSuctionWorkingTableCell.txtSkimmerSuctionWorking {
                self.secSubSkimmer[SubSkimmer.skimmerSuctionWorking.rawValue].formTextValue = (textView.text)!
            }
        } else if let SkimmerEqualizerTableCell = cell as? SkimmerEqualizerTableCell {
            if textView == SkimmerEqualizerTableCell.txtSkimmerEqualizer {
                self.secSubSkimmer[SubSkimmer.skimmerEqualizer.rawValue].formTextValue = (textView.text)!
            }
        } else if let SkimmerEqualizerVGBTableCell = cell as? SkimmerEqualizerVGBTableCell {
            if textView == SkimmerEqualizerVGBTableCell.txtSkimmerEqualizerVGB {
                self.secSubSkimmer[SubSkimmer.skimmerEqualizerVGB.rawValue].formTextValue = (textView.text)!
            }
        } else if let SkimmerMainDrainTableCell = cell as? SkimmerMainDrainTableCell {
            if textView == SkimmerMainDrainTableCell.txtSkimmerMainDrain {
                self.secSubSkimmer[SubSkimmer.skimmerMainDrain.rawValue].formTextValue = (textView.text)!
            }
        }
    }
}

extension InspectSideSuctionVC: UITableViewDataSource, UITableViewDelegate {
    //MARK:- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 25 {
            return 3
        } else if tableView.tag == 35 {
            return 14
        } else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 25 {
            if indexPath.row == 0 {
                let suctionCell = tableView.dequeueReusableCell(withIdentifier: "SideSuctionInchesCell", for: indexPath) as! SideSuctionInchesTableCell
                
                suctionCell.btnUpload.addTarget(self, action: #selector(btnSuctionUpload(_:)), for: UIControl.Event.touchUpInside)
                
                
                suctionCell.collectionVw.arrItems = arrSuctionInchesImg
                suctionCell.collectionVw.delegateItemCollection = self
                suctionCell.collectionVw.reloadImageCollection()
                
                if arrSuctionInchesImg.count > 0 {
                    suctionCell.btnUpload.isHidden = true
                    suctionCell.collectionVw.isHidden = false
                } else {
                    suctionCell.btnUpload.isHidden = false
                    suctionCell.collectionVw.isHidden = true
                }
                
                suctionCell.delegateSuction0 = self
                suctionCell.txtSuctionInches.delegate = self
                
                return suctionCell
            } else if indexPath.row == 1 {
                let suctionCell = tableView.dequeueReusableCell(withIdentifier: "SideSuctionVGBComplaintCell", for: indexPath) as! SideSuctionVGBComplaintTableCell
                
                suctionCell.btnUpload.addTarget(self, action: #selector(btnSuctionUpload(_:)), for: UIControl.Event.touchUpInside)
                
                suctionCell.collectionvw.arrItems = arrSuctionComplaintImg
                suctionCell.collectionvw.delegateItemCollection = self
                suctionCell.collectionvw.reloadImageCollection()

                if arrSuctionComplaintImg.count > 0 {
                    suctionCell.btnUpload.isHidden = true
                    suctionCell.collectionvw.isHidden = false
                } else {
                    suctionCell.btnUpload.isHidden = false
                    suctionCell.collectionvw.isHidden = true
                }
                
                suctionCell.delegateSuction1 = self
                suctionCell.txtSuctionVGBComplaint.delegate = self
                
                return suctionCell
            } else {
                let suctionCell = tableView.dequeueReusableCell(withIdentifier: "SideSuctionMountedProperlyCell", for: indexPath) as! SideSuctionMountedProperlyTableCell
                
                suctionCell.btnUpload.addTarget(self, action: #selector(btnSuctionUpload(_:)), for: UIControl.Event.touchUpInside)
                
                suctionCell.collectionvw.arrItems = arrSuctionMountedImg
                suctionCell.collectionvw.delegateItemCollection = self
                suctionCell.collectionvw.reloadImageCollection()

                if arrSuctionMountedImg.count > 0 {
                    suctionCell.btnUpload.isHidden = true
                    suctionCell.collectionvw.isHidden = false
                } else {
                    suctionCell.btnUpload.isHidden = false
                    suctionCell.collectionvw.isHidden = true
                }
                
                suctionCell.delegateSuction2 = self
                suctionCell.txtSuctionMounted.delegate = self
                
                return suctionCell
            }
        } else if tableView.tag == 35 {
            if indexPath.row == 0 {
                let skimmerCell = tableView.dequeueReusableCell(withIdentifier: "SkimmerOperatingCell", for: indexPath) as! SkimmerOperatingTableCell
                     
                skimmerCell.btnUpload.addTarget(self, action: #selector(btnSkimUpload(_:)), for: UIControl.Event.touchUpInside)
                
                skimmerCell.collectionvw.arrItems = arrSkimOperateImg
                skimmerCell.collectionvw.delegateItemCollection = self
                skimmerCell.collectionvw.reloadImageCollection()
                
                if arrSkimOperateImg.count > 0 {
                    skimmerCell.btnUpload.isHidden = true
                    skimmerCell.collectionvw.isHidden = false
                } else {
                    skimmerCell.btnUpload.isHidden = false
                    skimmerCell.collectionvw.isHidden = true
                }
                
                skimmerCell.delegateSkimmerOperating = self
                skimmerCell.txtSkimmerOperating.delegate = self
                
                return skimmerCell
            } else if indexPath.row == 1 {
                let skimmerCell = tableView.dequeueReusableCell(withIdentifier: "SkimmerPreviousRepairCell", for: indexPath) as! SkimmerPreviousRepairTableCell
                
                skimmerCell.btnUpload.addTarget(self, action: #selector(btnSkimUpload(_:)), for: UIControl.Event.touchUpInside)
                
                skimmerCell.collectionvw.arrItems = arrSkimRepairImg
                skimmerCell.collectionvw.delegateItemCollection = self
                skimmerCell.collectionvw.reloadImageCollection()
                
                if arrSkimRepairImg.count > 0 {
                    skimmerCell.btnUpload.isHidden = true
                    skimmerCell.collectionvw.isHidden = false
                } else {
                    skimmerCell.btnUpload.isHidden = false
                    skimmerCell.collectionvw.isHidden = true
                }
                
                skimmerCell.delegateSkimmerRepair = self
                skimmerCell.txtSkimmerRepair.delegate = self
                
                return skimmerCell
            } else if indexPath.row == 2 {
                let skimmerCell = tableView.dequeueReusableCell(withIdentifier: "SkimmerProperHeightCell", for: indexPath) as! SkimmerProperHeightTableCell
                
                skimmerCell.btnUpload.addTarget(self, action: #selector(btnSkimUpload(_:)), for: UIControl.Event.touchUpInside)
                
                skimmerCell.collectionvw.arrItems = arrSkimProperHtImg
                skimmerCell.collectionvw.delegateItemCollection = self
                skimmerCell.collectionvw.reloadImageCollection()
                
                if arrSkimProperHtImg.count > 0 {
                    skimmerCell.btnUpload.isHidden = true
                    skimmerCell.collectionvw.isHidden = false
                } else {
                    skimmerCell.btnUpload.isHidden = false
                    skimmerCell.collectionvw.isHidden = true
                }
                
                skimmerCell.delegateSkimmerHeight = self
                skimmerCell.txtSkimmerHeight.delegate = self
                
                return skimmerCell
            } else if indexPath.row == 3 {
                let skimmerCell = tableView.dequeueReusableCell(withIdentifier: "SkimmerWeirDoorCell", for: indexPath) as! SkimmerWeirDoorTableCell
                
                skimmerCell.btnUpload.addTarget(self, action: #selector(btnSkimUpload(_:)), for: UIControl.Event.touchUpInside)
                
                skimmerCell.collectionvw.arrItems = arrSkimWeirDoorImg
                skimmerCell.collectionvw.delegateItemCollection = self
                skimmerCell.collectionvw.reloadImageCollection()
                
                if arrSkimWeirDoorImg.count > 0 {
                    skimmerCell.btnUpload.isHidden = true
                    skimmerCell.collectionvw.isHidden = false
                } else {
                    skimmerCell.btnUpload.isHidden = false
                    skimmerCell.collectionvw.isHidden = true
                }
                
                skimmerCell.delegateSkimmerDoor = self
                skimmerCell.txtSkimmerWeirDoor.delegate = self
                
                return skimmerCell
            } else if indexPath.row == 4 {
                let skimmerCell = tableView.dequeueReusableCell(withIdentifier: "SkimmerWeirDoorWorkingCell", for: indexPath) as! SkimmerWeirDoorWorkingTableCell
                
                skimmerCell.btnUpload.addTarget(self, action: #selector(btnSkimUpload(_:)), for: UIControl.Event.touchUpInside)
                
                skimmerCell.collectionvw.arrItems = arrSkimDoorWorkImg
                skimmerCell.collectionvw.delegateItemCollection = self
                skimmerCell.collectionvw.reloadImageCollection()
                
                if arrSkimDoorWorkImg.count > 0 {
                    skimmerCell.btnUpload.isHidden = true
                    skimmerCell.collectionvw.isHidden = false
                } else {
                    skimmerCell.btnUpload.isHidden = false
                    skimmerCell.collectionvw.isHidden = true
                }
                
                skimmerCell.delegateSkimmerWeir = self
                skimmerCell.txtSkimmerDoorWorking.delegate = self
                
                return skimmerCell
            } else if indexPath.row == 5 {
                let skimmerCell = tableView.dequeueReusableCell(withIdentifier: "SkimmerBasementCell", for: indexPath) as! SkimmerBasementTableCell
                
                skimmerCell.btnUpload.addTarget(self, action: #selector(btnSkimUpload(_:)), for: UIControl.Event.touchUpInside)
                
                skimmerCell.collectionvw.arrItems = arrSkimBasementImg
                skimmerCell.collectionvw.delegateItemCollection = self
                skimmerCell.collectionvw.reloadImageCollection()
                
                if arrSkimBasementImg.count > 0 {
                    skimmerCell.btnUpload.isHidden = true
                    skimmerCell.collectionvw.isHidden = false
                } else {
                    skimmerCell.btnUpload.isHidden = false
                    skimmerCell.collectionvw.isHidden = true
                }
                
                skimmerCell.delegateSkimmerBase = self
                skimmerCell.txtSkimmerBasement.delegate = self
                
                return skimmerCell
            } else if indexPath.row == 6 {
                let skimmerCell = tableView.dequeueReusableCell(withIdentifier: "SkimmerBasementConditionCell", for: indexPath) as! SkimmerBasementConditionTableCell
                
                skimmerCell.btnUpload.addTarget(self, action: #selector(btnSkimUpload(_:)), for: UIControl.Event.touchUpInside)
                
                skimmerCell.collectionvw.arrItems = arrSkimConditionImg
                skimmerCell.collectionvw.delegateItemCollection = self
                skimmerCell.collectionvw.reloadImageCollection()
                
                if arrSkimConditionImg.count > 0 {
                    skimmerCell.btnUpload.isHidden = true
                    skimmerCell.collectionvw.isHidden = false
                } else {
                    skimmerCell.btnUpload.isHidden = false
                    skimmerCell.collectionvw.isHidden = true
                }
                
                skimmerCell.delegateSkimmerCondi = self
                skimmerCell.txtSkimmerBasementCondition.delegate =  self
                
                return skimmerCell
            } else if indexPath.row == 7 {
                let skimmerCell = tableView.dequeueReusableCell(withIdentifier: "SkimmerProperDiverterCell", for: indexPath) as! SkimmerProperDiverterTableCell
                
                skimmerCell.btnUpload.addTarget(self, action: #selector(btnSkimUpload(_:)), for: UIControl.Event.touchUpInside)
                
                skimmerCell.collectionvw.arrItems = arrSkimDiverImg
                skimmerCell.collectionvw.delegateItemCollection = self
                skimmerCell.collectionvw.reloadImageCollection()
                
                if arrSkimDiverImg.count > 0 {
                    skimmerCell.btnUpload.isHidden = true
                    skimmerCell.collectionvw.isHidden = false
                } else {
                    skimmerCell.btnUpload.isHidden = false
                    skimmerCell.collectionvw.isHidden = true
                }
                
                skimmerCell.delegateSkimmerDiver = self
                skimmerCell.txtSkimmerProperDiverter.delegate = self
                
                return skimmerCell
            } else if indexPath.row == 8 {
                let skimmerCell = tableView.dequeueReusableCell(withIdentifier: "SkimmerSeamConditionCell", for: indexPath) as! SkimmerSeamConditionTableCell
                
                skimmerCell.btnUpload.addTarget(self, action: #selector(btnSkimUpload(_:)), for: UIControl.Event.touchUpInside)
                
                skimmerCell.collectionvw.arrItems = arrSkimSeamImg
                skimmerCell.collectionvw.delegateItemCollection = self
                skimmerCell.collectionvw.reloadImageCollection()
                
                if arrSkimSeamImg.count > 0 {
                    skimmerCell.btnUpload.isHidden = true
                    skimmerCell.collectionvw.isHidden = false
                } else {
                    skimmerCell.btnUpload.isHidden = false
                    skimmerCell.collectionvw.isHidden = true
                }
                
                skimmerCell.delegateSkimmerSeam = self
                skimmerCell.txtSkimmerCondition.delegate = self
                
                return skimmerCell
            } else if indexPath.row == 9 {
                let skimmerCell = tableView.dequeueReusableCell(withIdentifier: "SkimmerCrackCell", for: indexPath) as! SkimmerCrackTableCell
                
                skimmerCell.btnUpload.addTarget(self, action: #selector(btnSkimUpload(_:)), for: UIControl.Event.touchUpInside)
                
                skimmerCell.collectionvw.arrItems = arrSkimCrackImg
                skimmerCell.collectionvw.delegateItemCollection = self
                skimmerCell.collectionvw.reloadImageCollection()
                
                if arrSkimCrackImg.count > 0 {
                    skimmerCell.btnUpload.isHidden = true
                    skimmerCell.collectionvw.isHidden = false
                } else {
                    skimmerCell.btnUpload.isHidden = false
                    skimmerCell.collectionvw.isHidden = true
                }
                
                skimmerCell.delegateSkimmerCreak = self
                skimmerCell.txtSkimmerCrack.delegate = self
                
                return skimmerCell
            } else if indexPath.row == 10 {
                let skimmerCell = tableView.dequeueReusableCell(withIdentifier: "SkimmerSuctionWorkingCell", for: indexPath) as! SkimmerSuctionWorkingTableCell
                
                skimmerCell.btnUpload.addTarget(self, action: #selector(btnSkimUpload(_:)), for: UIControl.Event.touchUpInside)
                
                skimmerCell.collectionvw.arrItems = arrSkimSuctionWorkImg
                skimmerCell.collectionvw.delegateItemCollection = self
                skimmerCell.collectionvw.reloadImageCollection()
                
                if arrSkimSuctionWorkImg.count > 0 {
                    skimmerCell.btnUpload.isHidden = true
                    skimmerCell.collectionvw.isHidden = false
                } else {
                    skimmerCell.btnUpload.isHidden = false
                    skimmerCell.collectionvw.isHidden = true
                }
                
                skimmerCell.delegateSkimmerCreak = self
                skimmerCell.txtSkimmerSuctionWorking.delegate = self
                
                return skimmerCell
            } else if indexPath.row == 11 {
                let skimmerCell = tableView.dequeueReusableCell(withIdentifier: "SkimmerEqualizerCell", for: indexPath) as! SkimmerEqualizerTableCell
                
                skimmerCell.btnUpload.addTarget(self, action: #selector(btnSkimUpload(_:)), for: UIControl.Event.touchUpInside)
                
                skimmerCell.collectionvw.arrItems = arrSkimEqualizerImg
                skimmerCell.collectionvw.delegateItemCollection = self
                skimmerCell.collectionvw.reloadImageCollection()
                
                if arrSkimEqualizerImg.count > 0 {
                    skimmerCell.btnUpload.isHidden = true
                    skimmerCell.collectionvw.isHidden = false
                } else {
                    skimmerCell.btnUpload.isHidden = false
                    skimmerCell.collectionvw.isHidden = true
                }
                
                skimmerCell.delegateSkimmerEqui = self
                skimmerCell.txtSkimmerEqualizer.delegate = self
                
                return skimmerCell
            } else if indexPath.row == 12 {
                let skimmerCell = tableView.dequeueReusableCell(withIdentifier: "SkimmerEqualizerVGBCell", for: indexPath) as! SkimmerEqualizerVGBTableCell
                
                skimmerCell.btnUpload.addTarget(self, action: #selector(btnSkimUpload(_:)), for: UIControl.Event.touchUpInside)
                
                skimmerCell.collectionvw.arrItems = arrSkimEqualVGBImg
                skimmerCell.collectionvw.delegateItemCollection = self
                skimmerCell.collectionvw.reloadImageCollection()
                
                if arrSkimEqualVGBImg.count > 0 {
                    skimmerCell.btnUpload.isHidden = true
                    skimmerCell.collectionvw.isHidden = false
                } else {
                    skimmerCell.btnUpload.isHidden = false
                    skimmerCell.collectionvw.isHidden = true
                }
                
                skimmerCell.delegateSkimmerVGB = self
                skimmerCell.txtSkimmerEqualizerVGB.delegate = self
                
                return skimmerCell
            } else {//if indexPath.row == 13 {
                let skimmerCell = tableView.dequeueReusableCell(withIdentifier: "SkimmerMainDrainCell", for: indexPath) as! SkimmerMainDrainTableCell
                
                skimmerCell.btnUpload.addTarget(self, action: #selector(btnSkimUpload(_:)), for: UIControl.Event.touchUpInside)
                
                skimmerCell.collectionvw.arrItems = arrSkimDrainImg
                skimmerCell.collectionvw.delegateItemCollection = self
                skimmerCell.collectionvw.reloadImageCollection()
                
                if arrSkimDrainImg.count > 0 {
                    skimmerCell.btnUpload.isHidden = true
                    skimmerCell.collectionvw.isHidden = false
                } else {
                    skimmerCell.btnUpload.isHidden = false
                    skimmerCell.collectionvw.isHidden = true
                }
                
                skimmerCell.delegateSkimmerDrain = self
                skimmerCell.txtSkimmerMainDrain.delegate = self
                
                return skimmerCell
            }
        } else {
            if indexPath.row == 0 {
                let HeaderCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as! HeaderTableCell
                
                HeaderCell.lblHeaderText.text = "SIDE SUCTION"
                return HeaderCell
            } else if indexPath.row == 1 {
                let InspectSideSuctionCell = tableView.dequeueReusableCell(withIdentifier: "InspectSideSuctionCell", for: indexPath) as! InspectSideSuctionTableCell
                
                InspectSideSuctionCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                InspectSideSuctionCell.collectionvw.arrItems = arrMainSuctionImg
                InspectSideSuctionCell.collectionvw.delegateItemCollection = self
                InspectSideSuctionCell.collectionvw.reloadImageCollection()
                
                if arrMainSuctionImg.count > 0 {
                    InspectSideSuctionCell.btnUpload.isHidden = true
                    InspectSideSuctionCell.collectionvw.isHidden = false
                } else {
                    InspectSideSuctionCell.btnUpload.isHidden = false
                    InspectSideSuctionCell.collectionvw.isHidden = true
                }
                
                if strSideSuctionPresentOption == "Yes" {
                    //Declare the outlet in our custom class
                    let tblSuction = InspectSideSuctionCell.viewWithTag(25) as! UITableView
                    
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        InspectSideSuctionCell.tblHeightConstraint.constant = (340*3)
                    } else {
                        InspectSideSuctionCell.tblHeightConstraint.constant = (600*3)
                    }
                    tblSuction.delegate = self
                    tblSuction.dataSource = self
                    tblSuction.reloadData()
                } else if strSideSuctionPresentOption == "No" {
                    InspectSideSuctionCell.tblHeightConstraint.constant = 0
                }
                
                InspectSideSuctionCell.delegateSideSuctionPresent = self
                InspectSideSuctionCell.txtSideSuction.delegate = self
                
                return InspectSideSuctionCell
            } else if indexPath.row == 2 {
                let HeaderCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as! HeaderTableCell
                
                HeaderCell.lblHeaderText.text = "SKIMMERS"
                return HeaderCell
            } else if indexPath.row == 3 {
                let InspectSkimmerCell = tableView.dequeueReusableCell(withIdentifier: "InspectSkimmerCell", for: indexPath) as! InspectSkimmerTableCell
                
                InspectSkimmerCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                InspectSkimmerCell.collectionvw.arrItems = arrMainSkimmerImg
                InspectSkimmerCell.collectionvw.delegateItemCollection = self
                InspectSkimmerCell.collectionvw.reloadImageCollection()
                
                if arrMainSkimmerImg.count > 0 {
                    InspectSkimmerCell.btnUpload.isHidden = true
                    InspectSkimmerCell.collectionvw.isHidden = false
                } else {
                    InspectSkimmerCell.btnUpload.isHidden = false
                    InspectSkimmerCell.collectionvw.isHidden = true
                }
                
                if strSkimmerPresentOption == "Yes" {
                    //Declare the outlet in our custom class
                    let tblSkimmer = InspectSkimmerCell.viewWithTag(35) as! UITableView
                    
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        InspectSkimmerCell.tblSkimmerHeightConstant.constant = 340*14
                    } else {
                        InspectSkimmerCell.tblSkimmerHeightConstant.constant = 600*14
                    }
                    tblSkimmer.delegate = self
                    tblSkimmer.dataSource = self
                    tblSkimmer.reloadData()
                } else if strSkimmerPresentOption == "No" {
                    InspectSkimmerCell.tblSkimmerHeightConstant.constant = 0
                }
                
                InspectSkimmerCell.delegateSkimmerPresent = self
                InspectSkimmerCell.txtSkimmer.delegate = self
                
                return InspectSkimmerCell
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
                return 340
            } else {
                if indexPath.row == 0 {
                    return 65
                } else if indexPath.row == 1 {
                    if strSideSuctionPresentOption == "Yes" {
                        return (340*3)+345//UITableView.automaticDimension//
                    } else {
                        return 345
                    }
                }  else if indexPath.row == 2 {
                    return 65
                } else if indexPath.row == 3 {
                     if strSkimmerPresentOption == "Yes" {
                        return (340*14)+345//UITableView.automaticDimension//
                     } else {
                        return 345
                    }
                } else {
                    return 105
               }
            }
        } else {        //.pad
            if tableView.tag == 25 {
                return 600
            } else if tableView.tag == 35 {
                return 600
            } else {
                if indexPath.row == 0 {
                    return 65
                } else if indexPath.row == 1 {
                    if strSideSuctionPresentOption == "Yes" {
                        return (600*3)+615//UITableView.automaticDimension//
                    } else {
                        return 615
                    }
                }  else if indexPath.row == 2 {
                    return 65
                } else if indexPath.row == 3 {
                     if strSkimmerPresentOption == "Yes" {
                        return (600*14)+615//UITableView.automaticDimension//
                     } else {
                        return 615
                    }
                } else {
                    return 175
               }
            }
        }
    }
}

extension InspectSideSuctionVC: SideSuctionPresentCellProtocol, Suction0Protocol, Suction1Protocol, Suction2Protocol, SkimmerPresentCellProtocol, SkimmerOperatingCellProtocol, SkimmerRepairCellProtocol, SkimmerHeightCellProtocol, SkimmerDoorCellProtocol, SkimmerWeirCellProtocol, SkimmerBaseCellProtocol, SkimmerCondiCellProtocol, SkimmerDiverCellProtocol, SkimmerSeamCellProtocol, SkimmerCreakCellProtocol, SkimmerSuctCellProtocol, SkimmerEquiCellProtocol, SkimmerVGBCellProtocol, SkimmerDrainCellProtocol {
    
    func didTapOnCellSideSuctionPresent(_btnSideSuctionPresentTag: Int){
        if _btnSideSuctionPresentTag == 0 {
           strSideSuctionPresentOption = "Yes"
        } else if _btnSideSuctionPresentTag == 1 {
           strSideSuctionPresentOption = "No"
        }
        self.tblSideSuction.reloadData()
    }
    
    func didTapOnCellSkimmerPresent(_btnSkimmerPresentTag: Int){
        if _btnSkimmerPresentTag == 0 {
            strSkimmerPresentOption = "Yes"
        } else if _btnSkimmerPresentTag == 1 {
            strSkimmerPresentOption = "No"
        }
        self.tblSideSuction.reloadData()
    }
    
    //MARK:- Sub Suction
    func didTapOnCellSuction0(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strSuctionInchesImg = "Yes"
        } else if _btnDescribeTag == 1 {
            strSuctionInchesImg = "No"
        }
        self.tblSideSuction.reloadData()
    }
    
    func didTapOnCellSuction1(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strSuctionComplaintOpt = "Yes"
        } else if _btnDescribeTag == 1 {
            strSuctionComplaintOpt = "No"
        }
        self.tblSideSuction.reloadData()
    }
    
    func didTapOnCellSuction2(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strSuctionMountedOpt = "Yes"
        } else if _btnDescribeTag == 1 {
            strSuctionMountedOpt = "No"
        }
        self.tblSideSuction.reloadData()
    }
    
    //MARK:- Sub Skimmers
    func didTapOnCellSkimmerOperating(_btnSkimmerOperatingTag: Int) {
        if _btnSkimmerOperatingTag == 0 {
            strSkimOperateImg = "Yes"
        } else if _btnSkimmerOperatingTag == 1 {
            strSkimOperateImg = "No"
        }
        self.tblSideSuction.reloadData()
    }
    
    func didTapOnCellSkimmerRepair(_btnSkimmerOperatingTag: Int) {
        if _btnSkimmerOperatingTag == 0 {
            strSkimRepairOpt = "Yes"
        } else if _btnSkimmerOperatingTag == 1 {
            strSkimRepairOpt = "No"
        }
        self.tblSideSuction.reloadData()
    }
    
    func didTapOnCellSkimmerHeight(_btnSkimmerOperatingTag: Int) {
        if _btnSkimmerOperatingTag == 0 {
            strSkimProperHtOpt = "Yes"
        } else if _btnSkimmerOperatingTag == 1 {
            strSkimProperHtOpt = "No"
        }
        self.tblSideSuction.reloadData()
    }
    
    func didTapOnCellSkimmerDoor(_btnSkimmerOperatingTag: Int) {
        if _btnSkimmerOperatingTag == 0 {
            strSkimWeirDoorOpt = "Yes"
        } else if _btnSkimmerOperatingTag == 1 {
            strSkimWeirDoorOpt = "No"
        }
        self.tblSideSuction.reloadData()
    }
    
    func didTapOnCellSkimmerWeir(_btnSkimmerOperatingTag: Int) {
        if _btnSkimmerOperatingTag == 0 {
            strSkimDoorWorkOpt = "Yes"
        } else if _btnSkimmerOperatingTag == 1 {
            strSkimDoorWorkOpt = "No"
        }
        self.tblSideSuction.reloadData()
    }
    
    func didTapOnCellSkimmerBase(_btnSkimmerOperatingTag: Int) {
        if _btnSkimmerOperatingTag == 0 {
            strSkimBasementOpt = "Yes"
        } else if _btnSkimmerOperatingTag == 1 {
            strSkimBasementOpt = "No"
        }
        self.tblSideSuction.reloadData()
    }
    
    func didTapOnCellSkimmerCondi(_btnSkimmerOperatingTag: Int) {
        if _btnSkimmerOperatingTag == 0 {
            strSkimConditionOpt = "Yes"
        } else if _btnSkimmerOperatingTag == 1 {
            strSkimConditionOpt = "No"
        }
        self.tblSideSuction.reloadData()
    }
    
    func didTapOnCellSkimmerDiver(_btnSkimmerOperatingTag: Int) {
        if _btnSkimmerOperatingTag == 0 {
            strSkimDiverOpt = "Yes"
        } else if _btnSkimmerOperatingTag == 1 {
            strSkimDiverOpt = "No"
        }
        self.tblSideSuction.reloadData()
    }
    
    func didTapOnCellSkimmerSeam(_btnSkimmerOperatingTag: Int) {
        if _btnSkimmerOperatingTag == 0 {
            strSkimSeamOpt = "Yes"
        } else if _btnSkimmerOperatingTag == 1 {
            strSkimSeamOpt = "No"
        }
        self.tblSideSuction.reloadData()
    }
    
    func didTapOnCellSkimmerCreak(_btnSkimmerOperatingTag: Int) {
        if _btnSkimmerOperatingTag == 0 {
            strSkimCrackOpt = "Yes"
        } else if _btnSkimmerOperatingTag == 1 {
            strSkimCrackOpt = "No"
        }
        self.tblSideSuction.reloadData()
    }
    
    func didTapOnCellSkimmerSuct(_btnSkimmerOperatingTag: Int) {
        if _btnSkimmerOperatingTag == 0 {
            strSkimSuctionWorkOpt = "Yes"
        } else if _btnSkimmerOperatingTag == 1 {
            strSkimSuctionWorkOpt = "No"
        }
        self.tblSideSuction.reloadData()
    }
    
    func didTapOnCellSkimmerEqui(_btnSkimmerOperatingTag: Int) {
        if _btnSkimmerOperatingTag == 0 {
            strSkimEqualizerOpt = "Yes"
        } else if _btnSkimmerOperatingTag == 1 {
            strSkimEqualizerOpt = "No"
        }
        self.tblSideSuction.reloadData()
    }
    
    func didTapOnCellSkimmerVGB(_btnSkimmerOperatingTag: Int) {
        if _btnSkimmerOperatingTag == 0 {
            strSkimEqualVGBOpt = "Yes"
        } else if _btnSkimmerOperatingTag == 1 {
            strSkimEqualVGBOpt = "No"
        }
        self.tblSideSuction.reloadData()
    }
    
    func didTapOnCellSkimmerDrain(_btnSkimmerOperatingTag: Int) {
        if _btnSkimmerOperatingTag == 0 {
            strSkimDrainOpt = "Yes"
        } else if _btnSkimmerOperatingTag == 1 {
            strSkimDrainOpt = "No"
        }
        self.tblSideSuction.reloadData()
    }
}
