//
//  InspectPoolContactVC.swift
//  Leaktronics
//
//  Created by ivaninfotech on 4/14/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import CoreData
import SVProgressHUD
import Alamofire


class InspectPoolContactVC: UIViewController {
    
    @IBOutlet weak var tblInspectionContact: UITableView!
    
    
    var secInspect1 = [formInspectionPoolData]()
    var secInspect2 = [formInspectionPoolData]()
    
    
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
        
        self.prepareFormInspectionPoolContactData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = UIColor.black
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    func prepareFormInspectionPoolContactData() {
        for _ in 0..<8 {
            let obj = formInspectionPoolData()
            self.secInspect1.append(obj)
        }
        
        for _ in 0..<4 {
            let obj = formInspectionPoolData()
            self.secInspect2.append(obj)
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
    
    
    //MARK:- Function
    @objc func btnDatePickerDidTap() {
        DatePickerDialog().show("DatePicker", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .dateAndTime) {
            (date) -> Void in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "MM/dd/YYYY HH:mm"
                print(dt)
                //textField.text = formatter.string(from: dt)
                self.secInspect2[3].formTextValue = formatter.string(from: dt)//(textfield.text)!
                self.tblInspectionContact.reloadData()
            }
        }
    }
    
    @objc func btnNextDidTap() {
        if self.secInspect1[Contact.name.rawValue].formTextValue == "" {
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
            self.view.endEditing(true)
            //self.postInspectionContactDetails()
            let userName = UserDefaults.standard.value(forKey: "InspectionUserName") ?? ""
            if userName as! String == "" {
                self.saveIntoCoreData()
            } else {
                self.updateCoreData()
            }
            if UIDevice.current.userInterfaceIdiom == .phone {
                let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
                let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectQuestionnaireForm") as! InspectQuestionnaireFormVC
                self.navigationController?.pushViewController(formVC, animated: true)
            } else if UIDevice.current.userInterfaceIdiom == .pad {
                let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
                let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectQuestionnaireForm") as! InspectQuestionnaireFormVC
                self.navigationController?.pushViewController(formVC, animated: true)
            }
        }
    }
    
    //MARK:- CoreData
    func saveIntoCoreData() {
        UserDefaults.standard.removeObject(forKey: "InspectionUserName")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "InspectionPool_CoreData", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        
        //let strPh = Int16(self.secInspect1[Contact.phone.rawValue].formTextValue)
        //let strZip = Int16(self.secInspect1[Contact.zip.rawValue].formTextValue)
        
        newUser.setValue(self.secInspect1[Contact.name.rawValue].formTextValue, forKey: "nameInspect")
        newUser.setValue(self.secInspect1[Contact.address.rawValue].formTextValue, forKey: "addressInspect")
        newUser.setValue(self.secInspect1[Contact.city.rawValue].formTextValue, forKey: "cityInspect")
        newUser.setValue(self.secInspect1[Contact.state.rawValue].formTextValue, forKey: "stateInspect")
        newUser.setValue(self.secInspect1[Contact.zip.rawValue].formTextValue, forKey: "zipInspect")
        newUser.setValue(self.secInspect1[Contact.phone.rawValue].formTextValue, forKey: "phoneNoInspect")
        newUser.setValue(self.secInspect1[Contact.email.rawValue].formTextValue, forKey: "emailInspect")
        newUser.setValue(self.secInspect1[Contact.payment.rawValue].formTextValue, forKey: "paymentPersonInspect")
        newUser.setValue(self.secInspect2[Payment.note.rawValue].formTextValue, forKey: "notesInspect")
        newUser.setValue(self.secInspect2[Payment.otherNote.rawValue].formTextValue, forKey: "otherNotesInspect")
        newUser.setValue(self.secInspect2[Payment.price.rawValue].formTextValue, forKey: "priceForLeakInspect")
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "MM/dd/YYYY HH:mm"
        let formattedDate = format.string(from: date)
        print(formattedDate)
        
        newUser.setValue(formattedDate, forKey:"inspection_date_time")
        
        do {
            try context.save()
            UserDefaults.standard.set(self.secInspect1[Contact.name.rawValue].formTextValue, forKey: "InspectionUserName")
        } catch {
            print("Failed saving")
        }
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "InspectionPool_CoreData")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false

        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let userName: String = UserDefaults.standard.value(forKey: "InspectionUserName") as! String
                if (data.value(forKey: "nameInspect") as! String) == userName {
                    print("Data of InspectContact:: \(data)")
                    print(data.value(forKey: "nameInspect") as! String)
                }
            }
        } catch {
            
            print("Failed")
        }
    }
    
    func updateCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "InspectionPool_CoreData")
        
        let userName: String = UserDefaults.standard.value(forKey: "InspectionUserName") as! String
        let predicate = NSPredicate(format: "%K == %@", "nameInspect", userName)
        fetchRequest.predicate = predicate
        
        do {
            let  rs = try managedContext.fetch(fetchRequest)
            for _ in rs as [NSManagedObject] {
                // update
                do {
                    let managedObject = rs[0]
                    
                    //let strPh = Int16(self.secInspect1[Contact.phone.rawValue].formTextValue)
                    //let strZip = Int16(self.secInspect1[Contact.zip.rawValue].formTextValue)
                    
                    managedObject.setValue(self.secInspect1[Contact.name.rawValue].formTextValue, forKey: "nameInspect")
                    managedObject.setValue(self.secInspect1[Contact.address.rawValue].formTextValue, forKey: "addressInspect")
                    managedObject.setValue(self.secInspect1[Contact.city.rawValue].formTextValue, forKey: "cityInspect")
                    managedObject.setValue(self.secInspect1[Contact.state.rawValue].formTextValue, forKey: "stateInspect")
                    managedObject.setValue(self.secInspect1[Contact.zip.rawValue].formTextValue, forKey: "zipInspect")
                    managedObject.setValue(self.secInspect1[Contact.phone.rawValue].formTextValue, forKey: "phoneNoInspect")
                    managedObject.setValue(self.secInspect1[Contact.email.rawValue].formTextValue, forKey: "emailInspect")
                    managedObject.setValue(self.secInspect1[Contact.payment.rawValue].formTextValue, forKey: "paymentPersonInspect")
                    managedObject.setValue(self.secInspect1[Payment.note.rawValue].formTextValue, forKey: "notesInspect")
                    managedObject.setValue(self.secInspect1[Payment.otherNote.rawValue].formTextValue, forKey: "otherNotesInspect")
                    managedObject.setValue(self.secInspect1[Payment.price.rawValue].formTextValue, forKey: "priceForLeakInspect")
                    let date = Date()
                    let format = DateFormatter()
                    format.dateFormat = "MM/dd/YYYY HH:mm"
                    let formattedDate = format.string(from: date)
                    print(formattedDate)
                    
                    managedObject.setValue(formattedDate, forKey:"inspection_date_time")
                    
                    try managedContext.save()
                    UserDefaults.standard.set(self.secInspect1[Contact.name.rawValue].formTextValue, forKey: "PoolDetectionUserName")
                    print("update successfull")
                } catch let error as NSError {
                    print("Could not Update. \(error), \(error.userInfo)")
                }
                //end update
            }
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "InspectionPool_CoreData")
            request.returnsObjectsAsFaults = false

            do {
                let result = try managedContext.fetch(request)
                for data in result as! [NSManagedObject] {
                    if (data.value(forKey: "nameInspect") as! String) == userName {
                        print("Data of InspectContactDetails:: \(data)")
//                        print("isCommercialPool::",data.value(forKey: "isCommercialPool") as Any)
//                        print("isFountain::",data.value(forKey: "isFountain") as Any)
//                        print("waterFeatureOption::",data.value(forKey: "waterFeatureOption") as! String)
//                        print("solarSystemOption::",data.value(forKey: "solarSystemOption") as! String)
//                        print("catchBasinOption::",data.value(forKey: "catchBasinOption") as! String)
//                        print("slotDrainOption::",data.value(forKey: "slotDrainOption") as! String)
//                    print("email::",data.value(forKey: "email") as! String)
//                    print("notes::",data.value(forKey: "notes") as! String)
//                    print("otherNotes::",data.value(forKey: "otherNotes") as! String)
//                    print("priceForLeak::",data.value(forKey: "priceForLeak") as! Int16)
                    }
                }
            } catch {
                print("Failed")
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    /*//MARK:: Function Api Calling
    func postInspectionContactDetails() {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        
        let contactDetails: NSMutableDictionary = [
            "device_id"             : (UIDevice.current.identifierForVendor?.uuidString)!,
            "nameInspection"        : self.secInspect1[Contact.name.rawValue].formTextValue,
            "addressInspect"        : self.secInspect1[Contact.address.rawValue].formTextValue,
            "cityInspect"           : self.secInspect1[Contact.city.rawValue].formTextValue,
            "stateInspect"          : self.secInspect1[Contact.state.rawValue].formTextValue,
            "zipInspect"            : self.secInspect1[Contact.zip.rawValue].formTextValue,
            "phoneNoInspect"        : self.secInspect1[Contact.phone.rawValue].formTextValue,
            "emailInspect"          : self.secInspect1[Contact.email.rawValue].formTextValue,
            "paymentPersonInspect"  : self.secInspect1[Contact.payment.rawValue].formTextValue,
            "notesInspect"          : self.secInspect2[Payment.note.rawValue].formTextValue,
            "otherNotesInspect"     : self.secInspect2[Payment.otherNote.rawValue].formTextValue,
            "priceForLeakInspect"   : self.secInspect2[Payment.price.rawValue].formTextValue,
            "inpectTimeInspect"     : Date().string(format: "MM/dd/YYYY HH:mm"),//"2020-04-24 10:05:06",
            "inspection_date_time"  : Date().string(format: "MM/dd/YYYY HH:mm")//"2020-04-24 10:05:06"
        ]
        
        print("contactDetails :: \(contactDetails)")
        //if sharedExtension.connectedToNetwork() {
        ApiManager.sharedInstanceAPI.PostInspectionPoolContactDetails(postId: 1, contactDetails: contactDetails, onSuccess: { json in
            DispatchQueue.main.async {
                print("PoolDetectionContactDetails json :: \(String(describing: json))")
                //let poolDetectDict = (json["data"] as AnyObject) as! [String : AnyObject]
                
                let poolDetectDict = (json["data"] as AnyObject) as! [String : AnyObject]
                
                //store dic data
                UserDefaults.standard.set(poolDetectDict["return_data_id"]!, forKey: "returnKeyForInspection")
                
                DispatchQueue.main.async(execute: {() -> Void in
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectQuestionnaireForm") as! InspectQuestionnaireFormVC
                        self.navigationController?.pushViewController(formVC, animated: true)
                    } else if UIDevice.current.userInterfaceIdiom == .pad {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "InspectionPool_iPad", bundle:nil)
                        let formVC = storyBoard.instantiateViewController(withIdentifier: "InspectQuestionnaireForm") as! InspectQuestionnaireFormVC
                        self.navigationController?.pushViewController(formVC, animated: true)
                    }
                    SVProgressHUD.dismiss()
                })
            }
        }, onFailure: { error in
            DispatchQueue.main.sync(execute: {() -> Void in
                SVProgressHUD.dismiss()
                print("Error Message::\(error)")
                let alert = UIAlertController(title: "", message: error["message"] as? String, preferredStyle: .alert)
                let dismissAction = UIAlertAction(title: "OK", style: .default) { (_) -> Void in
                    DispatchQueue.main.async(execute: {() -> Void in
                        
                    })
                }
                alert.addAction(dismissAction)
                self.present(alert, animated: true, completion: nil)
            })
        })
    }*/
}


extension InspectPoolContactVC: UITextFieldDelegate {
    @objc func updateInspectTextfieldValue() {
        let cell = self.tblInspectionContact.cellForRow(at: IndexPath.init(row: self.selectedRowIndex, section: self.sectionIndex))
        guard let _cell = cell else { return  }
        
        if let dataValueTblCell = _cell as? DataValueTableCell {
            if let textfield = dataValueTblCell.txtData {
                if self.sectionIndex == 0 {
                    if self.selectedRowIndex == Contact.phone.rawValue {
                        let formatted = textfield.text?.toPhoneNumber()
                        self.secInspect1[self.selectedRowIndex].formTextValue = formatted!
                        textfield.text = self.secInspect1[Contact.phone.rawValue].formTextValue
                    } else {
                        self.secInspect1[self.selectedRowIndex].formTextValue = (textfield.text)!
                    }
                } else {
                    self.secInspect2[self.selectedRowIndex].formTextValue = (textfield.text)!
                }
            }
        } else if let priceCell = _cell as? PriceValueTableCell {
            if let textfield = priceCell.txtData {
                if self.sectionIndex == 1 {
                    self.secInspect2[self.selectedRowIndex].formTextValue = (textfield.text)!
                }
            }
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let cell = (textField.superview?.superview as? UITableViewCell)!
        
        let indexpath = self.tblInspectionContact.indexPath(for: cell)
        guard let _indexPath = indexpath else { return false }
        self.selectedRowIndex = _indexPath.row
        self.sectionIndex = _indexPath.section
        
        self.perform(#selector(InspectPoolContactVC.updateInspectTextfieldValue), with: nil, afterDelay: 1)
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range:NSRange, replacementString string: String) -> Bool {
        let cell = (textField.superview?.superview as? UITableViewCell)!
        
        let indexpath = self.tblInspectionContact.indexPath(for: cell)
        guard let _indexPath = indexpath else { return false }
        self.selectedRowIndex = _indexPath.row
        self.sectionIndex = _indexPath.section
        
        self.perform(#selector(InspectPoolContactVC.updateInspectTextfieldValue), with: nil, afterDelay: 1)
        
        return true
    }
    
}

extension InspectPoolContactVC: UITextViewDelegate {
    @objc func updateInspectTextViewValue() {
        let cell = self.tblInspectionContact.cellForRow(at: IndexPath.init(row: self.selectedRowIndex, section: self.sectionIndex))
        guard let _cell = cell else { return  }
        
        if let addressTblCell = _cell as? AddressTableCell {
            if let textView = addressTblCell.txtAddress {
                if self.sectionIndex == 0 {
                    self.secInspect1[self.selectedRowIndex].formTextValue = (textView.text)!
                } else {
                    self.secInspect2[self.selectedRowIndex].formTextValue = (textView.text)!
                }
            }
        }
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        let cell = (textView.superview?.superview as? UITableViewCell)!
        
        let indexpath = self.tblInspectionContact.indexPath(for: cell)
        guard let _indexPath = indexpath else { return false }
        self.selectedRowIndex = _indexPath.row
        self.sectionIndex = _indexPath.section
        
        self.perform(#selector(InspectPoolContactVC.updateInspectTextViewValue), with: nil, afterDelay: 1)
        
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let cell = (textView.superview?.superview as? UITableViewCell)!
        
        let indexpath = self.tblInspectionContact.indexPath(for: cell)
        guard let _indexPath = indexpath else { return false }
        self.selectedRowIndex = _indexPath.row
        self.sectionIndex = _indexPath.section
        
        self.perform(#selector(InspectPoolContactVC.updateInspectTextViewValue), with: nil, afterDelay: 1)
        
        return true
    }
}

extension InspectPoolContactVC: UITableViewDataSource, UITableViewDelegate {
    
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
                
                addressCell.txtAddress.text = self.secInspect1[indexPath.row].formTextValue
                //addressCell.txtAddress.tag = indexPath.row
                addressCell.txtAddress.delegate = self
                
                return addressCell
            } else {
                let cellData = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath) as! DataValueTableCell
                
                if indexPath.row == Contact.name.rawValue {
                    cellData.lblTag.text = "Name"
                    cellData.txtData.keyboardType = UIKeyboardType.asciiCapable
                    cellData.txtData.text = (self.secInspect1[indexPath.row].formTextValue)//.capitalizingFirstLetter()
                    cellData.txtData.withoutImage(direction: .Left, image: UIImage(named: "dollar")!, colorSeparator: UIColor.white, colorBorder: UIColor.white)
                } else if indexPath.row == Contact.city.rawValue {
                    cellData.lblTag.text = "City"
                    cellData.txtData.keyboardType = UIKeyboardType.asciiCapable
                    cellData.txtData.text = (self.secInspect1[indexPath.row].formTextValue)//.capitalizingFirstLetter()
                    cellData.txtData.withoutImage(direction: .Left, image: UIImage(named: "dollar")!, colorSeparator: UIColor.white, colorBorder: UIColor.white)
                } else if indexPath.row == Contact.state.rawValue {
                    cellData.lblTag.text = "State"
                    cellData.txtData.keyboardType = UIKeyboardType.asciiCapable
                    cellData.txtData.text = (self.secInspect1[indexPath.row].formTextValue)//.capitalizingFirstLetter()
                    cellData.txtData.withoutImage(direction: .Left, image: UIImage(named: "dollar")!, colorSeparator: UIColor.white, colorBorder: UIColor.white)
                } else if indexPath.row == Contact.zip.rawValue {
                    cellData.lblTag.text = "Zip"
                    cellData.txtData.keyboardType = UIKeyboardType.numberPad
                    cellData.txtData.text = (self.secInspect1[indexPath.row].formTextValue)//.capitalizingFirstLetter()
                    cellData.txtData.withoutImage(direction: .Left, image: UIImage(named: "dollar")!, colorSeparator: UIColor.white, colorBorder: UIColor.white)
                } else if indexPath.row == Contact.phone.rawValue {
                    cellData.lblTag.text = "Phone Number"
                    cellData.txtData.keyboardType = UIKeyboardType.numberPad
                    cellData.txtData.text = (self.secInspect1[indexPath.row].formTextValue).toPhoneNumber()
                    cellData.txtData.withoutImage(direction: .Left, image: UIImage(named: "dollar")!, colorSeparator: UIColor.white, colorBorder: UIColor.white)
                } else if indexPath.row == Contact.email.rawValue {
                    cellData.lblTag.text = "Email Address"
                    cellData.txtData.autocapitalizationType = .none
                    cellData.txtData.keyboardType = UIKeyboardType.emailAddress
                    cellData.txtData.text = (self.secInspect1[indexPath.row].formTextValue)//.capitalizingFirstLetter()
                    cellData.txtData.withoutImage(direction: .Left, image: UIImage(named: "dollar")!, colorSeparator: UIColor.white, colorBorder: UIColor.white)
                } else if indexPath.row == Contact.payment.rawValue {
                    cellData.lblTag.text = "Person responsible for payment"
                    cellData.txtData.autocapitalizationType = .none
                    cellData.txtData.keyboardType = UIKeyboardType.asciiCapable
                    cellData.txtData.text = (self.secInspect1[indexPath.row].formTextValue)//.capitalizingFirstLetter()
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
                
                cellData.txtAddress.text = self.secInspect2[indexPath.row].formTextValue
                //cellData.txtAddress.tag = indexPath.row
                cellData.txtAddress.delegate = self
                
                return cellData
            } else if indexPath.row == Payment.time.rawValue {
                let cellData = tableView.dequeueReusableCell(withIdentifier: "DateCell", for: indexPath) as! DateValueTableCell
                
                cellData.lblTag.text = "Date of Leak Detection"
                cellData.txtData.isUserInteractionEnabled = false
                
                cellData.txtData.text = self.secInspect2[indexPath.row].formTextValue
                
                cellData.btnDate.addTarget(self, action: #selector(btnDatePickerDidTap), for: UIControl.Event.touchUpInside)
                cellData.txtData.delegate = self
                
                return cellData
            } else if indexPath.row == Payment.price.rawValue {
                let cellData = tableView.dequeueReusableCell(withIdentifier: "PriceCell", for: indexPath) as! PriceValueTableCell
                
                cellData.lblTag.text = "Price for Leak Detection"
                cellData.txtData.keyboardType = UIKeyboardType.numberPad
                cellData.txtData.isUserInteractionEnabled = true
                cellData.txtData.withImage(direction: .Left, image: UIImage(named: "dollar")!, colorSeparator: UIColor.white, colorBorder: UIColor.white)
                
                 cellData.txtData.text = self.secInspect2[indexPath.row].formTextValue
                 cellData.txtData.delegate = self
                
                return cellData
            } else {
                let cellData = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath) as! DataValueTableCell
                
                cellData.lblTag.text = "Notes: (Gate Code etc)"
                cellData.txtData.keyboardType = UIKeyboardType.asciiCapable
                
                cellData.txtData.text = self.secInspect2[indexPath.row].formTextValue
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


class formInspectionPoolData {
    var formTextValue = ""
}
