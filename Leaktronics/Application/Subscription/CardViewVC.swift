//
//  CardViewVC.swift
//  Leaktronics
//
//  Created by Abhishek Mullick on 18/06/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import CreditCardForm
import Stripe
import Heartland_iOS_SDK
import Alamofire
import SVProgressHUD

class CardViewVC: UIViewController,STPPaymentCardTextFieldDelegate {

    @IBOutlet weak var creditCardView: CreditCardFormView!
    let paymentTextField = STPPaymentCardTextField()
    private var cardHolderNameTextField: TextField!
    private var cardParams: STPPaymentMethodCardParams!
    var selectSubscription = String()
    var price = String()
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        print(selectSubscription)
        if selectSubscription == "Monthly" {
            self.price = "49.00"
        } else if selectSubscription == "Annual" {
            self.price = "489.00"
        }
        
        print(self.price)
        
        // Do any additional setup after loading the view.
        creditCardView.cardHolderString = " "
        creditCardView.cardGradientColors[Brands.Amex.rawValue] = [UIColor.red, UIColor.black]
        creditCardView.cardNumberFont = UIFont(name: "HelveticaNeue", size: 20)!
        creditCardView.cardPlaceholdersFont = UIFont(name: "HelveticaNeue", size: 10)!
        creditCardView.cardTextFont = UIFont(name: "HelveticaNeue", size: 12)!
        
        paymentTextField.postalCodeEntryEnabled = false
        
        createTextField()
        
        cardParams = STPPaymentMethodCardParams()
        cardParams.number = ""
        cardParams.expMonth = 0
        cardParams.expYear = 0
        cardParams.cvc = " "
        self.paymentTextField.cardParams = cardParams
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // load saved card params
        creditCardView.paymentCardTextFieldDidChange(cardNumber: cardParams.number, expirationYear: cardParams!.expYear as? UInt, expirationMonth: cardParams!.expMonth as? UInt, cvc: cardParams.cvc)
    }
    
    func createTextField() {
        cardHolderNameTextField = TextField(frame: CGRect(x: 15, y: 199, width: self.view.frame.size.width - 30, height: 44))
        cardHolderNameTextField.placeholder = "CARD HOLDER"
        cardHolderNameTextField.delegate = self
        cardHolderNameTextField.translatesAutoresizingMaskIntoConstraints = false
        cardHolderNameTextField.setBottomBorder()
        cardHolderNameTextField.addTarget(self, action: #selector(CardViewVC.textFieldDidChange(_:)), for: .editingChanged)
        view.addSubview(cardHolderNameTextField)
        
        paymentTextField.frame = CGRect(x: 15, y: 199, width: self.view.frame.size.width - 30, height: 44)
        paymentTextField.delegate = self
        paymentTextField.translatesAutoresizingMaskIntoConstraints = false
        paymentTextField.borderWidth = 0
        
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: paymentTextField.frame.size.height - width, width:  paymentTextField.frame.size.width, height: paymentTextField.frame.size.height)
        border.borderWidth = width
        paymentTextField.layer.addSublayer(border)
        paymentTextField.layer.masksToBounds = true
        
        view.addSubview(paymentTextField)
        
        NSLayoutConstraint.activate([
            cardHolderNameTextField.topAnchor.constraint(equalTo: creditCardView.bottomAnchor, constant: 20),
            cardHolderNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardHolderNameTextField.widthAnchor.constraint(equalToConstant: self.view.frame.size.width-25),
            cardHolderNameTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        NSLayoutConstraint.activate([
            paymentTextField.topAnchor.constraint(equalTo: cardHolderNameTextField.bottomAnchor, constant: 20),
            paymentTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            paymentTextField.widthAnchor.constraint(equalToConstant: self.view.frame.size.width-20),
            paymentTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func paymentCardTextFieldDidChange(_ textField: STPPaymentCardTextField) {
        creditCardView.paymentCardTextFieldDidChange(cardNumber: textField.cardNumber, expirationYear: textField.expirationYear, expirationMonth: textField.expirationMonth, cvc: textField.cvc)
    }
    
    func paymentCardTextFieldDidEndEditingExpiration(_ textField: STPPaymentCardTextField) {
        creditCardView.paymentCardTextFieldDidEndEditingExpiration(expirationYear: textField.expirationYear)
    }
    
    func paymentCardTextFieldDidBeginEditingCVC(_ textField: STPPaymentCardTextField) {
        creditCardView.paymentCardTextFieldDidBeginEditingCVC()
    }
    
    func paymentCardTextFieldDidEndEditingCVC(_ textField: STPPaymentCardTextField) {
        creditCardView.paymentCardTextFieldDidEndEditingCVC()
    }
    
    //MARK:- Payment Api Call

    func payment() {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        
        let todosEndpoint: String = ServiceConstant.BASE_URL.appending(ServiceConstant.Payment)
        let token: String = UserDefaults.standard.value(forKey: "key_token") as! String
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": token
        ]
        
        let parameters: Parameters = [
            "device_id" : (UIDevice.current.identifierForVendor?.uuidString)!,
            "card_number" : self.paymentTextField.cardParams.number!,
            "expMonth" : self.paymentTextField.cardParams.expMonth!,
            "expYear" : "\(20)\(self.paymentTextField.cardParams.expYear!)",
            "cvn" : self.paymentTextField.cardParams.cvc!,
            "cardHolderName" : creditCardView.cardHolderString,
            "subscription_id" : selectSubscription
        ]
        
        print(parameters)
        
        Alamofire.request(todosEndpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            guard let json = response.result.value as? [String: Any] else {
                SVProgressHUD.dismiss()
                let alertController = UIAlertController(title: "", message: "Check internet connection", preferredStyle: UIAlertController.Style.alert) //Replace
                
                // Replace UIAlertActionStyle.Default by UIAlertActionStyle.default
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                    (result : UIAlertAction) -> Void in
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }
            print("JSON: \(json)")
            if ((json["status"]  as! Int) == 1) {
                 DispatchQueue.main.async {
                    print("Payment json :: \(String(describing: json))")
                    
                    DispatchQueue.main.async(execute: {() -> Void in
                        let alertController = UIAlertController(title: "", message: json["message"] as? String, preferredStyle: UIAlertController.Style.alert) //Replace
                        
                        // Replace UIAlertActionStyle.Default by UIAlertActionStyle.default
                        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                            (result : UIAlertAction) -> Void in
                            if UIDevice.current.userInterfaceIdiom == .phone {
                                let storyBoard : UIStoryboard = UIStoryboard(name: "Home_iPhone", bundle:nil)
                                let InspectionListVC = storyBoard.instantiateViewController(withIdentifier: "InspectionList") as! InspectionListVC
                                self.navigationController?.pushViewController(InspectionListVC, animated: true)
                            } else if UIDevice.current.userInterfaceIdiom == .pad {
                                let storyBoard : UIStoryboard = UIStoryboard(name: "Home_iPad", bundle:nil)
                                let InspectionListVC = storyBoard.instantiateViewController(withIdentifier: "InspectionList") as! InspectionListVC
                                self.navigationController?.pushViewController(InspectionListVC, animated: true)
                            }
                        }
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                        SVProgressHUD.dismiss()
                    })
                }
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
            SVProgressHUD.dismiss()
        }
    }
    
    //MARK:- Submit Button Action
    @IBAction func btnSubmitDidTap(_ sender: Any) {
        self.payment()
//        print(cardParams!)
//        print(creditCardView.cardHolderString)
//        print(self.paymentTextField.cardParams.number!)
//        print(self.paymentTextField.cardParams.cvc!)
//        print(self.paymentTextField.cardParams.expMonth!)
//        print(self.paymentTextField.cardParams.expYear!)
//
//        let tokenService: HpsTokenService = HpsTokenService(publicKey:"pkapi_cert_2DVabkZuHjQerfzX18");
//
//        tokenService.getTokenWithCardNumber(self.paymentTextField.cardParams.number!,
//                                       cvc: self.paymentTextField.cardParams.cvc!,
//                                       expMonth: "\((self.paymentTextField.cardParams.expMonth)!)",
//                                       expYear: "\((self.paymentTextField.cardParams.expYear)!)") { (tokenData) in
//
//
//            //use token
//            //tokenData!.tokenValue
//                                        print(tokenData!.tokenValue!)
//
//        }
    }
}

extension CardViewVC: UITextFieldDelegate {
    @objc func textFieldDidChange(_ textField: UITextField) {
        creditCardView.cardHolderString = textField.text!
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == cardHolderNameTextField {
            textField.resignFirstResponder()
            paymentTextField.becomeFirstResponder()
        } else if textField == paymentTextField  {
            textField.resignFirstResponder()
        }
        return true
    }
}

extension UITextField {
    func setBottomBorder() {
        self.borderStyle = UITextField.BorderStyle.none
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width,   width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
