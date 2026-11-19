//
//  LoginVC.swift
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

class LoginVC: UIViewController {
    
    //MARK:- Variable Declaration
    @IBOutlet weak var btnSignupOutlet: UIButton!
    
    @IBOutlet weak var vwEmail: CustomOutlinedTxtField!
    @IBOutlet weak var vwPassword: CustomOutlinedTxtField!
    var totalUserDict = [String: AnyObject]()
    var email = String()
    var tokenData = String()
    var iconClick = true
    @IBOutlet weak var btnPasswordVision: UIButton!
    @IBOutlet weak var btnRememberMe: UIButton!
    
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(self.view.frame.size.height)
        print(self.view.frame.size.width)
        self.btnSignupOutlet.layer.cornerRadius = 5
        self.btnSignupOutlet.layer.masksToBounds = true
        self.vwEmail.textField.delegate = self
        self.vwPassword.textField.delegate = self

        let isRemember = UserDefaults.standard.bool(forKey: "isRemember")
        if isRemember == true {
            self.vwEmail.textField.text = String(describing: UserDefaults.standard.value(forKey: "RememberEmail")!)
            self.vwPassword.textField.text = String(describing: UserDefaults.standard.value(forKey: "RememberPassword")!)
        }
//        self.vwEmail.textField.text = "moumita.datta@yopmail.com"
//        self.vwPassword.textField.text = "12345678"
        self.vwPassword.textField.isSecureTextEntry = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.vwEmail.textField.autocapitalizationType = .none
        self.navigationController?.navigationBar.setBarColor(UIColor.clear)
    }
    
    //MARK:- SignIn Button Action
    @IBAction func btnSignInDidTap(_ sender: Any) {
        if self.vwEmail.textField.text! == "" && self.vwPassword.textField.text! == "" {
            self.vwEmail.textField.attributedPlaceholder = NSAttributedString(string: "Please enter a valid email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            self.vwPassword.textField.attributedPlaceholder = NSAttributedString(string: "Please enter Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            
            self.vwEmail.textFieldControllerFloating.inlinePlaceholderColor = UIColor.red
            self.vwEmail.textFieldControllerFloating.normalColor = UIColor.red
            
            self.vwPassword.textFieldControllerFloating.inlinePlaceholderColor = UIColor.red
            self.vwPassword.textFieldControllerFloating.normalColor = UIColor.red
            
            let alert = UIAlertController(title: "Alert", message: "Every field is mandatory", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        if (self.vwEmail.textField.text!.count == 0 || self.vwEmail.textField.text!.isEmpty || (self.vwEmail.textField.text?.trimmingCharacters(in: .whitespaces).isEmpty)!) {
            self.vwEmail.textField.attributedPlaceholder = NSAttributedString(string: "Email field cannot be blank", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            self.vwEmail.textFieldControllerFloating.inlinePlaceholderColor = UIColor.red
            self.vwEmail.textFieldControllerFloating.normalColor = UIColor.red
        } else {
            self.vwEmail.textFieldControllerFloating.floatingPlaceholderActiveColor = UIColor.lightGray
            self.vwEmail.textFieldControllerFloating.inlinePlaceholderColor = UIColor.lightGray
            self.vwEmail.textFieldControllerFloating.normalColor = UIColor.lightGray
        }
        
        if (self.vwPassword.textField.text!.count == 0 || self.vwPassword.textField.text!.isEmpty || (self.vwPassword.textField.text?.trimmingCharacters(in: .whitespaces).isEmpty)!) {
            self.vwPassword.textField.attributedPlaceholder = NSAttributedString(string: "Password field cannot be blank", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            self.vwPassword.textFieldControllerFloating.inlinePlaceholderColor = UIColor.red
            self.vwPassword.textFieldControllerFloating.normalColor = UIColor.red
        } else {
            if (self.vwPassword.textField.text!.count) < 6 {
                self.vwPassword.textField.text = ""
                self.vwPassword.textField.placeholder = "Password needs to be maximum of 6 characters long."
                self.vwPassword.textFieldControllerFloating.inlinePlaceholderColor = UIColor.red
                self.vwPassword.textFieldControllerFloating.normalColor = UIColor.red
            } else{
                self.vwPassword.textFieldControllerFloating.inlinePlaceholderColor = UIColor.lightGray
                self.vwPassword.textFieldControllerFloating.normalColor = UIColor.lightGray
            }
        }
        
        if !(isValidEmail(testStr: self.vwEmail.textField.text!)) {
           self.vwEmail.textField.attributedPlaceholder = NSAttributedString(string: "Please enter a valid email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
           self.vwEmail.textFieldControllerFloating.inlinePlaceholderColor = UIColor.red
           self.vwEmail.textFieldControllerFloating.normalColor = UIColor.red
        } else {
            self.loginApiCall()
            /*if UIDevice.current.userInterfaceIdiom == .phone {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Home_iPhone", bundle:nil)
                let InspectionListVC = storyBoard.instantiateViewController(withIdentifier: "InspectionList") as! InspectionListVC
                self.navigationController?.pushViewController(InspectionListVC, animated: true)
            } else if UIDevice.current.userInterfaceIdiom == .pad {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Home_iPad", bundle:nil)
                let InspectionListVC = storyBoard.instantiateViewController(withIdentifier: "InspectionList") as! InspectionListVC
                self.navigationController?.pushViewController(InspectionListVC, animated: true)
            }*/
        }
    }
    
    //MARK:- Signup Button Action
    @IBAction func btnSignUpDidTap(_ sender: Any) {
        if UIDevice.current.userInterfaceIdiom == .phone {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main_iPhone", bundle:nil)
            let RegistrationViewController = storyBoard.instantiateViewController(withIdentifier: "Registration") as! RegistrationViewController
            self.navigationController?.pushViewController(RegistrationViewController, animated: true)
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main_iPad", bundle:nil)
            let RegistrationViewController = storyBoard.instantiateViewController(withIdentifier: "Registration") as! RegistrationViewController
            self.navigationController?.pushViewController(RegistrationViewController, animated: true)
        }
    }
    
    @IBAction func btnRememberMeDidTap(_ sender: Any) {
        self.btnRememberMe.isSelected = !self.btnRememberMe.isSelected
        if (self.btnRememberMe.isSelected) {
            print(String(format: "is selected.\n"))
            UserDefaults.standard.set(true, forKey: "isRemember")
            UserDefaults.standard.set(self.vwEmail.textField.text, forKey: "RememberEmail")
            UserDefaults.standard.set(self.vwPassword.textField.text, forKey: "RememberPassword")
            self.btnRememberMe.setImage(UIImage(named: "checkmark"), for: .normal)
        } else {
            print(String(format: "is not selected.\n"))
            UserDefaults.standard.set(false, forKey: "isRemember")
            UserDefaults.standard.removeObject(forKey: "RememberEmail")
            UserDefaults.standard.removeObject(forKey: "RememberPassword")
            self.btnRememberMe.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }
    
    //MARK:- Email Validation Checking
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    //MARK:- Login Api Call
    func loginApiCall() {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
                  
        let todosEndpoint: String = ServiceConstant.BASE_URL+"login"
        print(todosEndpoint)
        let newTodo: [String: Any] = ["email": self.vwEmail.textField.text!, "password": self.vwPassword.textField.text!]
        print(newTodo)
        
        
        Alamofire.request(todosEndpoint, method: .post, parameters: newTodo, encoding: JSONEncoding.default).responseJSON { response in
            guard let json = response.result.value as? [String: Any] else {
                print("didn't get todo object as JSON from API")
                SVProgressHUD.dismiss()
                return
            }
            print("JSON: \(json)")
            if ((json["status"]  as! Int) == 1) {
                UserDefaults.standard.set(true, forKey: "login")
                
                self.totalUserDict = (json["data"] as AnyObject) as! [String : AnyObject]
                
                //store dic data
                let dicSubscript : [String: AnyObject] = ((self.totalUserDict["current_subscription"] as AnyObject) as! [String : AnyObject])
                let dataSub = NSKeyedArchiver.archivedData(withRootObject: dicSubscript)
                UserDefaults.standard.set(dataSub, forKey: "key_subscription_info")
                
                let dicProfile : [String: AnyObject] = ((self.totalUserDict["profile"] as AnyObject) as! [String : AnyObject])
                let dataPro = NSKeyedArchiver.archivedData(withRootObject: dicProfile)
                UserDefaults.standard.set(dataPro, forKey: "key_profile_info")
                
                UserDefaults.standard.setValue(self.totalUserDict["token"], forKey: "key_token")
                
                if UIDevice.current.userInterfaceIdiom == .phone {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Home_iPhone", bundle:nil)
                    let InspectionListVC = storyBoard.instantiateViewController(withIdentifier: "InspectionList") as! InspectionListVC
                    self.navigationController?.pushViewController(InspectionListVC, animated: true)
                } else if UIDevice.current.userInterfaceIdiom == .pad {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Home_iPad", bundle:nil)
                    let InspectionListVC = storyBoard.instantiateViewController(withIdentifier: "InspectionList") as! InspectionListVC
                    self.navigationController?.pushViewController(InspectionListVC, animated: true)
                }
                SVProgressHUD.dismiss()
            } else {
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
    
    //MARK:- Forgot Password Button Action
    @IBAction func btnForgotPasswordDidTap(_ sender: Any) {
        self.showAlert()
    }
    
    //MARK:- Alert Textfield
    
    func showAlert() {
        let alertController = UIAlertController(title: "Forgot Password", message: "Please enter your email address.", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: {(_ textField: UITextField?) -> Void in
            textField?.placeholder = "Email"
            textField?.addTarget(self, action: #selector(LoginVC.alertTextFieldDidChange(_:)), for: .editingChanged)
            textField?.keyboardType = .emailAddress
        })
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: {(_ action: UIAlertAction?) -> Void in
            let login: UITextField? = alertController.textFields?.first
            self.email = (login?.text!)!
            self.forgetPassword()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(_ action: UIAlertAction?) -> Void in
        })
        okAction.isEnabled = false
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true) {() -> Void in }
    }
    
    @objc func alertTextFieldDidChange(_ sender: UITextField?) {
        let alertController = presentedViewController as? UIAlertController
        if alertController != nil {
            let login: UITextField? = alertController?.textFields?.first
            let okAction: UIAlertAction? = alertController?.actions.first
            okAction?.isEnabled = (login?.text?.count ?? 0) > 2
        }
    }
    
    //MARK:- Password Seen Button Visibility
    @IBAction func btnPasswordSeenDidTap(_ sender: Any) {
        if(iconClick == true) {
            vwPassword.textField.isSecureTextEntry = false
            btnPasswordVision.setImage(UIImage(named: "passwordUnseen"), for: .normal)
        } else {
            vwPassword.textField.isSecureTextEntry = true
            btnPasswordVision.setImage(UIImage(named: "passwordSeen"), for: .normal)
       }
       iconClick = !iconClick
    }
    
    
    
    //MARK:- Forgot Password Api Call
    func forgetPassword() {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        let todosEndpoint: String = ServiceConstant.BASE_URL + "forgot-password"
        
        let newTodo: [String: Any] = ["email": self.email]
                
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
                    self.tokenData = (data["token"] as? String)!
                    if UIDevice.current.userInterfaceIdiom == .phone{
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main_iPhone", bundle:nil)
                        let ResetPasswordVC = storyBoard.instantiateViewController(withIdentifier: "ResetPasswordVC") as! ResetPasswordVC
                        ResetPasswordVC.token = self.tokenData
                        self.navigationController?.pushViewController(ResetPasswordVC, animated: true)
                    }else{
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main_iPad", bundle:nil)
                        let ResetPasswordVC = storyBoard.instantiateViewController(withIdentifier: "ResetPasswordVC") as! ResetPasswordVC
                        ResetPasswordVC.token = self.tokenData
                        self.navigationController?.pushViewController(ResetPasswordVC, animated: true)
                    }
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
}

extension LoginVC: UITextFieldDelegate {
  // MARK: - UITextFieldDelegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField == vwEmail.textField) {
            if (self.vwEmail.textField.text!.count == 0 || self.vwEmail.textField.text!.isEmpty || (self.vwEmail.textField.text?.trimmingCharacters(in: .whitespaces).isEmpty)!) {
                self.vwEmail.textField.attributedPlaceholder = NSAttributedString(string: "Email field cannot be blank", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                self.vwEmail.textFieldControllerFloating.inlinePlaceholderColor = UIColor.red
                self.vwEmail.textFieldControllerFloating.normalColor = UIColor.red
                textField.resignFirstResponder();
            } else {
                if !(isValidEmail(testStr: self.vwEmail.textField.text!)) {
                    self.vwEmail.textField.attributedPlaceholder = NSAttributedString(string: "Please enter a valid email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                    self.vwEmail.textFieldControllerFloating.inlinePlaceholderColor = UIColor.red
                    self.vwEmail.textFieldControllerFloating.normalColor = UIColor.red
                    textField.resignFirstResponder();
                } else {
                    self.vwEmail.textFieldControllerFloating.floatingPlaceholderActiveColor = UIColor.lightGray
                    self.vwEmail.textFieldControllerFloating.inlinePlaceholderColor = UIColor.lightGray
                    self.vwEmail.textFieldControllerFloating.normalColor = UIColor.lightGray
                    textField.resignFirstResponder();
                }
            }
        } else if (textField == vwPassword.textField) {
            if (self.vwPassword.textField.text!.count == 0 || self.vwPassword.textField.text!.isEmpty || (self.vwPassword.textField.text?.trimmingCharacters(in: .whitespaces).isEmpty)!) {
                self.vwPassword.textField.attributedPlaceholder = NSAttributedString(string: "Password field cannot be blank", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                self.vwPassword.textFieldControllerFloating.inlinePlaceholderColor = UIColor.red
                self.vwPassword.textFieldControllerFloating.normalColor = UIColor.red
                textField.resignFirstResponder();
            } else {
                if (self.vwPassword.textField.text!.count) < 6 {
                    self.vwPassword.textField.text = ""
                    self.vwPassword.textField.placeholder = "Password needs to be maximum of 6 characters long."
                    self.vwPassword.textFieldControllerFloating.inlinePlaceholderColor = UIColor.red
                    self.vwPassword.textFieldControllerFloating.normalColor = UIColor.red
                    textField.resignFirstResponder();
                } else {
                    self.vwPassword.textFieldControllerFloating.inlinePlaceholderColor = UIColor.lightGray
                    self.vwPassword.textFieldControllerFloating.normalColor = UIColor.lightGray
                    textField.resignFirstResponder();
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == vwEmail.textField) {
            if (self.vwEmail.textField.text!.count == 0 || self.vwEmail.textField.text!.isEmpty || (self.vwEmail.textField.text?.trimmingCharacters(in: .whitespaces).isEmpty)!) {
                self.vwEmail.textField.attributedPlaceholder = NSAttributedString(string: "Email field cannot be blank", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                self.vwEmail.textFieldControllerFloating.inlinePlaceholderColor = UIColor.red
                self.vwEmail.textFieldControllerFloating.normalColor = UIColor.red
                textField.resignFirstResponder();
            } else {
                if !(isValidEmail(testStr: self.vwEmail.textField.text!)) {
                    self.vwEmail.textField.attributedPlaceholder = NSAttributedString(string: "Please enter a valid email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                    self.vwEmail.textFieldControllerFloating.inlinePlaceholderColor = UIColor.red
                    self.vwEmail.textFieldControllerFloating.normalColor = UIColor.red
                    textField.resignFirstResponder();
                } else {
                    self.vwEmail.textFieldControllerFloating.floatingPlaceholderActiveColor = UIColor.lightGray
                    self.vwEmail.textFieldControllerFloating.inlinePlaceholderColor = UIColor.lightGray
                    self.vwEmail.textFieldControllerFloating.normalColor = UIColor.lightGray
                    textField.resignFirstResponder();
                }
            }
        } else if (textField == vwPassword.textField) {
            if (self.vwPassword.textField.text!.count == 0 || self.vwPassword.textField.text!.isEmpty || (self.vwPassword.textField.text?.trimmingCharacters(in: .whitespaces).isEmpty)!) {
                self.vwPassword.textField.attributedPlaceholder = NSAttributedString(string: "Password field cannot be blank", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                self.vwPassword.textFieldControllerFloating.inlinePlaceholderColor = UIColor.red
                self.vwPassword.textFieldControllerFloating.normalColor = UIColor.red
                textField.resignFirstResponder();
            } else {
                if (self.vwPassword.textField.text!.count) < 6 {
                    self.vwPassword.textField.text = ""
                    self.vwPassword.textField.placeholder = "Password needs to be maximum of 6 characters long."
                    self.vwPassword.textFieldControllerFloating.inlinePlaceholderColor = UIColor.red
                    self.vwPassword.textFieldControllerFloating.normalColor = UIColor.red
                    textField.resignFirstResponder();
                } else {
                    self.vwPassword.textFieldControllerFloating.inlinePlaceholderColor = UIColor.lightGray
                    self.vwPassword.textFieldControllerFloating.normalColor = UIColor.lightGray
                    textField.resignFirstResponder();
                }
            }
        }
        return true
    }
}
