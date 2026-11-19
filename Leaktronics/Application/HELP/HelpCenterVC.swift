//
//  HelpCenterVC.swift
//  Leaktronics
//
//  Created by Arun Halder on 23/07/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class HelpCenterVC: UIViewController,UIAlertViewDelegate {
    
    @IBOutlet weak var tblHelpList: UITableView!
    
    var dicSupportList = NSDictionary()
    var dicFAQList = NSArray()
    
    var fetchIndex = Int()
    var indexNo = Int()
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.getHelpList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let backButton = UIBarButtonItem()
        backButton.title = ""//"Help & Support"
        backButton.tintColor = UIColor.black
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    //MARK:- @objc Function
    @objc func btnFAQTap(_ sender: Any) {
        print("Button pressed 👍 ")
        let btn = sender as! UIButton
        let cell = btn.superview?.superview as! UITableViewCell
        let indexOfCell = self.tblHelpList.indexPath(for: cell)
        fetchIndex = (indexOfCell?.row)!
        print("Select Index : \(String(describing: fetchIndex))")
        
        self.tblHelpList.reloadData()
    }
    
    @objc func btnSendMsgTap(_ sender: Any) {
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: "", message: "Enter your message", preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in
            //getting the input values from user
            //let name = alertController.textFields?[0].text
            //let email = alertController.textFields?[1].text
            
            self.postSendMessage(subject: (alertController.textFields?[0].text)!, message: (alertController.textFields?[1].text)!)
        }
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        //adding textfields to our dialog box
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Subject"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Message"
        }
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
    
    //MARK:- Function Api Calling
    func getHelpList() {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        let token: String = UserDefaults.standard.value(forKey: "key_token") as! String
        
        let headers = [
            "Authorization": token,
            //"Content-Type": "application/x-www-form-urlencoded"
        ]
        
        let todosEndpoint: String = ServiceConstant.BASE_URL.appending(ServiceConstant.GetSupportList)
        
        
        
        Alamofire.request(todosEndpoint, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
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
                    print("SupportList json :: \(String(describing: json))")
                    self.dicSupportList = json["data"] as! NSDictionary
                    self.dicFAQList = self.dicSupportList["FAQ"] as! NSArray
                    DispatchQueue.main.async(execute: {() -> Void in
                        self.tblHelpList.reloadData()
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
        }
    }
    
    func postSendMessage(subject: String, message: String) {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
                  
        let todosEndpoint: String = ServiceConstant.BASE_URL.appending(ServiceConstant.PostSendMessage)
        print(todosEndpoint)
        
        let token: String = UserDefaults.standard.value(forKey: "key_token") as! String
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": token
        ]
        
        let parameters: Parameters = [
            "device_id" : (UIDevice.current.identifierForVendor?.uuidString)!,
            "subject"   : subject,
            "message"   : message
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
                    print("SendMessage json :: \(String(describing: json))")
                    
                    DispatchQueue.main.async(execute: {() -> Void in
                        let alertController = UIAlertController(title: "", message: json["message"] as? String, preferredStyle: UIAlertController.Style.alert) //Replace
                        
                        // Replace UIAlertActionStyle.Default by UIAlertActionStyle.default
                        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                            (result : UIAlertAction) -> Void in
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
        }
    }
}

extension HelpCenterVC: UITableViewDelegate, UITableViewDataSource {
    //MARK:- TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // indexNo = dicFAQList.count + 4
        indexNo =  3
        return indexNo
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell : HelpTableCell = tableView.dequeueReusableCell(withIdentifier: "HelpTableCell") as! HelpTableCell
            
            if dicSupportList.count > 0 {
                let dicHelp: NSDictionary = dicSupportList["help-support"] as! NSDictionary
                cell.lblHelp.attributedText = (dicHelp["content"] as? String)?.htmlAttributed(using: UIFont(name: "Roboto", size: 14)!, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
            }
            
            return cell
        } else if indexPath.row == 1 {
            let cell : DisClaimerTableCell = tableView.dequeueReusableCell(withIdentifier: "DisClaimerTableCell") as! DisClaimerTableCell
            
            if dicSupportList.count > 0 {
                let dicClaim: NSDictionary = dicSupportList["legal-disclaimers"] as! NSDictionary
                cell.lblDisClaimer.attributedText = (dicClaim["content"] as? String)?.htmlAttributed(using: UIFont(name: "Roboto", size: 14)!, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
            }
            
            return cell
        } else if indexPath.row == 2 {
            let cell : CustomFAQHeaderTableCell = tableView.dequeueReusableCell(withIdentifier: "CustomFAQHeaderTableCell") as! CustomFAQHeaderTableCell
            
            cell.lblFAQHeader.text = "FAQ"
            
            return cell
        } else if indexPath.row == (indexNo-1) {
            let cell : MessageTableCell = tableView.dequeueReusableCell(withIdentifier: "MessageTableCell") as! MessageTableCell
            
            cell.lblTitle.text = "Still stuck?Help is mail away"
            cell.btnSendMessage.addTarget(self, action: #selector(btnSendMsgTap(_:)), for: UIControl.Event.touchUpInside)
            
            return cell
        } else {// if indexPath.row == 2
            let cell : CustomFAQTableCell = tableView.dequeueReusableCell(withIdentifier: "CustomFAQTableCell") as! CustomFAQTableCell
            let index = (indexPath.row) - 3
            let dicFAQ: NSDictionary = dicFAQList[index] as! NSDictionary
            if dicFAQ.count > 0 {
                cell.lblFAQTitle.text = String(describing: dicFAQ["title"]!)
                cell.lblFAQContent.attributedText = (dicFAQ["content"] as? String)?.htmlAttributed(using: UIFont(name: "Roboto", size: 14)!, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
                cell.btnFAQ.addTarget(self, action: #selector(btnFAQTap(_:)), for: UIControl.Event.touchUpInside)
            }
            
            return cell
        }
    }
    
    //MARK:- TableView Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .phone {
            if indexPath.row == 0 {
                return UITableView.automaticDimension
            } else if indexPath.row == 1 {
                return UITableView.automaticDimension
            } else if indexPath.row == 2 {
                return 65
            } else if indexPath.row == (indexNo-1) {
                return 175
            } else {
                if fetchIndex == indexPath.row {
                    return UITableView.automaticDimension
                } else {
                    return 70
                }
            }
        } else {
            if indexPath.row == 0 {
                return UITableView.automaticDimension
            } else if indexPath.row == 1 {
                return UITableView.automaticDimension
            } else if indexPath.row == 2 {
                return 95
            } else if indexPath.row == (indexNo-1) {
                return 245
            } else {
                if fetchIndex == indexPath.row {
                    return UITableView.automaticDimension
                } else {
                    return 85
                }
            }
        }
    }
}
