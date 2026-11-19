//
//  HelpSupportVC.swift
//  Leaktronics
//
//  Created by ivaninfotech on 6/9/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class HelpSupportVC: UIViewController, UIAlertViewDelegate {
    
    @IBOutlet weak var tblHelpList: UITableView!
    var arrayMenu = [Dictionary<String,String>]()

    var dicSupportList = NSDictionary()
    var dicFAQList = NSArray()
    
    var fetchIndex = Int()
    var indexNo = Int()
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrayMenu = [
             ["title": "Help Center", "icon": "Path 737"],
             ["title": "Email Technical Support", "icon": "Group 460"],
             ["title": "Call Technical Support 033-5214-5624", "icon": "Group 457"]
         ]
        
        // Do any additional setup after loading the view.
      //  self.getHelpList()
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

extension HelpSupportVC: UITableViewDelegate, UITableViewDataSource {
    //MARK:- TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // indexNo = dicFAQList.count + 4
        indexNo =  3
        return indexNo
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HelpTableCell") as! HelpTableCell
        
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.backgroundColor = UIColor.clear
        
        cell.imagwHelp.image = UIImage(named: arrayMenu[indexPath.row]["icon"]!)
        cell.lblHelp.text = arrayMenu[indexPath.row]["title"]!
        
        if UIDevice.current.screenType.rawValue == "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE" {
            cell.lblHelp.font = UIFont(name: "Roboto-Regular", size: 12)
        } else {
            cell.lblHelp.font = UIFont(name: "Roboto-Regular", size: 18)
        }
        
        return cell

    }
    
    //MARK:- TableView Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 112
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            if UIDevice.current.userInterfaceIdiom == .phone {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Home_iPhone", bundle:nil)
                let nextVC = storyBoard.instantiateViewController(withIdentifier: "HelpCenterVC") as! HelpCenterVC
                self.navigationController?.pushViewController(nextVC, animated: true)
            } else { //UIDevice.current.userInterfaceIdiom == .pad
                let storyBoard : UIStoryboard = UIStoryboard(name: "Home_iPad", bundle:nil)
                let nextVC = storyBoard.instantiateViewController(withIdentifier: "HelpCenterVC") as! HelpCenterVC
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        } else if indexPath.row == 1 {
            if UIDevice.current.userInterfaceIdiom == .phone {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Home_iPhone", bundle:nil)
                let nextVC = storyBoard.instantiateViewController(withIdentifier: "EmailTechnicalSupportVC") as! EmailTechnicalSupportVC
                self.navigationController?.pushViewController(nextVC, animated: true)
            } else { //UIDevice.current.userInterfaceIdiom == .pad
                let storyBoard : UIStoryboard = UIStoryboard(name: "Home_iPad", bundle:nil)
                let nextVC = storyBoard.instantiateViewController(withIdentifier: "EmailTechnicalSupportVC") as! EmailTechnicalSupportVC
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        } else if indexPath.row == 2 {
            // Calling Functionality
            let phoneNumber = "\(03352145624)"
            if let phoneCallURL = URL(string: "telprompt://\(phoneNumber)") {

                let application:UIApplication = UIApplication.shared
                if (application.canOpenURL(phoneCallURL)) {
                    if #available(iOS 10.0, *) {
                        application.open(phoneCallURL, options: [:], completionHandler: nil)
                    } else {
                        // Fallback on earlier versions
                         application.openURL(phoneCallURL as URL)

                    }
                }
            }
        }
    }
}


/*
 
 func makePhoneCall(phoneNumber: String) {
   if let phoneURL = NSURL(string: ("tel://" + phoneNumber!)) {
       let alert = UIAlertController(title: ("Call " + phoneNumber! + "?"), message: nil, preferredStyle: .Alert)
       alert.addAction(UIAlertAction(title: "Call", style: .Default, handler: { (action) in
           UIApplication.sharedApplication().openURL(phoneURL)
       }))
 
       alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
               
       self.presentViewController(alert, animated: true, completion: nil)
   }
}
 */
