//
//  SideMenuVC.swift
//  Leaktronics
//
//  Created by ivaninfotech on 6/4/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire
import SVProgressHUD

protocol SlideMenuDelegate {
    func slideMenuItemSelectedAtIndex(_ index : Int32)
}

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var vwImage: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        vwImage.layer.cornerRadius = vwImage.frame.size.width/2
//        vwImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


class ProfileMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var vwProfileImage: UIImageView!
    @IBOutlet weak var lblProfileTitle: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        vwProfileImage.layer.cornerRadius = vwProfileImage.frame.size.width/2
        vwProfileImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}


class SideMenuVC: UIViewController, UINavigationControllerDelegate {
    
    var arrayMenu = [Dictionary<String,String>]()
    var delegate : SlideMenuDelegate?
    
    @IBOutlet weak var tblMenu: UITableView!
    var logIndict = NSDictionary()
    var fileUrl = NSURL()
    var deviceID = String()
    var accessToken = String()
    var accessTokenData = String()
    var currentController = String()
    var login_Token = String()
    var window: UIWindow?
    /**
     *  Menu button which was tapped to display the menu
     */
    //var btnMenu : UIButton!
    var btnMenu = UIButton()
    
    /**
     *  Transparent button to hide menu
     */
    @IBOutlet var btnCloseMenuOverlay : UIButton!
    
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        print(currentController)
        let loginData = UserDefaults.standard.object(forKey: "key_profile_info")
        logIndict = NSKeyedUnarchiver.unarchiveObject(with: loginData as! Data) as! NSDictionary
        print("UserDict: == \(logIndict)")
        login_Token = UserDefaults.standard.value(forKey: "key_token") as! String as! String
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        let loginData = UserDefaults.standard.object(forKey: "key_profile_info")
        logIndict = NSKeyedUnarchiver.unarchiveObject(with: loginData as! Data) as! NSDictionary
        print("UserDict: == \(logIndict)")
        
        
        arrayMenu = [
            ["title": "Profile", "icon": "profile_Menu"],
            ["title": "Subscription", "icon": "subscription_Menu"],
            ["title": "Report", "icon": "report_Menu"],
            ["title": "Help & Support", "icon": "help_Menu"],
            ["title": "Logout", "icon": "logout_Menu"]
        ]
        
        //["title": "Logout", "icon": "logout_Menu"]
    }
    
    //MARK:- Function
    @IBAction func onCloseMenuClick(_ button:UIButton!) {
        btnMenu.tag = 0
        
        if (self.delegate != nil) {
            var index = Int32(button.tag)
            if (button == self.btnCloseMenuOverlay) {
                index = -1
            }
            delegate?.slideMenuItemSelectedAtIndex(index)
        }
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.clear
        }, completion: { (finished) -> Void in
            self.view.removeFromSuperview()
            self.removeFromParent()
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func onLogoutClick(_ button:UIButton!) {
        print("Logout\n", terminator: "")
        
//        let loginData = UserDefaults.standard.object(forKey: "key_profile_info")
//        logIndict = NSKeyedUnarchiver.unarchiveObject(with: loginData as! Data) as! NSDictionary
//        print("UserDict: == \(logIndict)")
//        let login_Token = "\(logIndict.value(forKey: "token")!)"
//        print(login_Token)
        
        //self.apiCallLogout()
        UserDefaults.standard.removeObject(forKey: "key_profile_info")
        UserDefaults.standard.set(false, forKey: "login")
        UserDefaults.standard.removeObject(forKey: "registerToken")
        if UIDevice.current.userInterfaceIdiom == .phone {
           let appDelegate = UIApplication.shared.delegate as? AppDelegate
            let loginController = UIStoryboard(name: "Main_iPhone", bundle: nil).instantiateViewController(withIdentifier: "Login")
            let nav = UINavigationController(rootViewController: loginController)
            nav.navigationBar.isHidden = true;
            appDelegate?.window!.rootViewController = nav
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            let loginController = UIStoryboard(name: "Main_iPad", bundle: nil).instantiateViewController(withIdentifier: "Login")
            let nav = UINavigationController(rootViewController: loginController)
            nav.navigationBar.isHidden = true;
            appDelegate?.window!.rootViewController = nav
        }
    }
    
    
    //MARK: - API Call
    func apiCallLogout() {
        SVProgressHUD.show(withStatus: "Processing...")
        let todosEndpoint: String = "http://18.217.242.170/api/logout"
        
        let newTodo: [String: Any] = ["login_token": login_Token]
        print("Parameter:== \(newTodo)")
        
        Alamofire.request(todosEndpoint, method: .post, parameters: newTodo,
                          encoding: JSONEncoding.default)
            .responseJSON { response in
                guard let json = response.result.value as? [String: Any] else {
                    print("didn't get todo object as JSON from API")
                    //print("Error: \(response.result.error as! NSString)")
                    SVProgressHUD.dismiss()
                    return
                }
                //print(json)
                print("JSON: \(json)")
                UserDefaults.standard.removeObject(forKey: "key_profile_info")
                UserDefaults.standard.set(false, forKey: "login")
                UserDefaults.standard.removeObject(forKey: "registerToken")
                if UIDevice.current.userInterfaceIdiom == .phone {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main_iPhone", bundle:nil)
                    let BeforeLoginView = storyBoard.instantiateViewController(withIdentifier: "Login") as! LoginVC
                    let navi =  UINavigationController.init(rootViewController: BeforeLoginView)
                } else if UIDevice.current.userInterfaceIdiom == .pad {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main_iPad", bundle:nil)
                    let BeforeLoginView = storyBoard.instantiateViewController(withIdentifier: "Login") as! LoginVC
                    let navi =  UINavigationController.init(rootViewController: BeforeLoginView)
                }
        }
    }
}

extension SideMenuVC: UITableViewDelegate, UITableViewDataSource {
    //MARK:- TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : MenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell") as! MenuTableViewCell
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.backgroundColor = UIColor.clear
        
        cell.vwImage.image = UIImage(named: arrayMenu[indexPath.row]["icon"]!)
        cell.lblTitle.text = arrayMenu[indexPath.row]["title"]!
        
        if UIDevice.current.screenType.rawValue == "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE" {
            cell.lblTitle.font = UIFont(name: "Roboto-Regular", size: 12)
        } else {
            cell.lblTitle.font = UIFont(name: "Roboto-Regular", size: 18)
        }
        
        return cell
    }
    
    //MARK:- TableView Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = (self.tblMenu.frame.size.height)/5
        print(self.tblMenu.frame.size.height)
        print(height)
        return height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.tag = indexPath.row

        self.onCloseMenuClick(btn)*/
        

        if indexPath.row == 0 {
            if UIDevice.current.userInterfaceIdiom == .phone {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Home_iPhone", bundle:nil)
                let nextVC = storyBoard.instantiateViewController(withIdentifier: "AccountSettings") as! AccountSettingsVC
                self.navigationController?.pushViewController(nextVC, animated: true)
            } else { //UIDevice.current.userInterfaceIdiom == .pad
                let storyBoard : UIStoryboard = UIStoryboard(name: "Home_iPad", bundle:nil)
                let nextVC = storyBoard.instantiateViewController(withIdentifier: "AccountSettings") as! AccountSettingsVC
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        } else if indexPath.row == 1 {
            if UIDevice.current.userInterfaceIdiom == .phone {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Home_iPhone", bundle:nil)
                let nextVC = storyBoard.instantiateViewController(withIdentifier: "Subscription") as! SubscriptionVC
                self.navigationController?.pushViewController(nextVC, animated: true)
            } else { //UIDevice.current.userInterfaceIdiom == .pad
                let storyBoard : UIStoryboard = UIStoryboard(name: "Home_iPad", bundle:nil)
                let nextVC = storyBoard.instantiateViewController(withIdentifier: "Subscription") as! SubscriptionVC
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
    }else if indexPath.row == 2 {
        if UIDevice.current.userInterfaceIdiom == .phone {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Home_iPhone", bundle:nil)
            let nextVC = storyBoard.instantiateViewController(withIdentifier: "ReportList") as! ReportListVC
            self.navigationController?.pushViewController(nextVC, animated: true)
        } else { //UIDevice.current.userInterfaceIdiom == .pad
            let storyBoard : UIStoryboard = UIStoryboard(name: "Home_iPad", bundle:nil)
            let nextVC = storyBoard.instantiateViewController(withIdentifier: "ReportList") as! ReportListVC
            self.navigationController?.pushViewController(nextVC, animated: true)
            }
        }else if indexPath.row == 3 {
            if UIDevice.current.userInterfaceIdiom == .phone {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Home_iPhone", bundle:nil)
                let nextVC = storyBoard.instantiateViewController(withIdentifier: "HelpSupport") as! HelpSupportVC
                self.navigationController?.pushViewController(nextVC, animated: true)
            } else { //UIDevice.current.userInterfaceIdiom == .pad
                let storyBoard : UIStoryboard = UIStoryboard(name: "Home_iPad", bundle:nil)
                let nextVC = storyBoard.instantiateViewController(withIdentifier: "HelpSupport") as! HelpSupportVC
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        } else if indexPath.row == 4 {
            print("Logout\n", terminator: "")
            
            UserDefaults.standard.removeObject(forKey: "key_profile_info")
            UserDefaults.standard.set(false, forKey: "login")
            UserDefaults.standard.removeObject(forKey: "registerToken")
            if UIDevice.current.userInterfaceIdiom == .phone {
               let appDelegate = UIApplication.shared.delegate as? AppDelegate
                let loginController = UIStoryboard(name: "Main_iPhone", bundle: nil).instantiateViewController(withIdentifier: "Login")
                let nav = UINavigationController(rootViewController: loginController)
                nav.navigationBar.isHidden = true;
                appDelegate?.window!.rootViewController = nav
            } else if UIDevice.current.userInterfaceIdiom == .pad {
                let appDelegate = UIApplication.shared.delegate as? AppDelegate
                let loginController = UIStoryboard(name: "Main_iPad", bundle: nil).instantiateViewController(withIdentifier: "Login")
                let nav = UINavigationController(rootViewController: loginController)
                nav.navigationBar.isHidden = true;
                appDelegate?.window!.rootViewController = nav
            }
        }
    }
}


