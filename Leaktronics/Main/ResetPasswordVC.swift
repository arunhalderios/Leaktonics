//
//  ResetPasswordVC.swift
//  Leaktronics
//
//  Created by Abhishek Mullick on 23/04/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import MaterialComponents
import UINavigationBar_Transparent

class ResetPasswordVC: UIViewController {

    //MARK:- Variable Declaration
    @IBOutlet weak var vwNewPassword: CustomOutlinedTxtField!
    @IBOutlet weak var vwConfirmPassword: CustomOutlinedTxtField!
    var token = String()
    var logIndict = NSDictionary()
    var iconClick = true
    var iconClick1 = true
    
    @IBOutlet weak var btnNewPasswordVisionOutlet: UIButton!
    @IBOutlet weak var btnConfirmPasswordVisionOutlet: UIButton!
    
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.vwNewPassword.textField.isSecureTextEntry = true
        self.vwConfirmPassword.textField.isSecureTextEntry = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    //MARK:- New Password Vision Action
    
    @IBAction func btnNewPasswordVisibilityDidTap(_ sender: Any) {
        if(iconClick == true) {
             vwNewPassword.textField.isSecureTextEntry = false
             btnNewPasswordVisionOutlet.setImage(UIImage(named: "passwordUnseen"), for: .normal)
         } else {
             vwNewPassword.textField.isSecureTextEntry = true
             btnNewPasswordVisionOutlet.setImage(UIImage(named: "passwordSeen"), for: .normal)
        }
        iconClick = !iconClick
    }
    
    //MARK:- ConfirmPassword Vision Action
    
    @IBAction func btnConfirmPasswordVisibilityDidTap(_ sender: Any) {
        if(iconClick1 == true) {
             vwConfirmPassword.textField.isSecureTextEntry = false
             btnConfirmPasswordVisionOutlet.setImage(UIImage(named: "passwordUnseen"), for: .normal)
         } else {
             vwConfirmPassword.textField.isSecureTextEntry = true
             btnConfirmPasswordVisionOutlet.setImage(UIImage(named: "passwordSeen"), for: .normal)
        }
        iconClick1 = !iconClick1
    }
    
    
    
    
    //MARK:- Reset Button Action
    @IBAction func btnResetDidTap(_ sender: Any) {
        if self.vwNewPassword.textField.text! == "" && self.vwConfirmPassword.textField.text! == "" {
           self.vwNewPassword.textField.attributedPlaceholder = NSAttributedString(string: "Please provide a password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
           self.vwConfirmPassword.textField.attributedPlaceholder = NSAttributedString(string: "Please enter confirm password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])

           self.vwNewPassword.textFieldControllerFloating.inlinePlaceholderColor = UIColor.red
           self.vwNewPassword.textFieldControllerFloating.normalColor = UIColor.red
           
           self.vwConfirmPassword.textFieldControllerFloating.inlinePlaceholderColor = UIColor.red
           self.vwConfirmPassword.textFieldControllerFloating.normalColor = UIColor.red

           let alert = UIAlertController(title: "Alert", message: "Every field is mandatory", preferredStyle: UIAlertController.Style.alert)
           alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
           self.present(alert, animated: true, completion: nil)
       } else{
            self.resetPasswordApiCall()
       }
        
       if (self.vwNewPassword.textField.text!.count == 0 || self.vwNewPassword.textField.text!.isEmpty || (self.vwNewPassword.textField.text?.trimmingCharacters(in: .whitespaces).isEmpty)!){
             self.vwNewPassword.textField.attributedPlaceholder = NSAttributedString(string: "Name field cannot be blank", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
             self.vwNewPassword.textFieldControllerFloating.inlinePlaceholderColor = UIColor.red
             self.vwNewPassword.textFieldControllerFloating.normalColor = UIColor.red
       } else{
          self.vwNewPassword.textFieldControllerFloating.floatingPlaceholderActiveColor = UIColor.lightGray
          self.vwNewPassword.textFieldControllerFloating.inlinePlaceholderColor = UIColor.lightGray
          self.vwNewPassword.textFieldControllerFloating.normalColor = UIColor.lightGray
       }
       if (self.vwConfirmPassword.textField.text!.count == 0 || self.vwConfirmPassword.textField.text!.isEmpty || (self.vwConfirmPassword.textField.text?.trimmingCharacters(in: .whitespaces).isEmpty)!){
             self.vwConfirmPassword.textField.attributedPlaceholder = NSAttributedString(string: "Email field cannot be blank", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
             self.vwConfirmPassword.textFieldControllerFloating.inlinePlaceholderColor = UIColor.red
             self.vwConfirmPassword.textFieldControllerFloating.normalColor = UIColor.red
       } else{
            if self.vwNewPassword.textField.text != self.vwConfirmPassword.textField.text! {
                self.vwNewPassword.textFieldControllerFloating.inlinePlaceholderColor = UIColor.red
                self.vwNewPassword.textFieldControllerFloating.normalColor = UIColor.red
                self.vwConfirmPassword.textFieldControllerFloating.inlinePlaceholderColor = UIColor.red
                self.vwConfirmPassword.textFieldControllerFloating.normalColor = UIColor.red
            } else{
                self.vwConfirmPassword.textFieldControllerFloating.floatingPlaceholderActiveColor = UIColor.lightGray
                self.vwConfirmPassword.textFieldControllerFloating.inlinePlaceholderColor = UIColor.lightGray
                self.vwConfirmPassword.textFieldControllerFloating.normalColor = UIColor.lightGray
            }
        }
    }
    
    //MARK:- Reset Password Api Call
    func resetPasswordApiCall() {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        let todosEndpoint: String = ServiceConstant.BASE_URL + "reset-password"
        
        let newTodo: [String: Any] = ["password": self.vwNewPassword.textField.text!,"cpassword": self.vwConfirmPassword.textField.text!]
        print(newTodo)
        
        let headers: HTTPHeaders = [
            "Authorization": self.token
        ]
        
        Alamofire.request(todosEndpoint, method: .post, parameters: newTodo,
                          encoding: JSONEncoding.default,headers: headers)
            .responseJSON { response in
                guard let json = response.result.value as? [String: Any] else {
                    print("didn't get todo object as JSON from API")
                    SVProgressHUD.dismiss()
                    return
                }
                print("JSON: \(json)")
                if ((json["status"]  as! Int) == 1) {
                    if UIDevice.current.userInterfaceIdiom == .phone{
                        let alertController = UIAlertController(title: "Success", message: json["message"] as? String, preferredStyle: UIAlertController.Style.alert) //Replace
                        
                        // Replace UIAlertActionStyle.Default by UIAlertActionStyle.default
                        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                            (result : UIAlertAction) -> Void in
                             self.navigationController?.popToRootViewController(animated: true)
                        }
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                    }else{
                        self.navigationController?.popToRootViewController(animated: true)
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
