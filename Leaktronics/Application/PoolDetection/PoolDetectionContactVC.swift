//
//  PoolDetectionContactVC.swift
//  Leaktronics
//
//  Created by ivaninfotech on 4/7/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import CoreData
import SVProgressHUD


class DataValueTableCell: UITableViewCell {
    @IBOutlet weak var lblTag: UILabel!
    @IBOutlet weak var txtData: UITextField!
    

    //MARK:- View Lifecycle
        //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.lblTag.textColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
        self.txtData.layer.borderColor = UIColor.black.cgColor//UIColor.black.cgColor //
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtData.layer.borderWidth = 0.68
            self.txtData.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtData.layer.borderWidth = 0.85
            self.txtData.layer.cornerRadius = 10
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

class PriceValueTableCell: UITableViewCell {
    @IBOutlet weak var lblTag: UILabel!
    @IBOutlet weak var txtData: UITextField!

    //MARK:- View Lifecycle
        //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.lblTag.textColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
        self.txtData.layer.borderColor = UIColor.black.cgColor//UIColor.black.cgColor //
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtData.layer.borderWidth = 0.68
            self.txtData.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtData.layer.borderWidth = 0.85
            self.txtData.layer.cornerRadius = 10
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

class AddressTableCell: UITableViewCell {
    @IBOutlet weak var lblTag: UILabel!
    @IBOutlet weak var txtAddress: UITextView!
    
    //MARK:- View Lifecycle
            //TODO:: View Lifecycle
    override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code

            self.lblTag.textColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
            self.txtAddress.layer.borderColor = UIColor.black.cgColor
            
            if UIDevice.current.userInterfaceIdiom == .phone {
                self.txtAddress.layer.borderWidth = 0.68
                self.txtAddress.layer.cornerRadius = 5
            } else if UIDevice.current.userInterfaceIdiom == .pad {
                self.txtAddress.layer.borderWidth = 0.85
                self.txtAddress.layer.cornerRadius = 10
            }
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
        }

}

class NextForm1TableCell: UITableViewCell {
    @IBOutlet weak var btnNext: UIButton!
    
    //MARK:- View Lifecycle
        //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        self.btnNext.tintColor = #colorLiteral(red: 0.9474589229, green: 0.2073712945, blue: 0.1776620746, alpha: 1)
        self.btnNext.layer.borderColor = #colorLiteral(red: 0.9474589229, green: 0.2073712945, blue: 0.1776620746, alpha: 1)
        self.btnNext.clipsToBounds = true
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.btnNext.layer.borderWidth = 0.68
            self.btnNext.layer.cornerRadius = 25
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.btnNext.layer.borderWidth = 0.85
            self.btnNext.layer.cornerRadius = 40
        }
    }
}

class DateValueTableCell: UITableViewCell {
    @IBOutlet weak var lblTag: UILabel!
    @IBOutlet weak var txtData: UITextField!
    @IBOutlet weak var btnDate: UIButton!

    //MARK:- View Lifecycle
        //TODO:: View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.lblTag.textColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
        self.txtData.layer.borderColor = UIColor.black.cgColor//UIColor.black.cgColor //
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.txtData.layer.borderWidth = 0.68
            self.txtData.layer.cornerRadius = 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.txtData.layer.borderWidth = 0.85
            self.txtData.layer.cornerRadius = 10
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

class PoolDetectionContactVC: UIViewController {
    
    @IBOutlet weak var tblContact: UITableView!
    
    @IBAction func btnPhoneQuestionariesDidtap(_ sender: Any) {
         if UIDevice.current.userInterfaceIdiom == .phone {
             let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection", bundle:nil)
             let nextVC = storyBoard.instantiateViewController(withIdentifier: "QuestionnaireForm1VC") as! QuestionnaireForm1VC
             //let nextVC = storyBoard.instantiateViewController(withIdentifier: "PoolDetect") as! PoolDetectVC
             self.navigationController?.pushViewController(nextVC, animated: true)
         } else { //UIDevice.current.userInterfaceIdiom == .pad
             let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection_iPad", bundle:nil)
             let nextVC = storyBoard.instantiateViewController(withIdentifier: "QuestionnaireForm1VC") as! QuestionnaireForm1VC
             self.navigationController?.pushViewController(nextVC, animated: true)
         }
    }
    
    @IBAction func btnVisualLeakInspectionDidtap(_ sender: Any) {
//         if UIDevice.current.userInterfaceIdiom == .phone {
//             let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection", bundle:nil)
//             let nextVC = storyBoard.instantiateViewController(withIdentifier: "PoolDetectionContactVC") as! PoolDetectionContactVC
//             //let nextVC = storyBoard.instantiateViewController(withIdentifier: "PoolDetect") as! PoolDetectVC
//             self.navigationController?.pushViewController(nextVC, animated: true)
//         } else { //UIDevice.current.userInterfaceIdiom == .pad
//             let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection_iPad", bundle:nil)
//             let nextVC = storyBoard.instantiateViewController(withIdentifier: "PoolDetectionContactVC") as! PoolDetectionContactVC
//             self.navigationController?.pushViewController(nextVC, animated: true)
//         }
    }

    
    var strReport_id = String()
    var poolDetailsDict = [String : AnyObject]()
    var poolDict = [String : AnyObject]()
    var secPool1 = [formData]()
    var secPool2 = [formData]()
    
    private var sectionIndex = -1
    private var selectedRowIndex = -1
    
    enum Contact: Int {
        case name = 0
        case address = 1
        case city = 2
        case state = 3
        case zip = 4
        case phone = 5
        case email = 6
        case payment = 7
    }
    
    enum Payment: Int {
        case note = 0
        case otherNote = 1
        case price = 2
        case time = 3
    }
    
    @IBAction func PhoneQuationaryClick(_ button:UIButton!){
//         if UIDevice.current.userInterfaceIdiom == .phone {
//             let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection", bundle:nil)
//             let nextVC = storyBoard.instantiateViewController(withIdentifier: "QuestionnaireForm1VC") as! QuestionnaireForm1VC
//             //let nextVC = storyBoard.instantiateViewController(withIdentifier: "PoolDetect") as! PoolDetectVC
//             self.navigationController?.pushViewController(nextVC, animated: true)
//         } else { //UIDevice.current.userInterfaceIdiom == .pad
//             let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection_iPad", bundle:nil)
//             let nextVC = storyBoard.instantiateViewController(withIdentifier: "QuestionnaireForm1VC") as! QuestionnaireForm1VC
//             self.navigationController?.pushViewController(nextVC, animated: true)
//         }
        
        self.btnNextDidTap()
        
    }
    
    @IBAction func VisualLickInspectionClick(_ button:UIButton!){
//         if UIDevice.current.userInterfaceIdiom == .phone {
//             let storyBoard : UIStoryboard = UIStoryboard(name: "Home_iPhone", bundle:nil)
//             let nextVC = storyBoard.instantiateViewController(withIdentifier: "ReportListVC") as! ReportListVC
//             //let nextVC = storyBoard.instantiateViewController(withIdentifier: "PoolDetect") as! PoolDetectVC
//             self.navigationController?.pushViewController(nextVC, animated: true)
//         } else { //UIDevice.current.userInterfaceIdiom == .pad
//             let storyBoard : UIStoryboard = UIStoryboard(name: "Home_iPad", bundle:nil)
//             let nextVC = storyBoard.instantiateViewController(withIdentifier: "ReportListVC") as! ReportListVC
//             self.navigationController?.pushViewController(nextVC, animated: true)
//         }
    }
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.prepareFormData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = UIColor.black
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        if strReport_id == "" {

        } else {
            self.postReportDetailsEdit()
        }
    }
    
    //MARK:- Function
    func prepareFormData() {
        for _ in 0..<9 {
            let obj = formData()
            self.secPool1.append(obj)
        }
        
        for _ in 0..<4 {
            let obj = formData()
            self.secPool2.append(obj)
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
    
    
    //MARK:- ObjectiveC Function
    @objc func btnDatePickerDidTap() {
        DatePickerDialog().show("DatePicker", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .dateAndTime) {
            (date) -> Void in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "MM/dd/YYYY HH:mm"
                print(dt)
                //textField.text = formatter.string(from: dt)
                self.secPool2[3].formTextValue = formatter.string(from: dt)//(textfield.text)!
                self.tblContact.reloadData()
            }
        }
    }
    
    @objc func btnNextDidTap() {
        if self.secPool1[Contact.name.rawValue].formTextValue == "" {
            let alert = UIAlertController(title: "Alert", message: "Please enter Contact Name", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                  switch action.style{
                  case .cancel:
                        print("cancel")
                  case .destructive:
                        print("destructive")
                  case .default:
                    break
                  @unknown default: break
                }}))
            self.present(alert, animated: true, completion: nil)
        } else {
            if strReport_id == "" {
               // self.updateCoreData(strReport_id: strReport_id)
                saveIntoCoreData()
                self.postPoolDetectionContactDetails()
            } else {
                self.updateCoreData(strReport_id: strReport_id)
                self.postPoolDetectionContactDetailsUpdate()
            }
            //self.checkNetwork()
//            if UIDevice.current.userInterfaceIdiom == .phone {
//                let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection", bundle:nil)
//                let formVC = storyBoard.instantiateViewController(withIdentifier: "QuestionnaireForm1") as! QuestionnaireForm1VC
//                self.navigationController?.pushViewController(formVC, animated: true)
//            } else if UIDevice.current.userInterfaceIdiom == .pad {
//                let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection_iPad", bundle:nil)
//                let formVC = storyBoard.instantiateViewController(withIdentifier: "QuestionnaireForm1") as! QuestionnaireForm1VC
//                self.navigationController?.pushViewController(formVC, animated: true)
//            }
        }
    }
    
    func checkNetwork() {
        print("Network::\(Network.reachability.status )")
        switch Network.reachability.status {
        case .unreachable:
            print("Internet not available")
            self.saveIntoCoreData()
            if UIDevice.current.userInterfaceIdiom == .phone {
                let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection", bundle:nil)
                let formVC = storyBoard.instantiateViewController(withIdentifier: "QuestionnaireForm1") as! QuestionnaireForm1VC
                self.navigationController?.pushViewController(formVC, animated: true)
            } else if UIDevice.current.userInterfaceIdiom == .pad {
                let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection_iPad", bundle:nil)
                let formVC = storyBoard.instantiateViewController(withIdentifier: "QuestionnaireForm1") as! QuestionnaireForm1VC
                self.navigationController?.pushViewController(formVC, animated: true)
            }
        case .wwan:
            if strReport_id == "" {
                self.updateCoreData(strReport_id: strReport_id)
                self.postPoolDetectionContactDetails()
            } else {
                self.updateCoreData(strReport_id: strReport_id)
                self.postPoolDetectionContactDetailsUpdate()
            }
        case .wifi:
            if strReport_id == "" {
                self.updateCoreData(strReport_id: strReport_id)
                self.postPoolDetectionContactDetails()
            } else {
                self.updateCoreData(strReport_id: strReport_id)
                self.postPoolDetectionContactDetailsUpdate()
            }
        }
        print("Reachability Summary")
        print("Status:", Network.reachability.status)
        print("HostName:", Network.reachability.hostname ?? "nil")
        print("Reachable:", Network.reachability.isReachable)
        print("Wifi:", Network.reachability.isReachableViaWiFi)
    }
    
    //MARK:- CoreData
    func saveIntoCoreData() {
        UserDefaults.standard.removeObject(forKey: "PoolDetectionUserName")
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Pool1_CoreData", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        
        newUser.setValue(self.secPool1[Contact.name.rawValue].formTextValue, forKey: "namePoolDetection")
        newUser.setValue(self.secPool1[Contact.address.rawValue].formTextValue, forKey: "addressPool")
        newUser.setValue(self.secPool1[Contact.city.rawValue].formTextValue, forKey: "cityPool")
        newUser.setValue(self.secPool1[Contact.state.rawValue].formTextValue, forKey: "statePool")
        newUser.setValue(self.secPool1[Contact.zip.rawValue].formTextValue, forKey: "zipPool")
        newUser.setValue(self.secPool1[Contact.phone.rawValue].formTextValue, forKey: "phoneNoPool")
        newUser.setValue(self.secPool1[Contact.email.rawValue].formTextValue, forKey: "emailPool")
        newUser.setValue(self.secPool2[Payment.note.rawValue].formTextValue, forKey: "notesPool")
        newUser.setValue(self.secPool2[Payment.otherNote.rawValue].formTextValue, forKey: "otherNotesPool")
        newUser.setValue(self.secPool2[Payment.price.rawValue].formTextValue, forKey: "priceForLeakPool")
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "MM/dd/YYYY HH:mm"
        let formattedDate = format.string(from: date)
        print(formattedDate)
        
        //newUser.setValue(formattedDate, forKey:"pool_inspection_date_time")
        newUser.setValue(self.secPool2[Payment.time.rawValue].formTextValue, forKey:"pool_inspection_date_time")
        
        
        do {
            try context.save()
            UserDefaults.standard.set(self.secPool1[Contact.name.rawValue].formTextValue, forKey: "PoolDetectionUserName")
        } catch {
            print("Failed saving")
        }
        
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PoolDetection_CoreData")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false

        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let userName: String = UserDefaults.standard.value(forKey: "PoolDetectionUserName") as! String
                if (data.value(forKey: "namePoolDetection") as! String) == userName {
                    print("Data of PoolDetectContact:: \(data)")
                    print(data.value(forKey: "namePoolDetection") as! String)
                }
                print("namePoolDetection::",data.value(forKey: "namePoolDetection") as! String)
                print("addressPool::",data.value(forKey: "addressPool") as! String)
                print("cityPool::",data.value(forKey: "cityPool") as! String)
                print("statePool::",data.value(forKey: "statePool") as! String)
                print("zipPool::",data.value(forKey: "zipPool") as Any)
                print("phoneNo::",data.value(forKey: "phoneNoPool") as Any)
                print("email::",data.value(forKey: "emailPool") as! String)
                print("notes::",data.value(forKey: "notesPool") as! String)
                print("otherNotes::",data.value(forKey: "otherNotesPool") as! String)
                print("priceForLeak::",data.value(forKey: "priceForLeakPool") as Any)
            }
        } catch {
            
            print("Failed")
        }
    }
    
    //MARK:- Update CoreData
    func updateCoreData(strReport_id: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        //For data fetch in coredata
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Pool1_CoreData")
        fetchRequest.returnsObjectsAsFaults = false
        
        let predicate = NSPredicate(format: "%K == %@", "report_id", strReport_id)
        fetchRequest.predicate = predicate
        
        do {
            let reportResult = try managedContext.fetch(fetchRequest) as! [Pool1_CoreData]
            print("Report Data\(reportResult) and count is \(reportResult.count)")
            
            if reportResult.count == 0 {
                print ("Inserting DB")
                
                let entity = NSEntityDescription.entity(forEntityName: "Pool1_CoreData", in: managedContext)
                let newUser = NSManagedObject(entity: entity!, insertInto: managedContext)
                
                newUser.setValue(self.poolDict["report_id"], forKey: "report_id")
                newUser.setValue(self.poolDict["namePoolDetection"], forKey: "namePoolDetection")
                newUser.setValue(self.poolDict["addressPool"], forKey: "addressPool")
                newUser.setValue(self.poolDict["cityPool"], forKey: "cityPool")
                newUser.setValue(self.poolDict["statePool"], forKey: "statePool")
                newUser.setValue(self.poolDict["zipPool"], forKey: "zipPool")
                newUser.setValue(self.poolDict["phoneNoPool"], forKey: "phoneNoPool")
                newUser.setValue(self.poolDict["emailPool"], forKey: "emailPool")
                newUser.setValue(self.poolDict["notesPool"], forKey: "notesPool")
                newUser.setValue(self.poolDict["otherNotesPool"], forKey: "otherNotesPool")
                newUser.setValue(self.poolDict["priceForLeakPool"], forKey: "priceForLeakPool")
                newUser.setValue(self.poolDict["inpectTimePool"], forKey:"pool_inspection_date_time")
                
                do {
                    try managedContext.save()
                    UserDefaults.standard.set(self.poolDict["namePoolDetection"], forKey: "PoolDetectionUserName")
                    print("Inserted")
                } catch let error as NSError {
                    print(error)
                }
            } else {
                print ("Updating DB")
                //For data fetch in coredata
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Pool1_CoreData")
                fetchRequest.returnsObjectsAsFaults = false
                
                let predicate = NSPredicate(format: "%K == %@", "report_id", strReport_id)
                fetchRequest.predicate = predicate
                
                let  rs = try managedContext.fetch(fetchRequest)
                for _ in rs as [NSManagedObject] {
                    // update
                    do {
                        let managedObject = rs[0]

                        managedObject.setValue(strReport_id, forKey: "report_id")
                        managedObject.setValue(self.secPool1[Contact.name.rawValue].formTextValue, forKey: "namePoolDetection")
                        managedObject.setValue(self.secPool1[Contact.address.rawValue].formTextValue, forKey: "addressPool")
                        managedObject.setValue(self.secPool1[Contact.city.rawValue].formTextValue, forKey: "cityPool")
                        managedObject.setValue(self.secPool1[Contact.state.rawValue].formTextValue, forKey: "statePool")
                        managedObject.setValue(self.secPool1[Contact.zip.rawValue].formTextValue, forKey: "zipPool")
                        managedObject.setValue(self.secPool1[Contact.phone.rawValue].formTextValue, forKey: "phoneNoPool")
                        managedObject.setValue(self.secPool1[Contact.email.rawValue].formTextValue, forKey: "emailPool")
                        managedObject.setValue(self.secPool2[Payment.note.rawValue].formTextValue, forKey: "notesPool")
                        managedObject.setValue(self.secPool2[Payment.otherNote.rawValue].formTextValue, forKey: "otherNotesPool")
                        managedObject.setValue(self.secPool2[Payment.price.rawValue].formTextValue, forKey: "priceForLeakPool")
                        let date = Date()
                        let format = DateFormatter()
                        format.dateFormat = "MM/dd/YYYY HH:mm"
                        let formattedDate = format.string(from: date)
                        print(formattedDate)

                        //managedObject.setValue(formattedDate, forKey:"pool_inspection_date_time")
                        managedObject.setValue(self.secPool2[Payment.time.rawValue].formTextValue, forKey:"pool_inspection_date_time")

                        try managedContext.save()
                        UserDefaults.standard.set(self.secPool1[Contact.name.rawValue].formTextValue, forKey: "PoolDetectionUserName")
                        print("update successfull")
                    } catch let error as NSError {
                        print("Could not Update. \(error), \(error.userInfo)")
                    }
                    //end update
                }
            }
        } catch let error as NSError {
            print("Could not Update. \(error), \(error.userInfo)")
        }
    }
    
    //MARK:: Function Api Calling
    func postReportDetailsEdit() {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        
        let editDetails: NSMutableDictionary = [
            "report_id" : strReport_id,
            "type"        : "Pool Leak Detection"
        ]
        
        print("editDetails :: \(editDetails)")
        //if sharedExtension.connectedToNetwork() {
        ApiManager.sharedInstanceAPI.PostReportDetailsEdit(postId: 1, reportDetailsEdit: editDetails, onSuccess: { json in
            DispatchQueue.main.async {
                print("PoolDetectionDetailsEdit json :: \(String(describing: json))")
                //let poolDetectDict = (json["data"] as AnyObject) as! [String : AnyObject]
                
                self.poolDetailsDict = (json["data"] as AnyObject) as! [String : AnyObject]
                self.poolDict = self.poolDetailsDict["page_1"] as! [String : AnyObject]
                
                self.updateCoreData(strReport_id: self.strReport_id)
                self.tblContact.reloadData()
                SVProgressHUD.dismiss()
            }
        }, onFailure: { error in
            DispatchQueue.main.sync(execute: {() -> Void in
                SVProgressHUD.dismiss()
                print("Error Message::\(error)")
                let alert = UIAlertController(title: "Alert", message: error["message"] as? String, preferredStyle: .alert)
                let dismissAction = UIAlertAction(title: "OK", style: .default) { (_) -> Void in
                    DispatchQueue.main.async(execute: {() -> Void in
                        
                    })
                }
                alert.addAction(dismissAction)
                self.present(alert, animated: true, completion: nil)
            })
        })
    }
    
    func postPoolDetectionContactDetails() {
        self.view.endEditing(true)
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        
        let contactDetails: NSMutableDictionary = [
            "device_id"             : (UIDevice.current.identifierForVendor?.uuidString)!,
            "namePoolDetection"     : self.secPool1[Contact.name.rawValue].formTextValue,
            "addressPool"           : self.secPool1[Contact.address.rawValue].formTextValue,
            "cityPool"              : self.secPool1[Contact.city.rawValue].formTextValue,
            "statePool"             : self.secPool1[Contact.state.rawValue].formTextValue,
            "zipPool"               : self.secPool1[Contact.zip.rawValue].formTextValue,
            "phoneNoPool"           : self.secPool1[Contact.phone.rawValue].formTextValue,
            "emailPool"             : self.secPool1[Contact.email.rawValue].formTextValue,
            "paymentPersonInspect"  : self.secPool1[Contact.payment.rawValue].formTextValue,
            "notesPool"                     : self.secPool2[Payment.note.rawValue].formTextValue,
            "otherNotesPool"        : self.secPool2[Payment.otherNote.rawValue].formTextValue,
            "priceForLeakPool"      : self.secPool2[Payment.price.rawValue].formTextValue,
            "inpectTimePool"        : self.secPool2[Payment.time.rawValue].formTextValue,//"2020-04-24 10:05:06",
            "inspection_date_time"  : self.secPool2[Payment.time.rawValue].formTextValue//"2020-04-24 10:05:06"
        ]
        
        print("Post ContactDetails :: \(contactDetails)")
        //if sharedExtension.connectedToNetwork() {
        ApiManager.sharedInstanceAPI.PostPoolDetectionContactDetails(postId: 1, contactDetails: contactDetails, onSuccess: { json in
            DispatchQueue.main.async {
                print("PoolDetectionContactDetails json :: \(String(describing: json))")
                //let poolDetectDict = (json["data"] as AnyObject) as! [String : AnyObject]
                
                let poolDetectDict = (json["data"] as AnyObject) as! [String : AnyObject]
                print("poolDetectDict:\(poolDetectDict)")
                if String(describing: json["status"]!) == "1" {
                    //store dic data
                    self.strReport_id = String(describing: poolDetectDict["return_data_id"]!)
                    
                    DispatchQueue.main.async(execute: {() -> Void in
                        if UIDevice.current.userInterfaceIdiom == .phone {
                            let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection", bundle:nil)
                            let formVC = storyBoard.instantiateViewController(withIdentifier: "QuestionnaireForm1") as! QuestionnaireForm1VC
                            formVC.strReport_id = self.strReport_id
                            self.navigationController?.pushViewController(formVC, animated: true)
                        } else if UIDevice.current.userInterfaceIdiom == .pad {
                            let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection_iPad", bundle:nil)
                            let formVC = storyBoard.instantiateViewController(withIdentifier: "QuestionnaireForm1") as! QuestionnaireForm1VC
                            formVC.strReport_id = self.strReport_id
                            self.navigationController?.pushViewController(formVC, animated: true)
                        }
                    })
                } 
                SVProgressHUD.dismiss()
            }
        }, onFailure: { error in
            DispatchQueue.main.sync(execute: {() -> Void in
                SVProgressHUD.dismiss()
                print("Error Message::\(error)")
                let alert = UIAlertController(title: "Alert", message: error["message"] as? String, preferredStyle: .alert)
                let dismissAction = UIAlertAction(title: "OK", style: .default) { (_) -> Void in
                    DispatchQueue.main.async(execute: {() -> Void in
                        
                    })
                }
                alert.addAction(dismissAction)
                self.present(alert, animated: true, completion: nil)
            })
        })
    }
    
    func postPoolDetectionContactDetailsUpdate() {
        self.view.endEditing(true)
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        
        let contactDetails: NSMutableDictionary = [
            "device_id"             : (UIDevice.current.identifierForVendor?.uuidString)!,
            "report_id"             : strReport_id,
            "namePoolDetection"     : self.secPool1[Contact.name.rawValue].formTextValue,
            "addressPool"           : self.secPool1[Contact.address.rawValue].formTextValue,
            "cityPool"              : self.secPool1[Contact.city.rawValue].formTextValue,
            "statePool"             : self.secPool1[Contact.zip.rawValue].formTextValue,
            "zipPool"               : self.secPool1[Contact.zip.rawValue].formTextValue,
            "phoneNoPool"           : self.secPool1[Contact.phone.rawValue].formTextValue,
            "emailPool"             : self.secPool1[Contact.email.rawValue].formTextValue,
            "paymentPersonInspect"  : self.secPool1[Contact.payment.rawValue].formTextValue,
            "notesPool"             : self.secPool2[Payment.note.rawValue].formTextValue,
            "otherNotesPool"        : self.secPool2[Payment.otherNote.rawValue].formTextValue,
            "priceForLeakPool"      : self.secPool2[Payment.price.rawValue].formTextValue,
            "inpectTimePool"        : self.secPool2[Payment.time.rawValue].formTextValue,//"2020-04-24 10:05:06",
            "inspection_date_time"  : self.secPool2[Payment.time.rawValue].formTextValue//"2020-04-24 10:05:06"
        ]
        
        print("Update ContactDetails :: \(contactDetails)")
        //if sharedExtension.connectedToNetwork() {
        ApiManager.sharedInstanceAPI.PostPoolDetectionContactDetailsUpdate(postId: 1, contactDetails: contactDetails, onSuccess: { json in
            DispatchQueue.main.async {
                print("PoolDetectionContactDetails json :: \(String(describing: json))")
                //let poolDetectDict = (json["data"] as AnyObject) as! [String : AnyObject]
                
                let poolDetectDict = (json["data"] as AnyObject) as! [String : AnyObject]
                
                //store dic data
                UserDefaults.standard.set(poolDetectDict["return_data_id"]!, forKey: "returnKeyForPoolDetect")
                
                DispatchQueue.main.async(execute: {() -> Void in
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "QuestionnaireForm1") as! QuestionnaireForm1VC
                        formVC.strReport_id = self.strReport_id
                        self.navigationController?.pushViewController(formVC, animated: true)
                    } else if UIDevice.current.userInterfaceIdiom == .pad {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection_iPad", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "QuestionnaireForm1") as! QuestionnaireForm1VC
                        formVC.strReport_id = self.strReport_id
                        self.navigationController?.pushViewController(formVC, animated: true)
                    }
                    SVProgressHUD.dismiss()
                })
            }
        }, onFailure: { error in
            DispatchQueue.main.sync(execute: {() -> Void in
                SVProgressHUD.dismiss()
                print("Error Message::\(error)")
                let alert = UIAlertController(title: "Alert", message: error["message"] as? String, preferredStyle: .alert)
                let dismissAction = UIAlertAction(title: "OK", style: .default) { (_) -> Void in
                    DispatchQueue.main.async(execute: {() -> Void in
                        
                    })
                }
                alert.addAction(dismissAction)
                self.present(alert, animated: true, completion: nil)
            })
        })
    }
}

extension PoolDetectionContactVC: UITextFieldDelegate {
    @objc func updateTextfieldValue() {
        let cell = self.tblContact.cellForRow(at: IndexPath.init(row: self.selectedRowIndex, section: self.sectionIndex))
        guard let _cell = cell else { return  }
        
        if let dataValueTblCell = _cell as? DataValueTableCell {
            if let textfield = dataValueTblCell.txtData {
                if self.sectionIndex == 0 {
                    if self.selectedRowIndex == Contact.phone.rawValue {
                        let formatted = textfield.text?.toPhoneNumber()
                        self.secPool1[self.selectedRowIndex].formTextValue = formatted!
                        textfield.text = self.secPool1[Contact.phone.rawValue].formTextValue
                    } else {
                        self.secPool1[self.selectedRowIndex].formTextValue = (textfield.text)!
                    }
                } else {
                    self.secPool2[self.selectedRowIndex].formTextValue = (textfield.text)!
                }
            }
        } else if let priceCell = _cell as? PriceValueTableCell {
            if let textfield = priceCell.txtData {
                if self.sectionIndex == 1 {
                    self.secPool2[self.selectedRowIndex].formTextValue = (textfield.text)!
                }
            }
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let cell = (textField.superview?.superview as? UITableViewCell)!
        
        let indexpath = self.tblContact.indexPath(for: cell)
        guard let _indexPath = indexpath else { return false }
        self.selectedRowIndex = _indexPath.row
        self.sectionIndex = _indexPath.section
        
        self.perform(#selector(PoolDetectionContactVC.updateTextfieldValue), with: nil, afterDelay: 1)
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range:NSRange, replacementString string: String) -> Bool {
        let cell = (textField.superview?.superview as? UITableViewCell)!
        
        let indexpath = self.tblContact.indexPath(for: cell)
        guard let _indexPath = indexpath else { return false }
        self.selectedRowIndex = _indexPath.row
        self.sectionIndex = _indexPath.section
        
        self.perform(#selector(PoolDetectionContactVC.updateTextfieldValue), with: nil, afterDelay: 1)
        
        return true
    }
}


extension PoolDetectionContactVC: UITextViewDelegate {
    @objc func updateTextViewValue() {
        let cell = self.tblContact.cellForRow(at: IndexPath.init(row: self.selectedRowIndex, section: self.sectionIndex))
        guard let _cell = cell else { return  }
        
        if let addressTblCell = _cell as? AddressTableCell {
            if let textView = addressTblCell.txtAddress {
                if self.sectionIndex == 0 {
                    self.secPool1[self.selectedRowIndex].formTextValue = (textView.text)!
                } else {
                    self.secPool2[self.selectedRowIndex].formTextValue = (textView.text)!
                }
            }
        }
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        let cell = (textView.superview?.superview as? UITableViewCell)!
        
        let indexpath = self.tblContact.indexPath(for: cell)
        guard let _indexPath = indexpath else { return false }
        self.selectedRowIndex = _indexPath.row
        self.sectionIndex = _indexPath.section
        
        self.perform(#selector(PoolDetectionContactVC.updateTextViewValue), with: nil, afterDelay: 1)
        
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let cell = (textView.superview?.superview as? UITableViewCell)!
        
        let indexpath = self.tblContact.indexPath(for: cell)
        guard let _indexPath = indexpath else { return false }
        self.selectedRowIndex = _indexPath.row
        self.sectionIndex = _indexPath.section
        
        self.perform(#selector(PoolDetectionContactVC.updateTextViewValue), with: nil, afterDelay: 1)
        
        return true
    }
}

extension PoolDetectionContactVC: UITableViewDataSource, UITableViewDelegate
{
    
    //MARK:- UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        } else if section == 1 {
            return 4
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == Contact.address.rawValue {
                let addressCell = tableView.dequeueReusableCell(withIdentifier: "AddressCell", for: indexPath) as! AddressTableCell
                
                addressCell.lblTag.text = "Address"
                addressCell.txtAddress.keyboardType = UIKeyboardType.asciiCapable
                
                if poolDict.count > 0 {
                    self.secPool1[Contact.address.rawValue].formTextValue = String(describing: poolDict["addressPool"]!)
                    addressCell.txtAddress.text = String(describing: poolDict["addressPool"]!)
                } else {
                    addressCell.txtAddress.text = self.secPool1[indexPath.row].formTextValue
                }                //addressCell.txtAddress.tag = indexPath.row
                addressCell.txtAddress.delegate = self
                
                return addressCell
            } else {
                let cellData = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath) as! DataValueTableCell
                
                if indexPath.row == Contact.name.rawValue {
                    cellData.lblTag.text = "Name"
                    cellData.txtData.keyboardType = UIKeyboardType.asciiCapable
                    if poolDict.count > 0 {
                        self.secPool1[Contact.name.rawValue].formTextValue = String(describing: poolDict["namePoolDetection"]!)
                        cellData.txtData.text = String(describing: poolDict["namePoolDetection"]!)
                    } else {
                        cellData.txtData.text = (self.secPool1[indexPath.row].formTextValue)//.capitalizingFirstLetter()
                    }
                    cellData.txtData.withoutImage(direction: .Left, image: UIImage(named: "dollar")!, colorSeparator: UIColor.white, colorBorder: UIColor.white)
                } else if indexPath.row == Contact.city.rawValue {
                    cellData.lblTag.text = "City"
                    cellData.txtData.keyboardType = UIKeyboardType.asciiCapable
                    if poolDict.count > 0 {
                        self.secPool1[Contact.city.rawValue].formTextValue = String(describing: poolDict["cityPool"]!)
                        cellData.txtData.text = String(describing: poolDict["cityPool"]!)
                    } else {
                        cellData.txtData.text = (self.secPool1[indexPath.row].formTextValue)//.capitalizingFirstLetter()
                    }
                    cellData.txtData.withoutImage(direction: .Left, image: UIImage(named: "dollar")!, colorSeparator: UIColor.white, colorBorder: UIColor.white)
                } else if indexPath.row == Contact.state.rawValue {
                    cellData.lblTag.text = "State"
                    cellData.txtData.keyboardType = UIKeyboardType.asciiCapable
                    if poolDict.count > 0 {
                        self.secPool1[Contact.city.rawValue].formTextValue = String(describing: poolDict["statePool"]!)
                        cellData.txtData.text = String(describing: poolDict["statePool"]!)
                    } else {
                        cellData.txtData.text = (self.secPool1[indexPath.row].formTextValue)//.capitalizingFirstLetter()
                    }
                    cellData.txtData.withoutImage(direction: .Left, image: UIImage(named: "dollar")!, colorSeparator: UIColor.white, colorBorder: UIColor.white)
                } else if indexPath.row == Contact.zip.rawValue {
                    cellData.lblTag.text = "Zip"
                    cellData.txtData.keyboardType = UIKeyboardType.numberPad
                    if poolDict.count > 0 {
                        self.secPool1[Contact.zip.rawValue].formTextValue = String(describing: poolDict["zipPool"]!)
                        cellData.txtData.text = String(describing: poolDict["zipPool"]!)
                    } else {
                        cellData.txtData.text = (self.secPool1[indexPath.row].formTextValue)//.capitalizingFirstLetter()
                    }
                    cellData.txtData.withoutImage(direction: .Left, image: UIImage(named: "dollar")!, colorSeparator: UIColor.white, colorBorder: UIColor.white)
                } else if indexPath.row == Contact.phone.rawValue {
                    cellData.lblTag.text = "Phone Number"
                    cellData.txtData.keyboardType = UIKeyboardType.numberPad
                    if poolDict.count > 0 {
                        self.secPool1[Contact.phone.rawValue].formTextValue = String(describing: poolDict["phoneNoPool"]!)
                        cellData.txtData.text = String(describing: poolDict["phoneNoPool"]!)
                    } else {
                        cellData.txtData.text = (self.secPool1[indexPath.row].formTextValue).toPhoneNumber()
                    }
                    cellData.txtData.withoutImage(direction: .Left, image: UIImage(named: "dollar")!, colorSeparator: UIColor.white, colorBorder: UIColor.white)
                } else if indexPath.row == Contact.email.rawValue {
                    cellData.lblTag.text = "Email Address"
                    cellData.txtData.autocapitalizationType = .none
                    cellData.txtData.keyboardType = UIKeyboardType.emailAddress
                    if poolDict.count > 0 {
                        self.secPool1[Contact.email.rawValue].formTextValue = String(describing: poolDict["emailPool"]!)
                        cellData.txtData.text = String(describing: poolDict["emailPool"]!)
                    } else {
                        cellData.txtData.text = (self.secPool1[indexPath.row].formTextValue)//.capitalizingFirstLetter()
                    }
                    cellData.txtData.withoutImage(direction: .Left, image: UIImage(named: "dollar")!, colorSeparator: UIColor.white, colorBorder: UIColor.white)
                } else if indexPath.row == Contact.payment.rawValue {
                    cellData.lblTag.text = "Person responsible for payment"
                    cellData.txtData.autocapitalizationType = .none
                    cellData.txtData.keyboardType = UIKeyboardType.asciiCapable
                    if poolDict.count > 0 {
                        self.secPool1[Contact.payment.rawValue].formTextValue = String(describing: poolDict["paymentPersonInspect"]!)
                        cellData.txtData.text = String(describing: poolDict["paymentPersonInspect"]!)
                    } else {
                        cellData.txtData.text = (self.secPool1[indexPath.row].formTextValue)//.capitalizingFirstLetter()
                    }
                    cellData.txtData.withoutImage(direction: .Left, image: UIImage(named: "dollar")!, colorSeparator: UIColor.white, colorBorder: UIColor.white)
                }
                
                cellData.txtData.isUserInteractionEnabled = true
                //cellData.txtData.tag = indexPath.row
                cellData.txtData.delegate = self
                
                return cellData
            }
        } else if indexPath.section == 1 {
            if indexPath.row == Payment.otherNote.rawValue {
                let cellData = tableView.dequeueReusableCell(withIdentifier: "AddressCell", for: indexPath) as! AddressTableCell
                
                cellData.lblTag.text = "Other Notes"
                cellData.txtAddress.keyboardType = UIKeyboardType.asciiCapable
                
                if poolDict.count > 0 {
                    self.secPool2[Payment.otherNote.rawValue].formTextValue = String(describing: poolDict["otherNotesPool"]!)
                    cellData.txtAddress.text = String(describing: poolDict["otherNotesPool"]!)
                } else {
                    cellData.txtAddress.text = self.secPool2[indexPath.row].formTextValue
                }
                //cellData.txtAddress.tag = indexPath.row
                cellData.txtAddress.delegate = self
                
                return cellData
            } else if indexPath.row == Payment.time.rawValue {
                let cellData = tableView.dequeueReusableCell(withIdentifier: "DateCell", for: indexPath) as! DateValueTableCell
                
                cellData.lblTag.text = "Date of Leak Detection"
                cellData.txtData.isUserInteractionEnabled = false
                
                if poolDict.count > 0 {
                    self.secPool2[Payment.time.rawValue].formTextValue = String(describing: poolDict["inpectTimePool"]!)
                    cellData.txtData.text = String(describing: poolDict["inpectTimePool"]!)
                } else {
                    cellData.txtData.text = self.secPool2[indexPath.row].formTextValue
                }
                cellData.btnDate.addTarget(self, action: #selector(btnDatePickerDidTap), for: UIControl.Event.touchUpInside)
                cellData.txtData.delegate = self
                
                return cellData
            } else if indexPath.row == Payment.price.rawValue {
                let cellData = tableView.dequeueReusableCell(withIdentifier: "PriceCell", for: indexPath) as! PriceValueTableCell
                
                cellData.lblTag.text = "Price for Leak Detection"
                cellData.txtData.keyboardType = UIKeyboardType.numberPad
                cellData.txtData.isUserInteractionEnabled = true
                cellData.txtData.withImage(direction: .Left, image: UIImage(named: "dollar")!, colorSeparator: UIColor.white, colorBorder: UIColor.white)
                
                 if poolDict.count > 0 {
                     self.secPool2[Payment.price.rawValue].formTextValue = String(describing: poolDict["priceForLeakPool"]!)
                     cellData.txtData.text = String(describing: poolDict["priceForLeakPool"]!)
                 } else {
                     cellData.txtData.text = self.secPool2[indexPath.row].formTextValue
                 }
                cellData.txtData.delegate = self
                
                return cellData
            } else {
                let cellData = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath) as! DataValueTableCell
                
                cellData.lblTag.text = "Notes: (Gate Code etc)"
                cellData.txtData.keyboardType = UIKeyboardType.asciiCapable
                
                if poolDict.count > 0 {
                    self.secPool2[Payment.note.rawValue].formTextValue = String(describing: poolDict["notesPool"]!)
                    cellData.txtData.text = String(describing: poolDict["notesPool"]!)
                } else {
                    cellData.txtData.text = self.secPool2[indexPath.row].formTextValue
                }
                cellData.txtData.isUserInteractionEnabled = true
                //cellData.txtData.tag = indexPath.row
                cellData.txtData.delegate = self
                
                return cellData
            }
        } else {
            let cellBtn = tableView.dequeueReusableCell(withIdentifier: "NextCell", for: indexPath) as! NextForm1TableCell
            
            cellBtn.btnNext.addTarget(self, action: #selector(btnNextDidTap), for: UIControl.Event.touchUpInside)
            return cellBtn
        }
    }
    
    //MARK:- UITableViewDelegate
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            // get a reference to our storyboard cell
            let headerView : UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "CustomHeaderCell")!
            
            let lblHeaderTitle = headerView.viewWithTag(10) as! UILabel
            
            lblHeaderTitle.textColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.2352941176, alpha: 1)
            
            lblHeaderTitle.text = "Contact"  // set this however is appropriate for your app's model
            
            return headerView
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .phone {
            if section == 0 {
                return 65
            } else {
                return 0
            }
        } else { //if UIDevice.current.userInterfaceIdiom == .pad {
            if section == 0 {
                return 75
            } else {
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .phone {
            if indexPath.section == 0 {
               if indexPath.row == Contact.address.rawValue {
                   return 165
               } else {
                   return 100
               }
            } else if indexPath.section == 1 {
               if indexPath.row == Payment.otherNote.rawValue {
                   return 165
               } else {
                   return 100
               }
            } else {
                return 95
            }
        } else {        //UIDevice.current.userInterfaceIdiom == .pad
            if indexPath.section == 0 {
               if indexPath.row == Contact.address.rawValue {
                   return 250
               } else {
                   return 165
               }
            } else if indexPath.section == 1 {
                if indexPath.row == Payment.otherNote.rawValue {
                    return 250
                } else {
                    return 165
                }
            } else {
                return 175
            }
        }
    }
}
/*
{

    //MARK:- UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        } else if section == 1 {
            return 4
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == Contact.address.rawValue {
                let addressCell = tableView.dequeueReusableCell(withIdentifier: "AddressCell", for: indexPath) as! AddressTableCell

                addressCell.lblTag.text = "Address"
                addressCell.txtAddress.keyboardType = UIKeyboardType.asciiCapable
                if poolDict.count > 0 {
                    self.secPool1[Contact.address.rawValue].formTextValue = String(describing: poolDict["addressPool"]!)
                    addressCell.txtAddress.text = String(describing: poolDict["addressPool"]!)
                } else {
                    addressCell.txtAddress.text = self.secPool1[indexPath.row].formTextValue
                }
                //addressCell.txtAddress.tag = indexPath.row
                addressCell.txtAddress.delegate = self

                return addressCell
            } else {
                let cellData = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath) as! DataValueTableCell

                if indexPath.row == Contact.name.rawValue {
                    cellData.lblTag.text = "Name"
                    cellData.txtData.keyboardType = UIKeyboardType.asciiCapable
                    if poolDict.count > 0 {
                        self.secPool1[Contact.name.rawValue].formTextValue = String(describing: poolDict["namePoolDetection"]!)
                        cellData.txtData.text = String(describing: poolDict["namePoolDetection"]!)
                    } else {
                        cellData.txtData.text = (self.secPool1[indexPath.row].formTextValue)//.capitalizingFirstLetter()
                    }
                    cellData.txtData.withoutImage(direction: .Left, image: UIImage(named: "dollar")!, colorSeparator: UIColor.white, colorBorder: UIColor.white)
                } else if indexPath.row == Contact.city.rawValue {
                    cellData.lblTag.text = "City"
                    cellData.txtData.keyboardType = UIKeyboardType.asciiCapable
                    if poolDict.count > 0 {
                        self.secPool1[Contact.city.rawValue].formTextValue = String(describing: poolDict["cityPool"]!)
                        cellData.txtData.text = String(describing: poolDict["cityPool"]!)
                    } else {
                        cellData.txtData.text = (self.secPool1[indexPath.row].formTextValue)//.capitalizingFirstLetter()
                    }
                    cellData.txtData.withoutImage(direction: .Left, image: UIImage(named: "dollar")!, colorSeparator: UIColor.white, colorBorder: UIColor.white)
                } else if indexPath.row == Contact.state.rawValue {
                    cellData.lblTag.text = "State"
                    cellData.txtData.keyboardType = UIKeyboardType.asciiCapable
                    if poolDict.count > 0 {
                        self.secPool1[Contact.state.rawValue].formTextValue = String(describing: poolDict["statePool"]!)
                        cellData.txtData.text = String(describing: poolDict["statePool"]!)
                    } else {
                        cellData.txtData.text = (self.secPool1[indexPath.row].formTextValue)//.capitalizingFirstLetter()
                    }
                    cellData.txtData.withoutImage(direction: .Left, image: UIImage(named: "dollar")!, colorSeparator: UIColor.white, colorBorder: UIColor.white)
                } else if indexPath.row == Contact.zip.rawValue {
                    cellData.lblTag.text = "Zip"
                    cellData.txtData.keyboardType = UIKeyboardType.numberPad
                    if poolDict.count > 0 {
                        self.secPool1[Contact.zip.rawValue].formTextValue = String(describing: poolDict["zipPool"]!)
                        cellData.txtData.text = String(describing: poolDict["zipPool"]!)
                    } else {
                        cellData.txtData.text = (self.secPool1[indexPath.row].formTextValue)//.capitalizingFirstLetter()
                    }
                    cellData.txtData.withoutImage(direction: .Left, image: UIImage(named: "dollar")!, colorSeparator: UIColor.white, colorBorder: UIColor.white)
                } else if indexPath.row == Contact.phone.rawValue {
                    cellData.lblTag.text = "Phone Number"
                    cellData.txtData.keyboardType = UIKeyboardType.numberPad
                    if poolDict.count > 0 {
                        self.secPool1[Contact.phone.rawValue].formTextValue = String(describing: poolDict["phoneNoPool"]!)
                        cellData.txtData.text = String(describing: poolDict["phoneNoPool"]!)
                    } else {
                        cellData.txtData.text = (self.secPool1[indexPath.row].formTextValue).toPhoneNumber()
                    }
                    cellData.txtData.withoutImage(direction: .Left, image: UIImage(named: "dollar")!, colorSeparator: UIColor.white, colorBorder: UIColor.white)
                } else if indexPath.row == Contact.email.rawValue {
                    cellData.lblTag.text = "Email Address"
                    cellData.txtData.autocapitalizationType = .none
                    cellData.txtData.keyboardType = UIKeyboardType.emailAddress
                    if poolDict.count > 0 {
                        self.secPool1[Contact.email.rawValue].formTextValue = String(describing: poolDict["emailPool"]!)
                        cellData.txtData.text = String(describing: poolDict["emailPool"]!)
                    } else {
                        cellData.txtData.text = (self.secPool1[indexPath.row].formTextValue)//.capitalizingFirstLetter()
                    }
                    cellData.txtData.withoutImage(direction: .Left, image: UIImage(named: "dollar")!, colorSeparator: UIColor.white, colorBorder: UIColor.white)
                } else if indexPath.row == Contact.payment.rawValue {
                    cellData.lblTag.text = "Person responsible for payment"
                    cellData.txtData.autocapitalizationType = .none
                    cellData.txtData.keyboardType = UIKeyboardType.asciiCapable
                    if poolDict.count > 0 {
                        self.secPool1[Contact.payment.rawValue].formTextValue = String(describing: poolDict["paymentPersonInspect"]!)
                        cellData.txtData.text = String(describing: poolDict["paymentPersonInspect"]!)
                    } else {
                        cellData.txtData.text = (self.secPool1[indexPath.row].formTextValue)//.capitalizingFirstLetter()
                    }
                    cellData.txtData.withoutImage(direction: .Left, image: UIImage(named: "dollar")!, colorSeparator: UIColor.white, colorBorder: UIColor.white)
                }

                cellData.txtData.isUserInteractionEnabled = true
                //cellData.txtData.tag = indexPath.row
                cellData.txtData.delegate = self

                return cellData
            }
        } else if indexPath.section == 1 {
            if indexPath.row == Payment.otherNote.rawValue {
                let cellData = tableView.dequeueReusableCell(withIdentifier: "AddressCell", for: indexPath) as! AddressTableCell

                cellData.lblTag.text = "Other Notes"
                cellData.txtAddress.keyboardType = UIKeyboardType.asciiCapable
                if poolDict.count > 0 {
                    self.secPool2[Payment.otherNote.rawValue].formTextValue = String(describing: poolDict["otherNotesPool"]!)
                    cellData.txtAddress.text = String(describing: poolDict["otherNotesPool"]!)
                } else {
                    cellData.txtAddress.text = self.secPool2[indexPath.row].formTextValue
                }
                //cellData.txtAddress.tag = indexPath.row
                cellData.txtAddress.delegate = self

                return cellData
            } else if indexPath.row == Payment.time.rawValue {
                let cellData = tableView.dequeueReusableCell(withIdentifier: "DateCell", for: indexPath) as! DateValueTableCell

                cellData.lblTag.text = "Date of Leak Detection"
                cellData.txtData.isUserInteractionEnabled = false
                if poolDict.count > 0 {
                    self.secPool2[Payment.time.rawValue].formTextValue = String(describing: poolDict["inpectTimePool"]!)
                    cellData.txtData.text = String(describing: poolDict["inpectTimePool"]!)
                } else {
                    cellData.txtData.text = self.secPool2[indexPath.row].formTextValue
                }

                cellData.btnDate.addTarget(self, action: #selector(btnDatePickerDidTap), for: UIControl.Event.touchUpInside)
                cellData.txtData.delegate = self

                return cellData
            } else if indexPath.row == Payment.price.rawValue {
                let cellData = tableView.dequeueReusableCell(withIdentifier: "PriceCell", for: indexPath) as! PriceValueTableCell

                cellData.lblTag.text = "Price for Leak Detection"
                cellData.txtData.keyboardType = UIKeyboardType.numberPad
                 cellData.txtData.isUserInteractionEnabled = true
                cellData.txtData.withImage(direction: .Left, image: UIImage(named: "dollar")!, colorSeparator: UIColor.white, colorBorder: UIColor.white)

                if poolDict.count > 0 {
                    self.secPool2[Payment.price.rawValue].formTextValue = String(describing: poolDict["priceForLeakPool"]!)
                    cellData.txtData.text = String(describing: poolDict["priceForLeakPool"]!)
                } else {
                    cellData.txtData.text = self.secPool2[indexPath.row].formTextValue
                }
                cellData.txtData.delegate = self
                return cellData
            } else {
                let cellData = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath) as! DataValueTableCell

                cellData.lblTag.text = "Notes: (Gate Code etc)"
                cellData.txtData.keyboardType = UIKeyboardType.asciiCapable

                if poolDict.count > 0 {
                    self.secPool2[Payment.note.rawValue].formTextValue = String(describing: poolDict["notesPool"]!)
                    cellData.txtData.text = String(describing: poolDict["notesPool"]!)
                } else {
                    cellData.txtData.text = self.secPool2[indexPath.row].formTextValue
                }
                cellData.txtData.isUserInteractionEnabled = true
                //cellData.txtData.tag = indexPath.row
                cellData.txtData.delegate = self

                return cellData
            }
        } else {
            let cellBtn = tableView.dequeueReusableCell(withIdentifier: "NextCell", for: indexPath) as! NextForm1TableCell

            cellBtn.btnNext.addTarget(self, action: #selector(btnNextDidTap), for: UIControl.Event.touchUpInside)
            return cellBtn
        }
    }

    //MARK:- UITableViewDelegate
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            // get a reference to our storyboard cell
            let headerView : UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "CustomHeaderCell")!

            let lblHeaderTitle = headerView.viewWithTag(10) as! UILabel

            lblHeaderTitle.textColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.2352941176, alpha: 1)

            lblHeaderTitle.text = "Contact"  // set this however is appropriate for your app's model

            return headerView
        } else if section == 1 {
            // get a reference to our storyboard cell
            let headerView : UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "SpaceCell")!

            let lblHeaderTitle = headerView.viewWithTag(20) as! UILabel

            lblHeaderTitle.text = "Person responsible for payment"

            return headerView
        } else {
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .phone {
            if section == 0 {
                return 65
            } else if section == 1 {
                return 45
            } else {
                return 0
            }
        } else { //if UIDevice.current.userInterfaceIdiom == .pad {
            if section == 0 {
                return 75
            } else if section == 1 {
                return 65
            } else {
                return 0
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .phone {
            if indexPath.section == 0 {
               if indexPath.row == Contact.address.rawValue {
                   return 165
               } else {
                   return 100
               }
            } else if indexPath.section == 1 {
               if indexPath.row == Payment.otherNote.rawValue {
                   return 165
               } else {
                   return 100
               }
            } else {
                return 95
            }
        } else {        //UIDevice.current.userInterfaceIdiom == .pad
            if indexPath.section == 0 {
               if indexPath.row == Contact.address.rawValue {
                   return 250
               } else {
                   return 165
               }
            } else if indexPath.section == 1 {
                if indexPath.row == Payment.otherNote.rawValue {
                    return 250
                } else {
                    return 165
                }
            } else {
                return 175
            }
        }
    }
}
*/


class formData {
    var formTextValue = ""
    var formOption = 0
}
