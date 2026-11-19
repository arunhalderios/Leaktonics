//
//  PlumberContactFormVC.swift
//  Leaktronics
//
//  Created by Abhishek Mullick on 07/04/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import CoreData
import SVProgressHUD


class PlumberContactFormVC: UIViewController {
    
    @IBOutlet weak var tblPlumberContact: UITableView!
    var strReport_id = String()
    var plumberDetailsDict = [String : AnyObject]()
    var plumberDict = [String : AnyObject]()
    
    @IBOutlet weak var vwDatePicker: UIView!

    let toolbar = UIToolbar();
    let datePicker = UIDatePicker()
    
    var secPlumber1 = [formPlumberContactData]()
    var secPlumber2 = [formPlumberContactData]()
    
    
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
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.prepareFormPlumberContactData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = UIColor.black
        self.navigationController?.title = "Plumber Leak Detection Report"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        if strReport_id == "" {
            
        } else {
            self.postReportDetailsEdit()
        }
    }
    
    func prepareFormPlumberContactData() {
        for _ in 0..<8 {
            let obj = formPlumberContactData()
            self.secPlumber1.append(obj)
        }
        
        for _ in 0..<4 {
            let obj = formPlumberContactData()
            self.secPlumber2.append(obj)
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
    
    //MARK:- objc Function
    @objc func btnDatePickerDidTap() {
        DatePickerDialog().show("DatePicker", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .dateAndTime) {
            (date) -> Void in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "MM/dd/YYYY HH:mm"
                print(dt)
                //textField.text = formatter.string(from: dt)
                self.secPlumber2[3].formTextValue = formatter.string(from: dt)//(textfield.text)!
                self.tblPlumberContact.reloadData()
            }
        }
    }
    @objc func btnNextDidTap() {
        if self.secPlumber1[Contact.name.rawValue].formTextValue == "" {
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
            //self.postPlumberLeakContactDetails()
            
            if strReport_id == "" {
                self.saveIntoCoreData()
                self.postPlumberLeakContactDetails()
            } else {
                self.updateCoreData(strReport_id: strReport_id)
                self.postPlumberLeakContactDetailsUpdate()
            }
            /*if UIDevice.current.userInterfaceIdiom == .phone {
                let storyBoard : UIStoryboard = UIStoryboard(name: "PlumberLeak", bundle:nil)
                let plumberContactVC = storyBoard.instantiateViewController(withIdentifier: "PlumberPhoneQuestion") as! PlumberPhoneQuestionVC
                self.navigationController?.pushViewController(plumberContactVC, animated: true)
            } else if UIDevice.current.userInterfaceIdiom == .pad {
                let storyBoard : UIStoryboard = UIStoryboard(name: "PlumberLeak_iPad", bundle:nil)
                let plumberContactVC = storyBoard.instantiateViewController(withIdentifier: "PlumberPhoneQuestion") as! PlumberPhoneQuestionVC
                self.navigationController?.pushViewController(plumberContactVC, animated: true)
            }*/
        }
    }
    
    //MARK:- CoreData
    func saveIntoCoreData() {
        UserDefaults.standard.removeObject(forKey: "PlumberLeakUserName")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "PlumberLeak_CoreData", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        
        //let strPh = Int16(self.secPlumber1[Contact.phone.rawValue].formTextValue)
        //let strZip = Int16(self.secPlumber1[Contact.zip.rawValue].formTextValue)
        
        newUser.setValue(self.secPlumber1[Contact.name.rawValue].formTextValue, forKey: "namePlumberLeak")
        newUser.setValue(self.secPlumber1[Contact.address.rawValue].formTextValue, forKey: "addressPlumber")
        newUser.setValue(self.secPlumber1[Contact.city.rawValue].formTextValue, forKey: "cityPlumber")
        newUser.setValue(self.secPlumber1[Contact.state.rawValue].formTextValue, forKey: "statePlumber")
        newUser.setValue(self.secPlumber1[Contact.zip.rawValue].formTextValue, forKey: "zipPlumber")
        newUser.setValue(self.secPlumber1[Contact.phone.rawValue].formTextValue, forKey: "phoneNoPlumber")
        newUser.setValue(self.secPlumber1[Contact.email.rawValue].formTextValue, forKey: "emailPlumber")
        newUser.setValue(self.secPlumber2[Payment.note.rawValue].formTextValue, forKey: "notesPlumber")
        newUser.setValue(self.secPlumber2[Payment.otherNote.rawValue].formTextValue, forKey: "otherNotesPlumber")
        newUser.setValue(self.secPlumber2[Payment.price.rawValue].formTextValue, forKey: "priceForLeakPlumber")
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "MM/dd/YYYY HH:mm"
        let formattedDate = format.string(from: date)
        print(formattedDate)
        
        newUser.setValue(self.secPlumber2[Payment.time.rawValue].formTextValue, forKey:"plumber_inspection_date_time")
        
        do {
            try context.save()
            UserDefaults.standard.set(self.secPlumber1[Contact.name.rawValue].formTextValue, forKey: "PlumberLeakUserName")
        } catch {
            print("Failed saving")
        }
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PlumberLeak_CoreData")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false

        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let userName: String = UserDefaults.standard.value(forKey: "PlumberLeakUserName") as! String
                if (data.value(forKey: "namePlumberLeak") as! String) == userName {
                    print("Data of PlumberContact:: \(data)")
                    print(data.value(forKey: "namePlumberLeak") as! String)
                }
            }
        } catch {
            
            print("Failed")
        }
    }
    
    func updateCoreData(strReport_id: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        //For data fetch in coredata
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Plumber1_CoreData")
        fetchRequest.returnsObjectsAsFaults = false
        
        let predicate = NSPredicate(format: "%K == %@", "report_id", strReport_id)
        fetchRequest.predicate = predicate
        
        do {
            let reportResult = try managedContext.fetch(fetchRequest) as! [Plumber1_CoreData]
            print("Report Data\(reportResult) and count is \(reportResult.count)")
            
            if reportResult.count == 0 {
                print ("Inserting DB")
                
                let entity = NSEntityDescription.entity(forEntityName: "Plumber1_CoreData", in: managedContext)
                let newUser = NSManagedObject(entity: entity!, insertInto: managedContext)
                
                newUser.setValue(self.plumberDict["report_id"], forKey: "report_id")
                newUser.setValue(self.plumberDict["namePlumberLeak"], forKey: "namePlumberLeak")
                newUser.setValue(self.plumberDict["addressPlumber"], forKey: "addressPlumber")
                newUser.setValue(self.plumberDict["cityPlumber"], forKey: "cityPlumber")
                newUser.setValue(self.plumberDict["statePlumber"], forKey: "statePlumber")
                newUser.setValue(self.plumberDict["zipPlumber"], forKey: "zipPlumber")
                newUser.setValue(self.plumberDict["phoneNoPlumber"], forKey: "phoneNoPlumber")
                newUser.setValue(self.plumberDict["emailPlumber"], forKey: "emailPlumber")
                newUser.setValue(self.plumberDict["notesPlumber"], forKey: "notesPlumber")
                newUser.setValue(self.plumberDict["otherNotesPlumber"], forKey: "otherNotesPlumber")
                newUser.setValue(self.plumberDict["priceForLeakPlumber"], forKey: "priceForLeakPlumber")
                newUser.setValue(self.plumberDict["inpectTimePool"], forKey:"plumber_inspection_date_time")
                
                do {
                    try managedContext.save()
                    UserDefaults.standard.set(self.plumberDict["namePlumberLeak"], forKey: "PlumberLeakUserName")
                    print("Inserted")
                } catch let error as NSError {
                    print(error)
                }
            } else {
                print ("Updating DB")
                //For data fetch in coredata
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Plumber1_CoreData")
                fetchRequest.returnsObjectsAsFaults = false
                
                let predicate = NSPredicate(format: "%K == %@", "report_id", strReport_id)
                fetchRequest.predicate = predicate
                
                let  rs = try managedContext.fetch(fetchRequest)
                for _ in rs as [NSManagedObject] {
                    // update
                    do {
                        let managedObject = rs[0]

                        managedObject.setValue(strReport_id, forKey: "report_id")
                        managedObject.setValue(self.secPlumber1[Contact.name.rawValue].formTextValue, forKey: "namePlumberLeak")
                        managedObject.setValue(self.secPlumber1[Contact.address.rawValue].formTextValue, forKey: "addressPlumber")
                        managedObject.setValue(self.secPlumber1[Contact.city.rawValue].formTextValue, forKey: "cityPlumber")
                        managedObject.setValue(self.secPlumber1[Contact.state.rawValue].formTextValue, forKey: "statePlumber")
                        managedObject.setValue(self.secPlumber1[Contact.zip.rawValue].formTextValue, forKey: "zipPlumber")
                        managedObject.setValue(self.secPlumber1[Contact.phone.rawValue].formTextValue, forKey: "phoneNoPlumber")
                        managedObject.setValue(self.secPlumber1[Contact.email.rawValue].formTextValue, forKey: "emailPlumber")
                        managedObject.setValue(self.secPlumber2[Payment.note.rawValue].formTextValue, forKey: "notesPlumber")
                        managedObject.setValue(self.secPlumber2[Payment.otherNote.rawValue].formTextValue, forKey: "otherNotesPlumber")
                        managedObject.setValue(self.secPlumber2[Payment.price.rawValue].formTextValue, forKey: "priceForLeakPlumber")
                        managedObject.setValue(self.secPlumber2[Payment.time.rawValue].formTextValue, forKey:"plumber_inspection_date_time")
                        
                        try managedContext.save()
                        UserDefaults.standard.set(self.secPlumber1[Contact.name.rawValue].formTextValue, forKey: "PlumberLeakUserName")
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
            "type"        : "Plumbing Leak Detection"
        ]
        
        print("editDetails :: \(editDetails)")
        //if sharedExtension.connectedToNetwork() {
        ApiManager.sharedInstanceAPI.PostReportDetailsEdit(postId: 1, reportDetailsEdit: editDetails, onSuccess: { json in
            DispatchQueue.main.async {
                print("PoolDetectionDetailsEdit json :: \(String(describing: json))")
                //let poolDetectDict = (json["data"] as AnyObject) as! [String : AnyObject]
                
                self.plumberDetailsDict = (json["data"] as AnyObject) as! [String : AnyObject]
                self.plumberDict = self.plumberDetailsDict["page_1"] as! [String : AnyObject]
                
                self.updateCoreData(strReport_id: self.strReport_id)
                self.tblPlumberContact.reloadData()
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
    
    func postPlumberLeakContactDetails() {
        self.view.endEditing(true)
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        
        let contactDetails: NSMutableDictionary = [
            "device_id"             : (UIDevice.current.identifierForVendor?.uuidString)!,
            "namePoolDetection"     : self.secPlumber1[Contact.name.rawValue].formTextValue,
            "addressPool"           : self.secPlumber1[Contact.address.rawValue].formTextValue,
            "cityPool"              : self.secPlumber1[Contact.city.rawValue].formTextValue,
            "statePool"             : self.secPlumber1[Contact.state.rawValue].formTextValue,
            "zipPool"               : self.secPlumber1[Contact.zip.rawValue].formTextValue,
            "phoneNoPool"           : self.secPlumber1[Contact.phone.rawValue].formTextValue,
            "emailPool"             : self.secPlumber1[Contact.email.rawValue].formTextValue,
            "paymentPersonInspect"  : self.secPlumber1[Contact.payment.rawValue].formTextValue,
            "notesPool"             : self.secPlumber2[Payment.note.rawValue].formTextValue,
            "otherNotesPool"        : self.secPlumber2[Payment.otherNote.rawValue].formTextValue,
            "priceForLeakPool"      : self.secPlumber2[Payment.price.rawValue].formTextValue,
            "inpectTimePool"        : self.secPlumber2[Payment.time.rawValue].formTextValue,//"2020-04-24 10:05:06",
            "inspection_date_time"  : self.secPlumber2[Payment.time.rawValue].formTextValue//"2020-04-24 10:05:06"
        ]
        
        print("contactDetails :: \(contactDetails)")
        //if sharedExtension.connectedToNetwork() {
        ApiManager.sharedInstanceAPI.PostPlumberLeakContactDetails(postId: 1, contactDetails: contactDetails, onSuccess: { json in
            DispatchQueue.main.async {
                print("PlumberLeakContactDetails json :: \(String(describing: json))")
                //let poolDetectDict = (json["data"] as AnyObject) as! [String : AnyObject]
                
                let plumberLeakDict = (json["data"] as AnyObject) as! [String : AnyObject]
                
                if String(describing: json["status"]!) == "1" {
                    //store dic data
                    self.strReport_id = String(describing: plumberLeakDict["return_data_id"]!)
                    
                    DispatchQueue.main.async(execute: {() -> Void in
                        if UIDevice.current.userInterfaceIdiom == .phone {
                            let storyBoard : UIStoryboard = UIStoryboard(name: "PlumberLeak", bundle:nil)
                            let formVC = storyBoard.instantiateViewController(withIdentifier: "PlumberPhoneQuestion") as! PlumberPhoneQuestionVC
                            formVC.strReport_id = self.strReport_id
                            self.navigationController?.pushViewController(formVC, animated: true)
                        } else if UIDevice.current.userInterfaceIdiom == .pad {
                            let storyBoard : UIStoryboard = UIStoryboard(name: "PlumberLeak_iPad", bundle:nil)
                            let formVC = storyBoard.instantiateViewController(withIdentifier: "PlumberPhoneQuestion") as! PlumberPhoneQuestionVC
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
    
    func postPlumberLeakContactDetailsUpdate() {
        self.view.endEditing(true)
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        
        let contactDetails: NSMutableDictionary = [
            "device_id"             : (UIDevice.current.identifierForVendor?.uuidString)!,
            "report_id"             : strReport_id,
            "namePoolDetection"     : self.secPlumber1[Contact.name.rawValue].formTextValue,
            "addressPool"           : self.secPlumber1[Contact.address.rawValue].formTextValue,
            "cityPool"              : self.secPlumber1[Contact.city.rawValue].formTextValue,
            "statePool"             : self.secPlumber1[Contact.state.rawValue].formTextValue,
            "zipPool"               : self.secPlumber1[Contact.zip.rawValue].formTextValue,
            "phoneNoPool"           : self.secPlumber1[Contact.phone.rawValue].formTextValue,
            "emailPool"             : self.secPlumber1[Contact.email.rawValue].formTextValue,
            "paymentPersonInspect"  : self.secPlumber1[Contact.payment.rawValue].formTextValue,
            "notesPool"             : self.secPlumber2[Payment.note.rawValue].formTextValue,
            "otherNotesPool"        : self.secPlumber2[Payment.otherNote.rawValue].formTextValue,
            "priceForLeakPool"      : self.secPlumber2[Payment.price.rawValue].formTextValue,
            "inpectTimePool"        : self.secPlumber2[Payment.time.rawValue].formTextValue,//"2020-04-24 10:05:06",
            "inspection_date_time"  : self.secPlumber2[Payment.time.rawValue].formTextValue//"2020-04-24 10:05:06"
        ]
        
        print("contactDetails :: \(contactDetails)")
        //if sharedExtension.connectedToNetwork() {
        ApiManager.sharedInstanceAPI.PostPoolDetectionContactDetailsUpdate(postId: 1, contactDetails: contactDetails, onSuccess: { json in
            DispatchQueue.main.async {
                print("PoolDetectionContactDetails json :: \(String(describing: json))")
                //let poolDetectDict = (json["data"] as AnyObject) as! [String : AnyObject]
                
                let plumberLeakDict = (json["data"] as AnyObject) as! [String : AnyObject]
                
                if String(describing: json["status"]!) == "1" {
                    //store dic data
                    self.strReport_id = String(describing: plumberLeakDict["return_data_id"]!)
                    
                    DispatchQueue.main.async(execute: {() -> Void in
                        if UIDevice.current.userInterfaceIdiom == .phone {
                            let storyBoard : UIStoryboard = UIStoryboard(name: "PlumberLeak", bundle:nil)
                            let formVC = storyBoard.instantiateViewController(withIdentifier: "PlumberPhoneQuestion") as! PlumberPhoneQuestionVC
                            formVC.strReport_id = self.strReport_id
                            self.navigationController?.pushViewController(formVC, animated: true)
                        } else if UIDevice.current.userInterfaceIdiom == .pad {
                            let storyBoard : UIStoryboard = UIStoryboard(name: "PlumberLeak_iPad", bundle:nil)
                            let formVC = storyBoard.instantiateViewController(withIdentifier: "PlumberPhoneQuestion") as! PlumberPhoneQuestionVC
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
                //self.present(alert, animated: true, completion: nil)
            })
        })
    }
}

extension String {

    /// Handles 10 or 11 digit phone numbers
    ///
    /// - Returns: formatted phone number or original value
    public func toPhoneNumber() -> String {
        let digits = self.digitsOnly
        if digits.count == 10 {
            return digits.replacingOccurrences(of: "(\\d{3})(\\d{3})(\\d+)", with: "($1) $2-$3", options: .regularExpression, range: nil)
        }
        else if digits.count == 11 {
            return digits.replacingOccurrences(of: "(\\d{1})(\\d{3})(\\d{3})(\\d+)", with: "$1($2) $3-$4", options: .regularExpression, range: nil)
        }
        else {
            return self
        }
    }

}

extension StringProtocol {

    /// Returns the string with only [0-9], all other characters are filtered out
    var digitsOnly: String {
        return String(filter(("0"..."9").contains))
    }

}

extension PlumberContactFormVC: UITextFieldDelegate {
    
    @objc func updateTextfieldValue() {
        let cell = self.tblPlumberContact.cellForRow(at: IndexPath.init(row: self.selectedRowIndex, section: self.sectionIndex))
        guard let _cell = cell else { return  }
        
        if let dataValueTblCell = _cell as? DataValueTableCell {
            if let textfield = dataValueTblCell.txtData {
                if self.sectionIndex == 0 {
                    if self.selectedRowIndex == Contact.phone.rawValue {
                        let formatted = textfield.text?.toPhoneNumber()
                        self.secPlumber1[self.selectedRowIndex].formTextValue = formatted!
                        textfield.text = self.secPlumber1[Contact.phone.rawValue].formTextValue
                    } else {
                        self.secPlumber1[self.selectedRowIndex].formTextValue = (textfield.text)!
                    }
                } else {
                    self.secPlumber2[self.selectedRowIndex].formTextValue = (textfield.text)!
                }
            }
        } else if let priceCell = _cell as? PriceValueTableCell {
            if let textfield = priceCell.txtData {
                if self.sectionIndex == 1 {
                    self.secPlumber2[self.selectedRowIndex].formTextValue = (textfield.text)!
                }
            }
        }
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let cell = (textField.superview?.superview as? UITableViewCell)!
        
        let indexpath = self.tblPlumberContact.indexPath(for: cell)
        guard let _indexPath = indexpath else { return false }
        self.selectedRowIndex = _indexPath.row
        self.sectionIndex = _indexPath.section
        
        self.perform(#selector(PlumberContactFormVC.updateTextfieldValue), with: nil, afterDelay: 1)
        
        return true
    }

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range:NSRange, replacementString string: String) -> Bool {
        let cell = (textField.superview?.superview as? UITableViewCell)!
        
        let indexpath = self.tblPlumberContact.indexPath(for: cell)
        guard let _indexPath = indexpath else { return false }
        self.selectedRowIndex = _indexPath.row
        self.sectionIndex = _indexPath.section
        

        self.perform(#selector(PlumberContactFormVC.updateTextfieldValue), with: nil, afterDelay: 1)
        
        return true
    }
    
}

extension PlumberContactFormVC: UITextViewDelegate {
    @objc func updatePlumberTextViewValue() {
        let cell = self.tblPlumberContact.cellForRow(at: IndexPath.init(row: self.selectedRowIndex, section: self.sectionIndex))
        guard let _cell = cell else { return  }
        
        if let addressTblCell = _cell as? AddressTableCell {
            if let textView = addressTblCell.txtAddress {
                if self.sectionIndex == 0 {
                    self.secPlumber1[self.selectedRowIndex].formTextValue = (textView.text)!
                } else {
                    self.secPlumber2[self.selectedRowIndex].formTextValue = (textView.text)!
                }
            }
        }
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        let cell = (textView.superview?.superview as? UITableViewCell)!
        
        let indexpath = self.tblPlumberContact.indexPath(for: cell)
        guard let _indexPath = indexpath else { return false }
        self.selectedRowIndex = _indexPath.row
        self.sectionIndex = _indexPath.section
        
        self.perform(#selector(PlumberContactFormVC.updatePlumberTextViewValue), with: nil, afterDelay: 1)
        
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let cell = (textView.superview?.superview as? UITableViewCell)!
        
        let indexpath = self.tblPlumberContact.indexPath(for: cell)
        guard let _indexPath = indexpath else { return false }
        self.selectedRowIndex = _indexPath.row
        self.sectionIndex = _indexPath.section
        
        self.perform(#selector(PlumberContactFormVC.updatePlumberTextViewValue), with: nil, afterDelay: 1)
        
        return true
    }
    
}

extension PlumberContactFormVC: UITableViewDataSource, UITableViewDelegate {
    //MARK:- UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 7
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
                if plumberDict.count > 0 {
                    self.secPlumber1[Contact.address.rawValue].formTextValue = String(describing: plumberDict["addressPool"]!)
                    addressCell.txtAddress.text = String(describing: plumberDict["addressPool"]!)
                } else {
                    addressCell.txtAddress.text = self.secPlumber1[indexPath.row].formTextValue
                }
                //addressCell.txtAddress.tag = indexPath.row
                addressCell.txtAddress.delegate = self
                
                return addressCell
            } else {
                let cellData = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath) as! DataValueTableCell
                
                if indexPath.row == Contact.name.rawValue {
                    cellData.lblTag.text = "Name"
                    cellData.txtData.keyboardType = UIKeyboardType.asciiCapable
                    if plumberDict.count > 0 {
                        self.secPlumber1[Contact.name.rawValue].formTextValue = String(describing: plumberDict["namePoolDetection"]!)
                        cellData.txtData.text = String(describing: plumberDict["namePoolDetection"]!)
                    } else {
                        cellData.txtData.text = (self.secPlumber1[indexPath.row].formTextValue)//.capitalizingFirstLetter()
                    }
                    cellData.txtData.withoutImage(direction: .Left, image: UIImage(named: "dollar")!, colorSeparator: UIColor.white, colorBorder: UIColor.white)
                } else if indexPath.row == Contact.city.rawValue {
                    cellData.lblTag.text = "City"
                    cellData.txtData.keyboardType = UIKeyboardType.asciiCapable
                    if plumberDict.count > 0 {
                        self.secPlumber1[Contact.city.rawValue].formTextValue = String(describing: plumberDict["cityPool"]!)
                        cellData.txtData.text = String(describing: plumberDict["cityPool"]!)
                    } else {
                        cellData.txtData.text = (self.secPlumber1[indexPath.row].formTextValue)//.capitalizingFirstLetter()
                    }
                    cellData.txtData.withoutImage(direction: .Left, image: UIImage(named: "dollar")!, colorSeparator: UIColor.white, colorBorder: UIColor.white)
                } else if indexPath.row == Contact.state.rawValue {
                    cellData.lblTag.text = "State"
                    cellData.txtData.keyboardType = UIKeyboardType.asciiCapable
                    if plumberDict.count > 0 {
                        self.secPlumber1[Contact.state.rawValue].formTextValue = String(describing: plumberDict["statePool"]!)
                        cellData.txtData.text = String(describing: plumberDict["statePool"]!)
                    } else {
                        cellData.txtData.text = (self.secPlumber1[indexPath.row].formTextValue)//.capitalizingFirstLetter()
                    }
                    cellData.txtData.withoutImage(direction: .Left, image: UIImage(named: "dollar")!, colorSeparator: UIColor.white, colorBorder: UIColor.white)
                } else if indexPath.row == Contact.zip.rawValue {
                    cellData.lblTag.text = "Zip"
                    cellData.txtData.keyboardType = UIKeyboardType.numberPad
                    if plumberDict.count > 0 {
                        self.secPlumber1[Contact.zip.rawValue].formTextValue = String(describing: plumberDict["zipPool"]!)
                        cellData.txtData.text = String(describing: plumberDict["zipPool"]!)
                    } else {
                        cellData.txtData.text = (self.secPlumber1[indexPath.row].formTextValue)//.capitalizingFirstLetter()
                    }
                    cellData.txtData.withoutImage(direction: .Left, image: UIImage(named: "dollar")!, colorSeparator: UIColor.white, colorBorder: UIColor.white)
                } else if indexPath.row == Contact.phone.rawValue {
                    cellData.lblTag.text = "Phone Number"
                    cellData.txtData.keyboardType = UIKeyboardType.numberPad
                    if plumberDict.count > 0 {
                        self.secPlumber1[Contact.phone.rawValue].formTextValue = String(describing: plumberDict["phoneNoPool"]!)
                        cellData.txtData.text = String(describing: plumberDict["phoneNoPool"]!)
                    } else {
                        cellData.txtData.text = (self.secPlumber1[indexPath.row].formTextValue).toPhoneNumber()
                    }
                    cellData.txtData.withoutImage(direction: .Left, image: UIImage(named: "dollar")!, colorSeparator: UIColor.white, colorBorder: UIColor.white)
                } else if indexPath.row == Contact.email.rawValue {
                    cellData.lblTag.text = "Email Address"
                    cellData.txtData.autocapitalizationType = .none
                    cellData.txtData.keyboardType = UIKeyboardType.emailAddress
                    if plumberDict.count > 0 {
                        self.secPlumber1[Contact.email.rawValue].formTextValue = String(describing: plumberDict["emailPool"]!)
                        cellData.txtData.text = String(describing: plumberDict["emailPool"]!)
                    } else {
                        cellData.txtData.text = (self.secPlumber1[indexPath.row].formTextValue)//.capitalizingFirstLetter()
                    }
                    cellData.txtData.withoutImage(direction: .Left, image: UIImage(named: "dollar")!, colorSeparator: UIColor.white, colorBorder: UIColor.white)
                } else if indexPath.row == Contact.payment.rawValue {
                    cellData.lblTag.text = "Person responsible for payment"
                    cellData.txtData.autocapitalizationType = .none
                    cellData.txtData.keyboardType = UIKeyboardType.asciiCapable
                    if plumberDict.count > 0 {
                        self.secPlumber1[Contact.payment.rawValue].formTextValue = String(describing: plumberDict["paymentPersonInspect"]!)
                        //cellData.txtData.text = String(describing: poolDict["paymentPersonInspect"]!)
                    } else {
                        cellData.txtData.text = (self.secPlumber1[indexPath.row].formTextValue)//.capitalizingFirstLetter()
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
                if plumberDict.count > 0 {
                    self.secPlumber2[Payment.otherNote.rawValue].formTextValue = String(describing: plumberDict["otherNotesPool"]!)
                    cellData.txtAddress.text = String(describing: plumberDict["otherNotesPool"]!)
                } else {
                    cellData.txtAddress.text = self.secPlumber2[indexPath.row].formTextValue
                }
                //cellData.txtAddress.tag = indexPath.row
                cellData.txtAddress.delegate = self
                
                return cellData
            } else if indexPath.row == Payment.time.rawValue {
                let cellData = tableView.dequeueReusableCell(withIdentifier: "DateCell", for: indexPath) as! DateValueTableCell
                
                cellData.lblTag.text = "Date of Leak Detection"
                cellData.txtData.isUserInteractionEnabled = false
                if plumberDict.count > 0 {
                    self.secPlumber2[Payment.time.rawValue].formTextValue = String(describing: plumberDict["inpectTimePool"]!)
                    cellData.txtData.text = String(describing: plumberDict["inpectTimePool"]!)
                } else {
                    cellData.txtData.text = self.secPlumber2[indexPath.row].formTextValue
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

                if plumberDict.count > 0 {
                    self.secPlumber2[Payment.price.rawValue].formTextValue = String(describing: plumberDict["priceForLeakPool"]!)
                    cellData.txtData.text = String(describing: plumberDict["priceForLeakPool"]!)
                } else {
                    cellData.txtData.text = self.secPlumber2[indexPath.row].formTextValue
                }
                cellData.txtData.delegate = self
                return cellData
            } else {
                let cellData = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath) as! DataValueTableCell
                
                cellData.lblTag.text = "Notes: (Gate Code etc)"
                cellData.txtData.keyboardType = UIKeyboardType.asciiCapable

                if plumberDict.count > 0 {
                    self.secPlumber2[Payment.note.rawValue].formTextValue = String(describing: plumberDict["notesPool"]!)
                    cellData.txtData.text = String(describing: plumberDict["notesPool"]!)
                } else {
                    cellData.txtData.text = self.secPlumber2[indexPath.row].formTextValue
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
    /*{
        if indexPath.section == 0 {
            if indexPath.row == Contact.address.rawValue {
                let addressCell = tableView.dequeueReusableCell(withIdentifier: "AddressCell", for: indexPath) as! AddressTableCell
                
                addressCell.lblTag.text = "Address"
                addressCell.txtAddress.keyboardType = UIKeyboardType.asciiCapable
                if plumberDict.count > 0 {
                    self.secPool1[Contact.address.rawValue].formTextValue = String(describing: plumberDict["addressPlumber"]!)
                    addressCell.txtAddress.text = String(describing: plumberDict["addressPlumber"]!)
                } else {
                    addressCell.txtAddress.text = self.secPlumber1[indexPath.row].formTextValue
                }
                addressCell.txtAddress.delegate = self
                
                return addressCell
            } else {
                let cellData = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath) as! DataValueTableCell
                
                if indexPath.row == Contact.name.rawValue {
                    cellData.lblTag.text = "Name"
                    cellData.txtData.keyboardType = UIKeyboardType.asciiCapable
                    if plumberDict.count > 0 {
                        self.secPool1[Contact.name.rawValue].formTextValue = String(describing: plumberDict["namePlumberLeak"]!)
                        cellData.txtData.text = String(describing: plumberDict["namePlumberLeak"]!)
                    } else {
                        cellData.txtData.text = (self.secPlumber1[indexPath.row].formTextValue)//.capitalizingFirstLetter()
                    }
                } else if indexPath.row == Contact.city.rawValue {
                    cellData.lblTag.text = "City"
                    cellData.txtData.keyboardType = UIKeyboardType.asciiCapable
                    if plumberDict.count > 0 {
                        self.secPool1[Contact.city.rawValue].formTextValue = String(describing: plumberDict["cityPlumber"]!)
                        cellData.txtData.text = String(describing: poolDict["cityPlumber"]!)
                    } else {
                        cellData.txtData.text = (self.secPlumber1[indexPath.row].formTextValue)//.capitalizingFirstLetter()
                    }
                } else if indexPath.row == Contact.state.rawValue {
                    cellData.lblTag.text = "State"
                    cellData.txtData.keyboardType = UIKeyboardType.asciiCapable
                    cellData.txtData.text = (self.secPlumber1[indexPath.row].formTextValue)//.capitalizingFirstLetter()
                } else if indexPath.row == Contact.zip.rawValue {
                    cellData.lblTag.text = "Zip"
                    cellData.txtData.keyboardType = UIKeyboardType.numberPad
                    cellData.txtData.text = (self.secPlumber1[indexPath.row].formTextValue)//.capitalizingFirstLetter()
                } else if indexPath.row == Contact.phone.rawValue {
                    cellData.lblTag.text = "Phone Number"
                    cellData.txtData.keyboardType = UIKeyboardType.numberPad
                    cellData.txtData.text = (self.secPlumber1[indexPath.row].formTextValue).toPhoneNumber()
                } else if indexPath.row == Contact.email.rawValue {
                    cellData.lblTag.text = "Email Address"
                    cellData.txtData.autocapitalizationType = .none
                    cellData.txtData.keyboardType = UIKeyboardType.emailAddress
                    cellData.txtData.text = (self.secPlumber1[indexPath.row].formTextValue)//.capitalizingFirstLetter()
                } else if indexPath.row == Contact.payment.rawValue {
                    cellData.lblTag.text = "Person responsible for payment"
                    cellData.txtData.autocapitalizationType = .none
                    cellData.txtData.keyboardType = UIKeyboardType.asciiCapable
                    cellData.txtData.text = (self.secPlumber1[indexPath.row].formTextValue)//.capitalizingFirstLetter()
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
                
                cellData.txtAddress.text = self.secPlumber2[indexPath.row].formTextValue
                cellData.txtAddress.delegate = self
                
                return cellData
            } else if indexPath.row == Payment.time.rawValue {
                let cellData = tableView.dequeueReusableCell(withIdentifier: "DateCell", for: indexPath) as! DateValueTableCell
                
                cellData.lblTag.text = "Date of Leak Detection"
                cellData.txtData.isUserInteractionEnabled = false
                
                cellData.txtData.text = self.secPlumber2[indexPath.row].formTextValue
                
                cellData.btnDate.addTarget(self, action: #selector(btnDatePickerDidTap), for: UIControl.Event.touchUpInside)
                cellData.txtData.delegate = self
                
                return cellData
            } else if indexPath.row == Payment.price.rawValue {
                let cellData = tableView.dequeueReusableCell(withIdentifier: "PriceCell", for: indexPath) as! PriceValueTableCell
                
                cellData.lblTag.text = "Price for Leak Detection"
                cellData.txtData.keyboardType = UIKeyboardType.numberPad
                 cellData.txtData.isUserInteractionEnabled = true
                cellData.txtData.withImage(direction: .Left, image: UIImage(named: "dollar")!, colorSeparator: UIColor.clear, colorBorder: UIColor.clear)
                
                if plumberDict.count > 0 {
                    self.secPlumber2[Payment.price.rawValue].formTextValue = String(describing: plumberDict["priceForLeakPool"]!)
                    cellData.txtData.text = String(describing: plumberDict["priceForLeakPool"]!)
                } else {
                    cellData.txtData.text = self.secPlumber2[indexPath.row].formTextValue
                }
                return cellData
            } else {
                let cellData = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath) as! DataValueTableCell
                
                cellData.lblTag.text = "Notes: (Gate Code etc)"
                cellData.txtData.keyboardType = UIKeyboardType.asciiCapable

                cellData.txtData.isUserInteractionEnabled = true

                if plumberDict.count > 0 {
                    self.secPlumber2[Payment.note.rawValue].formTextValue = String(describing: plumberDict["notesPlumber"]!)
                    cellData.txtData.text = String(describing: plumberDict["notesPlumber"]!)
                } else {
                    cellData.txtData.text = self.secPlumber2[indexPath.row].formTextValue
                }
                cellData.txtData.delegate = self
                
                return cellData
            }
        } else {
            let cellBtn = tableView.dequeueReusableCell(withIdentifier: "NextCell", for: indexPath) as! NextForm1TableCell
            
            cellBtn.btnNext.addTarget(self, action: #selector(btnNextDidTap), for: UIControl.Event.touchUpInside)
            return cellBtn
        }
    }*/
    
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
                return 55
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

class formPlumberContactData {
    var formTextValue = ""
}

