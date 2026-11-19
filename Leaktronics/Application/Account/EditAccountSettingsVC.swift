//
//  EditAccountSettingsVC.swift
//  Leaktronics
//
//  Created by ivaninfotech on 6/8/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire
import SVProgressHUD

class EditAccountSettingsVC: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var vwProfile: UIView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txtUserEmail: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtCompanyName: UITextField!
    @IBOutlet weak var txtCompanyPhone: UITextField!
    @IBOutlet weak var txtCompanyWebsite: UITextField!
    @IBOutlet weak var txtCompanyAddress1: UITextField!
    @IBOutlet weak var txtCompanyAddress2: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtDistrict: UITextField!
    @IBOutlet weak var txtZipcode: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var indicatorVw: UIActivityIndicatorView!
    
    var logIndict = NSDictionary()
    var fileUrl = NSURL()
    var login_Token = String()
    
    //For UIImagePickerController
    var imagePicker = UIImagePickerController()
    //var profileImage : UIImage!
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setDesign()
        
        let loginData = UserDefaults.standard.object(forKey: "key_profile_info")
        logIndict = NSKeyedUnarchiver.unarchiveObject(with: loginData as! Data) as! NSDictionary
        print("UserDict: == \(logIndict)")
        login_Token = UserDefaults.standard.value(forKey: "key_token") as! String 
        
        self.indicatorVw.startAnimating()
        self.indicatorVw.isHidden = false
        self.setDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let backButton = UIBarButtonItem()
        backButton.title = "" //"My Account"
        backButton.tintColor = UIColor.black
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    

    //MARK:- Function
    func setDesign() {
        imgProfile.layer.cornerRadius = 10
        imgProfile.clipsToBounds = true
        vwProfile.layer.cornerRadius = 10
        vwProfile.layer.shadowPath = UIBezierPath(rect: vwProfile.bounds).cgPath
        vwProfile.layer.shadowRadius = 5
        vwProfile.layer.shadowOffset = .zero
        vwProfile.layer.shadowOpacity = 1
    }
    
    func setDetails() {
        //For Profile Dp
        if ((logIndict["profile_img"] as? String) != nil) {
            if (logIndict["profile_img"] is NSNull || logIndict["profile_img"] == nil) {
                imgProfile.image = UIImage(named: "UserProfile_Dummy")
            } else {
                let imageUrl = "\(logIndict.value(forKey: "profile_img")!)"
                if imageUrl .isEmpty {
                    imgProfile.image = UIImage(named: "UserProfile_Dummy")
                } else {
                    let fullUrl = ServiceConstant.PROFILE_BASE_URL.appending(imageUrl)
                    fileUrl = NSURL(string: fullUrl)!
                    
                    print("IUmageURL: === \(fullUrl)")
                    imgProfile.image = UIImage(named: "UserProfile_Dummy")
                    
                    
                    SDWebImageManager.shared().downloadImage(with: NSURL(string: fullUrl) as URL?, options: .continueInBackground, progress: {
                        (receivedSize :Int, ExpectedSize :Int) in
                    }, completed: {
                        (image : UIImage?, error : Error?, cacheType : SDImageCacheType, finished : Bool, url : URL?) in
                        self.imgProfile.image = image
                        self.imgProfile.contentMode = .scaleAspectFill
                    })
                }
            }
            self.indicatorVw.isHidden = true
            self.indicatorVw.stopAnimating()
        } else {
            imgProfile.image = UIImage(named: "UserProfile_Dummy")
        }
        
        //For Profile User Email
        if ((logIndict["email"] as? String) != nil) {
            txtUserEmail.text = logIndict.value(forKey: "email") as? String
        }
        
            //For Profile User Name
        if ((logIndict["name"] as? String) != nil) {
            txtUserName.text = logIndict.value(forKey: "name") as? String
        }
        
        //For Profile Company Name
        if ((logIndict["company_name"] as? String) != nil) {
            txtCompanyName.text = logIndict.value(forKey: "company_name") as? String
        }
        
        //For Profile Company Phone
        if ((logIndict["company_number"] as? String) != nil) {
            txtCompanyPhone.text = logIndict.value(forKey: "company_number") as? String
        }
        
        //For Profile Company Website
        if ((logIndict["company_website"] as? String) != nil) {
            txtCompanyWebsite.text = logIndict.value(forKey: "company_website") as? String
        }
        
        //For Profile Company Address1
        if ((logIndict["company_address_1"] as? String) != nil) {
            txtCompanyAddress1.text = logIndict.value(forKey: "company_address_1") as? String
        }
        
        //For Profile Company Address2
        if ((logIndict["company_address_2"] as? String) != nil) {
            txtCompanyAddress2.text = logIndict.value(forKey: "company_address_2") as? String
        }
        
        //For Profile Company City
        if ((logIndict["company_city"] as? String) != nil) {
            txtCity.text = logIndict.value(forKey: "company_city") as? String
        }
        
        //For Profile Company State
        if ((logIndict["company_state"] as? String) != nil) {
            txtState.text = logIndict.value(forKey: "company_state") as? String
        }
        
        //For Profile Company District
        if ((logIndict["district_court"] as? String) != nil) {
            txtDistrict.text = logIndict.value(forKey: "district_court") as? String
        }
        
        //For Profile Company ZipCode
        if ((logIndict["company_zipcode"] as? String) != nil) {
            txtZipcode.text = logIndict.value(forKey: "company_zipcode") as? String
        }
        
    }
    
    //MARK:- Method to Open camera
    func openCamera() {
        if (UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            //self.strDetermineCameraOrMedia = "camera"
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.delegate = self
            self .present(imagePicker, animated: true, completion: nil)
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
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()

        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary

        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func actionSheetPopUpForGalleryOpen() {
        let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.openCamera()
        }
        let gallaryAction = UIAlertAction(title: "Library", style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.openGallary()
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
        }
        
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        
        //------------------------
        // Present the controller
        //-------------------------
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.present(alert, animated: true, completion: nil)
        } else {
            if let popoverController = alert.popoverPresentationController {
                popoverController.sourceView = self.view
                popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                popoverController.permittedArrowDirections = UIPopoverArrowDirection.up
            }
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK:- @IBAction
    @IBAction func btnProfileImageUpload() {
        self.actionSheetPopUpForGalleryOpen()
    }
    
    @IBAction func btnSaveProfileDetails() {
        self.setUpdateUserDetails()
    }
    
    //MARK:: Function Api Calling
    func setUpdateUserDetails() {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        let token: String = UserDefaults.standard.value(forKey: "key_token") as! String
        
        let headers = [
            "Authorization": token,
            //"Content-Type": "application/x-www-form-urlencoded"
        ]
        let url = ServiceConstant.BASE_IMAGEURL.appending(ServiceConstant.UpdateProfile)
        var parameters = [String: String]()
        
        parameters["user_name"] = self.txtUserName.text
        parameters["company_name"] = self.txtCompanyName.text
        parameters["company_number"] = self.txtCompanyPhone.text
        parameters["company_website"] = self.txtCompanyWebsite.text
        parameters["company_address_1"] = self.txtCompanyAddress1.text
        parameters["company_address_2"] = self.txtCompanyAddress2.text
        parameters["company_city"] = self.txtCity.text
        parameters["company_state"] = self.txtState.text
        parameters["district_court"] = self.txtDistrict.text
        parameters["company_zipcode"] = self.txtZipcode.text
        
        print(parameters)
        Alamofire.upload(multipartFormData: { multipartFormData in
            if self.imgProfile != nil {
                //DispatchQueue.main.async {
                    let imageData = self.imgProfile.image!.jpeg(.high)
                    multipartFormData.append(imageData!, withName: "user_image", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
//                }
            }
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
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
                    
                    if String(describing: json["status"]!) == "1" {
                        let data: [String: AnyObject] = json["data"] as! [String : AnyObject]
                        print("JSON data: \(String(describing: data))")

                        let dicProfile : [String: AnyObject] = ((data["profile"] as AnyObject) as! [String : AnyObject])
                        let dataPro = NSKeyedArchiver.archivedData(withRootObject: dicProfile)
                        UserDefaults.standard.set(dataPro, forKey: "key_profile_info")

                        let alertController = UIAlertController(title: "", message: json["message"] as? String, preferredStyle: UIAlertController.Style.alert)
                        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
                           print("OK")
                           self.indicatorVw.isHidden = true
                            self.navigationController?.popViewController(animated: true)
                            /*if UIDevice.current.userInterfaceIdiom == .phone {
                                let storyBoard : UIStoryboard = UIStoryboard(name: "Home_iPhone", bundle:nil)
                                let nextVC = storyBoard.instantiateViewController(withIdentifier: "AccountSettings") as! AccountSettingsVC
                                self.navigationController?.popViewController(animated: true)
                            } else if UIDevice.current.userInterfaceIdiom == .pad {
                                let storyBoard : UIStoryboard = UIStoryboard(name: "Home_iPad", bundle:nil)
                                let nextVC = storyBoard.instantiateViewController(withIdentifier: "AccountSettings") as! AccountSettingsVC
                                self.navigationController?.pushViewController(nextVC, animated: true)
                            }*/
                        }
                        
                        alertController.addAction(okAction);
                        self.present(alertController, animated: true, completion: nil)
                    } else if String(describing: json["status"]!) == "0" {
                        let alertController = UIAlertController(title: "", message: json["message"] as? String, preferredStyle: UIAlertController.Style.alert)
                        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
                           print("OK")
                           self.indicatorVw.isHidden = true
                        }
                        
                        alertController.addAction(okAction);
                        self.present(alertController, animated: true, completion: nil)
                    }
                    SVProgressHUD.dismiss()
                }
            case .failure(let encodingError):
                print("error:\(encodingError)")
                let strError: String = encodingError.localizedDescription
                let alertController = UIAlertController(title: "", message: strError, preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
                    print("OK")
                    self.indicatorVw.isHidden = true
                    SVProgressHUD.dismiss()
                }
                alertController.addAction(okAction);
                self.present(alertController, animated: true, completion: nil)
            }
        })
    }
}

extension EditAccountSettingsVC: UIImagePickerControllerDelegate {
    // MARK:: UIImagePickerControllerDelegate
    //For xcode 10
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let possibleImage = info[.originalImage] as? UIImage
            else {
                fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
                //return
        }
        
        // Set photoImageView to display the selected image.
        imgProfile.image = possibleImage
        imgProfile.clipsToBounds = true
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
}
