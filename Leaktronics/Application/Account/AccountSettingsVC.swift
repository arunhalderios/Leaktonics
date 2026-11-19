//
//  AccountSettingsVC.swift
//  Leaktronics
//
//  Created by Abhishek Mullick on 09/07/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import SDWebImage
//import Alamofire
//import SVProgressHUD

class AccountSettingsVC: UIViewController {
    
    @IBOutlet weak var vwProfile: UIView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblUserEmail: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblCompanyName: UILabel!
    @IBOutlet weak var lblCompanyPhone: UILabel!
    @IBOutlet weak var lblCompanyWebsite: UILabel!
    @IBOutlet weak var lblCompanyAddress1: UILabel!
    @IBOutlet weak var lblCompanyAddress2: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblDistrict: UILabel!
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var lblZipcode: UILabel!
    @IBOutlet weak var indicatorVw: UIActivityIndicatorView!
    
    var logIndict = NSDictionary()
    var fileUrl = NSURL()
    var login_Token = String()
    
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setDesign()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let backButton = UIBarButtonItem()
        backButton.title = "" //"My Account"
        backButton.tintColor = UIColor.black
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        
        
        let loginData = UserDefaults.standard.object(forKey: "key_profile_info")
        logIndict = NSKeyedUnarchiver.unarchiveObject(with: loginData as! Data) as! NSDictionary
        print("UserDict: == \(logIndict)")
        login_Token = UserDefaults.standard.value(forKey: "key_token") as! String
        
        self.indicatorVw.startAnimating()
        self.indicatorVw.isHidden = false
        self.setDetails()
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
                    
                    print("ImageURL: === \(fullUrl)")
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
            self.indicatorVw.isHidden = true
            self.indicatorVw.stopAnimating()
        }
        
        //For Profile User Email
        if ((logIndict["email"] as? String) != nil) {
            lblUserEmail.text = logIndict.value(forKey: "email") as? String
        }
        
            //For Profile User Name
        if ((logIndict["name"] as? String) != nil) {
            lblUserName.text = logIndict.value(forKey: "name") as? String
        }
        
        //For Profile Company Name
        if ((logIndict["company_name"] as? String) != nil) {
            lblCompanyName.text = logIndict.value(forKey: "company_name") as? String
        }
        
        //For Profile Company Phone
        if ((logIndict["company_number"] as? String) != nil) {
            lblCompanyPhone.text = logIndict.value(forKey: "company_number") as? String
        }
        
        //For Profile Company Website
        if ((logIndict["company_website"] as? String) != nil) {
            lblCompanyWebsite.text = logIndict.value(forKey: "company_website") as? String
        }
        
        //For Profile Company Address1
        if ((logIndict["company_address_1"] as? String) != nil) {
            lblCompanyAddress1.text = logIndict.value(forKey: "company_address_1") as? String
        }
        
        //For Profile Company Address2
        if ((logIndict["company_address_2"] as? String) != nil) {
            lblCompanyAddress2.text = logIndict.value(forKey: "company_address_2") as? String
        }
        
        //For Profile Company City
        if ((logIndict["company_city"] as? String) != nil) {
            lblCity.text = logIndict.value(forKey: "company_city") as? String
        }
        
        //For Profile Company State
        if ((logIndict["company_state"] as? String) != nil) {
            lblState.text = logIndict.value(forKey: "company_state") as? String
        }
        
        //For Profile Company District
        if ((logIndict["district_court"] as? String) != nil) {
            lblDistrict.text = logIndict.value(forKey: "district_court") as? String
        }
        
        //For Profile Company ZipCode
        if ((logIndict["company_zipcode"] as? String) != nil) {
            lblZipcode.text = logIndict.value(forKey: "company_zipcode") as? String
        }
        
    }
    
    //MARK:- @IBAction
       @IBAction func btnEditAccountDidTap() {
           if UIDevice.current.userInterfaceIdiom == .phone {
               let storyBoard : UIStoryboard = UIStoryboard(name: "Home_iPhone", bundle:nil)
               let nextVC = storyBoard.instantiateViewController(withIdentifier: "EditAccountSettings") as! EditAccountSettingsVC
               self.navigationController?.pushViewController(nextVC, animated: true)
           } else if UIDevice.current.userInterfaceIdiom == .pad {
               let storyBoard : UIStoryboard = UIStoryboard(name: "Home_iPad", bundle:nil)
               let nextVC = storyBoard.instantiateViewController(withIdentifier: "EditAccountSettings") as! EditAccountSettingsVC
               self.navigationController?.pushViewController(nextVC, animated: true)
           }
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
