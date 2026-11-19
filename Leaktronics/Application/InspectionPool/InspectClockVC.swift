//
//  InspectClockVC.swift
//  Leaktronics
//
//  Created by ivaninfotech on 5/8/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import CoreData
import DLRadioButton
import SVProgressHUD
import Alamofire
import Photos
import OpalImagePicker


class InspectClockVC: UIViewController , UINavigationControllerDelegate, UploadCollectionProtocol {
    
    @IBOutlet weak var tblClock: UITableView!
    
    var secHeater = [formInspectionPoolData]()
    var secHeatPump = [formInspectionPoolData]()
    var secClockTime = [formInspectionPoolData]()
    
    enum Heater: Int {
        case heater0 = 0
        case heater1 = 1
        case heater2 = 2
        case heater3 = 3
        case heater4 = 4
        case heater5 = 5
        case heater6 = 6
        case heater7 = 7
        case heater8 = 8
        case heater9 = 9
        case heater10 = 10
        case heater11 = 11
    }
    
    enum HeatPump: Int {
        case heatPump1 = 1
        case heatPump2 = 2
        case heatPump3 = 3
        case heatPump4 = 4
        case heatPump5 = 5
    }
    
    enum ClockTime: Int {
        case clockTime0 = 0
        case clockTime1 = 1
        case clockTime2 = 2
        case clockTime3 = 3
        case clockTime4 = 4
        case clockTime5 = 5
        case clockTime6 = 6
        case clockTime7 = 7
        case clockTime8 = 8
        case clockTime9 = 9
        case clockTime10 = 10
        case clockTime11 = 11
        case clockTime12 = 12
        case clockTime13 = 13
        case clockTime14 = 14
        case clockTime15 = 15
        case clockTime16 = 16
    }
    
    var imagePicker = UIImagePickerController()
    var picker:UIImagePickerController? = UIImagePickerController()
    
    //For Images
    var arrTimeMainImg: [CollectionImageObject] = []
    var arrTime0Img: [CollectionImageObject] = []
    var arrTime1Img: [CollectionImageObject] = []
    var arrTime2Img: [CollectionImageObject] = []
    var arrTime3Img: [CollectionImageObject] = []
    var arrTime4Img: [CollectionImageObject] = []
    var arrTime5Img: [CollectionImageObject] = []
    var arrTime6Img: [CollectionImageObject] = []
    var arrTime7Img: [CollectionImageObject] = []
    var arrTime8Img: [CollectionImageObject] = []
    var arrTime9Img: [CollectionImageObject] = []
    var arrTime10Img: [CollectionImageObject] = []
    var arrTime11Img: [CollectionImageObject] = []
    var arrTime12Img: [CollectionImageObject] = []
    var arrTime13Img: [CollectionImageObject] = []
    var arrTime14Img: [CollectionImageObject] = []
    var arrTime15Img: [CollectionImageObject] = []
    var arrTime16Img: [CollectionImageObject] = []
    
    
    var arrHeaterMainImg: [CollectionImageObject] = []
    var arrHeater1Img: [CollectionImageObject] = []
    var arrHeater2Img: [CollectionImageObject] = []
    var arrHeater3Img: [CollectionImageObject] = []
    var arrHeater4Img: [CollectionImageObject] = []
    var arrHeater5Img: [CollectionImageObject] = []
    var arrHeater6Img: [CollectionImageObject] = []
    var arrHeater8Img: [CollectionImageObject] = []
    var arrHeater9Img: [CollectionImageObject] = []
    var arrHeater10Img: [CollectionImageObject] = []
    var arrHeater11Img: [CollectionImageObject] = []
    
    
    
    var arrHeatPumpMainImg: [CollectionImageObject] = []
    var arrHeatPump1Img: [CollectionImageObject] = []
    var arrHeatPump2Img: [CollectionImageObject] = []
    var arrHeatPump3Img: [CollectionImageObject] = []
    var arrHeatPump4Img: [CollectionImageObject] = []
    var arrHeatPump5Img: [CollectionImageObject] = []

    var fetchIndexForUpload: Int = -1
    var fetchIndexForSubTimeUpload: Int = -1
    var fetchIndexForSubHeaterUpload: Int = -1
    var fetchIndexForSubHeatPumpUpload: Int = -1
    


    //For Image Server path
    var strTimeMainImg = String()
    
    var strTime0Img = String()
    var strTime1Img = String()
    var strTime2Img = String()
    var strTime3Img = String()
    var strTime4Img = String()
    var strTime5Img = String()
    var strTime6Img = String()
    var strTime7Img = String()
    var strTime8Img = String()
    var strTime9Img = String()
    var strTime10Img = String()
    var strTime11Img = String()
    var strTime12Img = String()
    var strTime13Img = String()
    var strTime14Img = String()
    var strTime15Img = String()
    var strTime16Img = String()
    
    var strHeaterMainImg = String()
    var strHeaterSizedImg = String()
    var strHeaterFireUpImg = String()
    var strHeatErrorCodeImg = String()
    var strHeatGasImg = String()
    var strHeatHazardImg = String()
    var strHeatExhaustImg = String()
    var strHeatWiresImg = String()
    var strHeatCleanImg = String()
    var strHeatBurnerImg = String()
    
    var strHeatPumpOperateImg = String()
    var strHeatPumpDisplayPanelImg = String()
    var strHeatPumpColdAirImg = String()
    var strHeatPumpDrainFreeImg = String()
    var strHeatPumpExposedWiringImg = String()
    
    
    //For Image CoreData
    var dataTimeMainImg = NSData()
    
    var dataTime0Img = NSData()
    var dataTime1Img = NSData()
    var dataTime2Img = NSData()
    var dataTime3Img = NSData()
    var dataTime4Img = NSData()
    var dataTime5Img = NSData()
    var dataTime6Img = NSData()
    var dataTime7Img = NSData()
    var dataTime8Img = NSData()
    var dataTime9Img = NSData()
    var dataTime10Img = NSData()
    var dataTime11Img = NSData()
    var dataTime12Img = NSData()
    var dataTime13Img = NSData()
    var dataTime14Img = NSData()
    var dataTime15Img = NSData()
    var dataTime16Img = NSData()
    
    var dataHeaterMainImg = NSData()
    var dataHeaterSizedImg = NSData()
    var dataHeaterFireUpImg = NSData()
    var dataHeatErrorCodeImg = NSData()
    var dataHeatGasImg = NSData()
    var dataHeatHazardImg = NSData()
    var dataHeatExhaustImg = NSData()
    var dataHeatWiresImg = NSData()
    var dataHeatCleanImg = NSData()
    var dataHeatBurnerImg = NSData()
    
    var dataHeatPumpOperateImg = NSData()
    var dataHeatPumpDisplayPanelImg = NSData()
    var dataHeatPumpColdAirImg = NSData()
    var dataHeatPumpDrainFreeImg = NSData()
    var dataHeatPumpExposedWiringImg = NSData()
    
    
    //For Optional Values
    var strTimeMainOpt = String()
    var strTime0Opt = String()
    var strTime1Opt = String()
    var strTime2Opt = String()
    var strTime3Opt = String()
    var strTime4Opt = String()
    var strTime5Opt = String()
    var strTime6Opt = String()
    var strTime7Opt = String()
    var strTime8Opt = String()
    var strTime9Opt = String()
    var strTime10Opt = String()
    var strTime11Opt = String()
    var strTime12Opt = String()
    var strTime13Opt = String()
    var strTime14Opt = String()
    var strTime15Opt = String()
    var strTime16Opt = String()
    
    //Heater Optional Values
    var strHeatOpt = String()
    var strSubHeatOpt = String()
    var strSubHeater0Opt = String()
    var strHeatProperSizeOpt = String()
    var strHeatFireUpOpt = String()
    var strHeatErrorCodeOpt = String()
    var strHeatGasOpt = String()
    var strHeatHazardOpt = String()
    var strHeatExhaustOpt = String()
    var strHeatDebrisOpt = String()
    var strHeatWiresOpt = String()
    var strHeatCleanOpt = String()
    var strHeatBurnerOpt = String()
    
    //Heat Pump Optional Values
    var strHeatPumpOperateOpt = String()
    var strHeatPumpDisplayPanelOpt = String()
    var strHeatPumpColdAirOpt = String()
    var strHeatPumpDrainFreeOpt = String()
    var strHeatPumpExposedWiringOpt = String()
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.prepareFormClockData()
    }
    
    func prepareFormClockData() {
        for _ in 0..<12 {
            let obj = formInspectionPoolData()
            self.secHeater.append(obj)
        }
        for _ in 0..<6 {
            let obj = formInspectionPoolData()
            self.secHeatPump.append(obj)
        }
        for _ in 0..<17 {
            let obj = formInspectionPoolData()
            self.secClockTime.append(obj)
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
        let indexOfCell = self.tblClock.indexPath(for: cell)
        print("Clicked Index : \(String(describing: indexOfCell?.row))")
        
        fetchIndexForSubTimeUpload = -1
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
    
    @objc func btnTimeImgUpload(_ sender: Any) {
        print("Button pressed 👍 ")
        let btn = sender as! UIButton
        let cell = btn.superview?.superview?.superview as! UITableViewCell
        let tblWall = self.view.viewWithTag(25) as! UITableView
        let indexOfCell = tblWall.indexPath(for: cell)
        print("Clicked Index : \(String(describing: indexOfCell?.row))")
        fetchIndexForUpload = -1
        fetchIndexForSubTimeUpload = (indexOfCell?.row)!
        
        print("Upload Index : \(String(describing: fetchIndexForSubTimeUpload))")
        
        self.actionSheetPopUpForGalleryOpen()
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc func btnAutomaticImgUpload(_ sender: Any) {
        print("Button pressed 👍 ")
        let btn = sender as! UIButton
        let cell = btn.superview?.superview?.superview as! UITableViewCell
        let tblWall = self.view.viewWithTag(25) as! UITableView
        let indexOfCell = tblWall.indexPath(for: cell)
        print("Clicked Index : \(String(describing: indexOfCell?.row))")
        fetchIndexForUpload = -1
        fetchIndexForSubTimeUpload = (indexOfCell?.row)!
        
        print("Upload Index : \(String(describing: fetchIndexForSubTimeUpload))")
        
        self.actionSheetPopUpForGalleryOpen()
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc func btnHeaterImgUpload(_ sender: Any) {
       print("Button pressed 👍 ")
       let btn = sender as! UIButton
       let cell = btn.superview?.superview?.superview as! UITableViewCell
       let tblWall = self.view.viewWithTag(35) as! UITableView
       let indexOfCell = tblWall.indexPath(for: cell)
       print("Clicked Index : \(String(describing: indexOfCell?.row))")
       fetchIndexForUpload = -1
       fetchIndexForSubHeaterUpload = (indexOfCell?.row)!
       
       print("Upload Index : \(String(describing: fetchIndexForSubHeaterUpload))")
       
       self.actionSheetPopUpForGalleryOpen()
       
       if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
           print("Button capture")
           
           imagePicker.delegate = self
           imagePicker.sourceType = .savedPhotosAlbum
           imagePicker.allowsEditing = false
           
           present(imagePicker, animated: true, completion: nil)
       }
   }
    
    
    @objc func btnHeatPumpImgUpload(_ sender: Any) {
        print("Button pressed 👍 ")
        let btn = sender as! UIButton
        let cell = btn.superview?.superview?.superview as! UITableViewCell
        let tblWall = self.view.viewWithTag(45) as! UITableView
        let indexOfCell = tblWall.indexPath(for: cell)
        print("Clicked Index : \(String(describing: indexOfCell?.row))")
        fetchIndexForUpload = -1
        fetchIndexForSubHeatPumpUpload = (indexOfCell?.row)!
        
        print("Upload Index : \(String(describing: fetchIndexForSubHeatPumpUpload))")
        
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
        //self.postInspectClock()
        if UIDevice.current.userInterfaceIdiom == .phone {
            let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
            let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectLight") as! InspectLightVC
            self.navigationController?.pushViewController(formVC, animated: true)
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
            let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectLight") as! InspectLightVC
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
                    
                    managedObject.setValue(dataTimeMainImg, forKey: "timeMainImage")
                    managedObject.setValue(strTimeMainOpt, forKey: "timeMainOption")
                    managedObject.setValue(strTime0Opt, forKey: "clockMountedOption")
                    managedObject.setValue(dataTime0Img, forKey: "clockMountedImage")
                    managedObject.setValue(self.secClockTime[ClockTime.clockTime0.rawValue].formTextValue, forKey: "clockMountedData")
                    managedObject.setValue(strTime1Opt, forKey: "deviceRustyOption")
                    managedObject.setValue(dataTime1Img, forKey: "deviceRustyImage")
                    managedObject.setValue(self.secClockTime[ClockTime.clockTime1.rawValue].formTextValue, forKey: "deviceRustyData")
                    managedObject.setValue(strTime2Opt, forKey: "deviceRunProperlyOption")
                    managedObject.setValue(dataTime2Img, forKey: "deviceRunProperlyImage")
                    managedObject.setValue(self.secClockTime[ClockTime.clockTime2.rawValue].formTextValue, forKey: "deviceRunProperlyData")
                    managedObject.setValue(strTime3Opt, forKey: "exposedWireOption")
                    managedObject.setValue(dataTime3Img, forKey: "exposedWireImage")
                    managedObject.setValue(self.secClockTime[ClockTime.clockTime3.rawValue].formTextValue, forKey: "exposedWireData")
                    managedObject.setValue(strTime4Opt, forKey: "systemGroundedOption")
                    managedObject.setValue(dataTime4Img, forKey: "systemGroundedImage")
                    managedObject.setValue(self.secClockTime[ClockTime.clockTime4.rawValue].formTextValue, forKey: "systemGroundedData")
                    managedObject.setValue(strTime5Opt, forKey: "systemWeatherProofOption")
                    managedObject.setValue(dataTime5Img, forKey: "systemWeatherProofImage")
                    managedObject.setValue(self.secClockTime[ClockTime.clockTime5.rawValue].formTextValue, forKey: "systemWeatherProofData")
                    managedObject.setValue(strTime6Opt, forKey: "automatedDisplayOption")
                    managedObject.setValue(dataTime6Img, forKey: "automatedDisplayImage")
                    managedObject.setValue(self.secClockTime[ClockTime.clockTime6.rawValue].formTextValue, forKey: "automatedDisplayData")
                    managedObject.setValue(strTime7Opt, forKey: "automatedRemotePanelOption")
                    managedObject.setValue(dataTime7Img, forKey: "automatedRemotePanelImage")
                    managedObject.setValue(self.secClockTime[ClockTime.clockTime7.rawValue].formTextValue, forKey: "automatedRemotePanelData")
                    managedObject.setValue(strTime8Opt, forKey: "remotePanelWorkOption")
                    managedObject.setValue(dataTime8Img, forKey: "remotePanelWorkImage")
                    managedObject.setValue(self.secClockTime[ClockTime.clockTime8.rawValue].formTextValue, forKey: "remotePanelWorkData")
                    managedObject.setValue(strTime9Opt, forKey: "remoteControlOption")
                    managedObject.setValue(dataTime9Img, forKey: "remoteControlImage")
                    managedObject.setValue(self.secClockTime[ClockTime.clockTime9.rawValue].formTextValue, forKey: "remoteControlData")
                    managedObject.setValue(strTime10Opt, forKey: "spaSideSwitchOption")
                    managedObject.setValue(dataTime10Img, forKey: "spaSideSwitchImage")
                    managedObject.setValue(self.secClockTime[ClockTime.clockTime10.rawValue].formTextValue, forKey: "spaSideSwitchData")
                    managedObject.setValue(strTime11Opt, forKey: "spaAirSwitchOption")
                    managedObject.setValue(dataTime11Img, forKey: "spaAirSwitchImage")
                    managedObject.setValue(self.secClockTime[ClockTime.clockTime11.rawValue].formTextValue, forKey: "spaAirSwitchData")
                    managedObject.setValue(strTime12Opt, forKey: "phoneBasedAppOption")
                    managedObject.setValue(dataTime12Img, forKey: "phoneBasedAppImage")
                    managedObject.setValue(self.secClockTime[ClockTime.clockTime12.rawValue].formTextValue, forKey: "phoneBasedAppData")
                    managedObject.setValue(strTime13Opt, forKey: "remotelyOperatedSystemOption")
                    managedObject.setValue(dataTime13Img, forKey: "remotelyOperatedSystemImage")
                    managedObject.setValue(self.secClockTime[ClockTime.clockTime13.rawValue].formTextValue, forKey: "remotelyOperatedSystemData")
                    managedObject.setValue(strTime14Opt, forKey: "serviceModeOption")
                    managedObject.setValue(dataTime14Img, forKey: "serviceModeImage")
                    managedObject.setValue(self.secClockTime[ClockTime.clockTime14.rawValue].formTextValue, forKey: "serviceModeData")
                    managedObject.setValue(strTime15Opt, forKey: "properlyLabelOption")
                    managedObject.setValue(dataTime15Img, forKey: "properlyLabelImage")
                    managedObject.setValue(self.secClockTime[ClockTime.clockTime15.rawValue].formTextValue, forKey: "properlyLabelData")
                    managedObject.setValue(strTime16Opt, forKey: "automatedValvesWorkingOption")
                    managedObject.setValue(dataTime16Img, forKey: "automatedValvesWorkingImage")
                    managedObject.setValue(self.secClockTime[ClockTime.clockTime16.rawValue].formTextValue, forKey: "automatedValvesWorkingData")
                    managedObject.setValue(strHeatOpt, forKey: "heatOption")
                    managedObject.setValue(strSubHeatOpt, forKey: "heatOrHeaterOption")
                    managedObject.setValue(dataHeaterMainImg, forKey: "heaterMainImage")
                    managedObject.setValue(strSubHeater0Opt, forKey: "heaterPurposeOption")
                    managedObject.setValue(self.secHeater[Heater.heater0.rawValue].formTextValue, forKey: "heaterPurposeData")
                    managedObject.setValue(strHeatProperSizeOpt, forKey: "heaterSizedOption")
                    managedObject.setValue(dataHeaterSizedImg, forKey: "heaterSizedImage")
                    managedObject.setValue(self.secHeater[Heater.heater1.rawValue].formTextValue, forKey: "heaterSizedData")
                    managedObject.setValue(strHeatFireUpOpt, forKey: "heaterFireUpOption")
                    managedObject.setValue(dataHeaterFireUpImg, forKey: "heaterFireUpImage")
                    managedObject.setValue(self.secHeater[Heater.heater2.rawValue].formTextValue, forKey: "heaterFireUpData")
                    managedObject.setValue(strHeatErrorCodeOpt, forKey: "errorCodeDisplayOption")
                    managedObject.setValue(dataHeatErrorCodeImg, forKey: "errorCodeDisplayImage")
                    managedObject.setValue(self.secHeater[Heater.heater3.rawValue].formTextValue, forKey: "errorCodeDisplayData")
                    managedObject.setValue(strHeatGasOpt, forKey: "gasShutoutValveOption")
                    managedObject.setValue(dataHeatGasImg, forKey: "gasShutoutValveImage")
                    managedObject.setValue(self.secHeater[Heater.heater4.rawValue].formTextValue, forKey: "gasShutoutValveData")
                    managedObject.setValue(strHeatHazardOpt, forKey: "heaterSafeDistanceOption")
                    managedObject.setValue(dataHeatHazardImg, forKey: "heaterSafeDistanceImage")
                    managedObject.setValue(self.secHeater[Heater.heater5.rawValue].formTextValue, forKey: "heaterSafeDistanceData")
                    managedObject.setValue(strHeatExhaustOpt, forKey: "heaterExhaustBlockOption")
                    managedObject.setValue(dataHeatExhaustImg, forKey: "heaterExhaustBlockImage")
                    managedObject.setValue(self.secHeater[Heater.heater6.rawValue].formTextValue, forKey: "heaterExhaustBlockData")
                    managedObject.setValue(strHeatExhaustOpt, forKey: "internalDebrisFreeOption")
//                    managedObject.setValue(<#T##value: Any?##Any?#>, forKey: "internalDebrisFreeImage")
                    managedObject.setValue(self.secHeater[Heater.heater8.rawValue].formTextValue, forKey: "internalDebrisFreeData")
                    managedObject.setValue(strHeatWiresOpt, forKey: "heatExposedWireOption")
//                    managedObject.setValue(<#T##value: Any?##Any?#>, forKey: "heatExposedWireImage")
                    managedObject.setValue(self.secHeater[Heater.heater9.rawValue].formTextValue, forKey: "heatExposedWireData")
                    managedObject.setValue(strHeatCleanOpt, forKey: "terminalCleanOption")
//                    managedObject.setValue(<#T##value: Any?##Any?#>, forKey: "terminalCleanImage")
                    managedObject.setValue(self.secHeater[Heater.heater10.rawValue].formTextValue, forKey: "terminalCleanData")
                    managedObject.setValue(strHeatBurnerOpt, forKey: "burnerTrayCleanOption")
//                    managedObject.setValue(<#T##value: Any?##Any?#>, forKey: "burnerTrayCleanImage")
                    managedObject.setValue(self.secHeater[Heater.heater11.rawValue].formTextValue, forKey: "burnerTrayCleanData")
                    managedObject.setValue(strHeatPumpOperateOpt, forKey: "heatPumpOperateOption")
//                    managedObject.setValue(<#T##value: Any?##Any?#>, forKey: "heatPumpOperateImage")
                    managedObject.setValue(self.secHeatPump[HeatPump.heatPump1.rawValue].formTextValue, forKey: "heatPumpOperateData")
                    managedObject.setValue(strHeatPumpDisplayPanelOpt, forKey: "heatPumpDisplayPanelOption")
//                    managedObject.setValue(<#T##value: Any?##Any?#>, forKey: "heatPumpDisplayPanelImage")
                    managedObject.setValue(self.secHeatPump[HeatPump.heatPump2.rawValue].formTextValue, forKey: "heatPumpDisplayPanelData")
                    managedObject.setValue(strHeatPumpColdAirOpt, forKey: "heatPumpColdAirOption")
//                    managedObject.setValue(<#T##value: Any?##Any?#>, forKey: "heatPumpColdAirImage")
                    managedObject.setValue(self.secHeatPump[HeatPump.heatPump3.rawValue].formTextValue, forKey: "heatPumpColdAirData")
                    managedObject.setValue(strHeatPumpDrainFreeOpt, forKey: "heatPumpDrainFreeOption")
//                    managedObject.setValue(<#T##value: Any?##Any?#>, forKey: "heatPumpDrainFreeImage")
                    managedObject.setValue(self.secHeatPump[HeatPump.heatPump4.rawValue].formTextValue, forKey: "heatPumpDrainFreeData")
                    managedObject.setValue(strHeatPumpExposedWiringOpt, forKey: "heatPumpExposedWiringOption")
//                    managedObject.setValue(<#T##value: Any?##Any?#>, forKey: "heatPumpExposedWiringImage")
                    managedObject.setValue(self.secHeatPump[HeatPump.heatPump5.rawValue].formTextValue, forKey: "heatPumpExposedWiringData")
                    
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
                        print("Data of InspectClockVC:: \(data)")
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
                        self.strTimeMainImg = String(describing: data!)
                    }
                    
                    if self.fetchIndexForSubTimeUpload == 0 {
                        self.strTime0Img = String(describing: data!)
                    } else if self.fetchIndexForSubTimeUpload == 1 {
                        self.strTime1Img = String(describing: data!)
                    } else if self.fetchIndexForSubTimeUpload == 2 {
                        self.strTime2Img = String(describing: data!)
                    } else if self.fetchIndexForSubTimeUpload == 3 {
                        self.strTime3Img = String(describing: data!)
                    } else if self.fetchIndexForSubTimeUpload == 4 {
                        self.strTime4Img = String(describing: data!)
                    } else if self.fetchIndexForSubTimeUpload == 5 {
                        self.strTime5Img = String(describing: data!)
                    } else if self.fetchIndexForSubTimeUpload == 6 {
                        self.strTime6Img = String(describing: data!)
                    } else if self.fetchIndexForSubTimeUpload == 7 {
                        self.strTime7Img = String(describing: data!)
                    } else if self.fetchIndexForSubTimeUpload == 8 {
                        self.strTime8Img = String(describing: data!)
                    } else if self.fetchIndexForSubTimeUpload == 9 {
                        self.strTime9Img = String(describing: data!)
                    } else if self.fetchIndexForSubTimeUpload == 10 {
                        self.strTime10Img = String(describing: data!)
                    } else if self.fetchIndexForSubTimeUpload == 11 {
                        self.strTime11Img = String(describing: data!)
                    } else if self.fetchIndexForSubTimeUpload == 12 {
                        self.strTime12Img = String(describing: data!)
                    } else if self.fetchIndexForSubTimeUpload == 13 {
                        self.strTime13Img = String(describing: data!)
                    } else if self.fetchIndexForSubTimeUpload == 14 {
                        self.strTime14Img = String(describing: data!)
                    } else if self.fetchIndexForSubTimeUpload == 15 {
                        self.strTime15Img = String(describing: data!)
                    } else if self.fetchIndexForSubTimeUpload == 16 {
                        self.strTime16Img = String(describing: data!)
                    }
                    
                    if self.fetchIndexForSubHeaterUpload == 1 {
                        self.strHeaterMainImg = String(describing: data!)
                    } else if self.fetchIndexForSubHeaterUpload == 2 {
                        self.strHeaterSizedImg = String(describing: data!)
                    } else if self.fetchIndexForSubHeaterUpload == 3 {
                        self.strHeaterFireUpImg = String(describing: data!)
                    } else if self.fetchIndexForSubHeaterUpload == 4 {
                        self.strHeatErrorCodeImg = String(describing: data!)
                    } else if self.fetchIndexForSubHeaterUpload == 5 {
                        self.strHeatGasImg = String(describing: data!)
                    } else if self.fetchIndexForSubHeaterUpload == 6 {
                        self.strHeatHazardImg = String(describing: data!)
                    } else if self.fetchIndexForSubHeaterUpload == 8 {
                        self.strHeatExhaustImg = String(describing: data!)
                    } else if self.fetchIndexForSubHeaterUpload == 9 {
                        self.strHeatWiresImg = String(describing: data!)
                    } else if self.fetchIndexForSubHeaterUpload == 10 {
                        self.strHeatCleanImg = String(describing: data!)
                    } else if self.fetchIndexForSubHeaterUpload == 11 {
                        self.strHeatBurnerImg = String(describing: data!)
                    }
                    
                    if self.fetchIndexForSubHeatPumpUpload == 1 {
                        self.strHeatPumpOperateImg = String(describing: data!)
                    } else if self.fetchIndexForSubHeatPumpUpload == 2 {
                        self.strHeatPumpDisplayPanelImg = String(describing: data!)
                    } else if self.fetchIndexForSubHeatPumpUpload == 3 {
                        self.strHeatPumpColdAirImg = String(describing: data!)
                    } else if self.fetchIndexForSubHeatPumpUpload == 4 {
                        self.strHeatPumpDrainFreeImg = String(describing: data!)
                    } else if self.fetchIndexForSubHeatPumpUpload == 5 {
                        self.strHeatPumpExposedWiringImg = String(describing: data!)
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
    
    func postInspectClock() {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        
        let return_id = UserDefaults.standard.value(forKey: "returnKeyForInspection")
        
        let inspectClockDetails: NSMutableDictionary = [
            "return_data_id"                : return_id!,
            "timeMainImage"                 : strTimeMainImg,
            "timeMainOption"                : strTimeMainOpt,
            "clockMountedOption"            : strTime0Opt,
            "clockMountedImage"             : strTime0Img,
            "clockMountedData"              : self.secClockTime[ClockTime.clockTime0.rawValue].formTextValue,
            "deviceRustyOption"             : strTime1Opt,
            "deviceRustyImage"              : strTime1Img,
            "deviceRustyData"               : self.secClockTime[ClockTime.clockTime1.rawValue].formTextValue,
            "deviceRunProperlyOption"       : strTime2Opt,
            "deviceRunProperlyImage"        : strTime2Img,
            "deviceRunProperlyData"         : self.secClockTime[ClockTime.clockTime2.rawValue].formTextValue,
            "exposedWireOption"             : strTime3Opt,
            "exposedWireImage"              : strTime3Img,
            "exposedWireData"               : self.secClockTime[ClockTime.clockTime3.rawValue].formTextValue,
            "systemGroundedOption"          : strTime4Opt,
            "systemGroundedImage"           : strTime4Img,
            "systemGroundedData"            : self.secClockTime[ClockTime.clockTime4.rawValue].formTextValue,
            "systemWeatherProofOption"      : strTime5Opt,
            "systemWeatherProofImage"       : strTime5Img,
            "systemWeatherProofData"        : self.secClockTime[ClockTime.clockTime5.rawValue].formTextValue,
            "automatedDisplayOption"        : strTime6Opt,
            "automatedDisplayImage"         : strTime6Img,
            "automatedDisplayData"          : self.secClockTime[ClockTime.clockTime6.rawValue].formTextValue,
            "automatedRemotePanelOption"    : strTime7Opt,
            "automatedRemotePanelImage"     : strTime7Img,
            "automatedRemotePanelData"      : self.secClockTime[ClockTime.clockTime7.rawValue].formTextValue,
            "remotePanelWorkOption"         : strTime8Opt,
            "remotePanelWorkImage"          : strTime8Img,
            "remotePanelWorkData"           : self.secClockTime[ClockTime.clockTime8.rawValue].formTextValue,
            "remoteControlOption"           : strTime9Opt,
            "remoteControlImage"            : strTime9Img,
            "remoteControlData"             : self.secClockTime[ClockTime.clockTime9.rawValue].formTextValue,
            "spaSideSwitchOption"           : strTime10Opt,
            "spaSideSwitchImage"            : strTime10Img,
            "spaSideSwitchData"             : self.secClockTime[ClockTime.clockTime10.rawValue].formTextValue,
            "spaAirSwitchOption"            : strTime11Opt,
            "spaAirSwitchImage"             : strTime11Img,
            "spaAirSwitchData"              : self.secClockTime[ClockTime.clockTime11.rawValue].formTextValue,
            "phoneBasedAppOption"           : strTime12Opt,
            "phoneBasedAppImage"            : strTime12Img,
            "phoneBasedAppData"             : self.secClockTime[ClockTime.clockTime12.rawValue].formTextValue,
            "remotelyOperatedSystemOption"  : strTime13Opt,
            "remotelyOperatedSystemImage"   : strTime13Img,
            "remotelyOperatedSystemData"    : self.secClockTime[ClockTime.clockTime13.rawValue].formTextValue,
            "serviceModeOption"             : strTime14Opt,
            "serviceModeImage"              : strTime14Img,
            "serviceModeData"               : self.secClockTime[ClockTime.clockTime14.rawValue].formTextValue,
            "properlyLabelOption"           : strTime15Opt,
            "properlyLabelImage"            : strTime15Img,
            "properlyLabelData"             : self.secClockTime[ClockTime.clockTime15.rawValue].formTextValue,
            "automatedValvesWorkingOption"  : strTime16Opt,
            "automatedValvesWorkingImage"   : strTime16Img,
            "automatedValvesWorkingData"    : self.secClockTime[ClockTime.clockTime16.rawValue].formTextValue,
            "heatOption"                    : strHeatOpt,
            "heatOrHeaterOption"            : strSubHeatOpt,
            "heaterMainImage"               : strHeaterMainImg,
            "heaterPurposeOption"           : strSubHeater0Opt,
            "heaterPurposeData"             : self.secHeater[Heater.heater0.rawValue].formTextValue,
            "heaterSizedOption"             : strHeatProperSizeOpt,
            "heaterSizedImage"              : strHeaterSizedImg,
            "heaterSizedData"               : self.secHeater[Heater.heater1.rawValue].formTextValue,
            "heaterFireUpOption"            : strHeatFireUpOpt,
            "heaterFireUpImage"             : strHeaterFireUpImg,
            "heaterFireUpData"              : self.secHeater[Heater.heater2.rawValue].formTextValue,
            "errorCodeDisplayOption"        : strHeatErrorCodeOpt,
            "errorCodeDisplayImage"         : strHeatErrorCodeImg,
            "errorCodeDisplayData"          : self.secHeater[Heater.heater3.rawValue].formTextValue,
            "gasShutoutValveOption"         : strHeatGasOpt,
            "gasShutoutValveImage"          : strHeatGasImg,
            "gasShutoutValveData"           : self.secHeater[Heater.heater4.rawValue].formTextValue,
            "heaterSafeDistanceOption"      : strHeatHazardOpt,
            "heaterSafeDistanceImage"       : strHeatHazardImg,
            "heaterSafeDistanceData"        : self.secHeater[Heater.heater5.rawValue].formTextValue,
            "heaterExhaustBlockOption"      : strHeatExhaustOpt,
            "heaterExhaustBlockImage"       : strHeatExhaustImg,
            "heaterExhaustBlockData"        : self.secHeater[Heater.heater6.rawValue].formTextValue,
            "internalDebrisFreeOption"      : strHeatExhaustOpt,
            "internalDebrisFreeImage"       : strHeatExhaustImg,
            "internalDebrisFreeData"        : self.secHeater[Heater.heater8.rawValue].formTextValue,
            "heatExposedWireOption"         : strHeatWiresOpt,
            "heatExposedWireImage"          : strHeatWiresImg,
            "heatExposedWireData"           : self.secHeater[Heater.heater9.rawValue].formTextValue,
            "terminalCleanOption"           : strHeatCleanOpt,
            "terminalCleanImage"            : strHeatCleanImg,
            "terminalCleanData"             : self.secHeater[Heater.heater10.rawValue].formTextValue,
            "burnerTrayCleanOption"         : strHeatBurnerOpt,
            "burnerTrayCleanImage"          : strHeatBurnerImg,
            "burnerTrayCleanData"           : self.secHeater[Heater.heater11.rawValue].formTextValue,
            "heatPumpOperateOption"         : strHeatPumpOperateOpt,
            "heatPumpOperateImage"          : strHeatPumpOperateImg,
            "heatPumpOperateData"           : self.secHeatPump[HeatPump.heatPump1.rawValue].formTextValue,
            "heatPumpDisplayPanelOption"    : strHeatPumpDisplayPanelOpt,
            "heatPumpDisplayPanelImage"     : strHeatPumpDisplayPanelImg,
            "heatPumpDisplayPanelData"      : self.secHeatPump[HeatPump.heatPump2.rawValue].formTextValue,
            "heatPumpColdAirOption"         : strHeatPumpColdAirOpt,
            "heatPumpColdAirImage"          : strHeatPumpColdAirImg,
            "heatPumpColdAirData"           : self.secHeatPump[HeatPump.heatPump3.rawValue].formTextValue,
            "heatPumpDrainFreeOption"       : strHeatPumpDrainFreeOpt,
            "heatPumpDrainFreeImage"        : strHeatPumpDrainFreeImg,
            "heatPumpDrainFreeData"         : self.secHeatPump[HeatPump.heatPump4.rawValue].formTextValue,
            "heatPumpExposedWiringOption"   : strHeatPumpExposedWiringOpt,
            "heatPumpExposedWiringImage"    : strHeatPumpExposedWiringImg,
            "heatPumpExposedWiringData"     : self.secHeatPump[HeatPump.heatPump5.rawValue].formTextValue
        ]

        print("inspectClockDetails :: \(inspectClockDetails)")
        //if sharedExtension.connectedToNetwork() {
        ApiManager.sharedInstanceAPI.PostInspectClock(postId: 1, clockDetails: inspectClockDetails, onSuccess: { json in
            DispatchQueue.main.async {
                print("InspectionSaltSystemDetails json :: \(String(describing: json))")
                DispatchQueue.main.async(execute: {() -> Void in
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectLight") as! InspectLightVC
                        self.navigationController?.pushViewController(formVC, animated: true)
                    } else if UIDevice.current.userInterfaceIdiom == .pad {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectLight") as! InspectLightVC
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

extension InspectClockVC: OpalImagePickerControllerDelegate {
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
                                self.arrTimeMainImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForUpload == 2 {
                                self.arrHeaterMainImg.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            }
                            
                            if self.fetchIndexForSubTimeUpload == 0 {
                                self.arrTime0Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubTimeUpload == 1 {
                                self.arrTime1Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubTimeUpload == 2 {
                                self.arrTime2Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubTimeUpload == 3 {
                                self.arrTime3Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubTimeUpload == 4 {
                                self.arrTime4Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubTimeUpload == 5 {
                                self.arrTime5Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubTimeUpload == 6 {
                                self.arrTime6Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubTimeUpload == 7 {
                                self.arrTime7Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubTimeUpload == 8 {
                               self.arrTime8Img.append(CollectionImageObject.init(imgCollect: images[i]))
                               //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                               //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubTimeUpload == 9 {
                               self.arrTime9Img.append(CollectionImageObject.init(imgCollect: images[i]))
                               //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                               //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubTimeUpload == 10 {
                               self.arrTime10Img.append(CollectionImageObject.init(imgCollect: images[i]))
                               //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                               //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubTimeUpload == 11 {
                               self.arrTime11Img.append(CollectionImageObject.init(imgCollect: images[i]))
                               //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                               //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubTimeUpload == 12 {
                               self.arrTime12Img.append(CollectionImageObject.init(imgCollect: images[i]))
                               //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                               //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubTimeUpload == 13 {
                               self.arrTime13Img.append(CollectionImageObject.init(imgCollect: images[i]))
                               //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                               //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubTimeUpload == 14 {
                               self.arrTime14Img.append(CollectionImageObject.init(imgCollect: images[i]))
                               //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                               //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubTimeUpload == 15 {
                               self.arrTime15Img.append(CollectionImageObject.init(imgCollect: images[i]))
                               //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                               //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubTimeUpload == 16 {
                               self.arrTime16Img.append(CollectionImageObject.init(imgCollect: images[i]))
                               //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                               //self.setPostImage(arrOfImages: images)
                            }
                            
                            if self.fetchIndexForSubHeaterUpload == 1 {
                               self.arrHeater1Img.append(CollectionImageObject.init(imgCollect: images[i]))
                               //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                               //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubHeaterUpload == 2 {
                                self.arrHeater2Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubHeaterUpload == 3 {
                                self.arrHeater3Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubHeaterUpload == 4 {
                                self.arrHeater4Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubHeaterUpload == 5 {
                                self.arrHeater5Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubHeaterUpload == 6 {
                                self.arrHeater6Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubHeaterUpload == 8 {
                                self.arrHeater8Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubHeaterUpload == 9 {
                                self.arrHeater9Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubHeaterUpload == 10 {
                                self.arrHeater10Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubHeaterUpload == 11 {
                                self.arrHeater11Img.append(CollectionImageObject.init(imgCollect: images[i]))
                               // self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            }
                            
                            if self.fetchIndexForSubHeatPumpUpload == 1 {
                                self.arrHeatPump1Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubHeatPumpUpload == 2 {
                                self.arrHeatPump2Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubHeatPumpUpload == 3 {
                                self.arrHeatPump3Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubHeatPumpUpload == 4 {
                                self.arrHeatPump4Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
                                //self.setPostImage(arrOfImages: images)
                            } else if self.fetchIndexForSubHeatPumpUpload == 5 {
                                self.arrHeatPump5Img.append(CollectionImageObject.init(imgCollect: images[i]))
                                //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: images) as NSData
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
        presentedViewController?.dismiss(animated: true) {
            DispatchQueue.main.async {
                self.tblClock.reloadData()
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


extension InspectClockVC: UIImagePickerControllerDelegate {
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
            self.arrTimeMainImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForUpload == 2 {
            self.arrHeaterMainImg.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        }
        
        if self.fetchIndexForSubTimeUpload == 0 {
            self.arrTime0Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        }  else if fetchIndexForSubTimeUpload == 1 {
            self.arrTime1Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubTimeUpload == 2 {
            self.arrTime2Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubTimeUpload == 3 {
            self.arrTime3Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubTimeUpload == 4 {
            self.arrTime4Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubTimeUpload == 5 {
            self.arrTime5Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubTimeUpload == 6 {
            self.arrTime6Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubTimeUpload == 7 {
            self.arrTime7Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubTimeUpload == 8 {
            self.arrTime8Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubTimeUpload == 9 {
            self.arrTime9Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if self.fetchIndexForSubTimeUpload == 10 {
            self.arrTime10Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        }  else if fetchIndexForSubTimeUpload == 11 {
            self.arrTime11Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubTimeUpload == 12 {
            self.arrTime12Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubTimeUpload == 13 {
            self.arrTime13Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubTimeUpload == 14 {
            self.arrTime14Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubTimeUpload == 15 {
            self.arrTime15Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
           //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubTimeUpload == 16 {
            self.arrTime16Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        }
        
        if fetchIndexForSubHeaterUpload == 1 {
            self.arrHeater1Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubHeaterUpload == 2 {
            self.arrHeater2Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubHeaterUpload == 3 {
            self.arrHeater3Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubHeaterUpload == 4 {
           self.arrHeater4Img.append(CollectionImageObject.init(imgCollect: possibleImage))
           var imageArr = [UIImage]()
           imageArr.append(possibleImage)
            
            //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
           //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubHeaterUpload == 5 {
           self.arrHeater5Img.append(CollectionImageObject.init(imgCollect: possibleImage))
           var imageArr = [UIImage]()
           imageArr.append(possibleImage)
            
            //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
           //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubHeaterUpload == 6 {
            self.arrHeater6Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubHeaterUpload == 8 {
            self.arrHeater8Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubHeaterUpload == 9 {
            self.arrHeater9Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubHeaterUpload == 10 {
            self.arrHeater10Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubHeaterUpload == 11 {
            self.arrHeater11Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        }
        
        if fetchIndexForSubHeatPumpUpload == 1 {
            self.arrHeatPump1Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData//
            //self.setPostImage(arrOfImages: imageArr)
        } else if fetchIndexForSubHeatPumpUpload == 2 {
            self.arrHeatPump2Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
       } else if fetchIndexForSubHeatPumpUpload == 3 {
            self.arrHeatPump3Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
       } else if fetchIndexForSubHeatPumpUpload == 4 {
            self.arrHeatPump4Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
       } else if fetchIndexForSubHeatPumpUpload == 5 {
            self.arrHeatPump5Img.append(CollectionImageObject.init(imgCollect: possibleImage))
            var imageArr = [UIImage]()
            imageArr.append(possibleImage)
            
            //self.dataPortableSpaImg = NSKeyedArchiver.archivedData(withRootObject: imageArr) as NSData
            //self.setPostImage(arrOfImages: imageArr)
        }
        self.tblClock.reloadData()
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
}

extension InspectClockVC: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        var cell = UITableViewCell()
        cell = (textView.superview?.superview as? UITableViewCell)!
        
        if let Time0TableCell = cell as? Time0TableCell {
            if textView == Time0TableCell.txtOther {
                  self.secClockTime[ClockTime.clockTime0.rawValue].formTextValue = (textView.text)!
           }
        } else if let Time1TableCell = cell as? Time1TableCell {
            if textView == Time1TableCell.txtOther {
                  self.secClockTime[ClockTime.clockTime1.rawValue].formTextValue = (textView.text)!
           }
        } else if let Time2TableCell = cell as? Time2TableCell {
            if textView == Time2TableCell.txtOther {
                  self.secClockTime[ClockTime.clockTime2.rawValue].formTextValue = (textView.text)!
           }
        } else if let Time3TableCell = cell as? Time3TableCell {
            if textView == Time3TableCell.txtOther {
                  self.secClockTime[ClockTime.clockTime3.rawValue].formTextValue = (textView.text)!
           }
        } else if let Time4TableCell = cell as? Time4TableCell {
            if textView == Time4TableCell.txtOther {
                  self.secClockTime[ClockTime.clockTime4.rawValue].formTextValue = (textView.text)!
           }
        } else if let Time5TableCell = cell as? Time5TableCell {
            if textView == Time5TableCell.txtOther {
                  self.secClockTime[ClockTime.clockTime5.rawValue].formTextValue = (textView.text)!
           }
        } else if let Time6TableCell = cell as? Time6TableCell {
            if textView == Time6TableCell.txtOther {
                  self.secClockTime[ClockTime.clockTime6.rawValue].formTextValue = (textView.text)!
           }
        } else if let Time7TableCell = cell as? Time7TableCell {
            if textView == Time7TableCell.txtOther {
                  self.secClockTime[ClockTime.clockTime7.rawValue].formTextValue = (textView.text)!
           }
        } else if let Time8TableCell = cell as? Time8TableCell {
            if textView == Time8TableCell.txtOther {
                  self.secClockTime[ClockTime.clockTime8.rawValue].formTextValue = (textView.text)!
           }
        } else if let Time9TableCell = cell as? Time9TableCell {
            if textView == Time9TableCell.txtOther {
                  self.secClockTime[ClockTime.clockTime9.rawValue].formTextValue = (textView.text)!
           }
        } else if let Time10TableCell = cell as? Time10TableCell {
            if textView == Time10TableCell.txtOther {
                  self.secClockTime[ClockTime.clockTime10.rawValue].formTextValue = (textView.text)!
           }
        } else if let Time11TableCell = cell as? Time11TableCell {
            if textView == Time11TableCell.txtOther {
                  self.secClockTime[ClockTime.clockTime11.rawValue].formTextValue = (textView.text)!
           }
        } else if let Time12TableCell = cell as? Time12TableCell {
            if textView == Time12TableCell.txtOther {
                  self.secClockTime[ClockTime.clockTime12.rawValue].formTextValue = (textView.text)!
           }
        } else if let Time13TableCell = cell as? Time13TableCell {
            if textView == Time13TableCell.txtOther {
                  self.secClockTime[ClockTime.clockTime13.rawValue].formTextValue = (textView.text)!
           }
        } else if let Time14TableCell = cell as? Time14TableCell {
            if textView == Time14TableCell.txtOther {
                  self.secClockTime[ClockTime.clockTime14.rawValue].formTextValue = (textView.text)!
           }
        } else if let Time15TableCell = cell as? Time15TableCell {
            if textView == Time15TableCell.txtOther {
                  self.secClockTime[ClockTime.clockTime15.rawValue].formTextValue = (textView.text)!
           }
        } else if let Time16TableCell = cell as? Time16TableCell {
            if textView == Time16TableCell.txtOther {
                  self.secClockTime[ClockTime.clockTime16.rawValue].formTextValue = (textView.text)!
           }
        }
        
        if let SubHeater0TableCell = cell as? SubHeater0TableCell {
            if textView == SubHeater0TableCell.txtOther {
                self.secHeater[Heater.heater0.rawValue].formTextValue = (textView.text)!
            }
        } else if let HeatProperSizeTableCell = cell as? HeatProperSizeTableCell {
            if textView == HeatProperSizeTableCell.txtOther {
                  self.secHeater[Heater.heater1.rawValue].formTextValue = (textView.text)!
            }
        } else if let HeatFireUpTableCell = cell as? HeatFireUpTableCell {
            if textView == HeatFireUpTableCell.txtOther {
                  self.secHeater[Heater.heater2.rawValue].formTextValue = (textView.text)!
            }
        } else if let HeatErrorCodeTableCell = cell as? HeatErrorCodeTableCell {
            if textView == HeatErrorCodeTableCell.txtOther {
                  self.secHeater[Heater.heater3.rawValue].formTextValue = (textView.text)!
            }
        } else if let HeatGasTableCell = cell as? HeatGasTableCell {
            if textView == HeatGasTableCell.txtOther {
                self.secHeater[Heater.heater4.rawValue].formTextValue = (textView.text)!
            }
        } else if let HeatHazardTableCell = cell as? HeatHazardTableCell {
            if textView == HeatHazardTableCell.txtOther {
                self.secHeater[Heater.heater5.rawValue].formTextValue = (textView.text)!
            }
        } else if let HeatExhaustTableCell = cell as? HeatExhaustTableCell {
            if textView == HeatExhaustTableCell.txtOther {
                self.secHeater[Heater.heater6.rawValue].formTextValue = (textView.text)!
            }
        } else if let HeatDebrisTableCell = cell as? HeatDebrisTableCell {
            if textView == HeatDebrisTableCell.txtOther {
                self.secHeater[Heater.heater8.rawValue].formTextValue = (textView.text)!
            }
        } else if let HeatWiresTableCell = cell as? HeatWiresTableCell {
            if textView == HeatWiresTableCell.txtOther {
                self.secHeater[Heater.heater9.rawValue].formTextValue = (textView.text)!
            }
        } else if let HeatCleanTableCell = cell as? HeatCleanTableCell {
            if textView == HeatCleanTableCell.txtOther {
                self.secHeater[Heater.heater10.rawValue].formTextValue = (textView.text)!
            }
        } else if let HeatBurnerTableCell = cell as? HeatBurnerTableCell {
            if textView == HeatBurnerTableCell.txtOther {
                self.secHeater[Heater.heater11.rawValue].formTextValue = (textView.text)!
            }
        }
        
        if let HeatPumpOperateTableCell = cell as? HeatPumpOperateTableCell {
            if textView == HeatPumpOperateTableCell.txtOther {
                self.secHeatPump[HeatPump.heatPump1.rawValue].formTextValue = (textView.text)!
            }
        } else if let HeatPumpDisplayPanelTableCell = cell as? HeatPumpDisplayPanelTableCell {
            if textView == HeatPumpDisplayPanelTableCell.txtOther {
                self.secHeatPump[HeatPump.heatPump2.rawValue].formTextValue = (textView.text)!
            }
        } else if let HeatPumpColdAirTableCell = cell as? HeatPumpColdAirTableCell {
            if textView == HeatPumpColdAirTableCell.txtOther {
                self.secHeatPump[HeatPump.heatPump3.rawValue].formTextValue = (textView.text)!
            }
        } else if let HeatPumpDrainFreeTableCell = cell as? HeatPumpDrainFreeTableCell {
            if textView == HeatPumpDrainFreeTableCell.txtOther {
                self.secHeatPump[HeatPump.heatPump4.rawValue].formTextValue = (textView.text)!
            }
        } else if let HeatPumpExposedWiringTableCell = cell as? HeatPumpExposedWiringTableCell {
            if textView == HeatPumpExposedWiringTableCell.txtOther {
                self.secHeatPump[HeatPump.heatPump5.rawValue].formTextValue = (textView.text)!
            }
        }
    }
}

extension InspectClockVC: UITableViewDataSource, UITableViewDelegate {
    //MARK:- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 25 {
            return 17
        } else if tableView.tag == 35 {
            return 12
        } else if tableView.tag == 45 {
            return 6
        } else {
            return 5
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 25 {
            if indexPath.row == 0 {
                let timeCell = tableView.dequeueReusableCell(withIdentifier: "Time0Cell", for: indexPath) as! Time0TableCell
                
                timeCell.lblHeader.text = "Is time clock mounted properly?"
                
                timeCell.btnUpload.addTarget(self, action: #selector(btnTimeImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                timeCell.collectionVw.arrItems = arrTime0Img
                timeCell.collectionVw.delegateItemCollection = self
                timeCell.collectionVw.reloadImageCollection()
                
                if arrTime0Img.count > 0 {
                    timeCell.btnUpload.isHidden = true
                    timeCell.collectionVw.isHidden = false
                } else {
                    timeCell.btnUpload.isHidden = false
                    timeCell.collectionVw.isHidden = true
                }
                
                timeCell.delegateTime0 = self
                timeCell.txtOther.delegate = self
                
                return timeCell
            } else if indexPath.row == 1 {
                let timeCell = tableView.dequeueReusableCell(withIdentifier: "Time1Cell", for: indexPath) as! Time1TableCell
                
                timeCell.lblHeader.text = "Mechanical: Is device rusty or flimsy?"
                
                timeCell.btnUpload.addTarget(self, action: #selector(btnTimeImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                timeCell.collectionVw.arrItems = arrTime1Img
                timeCell.collectionVw.delegateItemCollection = self
                timeCell.collectionVw.reloadImageCollection()
                
                if arrTime1Img.count > 0 {
                    timeCell.btnUpload.isHidden = true
                    timeCell.collectionVw.isHidden = false
                } else {
                    timeCell.btnUpload.isHidden = false
                    timeCell.collectionVw.isHidden = true
                }
                
                timeCell.delegateTime1 = self
                timeCell.txtOther.delegate = self
                
                return timeCell
            } else if indexPath.row == 2 {
                let timeCell = tableView.dequeueReusableCell(withIdentifier: "Time2Cell", for: indexPath) as! Time2TableCell
                       
                timeCell.lblHeader.text = "Does device run properly when tested?"

                timeCell.btnUpload.addTarget(self, action: #selector(btnTimeImgUpload(_:)), for: UIControl.Event.touchUpInside)

                timeCell.collectionVw.arrItems = arrTime2Img
                timeCell.collectionVw.delegateItemCollection = self
                timeCell.collectionVw.reloadImageCollection()

                if arrTime2Img.count > 0 {
                   timeCell.btnUpload.isHidden = true
                   timeCell.collectionVw.isHidden = false
                } else {
                   timeCell.btnUpload.isHidden = false
                   timeCell.collectionVw.isHidden = true
                }
                
                timeCell.delegateTime2 = self
                timeCell.txtOther.delegate = self
                
                return timeCell
            } else if indexPath.row == 3 {
                let timeCell = tableView.dequeueReusableCell(withIdentifier: "Time3Cell", for: indexPath) as! Time3TableCell
                       
                timeCell.lblHeader.text = "Are there exposed wires or terminals?"

                timeCell.btnUpload.addTarget(self, action: #selector(btnTimeImgUpload(_:)), for: UIControl.Event.touchUpInside)

                timeCell.collectionVw.arrItems = arrTime3Img
                timeCell.collectionVw.delegateItemCollection = self
                timeCell.collectionVw.reloadImageCollection()

                if arrTime3Img.count > 0 {
                   timeCell.btnUpload.isHidden = true
                   timeCell.collectionVw.isHidden = false
                } else {
                   timeCell.btnUpload.isHidden = false
                   timeCell.collectionVw.isHidden = true
                }
                
                timeCell.delegateTime3 = self
                timeCell.txtOther.delegate = self
                return timeCell
            } else if indexPath.row == 4 {
                let timeCell = tableView.dequeueReusableCell(withIdentifier: "Time4Cell", for: indexPath) as! Time4TableCell
                       
                timeCell.lblHeader.text = "Is system properly grounded?"

                timeCell.btnUpload.addTarget(self, action: #selector(btnTimeImgUpload(_:)), for: UIControl.Event.touchUpInside)

                timeCell.collectionVw.arrItems = arrTime4Img
                timeCell.collectionVw.delegateItemCollection = self
                timeCell.collectionVw.reloadImageCollection()

                if arrTime4Img.count > 0 {
                   timeCell.btnUpload.isHidden = true
                   timeCell.collectionVw.isHidden = false
                } else {
                   timeCell.btnUpload.isHidden = false
                   timeCell.collectionVw.isHidden = true
                }
                
                timeCell.delegateTime4 = self
                timeCell.txtOther.delegate = self
                
                
                return timeCell
            } else if indexPath.row == 5 {
                let timeCell = tableView.dequeueReusableCell(withIdentifier: "Time5Cell", for: indexPath) as! Time5TableCell
                       
                timeCell.lblHeader.text = "Is system in a weatherproof enclosure?"

                timeCell.btnUpload.addTarget(self, action: #selector(btnTimeImgUpload(_:)), for: UIControl.Event.touchUpInside)

                timeCell.collectionVw.arrItems = arrTime5Img
                timeCell.collectionVw.delegateItemCollection = self
                timeCell.collectionVw.reloadImageCollection()

                if arrTime5Img.count > 0 {
                   timeCell.btnUpload.isHidden = true
                   timeCell.collectionVw.isHidden = false
                } else {
                   timeCell.btnUpload.isHidden = false
                   timeCell.collectionVw.isHidden = true
                }
                
                timeCell.delegateTime5 = self
                timeCell.txtOther.delegate = self
                
                return timeCell
            } else if indexPath.row == 6 {
                let timeCell = tableView.dequeueReusableCell(withIdentifier: "Time6Cell", for: indexPath) as! Time6TableCell
                       
                timeCell.lblHeader.text = "Automated: Do displays appear to work properly?"
                
                timeCell.btnUpload.addTarget(self, action: #selector(btnTimeImgUpload(_:)), for: UIControl.Event.touchUpInside)

                timeCell.collectionVw.arrItems = arrTime6Img
                timeCell.collectionVw.delegateItemCollection = self
                timeCell.collectionVw.reloadImageCollection()

                if arrTime6Img.count > 0 {
                   timeCell.btnUpload.isHidden = true
                   timeCell.collectionVw.isHidden = false
                } else {
                   timeCell.btnUpload.isHidden = false
                   timeCell.collectionVw.isHidden = true
                }
                
                timeCell.delegateTime6 = self
                timeCell.txtOther.delegate = self
                return timeCell
            } else if indexPath.row == 7 {
                let timeCell = tableView.dequeueReusableCell(withIdentifier: "Time7Cell", for: indexPath) as! Time7TableCell
                       
                timeCell.lblHeader.text = "Is there an automated remote panel in the house?"

                timeCell.btnUpload.addTarget(self, action: #selector(btnTimeImgUpload(_:)), for: UIControl.Event.touchUpInside)

                timeCell.collectionVw.arrItems = arrTime7Img
                timeCell.collectionVw.delegateItemCollection = self
                timeCell.collectionVw.reloadImageCollection()

                if arrTime7Img.count > 0 {
                   timeCell.btnUpload.isHidden = true
                   timeCell.collectionVw.isHidden = false
                } else {
                   timeCell.btnUpload.isHidden = false
                   timeCell.collectionVw.isHidden = true
                }
                
                timeCell.delegateTime7 = self
                timeCell.txtOther.delegate = self
                
                return timeCell
            } else if indexPath.row == 8 {
                let timeCell = tableView.dequeueReusableCell(withIdentifier: "Time8Cell", for: indexPath) as! Time8TableCell
                       
                timeCell.lblHeader.text = "Do all remote panel functions work properly?"

                timeCell.btnUpload.addTarget(self, action: #selector(btnTimeImgUpload(_:)), for: UIControl.Event.touchUpInside)

                timeCell.collectionVw.arrItems = arrTime8Img
                timeCell.collectionVw.delegateItemCollection = self
                timeCell.collectionVw.reloadImageCollection()

                if arrTime8Img.count > 0 {
                   timeCell.btnUpload.isHidden = true
                   timeCell.collectionVw.isHidden = false
                } else {
                   timeCell.btnUpload.isHidden = false
                   timeCell.collectionVw.isHidden = true
                }
                
                timeCell.delegateTime8 = self
                timeCell.txtOther.delegate = self
                
                return timeCell
            } else if indexPath.row == 9 {
                let timeCell = tableView.dequeueReusableCell(withIdentifier: "Time9Cell", for: indexPath) as! Time9TableCell
                       
                timeCell.lblHeader.text = "Is there a working remote control?"
                
                timeCell.btnUpload.addTarget(self, action: #selector(btnTimeImgUpload(_:)), for: UIControl.Event.touchUpInside)

                timeCell.collectionVw.arrItems = arrTime9Img
                timeCell.collectionVw.delegateItemCollection = self
                timeCell.collectionVw.reloadImageCollection()

                if arrTime9Img.count > 0 {
                   timeCell.btnUpload.isHidden = true
                   timeCell.collectionVw.isHidden = false
                } else {
                   timeCell.btnUpload.isHidden = false
                   timeCell.collectionVw.isHidden = true
                }
                
                timeCell.delegateTime9 = self
                timeCell.txtOther.delegate = self
                
                return timeCell
            } else if indexPath.row == 10 {
                let timeCell = tableView.dequeueReusableCell(withIdentifier: "Time10Cell", for: indexPath) as! Time10TableCell
                       
                timeCell.lblHeader.text = "Does the spa have side switch?"
                
                timeCell.btnUpload.addTarget(self, action: #selector(btnTimeImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                timeCell.collectionVw.arrItems = arrTime10Img
                timeCell.collectionVw.delegateItemCollection = self
                timeCell.collectionVw.reloadImageCollection()

                if arrTime10Img.count > 0 {
                   timeCell.btnUpload.isHidden = true
                   timeCell.collectionVw.isHidden = false
                } else {
                   timeCell.btnUpload.isHidden = false
                   timeCell.collectionVw.isHidden = true
                }
                
                timeCell.delegateTime10 = self
                timeCell.txtOther.delegate = self
                
                return timeCell
            } else if indexPath.row == 11 {
                let timeCell = tableView.dequeueReusableCell(withIdentifier: "Time11Cell", for: indexPath) as! Time11TableCell
                       
                timeCell.lblHeader.text = "Does the spa have an air switch?"
                
                timeCell.btnUpload.addTarget(self, action: #selector(btnTimeImgUpload(_:)), for: UIControl.Event.touchUpInside)

                timeCell.collectionVw.arrItems = arrTime11Img
                timeCell.collectionVw.delegateItemCollection = self
                timeCell.collectionVw.reloadImageCollection()

                if arrTime11Img.count > 0 {
                   timeCell.btnUpload.isHidden = true
                   timeCell.collectionVw.isHidden = false
                } else {
                   timeCell.btnUpload.isHidden = false
                   timeCell.collectionVw.isHidden = true
                }
                
                timeCell.delegateTime11 = self
                timeCell.txtOther.delegate = self
                
                return timeCell
            } else if indexPath.row == 12 {
                let timeCell = tableView.dequeueReusableCell(withIdentifier: "Time12Cell", for: indexPath) as! Time12TableCell
                       
                timeCell.lblHeader.text = "Is there a web/phone based app and does it work?"
                
                timeCell.btnUpload.addTarget(self, action: #selector(btnTimeImgUpload(_:)), for: UIControl.Event.touchUpInside)

                timeCell.collectionVw.arrItems = arrTime12Img
                timeCell.collectionVw.delegateItemCollection = self
                timeCell.collectionVw.reloadImageCollection()

                if arrTime12Img.count > 0 {
                   timeCell.btnUpload.isHidden = true
                   timeCell.collectionVw.isHidden = false
                } else {
                   timeCell.btnUpload.isHidden = false
                   timeCell.collectionVw.isHidden = true
                }
                
                timeCell.delegateTime12 = self
                timeCell.txtOther.delegate = self
                return timeCell
            } else if indexPath.row == 13 {
                let timeCell = tableView.dequeueReusableCell(withIdentifier: "Time13Cell", for: indexPath) as! Time13TableCell
                       
                timeCell.lblHeader.text = "Did system work properly when operated remotely?"
                
                timeCell.btnUpload.addTarget(self, action: #selector(btnTimeImgUpload(_:)), for: UIControl.Event.touchUpInside)

                timeCell.collectionVw.arrItems = arrTime13Img
                timeCell.collectionVw.delegateItemCollection = self
                timeCell.collectionVw.reloadImageCollection()

                if arrTime13Img.count > 0 {
                   timeCell.btnUpload.isHidden = true
                   timeCell.collectionVw.isHidden = false
                } else {
                   timeCell.btnUpload.isHidden = false
                   timeCell.collectionVw.isHidden = true
                }
                
                timeCell.delegateTime13 = self
                timeCell.txtOther.delegate = self
                
                return timeCell
            } else if indexPath.row == 14 {
                let timeCell = tableView.dequeueReusableCell(withIdentifier: "Time14Cell", for: indexPath) as! Time14TableCell
                       
                timeCell.lblHeader.text = "Do all functions work in service mode?"
                
                timeCell.btnUpload.addTarget(self, action: #selector(btnTimeImgUpload(_:)), for: UIControl.Event.touchUpInside)

                timeCell.collectionVw.arrItems = arrTime14Img
                timeCell.collectionVw.delegateItemCollection = self
                timeCell.collectionVw.reloadImageCollection()

                if arrTime14Img.count > 0 {
                   timeCell.btnUpload.isHidden = true
                   timeCell.collectionVw.isHidden = false
                } else {
                   timeCell.btnUpload.isHidden = false
                   timeCell.collectionVw.isHidden = true
                }
                
                timeCell.delegateTime14 = self
                timeCell.txtOther.delegate = self
                
                return timeCell
            } else if indexPath.row == 15 {
                let timeCell = tableView.dequeueReusableCell(withIdentifier: "Time15Cell", for: indexPath) as! Time15TableCell
                       
                timeCell.lblHeader.text = "Are all functions labeled properly?"
                
                timeCell.btnUpload.addTarget(self, action: #selector(btnTimeImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                timeCell.collectionVw.arrItems = arrTime15Img
                timeCell.collectionVw.delegateItemCollection = self
                timeCell.collectionVw.reloadImageCollection()
                
                if arrTime15Img.count > 0 {
                   timeCell.btnUpload.isHidden = true
                   timeCell.collectionVw.isHidden = false
                } else {
                   timeCell.btnUpload.isHidden = false
                   timeCell.collectionVw.isHidden = true
                }
                 
                timeCell.delegateTime15 = self
                timeCell.txtOther.delegate = self
                return timeCell
            } else {
                let timeCell = tableView.dequeueReusableCell(withIdentifier: "Time16Cell", for: indexPath) as! Time16TableCell
                
                timeCell.lblHeader.text = "Are all automated valves syncing/working?"
                
                timeCell.btnUpload.addTarget(self, action: #selector(btnTimeImgUpload(_:)), for: UIControl.Event.touchUpInside)
                
                timeCell.collectionVw.arrItems = arrTime16Img
                timeCell.collectionVw.delegateItemCollection = self
                timeCell.collectionVw.reloadImageCollection()
                
                if arrTime16Img.count > 0 {
                    timeCell.btnUpload.isHidden = true
                    timeCell.collectionVw.isHidden = false
                } else {
                    timeCell.btnUpload.isHidden = false
                    timeCell.collectionVw.isHidden = true
                }
                
                timeCell.delegateTime16 = self
                timeCell.txtOther.delegate = self
                
                return timeCell
            }
        } else if tableView.tag == 35 {
            if indexPath.row == 0 {
                let heaterCell = tableView.dequeueReusableCell(withIdentifier: "SubHeater0Cell", for: indexPath) as! SubHeater0TableCell
                
                heaterCell.lblHeader.text = "The heater is for"
                
                heaterCell.lbl1.text = "Pool Only"
                heaterCell.lbl2.text = "Spa Only"
                heaterCell.lbl3.text = "Pool/Spa Combo"
                heaterCell.lbl4.text = "Other"
                
                heaterCell.delegateSubHeater0 = self
                heaterCell.txtOther.delegate = self
                
                return heaterCell
            } else if indexPath.row == 1 {
                let heaterCell = tableView.dequeueReusableCell(withIdentifier: "HeatProperSizeCell", for: indexPath) as! HeatProperSizeTableCell

                heaterCell.lblHeader.text = "Is the heater properly sized?"

                heaterCell.btnUpload.addTarget(self, action: #selector(btnHeaterImgUpload(_:)), for: UIControl.Event.touchUpInside)

                heaterCell.collectionVw.arrItems = arrHeater1Img
                heaterCell.collectionVw.delegateItemCollection = self
                heaterCell.collectionVw.reloadImageCollection()

                if arrHeater1Img.count > 0 {
                    heaterCell.btnUpload.isHidden = true
                    heaterCell.collectionVw.isHidden = false
                } else {
                    heaterCell.btnUpload.isHidden = false
                    heaterCell.collectionVw.isHidden = true
                }

                heaterCell.delegateHeatProperSize = self
                heaterCell.txtOther.delegate = self
                return heaterCell
            } else if indexPath.row == 2 {
                let heaterCell = tableView.dequeueReusableCell(withIdentifier: "HeatFireUpCell", for: indexPath) as! HeatFireUpTableCell
                
                heaterCell.lblHeader.text = "Did heater fire up properly?"

               heaterCell.btnUpload.addTarget(self, action: #selector(btnHeaterImgUpload(_:)), for: UIControl.Event.touchUpInside)

                heaterCell.collectionVw.arrItems = arrHeater2Img
                heaterCell.collectionVw.delegateItemCollection = self
                heaterCell.collectionVw.reloadImageCollection()

                if arrHeater2Img.count > 0 {
                    heaterCell.btnUpload.isHidden = true
                    heaterCell.collectionVw.isHidden = false
                } else {
                    heaterCell.btnUpload.isHidden = false
                    heaterCell.collectionVw.isHidden = true
                }
                
                heaterCell.delegateHeatFireUp = self
                heaterCell.txtOther.delegate = self
                
                return heaterCell
            } else if indexPath.row == 3 {
                let heaterCell = tableView.dequeueReusableCell(withIdentifier: "HeatErrorCodeCell", for: indexPath) as! HeatErrorCodeTableCell
                
                heaterCell.lblHeader.text = "Are there any error codes on the display?"

                heaterCell.btnUpload.addTarget(self, action: #selector(btnHeaterImgUpload(_:)), for: UIControl.Event.touchUpInside)

                heaterCell.collectionVw.arrItems = arrHeater3Img
                heaterCell.collectionVw.delegateItemCollection = self
                heaterCell.collectionVw.reloadImageCollection()

                if arrHeater3Img.count > 0 {
                    heaterCell.btnUpload.isHidden = true
                    heaterCell.collectionVw.isHidden = false
                } else {
                    heaterCell.btnUpload.isHidden = false
                    heaterCell.collectionVw.isHidden = true
                }
                
                heaterCell.delegateHeatErrorCode = self
                heaterCell.txtOther.delegate = self
                
                return heaterCell
            } else if indexPath.row == 4 {
                let heaterCell = tableView.dequeueReusableCell(withIdentifier: "HeatGasCell", for: indexPath) as! HeatGasTableCell
                
                heaterCell.lblHeader.text = "Is there a gas shutoff valve with proper handle outside of the heater?"
                
                heaterCell.btnUpload.addTarget(self, action: #selector(btnHeaterImgUpload(_:)), for: UIControl.Event.touchUpInside)

                heaterCell.collectionVw.arrItems = arrHeater4Img
                heaterCell.collectionVw.delegateItemCollection = self
                heaterCell.collectionVw.reloadImageCollection()

                if arrHeater4Img.count > 0 {
                    heaterCell.btnUpload.isHidden = true
                    heaterCell.collectionVw.isHidden = false
                } else {
                    heaterCell.btnUpload.isHidden = false
                    heaterCell.collectionVw.isHidden = true
                }
                
                heaterCell.delegateHeatGas = self
                heaterCell.txtOther.delegate = self
                return heaterCell
            } else if indexPath.row == 5 {
                let heaterCell = tableView.dequeueReusableCell(withIdentifier: "HeatHazardCell", for: indexPath) as! HeatHazardTableCell
                
                heaterCell.lblHeader.text = "Is the heater a safe distance from walls or trees for proper ventilation/ fire hazard avoidance?"
                heaterCell.btnUpload.addTarget(self, action: #selector(btnHeaterImgUpload(_:)), for: UIControl.Event.touchUpInside)

                heaterCell.collectionVw.arrItems = arrHeater5Img
                heaterCell.collectionVw.delegateItemCollection = self
                heaterCell.collectionVw.reloadImageCollection()

                if arrHeater5Img.count > 0 {
                    heaterCell.btnUpload.isHidden = true
                    heaterCell.collectionVw.isHidden = false
                } else {
                    heaterCell.btnUpload.isHidden = false
                    heaterCell.collectionVw.isHidden = true
                }
                
                heaterCell.delegateHeatHazard = self
                heaterCell.txtOther.delegate = self
                
                return heaterCell
            } else if indexPath.row == 6 {
                let heaterCell = tableView.dequeueReusableCell(withIdentifier: "HeatExhaustCell", for: indexPath) as! HeatExhaustTableCell
                
                heaterCell.lblHeader.text = "Is there anything mounted above heater that blocks the exhaust?"
                
               heaterCell.btnUpload.addTarget(self, action: #selector(btnHeaterImgUpload(_:)), for: UIControl.Event.touchUpInside)

                heaterCell.collectionVw.arrItems = arrHeater6Img
                heaterCell.collectionVw.delegateItemCollection = self
                heaterCell.collectionVw.reloadImageCollection()

                if arrHeater6Img.count > 0 {
                    heaterCell.btnUpload.isHidden = true
                    heaterCell.collectionVw.isHidden = false
                } else {
                    heaterCell.btnUpload.isHidden = false
                    heaterCell.collectionVw.isHidden = true
                }
                
                heaterCell.delegateHeatExhaust = self
                heaterCell.txtOther.delegate = self
                
                return heaterCell
            } else if indexPath.row == 7 {
                let heaterCell = tableView.dequeueReusableCell(withIdentifier: "HeatEnclosedCell", for: indexPath) as! HeatEnclosedTableCell
                
                heaterCell.lblHeader.text = "If enclosed inside a structure - recommend gas company to inspect for proper venitlation!"
                
                if UIDevice.current.userInterfaceIdiom == .phone {
                    heaterCell.lblHeader.font = UIFont.init(name: "Roboto-bold", size: 16.0)
                } else {
                    heaterCell.lblHeader.font = UIFont.init(name: "Roboto-bold", size: 24.0)
                }
                
                return heaterCell
            } else if indexPath.row == 8 {
                let heaterCell = tableView.dequeueReusableCell(withIdentifier: "HeatDebrisCell", for: indexPath) as! HeatDebrisTableCell
                
                heaterCell.lblHeader.text = "Are internals free of debris?"
                
               heaterCell.btnUpload.addTarget(self, action: #selector(btnHeaterImgUpload(_:)), for: UIControl.Event.touchUpInside)

                heaterCell.collectionVw.arrItems = arrHeater8Img
                heaterCell.collectionVw.delegateItemCollection = self
                heaterCell.collectionVw.reloadImageCollection()

                if arrHeater8Img.count > 0 {
                    heaterCell.btnUpload.isHidden = true
                    heaterCell.collectionVw.isHidden = false
                } else {
                    heaterCell.btnUpload.isHidden = false
                    heaterCell.collectionVw.isHidden = true
                }
                
                heaterCell.delegateHeatDebris = self
                heaterCell.txtOther.delegate = self
                return heaterCell
            } else if indexPath.row == 9 {
                let heaterCell = tableView.dequeueReusableCell(withIdentifier: "HeatWiresCell", for: indexPath) as! HeatWiresTableCell
                
                heaterCell.lblHeader.text = "Are there any exposed wires?"
            
                heaterCell.btnUpload.addTarget(self, action: #selector(btnHeaterImgUpload(_:)), for: UIControl.Event.touchUpInside)

                heaterCell.collectionVw.arrItems = arrHeater9Img
                heaterCell.collectionVw.delegateItemCollection = self
                heaterCell.collectionVw.reloadImageCollection()

                if arrHeater9Img.count > 0 {
                    heaterCell.btnUpload.isHidden = true
                    heaterCell.collectionVw.isHidden = false
                } else {
                    heaterCell.btnUpload.isHidden = false
                    heaterCell.collectionVw.isHidden = true
                }
                
                heaterCell.delegateHeatWires = self
                heaterCell.txtOther.delegate = self
                
                return heaterCell
            } else if indexPath.row == 10 {
                let heaterCell = tableView.dequeueReusableCell(withIdentifier: "HeatCleanCell", for: indexPath) as! HeatCleanTableCell
                
                heaterCell.lblHeader.text = "Are terminals clean?"
            
               heaterCell.btnUpload.addTarget(self, action: #selector(btnHeaterImgUpload(_:)), for: UIControl.Event.touchUpInside)

               heaterCell.collectionVw.arrItems = arrHeater10Img
               heaterCell.collectionVw.delegateItemCollection = self
               heaterCell.collectionVw.reloadImageCollection()

                if arrHeater10Img.count > 0 {
                   heaterCell.btnUpload.isHidden = true
                   heaterCell.collectionVw.isHidden = false
                } else {
                   heaterCell.btnUpload.isHidden = false
                   heaterCell.collectionVw.isHidden = true
                }
                
                heaterCell.delegateHeatClean = self
                heaterCell.txtOther.delegate = self
                
                return heaterCell
            } else {
                let heaterCell = tableView.dequeueReusableCell(withIdentifier: "HeatBurnerCell", for: indexPath) as! HeatBurnerTableCell
                
                heaterCell.lblHeader.text = "is the burner tray clean?"
            
               heaterCell.btnUpload.addTarget(self, action: #selector(btnHeaterImgUpload(_:)), for: UIControl.Event.touchUpInside)

               heaterCell.collectionVw.arrItems = arrHeater11Img
               heaterCell.collectionVw.delegateItemCollection = self
               heaterCell.collectionVw.reloadImageCollection()

               if arrHeater11Img.count > 0 {
                   heaterCell.btnUpload.isHidden = true
                   heaterCell.collectionVw.isHidden = false
               } else {
                   heaterCell.btnUpload.isHidden = false
                   heaterCell.collectionVw.isHidden = true
               }
                heaterCell.delegateHeatBurner = self
                heaterCell.txtOther.delegate = self
                
                return heaterCell
            }
        } else if tableView.tag == 45 {
            if indexPath.row == 0 {
                let cameraCell = tableView.dequeueReusableCell(withIdentifier: "CameraCell", for: indexPath) as! CameraTableCell
                
                cameraCell.lblHeader.text = "Heat Pump"
                 if UIDevice.current.userInterfaceIdiom == .phone {
                    cameraCell.lblHeader.font = UIFont.init(name: "Roboto-bold", size: 16.0)
                 } else {
                    cameraCell.lblHeader.font = UIFont.init(name: "Roboto-bold", size: 24.0)
                }
                
                cameraCell.btnUpload.addTarget(self, action: #selector(btnHeatPumpImgUpload(_:)), for: UIControl.Event.touchUpInside)

                cameraCell.collectionVw.arrItems = arrHeatPumpMainImg
                cameraCell.collectionVw.delegateItemCollection = self
                cameraCell.collectionVw.reloadImageCollection()

                if arrHeatPumpMainImg.count > 0 {
                    cameraCell.btnUpload.isHidden = true
                    cameraCell.collectionVw.isHidden = false
                } else {
                    cameraCell.btnUpload.isHidden = false
                    cameraCell.collectionVw.isHidden = true
                }
                
                return cameraCell
            } else if indexPath.row == 1 {
                let subHeatPumpCell = tableView.dequeueReusableCell(withIdentifier: "HeatPumpOperateCell", for: indexPath) as! HeatPumpOperateTableCell
                
                subHeatPumpCell.lblHeader.text = "Is the heat pump operating properly?"
                
                subHeatPumpCell.btnUpload.addTarget(self, action: #selector(btnHeatPumpImgUpload(_:)), for: UIControl.Event.touchUpInside)

                subHeatPumpCell.collectionVw.arrItems = arrHeatPump1Img
                subHeatPumpCell.collectionVw.delegateItemCollection = self
                subHeatPumpCell.collectionVw.reloadImageCollection()

                if arrHeatPump1Img.count > 0 {
                    subHeatPumpCell.btnUpload.isHidden = true
                    subHeatPumpCell.collectionVw.isHidden = false
                } else {
                    subHeatPumpCell.btnUpload.isHidden = false
                    subHeatPumpCell.collectionVw.isHidden = true
                }
                
                subHeatPumpCell.delegateHeatPumpOperate = self
                subHeatPumpCell.txtOther.delegate = self
                
                return subHeatPumpCell
            } else if indexPath.row == 2 {
                let subHeatPumpCell = tableView.dequeueReusableCell(withIdentifier: "HeatPumpDisplayPanelCell", for: indexPath) as! HeatPumpDisplayPanelTableCell
                
                subHeatPumpCell.lblHeader.text = "Is the display panel working properly?"
                
                subHeatPumpCell.btnUpload.addTarget(self, action: #selector(btnHeatPumpImgUpload(_:)), for: UIControl.Event.touchUpInside)

                subHeatPumpCell.collectionVw.arrItems = arrHeatPump2Img
                subHeatPumpCell.collectionVw.delegateItemCollection = self
                subHeatPumpCell.collectionVw.reloadImageCollection()

                if arrHeatPump2Img.count > 0 {
                    subHeatPumpCell.btnUpload.isHidden = true
                    subHeatPumpCell.collectionVw.isHidden = false
                } else {
                    subHeatPumpCell.btnUpload.isHidden = false
                    subHeatPumpCell.collectionVw.isHidden = true
                }
                
                subHeatPumpCell.delegateHeatPumpDisplayPanel = self
                subHeatPumpCell.txtOther.delegate = self
                return subHeatPumpCell
            } else if indexPath.row == 3 {
                let subHeatPumpCell = tableView.dequeueReusableCell(withIdentifier: "HeatPumpColdAirCell", for: indexPath) as! HeatPumpColdAirTableCell
                
                subHeatPumpCell.lblHeader.text = "Is the heat pump blowing cold air when running?"
                
                subHeatPumpCell.btnUpload.addTarget(self, action: #selector(btnHeatPumpImgUpload(_:)), for: UIControl.Event.touchUpInside)

                subHeatPumpCell.collectionVw.arrItems = arrHeatPump3Img
                subHeatPumpCell.collectionVw.delegateItemCollection = self
                subHeatPumpCell.collectionVw.reloadImageCollection()

                if arrHeatPump3Img.count > 0 {
                    subHeatPumpCell.btnUpload.isHidden = true
                    subHeatPumpCell.collectionVw.isHidden = false
                } else {
                    subHeatPumpCell.btnUpload.isHidden = false
                    subHeatPumpCell.collectionVw.isHidden = true
                }
                
                subHeatPumpCell.delegateHeatPumpColdAir = self
                subHeatPumpCell.txtOther.delegate = self
                return subHeatPumpCell
            } else if indexPath.row == 4 {
                let subHeatPumpCell = tableView.dequeueReusableCell(withIdentifier: "HeatPumpDrainFreeCell", for: indexPath) as! HeatPumpDrainFreeTableCell
                
                subHeatPumpCell.lblHeader.text = "Is the heat pump drain free and clear?"
                
                subHeatPumpCell.btnUpload.addTarget(self, action: #selector(btnHeatPumpImgUpload(_:)), for: UIControl.Event.touchUpInside)

                subHeatPumpCell.collectionVw.arrItems = arrHeatPump4Img
                subHeatPumpCell.collectionVw.delegateItemCollection = self
                subHeatPumpCell.collectionVw.reloadImageCollection()

                if arrHeatPump4Img.count > 0 {
                    subHeatPumpCell.btnUpload.isHidden = true
                    subHeatPumpCell.collectionVw.isHidden = false
                } else {
                    subHeatPumpCell.btnUpload.isHidden = false
                    subHeatPumpCell.collectionVw.isHidden = true
                }
                
                subHeatPumpCell.delegateHeatPumpDrainFree = self
                subHeatPumpCell.txtOther.delegate = self
                return subHeatPumpCell
            } else {
                let subHeatPumpCell = tableView.dequeueReusableCell(withIdentifier: "HeatPumpExposedWiringCell", for: indexPath) as! HeatPumpExposedWiringTableCell
                
                subHeatPumpCell.lblHeader.text = "Is the heat pump have any exposed wiring?"
                
                subHeatPumpCell.btnUpload.addTarget(self, action: #selector(btnHeatPumpImgUpload(_:)), for: UIControl.Event.touchUpInside)

                subHeatPumpCell.collectionVw.arrItems = arrHeatPump5Img
                subHeatPumpCell.collectionVw.delegateItemCollection = self
                subHeatPumpCell.collectionVw.reloadImageCollection()

                if arrHeatPump5Img.count > 0 {
                    subHeatPumpCell.btnUpload.isHidden = true
                    subHeatPumpCell.collectionVw.isHidden = false
                } else {
                    subHeatPumpCell.btnUpload.isHidden = false
                    subHeatPumpCell.collectionVw.isHidden = true
                }
                
                subHeatPumpCell.delegateHeatPumpExposedWiring = self
                subHeatPumpCell.txtOther.delegate = self
                return subHeatPumpCell
            }
        } else {
            if indexPath.row == 0 {
                let cameraCell = tableView.dequeueReusableCell(withIdentifier: "CameraCell", for: indexPath) as! CameraTableCell
                
                cameraCell.lblHeader.text = "Time Clock And Automation"
                if UIDevice.current.userInterfaceIdiom == .phone {
                    cameraCell.lblHeader.font = UIFont.init(name: "Roboto-bold", size: 16.0)
                } else {
                    cameraCell.lblHeader.font = UIFont.init(name: "Roboto-bold", size: 24.0)
                }

                cameraCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                cameraCell.collectionVw.arrItems = arrTimeMainImg
                cameraCell.collectionVw.delegateItemCollection = self
                cameraCell.collectionVw.reloadImageCollection()
                
                if arrTimeMainImg.count > 0 {
                    cameraCell.btnUpload.isHidden = true
                    cameraCell.collectionVw.isHidden = false
                } else {
                    cameraCell.btnUpload.isHidden = false
                    cameraCell.collectionVw.isHidden = true
                }
                
                return cameraCell
            } else if indexPath.row == 1 {
                let timeCell = tableView.dequeueReusableCell(withIdentifier: "TimeMainCell", for: indexPath) as! TimeMainTableCell
                
                timeCell.lblHeader.text = "What type of timeclock is present?"
                
                timeCell.lblYes.text = "Mechanical"
                timeCell.lblNo.text = "Automated"
                timeCell.lbl3.text = "No time clock"
                    
                timeCell.delegateTimeMain = self
                if strTimeMainOpt == "Mechanical" {
                    timeCell.tblSubVw.delegate = self
                    timeCell.tblSubVw.dataSource = self
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        timeCell.tblHeightConstraint.constant = (355*16+345)
                    } else {
                         timeCell.tblHeightConstraint.constant = (600*17)
                    }
                    timeCell.tblSubVw.reloadData()
                } else if strTimeMainOpt == "Automated" {
                    timeCell.tblSubVw.delegate = self
                    timeCell.tblSubVw.dataSource = self
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        timeCell.tblHeightConstraint.constant = (355*16+345)
                    } else {
                        timeCell.tblHeightConstraint.constant = (600*17)
                    }
                    timeCell.tblSubVw.reloadData()
                } else {
                    timeCell.tblHeightConstraint.constant = 0
                }
                return timeCell
            } else if indexPath.row == 2 {
                let cameraCell = tableView.dequeueReusableCell(withIdentifier: "CameraCell", for: indexPath) as! CameraTableCell
                
                cameraCell.lblHeader.text = "Heater"
                if UIDevice.current.userInterfaceIdiom == .phone {
                    cameraCell.lblHeader.font = UIFont.init(name: "Roboto-bold", size: 16.0)
                } else {
                    cameraCell.lblHeader.font = UIFont.init(name: "Roboto-bold", size: 24.0)
                }

                cameraCell.btnUpload.addTarget(self, action: #selector(btnClickedUpload(_:)), for: UIControl.Event.touchUpInside)
                
                cameraCell.collectionVw.arrItems = arrHeaterMainImg
                cameraCell.collectionVw.delegateItemCollection = self
                cameraCell.collectionVw.reloadImageCollection()
                
                if arrHeaterMainImg.count > 0 {
                    cameraCell.btnUpload.isHidden = true
                    cameraCell.collectionVw.isHidden = false
                } else {
                    cameraCell.btnUpload.isHidden = false
                    cameraCell.collectionVw.isHidden = true
                }
                
                return cameraCell
            } else if indexPath.row == 3 {
                let heaterCell = tableView.dequeueReusableCell(withIdentifier: "HeatCell", for: indexPath) as! Heat0TableCell
                
                heaterCell.lblHeader.text = "Is a heater present?"
                
                heaterCell.lblYes.text = "Yes"
                heaterCell.lblNo.text = "No"
                
                if strHeatOpt == "Yes" {
                    heaterCell.tblHeaterVw.delegate = self
                    heaterCell.tblHeaterVw.dataSource = self
                    heaterCell.tblHeatPumpVw.delegate = self
                    heaterCell.tblHeatPumpVw.dataSource = self
                    if strSubHeatOpt == "Heater" {
                        heaterCell.tblHeaterVw.isHidden = false
                        heaterCell.tblHeatPumpVw.isHidden = true
                        if UIDevice.current.userInterfaceIdiom == .phone {
                            heaterCell.tblHeatHtConstraint.constant = 200+270+(350*11)
                        } else {
                            let height: CGFloat = 310+500+100
                             heaterCell.tblHeatHtConstraint.constant = height+(600*10)
                        }
                        heaterCell.tblHeaterVw.reloadData()
                    } else if strSubHeatOpt == "Heat Pump" {
                        heaterCell.tblHeaterVw.isHidden = true
                        heaterCell.tblHeatPumpVw.isHidden = false
                        if UIDevice.current.userInterfaceIdiom == .phone {
                            heaterCell.tblPumpHtConstraint.constant = 200+185+(350*5)
                        } else {
                             heaterCell.tblPumpHtConstraint.constant = 310+320+(600*5)
                        }
                        heaterCell.tblHeatPumpVw.reloadData()
                    } else {
                        if UIDevice.current.userInterfaceIdiom == .phone {
                            heaterCell.tblHeatHtConstraint.constant = 190 + 120
                        } else {
                            heaterCell.tblHeatHtConstraint.constant = 190 + 120
                        }
                        heaterCell.tblHeaterVw.isHidden = true
                        heaterCell.tblHeatPumpVw.isHidden = true
                        heaterCell.tblHeatPumpVw.reloadData()
                        heaterCell.tblHeaterVw.reloadData()
                    }
                } else {
                    heaterCell.tblHeatHtConstraint.constant = 190
                }
                
                heaterCell.delegateHeat = self
                heaterCell.delegateHeatOrHeatPump = self
                
                return heaterCell
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
                if indexPath.row == 16 {
                    return 345
                } else {
                    return 355
                }
            } else if tableView.tag == 35{
                if indexPath.row == 0 {
                    return 270
                } else if indexPath.row == 7 {
                    return 100
                } else {
                    return 340
                }
            } else if tableView.tag == 45 {
                if indexPath.row == 0 {
                    return 185
                } else {
                    return 350
                }
            } else {
                if indexPath.row == 0 {
                    return 185
                } else if indexPath.row == 1 {
                    if strTimeMainOpt == "Mechanical" {
                        return (355*16+345)+150
                    } else if strTimeMainOpt == "Automated" {
                        return (355*16+345)+150
                    } else {
                        return 150
                    }
                } else if indexPath.row == 2 {
                    return 185
                } else if indexPath.row == 3 {
                    if strHeatOpt == "Yes" {
                        if strSubHeatOpt == "Heater" {
                            return 120+(80+270+100+(350*10))
                        } else if strSubHeatOpt == "Heat Pump" {
                            return 120+(80+185+(350*5))
                        } else {
                            return 120+80
                        }
                    } else {
                        return 120
                    }
                }
                else {
                    return 105
                }
            }
        } else {        //.pad
            if tableView.tag == 25 {
                if indexPath.row == 16 {
                    return 600
                } else {
                    return 600
                }
            } else if tableView.tag == 35{
                if indexPath.row == 0 {
                    return 500
                } else if indexPath.row == 7 {
                    return 100
                } else {
                    return 600
                }
            } else if tableView.tag == 45 {
                if indexPath.row == 0 {
                    return 320
                } else {
                    return 600
                }
            } else {
                if indexPath.row == 0 {
                    return 320
                } else if indexPath.row == 1 {
                    if strTimeMainOpt == "Mechanical" {
                        return (600*17)+250
                    } else if strTimeMainOpt == "Automated" {
                        return (600*17)+250
                    } else {
                        return 250
                    }
                } else if indexPath.row == 2 {
                    return 320
                } else if indexPath.row == 3 {
                    if strHeatOpt == "Yes" {
                        if strSubHeatOpt == "Heater" {
                            return 190+(120+500+100+(600*10))
                        } else if strSubHeatOpt == "Heat Pump" {
                            return 190+120+(320+(600*5))
                        } else {
                            return 190+120
                        }
                    } else {
                        return 190
                    }
                } else {
                    return 175
                }
            }
        }
    }
}

extension InspectClockVC: TimeMainProtocol, Time0Protocol, Time1Protocol, Time2Protocol, Time3Protocol, Time4Protocol, Time5Protocol, Time6Protocol, Time7Protocol, Time8Protocol, Time9Protocol, Time10Protocol, Time11Protocol, Time12Protocol, Time13Protocol, Time14Protocol, Time15Protocol, Time16Protocol,Heat0Protocol,HeatOrHeatPumpProtocol ,SubHeater0Protocol,HeatProperSizeProtocol,HeatFireUpProtocol,HeatErrorCodeProtocol,HeatGasProtocol,HeatHazardProtocol,HeatExhaustProtocol,HeatDebrisProtocol,HeatWiresProtocol,HeatCleanProtocol,HeatBurnerProtocol,HeatPumpOperateProtocol,HeatPumpDisplayPanelProtocol,HeatPumpColdAirProtocol,HeatPumpDrainFreeProtocol,HeatPumpExposedWiringProtocol{
    
    //MARK:- Time Machine
    func didTapOnCellTimeMain(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strTimeMainOpt = "Mechanical"
        } else if _btnDescribeTag == 1 {
            strTimeMainOpt = "Automated"
        } else if _btnDescribeTag == 2 {
            strTimeMainOpt = "No time clock"
        }
        self.tblClock.reloadData()
    }
    
    func didTapOnCellTime0(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strTime0Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strTime0Opt = "No"
        }
       // self.tblClock.reloadData()
    }
    
    func didTapOnCellTime1(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strTime1Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strTime1Opt = "No"
        }
       // self.tblClock.reloadData()
    }
    
    func didTapOnCellTime2(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strTime2Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strTime2Opt = "No"
        }
        //self.tblClock.reloadData()
    }
    
    func didTapOnCellTime3(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strTime3Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strTime3Opt = "No"
        }
        //self.tblClock.reloadData()
    }
    
    func didTapOnCellTime4(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strTime4Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strTime4Opt = "No"
        }
        //self.tblClock.reloadData()
    }
    
    func didTapOnCellTime5(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strTime5Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strTime5Opt = "No"
        }
       // self.tblClock.reloadData()
    }
    
    func didTapOnCellTime6(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strTime6Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strTime6Opt = "No"
        }
       // self.tblClock.reloadData()
    }
    
    func didTapOnCellTime7(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strTime7Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strTime7Opt = "No"
        }
        //self.tblClock.reloadData()
    }
    
    func didTapOnCellTime8(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strTime8Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strTime8Opt = "No"
        }
        //self.tblClock.reloadData()
    }
    
    func didTapOnCellTime9(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strTime9Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strTime9Opt = "No"
        }
       // self.tblClock.reloadData()
    }
    
    func didTapOnCellTime10(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strTime10Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strTime10Opt = "No"
        }
       // self.tblClock.reloadData()
    }
    
    func didTapOnCellTime11(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strTime11Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strTime11Opt = "No"
        }
       // self.tblClock.reloadData()
    }
    
    func didTapOnCellTime12(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strTime12Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strTime12Opt = "No"
        }
       // self.tblClock.reloadData()
    }
    
    func didTapOnCellTime13(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strTime13Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strTime13Opt = "No"
        }
       // self.tblClock.reloadData()
    }
    
    func didTapOnCellTime14(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strTime14Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strTime14Opt = "No"
        }
       // self.tblClock.reloadData()
    }
    
    func didTapOnCellTime15(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strTime15Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strTime15Opt = "No"
        }
        //self.tblClock.reloadData()
    }
    
    func didTapOnCellTime16(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strTime16Opt = "Yes"
        } else if _btnDescribeTag == 1 {
            strTime16Opt = "No"
        }
       // self.tblClock.reloadData()
    }
    
    //MARK:- Heat
    
    func didTapOnCellHeat(_btnDescribeTag: Int) {
        if _btnDescribeTag == 0 {
            strHeatOpt = "Yes"
        } else if _btnDescribeTag == 1 {
            strHeatOpt = "No"
        }
        self.tblClock.reloadData()
    }
       
    func didTapOnCellHeatOrHeatPump(_btnDescribeTag: Int) {
       if _btnDescribeTag == 0 {
           strSubHeatOpt = "Heater"
       } else if _btnDescribeTag == 1 {
           strSubHeatOpt = "Heat Pump"
       }
       self.tblClock.reloadData()
    }
    
    func didTapOnCellSubHeater0(_btnDescribeTag: Int){
        if _btnDescribeTag == 0 {
            strSubHeater0Opt = "Pool only"
        } else if _btnDescribeTag == 1 {
            strSubHeater0Opt = "Spa only"
        } else if _btnDescribeTag == 2 {
            strSubHeater0Opt = "Pool/Spa combo"
        } else {
            strSubHeater0Opt = "Other"
        }
    }
    
    func didTapOnCellHeatProperSize(_btnDescribeTag: Int){
        if _btnDescribeTag == 0 {
            strHeatProperSizeOpt = "Yes"
        } else if _btnDescribeTag == 1 {
            strHeatProperSizeOpt = "No"
        }
    }
    
    func didTapOnCellHeatFireUp(_btnDescribeTag: Int){
        if _btnDescribeTag == 0 {
            strHeatFireUpOpt = "Yes"
        } else if _btnDescribeTag == 1 {
            strHeatFireUpOpt = "No"
        }
    }
    
    func didTapOnCellHeatErrorCode(_btnDescribeTag: Int){
        if _btnDescribeTag == 0 {
            strHeatErrorCodeOpt = "Yes"
        } else if _btnDescribeTag == 1 {
            strHeatErrorCodeOpt = "No"
        }
    }
    
    func didTapOnCellHeatGas(_btnDescribeTag: Int){
        if _btnDescribeTag == 0 {
            strHeatGasOpt = "Yes"
        } else if _btnDescribeTag == 1 {
            strHeatGasOpt = "No"
        }
    }
    
    func didTapOnCellHeatHazard(_btnDescribeTag: Int){
        if _btnDescribeTag == 0 {
            strHeatHazardOpt = "Yes"
        } else if _btnDescribeTag == 1 {
            strHeatHazardOpt = "No"
        }
    }
    
    func didTapOnCellHeatExhaust(_btnDescribeTag: Int){
        if _btnDescribeTag == 0 {
            strHeatExhaustOpt = "Yes"
        } else if _btnDescribeTag == 1 {
            strHeatExhaustOpt = "No"
        }
    }
    
    func didTapOnCellHeatDebris(_btnDescribeTag: Int){
        if _btnDescribeTag == 0 {
            strHeatExhaustOpt = "Yes"
        } else if _btnDescribeTag == 1 {
            strHeatExhaustOpt = "No"
        }
    }
    
    func didTapOnCellHeatWires(_btnDescribeTag: Int){
        if _btnDescribeTag == 0 {
           strHeatWiresOpt = "Yes"
        } else if _btnDescribeTag == 1 {
           strHeatWiresOpt = "No"
        }
    }
    
    func didTapOnCellHeatClean(_btnDescribeTag: Int){
        if _btnDescribeTag == 0 {
           strHeatCleanOpt = "Yes"
        } else if _btnDescribeTag == 1 {
           strHeatCleanOpt = "No"
        }
    }
    
    func didTapOnCellHeatBurner(_btnDescribeTag: Int){
       if _btnDescribeTag == 0 {
          strHeatBurnerOpt = "Yes"
       } else if _btnDescribeTag == 1 {
          strHeatBurnerOpt = "No"
       }
    }
    
    //MARK:- Heat Pump
    func didTapOnCellHeatPumpOperate(_btnDescribeTag: Int){
        if _btnDescribeTag == 0 {
            strHeatPumpOperateOpt = "Yes"
        } else if _btnDescribeTag == 1 {
            strHeatPumpOperateOpt = "No"
        }
    }
    
    func didTapOnCellHeatPumpDisplayPanel(_btnDescribeTag: Int){
        if _btnDescribeTag == 0 {
           strHeatPumpDisplayPanelOpt = "Yes"
        } else if _btnDescribeTag == 1 {
           strHeatPumpDisplayPanelOpt = "No"
        }
    }
    
    func didTapOnCellHeatPumpColdAir(_btnDescribeTag: Int){
        if _btnDescribeTag == 0 {
            strHeatPumpColdAirOpt = "Yes"
        } else if _btnDescribeTag == 1 {
            strHeatPumpColdAirOpt = "No"
        }
    }
    
    func didTapOnCellHeatPumpDrainFree(_btnDescribeTag: Int){
        if _btnDescribeTag == 0 {
            strHeatPumpDrainFreeOpt = "Yes"
        } else if _btnDescribeTag == 1 {
            strHeatPumpDrainFreeOpt = "No"
        }
    }
    
    func didTapOnCellHeatPumpExposedWiring(_btnDescribeTag: Int){
        if _btnDescribeTag == 0 {
            strHeatPumpExposedWiringOpt = "Yes"
        } else if _btnDescribeTag == 1 {
            strHeatPumpExposedWiringOpt = "No"
        }
    }
}

