//
//  InspectEdgeVC.swift
//  Leaktronics
//
//  Created by ivaninfotech on 5/5/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import CoreData
import DLRadioButton
import SVProgressHUD
import Alamofire
import Photos
import OpalImagePicker


class InspectEdgeVC: UIViewController, UINavigationControllerDelegate, UploadCollectionProtocol {
    
    @IBOutlet weak var tblEdge: UITableView!
    
    var secEdge = [formInspectionPoolData]()
    var secSubNegative = [formInspectionPoolData]()
    var secSubBasin = [formInspectionPoolData]()
    var secSubDrain = [formInspectionPoolData]()
    var secSubTank = [formInspectionPoolData]()
    
    enum Edge: Int {
        case nagative = 1
        case basin = 3
        case drain = 5
        case tank = 7
    }
    
    enum Negative: Int {
        case edge0 = 0
        case edge1 = 1
    }
    
    enum Basin: Int {
        case basin0 = 0
        case basin1 = 1
        case basin2 = 2
        case basin3 = 3
        case basin4 = 4
        case basin5 = 5
    }
    
    enum Drain: Int {
        case drain0 = 0
    }
    
    enum Tank: Int {
        case tank0 = 0
    }
    var imagePicker = UIImagePickerController()
    var picker:UIImagePickerController? = UIImagePickerController()
    
    
    //For Images
    var arrNegativeEdgeImg: [CollectionImageObject] = []
    var arrBasinImg: [CollectionImageObject] = []
    var arrDrainImg: [CollectionImageObject] = []
    var arrTankImg: [CollectionImageObject] = []
    
    var arrEdge0Img: [CollectionImageObject] = []
    var arrEdge1Img: [CollectionImageObject] = []
    
    var arrBasin0Img: [CollectionImageObject] = []
    var arrBasin1Img: [CollectionImageObject] = []
    var arrBasin2Img: [CollectionImageObject] = []
    var arrBasin3Img: [CollectionImageObject] = []
    var arrBasin4Img: [CollectionImageObject] = []
    var arrBasin5Img: [CollectionImageObject] = []
    
    var arrDrain0Img: [CollectionImageObject] = []
    
    var arrTank0Img: [CollectionImageObject] = []
    
    var fetchIndexForUpload: Int = -1
    var fetchIndexForSubEdgeUpload: Int = -1
    var fetchIndexForSubBasinUpload: Int = -1
    var fetchIndexForSubDrainUpload: Int = -1
    var fetchIndexForSubTankUpload: Int = -1
    
    
    //For Image Server path
    var strNegativeEdgeImg = String()
    var strBasinImg = String()
    var strDrainImg = String()
    var strTankImg = String()
    var strEdge0Img = String()
    var strEdge1Img = String()
    var strBasin0Img = String()
    var strBasin1Img = String()
    var strBasin2Img = String()
    var strBasin3Img = String()
    var strBasin4Img = String()
    var strBasin5Img = String()
    var strDrain0Img = String()
    var strTank0Img = String()
    
    //For Image CoreData
    var dataNegativeEdgeImg = NSData()
    var dataBasinImg = NSData()
    var dataDrainImg = NSData()
    var dataTankImg = NSData()
    var dataEdge0Img = NSData()
    var dataEdge1Img = NSData()
    var dataBasin0Img = NSData()
    var dataBasin1Img = NSData()
    var dataBasin2Img = NSData()
    var dataBasin3Img = NSData()
    var dataBasin4Img = NSData()
    var dataBasin5Img = NSData()
    var dataDrain0Img = NSData()
    var dataTank0Img = NSData()
    
    //For Optional Value
    var strNegativeEdgeOpt = String()
    var strBasinOpt = String()
    var strDrainOpt = String()
    var strTankOpt = String()
    var strEdge0Opt = String()
    var strEdge1Opt = String()
    var strBasin0Opt = String()
    var strBasin1Opt = String()
    var strBasin2Opt = String()
    var strBasin3Opt = String()
    var strBasin4Opt = String()
    var strBasin5Opt = String()
    var strDrain0Opt = String()
    var strTank0Opt = String()
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.prepareFormEdgeData()
    }
    
    func prepareFormEdgeData() {
        for _ in 0..<8 {
            let obj = formInspectionPoolData()
            self.secEdge.append(obj)
        }
        for _ in 0..<2 {
            let obj = formInspectionPoolData()
            self.secSubNegative.append(obj)
        }
        for _ in 0..<6 {
            let obj = formInspectionPoolData()
            self.secSubBasin.append(obj)
        }
        for _ in 0..<1 {
            let obj = formInspectionPoolData()
            self.secSubDrain.append(obj)
        }
        for _ in 0..<1 {
            let obj = formInspectionPoolData()
            self.secSubTank.append(obj)
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
        let indexOfCell = self.tblEdge.indexPath(for: cell)
        print("Clicked Index : \(String(describing: indexOfCell?.row))")
        
        fetchIndexForSubEdgeUpload = -1
        fetchIndexForSubBasinUpload = -1
        fetchIndexForSubDrainUpload = -1
        fetchIndexForSubTankUpload = -1
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
    
    @objc func btnEdgeImgUpload(_ sender: Any) {
        print("Button pressed 👍 ")
        let btn = sender as! UIButton
        let cell = btn.superview?.superview?.superview as! UITableViewCell
        let tblWall = self.view.viewWithTag(25) as! UITableView
        let indexOfCell = tblWall.indexPath(for: cell)
        print("Clicked Index : \(String(describing: indexOfCell?.row))")
        fetchIndexForUpload = -1
        fetchIndexForSubEdgeUpload = (indexOfCell?.row)!
        
        print("Upload Index : \(String(describing: fetchIndexForSubEdgeUpload))")
        
        self.actionSheetPopUpForGalleryOpen()
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc func btnBasinImgUpload(_ sender: Any) {
        print("Button pressed 👍 ")
        let btn = sender as! UIButton
        let cell = btn.superview?.superview?.superview as! UITableViewCell
        let tblWall = self.view.viewWithTag(30) as! UITableView
        let indexOfCell = tblWall.indexPath(for: cell)
        print("Clicked Index : \(String(describing: indexOfCell?.row))")
        fetchIndexForUpload = -1
        fetchIndexForSubBasinUpload = (indexOfCell?.row)!
        
        print("Upload Index : \(String(describing: fetchIndexForSubBasinUpload))")
        
        self.actionSheetPopUpForGalleryOpen()
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc func btnDrainImgUpload(_ sender: Any) {
        print("Button pressed 👍 ")
        let btn = sender as! UIButton
        let cell = btn.superview?.superview?.superview as! UITableViewCell
        let tblWall = self.view.viewWithTag(35) as! UITableView
        let indexOfCell = tblWall.indexPath(for: cell)
        print("Clicked Index : \(String(describing: indexOfCell?.row))")
        fetchIndexForUpload = -1
        fetchIndexForSubDrainUpload = (indexOfCell?.row)!
        
        print("Upload Index : \(String(describing: fetchIndexForSubDrainUpload))")
        
        self.actionSheetPopUpForGalleryOpen()
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc func btnTankImgUpload(_ sender: Any) {
        print("Button pressed 👍 ")
        let btn = sender as! UIButton
        let cell = btn.superview?.superview?.superview as! UITableViewCell
        let tblWall = self.view.viewWithTag(40) as! UITableView
        let indexOfCell = tblWall.indexPath(for: cell)
        print("Clicked Index : \(String(describing: indexOfCell?.row))")
        fetchIndexForUpload = -1
        fetchIndexForSubTankUpload = (indexOfCell?.row)!
        
        print("Upload Index : \(String(describing: fetchIndexForSubTankUpload))")
        
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
                    
                    managedObject.setValue(strNegativeEdgeOpt, forKey: "negativeOption")
                    managedObject.setValue(dataNegativeEdgeImg, forKey: "negativeImg")
                    managedObject.setValue(self.secEdge[Edge.nagative.rawValue].formTextValue, forKey: "negativeData")
                    managedObject.setValue(strBasinOpt, forKey: "basinOption")
                    managedObject.setValue(dataBasinImg, forKey: "basinImg")
                    managedObject.setValue(self.secEdge[Edge.basin.rawValue].formTextValue, forKey: "basinData")
                    managedObject.setValue(strDrainOpt, forKey: "drainOption")
                    managedObject.setValue(dataDrainImg, forKey: "drainImg")
                    managedObject.setValue(self.secEdge[Edge.drain.rawValue].formTextValue, forKey: "drainData")
                    managedObject.setValue(strTankOpt, forKey: "tankOption")
                    managedObject.setValue(dataTankImg, forKey: "tankImg")
                    managedObject.setValue(self.secEdge[Edge.tank.rawValue].formTextValue, forKey: "tankData")
                    managedObject.setValue(strEdge0Opt, forKey: "edge0Option")
                    managedObject.setValue(dataEdge0Img, forKey: "edge0Img")
                    managedObject.setValue(self.secSubNegative[Negative.edge0.rawValue].formTextValue, forKey: "edge0Data")
                    managedObject.setValue(strEdge1Opt, forKey: "edge1Option")
                    managedObject.setValue(dataEdge1Img, forKey: "edge1Img")
                    managedObject.setValue(self.secSubNegative[Negative.edge1.rawValue].formTextValue, forKey: "edge1Data")
                    managedObject.setValue(strBasin0Opt, forKey: "basin0Option")
                    managedObject.setValue(dataBasin0Img, forKey: "basin0Img")
                    managedObject.setValue(self.secSubBasin[Basin.basin0.rawValue].formTextValue, forKey: "basin0Data")
                    managedObject.setValue(strBasin1Opt, forKey: "basin1Option")
                    managedObject.setValue(dataBasin1Img, forKey: "basin1Img")
                    managedObject.setValue(self.secSubBasin[Basin.basin1.rawValue].formTextValue, forKey: "basin1Data")
                    managedObject.setValue(strBasin2Opt, forKey: "basin2Option")
                    managedObject.setValue(dataBasin2Img, forKey: "basin2Img")
                    managedObject.setValue(self.secSubBasin[Basin.basin2.rawValue].formTextValue, forKey: "basin2Data")
                    managedObject.setValue(strBasin3Opt, forKey: "basin3Option")
                    managedObject.setValue(dataBasin3Img, forKey: "basin3Img")
                    managedObject.setValue(self.secSubBasin[Basin.basin3.rawValue].formTextValue, forKey: "basin3Data")
                    managedObject.setValue(strBasin4Opt, forKey: "basin4Option")
                    managedObject.setValue(dataBasin4Img, forKey: "basin4Img")
                    managedObject.setValue(self.secSubBasin[Basin.basin4.rawValue].formTextValue, forKey: "basin4Data")
                    managedObject.setValue(strBasin5Opt, forKey: "basin5Option")
                    managedObject.setValue(dataBasin5Img, forKey: "basin5Img")
                    managedObject.setValue(self.secSubBasin[Basin.basin5.rawValue].formTextValue, forKey: "basin5Data")
                    managedObject.setValue(strDrain0Opt, forKey: "drain0Option")
                    managedObject.setValue(dataDrain0Img, forKey: "drain0Img")
                    managedObject.setValue(self.secSubDrain[Drain.drain0.rawValue].formTextValue, forKey: "drain0Data")
                    managedObject.setValue(strTank0Opt, forKey: "tank0Option")
                    managedObject.setValue(dataTank0Img, forKey: "tank0Img")
                    managedObject.setValue(self.secSubTank[Tank.tank0.rawValue].formTextValue, forKey: "tank0Data")
                    
                    
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
        //self.postInspectEdge()
        if UIDevice.current.userInterfaceIdiom == .phone {
            let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
            let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectWaterFeature") as! InspectWaterFeatureVC
            self.navigationController?.pushViewController(formVC, animated: true)
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
            let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectWaterFeature") as! InspectWaterFeatureVC
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
                        self.strNegativeEdgeImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 3 {
                        self.strBasinImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 5 {
                        self.strDrainImg = String(describing: data!)
                    } else if self.fetchIndexForUpload == 7 {
                        self.strTankImg = String(describing: data!)
                    }

                    if self.fetchIndexForSubEdgeUpload == 0 {
                        self.strEdge0Img = String(describing: data!)
                    } else if self.fetchIndexForSubEdgeUpload == 1 {
                        self.strEdge1Img = String(describing: data!)
                    }
                    if self.fetchIndexForSubBasinUpload == 0 {
                        self.strBasin0Img = String(describing: data!)
                    } else if self.fetchIndexForSubBasinUpload == 1 {
                        self.strBasin1Img = String(describing: data!)
                    } else if self.fetchIndexForSubBasinUpload == 2 {
                        self.strBasin2Img = String(describing: data!)
                    } else if self.fetchIndexForSubBasinUpload == 3 {
                        self.strBasin3Img = String(describing: data!)
                    } else if self.fetchIndexForSubBasinUpload == 4 {
                        self.strBasin4Img = String(describing: data!)
                    } else if self.fetchIndexForSubBasinUpload == 5 {
                        self.strBasin5Img = String(describing: data!)
                    }
                    if self.fetchIndexForSubDrainUpload == 0 {
                        self.strDrain0Img = String(describing: data!)
                    }
                    if self.fetchIndexForSubTankUpload == 0 {
                        self.strTank0Img = String(describing: data!)
                    }
                    SVProgressHUD.dismiss()
                }
            case .failure(let encodingError):
                print("error:\(encodingError)")
                SVProgressHUD.dismiss()
            }
        })
    }
    
    func postInspectEdge() {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        
        let return_id = UserDefaults.standard.value(forKey: "returnKeyForInspection")
        
        let inspectEdgeDetails:  NSMutableDictionary = [
            "return_data_id"    : return_id!,
            "negativeOption"    : strNegativeEdgeOpt,
            "negativeImg"       : strNegativeEdgeImg,
            "negativeData"      : self.secEdge[Edge.nagative.rawValue].formTextValue,
            "basinOption"       : strBasinOpt,
            "basinImg"          : strBasinImg,
            "basinData"         : self.secEdge[Edge.basin.rawValue].formTextValue,
            "drainOption"       : strDrainOpt,
            "drainImg"          : strDrainImg,
            "drainData"         : self.secEdge[Edge.drain.rawValue].formTextValue,
            "tankOption"        : strTankOpt,
            "tankImg"           : strTankImg,
            "tankData"          : self.secEdge[Edge.tank.rawValue].formTextValue,
            "edge0Option"       : strEdge0Opt,
            "edge0Img"          : strEdge0Img,
            "edge0Data"         : self.secSubNegative[Negative.edge0.rawValue].formTextValue,
            "edge1Option"       : strEdge1Opt,
            "edge1Img"          : strEdge1Img,
            "edge1Data"         : self.secSubNegative[Negative.edge1.rawValue].formTextValue,
            "basin0Option"      : strBasin0Opt,
            "basin0Img"         : strBasin0Img,
            "basin0Data"        : self.secSubBasin[Basin.basin0.rawValue].formTextValue,
            "basin1Option"      : strBasin1Opt,
            "basin1Img"         : strBasin1Img,
            "basin1Data"        : self.secSubBasin[Basin.basin1.rawValue].formTextValue,
            "basin2Option"      : strBasin2Opt,
            "basin2Img"         : strBasin2Img,
            "basin2Data"        : self.secSubBasin[Basin.basin2.rawValue].formTextValue,
            "basin3Option"      : strBasin3Opt,
            "basin3Img"         : strBasin3Img,
            "basin3Data"        : self.secSubBasin[Basin.basin3.rawValue].formTextValue,
            "basin4Option"      : strBasin4Opt,
            "basin4Img"         : strBasin4Img,
            "basin4Data"        : self.secSubBasin[Basin.basin4.rawValue].formTextValue,
            "basin5Option"      : strBasin5Opt,
            "basin5Img"         : strBasin5Img,
            "basin5Data"        : self.secSubBasin[Basin.basin5.rawValue].formTextValue,
            "drain0Option"      : strDrain0Opt,
            "drain0Img"         : strDrain0Img,
            "drain0Data"        : self.secSubDrain[Drain.drain0.rawValue].formTextValue,
            "tank0Option"       : strTank0Opt,
            "tank0Img"          : strTank0Img,
            "tank0Data"         : self.secSubTank[Tank.tank0.rawValue].formTextValue
        ]
        
        print("inspectEdgeDetails :: \(inspectEdgeDetails)")
        //if sharedExtension.connectedToNetwork() {
        ApiManager.sharedInstanceAPI.PostInspectEdge(postId: 1, edgeDetails: inspectEdgeDetails, onSuccess: { json in
            DispatchQueue.main.async {
                print("InspectionEdgeDetails json :: \(String(describing: json))")
                DispatchQueue.main.async(execute: {() -> Void in
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectWaterFeature") as! InspectWaterFeatureVC
                        self.navigationController?.pushViewController(formVC, animated: true)
                    } else if UIDevice.current.userInterfaceIdiom == .pad {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectWaterFeature") as! InspectWaterFeatureVC
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

extension InspectEdgeVC: OpalImagePickerControllerDelegate {
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
                                self.arrNegativeEdgeImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataNegativeEdgeImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 3 {
                                self.arrBasinImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataBasinImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 5 {
                                self.arrDrainImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataDrainImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 7 {
                                self.arrTankImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataTankImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            }
                            if self.fetchIndexForSubEdgeUpload == 0 {
                                self.arrEdge0Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataEdge0Img = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubEdgeUpload == 1 {
                                self.arrEdge1Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataEdge1Img = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            }
                            if self.fetchIndexForSubBasinUpload == 0 {
                                self.arrBasin0Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataBasin0Img = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubBasinUpload == 1 {
                                self.arrBasin1Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataBasin1Img = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubBasinUpload == 2 {
                                self.arrBasin2Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataBasin2Img = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubBasinUpload == 3 {
                                self.arrBasin3Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataBasin3Img = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubBasinUpload == 4 {
                                self.arrBasin4Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataBasin4Img = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubBasinUpload == 5 {
                                self.arrBasin5Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataBasin5Img = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            }
                            if self.fetchIndexForSubDrainUpload == 0 {
                                self.arrDrain0Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataDrain0Img = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            }
                            if self.fetchIndexForSubTankUpload == 0 {
                                self.arrTank0Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                self.dataTank0Img = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
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
                self.tblEdge.reloadData()
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


extension InspectEdgeVC: UIImagePickerControllerDelegate {
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
            self.arrNegativeEdgeImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataNegativeEdgeImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 3 {
            self.arrBasinImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataBasinImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 5 {
            self.arrDrainImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataDrainImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 7 {
            self.arrTankImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataTankImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        }
        if self.fetchIndexForSubEdgeUpload == 0 {
            self.arrEdge0Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataEdge0Img = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForSubEdgeUpload == 1 {
            self.arrEdge1Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataEdge1Img = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        }
        if self.fetchIndexForSubBasinUpload == 0 {
            self.arrBasin0Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataBasin0Img = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForSubBasinUpload == 1 {
            self.arrBasin1Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataBasin1Img = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForSubBasinUpload == 2 {
            self.arrBasin2Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataBasin2Img = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForSubBasinUpload == 3 {
            self.arrBasin3Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataBasin3Img = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForSubBasinUpload == 4 {
            self.arrBasin4Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataBasin4Img = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForSubBasinUpload == 5 {
            self.arrBasin5Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataBasin5Img = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        }
        if self.fetchIndexForSubDrainUpload == 0 {
            self.arrDrain0Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataDrain0Img = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        }
        if self.fetchIndexForSubTankUpload == 0 {
            self.arrTank0Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            self.dataTank0Img = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        }
        self.tblEdge.reloadData()
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
}

extension InspectEdgeVC: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        var cell = UITableViewCell()
        cell = (textView.superview?.superview as? UITableViewCell)!
        
        if let edgeTblCell = cell as? NegativeEdgeTableCell {
            if let textView = edgeTblCell.txtOther {
                self.secEdge[Edge.nagative.rawValue].formTextValue = (textView.text)!
            }
        } else if let basinTblCell = cell as? CatchBasinTableCell {
            if let textView = basinTblCell.txtOther {
                self.secEdge[Edge.basin.rawValue].formTextValue = (textView.text)!
            }
        } else if let drainTblCell = cell as? SlottedDrainTableCell {
            if let textView = drainTblCell.txtOther {
                self.secEdge[Edge.drain.rawValue].formTextValue = (textView.text)!
            }
        } else if let tankTblCell = cell as? InspectSurgeTankTableCell {
            if let textView = tankTblCell.txtOther {
                self.secEdge[Edge.tank.rawValue].formTextValue = (textView.text)!
            }
        }
        
        if let edgeTblCell = cell as? Edge0TableCell {
            if let textView = edgeTblCell.txtOther {
                self.secSubNegative[Negative.edge0.rawValue].formTextValue = (textView.text)!
            }
        } else if let edgeTblCell = cell as? Edge1TableCell {
            if let textView = edgeTblCell.txtOther {
                self.secSubNegative[Negative.edge1.rawValue].formTextValue = (textView.text)!
            }
        }
        if let basinTblCell = cell as? Basin0TableCell {
            if let textView = basinTblCell.txtOther {
                self.secSubBasin[Basin.basin0.rawValue].formTextValue = (textView.text)!
            }
        } else if let basinTblCell = cell as? Basin1TableCell {
            if let textView = basinTblCell.txtOther {
                self.secSubBasin[Basin.basin1.rawValue].formTextValue = (textView.text)!
            }
        } else if let basinTblCell = cell as? Basin2TableCell {
            if let textView = basinTblCell.txtOther {
                self.secSubBasin[Basin.basin2.rawValue].formTextValue = (textView.text)!
            }
        } else if let basinTblCell = cell as? Basin3TableCell {
            if let textView = basinTblCell.txtOther {
                self.secSubBasin[Basin.basin3.rawValue].formTextValue = (textView.text)!
            }
        } else if let basinTblCell = cell as? Basin4TableCell {
            if let textView = basinTblCell.txtOther {
                self.secSubBasin[Basin.basin4.rawValue].formTextValue = (textView.text)!
            }
        } else if let basinTblCell = cell as? Basin5TableCell {
            if let textView = basinTblCell.txtOther {
                self.secSubBasin[Basin.basin5.rawValue].formTextValue = (textView.text)!
            }
        }
        if let drainTblCell = cell as? Drain0TableCell {
            if let textView = drainTblCell.txtOther {
                self.secSubDrain[Drain.drain0.rawValue].formTextValue = (textView.text)!
            }
        }
        if let tankTblCell = cell as? Tank0TableCell {
            if let textView = tankTblCell.txtOther {
                self.secSubTank[Tank.tank0.rawValue].formTextValue = (textView.text)!
            }
        }
    }
}

extension InspectEdgeVC: UITableViewDataSource, UITableViewDelegate {
    //MARK:- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 25 {
            return 2
        } else if tableView.tag == 30 {
            return 6
        } else if tableView.tag == 35 {
            return 1
        } else if tableView.tag == 40 {
            return 1
        } else {
            return 9
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 25 {
            if indexPath.row == 0 {
                let edgeCell = tableView.dequeueReusableCell(withIdentifier: "Edge0Cell", for: indexPath) as! Edge0TableCell
                edgeCell.lblHeader.text = "Does the nagetive edge have proper safety netting or proper safety feature?"

                edgeCell.btnUpload.addTarget(self, action: #selector(btnEdgeImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                edgeCell.collectionVw.arrItems = arrEdge0Img
                edgeCell.collectionVw.delegateItemCollection = self
                edgeCell.collectionVw.reloadImageCollection()
                
                if arrEdge0Img.count > 0 {
                    edgeCell.btnUpload.isHidden = true
                    edgeCell.collectionVw.isHidden = false
                } else {
                    edgeCell.btnUpload.isHidden = false
                    edgeCell.collectionVw.isHidden = true
                }
                
                edgeCell.delegateEdge0 = self
                edgeCell.txtOther.delegate = self
                
                return edgeCell
            } else {
                let edgeCell = tableView.dequeueReusableCell(withIdentifier: "Edge1Cell", for: indexPath) as! Edge1TableCell
                edgeCell.lblHeader.text = "Does the nagetive edge have pose a diving hazard?"
                
                edgeCell.btnUpload.addTarget(self, action: #selector(btnEdgeImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                edgeCell.collectionVw.arrItems = arrEdge1Img
                edgeCell.collectionVw.delegateItemCollection = self
                edgeCell.collectionVw.reloadImageCollection()
                
                if arrEdge1Img.count > 0 {
                    edgeCell.btnUpload.isHidden = true
                    edgeCell.collectionVw.isHidden = false
                } else {
                    edgeCell.btnUpload.isHidden = false
                    edgeCell.collectionVw.isHidden = true
                }
                
                edgeCell.delegateEdge1 = self
                edgeCell.txtOther.delegate = self
                
                return edgeCell
            }
        } else if tableView.tag == 30 {
            if indexPath.row == 0 {
                let basinCell = tableView.dequeueReusableCell(withIdentifier: "Basin0Cell", for: indexPath) as! Basin0TableCell
                basinCell.lblHeader.text = "Is the catch basin adequately sized for the pool?"
                
                basinCell.btnUpload.addTarget(self, action: #selector(btnBasinImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                basinCell.collectionVw.arrItems = arrBasin0Img
                basinCell.collectionVw.delegateItemCollection = self
                basinCell.collectionVw.reloadImageCollection()
                
                if arrBasin0Img.count > 0 {
                    basinCell.btnUpload.isHidden = true
                    basinCell.collectionVw.isHidden = false
                } else {
                    basinCell.btnUpload.isHidden = false
                    basinCell.collectionVw.isHidden = true
                }
                
                basinCell.delegateBasin0 = self
                basinCell.txtOther.delegate = self
                
                return basinCell
            } else if indexPath.row == 1 {
                let basinCell = tableView.dequeueReusableCell(withIdentifier: "Basin1Cell", for: indexPath) as! Basin1TableCell
                basinCell.lblHeader.text = "Does catch basin have an autofill?"
                
                basinCell.btnUpload.addTarget(self, action: #selector(btnBasinImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                basinCell.collectionVw.arrItems = arrBasin1Img
                basinCell.collectionVw.delegateItemCollection = self
                basinCell.collectionVw.reloadImageCollection()
                
                if arrBasin1Img.count > 0 {
                    basinCell.btnUpload.isHidden = true
                    basinCell.collectionVw.isHidden = false
                } else {
                    basinCell.btnUpload.isHidden = false
                    basinCell.collectionVw.isHidden = true
                }
                
                basinCell.delegateBasin1 = self
                basinCell.txtOther.delegate = self
                
                return basinCell
            } else if indexPath.row == 2 {
                let basinCell = tableView.dequeueReusableCell(withIdentifier: "Basin2Cell", for: indexPath) as! Basin2TableCell
                basinCell.lblHeader.text = "Does catch basin autofill work properly?"
                
                basinCell.btnUpload.addTarget(self, action: #selector(btnBasinImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                basinCell.collectionVw.arrItems = arrBasin2Img
                basinCell.collectionVw.delegateItemCollection = self
                basinCell.collectionVw.reloadImageCollection()
                
                if arrBasin2Img.count > 0 {
                    basinCell.btnUpload.isHidden = true
                    basinCell.collectionVw.isHidden = false
                } else {
                    basinCell.btnUpload.isHidden = false
                    basinCell.collectionVw.isHidden = true
                }
                
                basinCell.delegateBasin2 = self
                basinCell.txtOther.delegate = self
                
                return basinCell
            } else if indexPath.row == 3 {
                let basinCell = tableView.dequeueReusableCell(withIdentifier: "Basin3Cell", for: indexPath) as! Basin3TableCell
                basinCell.lblHeader.text = "Does catch basin have a proper overflow?"
                
                basinCell.btnUpload.addTarget(self, action: #selector(btnBasinImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                basinCell.collectionVw.arrItems = arrBasin3Img
                basinCell.collectionVw.delegateItemCollection = self
                basinCell.collectionVw.reloadImageCollection()
                
                if arrBasin3Img.count > 0 {
                    basinCell.btnUpload.isHidden = true
                    basinCell.collectionVw.isHidden = false
                } else {
                    basinCell.btnUpload.isHidden = false
                    basinCell.collectionVw.isHidden = true
                }
                
                basinCell.delegateBasin3 = self
                basinCell.txtOther.delegate = self
                
                return basinCell
            } else if indexPath.row == 4 {
                let basinCell = tableView.dequeueReusableCell(withIdentifier: "Basin4Cell", for: indexPath) as! Basin4TableCell
                basinCell.lblHeader.text = "Are there any structures below the catch basin that can flood?"
                
                basinCell.btnUpload.addTarget(self, action: #selector(btnBasinImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                basinCell.collectionVw.arrItems = arrBasin4Img
                basinCell.collectionVw.delegateItemCollection = self
                basinCell.collectionVw.reloadImageCollection()
                
                if arrBasin4Img.count > 0 {
                    basinCell.btnUpload.isHidden = true
                    basinCell.collectionVw.isHidden = false
                } else {
                    basinCell.btnUpload.isHidden = false
                    basinCell.collectionVw.isHidden = true
                }
                
                basinCell.delegateBasin4 = self
                basinCell.txtOther.delegate = self
                
                return basinCell
            } else {
                let basinCell = tableView.dequeueReusableCell(withIdentifier: "Basin5Cell", for: indexPath) as! Basin5TableCell
                basinCell.lblHeader.text = "Is the catch basin free of cracks and leaks"
                
                basinCell.btnUpload.addTarget(self, action: #selector(btnBasinImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                basinCell.collectionVw.arrItems = arrBasin5Img
                basinCell.collectionVw.delegateItemCollection = self
                basinCell.collectionVw.reloadImageCollection()
                
                if arrBasin5Img.count > 0 {
                    basinCell.btnUpload.isHidden = true
                    basinCell.collectionVw.isHidden = false
                } else {
                    basinCell.btnUpload.isHidden = false
                    basinCell.collectionVw.isHidden = true
                }
                
                basinCell.delegateBasin5 = self
                basinCell.txtOther.delegate = self
                
                return basinCell
            }
        } else if tableView.tag == 35 {
            let drainCell = tableView.dequeueReusableCell(withIdentifier: "Drain0Cell", for: indexPath) as! Drain0TableCell
            drainCell.lblHeader.text = "Does the slotted drain allow access for visual inspection of the catch trough?"
            
            drainCell.lblYes.text = "Yes, Looked waterproofed and structurally sound"
            drainCell.lblNo.text = "No, unable to gain access due to design and could not check for any leaks whatsoever"
            
            drainCell.btnUpload.addTarget(self, action: #selector(btnDrainImgUpload(_:)), for: UIControl.Event.touchUpInside)
            
            drainCell.collectionVw.arrItems = arrDrain0Img
            drainCell.collectionVw.delegateItemCollection = self
            drainCell.collectionVw.reloadImageCollection()
            
            if arrDrain0Img.count > 0 {
                drainCell.btnUpload.isHidden = true
                drainCell.collectionVw.isHidden = false
            } else {
                drainCell.btnUpload.isHidden = false
                drainCell.collectionVw.isHidden = true
            }
            
            drainCell.delegateDrain0 = self
            drainCell.txtOther.delegate = self
            
            return drainCell
        } else if tableView.tag == 40 {
            let tankCell = tableView.dequeueReusableCell(withIdentifier: "Tank0Cell", for: indexPath) as! Tank0TableCell
            
            tankCell.lblHeader.text = "Did a visual check show the surge tank being free of leaks?"
            
            tankCell.btnUpload.addTarget(self, action: #selector(btnTankImgUpload(_:)), for: UIControl.Event.touchUpInside)
            
            tankCell.collectionVw.arrItems = arrTank0Img
            tankCell.collectionVw.delegateItemCollection = self
            tankCell.collectionVw.reloadImageCollection()
            
            if arrTank0Img.count > 0 {
                tankCell.btnUpload.isHidden = true
                tankCell.collectionVw.isHidden = false
            } else {
                tankCell.btnUpload.isHidden = false
                tankCell.collectionVw.isHidden = true
            }
            
            tankCell.delegateTank0 = self
            tankCell.txtOther.delegate = self
            
            return tankCell
        } else {
            if indexPath.row == 1 {
                let edgeCell = tableView.dequeueReusableCell(withIdentifier: "NegativeEdgeCell", for: indexPath) as! NegativeEdgeTableCell
                
                edgeCell.lblHeader.text = "Does the pool/SPA have a negative edge?"
                
                edgeCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                edgeCell.collectionVw.arrItems = arrNegativeEdgeImg
                edgeCell.collectionVw.delegateItemCollection = self
                edgeCell.collectionVw.reloadImageCollection()
                
                if arrNegativeEdgeImg.count > 0 {
                    edgeCell.btnUpload.isHidden = true
                    edgeCell.collectionVw.isHidden = false
                } else {
                    edgeCell.btnUpload.isHidden = false
                    edgeCell.collectionVw.isHidden = true
                }
                
                if strNegativeEdgeOpt == "Yes" {
                    edgeCell.tblSubVw.delegate = self
                    edgeCell.tblSubVw.dataSource = self
                    
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        edgeCell.tblHeightConstraint.constant = 385+365
                    } else {
                        edgeCell.tblHeightConstraint.constant = 600*2
                    }
                    edgeCell.tblSubVw.reloadData()
                } else {
                    edgeCell.tblHeightConstraint.constant = 0
                }
                
                edgeCell.delegateEdge = self
                edgeCell.txtOther.delegate = self
                
                return edgeCell
            } else if indexPath.row == 3 {
                let edgeCell = tableView.dequeueReusableCell(withIdentifier: "CatchBasinCell", for: indexPath) as! CatchBasinTableCell
                
                edgeCell.lblHeader.text = "Does the pool have a catch basin?"
                
                edgeCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                edgeCell.collectionVw.arrItems = arrBasinImg
                edgeCell.collectionVw.delegateItemCollection = self
                edgeCell.collectionVw.reloadImageCollection()
                
                if arrBasinImg.count > 0 {
                    edgeCell.btnUpload.isHidden = true
                    edgeCell.collectionVw.isHidden = false
                } else {
                    edgeCell.btnUpload.isHidden = false
                    edgeCell.collectionVw.isHidden = true
                }
                
                if strBasinOpt == "Yes" {
                    edgeCell.tblSubVw.delegate = self
                    edgeCell.tblSubVw.dataSource = self
                    
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        edgeCell.tblHeightConstraint.constant = (365*5)+385
                    } else {
                        edgeCell.tblHeightConstraint.constant = (600*5)+600
                    }
                    edgeCell.tblSubVw.reloadData()
                } else {
                    edgeCell.tblHeightConstraint.constant = 0
                }
                
                edgeCell.delegateBasin = self
                edgeCell.txtOther.delegate = self
                
                return edgeCell
            } else if indexPath.row == 5 {
                let edgeCell = tableView.dequeueReusableCell(withIdentifier: "SlottedDrainCell", for: indexPath) as! SlottedDrainTableCell
                
                edgeCell.lblHeader.text = "Does the pool have a slotted drain?"
                
                edgeCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                edgeCell.collectionVw.arrItems = arrDrainImg
                edgeCell.collectionVw.delegateItemCollection = self
                edgeCell.collectionVw.reloadImageCollection()
                
                if arrDrainImg.count > 0 {
                    edgeCell.btnUpload.isHidden = true
                    edgeCell.collectionVw.isHidden = false
                } else {
                    edgeCell.btnUpload.isHidden = false
                    edgeCell.collectionVw.isHidden = true
                }
                
                if strDrainOpt == "Yes" {
                    edgeCell.tblSubVw.delegate = self
                    edgeCell.tblSubVw.dataSource = self
                    
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        edgeCell.tblHeightConstraint.constant = 420
                    } else {
                        edgeCell.tblHeightConstraint.constant = 600
                    }
                    edgeCell.tblSubVw.reloadData()
                } else {
                    edgeCell.tblHeightConstraint.constant = 0
                }
                
                edgeCell.delegateDrain = self
                edgeCell.txtOther.delegate = self
                
                return edgeCell
            } else if indexPath.row == 7 {
                let edgeCell = tableView.dequeueReusableCell(withIdentifier: "SurgeTankCell", for: indexPath) as! InspectSurgeTankTableCell
                
                edgeCell.lblHeader.text = "Does pool has a surge tank?"
                
                edgeCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                edgeCell.collectionVw.arrItems = arrTankImg
                edgeCell.collectionVw.delegateItemCollection = self
                edgeCell.collectionVw.reloadImageCollection()
                
                if arrTankImg.count > 0 {
                    edgeCell.btnUpload.isHidden = true
                    edgeCell.collectionVw.isHidden = false
                } else {
                    edgeCell.btnUpload.isHidden = false
                    edgeCell.collectionVw.isHidden = true
                }
                
                if strTankOpt == "Yes" {
                    edgeCell.tblSubVw.delegate = self
                    edgeCell.tblSubVw.dataSource = self
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        edgeCell.tblHeightConstraint.constant = 355*2
                    } else {
                        edgeCell.tblHeightConstraint.constant = 600
                    }
                    edgeCell.tblSubVw.reloadData()
                } else {
                    edgeCell.tblHeightConstraint.constant = 0
                }
                
                edgeCell.delegateTank = self
                edgeCell.txtOther.delegate = self
                
                return edgeCell
            } else if indexPath.row == 8 {
                let cellBtn = tableView.dequeueReusableCell(withIdentifier: "NextCell", for: indexPath) as! NextForm1TableCell
                
                cellBtn.btnNext.addTarget(self, action: #selector(btnNextDidTap), for: UIControl.Event.touchUpInside)
                return cellBtn
            } else {
                let headerView : UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "CustomHeaderCell")!
                
                let lblHeaderTitle = headerView.viewWithTag(10) as! UILabel
                lblHeaderTitle.textColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.2352941176, alpha: 1)
                
                // set this however is appropriate for your app's model
                if indexPath.row == 0 {
                    lblHeaderTitle.text = "Negative Edge"
                } else if indexPath.row == 2 {
                    lblHeaderTitle.text = "Catch Basin"
                } else if indexPath.row == 4 {
                    lblHeaderTitle.text = "Slotted Drain"
                } else if indexPath.row == 6 {
                    lblHeaderTitle.text = "Surge Tank"
                }

                return headerView
            }
        }
    }

    //MARK:- UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .phone {
            if tableView.tag == 25 {
                if indexPath.row == 0 {
                    return 355
                } else {//if indexPath.row == 1 {
                    return 335
                }
            } else if tableView.tag == 30 {
                if indexPath.row == 4 {
                    return 355
                } else {//if indexPath.row == 1 {
                    return 335
                }
            } else if tableView.tag == 35 {
                return 385
            } else if tableView.tag == 40 {
                return 335
            } else {
                if indexPath.row == 1 {
                    if strNegativeEdgeOpt == "Yes" {
                        return (355+335)+335
                    } else {
                        return 335
                    }
                } else if indexPath.row == 3 {
                    if strBasinOpt == "Yes" {
                        return ((335*4)+355)+335
                    } else {
                        return 335
                    }
                } else if indexPath.row == 5 {
                    if strDrainOpt == "Yes" {
                        return 385+345
                    } else {
                        return 335
                    }
                } else if indexPath.row == 7 {
                    if strTankOpt == "Yes" {
                        return 335+365
                    } else {
                        return 335
                    }
                } else if indexPath.row == 8 {
                    return 105
                } else {
                    return 65
                }
            }
        } else {            //.pad
            if tableView.tag == 25 {
                if indexPath.row == 0 {
                    return 600
                } else {//if indexPath.row == 1 {
                    return 600
                }
            } else if tableView.tag == 30 {
                if indexPath.row == 4 {
                    return 600
                } else {//if indexPath.row == 1 {
                    return 600
                }
            } else if tableView.tag == 35 {
                return 600
            } else if tableView.tag == 40 {
                return 600
            } else {
                if indexPath.row == 1 {
                    if strNegativeEdgeOpt == "Yes" {
                        return (615+(600*2))
                    } else {
                        return 615
                    }
                } else if indexPath.row == 3 {
                    if strBasinOpt == "Yes" {
                        return (600*6)+(615)
                    } else {
                        return 615
                    }
                } else if indexPath.row == 5 {
                    if strDrainOpt == "Yes" {
                        return 615+600
                    } else {
                        return 615
                    }
                } else if indexPath.row == 7 {
                    if strTankOpt == "Yes" {
                        return 615+600
                    } else {
                        return 615
                    }
                } else if indexPath.row == 8 {
                    return 175
                } else {
                    return 95
                }
            }
        }
    }
}

extension InspectEdgeVC: NegativeEdgeProtocol, CatchBasinProtocol, SlottedDrainProtocol, InspectSurgeTankProtocol, Edge0Protocol, Edge1Protocol, Basin0Protocol, Basin1Protocol, Basin2Protocol, Basin3Protocol, Basin4Protocol, Basin5Protocol, Drain0Protocol, Tank0Protocol {
    func didTapOnCellEdge(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strNegativeEdgeOpt = "Yes"
        } else if _btnDescribeTag == 1 {
            strNegativeEdgeOpt = "No"
        }
        self.tblEdge.reloadData()
    }
    
    func didTapOnCellBasin(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strBasinOpt = "Yes"
        } else if _btnDescribeTag == 1 {
            strBasinOpt = "No"
        }
        self.tblEdge.reloadData()
    }
    
    func didTapOnCellDrain(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strDrainOpt = "Yes"
        } else if _btnDescribeTag == 1 {
            strDrainOpt = "No"
        }
        self.tblEdge.reloadData()
    }
    
    func didTapOnCellTank(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strTankOpt = "Yes"
        } else if _btnDescribeTag == 1 {
            strTankOpt = "No"
        }
        self.tblEdge.reloadData()
    }
    
    func didTapOnCellEdge0(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strEdge0Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strTankOpt = "No"
        }
        self.tblEdge.reloadData()
    }
    
    func didTapOnCellEdge1(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strEdge1Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strEdge1Opt = "No"
        }
        self.tblEdge.reloadData()
    }
    
    func didTapOnCellBasin0(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strBasin0Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strBasin0Opt = "No"
        }
        self.tblEdge.reloadData()
    }
    
    func didTapOnCellBasin1(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strBasin1Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strBasin1Opt = "No"
        }
        self.tblEdge.reloadData()
    }
    
    func didTapOnCellBasin2(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strBasin2Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strBasin2Opt = "No"
        }
        self.tblEdge.reloadData()
    }
    
    func didTapOnCellBasin3(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strBasin3Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strBasin3Opt = "No"
        }
        self.tblEdge.reloadData()
    }
    
    func didTapOnCellBasin4(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strBasin4Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strBasin4Opt = "No"
        }
        self.tblEdge.reloadData()
    }
    
    func didTapOnCellBasin5(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strBasin5Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strBasin5Opt = "No"
        }
        self.tblEdge.reloadData()
    }
    
    func didTapOnCellDrain0(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strDrain0Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strDrain0Opt = "No"
        }
        self.tblEdge.reloadData()
    }
    
    func didTapOnCellTank0(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strTank0Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strTank0Opt = "No"
        }
        self.tblEdge.reloadData()
    }
}
