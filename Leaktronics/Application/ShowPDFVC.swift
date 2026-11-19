//
//  ShowPDFVC.swift
//  Leaktronics
//
//  Created by Abhishek Mullick on 17/07/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import WebKit

class ShowPDFVC: UIViewController, WKUIDelegate {
    
    @IBOutlet weak var webShowPDF: WKWebView!
    @IBOutlet weak var webBackVw: UIView!
    
    var reportUrl = String()
    var strReport_id = String()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print("reportUrl:\(reportUrl)")
        print("strReport_id:\(strReport_id)")
        let myURL = URL(string:reportUrl)
        let myRequest = URLRequest(url: myURL!)
        webShowPDF.load(myRequest)
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            webShowPDF = WKWebView(frame: CGRect( x: 20, y: 500, width: UIScreen.main.bounds.size.width-40, height: UIScreen.main.bounds.size.height-500 ), configuration: WKWebViewConfiguration() )

        }
        else{
            webShowPDF = WKWebView(frame: CGRect( x: 50, y: 500, width: UIScreen.main.bounds.size.width-100, height: UIScreen.main.bounds.size.height-500 ), configuration: WKWebViewConfiguration() )

            
        }
           // self.view = webShowPDF
          //  self.view.addSubview(webShowPDF)
//        let req = NSURLRequest(url:myURL!)
//        webShowPDF.load(req as URLRequest)
        self.webShowPDF.allowsBackForwardNavigationGestures = true
        }
    
//    override func loadView() {
//       let webConfiguration = WKWebViewConfiguration()
//       webShowPDF = WKWebView(frame: .zero, configuration: webConfiguration)
//       webShowPDF.uiDelegate = self
//       view = webShowPDF
//    }
    
    
    @IBAction func PhoneContactClick(_ button:UIButton!){
                 if UIDevice.current.userInterfaceIdiom == .phone {
                     let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection", bundle:nil)
                     let nextVC = storyBoard.instantiateViewController(withIdentifier: "PoolDetectionContactVC") as! PoolDetectionContactVC
                     //let nextVC = storyBoard.instantiateViewController(withIdentifier: "PoolDetect") as! PoolDetectVC
                        nextVC.strReport_id = self.strReport_id
                    
                     self.navigationController?.pushViewController(nextVC, animated: true)
                 } else { //UIDevice.current.userInterfaceIdiom == .pad
                     let storyBoard : UIStoryboard = UIStoryboard(name: "PoolDetection_iPad", bundle:nil)
                     let nextVC = storyBoard.instantiateViewController(withIdentifier: "PoolDetectionContactVC") as! PoolDetectionContactVC
                        nextVC.strReport_id = self.strReport_id

                     self.navigationController?.pushViewController(nextVC, animated: true)
                 }
    }
    
    @IBAction func PhoneQuationaryClick(_ button:UIButton!){
      //ReportListVC
        //Home_iPad
        //Home_iPhone
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
    //Arun
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.hidesBackButton = true
    }
    
    @IBAction func btnBackDidtap(_ sender: Any) {
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
