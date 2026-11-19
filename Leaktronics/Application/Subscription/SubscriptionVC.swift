//
//  SubscriptionVC.swift
//  Leaktronics
//
//  Created by ivaninfotech on 6/9/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import Heartland_iOS_SDK
import SVProgressHUD
import Alamofire

protocol SubscriptionCellProtocol {
    func didTapOnCellSubscription(_ indexPath: IndexPath)
}

class SubscriptionCell: UITableViewCell {
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var btnCheck: UIButton!
    
    //TODO:: Variable Declaration
    var delegateSubScript: SubscriptionCellProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        innerView.layer.cornerRadius = 5
        innerView.clipsToBounds = true
        innerView.layer.shadowPath = UIBezierPath(rect: innerView.bounds).cgPath
        innerView.layer.shadowRadius = 5
        innerView.layer.shadowColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        innerView.layer.shadowOffset = .zero
        innerView.layer.shadowOpacity = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func initCellItem() {
        let deselectedImage = UIImage(named: "unchecked")//?.withRenderingMode(.alwaysTemplate)
        let selectedImage = UIImage(named: "checkmark")//?.withRenderingMode(.alwaysTemplate)
        btnCheck.setImage(deselectedImage, for: .normal)
        btnCheck.setImage(selectedImage, for: .selected)
        btnCheck.addTarget(self, action: #selector(self.radioButtonTapped), for: .touchUpInside)
    }

    @objc func radioButtonTapped(_ radioButton: UIButton) {
        print("radio button tapped")
        let isSelected = !self.btnCheck.isSelected
        self.btnCheck.isSelected = isSelected
        if isSelected {
            deselectOtherButton()
        }
        let tableView = self.superview as! UITableView
        let tappedCellIndexPath = tableView.indexPath(for: self)!
        delegateSubScript?.didTapOnCellSubscription(tappedCellIndexPath)
    }

    func deselectOtherButton() {
        let tableView = self.superview as! UITableView
        let tappedCellIndexPath = tableView.indexPath(for: self)!
        let indexPaths = tableView.indexPathsForVisibleRows
        for indexPath in indexPaths! {
            if indexPath.row != tappedCellIndexPath.row && indexPath.section == tappedCellIndexPath.section {
                let cell = tableView.cellForRow(at: IndexPath(row: indexPath.row, section: indexPath.section)) as! SubscriptionCell
                cell.btnCheck.isSelected = false
            }
        }
    }
}


class SubscriptionVC: UIViewController, SubscriptionCellProtocol {
    
    @IBOutlet weak var tblSubscription: UITableView!
    
    let menuList = [["Monthly", "Annual", "Free"]]
    var selectSubscription = String()
    var selectedIndex = Int()
    //[Int : String]()
    var arrSubscriptionList = NSArray()
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.getSubscriptionList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
           let backButton = UIBarButtonItem()
           backButton.title = "Subscription"
           backButton.tintColor = UIColor.black
           self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    //MARK:: Function Api Calling
       func getSubscriptionList() {
           SVProgressHUD.setDefaultMaskType(.clear)
           SVProgressHUD.show(withStatus: "Processing...")
                     
           let todosEndpoint: String = ServiceConstant.BASE_URL.appending(ServiceConstant.GetSubscription)
           let token: String = UserDefaults.standard.value(forKey: "key_token") as! String
           let headers: HTTPHeaders = [
               "Content-Type": "application/json",
               "Authorization": token
           ]
           
           
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
                       print("Subscription json :: \(String(describing: json))")
                       let dic: NSDictionary = json["data"] as! NSDictionary
                       self.arrSubscriptionList = dic["subscription_list"] as! NSArray
                       print("SubscriptionList json :: \(String(describing: self.arrSubscriptionList))")

                       DispatchQueue.main.async(execute: {() -> Void in
                           self.tblSubscription.reloadData()
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
            
    //MARK:- delegateSubScript
    func didTapOnCellSubscription(_ indexPath: IndexPath) {
        selectedIndex = indexPath.row
        
//        let section = indexPath.section
//        selectSubscription  = menuList[section][indexPath.row]
//
//        if let previousItem = selectedIndex[section] {
//            if previousItem == selectSubscription {
//                selectedIndex.removeValue(forKey: section)
//                return
//            }
//        }
//        selectedIndex.updateValue(selectSubscription, forKey: section)
        print(selectedIndex)
    }
    
    
    //MARK:- Subscription Button Action
    @IBAction func btnSubscriptionDidTap(_ sender: Any) {
        print(self.arrSubscriptionList[selectedIndex])
        let dic: NSDictionary = self.arrSubscriptionList[selectedIndex] as! NSDictionary
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Home_iPhone", bundle:nil)
            let cardVC = storyBoard.instantiateViewController(withIdentifier: "CardView") as! CardViewVC
            cardVC.selectSubscription = dic["id"] as! String
            self.navigationController?.pushViewController(cardVC, animated: true)
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Home_iPad", bundle:nil)
            let cardVC = storyBoard.instantiateViewController(withIdentifier: "CardView") as! CardViewVC
            cardVC.selectSubscription = dic["id"] as! String
            self.navigationController?.pushViewController(cardVC, animated: true)
        }
    }
}


extension SubscriptionVC: UITableViewDelegate, UITableViewDataSource {
    //MARK:- TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrSubscriptionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : SubscriptionCell = tableView.dequeueReusableCell(withIdentifier: "SubscriptionCell") as! SubscriptionCell
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.backgroundColor = UIColor.clear

        let dic: NSDictionary = self.arrSubscriptionList[indexPath.row] as! NSDictionary
        
        cell.lblTitle.text = dic["subscription"] as? String
        if dic["subscription"] as? String == "Monthly Subscription" {
             cell.lblPrice.text = dic["price"] as? String
             cell.lblDate.text = "/ month"
        } else {
            cell.lblPrice.text = dic["price"] as? String
            cell.lblDate.text = "/ year"
        }
        cell.initCellItem()
        cell.delegateSubScript = self
        
        return cell
    }
    
    //MARK:- TableView Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return 125
        } else {
            return 225
        }
    }
}
