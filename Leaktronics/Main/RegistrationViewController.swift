//
//  RegistrationViewController.swift
//  Leaktronics
//
//  Created by Abhishek Mullick on 06/04/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import MaterialComponents
import UINavigationBar_Transparent
import Alamofire
import SVProgressHUD

class RegistrationViewController: UIViewController {

    //MARK:- Variable declaration
    @IBOutlet weak var btnSigninOutlet: UIButton!
    @IBOutlet weak var vwName: CustomOutlinedTxtField!
    @IBOutlet weak var vwEmail: CustomOutlinedTxtField!
    @IBOutlet weak var vwPassword: CustomOutlinedTxtField!
    @IBOutlet weak var vwCouponCode: CustomOutlinedTxtField!
    var deviceID = String()
    @IBOutlet weak var lblSubscriptionDays: UILabel!
    @IBOutlet weak var vwCouponApplied: UIView!
    @IBOutlet weak var lblCouponValidStatus: UILabel!
    @IBOutlet weak var btnPasswordVisionOutlet: UIButton!
    var iconClick = true
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.vwCouponApplied.isHidden = true
        self.lblSubscriptionDays.isHidden = true
        self.btnSigninOutlet.layer.cornerRadius = 5
        self.btnSigninOutlet.layer.masksToBounds = true
        
        self.vwName.textField.delegate = self
        self.vwEmail.textField.delegate = self
        self.vwPassword.textField.delegate = self
        self.vwCouponCode.textField.delegate = self
        self.vwPassword.textField.isSecureTextEntry = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.vwEmail.textField.autocapitalizationType = .none
        self.navigationItem.setHidesBackButton(true, animated: true);
        self.navigationController?.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationController?.navigationBar.topItem?.hidesBackButton = true
        self.navigationController?.navigationBar.setBarColor(UIColor.clear)
        self.deviceID = (UIDevice.current.identifierForVendor?.uuidString)!
    }
    
    //MARK:- Signup Button Action
    @IBAction func btnSignupDidTap(_ sender: Any){
        if self.vwEmail.textField.text! == "" && self.vwPassword.textField.text! == "" && self.vwName.textField.text! == ""{
            self.vwEmail.textField.attributedPlaceholder = NSAttributedString(string: "Please enter a valid email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            self.vwPassword.textField.attributedPlaceholder = NSAttributedString(string: "Please enter password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            self.vwName.textField.attributedPlaceholder = NSAttributedString(string: "Please enter name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
 
            
            self.vwEmail.textFieldControllerFloating.inlinePlaceholderColor = UIColor.red
            self.vwEmail.textFieldControllerFloating.normalColor = UIColor.red
            
            self.vwPassword.textFieldControllerFloating.inlinePlaceholderColor = UIColor.red
            self.vwPassword.textFieldControllerFloating.normalColor = UIColor.red
            
            self.vwName.textFieldControllerFloating.inlinePlaceholderColor = UIColor.red
            self.vwName.textFieldControllerFloating.normalColor = UIColor.red
            
            
            let alert = UIAlertController(title: "Alert", message: "Every field is mandatory", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        if (self.vwName.textField.text!.count == 0 || self.vwName.textField.text!.isEmpty || (self.vwName.textField.text?.trimmingCharacters(in: .whitespaces).isEmpty)!){
              self.vwName.textField.attributedPlaceholder = NSAttributedString(string: "Name field cannot be blank", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
              self.vwName.textFieldControllerFloating.inlinePlaceholderColor = UIColor.red
              self.vwName.textFieldControllerFloating.normalColor = UIColor.red
        } else{
           self.vwName.textFieldControllerFloating.floatingPlaceholderActiveColor = UIColor.lightGray
           self.vwName.textFieldControllerFloating.inlinePlaceholderColor = UIColor.lightGray
           self.vwName.textFieldControllerFloating.normalColor = UIColor.lightGray
        }
        
        if (self.vwEmail.textField.text!.count == 0 || self.vwEmail.textField.text!.isEmpty || (self.vwEmail.textField.text?.trimmingCharacters(in: .whitespaces).isEmpty)!){
               self.vwEmail.textField.attributedPlaceholder = NSAttributedString(string: "Email field cannot be blank", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
               self.vwEmail.textFieldControllerFloating.inlinePlaceholderColor = UIColor.red
               self.vwEmail.textFieldControllerFloating.normalColor = UIColor.red
        } else{
            self.vwEmail.textFieldControllerFloating.floatingPlaceholderActiveColor = UIColor.lightGray
            self.vwEmail.textFieldControllerFloating.inlinePlaceholderColor = UIColor.lightGray
            self.vwEmail.textFieldControllerFloating.normalColor = UIColor.lightGray
        }
        if (self.vwPassword.textField.text!.count == 0 || self.vwPassword.textField.text!.isEmpty || (self.vwPassword.textField.text?.trimmingCharacters(in: .whitespaces).isEmpty)!){
                self.vwPassword.textField.attributedPlaceholder = NSAttributedString(string: "Password field cannot be blank", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                self.vwPassword.textFieldControllerFloating.inlinePlaceholderColor = UIColor.red
                self.vwPassword.textFieldControllerFloating.normalColor = UIColor.red
        }else{
            if (self.vwPassword.textField.text!.count) < 6{
                self.vwPassword.textField.text = ""
                self.vwPassword.textField.placeholder = "Password needs to be maximum of 6 characters long."
                self.vwPassword.textFieldControllerFloating.inlinePlaceholderColor = UIColor.red
                self.vwPassword.textFieldControllerFloating.normalColor = UIColor.red
             }
            else{
                self.vwPassword.textFieldControllerFloating.inlinePlaceholderColor = UIColor.lightGray
                self.vwPassword.textFieldControllerFloating.normalColor = UIColor.lightGray
            }
        }
        if !(isValidEmail(testStr: self.vwEmail.textField.text!)){
          self.vwEmail.textField.attributedPlaceholder = NSAttributedString(string: "Please enter a valid email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
          self.vwEmail.textFieldControllerFloating.inlinePlaceholderColor = UIColor.red
          self.vwEmail.textFieldControllerFloating.normalColor = UIColor.red
        }
        else{
            self.registrationApiCall()
        }
        
    }
    
    //MARK:- Email Validation Checking
   func isValidEmail(testStr:String) -> Bool {
       let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
       
       let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
       return emailTest.evaluate(with: testStr)
   }
    
    //MARK:- Login Api Call
    
    func registrationApiCall() {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
                  
        let todosEndpoint: String = ServiceConstant.BASE_URL + ServiceConstant.Register

        let newTodo: [String: Any] = ["name": self.vwName.textField.text!,"email": self.vwEmail.textField.text!, "password": self.vwPassword.textField.text!,"device_id": self.deviceID,"coupon": self.vwCouponCode.textField.text!]
        print(newTodo)
        
        Alamofire.request(todosEndpoint, method: .post, parameters: newTodo,
                          encoding: JSONEncoding.default)
            .responseJSON { response in
                guard let json = response.result.value as? [String: Any] else {
                    print("didn't get todo object as JSON from API")
                    SVProgressHUD.dismiss()
                    return
                }
                print("JSON: \(json)")
                if ((json["status"]  as! Int) == 1){
                    let alertController = UIAlertController(title: "Almost Done", message: "Please check your email for a final verification step.\n Once you have verified your email address, your registration will be completed.", preferredStyle: UIAlertController.Style.alert) //Replace
                                       
                    // Replace UIAlertActionStyle.Default by UIAlertActionStyle.default
                    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                       (result : UIAlertAction) -> Void in
                        self.navigationController?.popViewController(animated: true)
                    }
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                    SVProgressHUD.dismiss()
                }else{
                    let alertController = UIAlertController(title: "Error", message: json["message"] as? String, preferredStyle: UIAlertController.Style.alert) //Replace
                                       
                    // Replace UIAlertActionStyle.Default by UIAlertActionStyle.default
                    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                       (result : UIAlertAction) -> Void in
                    }
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                    SVProgressHUD.dismiss()
                }
        }
    }
    
    @IBAction func btnSignInDidTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- Password Button Visibility Action
    @IBAction func btnPasswordVisibilityDidTap(_ sender: Any) {
        if(iconClick == true) {
             vwPassword.textField.isSecureTextEntry = false
             btnPasswordVisionOutlet.setImage(UIImage(named: "passwordUnseen"), for: .normal)
         } else {
             vwPassword.textField.isSecureTextEntry = true
             btnPasswordVisionOutlet.setImage(UIImage(named: "passwordSeen"), for: .normal)
        }
        iconClick = !iconClick
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

extension RegistrationViewController: UITextFieldDelegate {

  // MARK: - UITextFieldDelegate

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if (textField == self.vwCouponCode.textField) {
            self.checkCouponAvailability()
        }
        return true
    }
        
    //MARK:- Availability Api Call
    func checkCouponAvailability(){
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        let todosEndpoint: String = ServiceConstant.BASE_URL + "check-coupon"
        
        let newTodo: [String: Any] = ["coupon":self.vwCouponCode.textField.text!]
                
        Alamofire.request(todosEndpoint, method: .post, parameters: newTodo,
                          encoding: JSONEncoding.default)
            .responseJSON { response in
                guard let json = response.result.value as? [String: Any] else {
                    print("didn't get todo object as JSON from API")
                    SVProgressHUD.dismiss()
                    return
                }
                print("JSON: \(json)")
                if ((json["status"]  as! Int) == 1){
                     let data =  (json["data"] as AnyObject) as! [String : AnyObject]
                    let couponValid = data["coupon"] as? NSDictionary
                    let applied_data = couponValid!["applied_for"] as? String
                    
                    self.lblSubscriptionDays.text = "You will get \(applied_data!) free subscription."
                    self.lblSubscriptionDays.isHidden = false
                     self.vwCouponApplied.isHidden = false
                    SVProgressHUD.dismiss()
                }else{
                    self.vwCouponApplied.isHidden = true
                    self.lblSubscriptionDays.isHidden = true
                    let alertController = UIAlertController(title: "Error", message: json["message"] as? String, preferredStyle: UIAlertController.Style.alert) //Replace
                                       
                    // Replace UIAlertActionStyle.Default by UIAlertActionStyle.default
                    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                       (result : UIAlertAction) -> Void in
                    }
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                    SVProgressHUD.dismiss()
                }
        }
    }
    
  func textFieldDidEndEditing(_ textField: UITextField) {
      
      if (textField == vwEmail.textField) {
          if (self.vwEmail.textField.text!.count == 0 || self.vwEmail.textField.text!.isEmpty || (self.vwEmail.textField.text?.trimmingCharacters(in: .whitespaces).isEmpty)!){
                  self.vwEmail.textField.attributedPlaceholder = NSAttributedString(string: "Email field cannot be blank", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                  self.vwEmail.textFieldControllerFloating.inlinePlaceholderColor = UIColor.red
                  self.vwEmail.textFieldControllerFloating.normalColor = UIColor.red
                  textField.resignFirstResponder();
          }else{
              if !(isValidEmail(testStr: self.vwEmail.textField.text!)){
                 self.vwEmail.textField.attributedPlaceholder = NSAttributedString(string: "Please enter a valid email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                 self.vwEmail.textFieldControllerFloating.inlinePlaceholderColor = UIColor.red
                 self.vwEmail.textFieldControllerFloating.normalColor = UIColor.red
                 textField.resignFirstResponder();
              }else{
                  self.vwEmail.textFieldControllerFloating.floatingPlaceholderActiveColor = UIColor.lightGray
                  self.vwEmail.textFieldControllerFloating.inlinePlaceholderColor = UIColor.lightGray
                  self.vwEmail.textFieldControllerFloating.normalColor = UIColor.lightGray
                  textField.resignFirstResponder();
              }
          }
      }
      else if (textField == vwPassword.textField){
          if (self.vwPassword.textField.text!.count == 0 || self.vwPassword.textField.text!.isEmpty || (self.vwPassword.textField.text?.trimmingCharacters(in: .whitespaces).isEmpty)!){
                  self.vwPassword.textField.attributedPlaceholder = NSAttributedString(string: "Password field cannot be blank", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                  self.vwPassword.textFieldControllerFloating.inlinePlaceholderColor = UIColor.red
                  self.vwPassword.textFieldControllerFloating.normalColor = UIColor.red
                  textField.resignFirstResponder();
          }else{
              if (self.vwPassword.textField.text!.count) < 6{
                  self.vwPassword.textField.text = ""
                  self.vwPassword.textField.placeholder = "Password needs to be maximum of 6 characters long."
                  self.vwPassword.textFieldControllerFloating.inlinePlaceholderColor = UIColor.red
                  self.vwPassword.textFieldControllerFloating.normalColor = UIColor.red
                  textField.resignFirstResponder();
                     }
              else{
                  self.vwPassword.textFieldControllerFloating.inlinePlaceholderColor = UIColor.lightGray
                  self.vwPassword.textFieldControllerFloating.normalColor = UIColor.lightGray
                  textField.resignFirstResponder();
              }
          }
      }
      else{
        if (self.vwName.textField.text!.count == 0 || self.vwName.textField.text!.isEmpty || (self.vwName.textField.text?.trimmingCharacters(in: .whitespaces).isEmpty)!){
                self.vwName.textField.attributedPlaceholder = NSAttributedString(string: "Name field cannot be blank", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                self.vwName.textFieldControllerFloating.inlinePlaceholderColor = UIColor.red
                self.vwName.textFieldControllerFloating.normalColor = UIColor.red
                textField.resignFirstResponder();
        }else{
                self.vwName.textFieldControllerFloating.inlinePlaceholderColor = UIColor.lightGray
                self.vwName.textFieldControllerFloating.normalColor = UIColor.lightGray
                textField.resignFirstResponder();
        }
    }
  }
      
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
     if (textField == vwEmail.textField) {
         if (self.vwEmail.textField.text!.count == 0 || self.vwEmail.textField.text!.isEmpty || (self.vwEmail.textField.text?.trimmingCharacters(in: .whitespaces).isEmpty)!){
                 self.vwEmail.textField.attributedPlaceholder = NSAttributedString(string: "Email field cannot be blank", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                 self.vwEmail.textFieldControllerFloating.inlinePlaceholderColor = UIColor.red
                 self.vwEmail.textFieldControllerFloating.normalColor = UIColor.red
                 textField.resignFirstResponder();
         }else{
             if !(isValidEmail(testStr: self.vwEmail.textField.text!)){
                self.vwEmail.textField.attributedPlaceholder = NSAttributedString(string: "Please enter a valid email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                self.vwEmail.textFieldControllerFloating.inlinePlaceholderColor = UIColor.red
                self.vwEmail.textFieldControllerFloating.normalColor = UIColor.red
                textField.resignFirstResponder();
             }else{
                 self.vwEmail.textFieldControllerFloating.floatingPlaceholderActiveColor = UIColor.lightGray
                 self.vwEmail.textFieldControllerFloating.inlinePlaceholderColor = UIColor.lightGray
                 self.vwEmail.textFieldControllerFloating.normalColor = UIColor.lightGray
                 textField.resignFirstResponder();
             }
         }
     }
     else if (textField == vwPassword.textField){
         if (self.vwPassword.textField.text!.count == 0 || self.vwPassword.textField.text!.isEmpty || (self.vwPassword.textField.text?.trimmingCharacters(in: .whitespaces).isEmpty)!){
                 self.vwPassword.textField.attributedPlaceholder = NSAttributedString(string: "Password field cannot be blank", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                 self.vwPassword.textFieldControllerFloating.inlinePlaceholderColor = UIColor.red
                 self.vwPassword.textFieldControllerFloating.normalColor = UIColor.red
                 textField.resignFirstResponder();
         }else{
             if (self.vwPassword.textField.text!.count) < 6{
                 self.vwPassword.textField.text = ""
                 self.vwPassword.textField.placeholder = "Password needs to be maximum of 6 characters long."
                 self.vwPassword.textFieldControllerFloating.inlinePlaceholderColor = UIColor.red
                 self.vwPassword.textFieldControllerFloating.normalColor = UIColor.red
                 textField.resignFirstResponder();
                    }
             else{
                 self.vwPassword.textFieldControllerFloating.inlinePlaceholderColor = UIColor.lightGray
                 self.vwPassword.textFieldControllerFloating.normalColor = UIColor.lightGray
                 textField.resignFirstResponder();
             }
         }
     }
    else{
        if (self.vwName.textField.text!.count == 0 || self.vwName.textField.text!.isEmpty || (self.vwName.textField.text?.trimmingCharacters(in: .whitespaces).isEmpty)!){
                self.vwName.textField.attributedPlaceholder = NSAttributedString(string: "Name field cannot be blank", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                self.vwName.textFieldControllerFloating.inlinePlaceholderColor = UIColor.red
                self.vwName.textFieldControllerFloating.normalColor = UIColor.red
                textField.resignFirstResponder();
        }else{
                self.vwName.textFieldControllerFloating.inlinePlaceholderColor = UIColor.lightGray
                self.vwName.textFieldControllerFloating.normalColor = UIColor.lightGray
                textField.resignFirstResponder();
        }
    }
      return true
    }
}
