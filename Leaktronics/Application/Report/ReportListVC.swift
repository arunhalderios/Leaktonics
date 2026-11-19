//
//  ReportListVC.swift
//  Leaktronics
//
//  Created by ivaninfotech on 6/4/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import ScrollableSegmentedControl
import FSCalendar
import Alamofire
import SVProgressHUD
import CoreData

class ReportListVC: UIViewController {
    
    @IBOutlet weak var tblReportList: UITableView!
    @IBOutlet weak var scrollableSegment: ScrollableSegmentedControl!
    var multipleDates: [Date]?
    private var datesRange: [Date]?
    
    @IBOutlet weak var calendar: FSCalendar!
    
    // first date in the range
    private var firstDate: Date?
    // last date in the range
    private var lastDate: Date?
    
    var arrReportList = NSArray()
    @IBOutlet weak var filterVw: UIView!
    @IBOutlet weak var vwBack: UIView!
    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var lblEndDate: UILabel!
    @IBOutlet weak var lblStartMonth: UILabel!
    @IBOutlet weak var lblEndMonth: UILabel!
    @IBOutlet weak var lblStartDay: UILabel!
    @IBOutlet weak var lblEndDay: UILabel!
    
    var selectedSegment = Int()
    var reportSegmentType = "A"
    
    var fetchIndex = Int()
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.filterVw.isHidden = true
        self.vwBack.isHidden = true
    
        self.calendar.allowsMultipleSelection = true
    
        scrollableSegment.segmentStyle = .textOnly
        scrollableSegment.insertSegment(withTitle: "All", at: 0)
        scrollableSegment.insertSegment(withTitle: "Incomplete", at: 1)
        scrollableSegment.insertSegment(withTitle: "Complete", at: 2)
        scrollableSegment.selectedSegmentIndex = 0
        scrollableSegment.underlineSelected = true
            
        scrollableSegment.addTarget(self, action: #selector(ReportListVC.segmentSelected(sender:)), for: .valueChanged)

        // change some colors
        scrollableSegment.segmentContentColor = UIColor.lightGray
        scrollableSegment.selectedSegmentContentColor = UIColor.black
        scrollableSegment.backgroundColor = UIColor.clear

        
        // Turn off all segments been fixed/equal width.
        // The width of each segment would be based on the text length and font size.
        scrollableSegment.fixedSegmentWidth = true
        
        self.getReportList(reportType: "A")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let backButton = UIBarButtonItem()
        backButton.title = ""//"Report List"
        backButton.tintColor = UIColor.black
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        
    }
    
    @objc func segmentSelected(sender:ScrollableSegmentedControl) {
        print("Segment at index \(sender.selectedSegmentIndex)  selected")
        selectedSegment = sender.selectedSegmentIndex
        if selectedSegment == 0 {
            arrReportList = []
            self.getReportList(reportType: "A")
            reportSegmentType = "A"

        } else if selectedSegment == 1 {
            arrReportList = []
            self.getReportList(reportType: "I")
            reportSegmentType = "I"

        } else if selectedSegment == 2 {
            arrReportList = []
            self.getReportList(reportType: "C")
            reportSegmentType = "C"

        }
    }

    //MARK:- Filter button Action
    @IBAction func btnFilterDidTap(_ sender: Any) {
         self.filterVw.isHidden = false
         self.vwBack.isHidden = false
         self.multipleDates = []
         print(multipleDates!)
        if multipleDates!.count == 0 {
            let date = Date()
           
            let dayFormatter = DateFormatter()
            dayFormatter.dateFormat = "dd"
            let formatteddate = dayFormatter.string(from: date)
            print(formatteddate)
           
            let monthFormatter = DateFormatter()
            monthFormatter.dateFormat = "MMMM,yyyy"
            let formattedmonth = monthFormatter.string(from: date)
            print(formattedmonth)
            
            let weekNameFormatter = DateFormatter()
            weekNameFormatter.dateFormat = "EEEE"
            let formattedweek = weekNameFormatter.string(from: date)
            print(formattedweek)
            
            self.lblStartDate.text = "\(formatteddate)"
            self.lblEndDate.text = "\(formatteddate)"
            
            self.lblStartMonth.text = "\(formattedmonth)"
            self.lblEndMonth.text = "\(formattedmonth)"
            
            self.lblStartDay.text =  "\(formattedweek)"
            self.lblEndDay.text = "\(formattedweek)"
        }
    }
    
    //MARK:- Background Button
    @IBAction func btnBackgroundDismiss(_ sender: Any) {
         self.filterVw.isHidden = true
         self.vwBack.isHidden = true
         self.multipleDates = []
    }
    
    //MARK: - Filter Button
    @IBAction func btnApplyFilter(_ sender: Any) {
        self.filterVw.isHidden = true
        self.vwBack.isHidden = true
        self.getFliterList(datesRange: datesRange!)
    }
    
    //MARK:- @objc Function
    @objc func btnSendReportTap(_ sender: Any) {
        print("Button pressed 👍 ")
        let btn = sender as! UIButton
        let cell = btn.superview?.superview?.superview as! UITableViewCell
        let indexOfCell = self.tblReportList.indexPath(for: cell)
        let selectedRowIndex = indexOfCell?.row
        let sectionIndex = indexOfCell?.section
        print("Select Section : \(String(describing: sectionIndex!))")
        print("Select Index : \(String(describing: selectedRowIndex!))")
        

        let dic: NSDictionary = arrReportList[sectionIndex!] as! NSDictionary
        let arrReport: NSArray = dic["value"] as! NSArray
        let dicReport: NSDictionary = arrReport[selectedRowIndex!] as! NSDictionary
        
        print(dicReport)
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: "Send Report", message: "", preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in
            //getting the input values from user
            //let name = alertController.textFields?[0].text
            //let email = alertController.textFields?[1].text
            
            self.postSendReport(reportId: dicReport["id"] as! String, reportType: dicReport["inspection_type"] as! String, receiverName: (alertController.textFields?[0].text)!, receiverEmail: (alertController.textFields?[1].text)!)
        }
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        //adding textfields to our dialog box
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Receiver Name"
            textField.keyboardType = UIKeyboardType.alphabet
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Receiver Email Id"
            textField.keyboardType = UIKeyboardType.emailAddress
        }
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
    
    func savePoolCoredate(report: NSDictionary) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Pool1_CoreData", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        
        newUser.setValue(report["contact_name"], forKey: "namePoolDetection")
        newUser.setValue(report["contact_address"], forKey: "addressPool")
        newUser.setValue(report["contact_city"], forKey: "cityPool")
        newUser.setValue(report["contact_state"], forKey: "statePool")
        newUser.setValue(report["contact_zip"], forKey: "zipPool")
        newUser.setValue(report["contact_phone"], forKey: "phoneNoPool")
        newUser.setValue(report["contact_name"], forKey: "emailPool")
        newUser.setValue(report["contact_name"], forKey: "notesPool")
        newUser.setValue(report["contact_name"], forKey: "otherNotesPool")
        newUser.setValue(report["contact_name"], forKey: "priceForLeakPool")
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "MM/dd/YYYY HH:mm"
        let formattedDate = format.string(from: date)
        print(formattedDate)
        
        //newUser.setValue(formattedDate, forKey:"pool_inspection_date_time")
        newUser.setValue(report["inspection_date_time"], forKey:"pool_inspection_date_time")
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    //MARK:: Function Api Calling
    func getReportList(reportType: String) {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
                  
        let todosEndpoint: String = ServiceConstant.BASE_URL.appending(ServiceConstant.GetReport)
        let token: String = UserDefaults.standard.value(forKey: "key_token") as! String
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": token
        ]
        
        let params: Parameters = [
            "type"  : reportType
        ]
        print(params)
        
        Alamofire.request(todosEndpoint, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
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
                    print("ReportList json :: \(String(describing: json))")
                    self.arrReportList = json["data"] as! NSArray
                    print("ReportList json :: \(String(describing: self.arrReportList))")
                    
                    DispatchQueue.main.async(execute: {() -> Void in
                        self.tblReportList.reloadData()
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
    
    func getFliterList(datesRange: [Date]) {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
        let token: String = UserDefaults.standard.value(forKey: "key_token") as! String
        
        let headers = [
            "Authorization": token,
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        let url = ServiceConstant.BASE_URL.appending(ServiceConstant.GetFilter)
        print(url)
        Alamofire.upload(multipartFormData: { multipartFormData in
            print(datesRange)
            for date in datesRange {
                print(date)
                let formatter = DateFormatter()
                //then again set the date format whhich type of output you need
                formatter.dateFormat = "MM/dd/yyyy"
                // again convert your date to string
                let strDate = formatter.string(from: date)

                print(strDate)
                if let codeData = strDate.data(using: String.Encoding.utf8) {
                    multipartFormData.append(codeData, withName: "date[]" )
                }
            }
        }, to: url,
           method:.post,
           headers:headers ,
           encodingCompletion: { encodingResult in
               switch encodingResult {
               case .success(let upload, _, _):
                   upload.responseJSON { response in
                       guard let json = response.result.value as? [String: Any] else {
                        print(response)
                        print(response.data as Any)
                        print("didn't get todo object as JSON from API")
                        //print("Error: \(response.result.error as! NSString)")
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
                               print("FilterList json :: \(String(describing: json))")
                               self.arrReportList = json["data"] as! NSArray
                               print("FilterList json :: \(String(describing: self.arrReportList))")
                               
                               DispatchQueue.main.async(execute: {() -> Void in
                                   self.tblReportList.reloadData()
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
               case .failure(let encodingError):
                   print("error:\(encodingError)")
                   SVProgressHUD.dismiss()
               }
           })
    }
    
    func postSearchList(searchText: String) {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
                  
        let todosEndpoint: String = ServiceConstant.BASE_URL.appending(ServiceConstant.PostSearch)
        let token: String = UserDefaults.standard.value(forKey: "key_token") as! String
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": token
        ]
        
        let parameters: Parameters = [
            "name"  : searchText,
            "type" : reportSegmentType
        ]
        
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
                    print("SearchList json :: \(String(describing: json))")
                    self.arrReportList = json["data"] as! NSArray
                    print("SearchList json :: \(String(describing: self.arrReportList))")
                    
                    DispatchQueue.main.async(execute: {() -> Void in
                        self.tblReportList.reloadData()
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
    
    func postSendReport(reportId: String, reportType: String, receiverName: String, receiverEmail: String) {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: "Processing...")
                  
        let todosEndpoint: String = ServiceConstant.BASE_URL.appending(ServiceConstant.PostSendReport)
        print(todosEndpoint)
        
        let token: String = UserDefaults.standard.value(forKey: "key_token") as! String
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": token
        ]
        
        let parameters: Parameters = [
            "device_id"     : (UIDevice.current.identifierForVendor?.uuidString)!,
            "receiver_name" : receiverName,
            "receiver_email": receiverEmail,
            "reportId"      : reportId,
            "reportTYpe"    : reportType
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

extension ReportListVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let searchText  = textField.text!
        print(searchText)
        self.postSearchList(searchText: searchText)
        textField.resignFirstResponder()
        return true
    }
}
extension ReportListVC: FSCalendarDataSource,FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // nothing selected:
        if firstDate == nil {
            firstDate = date
            datesRange = [firstDate!]

            print("datesRange contains: \(datesRange!)")

            return
        }

        // only first date is selected:
        if firstDate != nil && lastDate == nil {
            // handle the case of if the last date is less than the first date:
            if date <= firstDate! {
                calendar.deselect(firstDate!)
                firstDate = date
                datesRange = [firstDate!]

                print("datesRange contains: \(datesRange!)")

                return
            }

            let range = datesRange(from: firstDate!, to: date)

            lastDate = datesRange?.last

            for d in range {
                calendar.select(d)
            }

            datesRange = range

            print("datesRange contains: \(datesRange!)")

            return
        }

        // both are selected:
        if firstDate != nil && lastDate != nil {
            for d in calendar.selectedDates {
                calendar.deselect(d)
            }

            lastDate = nil
            firstDate = nil

            datesRange = []

            print("datesRange contains: \(datesRange!)")
        }
    }

    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // both are selected:

        // NOTE: the is a REDUANDENT CODE:
        if firstDate != nil && lastDate != nil {
            for d in calendar.selectedDates {
                calendar.deselect(d)
            }

            lastDate = nil
            firstDate = nil

            datesRange = []
            print("datesRange contains: \(datesRange!)")
        }
    }
    
    func datesRange(from: Date, to: Date) -> [Date] {
        // in case of the "from" date is more than "to" date,
        // it should returns an empty array:
        if from > to { return [Date]() }

        var tempDate = from
        var array = [tempDate]
        
        while tempDate < to {
            tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
            array.append(tempDate)
        }

        return array
    }
}

extension ReportListVC: UITableViewDelegate, UITableViewDataSource {
    //MARK:- TableView DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrReportList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dic: NSDictionary = arrReportList[section] as! NSDictionary
        let arrReport: NSArray = dic["value"] as! NSArray
        return arrReport.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : AllReportListTableCell = tableView.dequeueReusableCell(withIdentifier: "AllReportCell") as! AllReportListTableCell
        
        if arrReportList.count > 0 {
            let dic: NSDictionary = arrReportList[indexPath.section] as! NSDictionary
            let arrReport: NSArray = dic["value"] as! NSArray
            let dicReport: NSDictionary = arrReport[indexPath.row] as! NSDictionary
            cell.lblReportName.text = String(describing: dicReport["contact_name"]!)
            cell.lblReportType.text = String(describing: dicReport["inspection_type"]!)
            cell.lblReportAddress.text = String(describing: dicReport["contact_address"]!)
            cell.lblReportPh.text = String(describing: dicReport["contact_phone"]!)
            
            if selectedSegment == 0 {
                let strStatus: String = String(describing: dicReport["status"]!)
                if  strStatus == "I" {
                    cell.btnReportStatus.setTitle("Incomplete", for: .normal)
                    cell.btnReportStatus.setTitleColor(#colorLiteral(red: 0.9474589229, green: 0.2073712945, blue: 0.1776620746, alpha: 1), for: .normal)
                } else if strStatus == "A" {
                    cell.btnReportStatus.setTitle("Complete", for: .normal)
                    cell.btnReportStatus.setTitleColor(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), for: .normal)
                }
            } else if selectedSegment == 1 {
                cell.btnReportStatus.setTitle("Incomplete", for: .normal)
                cell.btnReportStatus.setTitleColor(#colorLiteral(red: 0.9474589229, green: 0.2073712945, blue: 0.1776620746, alpha: 1), for: .normal)
            } else if selectedSegment == 2 {
                cell.btnReportStatus.setTitle("Complete", for: .normal)
                cell.btnReportStatus.setTitleColor(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), for: .normal)
            }
            cell.btnSendReport.addTarget(self, action: #selector(btnSendReportTap(_:)), for: UIControl.Event.touchUpInside)
        }
        
        return cell
    }
    
    //MARK:- TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedSegment == 1 {
            if arrReportList.count > 0 {
                let dic: NSDictionary = arrReportList[indexPath.section] as! NSDictionary
                let arrReport: NSArray = dic["value"] as! NSArray
                let dicReport: NSDictionary = arrReport[indexPath.row] as! NSDictionary
                print(dicReport)
                self.savePoolCoredate(report: dicReport)
                let strInspectType = dicReport["inspection_type"] as! String
                UserDefaults.standard.set(true, forKey: "isFromReportList")
                if strInspectType == "Plumbing Leak Detection" {
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "PlumberLeak", bundle:nil)
                        let nextVC = storyBoard.instantiateViewController(withIdentifier: "PlumberContactForm") as! PlumberContactFormVC
                        nextVC.strReport_id = String(describing: dicReport["id"]!)
                        self.navigationController?.pushViewController(nextVC, animated: true)
                    } else { //UIDevice.current.userInterfaceIdiom == .pad
                        let storyBoard : UIStoryboard = UIStoryboard(name: "PlumberLeak_iPad", bundle:nil)
                        let nextVC = storyBoard.instantiateViewController(withIdentifier: "PlumberContactForm") as! PlumberContactFormVC
                        nextVC.strReport_id = String(describing: dicReport["id"]!)
                        self.navigationController?.pushViewController(nextVC, animated: true)
                    }
                } else if strInspectType == "Pool Leak Detection"{
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection", bundle:nil)
                        let nextVC = storyBoard.instantiateViewController(withIdentifier: "PoolDetectionContactVC") as! PoolDetectionContactVC
                        //let nextVC = storyBoard.instantiateViewController(withIdentifier: "VisualLeak") as! VisualLeakVC
                        
                        nextVC.strReport_id = String(describing: dicReport["id"]!)
                        self.navigationController?.pushViewController(nextVC, animated: true)
                    } else { //UIDevice.current.userInterfaceIdiom == .pad
                        let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection_iPad", bundle:nil)
                        let nextVC = storyBoard.instantiateViewController(withIdentifier: "PoolDetectionContactVC") as! PoolDetectionContactVC
                        //let nextVC = storyBoard.instantiateViewController(withIdentifier: "PlumbingStatistic2") as! PlumbingStatistic2VC
                        nextVC.strReport_id = String(describing: dicReport["id"]!)
                        self.navigationController?.pushViewController(nextVC, animated: true)
                    }
                }
            }
        } else if selectedSegment == 2 {
            if arrReportList.count > 0 {
                let dic: NSDictionary = arrReportList[indexPath.section] as! NSDictionary
                let arrReport: NSArray = dic["value"] as! NSArray
                let dicReport: NSDictionary = arrReport[indexPath.row] as! NSDictionary
                print(dicReport)
                self.savePoolCoredate(report: dicReport)
                let strInspectType = dicReport["inspection_type"] as! String
                UserDefaults.standard.set(true, forKey: "isFromReportList")
                if strInspectType == "Plumbing Leak Detection" {
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "PlumberLeak", bundle:nil)
                        let nextVC = storyBoard.instantiateViewController(withIdentifier: "PlumberContactForm") as! PlumberContactFormVC
                        nextVC.strReport_id = String(describing: dicReport["id"]!)
                        self.navigationController?.pushViewController(nextVC, animated: true)
                    } else { //UIDevice.current.userInterfaceIdiom == .pad
                        let storyBoard : UIStoryboard = UIStoryboard(name: "PlumberLeak_iPad", bundle:nil)
                        let nextVC = storyBoard.instantiateViewController(withIdentifier: "PlumberContactForm") as! PlumberContactFormVC
                        nextVC.strReport_id = String(describing: dicReport["id"]!)
                        self.navigationController?.pushViewController(nextVC, animated: true)
                    }
                } else if strInspectType == "Pool Leak Detection" {
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection", bundle:nil)
                        let nextVC = storyBoard.instantiateViewController(withIdentifier: "PoolDetectionContactVC") as! PoolDetectionContactVC
                        nextVC.strReport_id = String(describing: dicReport["id"]!)
                        self.navigationController?.pushViewController(nextVC, animated: true)
                    } else { //UIDevice.current.userInterfaceIdiom == .pad
                        let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection_iPad", bundle:nil)
                        let nextVC = storyBoard.instantiateViewController(withIdentifier: "PoolDetectionContactVC") as! PoolDetectionContactVC
                        nextVC.strReport_id = String(describing: dicReport["id"]!)
                        self.navigationController?.pushViewController(nextVC, animated: true)
                    }
                } else if strInspectType == "Pool Inspection Detection" {
                    /*if UIDevice.current.userInterfaceIdiom == .phone {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "PlumberLeak", bundle:nil)
                        let nextVC = storyBoard.instantiateViewController(withIdentifier: "PlumberContactForm") as! PlumberContactFormVC
                        nextVC.strReport_id = String(describing: dicReport["id"]!)
                        self.navigationController?.pushViewController(nextVC, animated: true)
                    } else { //UIDevice.current.userInterfaceIdiom == .pad
                        let storyBoard : UIStoryboard = UIStoryboard(name: "PlumberLeak_iPad", bundle:nil)
                        let nextVC = storyBoard.instantiateViewController(withIdentifier: "PlumberContactForm") as! PlumberContactFormVC
                        nextVC.strReport_id = String(describing: dicReport["id"]!)
                        self.navigationController?.pushViewController(nextVC, animated: true)
                    }*/
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return 180
        } else { //UIDevice.current.userInterfaceIdiom == .pad
            return 325
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // get a reference to our storyboard cell
        let headerView : UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "CustomReportHeaderCell")!
        
        let lblHeaderTitle = headerView.viewWithTag(10) as! UILabel
        let dic: NSDictionary = arrReportList[section] as! NSDictionary
        lblHeaderTitle.text = String(describing: dic["date"]!)  // set this however is appropriate for your app's model
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return 45
        } else { //UIDevice.current.userInterfaceIdiom == .pad
            return 85
        }
    }
}


