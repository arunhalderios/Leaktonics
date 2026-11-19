//
//  PlumberCommercialQuestionVC.swift
//  Leaktronics
//
//  Created by Abhishek Mullick on 07/04/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import CoreData
import DLRadioButton
import Alamofire
import SVProgressHUD
import Photos
import OpalImagePicker

//MARK: - View Controller Methods
class PlumberPhoneQuestionVC: UIViewController, UINavigationControllerDelegate, UploadCollectionProtocol {

    @IBOutlet weak var tblPlumberQuestion: UITableView!
    
    var plumberDetailsDict = [String : AnyObject]()
    var plumberDict = [String : AnyObject]()
    var strReport_id = String()
    var plumberType = String()
    
    var secPlumber1 = [formData]()
    
//    private var sectionIndex = -1
//    private var selectedRowIndex = -1
    
    enum PlumberPhone: Int {
        case propertyText = 0
        case storiesText = 1
        case findUsText = 2
        case callReasonText = 3
        case swimmingText = 4
        case residentText = 5
        case fireSuppressionText = 6
        case floorHeatingText = 7
        case buildingNumber = 8
    }
    
    //MARK:- Variable Declaration
    var propertyTypePlumber = String()
    var storiesTypePlumber = String()
    var findUsOptionPlumber = String()
    var reasonForCallPlumber = String()
    var swimmingOption = String()
    var residentialOption = String()
    var fireSuppressionOption = String()
    var floorHeating = String()
    var propertyTextValue = String()
    
    //For Images
    var arrPlumberImg: [CollectionImageObject] = []
    
    //For Image CoreData
    var dataPlumberImg = NSData()
    
    
    var imagePicker = UIImagePickerController()
    var picker:UIImagePickerController? = UIImagePickerController()
    
    var fetchIndexForUpload = Int()
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.prepareFormData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = UIColor.black
        self.navigationController?.title = "Plumber Leak Detection Report"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        if strReport_id == "" {

        } else {
            self.postReportDetailsEdit()
        }
    }
    
    func prepareFormData() {
        for _ in 0..<9 {
            let obj = formData()
            self.secPlumber1.append(obj)
        }
    }
    
    //MARK:- UploadCollectionProtocol
    func didTapOnCellItem(_indexpath: IndexPath, _imgUrl: String, _videoUrl: String) {
        
    }
    
    func didUpdateCellIndex(_indexpath: Int) {
        
    }
    
    //MARK:- Function
    func actionSheetPopUpForType() {
        let alert:UIAlertController = UIAlertController(title: "Choose Type", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        let comAction = UIAlertAction(title: "COMMERCIAL", style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.btnCommercialDidTap()
        }
        let nonComAction = UIAlertAction(title: "Non - COMMERCIAL", style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.btnNonCommercialDidTap()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
        }
        //picker?.delegate = self
        alert.addAction(comAction)
        alert.addAction(nonComAction)
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
        
       // alert.popoverPresentationController?.sourceView = self.view
        //------------------------
        // Present the controller
        //-------------------------
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.present(alert, animated: true, completion: nil)
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            if let popoverController = alert.popoverPresentationController {
                popoverController.sourceView = self.view
                popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                popoverController.permittedArrowDirections = []
            }
            self.present(alert, animated: true, completion: nil)
            // popover=UIPopoverController(contentViewController: alert)
        }
    }
    
    //MARK:- Method to Open camera
    func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            //self.strDetermineCameraOrMedia = "camera"
            picker!.sourceType = UIImagePickerController.SourceType.camera
            picker!.delegate = self
            //picker!.mediaTypes = ["public.movie"]
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
    
    //MARK:- Method to Open Gallery
    func openGallary() {
        let imagePicker = OpalImagePickerController()
        imagePicker.imagePickerDelegate = self
        imagePicker.maximumSelectionsAllowed = 2
        present(imagePicker, animated: true, completion: nil)
    }
    
    //MARK:- @objc Function
    @objc func btnCommercialDidTap() {
        if UIDevice.current.userInterfaceIdiom == .phone {
            let storyBoard : UIStoryboard = UIStoryboard(name: "PlumberLeak", bundle:nil)
            let formVC = storyBoard.instantiateViewController(withIdentifier: "CommercialLeakDetection") as! CommercialLeakDetectionVC
            formVC.isPlumberType = "Commercial"
            self.navigationController?.pushViewController(formVC, animated: true)
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            let storyBoard : UIStoryboard = UIStoryboard(name: "PlumberLeak_iPad", bundle:nil)
            let formVC = storyBoard.instantiateViewController(withIdentifier: "CommercialLeakDetection") as! CommercialLeakDetectionVC
            formVC.isPlumberType = "Commercial"
            self.navigationController?.pushViewController(formVC, animated: true)
        }
    }
    
    @objc func btnNonCommercialDidTap() {
        if UIDevice.current.userInterfaceIdiom == .phone {
            let storyBoard : UIStoryboard = UIStoryboard(name: "PlumberLeak", bundle:nil)
            let formVC = storyBoard.instantiateViewController(withIdentifier: "NonCommercialLeakDetection") as! NonCommercialLeakDetectionVC
            self.navigationController?.pushViewController(formVC, animated: true)
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            let storyBoard : UIStoryboard = UIStoryboard(name: "PlumberLeak_iPad", bundle:nil)
            let formVC = storyBoard.instantiateViewController(withIdentifier: "NonCommercialLeakDetection") as! NonCommercialLeakDetectionVC
            formVC.isPlumberType = "Non - COMMERCIAL"
            self.navigationController?.pushViewController(formVC, animated: true)
        }
    }
    
    @objc func btnClickedUpload(_ sender: Any) {
        print("Button pressed 👍 ")
        let btn = sender as! UIButton
        let cell = btn.superview?.superview?.superview as! UITableViewCell
        let indexOfCell = self.tblPlumberQuestion.indexPath(for: cell)
        fetchIndexForUpload = (indexOfCell?.row)!
        print("Upload Index : \(String(describing: fetchIndexForUpload))")
        
        self.actionSheetPopUpForGalleryOpen()
    }
    
    @objc func btnNextDidTap() {
        if plumberType == ""{
            let alert = UIAlertController(title: "Alert", message: "Please select Property Type", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
              case .cancel:
                    print("cancel")
              case .destructive:
                    print("destructive")
              case .default:
                break
              @unknown default: break
            }}))
            self.present(alert, animated: true, completion: nil)
        } else {
            self.updateCoreData(strReport_id: strReport_id)
            //self.checkNetwork()
            let isFrom: Bool = UserDefaults.standard.bool(forKey: "isFromReportList")
            if isFrom == true {
                self.postPlumberPhoneQuestionnaireUpdate()
            } else {
                self.postPlumberPhoneQuestionnaire()
            }
        }
        //self.actionSheetPopUpForType()
    }
     
    //MARK:- CoreData
    func updateCoreData(strReport_id: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Plumber2_CoreData")
        
        //let userName: String = UserDefaults.standard.value(forKey: "PoolDetectionUserName") as! String
        let predicate = NSPredicate(format: "%K == %@", "report_id", strReport_id)
        fetchRequest.predicate = predicate
        
        do {
            let reportResult = try managedContext.fetch(fetchRequest) as! [Plumber2_CoreData]
            print("Report Data\(reportResult) and count is \(reportResult.count)")
            
            if reportResult.count == 0 {
                print ("Inserting DB")
                
                //For data fetch in coredata
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Plumber2_CoreData")
                fetchRequest.returnsObjectsAsFaults = false
                
                let predicate = NSPredicate(format: "%K == %@", "report_id", strReport_id)
                fetchRequest.predicate = predicate
                
                let  rs = try managedContext.fetch(fetchRequest)
                for _ in rs as [NSManagedObject] {
                    // update
                    do {
                        let managedObject = rs[0]
                        
                        managedObject.setValue(self.plumberDict["report_id"], forKey: "report_id")
                        managedObject.setValue(plumberDict["propertyTypePlumber"], forKey: "propertyTypePlumber")
                        managedObject.setValue(plumberDict["propertyImg"], forKey: "propertyImg")
                        managedObject.setValue(plumberDict["storiesTypePlumber"], forKey: "storiesTypePlumber")
                        managedObject.setValue(plumberDict["findUsOptionPlumber"], forKey: "findUsOptionPlumber")
                        managedObject.setValue(plumberDict["reasonForCallPlumber"], forKey: "reasonForCallPlumber")
                        managedObject.setValue(plumberDict["swimmingOption"], forKey: "swimmingOption")
                        managedObject.setValue(plumberDict["residentialOption"], forKey: "residentialOption")
                        managedObject.setValue(plumberDict["fireSuppressionOption"], forKey: "fireSuppressionOption")
                        managedObject.setValue(plumberDict["floorHeating"], forKey: "floorHeating")
                        managedObject.setValue(plumberDict["plumberPropertyText"], forKey: "plumberPropertyText")
                        managedObject.setValue(plumberDict["plumberStoriesText"], forKey: "plumberStoriesText")
                        managedObject.setValue(plumberDict["plumberFindUsText"], forKey: "plumberFindUsText")
                        managedObject.setValue(plumberDict["plumberCallReasonText"], forKey: "plumberCallReasonText")
                        managedObject.setValue(plumberDict["plumberSwimmingText"], forKey: "plumberSwimmingText")
                        managedObject.setValue(plumberDict["plumberResidentText"], forKey: "plumberResidentText")
                        managedObject.setValue(plumberDict["plumberfireSuppressionText"], forKey: "plumberfireSuppressionText")
                        managedObject.setValue(plumberDict["numberOfBuilding"], forKey: "numberOfBuilding")
                        
                        try managedContext.save()
                        print("update successfull")
                    } catch let error as NSError {
                        print("Could not Update. \(error), \(error.userInfo)")
                    }
                    //end update
                }
                do {
                    try managedContext.save()
                    UserDefaults.standard.set(self.plumberDict["namePoolDetection"], forKey: "PoolDetectionUserName")
                    print("Inserted")
                } catch let error as NSError {
                    print(error)
                }
            } else {
                print ("Updating DB")
                //For data fetch in coredata
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Plumber2_CoreData")
                fetchRequest.returnsObjectsAsFaults = false
                
                let predicate = NSPredicate(format: "%K == %@", "report_id", strReport_id)
                fetchRequest.predicate = predicate
                
                let  rs = try managedContext.fetch(fetchRequest)
                for _ in rs as [NSManagedObject] {
                    // update
                    do {
                        let managedObject = rs[0]
                        
                        managedObject.setValue(strReport_id, forKey: "report_id")
                        managedObject.setValue(propertyTypePlumber, forKey: "propertyTypePlumber")
                        managedObject.setValue(dataPlumberImg, forKey: "propertyImg")
                        managedObject.setValue(storiesTypePlumber, forKey: "storiesTypePlumber")
                        managedObject.setValue(findUsOptionPlumber, forKey: "findUsOptionPlumber")
                        managedObject.setValue(reasonForCallPlumber, forKey: "reasonForCallPlumber")
                        managedObject.setValue(swimmingOption, forKey: "swimmingOption")
                        managedObject.setValue(residentialOption, forKey: "residentialOption")
                        managedObject.setValue(fireSuppressionOption, forKey: "fireSuppressionOption")
                        managedObject.setValue(floorHeating, forKey: "floorHeating")
                        managedObject.setValue(self.secPlumber1[PlumberPhone.propertyText.rawValue].formTextValue, forKey: "plumberPropertyText")
                        managedObject.setValue(self.secPlumber1[PlumberPhone.storiesText.rawValue].formTextValue, forKey: "plumberStoriesText")
                        managedObject.setValue(self.secPlumber1[PlumberPhone.findUsText.rawValue].formTextValue, forKey: "plumberFindUsText")
                        managedObject.setValue(self.secPlumber1[PlumberPhone.callReasonText.rawValue].formTextValue, forKey: "plumberCallReasonText")
                        managedObject.setValue(self.secPlumber1[PlumberPhone.swimmingText.rawValue].formTextValue, forKey: "plumberSwimmingText")
                        managedObject.setValue(self.secPlumber1[PlumberPhone.residentText.rawValue].formTextValue, forKey: "plumberResidentText")
                        managedObject.setValue(self.secPlumber1[PlumberPhone.fireSuppressionText.rawValue].formTextValue, forKey: "plumberfireSuppressionText")
                        managedObject.setValue(self.secPlumber1[PlumberPhone.buildingNumber.rawValue].formTextValue, forKey: "numberOfBuilding")
                        
                        
                        try managedContext.save()
                        print("update successfull")
                    } catch let error as NSError {
                        print("Could not Update. \(error), \(error.userInfo)")
                    }
                    //end update
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    //MARK:- Move
    func movePage() {
        if plumberType == "Non - COMMERCIAL" {
            if UIDevice.current.userInterfaceIdiom == .phone {
                let storyBoard : UIStoryboard = UIStoryboard(name: "PlumberLeak", bundle:nil)
                let formVC = storyBoard.instantiateViewController(withIdentifier: "NonCommercialLeakDetection") as! NonCommercialLeakDetectionVC
                formVC.strReport_id = self.strReport_id
                formVC.isPlumberType = "Non - COMMERCIAL"
                self.navigationController?.pushViewController(formVC, animated: true)
            } else if UIDevice.current.userInterfaceIdiom == .pad {
                let storyBoard : UIStoryboard = UIStoryboard(name: "PlumberLeak_iPad", bundle:nil)
                let formVC = storyBoard.instantiateViewController(withIdentifier: "NonCommercialLeakDetection") as! NonCommercialLeakDetectionVC
                formVC.strReport_id = self.strReport_id
                formVC.isPlumberType = "Non - COMMERCIAL"
                self.navigationController?.pushViewController(formVC, animated: true)
            }
        } else if plumberType == "COMMERCIAL" {
            if UIDevice.current.userInterfaceIdiom == .phone {
                let storyBoard : UIStoryboard = UIStoryboard(name: "PlumberLeak", bundle:nil)
                let formVC = storyBoard.instantiateViewController(withIdentifier: "CommercialLeakDetection") as! CommercialLeakDetectionVC
                formVC.strReport_id = self.strReport_id
                formVC.isPlumberType = "COMMERCIAL"
                self.navigationController?.pushViewController(formVC, animated: true)
            } else if UIDevice.current.userInterfaceIdiom == .pad {
                let storyBoard : UIStoryboard = UIStoryboard(name: "PlumberLeak_iPad", bundle:nil)
                let formVC = storyBoard.instantiateViewController(withIdentifier: "CommercialLeakDetection") as! CommercialLeakDetectionVC
                formVC.strReport_id = self.strReport_id
                formVC.isPlumberType = "COMMERCIAL"
                self.navigationController?.pushViewController(formVC, animated: true)
            }
        }
    }
    //MARK:: Function Api Calling
    func postReportDetailsEdit() {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        
        let editDetails: NSMutableDictionary = [
            "report_id" : strReport_id,
            "type"        : "Plumbing Leak Detection"
        ]
        
        print("editDetails :: \(editDetails)")
        //if sharedExtension.connectedToNetwork() {
        ApiManager.sharedInstanceAPI.PostReportDetailsEdit(postId: 1, reportDetailsEdit: editDetails, onSuccess: { json in
            DispatchQueue.main.async {
                print("PoolDetectionDetailsEdit json :: \(String(describing: json))")
                //let poolDetectDict = (json["data"] as AnyObject) as! [String : AnyObject]
                
                self.plumberDetailsDict = (json["data"] as AnyObject) as! [String : AnyObject]
                let strPlumberData: String = String(describing: self.plumberDetailsDict["page_2"]!)
                if strPlumberData != "<null>" {
                    self.plumberDict = self.plumberDetailsDict["page_2"] as! [String : AnyObject]
                }
                print("plumberDict_2::\(self.plumberDict)")
                self.updateCoreData(strReport_id: self.strReport_id)
                self.tblPlumberQuestion.reloadData()
                SVProgressHUD.dismiss()
            }
        }, onFailure: { error in
            DispatchQueue.main.sync(execute: {() -> Void in
                SVProgressHUD.dismiss()
                print("Error Message::\(error)")
                let alert = UIAlertController(title: "", message: error["message"] as? String, preferredStyle: .alert)
                let dismissAction = UIAlertAction(title: "OK", style: .default) { (_) -> Void in
                    DispatchQueue.main.async(execute: {() -> Void in
                        
                    })
                }
                alert.addAction(dismissAction)
                self.present(alert, animated: true, completion: nil)
            })
        })
    }
    /*func setPostImage(arrOfImages: [UIImage]) {
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
                let imageData = image.jpegData(compressionQuality: 1.0)
                multipartFormData.append(imageData!, withName: "files[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
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
                        self.propertyImg = String(describing: data!)
                    }
                    SVProgressHUD.dismiss()
                }
            case .failure(let encodingError):
                    print("error:\(encodingError)")
                    SVProgressHUD.dismiss()
                }
            })
    }*/
    func postPlumberPhoneQuestionnaire() {
        self.view.endEditing(true)
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        let token: String = UserDefaults.standard.value(forKey: "key_token") as! String
        
        let headers = [
            "Authorization": token,
            //"Content-Type": "application/x-www-form-urlencoded"
        ]
        
        let url = ServiceConstant.BASE_URL.appending(ServiceConstant.PostPlumberPhoneQuestionnaire)
        print("PlumberPhoneQuestionnaireDetails URL:: \(url)")
        
        let plumberDetails: NSMutableDictionary = [
            "return_data_id"             : strReport_id,
            "propertyTypePlumber"        : propertyTypePlumber,
            //"property_Image"               : ,
            "storiesTypePlumber"         : storiesTypePlumber,
            "findUsOptionPlumber"        : findUsOptionPlumber,
            "reasonForCallPlumber"       : reasonForCallPlumber,
            "swimmingOption"             : swimmingOption,
            "residentialOption"          : residentialOption,
            "fireSuppressionOption"      : fireSuppressionOption,
            "floorHeating"               : floorHeating,
            "plumberPropertyText"        : self.secPlumber1[PlumberPhone.propertyText.rawValue].formTextValue,
            "plumberStoriesText"         : self.secPlumber1[PlumberPhone.storiesText.rawValue].formTextValue,
            "plumberFindUsText"          : self.secPlumber1[PlumberPhone.findUsText.rawValue].formTextValue,
            "plumberCallReasonText"      : self.secPlumber1[PlumberPhone.callReasonText.rawValue].formTextValue,
            "plumberSwimmingText"        : self.secPlumber1[PlumberPhone.swimmingText.rawValue].formTextValue,
            "plumberResidentText"        : self.secPlumber1[PlumberPhone.residentText.rawValue].formTextValue,
            "plumberfireSuppressionText" : self.secPlumber1[PlumberPhone.fireSuppressionText.rawValue].formTextValue,
            "numberOfBuilding"              : self.secPlumber1[PlumberPhone.buildingNumber.rawValue].formTextValue,
            "plumber_type"                  : plumberType
        ]
        
        print(plumberDetails)
        Alamofire.upload(multipartFormData: { multipartFormData in
            if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.dataPlumberImg as! Data) as? NSArray {
                //extract data..
                print(mySavedData)
                let arrImgs = mySavedData as! [UIImage]
                for image in arrImgs {
                    let imageData = image.jpegData(compressionQuality: 1.0)
                    multipartFormData.append(imageData!, withName: "property_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                }
            }
            for (key, value) in plumberDetails {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key as! String)
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
                    
                    if ((json["status"]  as! Int) == 1) {
                        self.movePage()
                    }
                    SVProgressHUD.dismiss()
                }
            case .failure(let encodingError):
                print("error:\(encodingError)")
                SVProgressHUD.dismiss()
            }
        })
    }
    func postPlumberPhoneQuestionnaireUpdate() {
        self.view.endEditing(true)
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        let token: String = UserDefaults.standard.value(forKey: "key_token") as! String
        
        let headers = [
            "Authorization": token,
            //"Content-Type": "application/x-www-form-urlencoded"
        ]
        
        let urlString = ServiceConstant.BASE_URL.appending(ServiceConstant.PostPlumberPhoneQuestionnaireUpdate)
        print("PlumberPhoneQuestionnaireDetails URL:: \(urlString)")
        
        let myUrl = URL(string: urlString)
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "POST"
        request.timeoutInterval = 120
        
        let plumberDetails: NSMutableDictionary = [
            "return_data_id"             : strReport_id,
            "report_id"                     : strReport_id,
            "propertyTypePlumber"        : propertyTypePlumber,
            //"property_Image"               : ,
            "storiesTypePlumber"         : storiesTypePlumber,
            "findUsOptionPlumber"        : findUsOptionPlumber,
            "reasonForCallPlumber"       : reasonForCallPlumber,
            "swimmingOption"             : swimmingOption,
            "residentialOption"          : residentialOption,
            "fireSuppressionOption"      : fireSuppressionOption,
            "floorHeating"               : floorHeating,
            "plumberPropertyText"        : self.secPlumber1[PlumberPhone.propertyText.rawValue].formTextValue,
            "plumberStoriesText"         : self.secPlumber1[PlumberPhone.storiesText.rawValue].formTextValue,
            "plumberFindUsText"          : self.secPlumber1[PlumberPhone.findUsText.rawValue].formTextValue,
            "plumberCallReasonText"      : self.secPlumber1[PlumberPhone.callReasonText.rawValue].formTextValue,
            "plumberSwimmingText"        : self.secPlumber1[PlumberPhone.swimmingText.rawValue].formTextValue,
            "plumberResidentText"        : self.secPlumber1[PlumberPhone.residentText.rawValue].formTextValue,
            "plumberfireSuppressionText" : self.secPlumber1[PlumberPhone.fireSuppressionText.rawValue].formTextValue,
            "numberOfBuilding"              : self.secPlumber1[PlumberPhone.buildingNumber.rawValue].formTextValue,
            "plumber_type"                  : plumberType
        ]
        
        print(plumberDetails)
        Alamofire.upload(multipartFormData: { multipartFormData in
            if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: self.dataPlumberImg as! Data) as? NSArray {
                //extract data..
                print(mySavedData)
                let arrImgs = mySavedData as! [UIImage]
                for image in arrImgs {
                    let imageData = image.jpegData(compressionQuality: 1.0)
                    multipartFormData.append(imageData!, withName: "property_Image[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                }
            }
            for (key, value) in plumberDetails {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key as! String)
            }
        }, to: urlString,
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
                    
                    if ((json["status"]  as! Int) == 1) {
                        self.movePage()
                    }
                    SVProgressHUD.dismiss()
                }
            case .failure(let encodingError):
                print("error:\(encodingError)")
                SVProgressHUD.dismiss()
            }
        })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension PlumberPhoneQuestionVC: UITableViewDelegate, UITableViewDataSource {
    //MARK:- Tableview Delegate/Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlumberPhoneQuestionCell", for: indexPath) as! PlumberPhoneQuestionTableCell
        
        cell.btnUploadOutlet.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
        cell.collectionVw.arrItems = arrPlumberImg
        
        if plumberDict.count > 0 {
            //property
            if String(describing: plumberDict["propertyTypePlumber"]!) == "Single Family House / Multifamily House" {
                self.propertyTypePlumber = "Single Family House / Multifamily House"
                self.plumberType = "Non - COMMERCIAL"
                cell.imgProperty0.image = UIImage(named: "checkmark")
                cell.imgProperty1.image = UIImage(named: "unchecked")
                cell.imgProperty2.image = UIImage(named: "unchecked")
                
                self.secPlumber1[PlumberPhone.propertyText.rawValue].formTextValue = ""
                cell.vwOtherText.text = ""
            } else if String(describing: plumberDict["propertyTypePlumber"]!) == "Commercial Building" {
                self.propertyTypePlumber = "Commercial Building"
                self.plumberType = "COMMERCIAL"
                cell.imgProperty0.image = UIImage(named: "unchecked")
                cell.imgProperty1.image = UIImage(named: "checkmark")
                cell.imgProperty2.image = UIImage(named: "unchecked")

                self.secPlumber1[PlumberPhone.propertyText.rawValue].formTextValue = ""
                cell.vwOtherText.text = ""
            } else if String(describing: plumberDict["propertyTypePlumber"]!) == "Other" {
                self.propertyTypePlumber = "Other"
                self.plumberType = "Non - COMMERCIAL"
                cell.imgProperty0.image = UIImage(named: "unchecked")
                cell.imgProperty1.image = UIImage(named: "unchecked")
                cell.imgProperty2.image = UIImage(named: "checkmark")

                self.secPlumber1[PlumberPhone.propertyText.rawValue].formTextValue = String(describing: plumberDict["plumberPropertyText"]!)
                cell.vwOtherText.text = String(describing: plumberDict["plumberPropertyText"]!)
            }
            
            
            if (self.plumberDict["property_Image"]! as! [String]).count > 0 {
                let imgArr = self.plumberDict["property_Image"]! as! [String]
                cell.collectionVw.arrImgs = imgArr
                if imgArr.count > 0 {
                    cell.btnUploadOutlet.isHidden = true
                    cell.collectionVw.isHidden = false
                } else {
                    cell.btnUploadOutlet.isHidden = false
                    cell.collectionVw.isHidden = true
                }
            } else {
                cell.collectionVw.arrItems = arrPlumberImg
                if arrPlumberImg.count > 0 {
                    cell.btnUploadOutlet.isHidden = true
                    cell.collectionVw.isHidden = false
                } else {
                    cell.btnUploadOutlet.isHidden = false
                    cell.collectionVw.isHidden = true
                }
            }
            
            cell.collectionVw.isEdit = true
            cell.collectionVw.delegateItemCollection = self
            cell.collectionVw.reloadImageCollection()
            //stories
            if String(describing: plumberDict["storiesTypePlumber"]!) == "Single Level" {
                self.storiesTypePlumber = "Single Level"
                cell.imgStoriesOptn0.image = UIImage(named: "checkmark")
                cell.imgStoriesOptn1.image = UIImage(named: "unchecked")
                cell.imgStoriesOptn2.image = UIImage(named: "unchecked")
                cell.imgStoriesOptn3.image = UIImage(named: "unchecked")
            } else if String(describing: plumberDict["storiesTypePlumber"]!) == "Multi Level" {
                self.storiesTypePlumber = "Multi Level"
                cell.imgStoriesOptn0.image = UIImage(named: "unchecked")
                cell.imgStoriesOptn1.image = UIImage(named: "checkmark")
                cell.imgStoriesOptn2.image = UIImage(named: "unchecked")
                cell.imgStoriesOptn3.image = UIImage(named: "unchecked")
            } else if String(describing: plumberDict["storiesTypePlumber"]!) == "Basement" {
                self.storiesTypePlumber = "Basement"
                cell.imgStoriesOptn0.image = UIImage(named: "unchecked")
                cell.imgStoriesOptn1.image = UIImage(named: "unchecked")
                cell.imgStoriesOptn2.image = UIImage(named: "checkmark")
                cell.imgStoriesOptn3.image = UIImage(named: "unchecked")
            } else if String(describing: plumberDict["storiesTypePlumber"]!) == "Other (if any air noted, describe)" {
                self.storiesTypePlumber = "Other (if any air noted, describe)"
                cell.imgStoriesOptn0.image = UIImage(named: "unchecked")
                cell.imgStoriesOptn1.image = UIImage(named: "unchecked")
                cell.imgStoriesOptn2.image = UIImage(named: "unchecked")
                cell.imgStoriesOptn3.image = UIImage(named: "checkmark")
            }
            
            self.secPlumber1[PlumberPhone.storiesText.rawValue].formTextValue = String(describing: plumberDict["plumberStoriesText"]!)
            cell.vwStoriesText.text = String(describing: plumberDict["plumberStoriesText"]!)
            
            //findus
            if String(describing: plumberDict["findUsOptionPlumber"]!) == "Existing customer (used our services in the past)" {
                self.findUsOptionPlumber = "Existing customer (used our services in the past)"
                cell.imgFindUsOptn0.image = UIImage(named: "checkmark")
                cell.imgFindUsOptn1.image = UIImage(named: "unchecked")
                cell.imgFindUsOptn2.image = UIImage(named: "unchecked")
            } else if String(describing: plumberDict["findUsOptionPlumber"]!) == "Online" {
                self.findUsOptionPlumber = "Online"
                cell.imgFindUsOptn0.image = UIImage(named: "unchecked")
                cell.imgFindUsOptn1.image = UIImage(named: "checkmark")
                cell.imgFindUsOptn2.image = UIImage(named: "unchecked")
            } else if String(describing: plumberDict["findUsOptionPlumber"]!) == "Other" {
                self.findUsOptionPlumber = "Other"
                cell.imgFindUsOptn0.image = UIImage(named: "unchecked")
                cell.imgFindUsOptn1.image = UIImage(named: "unchecked")
                cell.imgFindUsOptn2.image = UIImage(named: "checkmark")
            }
            self.secPlumber1[PlumberPhone.findUsText.rawValue].formTextValue = String(describing: plumberDict["plumberFindUsText"]!)
            cell.vwFindText.text = String(describing: plumberDict["plumberFindUsText"]!)
            
            //reasonForCall
            if String(describing: plumberDict["reasonForCallPlumber"]!) == "Present water damage" {
                self.reasonForCallPlumber = "Present water damage"
                cell.imgReasonOptn0.image = UIImage(named: "checkmark")
                cell.imgReasonOptn1.image = UIImage(named: "unchecked")
                cell.imgReasonOptn2.image = UIImage(named: "unchecked")
                cell.imgReasonOptn3.image = UIImage(named: "unchecked")
                cell.imgReasonOptn4.image = UIImage(named: "unchecked")
            } else if String(describing: plumberDict["reasonForCallPlumber"]!) == "High water bill" {
                self.reasonForCallPlumber = "High water bill"
                cell.imgReasonOptn0.image = UIImage(named: "unchecked")
                cell.imgReasonOptn1.image = UIImage(named: "checkmark")
                cell.imgReasonOptn2.image = UIImage(named: "unchecked")
                cell.imgReasonOptn3.image = UIImage(named: "unchecked")
                cell.imgReasonOptn4.image = UIImage(named: "unchecked")
            } else if String(describing: plumberDict["reasonForCallPlumber"]!) == "Pooling water on property" {
                self.reasonForCallPlumber = "Pooling water on property"
                cell.imgReasonOptn0.image = UIImage(named: "unchecked")
                cell.imgReasonOptn1.image = UIImage(named: "unchecked")
                cell.imgReasonOptn2.image = UIImage(named: "checkmark")
                cell.imgReasonOptn3.image = UIImage(named: "unchecked")
                cell.imgReasonOptn4.image = UIImage(named: "unchecked")
            } else if String(describing: plumberDict["reasonForCallPlumber"]!) == "Losing pressure" {
                self.reasonForCallPlumber = "Losing pressure"
                cell.imgReasonOptn0.image = UIImage(named: "unchecked")
                cell.imgReasonOptn1.image = UIImage(named: "unchecked")
                cell.imgReasonOptn2.image = UIImage(named: "unchecked")
                cell.imgReasonOptn3.image = UIImage(named: "checkmark")
                cell.imgReasonOptn4.image = UIImage(named: "unchecked")
            } else if String(describing: plumberDict["reasonForCallPlumber"]!) == "Other" {
                self.reasonForCallPlumber = "Other"
                cell.imgReasonOptn0.image = UIImage(named: "unchecked")
                cell.imgReasonOptn1.image = UIImage(named: "unchecked")
                cell.imgReasonOptn2.image = UIImage(named: "unchecked")
                cell.imgReasonOptn3.image = UIImage(named: "unchecked")
                cell.imgReasonOptn4.image = UIImage(named: "checkmark")
            }
            self.secPlumber1[PlumberPhone.callReasonText.rawValue].formTextValue = String(describing: plumberDict["plumberCallReasonText"]!)
            cell.vwCallReasonText.text = String(describing: plumberDict["plumberCallReasonText"]!)
            
            //numberOfBuilding
            self.secPlumber1[PlumberPhone.buildingNumber.rawValue].formTextValue = String(describing: plumberDict["numberOfBuilding"]!)
            cell.txtNumberofBuilding.text = String(describing: plumberDict["numberOfBuilding"]!)
            
            //swimming
            if String(describing: plumberDict["swimmingOption"]!) == "Yes" {
                self.swimmingOption = "Yes"
                cell.imgSwimmingOptn0.image = UIImage(named: "checkmark")
                cell.imgSwimmingOptn1.image = UIImage(named: "unchecked")
            } else if String(describing: plumberDict["swimmingOption"]!) == "No" {
                self.swimmingOption = "No"
                cell.imgSwimmingOptn0.image = UIImage(named: "unchecked")
                cell.imgSwimmingOptn1.image = UIImage(named: "checkmark")
            }
            self.secPlumber1[PlumberPhone.swimmingText.rawValue].formTextValue = String(describing: plumberDict["plumberSwimmingText"]!)
            cell.vwSwimmingText.text = String(describing: plumberDict["plumberSwimmingText"]!)
            
            //Resident
            if String(describing: plumberDict["residentialOption"]!) == "Guest house" {
                self.residentialOption = "Guest house"
                cell.imgResidentOptn0.image = UIImage(named: "checkmark")
                cell.imgResidentOptn1.image = UIImage(named: "unchecked")
                cell.imgResidentOptn2.image = UIImage(named: "unchecked")
            } else if String(describing: plumberDict["residentialOption"]!) == "Detached Garage" {
                self.residentialOption = "Detached Garage"
                cell.imgResidentOptn0.image = UIImage(named: "unchecked")
                cell.imgResidentOptn1.image = UIImage(named: "checkmark")
                cell.imgResidentOptn2.image = UIImage(named: "unchecked")
            } else if String(describing: plumberDict["residentialOption"]!) == "Swimming Pool, Spa or Water Features" {
                self.residentialOption = "Swimming Pool, Spa or Water Features"
                cell.imgResidentOptn0.image = UIImage(named: "unchecked")
                cell.imgResidentOptn1.image = UIImage(named: "unchecked")
                cell.imgResidentOptn2.image = UIImage(named: "checkmark")
            }
            self.secPlumber1[PlumberPhone.residentText.rawValue].formTextValue = String(describing: plumberDict["plumberResidentText"]!)
            cell.vwResidentText.text = String(describing: plumberDict["plumberResidentText"]!)
            
            //fireSuppression
            if String(describing: plumberDict["fireSuppressionOption"]!) == "Yes" {
                self.fireSuppressionOption = "Yes"
                cell.imgFireSuppressionOptn0.image = UIImage(named: "checkmark")
                cell.imgFireSuppressionOptn1.image = UIImage(named: "unchecked")
            } else if String(describing: plumberDict["fireSuppressionOption"]!) == "No" {
                self.fireSuppressionOption = "No"
                cell.imgFireSuppressionOptn0.image = UIImage(named: "unchecked")
                cell.imgFireSuppressionOptn1.image = UIImage(named: "checkmark")
            }
            self.secPlumber1[PlumberPhone.fireSuppressionText.rawValue].formTextValue = String(describing: plumberDict["plumberfireSuppressionText"]!)
            cell.vwFireSuppressionText.text = String(describing: plumberDict["plumberfireSuppressionText"]!)
            
            //floorHeating
            if String(describing: plumberDict["floorHeating"]!) == "Yes" {
                self.floorHeating = "Yes"
                cell.imgFloorHeatingOptn0.image = UIImage(named: "checkmark")
                cell.imgFloorHeatingOptn1.image = UIImage(named: "unchecked")
            } else if String(describing: plumberDict["floorHeating"]!) == "No" {
                self.floorHeating = "No"
                cell.imgFloorHeatingOptn0.image = UIImage(named: "unchecked")
                cell.imgFloorHeatingOptn1.image = UIImage(named: "checkmark")
            }
        } else {
            if arrPlumberImg.count > 0 {
                cell.btnUploadOutlet.isHidden = true
                cell.collectionVw.isHidden = false
            } else {
                cell.btnUploadOutlet.isHidden = false
                cell.collectionVw.isHidden = true
            }
            cell.collectionVw.isEdit = true
            cell.collectionVw.delegateItemCollection = self
            cell.collectionVw.reloadImageCollection()
        }
        
        cell.btnNextOutlet.addTarget(self, action: #selector(btnNextDidTap), for: UIControl.Event.touchUpInside)
        
        cell.txtNumberofBuilding.delegate = self
        cell.vwOtherText.delegate = self
        cell.vwStoriesText.delegate = self
        cell.vwFindText.delegate = self
        cell.vwCallReasonText.delegate = self
        cell.vwSwimmingText.delegate = self
        cell.vwResidentText.delegate = self
        cell.vwFireSuppressionText.delegate = self
        
        cell.delegatePropertyType = self
        cell.delegateFindUsType = self
        cell.delegateStoriesType = self
        cell.delegateCallReasonType = self
        cell.delegateSwimmingOptionType = self
        cell.delegateFloorHeatingOptionType = self
        cell.delegateResidentOptionType = self
        cell.delegateFireSuppressionOptionType = self
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .phone {
             return 2420
        } else {
            return 4524
        }
       
    }
}

extension PlumberPhoneQuestionVC: OpalImagePickerControllerDelegate {
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
                                self.arrPlumberImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.setPostImage(arrOfImages: images)
                                self.dataPlumberImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
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
                self.tblPlumberQuestion.reloadData()
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

extension PlumberPhoneQuestionVC: UIImagePickerControllerDelegate {
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
            self.arrPlumberImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.setPostImage(arrOfImages: imageArr)
            self.dataPlumberImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
        }
        
        self.tblPlumberQuestion.reloadData()
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
}

extension PlumberPhoneQuestionVC: UITextViewDelegate {
   /*
    @objc func updateTextViewValue(_: textView) {
        let cell = self.tblPlumberQuestion.cellForRow(at: IndexPath.init(row: self.selectedRowIndex, section: self.sectionIndex))
        guard let _cell = cell else { return  }
        
        if let PlumberPhoneQuestionCell = _cell as? PlumberPhoneQuestionCell {
            if textView == PlumberPhoneQuestionCell.vwOtherText {
                print(self.sectionIndex)
                print(self.selectedRowIndex)
                if self.sectionIndex == 0 {
                    self.secPool1[PlumberPhone.propertyText.rawValue].formTextValue = (textView.text)!
                }
            } else  if textView == PlumberPhoneQuestionCell.vwStoriesText {
                print(self.sectionIndex)
                print(self.selectedRowIndex)
                if self.sectionIndex == 0 {
                    self.secPool1[PlumberPhone.storiesText.rawValue].formTextValue = (textView.text)!
                }
            } else  if textView == PlumberPhoneQuestionCell.vwFindText {
                print(self.sectionIndex)
                print(self.selectedRowIndex)
                if self.sectionIndex == 0 {
                    self.secPool1[PlumberPhone.findUsText.rawValue].formTextValue = (textView.text)!
                }
            } else  if textView == PlumberPhoneQuestionCell.vwCallReasonText {
                print(self.sectionIndex)
                print(self.selectedRowIndex)
                if self.sectionIndex == 0 {
                    self.secPool1[PlumberPhone.callReasonText.rawValue].formTextValue = (textView.text)!
                }
            } else  if textView == PlumberPhoneQuestionCell.vwSwimmingText {
                print(self.sectionIndex)
                print(self.selectedRowIndex)
                if self.sectionIndex == 0 {
                    self.secPool1[PlumberPhone.swimmingText.rawValue].formTextValue = (textView.text)!
                }
            } else  if textView == PlumberPhoneQuestionCell.vwResidentText {
                print(self.sectionIndex)
                print(self.selectedRowIndex)
                if self.sectionIndex == 0 {
                    self.secPool1[PlumberPhone.residentText.rawValue].formTextValue = (textView.text)!
                }
            } else  if textView == PlumberPhoneQuestionCell.vwFireSuppressionText {
                print(self.sectionIndex)
                print(self.selectedRowIndex)
                if self.sectionIndex == 0 {
                    self.secPool1[PlumberPhone.fireSuppressionText.rawValue].formTextValue = (textView.text)!
                }
            }
        }
    }
 */
 
    
//    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
//        var cell = UITableViewCell()
//        if UIDevice.current.userInterfaceIdiom == .phone {
//            cell = (textView.superview?.superview?.superview as? UITableViewCell)!
//
//            let indexpath = self.tblPlumberQuestion.indexPath(for: cell)
//            guard let _indexPath = indexpath else { return false }
//            self.selectedRowIndex = _indexPath.row
//            self.sectionIndex = _indexPath.section
//
//        } else if UIDevice.current.userInterfaceIdiom == .pad {
//            cell = (textView.superview?.superview as? UITableViewCell)!
//
//            let indexpath = self.tblPlumberQuestion.indexPath(for: cell)
//            guard let _indexPath = indexpath else { return false }
//            self.selectedRowIndex = _indexPath.row
//            self.sectionIndex = _indexPath.section
//        }
//        return true
//    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        var cell = UITableViewCell()
        if UIDevice.current.userInterfaceIdiom == .phone {
            cell = (textView.superview?.superview?.superview as? UITableViewCell)!
                        
            if let PlumberPhoneQuestionCell = cell as? PlumberPhoneQuestionTableCell {
                if textView == PlumberPhoneQuestionCell.vwOtherText {
                    self.secPlumber1[PlumberPhone.propertyText.rawValue].formTextValue = (textView.text)!
               } else if  textView == PlumberPhoneQuestionCell.vwStoriesText {
                    self.secPlumber1[PlumberPhone.storiesText.rawValue].formTextValue = (textView.text)!
               } else if textView == PlumberPhoneQuestionCell.vwFindText {
                    self.secPlumber1[PlumberPhone.findUsText.rawValue].formTextValue = (textView.text)!
               } else  if textView == PlumberPhoneQuestionCell.vwCallReasonText {
                    self.secPlumber1[PlumberPhone.callReasonText.rawValue].formTextValue = (textView.text)!
               } else if textView == PlumberPhoneQuestionCell.vwSwimmingText {
                    self.secPlumber1[PlumberPhone.swimmingText.rawValue].formTextValue = (textView.text)!
               } else if textView == PlumberPhoneQuestionCell.vwResidentText {
                    self.secPlumber1[PlumberPhone.residentText.rawValue].formTextValue = (textView.text)!
               } else if textView == PlumberPhoneQuestionCell.vwFireSuppressionText {
                    self.secPlumber1[PlumberPhone.fireSuppressionText.rawValue].formTextValue = (textView.text)!
               }
            }
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            cell = (textView.superview?.superview as? UITableViewCell)!
          
            if let PlumberPhoneQuestionCell = cell as? PlumberPhoneQuestionTableCell {
                if textView == PlumberPhoneQuestionCell.vwOtherText {
                    self.secPlumber1[PlumberPhone.propertyText.rawValue].formTextValue = (textView.text)!
               } else if  textView == PlumberPhoneQuestionCell.vwStoriesText {
                    self.secPlumber1[PlumberPhone.storiesText.rawValue].formTextValue = (textView.text)!
               } else if textView == PlumberPhoneQuestionCell.vwFindText {
                    self.secPlumber1[PlumberPhone.findUsText.rawValue].formTextValue = (textView.text)!
               } else  if textView == PlumberPhoneQuestionCell.vwCallReasonText {
                    self.secPlumber1[PlumberPhone.callReasonText.rawValue].formTextValue = (textView.text)!
               } else if textView == PlumberPhoneQuestionCell.vwSwimmingText {
                    self.secPlumber1[PlumberPhone.swimmingText.rawValue].formTextValue = (textView.text)!
               } else if textView == PlumberPhoneQuestionCell.vwResidentText {
                    self.secPlumber1[PlumberPhone.residentText.rawValue].formTextValue = (textView.text)!
               } else if textView == PlumberPhoneQuestionCell.vwFireSuppressionText {
                    self.secPlumber1[PlumberPhone.fireSuppressionText.rawValue].formTextValue = (textView.text)!
               }
            }
        }
    }
    
    /*
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
         var cell = UITableViewCell()
         if UIDevice.current.userInterfaceIdiom == .phone {
            cell = (textView.superview?.superview?.superview as? UITableViewCell)!
                   
            let indexpath = self.tblPlumberQuestion.indexPath(for: cell)
            guard let _indexPath = indexpath else { return false }


            //self.perform(#selector(PlumberPhoneQuestionVC.updateTextViewValue(textView)), with: nil, afterDelay: 1)
         } else {
            cell = (textView.superview?.superview as? UITableViewCell)!
                   
            let indexpath = self.tblPlumberQuestion.indexPath(for: cell)
            guard let _indexPath = indexpath else { return false }
 
                  
            //self.perform(#selector(PlumberPhoneQuestionVC.updateTextViewValue), with: nil, afterDelay: 1)
        }
       
        
        return true
    }
 */
}

extension PlumberPhoneQuestionVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        var cell = UITableViewCell()
        if UIDevice.current.userInterfaceIdiom == .phone {
            cell = (textField.superview?.superview as? UITableViewCell)!
                        
            if let PlumberPhoneQuestionCell = cell as? PlumberPhoneQuestionTableCell {
                if textField == PlumberPhoneQuestionCell.txtNumberofBuilding {
                    self.secPlumber1[PlumberPhone.buildingNumber.rawValue].formTextValue = (textField.text)!
               }
            }
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            cell = (textField.superview?.superview as? UITableViewCell)!
            
            if let PlumberPhoneQuestionCell = cell as? PlumberPhoneQuestionTableCell {
                if textField == PlumberPhoneQuestionCell.txtNumberofBuilding {
                       self.secPlumber1[PlumberPhone.buildingNumber.rawValue].formTextValue = (textField.text)!
               }
            }
        }
    }
}


extension PlumberPhoneQuestionVC: PropertyTypeProtocol, StoriesTypeProtocol, FindUsProtocol, ResidentOptionProtocol, FloorHeatingOptionProtocol, CallReasonProtocol, SwimmingOptionProtocol, FireSuppressionOptionProtocol {
    
    //MARK:- PhoneQuestionnaireProtocol
    func didTapOnPropertyType(_btnPropertyTypeTag: Int) {
        if _btnPropertyTypeTag == 0 {
            propertyTypePlumber = "Single Family House / Multifamily House"
            plumberType = "Non - COMMERCIAL"
        } else if _btnPropertyTypeTag == 1 {
            propertyTypePlumber = "Commercial Building"
            plumberType = "COMMERCIAL"
        } else {
            propertyTypePlumber = "Other"
            plumberType = "Non - COMMERCIAL"
        }
    }
    
    //MARK:- StoriesTypeProtocol
    func didTapOnStoriesType(_btnStoriesTypeTag: Int) {
        if _btnStoriesTypeTag == 0 {
            storiesTypePlumber = "Single Level"
        } else if _btnStoriesTypeTag == 1 {
            storiesTypePlumber = "Multi Level"
        } else if _btnStoriesTypeTag == 2 {
            storiesTypePlumber = "Basement"
        } else {
            storiesTypePlumber = "Other (if any air noted, describe)"
        }
    }
    
    //MARK:- FindUsCellProtocol
    func didTapOnFindUs(_btnFindUsTag: Int) {
        if _btnFindUsTag == 0 {
            findUsOptionPlumber = "Existing customer (used our services in the past)"
        } else if _btnFindUsTag == 1 {
            findUsOptionPlumber = "Online"
        } else {
            findUsOptionPlumber = "Other"
        }
    }
    
    //MARK:- ReasonForCallProtocol
    func didTapOnCallReason(_btnCallReasonTag: Int) {
        if _btnCallReasonTag == 0 {
            reasonForCallPlumber = "Present water damage"
        } else if _btnCallReasonTag == 1 {
            reasonForCallPlumber = "High water bill"
        } else if _btnCallReasonTag == 2 {
            reasonForCallPlumber = "Pooling water on property"
        } else if _btnCallReasonTag == 3 {
            reasonForCallPlumber = "Losing pressure"
        } else if _btnCallReasonTag == 4 {
            reasonForCallPlumber = "Other"
        }
    }
    
    //MARK:- SwimmingOptionProtocol
    func didTapOnSwimmingOption(_btnSwimmingTag: Int) {
        if _btnSwimmingTag == 0 {
            swimmingOption = "Yes"
        } else if _btnSwimmingTag == 1 {
            swimmingOption = "No"
        }
    }
    
    //MARK:- ResidentialOptionProtocol
    func didTapOnResidentOption(_btnResidentTag: Int) {
        if _btnResidentTag == 0 {
            residentialOption = "Guest house"
        } else if _btnResidentTag == 1 {
            residentialOption = "Detached Garage"
        } else if _btnResidentTag == 2 {
            residentialOption = "Swimming Pool, Spa or Water Features"
        }
    }
     
    //MARK:- FireSuppressionProtocol
    func didTapOnFireSuppressionOption(_btnFireSuppressionTag: Int) {
         if _btnFireSuppressionTag == 0 {
             fireSuppressionOption = "Yes"
         } else {
             fireSuppressionOption = "No"
         }
    }
    
    //MARK:- FllorHeatingProtocol
    func didTapOnFloorHeatingOption(_btnFloorHeatingTag: Int) {
        if _btnFloorHeatingTag == 0 {
            floorHeating = "Yes"
        } else {
            floorHeating = "No"
        }
    }
}
