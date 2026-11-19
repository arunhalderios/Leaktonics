//
//  EmailTechnicalSupportVC.swift
//  Leaktronics
//
//  Created by Arun Halder on 23/07/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import MessageUI
import MaterialComponents
import UINavigationBar_Transparent
import Alamofire
import SVProgressHUD

class EmailTechnicalSupportVC: UIViewController,MFMailComposeViewControllerDelegate{
    
    @IBOutlet weak var vwEmail: CustomOutlinedTxtField!
    @IBOutlet weak var vwMessage: CustomOutlinedTxtField!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.vwEmail.textField.delegate = self
        self.vwMessage.textField.delegate = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.vwEmail.textField.autocapitalizationType = .none
        self.navigationController?.navigationBar.setBarColor(UIColor.clear)
        self.vwEmail.textFieldControllerFloating.inlinePlaceholderColor = UIColor.gray
        
        self.vwMessage.textFieldControllerFloating.inlinePlaceholderColor = UIColor.gray

    }
    
    //MARK:- SignIn Button Action
    @IBAction func btnSignInDidTap(_ sender: Any) {
        if self.vwEmail.textField.text! == "" && self.vwEmail.textField.text! == "" {
            self.vwEmail.textField.attributedPlaceholder = NSAttributedString(string: "Please enter a valid email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            self.vwMessage.textField.attributedPlaceholder = NSAttributedString(string: "Please enter Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            
            self.vwEmail.textFieldControllerFloating.inlinePlaceholderColor = UIColor.red
            self.vwEmail.textFieldControllerFloating.normalColor = UIColor.red
            
            self.vwMessage.textFieldControllerFloating.inlinePlaceholderColor = UIColor.red
            self.vwMessage.textFieldControllerFloating.normalColor = UIColor.red
            
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
        
        if (self.vwMessage.textField.text!.count == 0 || self.vwMessage.textField.text!.isEmpty || (self.vwMessage.textField.text?.trimmingCharacters(in: .whitespaces).isEmpty)!) {
            self.vwMessage.textField.attributedPlaceholder = NSAttributedString(string: "Message field cannot be blank", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            self.vwMessage.textFieldControllerFloating.inlinePlaceholderColor = UIColor.red
            self.vwMessage.textFieldControllerFloating.normalColor = UIColor.red
        } else {
        
                self.vwMessage.textFieldControllerFloating.inlinePlaceholderColor = UIColor.lightGray
                self.vwMessage.textFieldControllerFloating.normalColor = UIColor.lightGray
            
        }
        
        if !(isValidEmail(testStr: self.vwEmail.textField.text!)) {
           self.vwEmail.textField.attributedPlaceholder = NSAttributedString(string: "Please enter a valid email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
           self.vwEmail.textFieldControllerFloating.inlinePlaceholderColor = UIColor.red
           self.vwEmail.textFieldControllerFloating.normalColor = UIColor.red
        } else {
           // self.loginApiCall()
            self.sendEmail()
        }
    }
    
    //MARK:- Email Validation Checking
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    //MARK:- Email Compose
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["arunhalder.leo@gmail.com"])
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)

            present(mail, animated: true)
        } else {
            print("Error Message")
            // show failure alert
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }


}

extension EmailTechnicalSupportVC: UITextFieldDelegate {
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
        } else if (textField == vwMessage.textField) {
            if (self.vwMessage.textField.text!.count == 0 || self.vwMessage.textField.text!.isEmpty || (self.vwMessage.textField.text?.trimmingCharacters(in: .whitespaces).isEmpty)!) {
                self.vwMessage.textField.attributedPlaceholder = NSAttributedString(string: "Message field cannot be blank", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                self.vwMessage.textFieldControllerFloating.inlinePlaceholderColor = UIColor.red
                self.vwMessage.textFieldControllerFloating.normalColor = UIColor.red
                textField.resignFirstResponder();
            } else {
                self.vwMessage.textFieldControllerFloating.inlinePlaceholderColor = UIColor.lightGray
                self.vwMessage.textFieldControllerFloating.normalColor = UIColor.lightGray
                textField.resignFirstResponder();
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
        } else if (textField == vwMessage.textField) {
            if (self.vwMessage.textField.text!.count == 0 || self.vwMessage.textField.text!.isEmpty || (self.vwMessage.textField.text?.trimmingCharacters(in: .whitespaces).isEmpty)!) {
                self.vwMessage.textField.attributedPlaceholder = NSAttributedString(string: "Message field cannot be blank", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                self.vwMessage.textFieldControllerFloating.inlinePlaceholderColor = UIColor.red
                self.vwMessage.textFieldControllerFloating.normalColor = UIColor.red
                textField.resignFirstResponder();
            } else {
                self.vwMessage.textFieldControllerFloating.inlinePlaceholderColor = UIColor.lightGray
                self.vwMessage.textFieldControllerFloating.normalColor = UIColor.lightGray
                textField.resignFirstResponder();
            }
        }
        return true
    }
}
