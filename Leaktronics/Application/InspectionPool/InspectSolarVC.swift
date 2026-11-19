//
//  InspectSolarVC.swift
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


class InspectSolarVC: UIViewController, UINavigationControllerDelegate, UploadCollectionProtocol {
    
    @IBOutlet weak var tblSolar: UITableView!
     
    var secInspectSolar = [formInspectionPoolData]()
    var secSolar = [formInspectionPoolData]()
    
    enum InspectSolar: Int {
        case solar = 1
        case filt = 3
        case filt1 = 4
        case filt2 = 5
        case filt3 = 6
        case filt4 = 7
        case filt5 = 8
        case filt6 = 9
        case filt7 = 10
        case filt8 = 11
        case filt9 = 12
        case filt10 = 13
        case filt11 = 14
        case filt12 = 15
    }
    
    enum Solar: Int {
        case solar0 = 0
        case solar1 = 1
        case solar2 = 2
        case solar3 = 3
        case solar4 = 4
    }
    
    var imagePicker = UIImagePickerController()
    var picker:UIImagePickerController? = UIImagePickerController()


    //For Images
    var arrSolarMainImg: [CollectionImageObject] = []
    var arrSolarImg: [CollectionImageObject] = []
    var arrFiltMainImg: [CollectionImageObject] = []
    var arrFiltImg: [CollectionImageObject] = []
    var arrFilt1Img: [CollectionImageObject] = []
    var arrFilt2Img: [CollectionImageObject] = []
    var arrFilt3Img: [CollectionImageObject] = []
    var arrFilt4Img: [CollectionImageObject] = []
    var arrFilt5Img: [CollectionImageObject] = []
    var arrFilt6Img: [CollectionImageObject] = []
    var arrFilt7Img: [CollectionImageObject] = []
    var arrFilt8Img: [CollectionImageObject] = []
    var arrFilt9Img: [CollectionImageObject] = []
    var arrFilt10Img: [CollectionImageObject] = []
    var arrFilt11Img: [CollectionImageObject] = []
    var arrFilt12Img: [CollectionImageObject] = []

    var arrSolar0Img: [CollectionImageObject] = []
    var arrSolar1Img: [CollectionImageObject] = []
    var arrSolar2Img: [CollectionImageObject] = []
    var arrSolar3Img: [CollectionImageObject] = []
    var arrSolar4Img: [CollectionImageObject] = []

    var fetchIndexForUpload: Int = -1
    var fetchIndexForSubSolarUpload: Int = -1


    //For Image Server path
    var strSolarMainImg = String()
    var strSolarImg = String()
    var strFiltMainImg = String()
    var strFiltImg = String()
    var strFilt1Img = String()
    var strFilt2Img = String()
    var strFilt3Img = String()
    var strFilt4Img = String()
    var strFilt5Img = String()
    var strFilt6Img = String()
    var strFilt7Img = String()
    var strFilt8Img = String()
    var strFilt9Img = String()
    var strFilt10Img = String()
    var strFilt11Img = String()
    var strFilt12Img = String()
    
    var strSolar0Img = String()
    var strSolar1Img = String()
    var strSolar2Img = String()
    var strSolar3Img = String()
    var strSolar4Img = String()
    
    
    //For Image CoreData
    var dataSolarMainImg = NSData()
    var dataSolarImg = NSData()
    var dataFiltMainImg = NSData()
    var dataFiltImg = NSData()
    var dataFilt1Img = NSData()
    var dataFilt2Img = NSData()
    var dataFilt3Img = NSData()
    var dataFilt4Img = NSData()
    var dataFilt5Img = NSData()
    var dataFilt6Img = NSData()
    var dataFilt7Img = NSData()
    var dataFilt8Img = NSData()
    var dataFilt9Img = NSData()
    var dataFilt10Img = NSData()
    var dataFilt11Img = NSData()
    var dataFilt12Img = NSData()
    
    var dataSolar0Img = NSData()
    var dataSolar1Img = NSData()
    var dataSolar2Img = NSData()
    var dataSolar3Img = NSData()
    var dataSolar4Img = NSData()
    
    
    var strSolarMainOpt = String()
    var strFiltMainOpt = String()
    var strFiltOpt = String()
    var strFilt1Opt = String()
    var strFilt2Opt = String()
    var strFilt3Opt = String()
    var strFilt4Opt = String()
    var strFilt5Opt = String()
    var strFilt6Opt = String()
    var strFilt7Opt = String()
    var strFilt8Opt = String()
    var strFilt9Opt = String()
    var strFilt10Opt = String()
    var strFilt11Opt = String()
    var strFilt12Opt = String()
    
    var strSolar0Opt = String()
    var strSolar1Opt = String()
    var strSolar2Opt = String()
    var strSolar3Opt = String()
    var strSolar4Opt = String()
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.prepareFormSolarData()
    }
    
    func prepareFormSolarData() {
        for _ in 0..<17 {
            let obj = formInspectionPoolData()
            self.secInspectSolar.append(obj)
        }
        for _ in 0..<5 {
            let obj = formInspectionPoolData()
            self.secSolar.append(obj)
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
        let indexOfCell = self.tblSolar.indexPath(for: cell)
        print("Clicked Index : \(String(describing: indexOfCell?.row))")
        
        fetchIndexForSubSolarUpload = -1
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
    
    @objc func btnSolarImgUpload(_ sender: Any) {
        print("Button pressed 👍 ")
        let btn = sender as! UIButton
        let cell = btn.superview?.superview?.superview as! UITableViewCell
        let tblWall = self.view.viewWithTag(25) as! UITableView
        let indexOfCell = tblWall.indexPath(for: cell)
        print("Clicked Index : \(String(describing: indexOfCell?.row))")
        fetchIndexForUpload = -1
        fetchIndexForSubSolarUpload = (indexOfCell?.row)!
        
        print("Upload Index : \(String(describing: fetchIndexForSubSolarUpload))")
        
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
        //self.postInspectSolar()
        if UIDevice.current.userInterfaceIdiom == .phone {
            let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
            let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectPoolPump") as! InspectPoolPumpVC
            self.navigationController?.pushViewController(formVC, animated: true)
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
            let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectPoolPump") as! InspectPoolPumpVC
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
                    
                    managedObject.setValue(dataSolarImg, forKey: "solarImg")
                    managedObject.setValue(strSolarMainOpt, forKey: "solarMainOption")
                    managedObject.setValue(dataSolarMainImg, forKey: "solarMainImage")
                    managedObject.setValue(self.secInspectSolar[InspectSolar.solar.rawValue].formTextValue, forKey: "solarMainData")
                    managedObject.setValue(strSolar0Opt, forKey: "solar0Option")
                    managedObject.setValue(dataSolar0Img, forKey: "solar0Image")
                    managedObject.setValue(self.secSolar[Solar.solar0.rawValue].formTextValue, forKey: "solar0Data")
                    managedObject.setValue(strSolar1Opt, forKey: "solar1Option")
                    managedObject.setValue(dataSolar1Img, forKey: "solar1Image")
                    managedObject.setValue(self.secSolar[Solar.solar1.rawValue].formTextValue, forKey: "solar1Data")
                    managedObject.setValue(strSolar2Opt, forKey: "solar2Option")
                    managedObject.setValue(dataSolar2Img, forKey: "solar2Image")
                    managedObject.setValue(self.secSolar[Solar.solar2.rawValue].formTextValue, forKey: "solar2Data")
                    managedObject.setValue(strSolar3Opt, forKey: "solar3Option")
                    managedObject.setValue(dataSolar3Img, forKey: "solar3Image")
                    managedObject.setValue(self.secSolar[Solar.solar3.rawValue].formTextValue, forKey: "solar3Data")
                    managedObject.setValue(strSolar4Opt, forKey: "solar4Option")
                    managedObject.setValue(dataSolar4Img, forKey: "solar4Image")
                    managedObject.setValue(self.secSolar[Solar.solar4.rawValue].formTextValue, forKey: "solar4Data")
                    managedObject.setValue(dataFiltMainImg, forKey: "filtMainImage")
                    managedObject.setValue(strFiltOpt, forKey: "flitOption")
                    managedObject.setValue(dataFiltImg, forKey: "filtImage")
                    managedObject.setValue(self.secInspectSolar[InspectSolar.filt.rawValue].formTextValue, forKey: "flitData")
                    managedObject.setValue(strFilt1Opt, forKey: "flit1Option")
                    managedObject.setValue(dataFilt1Img, forKey: "filt1Image")
                    managedObject.setValue(self.secInspectSolar[InspectSolar.filt1.rawValue].formTextValue, forKey: "flit1Data")
                    managedObject.setValue(strFilt2Opt, forKey: "flit2Option")
                    managedObject.setValue(dataFilt2Img, forKey: "filt2Image")
                    managedObject.setValue(self.secInspectSolar[InspectSolar.filt2.rawValue].formTextValue, forKey: "flit2Data")
                    managedObject.setValue(strFilt3Opt, forKey: "flit3Option")
                    managedObject.setValue(dataFilt3Img, forKey: "filt3Image")
                    managedObject.setValue(self.secInspectSolar[InspectSolar.filt3.rawValue].formTextValue, forKey: "flit3Data")
                    managedObject.setValue(strFilt4Opt, forKey: "flit4Option")
                    managedObject.setValue(dataFilt4Img, forKey: "filt4Image")
                    managedObject.setValue(self.secInspectSolar[InspectSolar.filt4.rawValue].formTextValue, forKey: "flit4Data")
                    managedObject.setValue(strFilt5Opt, forKey: "flit5Option")
                    managedObject.setValue(dataFilt5Img, forKey: "filt5Image")
                    managedObject.setValue(self.secInspectSolar[InspectSolar.filt5.rawValue].formTextValue, forKey: "flit5Data")
                    managedObject.setValue(strFilt6Opt, forKey: "flit6Option")
                    managedObject.setValue(dataFilt6Img, forKey: "filt6Image")
                    managedObject.setValue(self.secInspectSolar[InspectSolar.filt6.rawValue].formTextValue, forKey: "flit6Data")
                    managedObject.setValue(strFilt7Opt, forKey: "flit7Option")
                    managedObject.setValue(dataFilt7Img, forKey: "filt7Image")
                    managedObject.setValue(self.secInspectSolar[InspectSolar.filt7.rawValue].formTextValue, forKey: "flit7Data")
                    managedObject.setValue(strFilt8Opt, forKey: "flit8Option")
                    managedObject.setValue(dataFilt8Img, forKey: "filt8Image")
                    managedObject.setValue(self.secInspectSolar[InspectSolar.filt8.rawValue].formTextValue, forKey: "flit8Data")
                    managedObject.setValue(strFilt9Opt, forKey: "flit9Option")
                    managedObject.setValue(dataFilt9Img, forKey: "filt9Image")
                    managedObject.setValue(self.secInspectSolar[InspectSolar.filt9.rawValue].formTextValue, forKey: "flit9Data")
                    managedObject.setValue(strFilt10Opt, forKey: "flit10Option")
                    managedObject.setValue(dataFilt10Img, forKey: "filt10Image")
                    managedObject.setValue(self.secInspectSolar[InspectSolar.filt10.rawValue].formTextValue, forKey: "flit10Data")
                    managedObject.setValue(strFilt11Opt, forKey: "flit11Option")
                    managedObject.setValue(dataFilt11Img, forKey: "filt11Image")
                    managedObject.setValue(self.secInspectSolar[InspectSolar.filt11.rawValue].formTextValue, forKey: "flit11Data")
                    managedObject.setValue(strFilt12Opt, forKey: "flit12Option")
                    managedObject.setValue(dataFilt12Img, forKey: "filt12Image")
                    managedObject.setValue(self.secInspectSolar[InspectSolar.filt12.rawValue].formTextValue, forKey: "flit12Data")
                    
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
                        self.strSolarImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 1 {
                        self.strSolarMainImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 2 {
                        self.strFiltMainImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 3 {
                        self.strFiltImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 4 {
                        self.strFilt1Img = String(describing: data!)
                    } else if self.fetchIndexForUpload == 5 {
                        self.strFilt2Img = String(describing: data!)
                    } else if self.fetchIndexForUpload == 6 {
                        self.strFilt3Img = String(describing: data!)
                    } else if self.fetchIndexForUpload == 7 {
                        self.strFilt4Img = String(describing: data!)
                    } else if self.fetchIndexForUpload == 8 {
                        self.strFilt5Img = String(describing: data!)
                    } else if self.fetchIndexForUpload == 9 {
                        self.strFilt6Img = String(describing: data!)
                    } else if self.fetchIndexForUpload == 10 {
                        self.strFilt7Img = String(describing: data!)
                    } else if self.fetchIndexForUpload == 11 {
                        self.strFilt8Img = String(describing: data!)
                    } else if self.fetchIndexForUpload == 12 {
                        self.strFilt9Img = String(describing: data!)
                    } else if self.fetchIndexForUpload == 13 {
                        self.strFilt10Img = String(describing: data!)
                    } else if self.fetchIndexForUpload == 14 {
                        self.strFilt11Img = String(describing: data!)
                    } else if self.fetchIndexForUpload == 15 {
                        self.strFilt12Img = String(describing: data!)
                    }
                    
                    if self.fetchIndexForSubSolarUpload == 0 {
                        self.strSolar0Img = String(describing: data!)
                    } else if self.fetchIndexForSubSolarUpload == 1 {
                        self.strSolar1Img = String(describing: data!)
                    } else if self.fetchIndexForSubSolarUpload == 2 {
                        self.strSolar2Img = String(describing: data!)
                    } else if self.fetchIndexForSubSolarUpload == 3 {
                        self.strSolar3Img = String(describing: data!)
                    } else if self.fetchIndexForSubSolarUpload == 4 {
                        self.strSolar4Img = String(describing: data!)
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
    
    func postInspectSolar() {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        
        let return_id = UserDefaults.standard.value(forKey: "returnKeyForInspection")
        
        let inspectSolarDetails:  NSMutableDictionary = [
            "return_data_id"    : return_id!,
            "solarImg"          : strSolarImg,
            "solarMainImage"    : strSolarMainImg,
            "solarMainOption"   : strSolarMainOpt,
            "solarMainData"     : self.secInspectSolar[InspectSolar.solar.rawValue].formTextValue,
            "solar0Option"      : strSolar0Opt,
            "solar0Image"       : strSolar0Img,
            "solar0Data"        : self.secSolar[Solar.solar0.rawValue].formTextValue,
            "solar1Option"      : strSolar1Opt,
            "solar1Image"       : strSolar1Img,
            "solar1Data"        : self.secSolar[Solar.solar1.rawValue].formTextValue,
            "solar2Option"      : strSolar2Opt,
            "solar2Image"       : strSolar2Img,
            "solar2Data"        : self.secSolar[Solar.solar2.rawValue].formTextValue,
            "solar3Option"      : strSolar3Opt,
            "solar3Image"       : strSolar3Img,
            "solar3Data"        : self.secSolar[Solar.solar3.rawValue].formTextValue,
            "solar4Option"      : strSolar4Opt,
            "solar4Image"       : strSolar4Img,
            "solar4Data"        : self.secSolar[Solar.solar4.rawValue].formTextValue,
            "filtMainImage"     : strFiltMainImg,
            "flitOption"        : strFiltOpt,
            "filtImage"         : strFiltImg,
            "flitData"          : self.secInspectSolar[InspectSolar.filt.rawValue].formTextValue,
            "flit1Option"       : strFilt1Opt,
            "filt1Image"        : strFilt1Img,
            "flit1Data"         : self.secInspectSolar[InspectSolar.filt1.rawValue].formTextValue,
            "flit2Option"       : strFilt2Opt,
            "filt2Image"        : strFilt2Img,
            "flit2Data"         : self.secInspectSolar[InspectSolar.filt2.rawValue].formTextValue,
            "flit3Option"       : strFilt3Opt,
            "filt3Image"        : strFilt3Img,
            "flit3Data"         : self.secInspectSolar[InspectSolar.filt3.rawValue].formTextValue,
            "flit4Option"       : strFilt4Opt,
            "filt4Image"        : strFilt4Img,
            "flit4Data"         : self.secInspectSolar[InspectSolar.filt4.rawValue].formTextValue,
            "flit5Option"       : strFilt5Opt,
            "filt5Image"        : strFilt5Img,
            "flit5Data"         : self.secInspectSolar[InspectSolar.filt5.rawValue].formTextValue,
            "flit6Option"       : strFilt6Opt,
            "filt6Image"        : strFilt6Img,
            "flit6Data"         : self.secInspectSolar[InspectSolar.filt6.rawValue].formTextValue,
            "flit7Option"       : strFilt7Opt,
            "filt7Image"        : strFilt7Img,
            "flit7Data"         : self.secInspectSolar[InspectSolar.filt7.rawValue].formTextValue,
            "flit8Option"       : strFilt8Opt,
            "filt8Image"        : strFilt8Img,
            "flit8Data"         : self.secInspectSolar[InspectSolar.filt8.rawValue].formTextValue,
            "flit9Option"       : strFilt9Opt,
            "filt9Image"        : strFilt9Img,
            "flit9Data"         : self.secInspectSolar[InspectSolar.filt9.rawValue].formTextValue,
            "flit10Option"      : strFilt10Opt,
            "filt10Image"       : strFilt10Img,
            "flit10Data"        : self.secInspectSolar[InspectSolar.filt10.rawValue].formTextValue,
            "flit11Option"      : strFilt11Opt,
            "filt11Image"       : strFilt11Img,
            "flit11Data"        : self.secInspectSolar[InspectSolar.filt11.rawValue].formTextValue,
            "flit12Option"      : strFilt12Opt,
            "filt12Image"       : strFilt12Img,
            "flit12Data"        : self.secInspectSolar[InspectSolar.filt12.rawValue].formTextValue
        ]
        
        print("inspectSolarDetails :: \(inspectSolarDetails)")
        //if sharedExtension.connectedToNetwork() {
        ApiManager.sharedInstanceAPI.PostInspectSolar(postId: 1, solarDetails: inspectSolarDetails, onSuccess: { json in
            DispatchQueue.main.async {
                print("InspectionSolarDetails json :: \(String(describing: json))")
                DispatchQueue.main.async(execute: {() -> Void in
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectPoolPump") as! InspectPoolPumpVC
                        self.navigationController?.pushViewController(formVC, animated: true)
                    } else if UIDevice.current.userInterfaceIdiom == .pad {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectPoolPump") as! InspectPoolPumpVC
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

extension InspectSolarVC: OpalImagePickerControllerDelegate {
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
                                self.arrSolarMainImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSolarMainImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 1 {
                                self.arrSolarImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSolarImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 2 {
                                self.arrFiltMainImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataFiltMainImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 3 {
                                self.arrFiltImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataFiltImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 4 {
                                self.arrFilt1Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataFilt1Img = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 5 {
                                self.arrFilt2Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataFilt2Img = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 6 {
                                self.arrFilt3Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataFilt3Img = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 7 {
                                self.arrFilt4Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataFilt4Img = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 8 {
                                self.arrFilt5Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataFilt5Img = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 9 {
                                self.arrFilt6Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataFilt6Img = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 10 {
                                self.arrFilt7Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataFilt7Img = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 11 {
                                self.arrFilt8Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataFilt8Img = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 12 {
                                self.arrFilt9Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataFilt9Img = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 13 {
                                self.arrFilt10Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataFilt10Img = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 14 {
                                self.arrFilt11Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataFilt11Img = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 15 {
                                self.arrFilt12Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataFilt12Img = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            }
                            
                            if self.fetchIndexForSubSolarUpload == 0 {
                                self.arrSolar0Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSolar0Img = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubSolarUpload == 1 {
                                self.arrSolar1Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSolar1Img = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubSolarUpload == 2 {
                                self.arrSolar2Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSolar2Img = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubSolarUpload == 3 {
                                self.arrSolar3Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSolar3Img = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubSolarUpload == 4 {
                                self.arrSolar4Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataSolar4Img = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
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
                self.tblSolar.reloadData()
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


extension InspectSolarVC: UIImagePickerControllerDelegate {
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
            self.arrSolarMainImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSolarMainImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 1 {
            self.arrSolarImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSolarImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 2 {
            self.arrFiltMainImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataFiltMainImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 3 {
            self.arrFiltImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataFiltImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 4 {
            self.arrFilt1Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataFilt1Img = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 5 {
            self.arrFilt2Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)

           self.dataFilt2Img = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 6 {
            self.arrFilt3Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataFilt3Img = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 7 {
            self.arrFilt4Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataFilt4Img = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 8 {
            self.arrFilt5Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataFilt5Img = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 9 {
            self.arrFilt6Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataFilt6Img = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 10 {
            self.arrFilt7Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataFilt7Img = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 11 {
            self.arrFilt8Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataFilt8Img = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 12 {
            self.arrFilt9Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataFilt9Img = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 13 {
            self.arrFilt10Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataFilt10Img = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 14 {
            self.arrFilt11Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataFilt11Img = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 15 {
            self.arrFilt12Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataFilt12Img = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        }
        
        if self.fetchIndexForSubSolarUpload == 0 {
            self.arrSolar0Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSolar0Img = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForSubSolarUpload == 1 {
            self.arrSolar1Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSolar1Img = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForSubSolarUpload == 2 {
            self.arrSolar2Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSolar2Img = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForSubSolarUpload == 3 {
            self.arrSolar3Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSolar3Img = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForSubSolarUpload == 4 {
            self.arrSolar4Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataSolar4Img = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        }
        
        self.tblSolar.reloadData()
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
}

extension InspectSolarVC: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        var cell = UITableViewCell()
        cell = (textView.superview?.superview as? UITableViewCell)!
        
        if let portableTblCell = cell as? SolarMainTableCell {
            if let textView = portableTblCell.txtOther {
                self.self.secInspectSolar[InspectSolar.solar.rawValue].formTextValue = (textView.text)!
            }
        } else if let portableTblCell = cell as? FiltTableCell {
            if let textView = portableTblCell.txtOther {
                self.secInspectSolar[InspectSolar.filt.rawValue].formTextValue = (textView.text)!
            }
        } else if let portableTblCell = cell as? Filt1TableCell {
            if let textView = portableTblCell.txtOther {
                self.secInspectSolar[InspectSolar.filt1.rawValue].formTextValue = (textView.text)!
            }
        } else if let portableTblCell = cell as? Filt2TableCell {
            if let textView = portableTblCell.txtOther {
                self.secInspectSolar[InspectSolar.filt2.rawValue].formTextValue = (textView.text)!
            }
        } else if let portableTblCell = cell as? Filt3TableCell {
            if let textView = portableTblCell.txtOther {
                self.secInspectSolar[InspectSolar.filt3.rawValue].formTextValue = (textView.text)!
            }
        } else if let portableTblCell = cell as? Filt4TableCell {
            if let textView = portableTblCell.txtOther {
                self.secInspectSolar[InspectSolar.filt4.rawValue].formTextValue = (textView.text)!
            }
        } else if let portableTblCell = cell as? Filt5TableCell {
            if let textView = portableTblCell.txtOther {
                self.secInspectSolar[InspectSolar.filt5.rawValue].formTextValue = (textView.text)!
            }
        } else if let portableTblCell = cell as? Filt6TableCell {
            if let textView = portableTblCell.txtOther {
                self.secInspectSolar[InspectSolar.filt6.rawValue].formTextValue = (textView.text)!
            }
        } else if let portableTblCell = cell as? Filt7TableCell {
            if let textView = portableTblCell.txtOther {
                self.secInspectSolar[InspectSolar.filt7.rawValue].formTextValue = (textView.text)!
            }
        } else if let portableTblCell = cell as? Filt8TableCell {
            if let textView = portableTblCell.txtOther {
                self.secInspectSolar[InspectSolar.filt8.rawValue].formTextValue = (textView.text)!
            }
        } else if let portableTblCell = cell as? Filt9TableCell {
            if let textView = portableTblCell.txtOther {
                self.secInspectSolar[InspectSolar.filt9.rawValue].formTextValue = (textView.text)!
            }
        } else if let portableTblCell = cell as? Filt10TableCell {
            if let textView = portableTblCell.txtOther {
                self.secInspectSolar[InspectSolar.filt10.rawValue].formTextValue = (textView.text)!
            }
        } else if let portableTblCell = cell as? Filt11TableCell {
            if let textView = portableTblCell.txtOther {
                self.secInspectSolar[InspectSolar.filt11.rawValue].formTextValue = (textView.text)!
            }
        } else if let portableTblCell = cell as? Filt12TableCell {
            if let textView = portableTblCell.txtOther {
                self.secInspectSolar[InspectSolar.filt12.rawValue].formTextValue = (textView.text)!
            }
        }
        
        if let spaTblCell = cell as? Solar0TableCell {
            if let textView = spaTblCell.txtOther {
                self.secSolar[Solar.solar0.rawValue].formTextValue = (textView.text)!
            }
        } else if let spaTblCell = cell as? Solar1TableCell {
            if let textView = spaTblCell.txtOther {
                self.secSolar[Solar.solar1.rawValue].formTextValue = (textView.text)!
            }
        } else if let spaTblCell = cell as? Solar2TableCell {
            if let textView = spaTblCell.txtOther {
                self.secSolar[Solar.solar2.rawValue].formTextValue = (textView.text)!
            }
        } else if let spaTblCell = cell as? Solar3TableCell {
            if let textView = spaTblCell.txtOther {
                self.secSolar[Solar.solar3.rawValue].formTextValue = (textView.text)!
            }
        } else if let spaTblCell = cell as? Solar4TableCell {
            if let textView = spaTblCell.txtOther {
                self.secSolar[Solar.solar4.rawValue].formTextValue = (textView.text)!
            }
        } 
    }
}

extension InspectSolarVC: UITableViewDataSource, UITableViewDelegate {
    //MARK:- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 25 {
            return 5
        } else {
            return 17
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 25 {
            if indexPath.row == 0 {
                let solarCell = tableView.dequeueReusableCell(withIdentifier: "Solar0Cell", for: indexPath) as! Solar0TableCell
                
                solarCell.lblHeader.text = "Does a visual inspection of panels show good condition?"
                
                solarCell.btnUpload.addTarget(self, action: #selector(btnSolarImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                solarCell.collectionVw.arrItems = arrSolar0Img
                solarCell.collectionVw.delegateItemCollection = self
                solarCell.collectionVw.reloadImageCollection()
                
                if arrSolar0Img.count > 0 {
                    solarCell.btnUpload.isHidden = true
                    solarCell.collectionVw.isHidden = false
                } else {
                    solarCell.btnUpload.isHidden = false
                    solarCell.collectionVw.isHidden = true
                }
                
                solarCell.delegateSolar0 = self
                solarCell.txtOther.delegate = self
                
                return solarCell
            } else if indexPath.row == 1 {
                let solarCell = tableView.dequeueReusableCell(withIdentifier: "Solar1Cell", for: indexPath) as! Solar1TableCell
                
                solarCell.lblHeader.text = "Are there any visual leaks while system is running?"
                
                solarCell.btnUpload.addTarget(self, action: #selector(btnSolarImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                solarCell.collectionVw.arrItems = arrSolar1Img
                solarCell.collectionVw.delegateItemCollection = self
                solarCell.collectionVw.reloadImageCollection()
                
                if arrSolar1Img.count > 0 {
                    solarCell.btnUpload.isHidden = true
                    solarCell.collectionVw.isHidden = false
                } else {
                    solarCell.btnUpload.isHidden = false
                    solarCell.collectionVw.isHidden = true
                }
                
                solarCell.delegateSolar1 = self
                solarCell.txtOther.delegate = self
                
                return solarCell
            } else if indexPath.row == 2 {
                let solarCell = tableView.dequeueReusableCell(withIdentifier: "Solar2Cell", for: indexPath) as! Solar2TableCell
                
                solarCell.lblHeader.text = "What is the approximate age of the panels?"
                
                solarCell.btnUpload.addTarget(self, action: #selector(btnSolarImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                solarCell.collectionVw.arrItems = arrSolar2Img
                solarCell.collectionVw.delegateItemCollection = self
                solarCell.collectionVw.reloadImageCollection()
                
                if arrSolar2Img.count > 0 {
                    solarCell.btnUpload.isHidden = true
                    solarCell.collectionVw.isHidden = false
                } else {
                    solarCell.btnUpload.isHidden = false
                    solarCell.collectionVw.isHidden = true
                }
                
                //solarCell.delegateSolar2 = self
                solarCell.txtOther.delegate = self
                
                return solarCell
            } else if indexPath.row == 3 {
                let solarCell = tableView.dequeueReusableCell(withIdentifier: "Solar3Cell", for: indexPath) as! Solar3TableCell
                
                solarCell.lblHeader.text = "Are any of the panels dry rotted?"
                
                solarCell.btnUpload.addTarget(self, action: #selector(btnSolarImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                solarCell.collectionVw.arrItems = arrSolar3Img
                solarCell.collectionVw.delegateItemCollection = self
                solarCell.collectionVw.reloadImageCollection()
                
                if arrSolar3Img.count > 0 {
                    solarCell.btnUpload.isHidden = true
                    solarCell.collectionVw.isHidden = false
                } else {
                    solarCell.btnUpload.isHidden = false
                    solarCell.collectionVw.isHidden = true
                }
                
                solarCell.delegateSolar3 = self
                solarCell.txtOther.delegate = self
                
                return solarCell
            } else {// if indexPath.row == 4
                let solarCell = tableView.dequeueReusableCell(withIdentifier: "Solar4Cell", for: indexPath) as! Solar4TableCell
                
                solarCell.lblHeader.text = "Is the control and value system working properly?"
                
                solarCell.btnUpload.addTarget(self, action: #selector(btnSolarImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                solarCell.collectionVw.arrItems = arrSolar4Img
                solarCell.collectionVw.delegateItemCollection = self
                solarCell.collectionVw.reloadImageCollection()
                
                if arrSolar4Img.count > 0 {
                    solarCell.btnUpload.isHidden = true
                    solarCell.collectionVw.isHidden = false
                } else {
                    solarCell.btnUpload.isHidden = false
                    solarCell.collectionVw.isHidden = true
                }
                
                solarCell.delegateSolar4 = self
                solarCell.txtOther.delegate = self
                
                return solarCell
            }
        } else {
            if indexPath.row == 0 {
                let cameraCell = tableView.dequeueReusableCell(withIdentifier: "CameraCell", for: indexPath) as! CameraTableCell
                
                cameraCell.lblHeader.text = "Solar"
                 if UIDevice.current.userInterfaceIdiom == .phone {
                    cameraCell.lblHeader.font = UIFont.init(name: "Roboto-bold", size: 16.0)
                 } else {
                    cameraCell.lblHeader.font = UIFont.init(name: "Roboto-bold", size: 24.0)
                }
                
                cameraCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                cameraCell.collectionVw.arrItems = arrSolarMainImg
                cameraCell.collectionVw.delegateItemCollection = self
                cameraCell.collectionVw.reloadImageCollection()
                
                if arrSolarMainImg.count > 0 {
                    cameraCell.btnUpload.isHidden = true
                    cameraCell.collectionVw.isHidden = false
                } else {
                    cameraCell.btnUpload.isHidden = false
                    cameraCell.collectionVw.isHidden = true
                }
                
                return cameraCell
            } else if indexPath.row == 1 {
                let solarMCell = tableView.dequeueReusableCell(withIdentifier: "SolarMainCell", for: indexPath) as! SolarMainTableCell
                
                solarMCell.lblHeader.text = "Is solar present?"
                solarMCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

                solarMCell.collectionVw.arrItems = arrSolarImg
                solarMCell.collectionVw.delegateItemCollection = self
                solarMCell.collectionVw.reloadImageCollection()
                
                if arrSolarImg.count > 0 {
                    solarMCell.btnUpload.isHidden = true
                    solarMCell.collectionVw.isHidden = false
                } else {
                    solarMCell.btnUpload.isHidden = false
                    solarMCell.collectionVw.isHidden = true
                }
                
                if strSolarMainOpt == "Yes" {
                    solarMCell.tblSubVw.delegate = self
                    solarMCell.tblSubVw.dataSource = self
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        solarMCell.tblHeightConstraint.constant = (350*4+345)
                    } else {
                        solarMCell.tblHeightConstraint.constant = (600*4+470)
                    }
                    solarMCell.tblSubVw.reloadData()
                } else {
                    solarMCell.tblHeightConstraint.constant = 0
                }
                
                solarMCell.delegateSolarMain = self
                solarMCell.txtOther.delegate = self
                
                return solarMCell
            } else if indexPath.row == 2 {
                let cameraCell = tableView.dequeueReusableCell(withIdentifier: "CameraCell", for: indexPath) as! CameraTableCell
                
                cameraCell.lblHeader.text = "Filtration System"
                 if UIDevice.current.userInterfaceIdiom == .phone {
                    cameraCell.lblHeader.font = UIFont.init(name: "Roboto-bold", size: 16.0)
                 } else {
                    cameraCell.lblHeader.font = UIFont.init(name: "Roboto-bold", size: 24.0)
                }
                cameraCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

                cameraCell.collectionVw.arrItems = arrFiltMainImg
                cameraCell.collectionVw.delegateItemCollection = self
                cameraCell.collectionVw.reloadImageCollection()
                
                if arrFiltMainImg.count > 0 {
                    cameraCell.btnUpload.isHidden = true
                    cameraCell.collectionVw.isHidden = false
                } else {
                    cameraCell.btnUpload.isHidden = false
                    cameraCell.collectionVw.isHidden = true
                }
                
                return cameraCell
            } else if indexPath.row == 3 {
                let filtCell = tableView.dequeueReusableCell(withIdentifier: "FiltCell", for: indexPath) as! FiltTableCell
                
                filtCell.lblHeader.text = "What type of filtration system is present?"
                
                filtCell.lbl1.text = "De"
                filtCell.lbl2.text = "Cartridge"
                filtCell.lbl3.text = "Sand/Media"
                filtCell.lbl4.text = "Other"
                
                filtCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

                filtCell.collectionVw.arrItems = arrFiltImg
                filtCell.collectionVw.delegateItemCollection = self
                filtCell.collectionVw.reloadImageCollection()
                
                if arrFiltImg.count > 0 {
                    filtCell.btnUpload.isHidden = true
                    filtCell.collectionVw.isHidden = false
                } else {
                    filtCell.btnUpload.isHidden = false
                    filtCell.collectionVw.isHidden = true
                }
                
                filtCell.delegateFilt = self
                filtCell.txtOther.delegate = self
                
                return filtCell
            } else if indexPath.row == 4 {
                let filtCell = tableView.dequeueReusableCell(withIdentifier: "Filt1Cell", for: indexPath) as! Filt1TableCell
                
                filtCell.lblHeader.text = "Is system easily accessible for repair?"
                
                filtCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

                filtCell.collectionVw.arrItems = arrFilt1Img
                filtCell.collectionVw.delegateItemCollection = self
                filtCell.collectionVw.reloadImageCollection()
                
                if arrFilt1Img.count > 0 {
                    filtCell.btnUpload.isHidden = true
                    filtCell.collectionVw.isHidden = false
                } else {
                    filtCell.btnUpload.isHidden = false
                    filtCell.collectionVw.isHidden = true
                }
                
                filtCell.delegateFilt1 = self
                filtCell.txtOther.delegate = self
                
                return filtCell
            } else if indexPath.row == 5 {
                let filtCell = tableView.dequeueReusableCell(withIdentifier: "Filt2Cell", for: indexPath) as! Filt2TableCell
                
                filtCell.lblHeader.text = "Does system have proper sized plumbing?"
                
                filtCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

                filtCell.collectionVw.arrItems = arrFilt2Img
                filtCell.collectionVw.delegateItemCollection = self
                filtCell.collectionVw.reloadImageCollection()
                
                if arrFilt2Img.count > 0 {
                    filtCell.btnUpload.isHidden = true
                    filtCell.collectionVw.isHidden = false
                } else {
                    filtCell.btnUpload.isHidden = false
                    filtCell.collectionVw.isHidden = true
                }
                
                filtCell.delegateFilt2 = self
                filtCell.txtOther.delegate = self
                
                return filtCell
            } else if indexPath.row == 6 {
                let filtCell = tableView.dequeueReusableCell(withIdentifier: "Filt3Cell", for: indexPath) as! Filt3TableCell
                
                filtCell.lblHeader.text = "Is the plumbling properly labeled and oranized?"
                
                filtCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

                filtCell.collectionVw.arrItems = arrFilt3Img
                filtCell.collectionVw.delegateItemCollection = self
                filtCell.collectionVw.reloadImageCollection()
                
                if arrFilt3Img.count > 0 {
                    filtCell.btnUpload.isHidden = true
                    filtCell.collectionVw.isHidden = false
                } else {
                    filtCell.btnUpload.isHidden = false
                    filtCell.collectionVw.isHidden = true
                }
                
                filtCell.delegateFilt3 = self
                filtCell.txtOther.delegate = self
                
                return filtCell
            } else if indexPath.row == 7 {
                let filtCell = tableView.dequeueReusableCell(withIdentifier: "Filt4Cell", for: indexPath) as! Filt4TableCell
                
                filtCell.lblHeader.text = "Is the filtration system operating properly?"
                
                filtCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

                filtCell.collectionVw.arrItems = arrFilt4Img
                filtCell.collectionVw.delegateItemCollection = self
                filtCell.collectionVw.reloadImageCollection()
                
                if arrFilt4Img.count > 0 {
                    filtCell.btnUpload.isHidden = true
                    filtCell.collectionVw.isHidden = false
                } else {
                    filtCell.btnUpload.isHidden = false
                    filtCell.collectionVw.isHidden = true
                }
                
                filtCell.delegateFilt4 = self
                filtCell.txtOther.delegate = self
                
                return filtCell
            } else if indexPath.row == 8 {
                let filtCell = tableView.dequeueReusableCell(withIdentifier: "Filt5Cell", for: indexPath) as! Filt5TableCell
                
                filtCell.lblHeader.text = "Does the system show visible laeking?"
                
                filtCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

                filtCell.collectionVw.arrItems = arrFilt5Img
                filtCell.collectionVw.delegateItemCollection = self
                filtCell.collectionVw.reloadImageCollection()
                
                if arrFilt5Img.count > 0 {
                    filtCell.btnUpload.isHidden = true
                    filtCell.collectionVw.isHidden = false
                } else {
                    filtCell.btnUpload.isHidden = false
                    filtCell.collectionVw.isHidden = true
                }
                
                filtCell.delegateFilt5 = self
                filtCell.txtOther.delegate = self
                
                return filtCell
            } else if indexPath.row == 9 {
                let filtCell = tableView.dequeueReusableCell(withIdentifier: "Filt6Cell", for: indexPath) as! Filt6TableCell
                
                filtCell.lblHeader.text = "Does the system run quietly during operation?"
                
                filtCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

                filtCell.collectionVw.arrItems = arrFilt6Img
                filtCell.collectionVw.delegateItemCollection = self
                filtCell.collectionVw.reloadImageCollection()
                
                if arrFilt6Img.count > 0 {
                    filtCell.btnUpload.isHidden = true
                    filtCell.collectionVw.isHidden = false
                } else {
                    filtCell.btnUpload.isHidden = false
                    filtCell.collectionVw.isHidden = true
                }
                
                filtCell.delegateFilt6 = self
                filtCell.txtOther.delegate = self
                
                return filtCell
            } else if indexPath.row == 10 {
                let filtCell = tableView.dequeueReusableCell(withIdentifier: "Filt7Cell", for: indexPath) as! Filt7TableCell
                
                filtCell.lblHeader.text = "Is the filtration system mounted properly and secure?"
                
                filtCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

                filtCell.collectionVw.arrItems = arrFilt7Img
                filtCell.collectionVw.delegateItemCollection = self
                filtCell.collectionVw.reloadImageCollection()
                
                if arrFilt7Img.count > 0 {
                    filtCell.btnUpload.isHidden = true
                    filtCell.collectionVw.isHidden = false
                } else {
                    filtCell.btnUpload.isHidden = false
                    filtCell.collectionVw.isHidden = true
                }
                
                filtCell.delegateFilt7 = self
                filtCell.txtOther.delegate = self
                
                return filtCell
            } else if indexPath.row == 11 {
                let filtCell = tableView.dequeueReusableCell(withIdentifier: "Filt8Cell", for: indexPath) as! Filt8TableCell
                
                filtCell.lblHeader.text = "Does the filtration system have a pressure gauge?"
                
                filtCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

                filtCell.collectionVw.arrItems = arrFilt8Img
                filtCell.collectionVw.delegateItemCollection = self
                filtCell.collectionVw.reloadImageCollection()
                
                if arrFilt8Img.count > 0 {
                    filtCell.btnUpload.isHidden = true
                    filtCell.collectionVw.isHidden = false
                } else {
                    filtCell.btnUpload.isHidden = false
                    filtCell.collectionVw.isHidden = true
                }
                
                filtCell.delegateFilt8 = self
                filtCell.txtOther.delegate = self
                
                return filtCell
            } else if indexPath.row == 12 {
                let filtCell = tableView.dequeueReusableCell(withIdentifier: "Filt9Cell", for: indexPath) as! Filt9TableCell
                
                filtCell.lblHeader.text = "What was the pressure at the time of operation?"
                
                filtCell.lbl1.text = "Low"
                filtCell.lbl2.text = "High"
                
                filtCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

                filtCell.collectionVw.arrItems = arrFilt9Img
                filtCell.collectionVw.delegateItemCollection = self
                filtCell.collectionVw.reloadImageCollection()
                
                if arrFilt9Img.count > 0 {
                    filtCell.btnUpload.isHidden = true
                    filtCell.collectionVw.isHidden = false
                } else {
                    filtCell.btnUpload.isHidden = false
                    filtCell.collectionVw.isHidden = true
                }
                
                filtCell.delegateFilt9 = self
                filtCell.txtOther.delegate = self
                
                return filtCell
            } else if indexPath.row == 13 {
                let filtCell = tableView.dequeueReusableCell(withIdentifier: "Filt10Cell", for: indexPath) as! Filt10TableCell
                
                filtCell.lblHeader.text = "Does the filtration system have a proper backwash or values to lower water in the pool?"
                
                filtCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

                filtCell.collectionVw.arrItems = arrFilt10Img
                filtCell.collectionVw.delegateItemCollection = self
                filtCell.collectionVw.reloadImageCollection()
                
                if arrFilt10Img.count > 0 {
                    filtCell.btnUpload.isHidden = true
                    filtCell.collectionVw.isHidden = false
                } else {
                    filtCell.btnUpload.isHidden = false
                    filtCell.collectionVw.isHidden = true
                }
                
                filtCell.delegateFilt10 = self
                filtCell.txtOther.delegate = self
                
                return filtCell
            } else if indexPath.row == 14 {
                let filtCell = tableView.dequeueReusableCell(withIdentifier: "Filt11Cell", for: indexPath) as! Filt11TableCell
                
                filtCell.lblHeader.text = "Is a proper backwash hose present at the filtration system?"
                
                filtCell.lbl3.text = "Not Applicable"
                
                filtCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                filtCell.collectionVw.arrItems = arrFilt11Img
                filtCell.collectionVw.delegateItemCollection = self
                filtCell.collectionVw.reloadImageCollection()
                
                if arrFilt11Img.count > 0 {
                    filtCell.btnUpload.isHidden = true
                    filtCell.collectionVw.isHidden = false
                } else {
                    filtCell.btnUpload.isHidden = false
                    filtCell.collectionVw.isHidden = true
                }
                
                filtCell.delegateFilt11 = self
                filtCell.txtOther.delegate = self
                
                return filtCell
            } else if indexPath.row == 15 {
                let filtCell = tableView.dequeueReusableCell(withIdentifier: "Filt12Cell", for: indexPath) as! Filt12TableCell
                
                filtCell.lblHeader.text = "Are grid/cartridge/media in good condition?"
                
                filtCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)

                filtCell.collectionVw.arrItems = arrFilt12Img
                filtCell.collectionVw.delegateItemCollection = self
                filtCell.collectionVw.reloadImageCollection()
                
                if arrFilt12Img.count > 0 {
                    filtCell.btnUpload.isHidden = true
                    filtCell.collectionVw.isHidden = false
                } else {
                    filtCell.btnUpload.isHidden = false
                    filtCell.collectionVw.isHidden = true
                }
                
                filtCell.delegateFilt12 = self
                filtCell.txtOther.delegate = self
                
                return filtCell
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
                    return 345
                }
            } else {
                if indexPath.row == 0 {
                    return 185
                } else if indexPath.row == 1 {
                    if strSolarMainOpt == "Yes" {
                        return (350*4+345)+335
                    } else {
                        return 335
                    }
                } else if indexPath.row == 2 {
                    return 185
                } else if indexPath.row == 3 {
                    return 410
                } else if indexPath.row == 14 {
                    return 395
                } else if indexPath.row == 15 {
                    return 345
                } else if indexPath.row == 16 {
                    return 105
                } else {
                    return 355
                }
            }
        } else {        // .pad
            if tableView.tag == 25 {
                if indexPath.row == 2 {
                    return 470
                } else {
                    return 600
                }
            } else {
                if indexPath.row == 0 {
                    return 320
                } else if indexPath.row == 1 {
                    if strSolarMainOpt == "Yes" {
                        return (600*4+470)+615
                    } else {
                        return 615
                    }
                } else if indexPath.row == 2 {
                    return 320
                } else if indexPath.row == 3 {
                    return 700
                } else if indexPath.row == 14 {
                    return 660
                } else if indexPath.row == 15 {
                    return 585
                } else if indexPath.row == 16 {
                    return 175
                } else {
                    return 600
                }
            }
        }
    }
}

extension InspectSolarVC: SolarMainProtocol, Solar0Protocol, Solar1Protocol, Solar3Protocol, Solar4Protocol, FiltProtocol, Filt1Protocol, Filt2Protocol, Filt3Protocol, Filt4Protocol, Filt5Protocol, Filt6Protocol, Filt7Protocol, Filt8Protocol, Filt9Protocol, Filt10Protocol, Filt11Protocol, Filt12Protocol {
    func didTapOnCellSolarMain(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strSolarMainOpt = "Yes"
        } else if _btnDescribeTag == 1 {
            strSolarMainOpt = "No"
        }
        self.tblSolar.reloadData()
    }
    
    func didTapOnCellSolar0(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strSolar0Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strSolar0Opt = "No"
        }
        self.tblSolar.reloadData()
    }
    
    func didTapOnCellSolar1(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strSolar1Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strSolar1Opt = "No"
        }
        self.tblSolar.reloadData()
    }
    
    func didTapOnCellSolar3(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strSolar3Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strSolar3Opt = "No"
        }
        self.tblSolar.reloadData()
    }
    
    func didTapOnCellSolar4(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strSolar4Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strSolar4Opt = "No"
        }
        self.tblSolar.reloadData()
    }
    
    func didTapOnCellFilt(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strFiltOpt = "De"
        } else if _btnDescribeTag == 1 {
            strFiltOpt = "Cartridge"
        } else if _btnDescribeTag == 2 {
            strFiltOpt = "Sand/Media"
        } else if _btnDescribeTag == 3 {
            strFiltOpt = "Other"
        }
        self.tblSolar.reloadData()
    }
    
    func didTapOnCellFilt1(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strFilt1Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strFilt1Opt = "No"
        }
        self.tblSolar.reloadData()
    }
    
    func didTapOnCellFilt2(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strFilt2Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strFilt2Opt = "No"
        }
        self.tblSolar.reloadData()
    }
    
    func didTapOnCellFilt3(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strFilt3Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strFilt3Opt = "No"
        }
        self.tblSolar.reloadData()
    }
    
    func didTapOnCellFilt4(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strFilt4Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strFilt4Opt = "No"
        }
        self.tblSolar.reloadData()
    }
    
    func didTapOnCellFilt5(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strFilt5Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strFilt5Opt = "No"
        }
        self.tblSolar.reloadData()
    }
    
    func didTapOnCellFilt6(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strFilt6Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strFilt6Opt = "No"
        }
        self.tblSolar.reloadData()
    }
    
    func didTapOnCellFilt7(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strFilt7Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strFilt7Opt = "No"
        }
        self.tblSolar.reloadData()
    }
    
    func didTapOnCellFilt8(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strFilt8Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strFilt8Opt = "No"
        }
        self.tblSolar.reloadData()
    }
    
    func didTapOnCellFilt9(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strFilt9Opt = "Low"
        } else if _btnDescribeTag == 1 {
            strFilt9Opt = "High"
        }
        self.tblSolar.reloadData()
    }
    
    func didTapOnCellFilt10(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strFilt10Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strFilt10Opt = "No"
        }
        self.tblSolar.reloadData()
    }
    
    func didTapOnCellFilt11(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strFilt11Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strFilt11Opt = "No"
        }
        self.tblSolar.reloadData()
    }
    
    func didTapOnCellFilt12(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strFilt12Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strFilt12Opt = "No"
        }
        self.tblSolar.reloadData()
    }
}
